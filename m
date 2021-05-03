Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00C4371350
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhECKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhECKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:04:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mLUoHUuU4w0ObYVm7U+TfjHFuEYtZIhN4dWr35/0b9g=; b=H5UxfVHIXv1eRkUSEtMvsIBZkj
        p2JIOoZ76y9unNZYRgJbgAGipjJW6rIgq6NSE+oxq7PJM8dTiPV9YJrM+YK1INrIv8aN4PYmoUm/k
        6DtCPTtkiXXXRsiFlCSihB9QRp7eR11YrvRdAY1oHPAAZJz+8wiCuUl6+bCEgXTPq3HbS6TS2RwP/
        0/8+Vvx4kSq0WMHyjcbWtqypKxprBpLeDM4SktRD5v84kfEg5gVy3lSZXRQtejciNpgd7unZ7qkGU
        GCmrjuBAqgLK0fv2sSdvpv3QFJ3rRrat/eZOXyVAE5OeUVqBIo2IxDWgRh+MhPEJvmCypXrJSyPiX
        FSDNEP1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldVPd-00Dc7r-Vy; Mon, 03 May 2021 10:02:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DEBD3001D0;
        Mon,  3 May 2021 12:02:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ED052BC22568; Mon,  3 May 2021 12:02:49 +0200 (CEST)
Date:   Mon, 3 May 2021 12:02:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YI/KSfWuGLhPnilr@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> @@ -8507,6 +8616,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (!sgs->sum_h_nr_running)
>  		return false;
>  
> +	/*
> +	 * @sg may have been tentatively classified as group_asym_packing.
> +	 * Now that we have sufficient information about @sds.local, reassess
> +	 * if asym packing migration can be done. Reclassify @sg. The only
> +	 * possible results are group_has_spare and group_fully_busy.
> +	 */
> +	if (sgs->group_type == group_asym_packing &&
> +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg)) {
> +		sgs->group_asym_packing = 0;
> +		sgs->group_type = group_classify(env->sd->imbalance_pct, sg, sgs);
> +	}

So if this really is all about not having sds.local in
update_sd_lb_stats(), then that seems fixable. Let me haz a try.
