Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CD33C458
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCORfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhCORfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30TBr3sK+ajEBQTkdVxs2gUMnCABPyOfPizE9SkmbsI=;
        b=fe/osrTNzv/sXjJ53J4Dkn9HoHQgo6cGAXNkhWxegsdh5YY4YGdfXUaH5Iu4tkhJlglkS4
        qDKTdXXvzB0QR9mQuXU8CLHRtOwN/2/9mtKnN8JUtmSqMxvzhBUlCjpzj3DUu8J5WykQVj
        ypRl2gZm+F0cvTtnC+8vKUPsWINdHp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-ym9K23_yPl6LoD-vytMdWg-1; Mon, 15 Mar 2021 13:34:59 -0400
X-MC-Unique: ym9K23_yPl6LoD-vytMdWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44221801597;
        Mon, 15 Mar 2021 17:34:57 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 283DF5C5E0;
        Mon, 15 Mar 2021 17:34:54 +0000 (UTC)
Date:   Mon, 15 Mar 2021 18:34:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 09/27] perf parse-events: Create two hybrid hardware
 events
Message-ID: <YE+avkajxbGJMOoM@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-10-yao.jin@linux.intel.com>
 <YEu9zbr75p+OLY2o@krava>
 <65b8208c-ac5d-bdea-a11a-64d4a3d29562@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b8208c-ac5d-bdea-a11a-64d4a3d29562@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:04:56AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 3/13/2021 3:15 AM, Jiri Olsa wrote:
> > On Thu, Mar 11, 2021 at 03:07:24PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > >    cycles: 4: 800933425 1002536659 1002536659
> > >    cycles: 5: 800928573 1002528386 1002528386
> > >    cycles: 6: 800924347 1002520527 1002520527
> > >    cycles: 7: 800922009 1002513176 1002513176
> > >    cycles: 8: 800919624 1002507326 1002507326
> > >    cycles: 9: 800917204 1002500663 1002500663
> > >    cycles: 10: 802096579 1002494280 1002494280
> > >    cycles: 11: 802093770 1002486404 1002486404
> > >    cycles: 12: 803284338 1002479491 1002479491
> > >    cycles: 13: 803277609 1002469777 1002469777
> > >    cycles: 14: 800875902 1002458861 1002458861
> > >    cycles: 15: 800873241 1002451350 1002451350
> > >    cycles: 0: 800837379 1002444645 1002444645
> > >    cycles: 1: 800833400 1002438505 1002438505
> > >    cycles: 2: 800829291 1002433698 1002433698
> > >    cycles: 3: 800824390 1002427584 1002427584
> > >    cycles: 4: 800819360 1002422099 1002422099
> > >    cycles: 5: 800814787 1002415845 1002415845
> > >    cycles: 6: 800810125 1002410301 1002410301
> > >    cycles: 7: 800791893 1002386845 1002386845
> > >    cycles: 12855737722 16040169029 16040169029
> > >    cycles: 6406560625 8019379522 8019379522
> > > 
> > >     Performance counter stats for 'system wide':
> > > 
> > >        12,855,737,722      cpu_core/cycles/
> > >         6,406,560,625      cpu_atom/cycles/
> > 
> > so we do that no_merge stuff for uncore pmus, why can't we do
> > that in here? that'd seems like generic way
> > 
> > jirka
> > 
> 
> We have set the "stat_config.no_merge = true;" in "[PATCH v2 08/27] perf
> stat: Uniquify hybrid event name".
> 
> For hybrid hardware events, they have different configs. The config is
> 0xDD000000AA (0x400000000 for core vs. 0xa00000000 for atom in this example)
> 
> We use perf_pmu__for_each_hybrid_pmu() to iterate all hybrid PMUs, generate
> the configs and create the evsels for each hybrid PMU. This logic and the
> code are not complex and easy to understand.
> 
> Uncore looks complicated. It has uncore alias concept which is for different
> PMUs but with same prefix. Such as "uncore_cbox" for "uncore_cbox_0" to
> "uncore_cbox_9". But the uncore alias concept doesn't apply to hybrid pmu
> (we just have "cpu_core" and "cpu_atom" here). And actually I also don't
> want to mix the core stuff with uncore stuff, that would be hard for
> understanding.
> 
> Perhaps I misunderstand, correct me if I'm wrong.

not sure, I thought the merging stuff was more generic,
because the change looks too specific for me, I'll try
to check on it more deeply

jirka

