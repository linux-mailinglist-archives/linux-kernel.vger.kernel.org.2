Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34EB42EF45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhJOLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:06:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhJOLGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:06:36 -0400
Received: from zn.tnic (p200300ec2f0cfb0087c6997658fca07e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fb00:87c6:9976:58fc:a07e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F48F1EC0593;
        Fri, 15 Oct 2021 13:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634295869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrJLWbbRUBeuLFY0ZXFJKj4jdgvFkQtSue6zAwY5Snw=;
        b=RaStao5GeW3kwT/Xxp0Y189C1BvagALuCuIkuRrrCfAXXVhKC38p7l9w4ANF44do1QCgBn
        0iO6uYq0Z1qDUYCSSrlho4XqanV6iBFoTD36/ye+3hX7U17NZa4BW5jcbLJ6snFWj32ylf
        S3bmJEGNctQ0Pqyvaf2JucLZW0FhzRI=
Date:   Fri, 15 Oct 2021 13:04:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Ser Olmy <ser.olmy@protonmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWlgPJwxmFL5nX4c@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
 <YWhwdDI5ECoMZQzU@zn.tnic>
 <YWh7GgCgdtwRj3GU@intel.com>
 <YWiAPQCRm4RnOiCd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWiAPQCRm4RnOiCd@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here it is.

Ser, I'd appreciate you running it too, to make sure your box is still
ok.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 15 Oct 2021 12:46:25 +0200
Subject: [PATCH] x86/fpu: Mask out the invalid MXCSR bits properly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a fix for the fix (yeah, /facepalm).

The correct mask to use is not the negation of the MXCSR_MASK but the
actual mask which contains the supported bits in the MXCSR register.

Reported and debugged by Ville Syrjälä <ville.syrjala@linux.intel.com>

Fixes: d298b03506d3 ("x86/fpu: Restore the masking out of reserved MXCSR bits")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/YWgYIYXLriayyezv@intel.com
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index fa17a27390ab..831b25c5e705 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -385,7 +385,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 				return -EINVAL;
 		} else {
 			/* Mask invalid bits out for historical reasons (broken hardware). */
-			fpu->state.fxsave.mxcsr &= ~mxcsr_feature_mask;
+			fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
 		}
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
