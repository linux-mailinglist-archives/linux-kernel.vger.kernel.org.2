Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E541842DC91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhJNPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:00:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhJNO7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:59:03 -0400
Received: from zn.tnic (p200300ec2f0c72008718c38cc37e4684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:8718:c38c:c37e:4684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C1D61EC051F;
        Thu, 14 Oct 2021 16:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634223417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDDmqTSSM2bL2DR7PpN6E5Y6DxdU1LJ7c+RAog1a0nM=;
        b=VgkQ0zI3OH+VHmOqIk/Ze9OAYnrgdN+QitI7/dYE8MBuEBZIL3vOen4abDrTvudTHx48NP
        OJhWOHWqXjK+LrlSj4zPdfAkcJUJw8vGxfOeJhqFrrgpLO0CxHJ5jeUHPtNpgwjc9mURco
        vRe0yg1ve1hGfpr5FeRKqOyD8aYE+MQ=
Date:   Thu, 14 Oct 2021 16:56:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWhFOJCF1pxIBANv@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWhCAqDxAuTh1YwE@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:43:14PM +0300, Ville Syrjälä wrote:
> Hmm. Actually I just stared at the code a bit more it looks
> a bit funny. Was it supposed to do this instead?
> 
> - fpu->state.fxsave.mxcsr &= ~mxcsr_feature_mask;
> + fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;

Whoops, I had it like that in the original patch:

https://lore.kernel.org/all/163354193576.25758.8132624386883258818.tip-bot2@tip-bot2/

I blame tglx. :-)

Does it work if you remove the mask negation "~"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
