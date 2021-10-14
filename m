Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00B342DB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJNO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhJNO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:29:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:27:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c72008718c38cc37e4684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:8718:c38c:c37e:4684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4931E1EC04B9;
        Thu, 14 Oct 2021 16:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634221629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4UDSRZNLbujPIMgHpMxdcCEUXw1BBdhLqNoRmR+wHFg=;
        b=iLtR1bF1mRNcV6+xUyanug+PaG/VCmB6cg7pXYslKB4NcVnLGe8/5pdmacz63+hrZcc3vc
        iD6dldpHkzBhetlsMYE169aKDJciVwbTtlSzpljTpfq3tmQMAurJ+aiwisyvcu1fbKz6Ol
        mG6/SX2zFHDllWBhsIENM0DIypeNHYQ=
Date:   Thu, 14 Oct 2021 16:27:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWg+O1AXrWLO3Sf9@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWgYIYXLriayyezv@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 02:44:33PM +0300, Ville Syrjälä wrote:
> I have a 32bit installation here that stopped working. Bisected it
> to commit d298b03506d3 ("x86/fpu: Restore the masking out of reserved
> MXCSR bits").

Lemme make sure I understand this correctly: this patch is bad and with
it reverted it works?

Because before this patch, the restoring would be a more restrictive
than before and this patch reverts the code to the old behavior for
invalid MXCSR bits.

> Tested the same disk on on both a 64bit capable Pentium D
> and a 32bit only Pentium 4 just to rule out the specific CPU.
> Busted on both.

So that's a purely 32-bit installation and a 32-bit kernel and you've
booted it on two different machines?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
