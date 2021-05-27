Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD73935A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhE0S4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:56:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234553AbhE0S4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:56:09 -0400
Received: from zn.tnic (p200300ec2f0f02007e50b358e2406320.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:200:7e50:b358:e240:6320])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACCEB1EC01DF;
        Thu, 27 May 2021 20:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622141673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4j3+U8NPO6x1s8W4eN+2wRaXIw4uGauEk5tMjMWLvsk=;
        b=ewl9m6D1RKaKiXB4XHjPv4fARy8PgjJio5CVMEDE90vrdldmBYqD2wvs7qFX/Gl78El9TG
        73NX/W26pGfvW7iCInzqI0Na1yn8+lThQ5EACD/N+I5doXdGaWQwMQR8ZLBCZXCfNCTkXp
        9QKUD8mPdhuDO4ZeChytBQGqopT1BNo=
Date:   Thu, 27 May 2021 20:54:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>,
        linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
Message-ID: <YK/q4RyKhoqFM2nJ@zn.tnic>
References: <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
 <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
 <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
 <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
 <YK905sC/2cVOYo6I@zn.tnic>
 <87h7io8kh5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7io8kh5.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 01:49:42PM +0200, Thomas Gleixner wrote:
> Also if disabling this entry is causing the BIOS/SMM gunk to go south, then
> disabling CONFIG_X86_THERMAL_VECTOR should have the same effect.

Well, I believe the latter was practically impossible:

config X86_THERMAL_VECTOR
	def_bool y
	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC

so *if* the machine was sporting thermal SMI, then it very much needed
that code in intel_init_thermal() to unstuck the cores. At least it
looks that way...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
