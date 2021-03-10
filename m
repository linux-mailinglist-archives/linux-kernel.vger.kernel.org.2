Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE717333B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhCJL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhCJL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:27:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:27:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a99005e0b34ded2f39972.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:5e0b:34de:d2f3:9972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B3D51EC025A;
        Wed, 10 Mar 2021 12:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615375647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XA4Tt17+6Doiam7IPy+7hL/2KgvHzSwXqX1249vr2qI=;
        b=mH45mrkQrjJss3hyZPpQIWjdS/YkH8szIj0ANdE4DtUKnw1ohp1E2jmRkPAo4jNE64oUvF
        6VFutuWTPjXfYSKiTRPo8HPYSfeVhVF/r4Itn0W/hZs5QXJK+d3+s2+IjIXJyO/m4ONVHw
        E4n7nVzqA3Otf2OiMTgQQTB8pmhhOW8=
Date:   Wed, 10 Mar 2021 12:27:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] x86/vdso: avoid warning when building vdso2c on 32-bit
 host
Message-ID: <20210310112723.GD23521@zn.tnic>
References: <14b269f1-a9d2-3083-00d7-c23368f135e9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14b269f1-a9d2-3083-00d7-c23368f135e9@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:22:16AM +0100, Jan Beulich wrote:
> size_t arguments can't compatibly be passed for l-modifier format
> specifiers. Use z instead.
> 
> Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsi
>  	if (offset + len > data_len)
>  		fail("section to extract overruns input data");
>  
> -	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> +	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
>  	BITSFUNC(copy)(outfile, data + offset, len);
>  	fprintf(outfile, "\n};\n\n");

Already fixed:

https://git.kernel.org/tip/70c9d959226b7c5c48c119e2c1cfc1424f87b023

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
