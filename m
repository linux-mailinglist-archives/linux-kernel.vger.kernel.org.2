Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1C30608C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhA0QFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343876AbhA0QAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611763163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNnyum5AJJisJKioi1qMcBfp7gdHj9WZI4hpsB+FDzU=;
        b=Z9BcPzAAAsFcAN/CRCCSr8WkwQntrCByiXfkSdLxUXIZIEyBYzE/m2LJkyGL8QRqMoa82W
        5lMekUEIWkpoittjop2ZeNHL86MpNrImkAzsf/QOJEkPl9rJN9mIABGVIsLxq9VJbKoHCV
        N1Xr7/QsIz3eqzCWv2laB51AYbYBHEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-T_zxS9qmOh6JNH3Vn5dR2A-1; Wed, 27 Jan 2021 10:59:19 -0500
X-MC-Unique: T_zxS9qmOh6JNH3Vn5dR2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BBC31005504;
        Wed, 27 Jan 2021 15:59:17 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBBCC5C1D5;
        Wed, 27 Jan 2021 15:59:15 +0000 (UTC)
Date:   Wed, 27 Jan 2021 09:59:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210127155914.jfmr4jay47yck5h5@treble>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:27:09PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 10:13:47AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 26, 2021 at 05:57:30PM -0600, Josh Poimboeuf wrote:
> 
> > > Well, I hate it, but I'm not sure I have any better ideas.  It should be
> > > possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
> > > sure about the performance impact though.  Might be a good reason to
> > > speed up kallsyms!
> > 
> > Oh right, let me see if I can make that work.
> 
> Something like so compiles.. but it does make the whole thing depend on
> KALLSYMS_ALL, which is somewhat yuck.
> 
> Also, kallsyms_lookup_name() is horrible, but not trivial to fix because
> of that compression scheme used.

The KALLSYMS_ALL dependency doesn't bother me personally but I assume
some of the tinyconfig folks might not appreciate it being on
permanently.

Can DEFINE_STATIC_CALL() make the tramp-key association?

e.g. have DEFINE_STATIC_CALL() add an entry to .static_call_tramp_key
which has an array of 

struct static_call_tramp_key {
	unsigned int tramp;  // PC-relative pointer to tramp
	unsigned int key;    // PC-relative pointer to key
}

and then just scan that instead of kallsyms.

-- 
Josh

