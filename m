Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF699427717
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhJIEQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhJIEQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:16:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B6C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 21:15:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 133so5011444pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Io2K8Gs5Uy4lV1ustz6eBAsYaKVHMWynGJ6LMeJkvvY=;
        b=IHlRPDPpGTYdsWbiRJXxD+IxZUcuwj+pvS7dKcfkiRsFOQl8VutpHqvWEHLw4KE/zR
         8QsUEbBbybuj0tGLq930M+QzuaBJaTeUyfo12ZqWWf1yRezDlwYCJuJ2lHZ4vkE2Bgqo
         yQx3BNgxk9YnBTOHv5gpj2L18cUCS1ZyVwqXh2vIvgODtYzP4n64yB3sGTcS9HyBmBlc
         XiHptpI2NOjjljCG+RSeCwLHt6+7HMdH81Xp7/R+Cu5FVLxDSIIkv0UDVuvwmz22y+8b
         j82d119YSaWwWOqdjreO/UzC5bP6PaIrxXXzaJanZFnoV0WW4HAxU0gPZVw6O9clGPZp
         Gggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Io2K8Gs5Uy4lV1ustz6eBAsYaKVHMWynGJ6LMeJkvvY=;
        b=djArzJVImI0XKxJwNaBbcAuRyMV4f9kQZkd0doQRp8DKNsSPChCFgSkNCVOezJ1E4l
         KXBMFufdfDmGUjUW9mo4PunCZ8H8sZY3Kolq2jd5ujdjw7hqmXkbyuJyIZaGO5SkxxNn
         6F5kUm8PqUs4WeLQVsH1BeNU72ac74dKS/GKC1rOIbipDY/4UIrI0X47j4u97Z7ITWzv
         PEp1k0qtWVq6U6yEJcDWxhsPsSpgw+lrbzqsW7C9DNLXEFsbrYecDIc2fX7wE3b8zN5w
         U93gL3HkTc3qJoR8tv2fR5/5HiMRBX03HFNM+qLWA5CTvLYBFbEDvfm557ctlfMcZxOd
         vA0w==
X-Gm-Message-State: AOAM531b79gEorNQBTGyPWCLorgYkRL+KfFZ6XmBrBo0U/+8OAUw1mR9
        H3HBX1F/+QXaOesZEn0Gew==
X-Google-Smtp-Source: ABdhPJwPoU06MU8dcjlX4qmTI9/9eo81W8ghWdb0go400KHtc5KlpLZVwJhxWSWxNfzg1gGq4ckRLw==
X-Received: by 2002:a63:b917:: with SMTP id z23mr7811076pge.284.1633752900459;
        Fri, 08 Oct 2021 21:15:00 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3sm623228pjg.7.2021.10.08.21.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 21:15:00 -0700 (PDT)
Date:   Sat, 9 Oct 2021 12:14:52 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <YWEXPIIeMgSAuSBf@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
 <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
 <20211008154523.GP880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008154523.GP880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 08:45:23AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 08, 2021 at 12:01:25PM +0800, Pingfan Liu wrote:
> > Sorry that I missed this message and I am just back from a long
> > festival.
> > 
> > Adding Paul for RCU guidance.
> 
> Didn't the recent patch series cover this, or is this a new problem?
> 
Sorry not to explain it clearly. This is a new problem.

The acked recent series derive from [3-4/5], which addresses the nested calling:
in a single normal interrupt handler
    rcu_irq_enter()
        rcu_irq_enter()
	...
        rcu_irq_exit()
    rcu_irq_exit()


While this new problem [1-2/5] is about pNMI (similar to NMI in this context).
On arm64, the current process in a pNMI handler looks like:
    rcu_irq_enter(){ rcu_nmi_enter()}
        ^^^ At this point, the handler is treated as a normal interrupt temporary, (no chance to __preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);).
	    So rcu_nmi_enter() can not distinguish NMI, because "if (!in_nmi())" can not tell it. (goto "questionA")
        nmi_enter()
	NMI handler
	nmi_exit()
    rcu_irq_exit()

[...]
> > Refer to rcu_nmi_enter(), which can be called by
> > enter_from_kernel_mode():
> > 
> > ||noinstr void rcu_nmi_enter(void)
> > ||{
> > ||        ...
> > ||        if (rcu_dynticks_curr_cpu_in_eqs()) {
> > ||
> > ||                if (!in_nmi())
> > ||                        rcu_dynticks_task_exit();
> > ||
> > ||                // RCU is not watching here ...
> > ||                rcu_dynticks_eqs_exit();
> > ||                // ... but is watching here.
> > ||
> > ||                if (!in_nmi()) {
> > ||                        instrumentation_begin();
> > ||                        rcu_cleanup_after_idle();
> > ||                        instrumentation_end();
> > ||                }
> > ||
> > ||                instrumentation_begin();
> > ||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> > ||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> > ||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > ||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > ||
> > ||                incby = 1;
> > ||        } else if (!in_nmi()) {
> > ||                instrumentation_begin();
> > ||                rcu_irq_enter_check_tick();
> > ||        } else  {
> > ||                instrumentation_begin();
> > ||        }
> > ||        ...
> > ||}
> > 
> > There is 3 pieces of code put under the
> > protection of if (!in_nmi()). At least the last one
> > "rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
> > is supposed to hold a spin lock with irqoff by
> > "raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
> > scenario in rcu_nmi_exit()->rcu_prepare_for_idle().
> > 

questionA:
> > As for the first two "if (!in_nmi())", I have no idea of why, except
> > breaching spin_lock_irq() by NMI. Hope Paul can give some guide.
> > 

Thanks,

	Pingfan
