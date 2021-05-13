Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BFF37F51A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhEMJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:54:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhEMJy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:54:27 -0400
Received: from zn.tnic (p200300ec2f0e44003cf6e755e77ac6f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4400:3cf6:e755:e77a:c6f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE0CA1EC050F;
        Thu, 13 May 2021 11:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620899596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DOLq0Lj3q5zYgGx2CLe/FoJhWpQJQp54lkJ2OG3LGlw=;
        b=Ba9TPFkuTBKnjcAZWJbjLgg4Jqc+7dcrDpCidnTEcvh8JPPpH9KWBoYcxDx7P8DvvW0uCB
        JI5N/ODTdU7vlmINofsglh0wLRafw3DiIB8QqgwG2q4UsXl7hIbf4+W6v0UzSAthQlC8vf
        +WRdJhdKGeFa3avaQNQiJcNY7toM7Yg=
Date:   Thu, 13 May 2021 11:53:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJz3CMBFFIDBzVwX@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 03:20:36AM +0000, Joshi, Mukul wrote:
> Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is defined.
> I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile the amdgpu
> driver when CONFIG_X86_MCE_AMD is not defined.
> I can avoid all that by using is_smca_umc_v2().
> I think it would be cleaner with using is_smca_umc_v2().

See how smca_get_long_name() is exported and export that function the
same way.

To save you some energy: is_smca_umc_v2() is not going to happen.

> You can think of GPU device as a EDAC device here. It is mainly
> interested in handling uncorrectable errors.

An EDAC "device", as you call it, is not interested in handling UEs. If
anything, it counts them.

> It is a deferred interrupt that generates an MCE.

Is that the same deferred interrupt which calls amd_deferred_error_interrupt() ?

> When an uncorrectable error is detected on the GPU UMC, all we are
> doing is determining the physical address where the error occurred and
> then "retiring" the page that address belongs to.

What page is that? Normal DRAM page or a page in some special GPU memory?

> By retiring, we mean we reserve the page so that it is not available
> for allocations to any applications.

We do that for normal DRAM memory pages by poisoning them. I hope you
don't mean that.

Looking at

amdgpu_ras_add_bad_pages
|-> amdgpu_vram_mgr_reserve_range

that's some VRAM thing so I'm guessing special memory on the GPU.

If so, what happens with all those "retired" pages when you reboot?
They're getting used again and potentially trigger the same UEs and the
same retiring happens?

> We are providing information to the user by storing all the
> information about the retired pages in EEPROM. This can be accessed
> through sysfs.

Ok, I'm a user and I can access that information through sysfs. What can
I do with it?

> Hope it clears what "bad page retirement" is achieving.

It is getting there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
