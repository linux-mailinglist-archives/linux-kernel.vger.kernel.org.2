Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3938C468
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhEUKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:12:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhEUKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:11:58 -0400
Received: from zn.tnic (p200300ec2f0ea40053fd7160b74f4551.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:53fd:7160:b74f:4551])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6868C1EC06D7;
        Fri, 21 May 2021 12:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621591834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6qW0rzkEjcD4Goq+LyMDUMIQFlIjR27WlxE0n1UIRu4=;
        b=bYm9kIW+wsHVhAZnP1J8G7MYuBQKrCKoPI7foVOcgOdPrhqgBKvCSBqSTkY7SFenrNQmi/
        MFBgTh+erRKYvi06M4/8FIvprEfvagD/uLmuhNZhZLTm/pXJg0LH9yQA2bWz0A52v5zg42
        GAFstdrYT4lVPrYMzimvIbkWvpN3kYQ=
Date:   Fri, 21 May 2021 12:10:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Bartley <andareed@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org,
        Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
Message-ID: <YKeHBI757jX65ULa@zn.tnic>
References: <20210520174130.94954-1-andareed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520174130.94954-1-andareed@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:41:30AM -0700, David Bartley wrote:
> This is required to support Zen3 APUs in k10temp.
> 
> Signed-off-by: David Bartley <andareed@gmail.com>
> ---
>  arch/x86/kernel/amd_nb.c | 3 +++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 09083094eb57..23dda362dc0f 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,6 +25,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{}
>  };
>  
> @@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}
>  };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..5356ccf1c275 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d

I don't see this define used anywhere else besides amd_nb.c. If there's
no use for it outside of that file, I'm moving it there...?

Or does it need to get added to that k10temp_id_table in k10temp.c too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
