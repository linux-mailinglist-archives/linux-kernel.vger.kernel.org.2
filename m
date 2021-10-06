Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B108423F63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJFNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:36:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhJFNgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:36:49 -0400
Received: from zn.tnic (p200300ec2f0d3600bd612f435519a27c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:bd61:2f43:5519:a27c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36CBA1EC04BF;
        Wed,  6 Oct 2021 15:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633527296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=azbJy9XarL2vqTlJbOYf3rqnWVLZMYcDF2N2Nz/wT1A=;
        b=jvv22IMUrbuzK7hdlQtUCdvrC4ha3TfGEN64HfVrnA8YSMpyp0uK/XonWPBhURQBOkgU4x
        vtxsc+cISc6g569ZfdwcjNooPuSIFn3g4QOQ8r+MfnTJrVFv85+7ZY6yTFFkUsaGffIhLI
        0TVClnjIyBZYiV28exS4KRny38ciXWY=
Date:   Wed, 6 Oct 2021 15:34:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ser Olmy <ser.olmy@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <YV2l+1oIGd2p/Gt5@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com>
 <YVtA67jImg3KlBTw@zn.tnic>
 <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com>
 <YVwjY9TX6XMxkM2f@zn.tnic>
 <YqPgABmVMzvEllmeYzm8tkSaqtC-Q8nzeNjgNBXVPnQtPCHAeFg7IdwpzBECDcFGjrCBkFVegcYvqh_KoGnyOsbK4oC91VHw5G-qUlwlCvM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqPgABmVMzvEllmeYzm8tkSaqtC-Q8nzeNjgNBXVPnQtPCHAeFg7IdwpzBECDcFGjrCBkFVegcYvqh_KoGnyOsbK4oC91VHw5G-qUlwlCvM=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 12:42:47AM +0000, Ser Olmy wrote:
> Sure:

Thx.

> [   21.670972] fpu->state.fxsave.mxcsr: 0xb7be13b4, mxcsr_feature_mask: 0xffbf
> [   21.754383] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/signal.c:384 __fpu_restore_sig+0x51f/0x540

As tglx expected.

I guess this fixes your issue (replace with previous diff pls):

---
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 445c57c9c539..684be34d4609 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -379,9 +379,8 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 				     sizeof(fpu->state.fxsave)))
 			return -EFAULT;
 
-		/* Reject invalid MXCSR values. */
-		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
-			return -EINVAL;
+		/* Mask out reserved MXCSR bits. */
+		fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
