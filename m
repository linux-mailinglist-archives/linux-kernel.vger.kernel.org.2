Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04132EBF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhCENSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:18:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhCENSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:18:11 -0500
Received: from zn.tnic (p200300ec2f0b9500a5847b5a228c2b11.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:a584:7b5a:228c:2b11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C48C41EC032C;
        Fri,  5 Mar 2021 14:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614950289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a6f8ruqcL1B2dSMKwksbdBsdxs5yzu8wbv0uJQXnMNo=;
        b=EkI+7VZbOy9eJwcY5GNvIWNWAu+Phj9QJUxT0cC6OmGjfK11MhgOezKR4+BEspBcvIlwyU
        W4LU3DwkOrE19LOwQpwR2eYQnUbVPzj9Bc0tVcG524otAxveN5JaPFbzAXkgZ3lzvoyuMz
        rf1E5aoZ1tKb8j4qdnvV+WlkE6J16fg=
Date:   Fri, 5 Mar 2021 14:18:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/platform/uv: Add set of kernel block size for
 hubless arches
Message-ID: <20210305131804.GA2685@zn.tnic>
References: <20210304223955.183463-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304223955.183463-1-mike.travis@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 04:39:55PM -0600, Mike Travis wrote:
> The commit below added a call to set the block size value that is needed
> to set the value used by the kernel.  This was done for UV Hubbed systems.
> This commit adds that same set call to hubless systems which supports the
> same NVRAMS and Intel BIOS thus the same problem occurs.
> 
> Fixes: bbbd2b51a2aa ...

The format is:

Fixes: bbbd2b51a2aa ("x86/platform/UV: Use new set memory block size function")

and you don't need to paste the commit text.

And if you add a Fixes tag, then this is supposed to fix something but
I'm unclear what exactly this fixes?

IOW, should this patch be backported to stable because UV hubless
systems would somehow fail without it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
