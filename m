Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF825356C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352138AbhDGM17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhDGM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:27:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD2C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MfqgLWv10IJUoyDmm979n6kaRcDpYx7OQawOsvcvaLo=; b=ehAPGtUP0FPy1+N88OuFRTRS5r
        QonnsHieZ034bS3NTIN0lbiP9asu7//rg22nLKCOjhmxwUM3/PzcVscIHrVdZ0XA1cZoYoyMFkVKG
        yC2TasVn2Nw+b+tRFsuqqetzxo6FQnDO6t6bn4EOSedng4iJCySyO15xAVKeWpsLBIq5tsCak1gwz
        2KwePxMPyVq7GcwBGCBGcPpwzGVjVrguHhGz/7D1GaoXnPyRw/qYXrT6+zY/Kd8oFAVzazRfC6De4
        9s1QF7GDELhwo5RLCaY6r8TreoVEMvW3aOV9EBpnClzizoLiOFs0XiWUyqXdz8fS7N5ASQUc654ac
        LR2vXT8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU7Gg-00ESES-My; Wed, 07 Apr 2021 12:26:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A07D300056;
        Wed,  7 Apr 2021 14:26:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 409A6244029A1; Wed,  7 Apr 2021 14:26:46 +0200 (CEST)
Date:   Wed, 7 Apr 2021 14:26:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 4/9] sched: Move SCHED_DEBUG to debugfs
Message-ID: <YG2lBimj3cKMErA7@hirez.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.025550243@infradead.org>
 <87blaqnzho.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blaqnzho.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:46:43AM +0100, Valentin Schneider wrote:
> On 26/03/21 11:33, Peter Zijlstra wrote:
> >  __read_mostly bool sched_debug_enabled;
> >  
> > +struct dentry *debugfs_sched;
> > +
> >  static __init int sched_init_debug(void)
> >  {
> > -	debugfs_create_file("sched_features", 0644, NULL, NULL,
> > -			&sched_feat_fops);
> > +	struct dentry __maybe_unused *numa;
> > +
> > +	debugfs_sched = debugfs_create_dir("sched", NULL);
> > +
> > +	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
> > +	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
> > +
> 
> Could we kill this too? I'm probably biased because I've spent some amount
> of time banging my head at topology problems, but this two-tiered debugging
> setup (KCONFIG + cmdline or post-boot write) has always irked me.
> 
> I can't find the threads in a hurry, but ISTR justifications for keeping
> this around were:
> - Most distros have CONFIG_SCHED_DEBUG=y because knobs and ponies
> - Topology debug prints are "too verbose"

^^ that mostly.

> - NUMA distance matrix processing gets slower
> 
> If we make it so distros stop / don't need to select CONFIG_SCHED_DEBUG,

We're not there yet, I think :-(

> then I don't think the above really stands anymore (also, sched_init_numa()
> now has the same complexity regardless of sched_debug), and we could keep
> everything under CONFIG_SCHED_DEBUG.

But yes, the reason this knob exists is ebcause I too frequently forget
to add the boot time knob, so I added this one to enable it at runtime
and then I get topology prints when I hotplug cycle a cpu.
