Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAA4068F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhIJJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhIJJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:18:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 02:16:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0700510d70add229dcc0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:510d:70ad:d229:dcc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEEF61EC0390;
        Fri, 10 Sep 2021 11:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631265410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ja789o5lI09KtLVM89FV5cMUUR8FmCvg4bkLQy1qXl8=;
        b=imkkjsyc7cbeo0ydp99Hl/kGC9iP6/QoOmN7hllKdWKCqgFgCit0/cMXo6QCOYP0y9INS5
        tcFVOJsitifC9vXV+XuPksAFOSaFHCgOn3DejKArpzi1nJoEkLPbx//UCFGWztRfwnfKa3
        dBHxQkNLAGQqh8RvmJ6TvvbpT5aHQ94=
Date:   Fri, 10 Sep 2021 11:16:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2 0/2] x86/asm: avoid register pressure from
 static_cpu_has()
Message-ID: <YTsif1FeOEyFJnqc@zn.tnic>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210909220818.417312-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210909220818.417312-1-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:08:16PM -0700, H. Peter Anvin (Intel) wrote:
> gcc will sometimes manifest the address of boot_cpu_data in a register
> as part of constant propagation. When multiple static_cpu_has() are
> used this may foul the mainline code with a register load which will
> only be used on the fallback path, which is unused after
> initialization.
> 
> Explicitly force gcc to use immediate (rip-relative) addressing for
> the fallback path, thus removing any possible register use from
> static_cpu_has().

Right, maybe I'm missing something but what is wrong with the immediate
addressing variant, i.e., that thing:

	testb  $0x8,0xffffffff89346eea

and you need to *force* %rip-relative?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
