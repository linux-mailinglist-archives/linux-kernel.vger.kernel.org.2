Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB703619C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhDPGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:17:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:16144 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDPGRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:17:25 -0400
IronPort-SDR: KxwwCWy8/b8TTguCePXrHbEQy0rx7TAMJMGTp92zFgtVL5CRUXxJytQQ7ZXidEsEq24v4keoXL
 3pC93FaOAgPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192868141"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="192868141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 23:17:01 -0700
IronPort-SDR: o37HCrApaoFX3gowhbomxa8qfRZIvxJOIiZV3WK/vJgcJv97PXqHwm4SEeveUqXHQhG3HRIKTH
 BRqonP6MrmUA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461868390"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 23:16:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [RFC PATCH] percpu_ref: Make percpu_ref_tryget*() ACQUIRE
 operations
References: <20210416050054.ws2nl6ds7kd6i4so@zaphod.evilpiepirate.org>
Date:   Fri, 16 Apr 2021 14:16:56 +0800
In-Reply-To: <20210416050054.ws2nl6ds7kd6i4so@zaphod.evilpiepirate.org> (Kent
        Overstreet's message of "Fri, 16 Apr 2021 01:02:04 -0400")
Message-ID: <87fszqoisn.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Overstreet <kent.overstreet@gmail.com> writes:

> On Thu, Apr 15, 2021 at 09:42:56PM -0700, Paul E. McKenney wrote:
>> On Tue, Apr 13, 2021 at 10:47:03AM +0800, Huang Ying wrote:
>> > One typical use case of percpu_ref_tryget() family functions is as
>> > follows,
>> > 
>> >   if (percpu_ref_tryget(&p->ref)) {
>> > 	  /* Operate on the other fields of *p */
>> >   }
>> > 
>> > The refcount needs to be checked before operating on the other fields
>> > of the data structure (*p), otherwise, the values gotten from the
>> > other fields may be invalid or inconsistent.  To guarantee the correct
>> > memory ordering, percpu_ref_tryget*() needs to be the ACQUIRE
>> > operations.
>> 
>> I am not seeing the need for this.
>> 
>> If __ref_is_percpu() returns true, then the overall count must be non-zero
>> and there will be an RCU grace period between now and the time that this
>> count becomes zero.  For the calls to __ref_is_percpu() enclosed within
>> rcu_read_lock() and rcu_read_unlock(), the grace period will provide
>> the needed ordering.  (See the comment header for the synchronize_rcu()
>> function.)
>> 
>> Otherwise, when __ref_is_percpu() returns false, its caller does a
>> value-returning atomic read-modify-write operation, which provides
>> full ordering.

Hi, Paul,

Yes, for the cases you described (from non-zero to 0), current code
works well, no changes are needed.

>> Either way, the required acquire semantics (and more) are already
>> provided, and in particular, this analysis covers the percpu_ref_tryget()
>> you call out above.
>> 
>> Or am I missing something subtle here?
>
> I think you're right, but some details about the race we're concerned about
> would be helpful. Are we concerned about seeing values from after the ref has
> hit 0? In that case I agree with Paul. Or is the concern about seeing values
> from before a transition from 0 to nonzero?

Hi, Kent,

Yes, that's exactly what I concern about.  In swap code, we may get a
pointer to a data structure (swap_info_struct) when its refcount is 0
(not fully initialized), and we cannot access the other fields of the
data structure until its refcount becomes non-zero (fully initialized).
So the order must be guaranteed between checking refcount and accessing
the other fields of the data structure.

I have discussed with Dennis Zhou about this in another thread too,

https://lore.kernel.org/lkml/87o8egp1bk.fsf@yhuang6-desk1.ccr.corp.intel.com/
https://lore.kernel.org/lkml/YHhOLuIAR3QJ1jx4@google.com/

He think the use case of swap code isn't typical.  So he prefers to deal
with that in swap code, such as adding a smp_rmb() after
percpu_ref_tryget_live(), etc.

So, if the transition from 0 to non-zero isn't concerned in most other
use cases, I am fine to deal with that in the swap code.

> That wasn't a concern when I wrote
> the code for the patterns of use I had in mind, but Tejun's done some stuff with
> the code since.
>
> Huang, can you elaborate?

Best Regards,
Huang, Ying
