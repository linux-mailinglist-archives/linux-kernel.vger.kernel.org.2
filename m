Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277C33941B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhE1LVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhE1LVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:21:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC3C06174A;
        Fri, 28 May 2021 04:19:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8e00bfe48e092671442e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:bfe4:8e09:2671:442e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36EE81EC04CC;
        Fri, 28 May 2021 13:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622200762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kati2SViokZXtvVLVSFy2uE9v9luDCM95k9VGN5xKS0=;
        b=CExQC1vvU3TOA9kzHGEou6dyt9Kigi1Mw2Z1/L7mbVRvMBgWTCIKMWM8TvPwDlaTQzPfNx
        jyaM9joCkIM1xNK9tO9lZ1buUZRk/nCwm8YKzvrZ0rwcMCuFZLWsxOKJFQ/B2AbF+ENJSP
        8oIo1OC4jJj9qPbhKcHjks3cEhRevUI=
Date:   Fri, 28 May 2021 13:19:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>,
        linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
Message-ID: <YLDRuLC1vCu30lF0@zn.tnic>
References: <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
 <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
 <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
 <YK905sC/2cVOYo6I@zn.tnic>
 <87h7io8kh5.ffs@nanos.tec.linutronix.de>
 <YK/q4RyKhoqFM2nJ@zn.tnic>
 <87mtsf6zch.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtsf6zch.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:23:42AM +0200, Thomas Gleixner wrote:
> So you could disable CPU_SUP_INTEL ... Should still boot with reduced
> functionality.

*If* you disable it and *if* that intel_init_thermal() is really there
to unstick those cores, then you might not even boot successfully.

> What a mess...

When is it not when SMM is involved?

That stinking goo underneath the OS needs to be open sourced so that we
can replace it with something small and sane. BIOS morons will never
learn not to fiddle with architectural components.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
