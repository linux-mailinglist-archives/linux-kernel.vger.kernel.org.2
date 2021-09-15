Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81F440C045
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhIOHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:14:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60112 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhIOHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:14:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 01C3E1FE47;
        Wed, 15 Sep 2021 07:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631689961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bfTUsetN6ewLSVGJM0Xk5gc+BqIXK4MyH/8xgJBOew=;
        b=ZEGszKZuN3ou+cwEoPDB031g/MU6ELAQUN4+AhyNziA2a/APO/5qqvXAIOaoSymxsRlHPH
        KM7eXOrVLhPMsO9BlrCFO2NUZFTc5C8+lC1Wp4LhPYAJ0N8sBKVGVLDg9eru+layXKGNZi
        x3A39tn97qZVHwdZm+5Os4mbW8HB7Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631689961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bfTUsetN6ewLSVGJM0Xk5gc+BqIXK4MyH/8xgJBOew=;
        b=8BjqgYs/JMtJ9YquxfjlUdUysrKNAu9sG1+ciPjuPpJkUunW5jE6SGwjceay6Zx7QrUx6V
        4XlkYIVioRTn6SBg==
Received: from ggherdovich.udp.ovpn1.nue.suse.de (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 752F9A3B95;
        Wed, 15 Sep 2021 07:12:40 +0000 (UTC)
Message-ID: <7af6051cfc0a40a2461cfaa645cff3dd885d8671.camel@suse.cz>
Subject: Re: [PATCH] x86/smp: Unused value freq_scale
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Tim Gardner <tim.gardner@canonical.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Date:   Wed, 15 Sep 2021 09:12:34 +0200
In-Reply-To: <20210910184405.24422-1-tim.gardner@canonical.com>
References: <20210910184405.24422-1-tim.gardner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-10 at 12:44 -0600, Tim Gardner wrote:
> Coverity warns of an unused value in arch_scale_freq_tick().
> 
> CID 100778 (#1 of 1): Unused value (UNUSED_VALUE)
> assigned_value: Assigning value 1024ULL to freq_scale here, but that stored
> value is overwritten before it can be used.
> 
> e2b0d619b400a ("x86, sched: check for counters overflow in frequency invariant
> accounting") introduced this warning.
> 
> Fix this by removing the variable initializer.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Nathan Fontenot <nathan.fontenot@amd.com>
> Cc: Balbir Singh <sblbir@amazon.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 85f6e242b6b4..c453b825a57f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -2166,7 +2166,7 @@ DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>  
>  void arch_scale_freq_tick(void)
>  {
> -	u64 freq_scale = SCHED_CAPACITY_SCALE;
> +	u64 freq_scale;
>  	u64 aperf, mperf;
>  	u64 acnt, mcnt;
>  

Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>


Thanks,
Giovanni

