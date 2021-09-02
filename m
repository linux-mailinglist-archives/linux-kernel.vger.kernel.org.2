Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8823FF0BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbhIBQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345985AbhIBQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630598834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4ZmFicaV3zK2SsRdu/pWTVb4qhXLmV9US8d6xYPe2E=;
        b=GaGebBRPabE9Ht61P6J4D02l3mNXSWU9Pjk7HV3Xr1RgYaqty9QHe4411mJknJp9r+DSeb
        BM6MeqMua5c2GTxIkrSh0d3JteKNoTq7VVfBY9OVG0TvqKJBRTjBrfJiNZ5s4ykazfe3QA
        E6/rTZV/q8hVDs8fAuD6UDvCZTX5Ukg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-WRcCPH7nPnOnTr3czMZpTg-1; Thu, 02 Sep 2021 12:07:13 -0400
X-MC-Unique: WRcCPH7nPnOnTr3czMZpTg-1
Received: by mail-ej1-f72.google.com with SMTP id ak17-20020a170906889100b005c5d1e5e707so1147000ejc.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M4ZmFicaV3zK2SsRdu/pWTVb4qhXLmV9US8d6xYPe2E=;
        b=DPkWlpyrTiVDoSnG80VeIm71kbU1Op+Kj6+ycLi6DeDiDyQRjxDFP2rI5f6F9YS5yO
         UqNPARtpgKzNEpwE3vsZvKZOqI7XpL7n4DdwPbc28Sb21CXTz/eoGj9pKNHRhGmViU1+
         /APktNRRp8voQs2SQXsDF3HGPSJMrwrDGc2ANx89Oam2xB9Atimyu0gSD5g6umeBtHaf
         XLi4Gyo37Iwny+iyaLeUtiRDDD+UCfuALaH5UNwT/UboLfCMbGfOfrPF7IHZPK7Q/IgI
         wFPDP7/8RQEKJ9npcJDw6yxLVwfSJKFpS4gh284QSFL7VTO/tmONj+qQinLOq/ERxXdL
         7z5g==
X-Gm-Message-State: AOAM531UnzWXBg8V3Q6Xvk5bt35snPywvP2Qest9SNd4ZpOu57PFHPoO
        pD7S1SnXtL3c1kJmQCmbwPYeVr84Psq4cdHHzPHB1z7oFE10nqzVQLn9buGcJBpx0zjkwMXwLy5
        /++CciyXUxn4275pRyW1bYQypRix3uDRGQzO4wRarqxKcySnv8IsiSxEoAUWKiV4dZmDHQLJj90
        2g
X-Received: by 2002:a17:906:730a:: with SMTP id di10mr4515061ejc.428.1630598831753;
        Thu, 02 Sep 2021 09:07:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLIfbT0523mnAaErEdDqfIMgx244vfN9nkxNudNOLXD2ajmqD28+0qWpPjeGE7u1WOrFrhJg==
X-Received: by 2002:a17:906:730a:: with SMTP id di10mr4515021ejc.428.1630598831238;
        Thu, 02 Sep 2021 09:07:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d6sm1471244edx.0.2021.09.02.09.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:07:10 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
Date:   Thu, 2 Sep 2021 18:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901151643.13562-1-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 9/1/21 5:16 PM, Kate Hsuan wrote:
> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD SATA controllers and only
> completely disabling NCQ helps to avoid these issues.
> 
> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
> SATA adapter vendor will cause I/O performance degradation with well
> behaved adapters. To limit the performance impact to AMD adapters,
> introduce the ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ
> only for these adapters.
> 
> Also, two libata.force parameters (noncqamd and ncqamd) are introduced
> to disable and enable the NCQ for the system which equiped with AMD
> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
> function to be enabled or disabled according to the demand.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Thanks, v5 looks good to me, but in the mean time I've also gotten the
first replies to my request to collect PCI-ids on systems having this
issue and it looks like checking for PCI_VENDOR_ID_AMD might not be
the right thing to do.

Tor Vic who has a very recent motherboard which does not show this
issue reports the following pci-ids:

06:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7901] (rev 51)
07:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7901] (rev 51)

Where as we now have a bunch of lspci -nn outputs from different motherboard
with the issue from: https://bugzilla.kernel.org/show_bug.cgi?id=201693 :

00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)

00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)

00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)

00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391]

00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391]

Notice these are basically all the same; and it seems these are
all from the AMD/ATI period where the motherboars chipset where still
using PCI_VENDOR_ID_ATI as vendor-id.

So it looks like we actually need to disable NCQ for Samsung 860/870
devices when the SATA controller has a vendor-id of PCI_VENDOR_ID_ATI
rather then AMD.

So lets wait a bit for some more info to become available and then
I think we need a v6 with s/AMD/ATI/ (everywhere, also in the name
of the horkage-flag, the cmdline options, etc.).

Regards,

Hans

> ---
> Changes in v5:
> * The libata.force parameters ncqamd and noncqamd are used to enable and
>   disable the NCQ for the systems equiped with AMD SATA adapter and
>   Samsung 860 and 870 SSDs.
> * The character encoding of the patch comment was fixed.
> 
> Changes in v4:
> * A function ata_dev_check_adapter() is added to check the vendor ID of
>   the adapter.
> * ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to
>   align with the naming convention.
> * Commit messages were improved according to reviewer comments.
> 
> Changes in v3:
> * ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to
>   ATA_HORKAGE_NONCQ_ON_AMD.
> * Codes were fixed to completely disable NCQ on AMD controller.
> 
> ---
>  drivers/ata/libata-core.c | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/libata.h    |  1 +
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3eda3291952b..e2e900085f99 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2199,6 +2199,25 @@ static void ata_dev_config_ncq_prio(struct ata_device *dev)
> 
>  }
> 
> +static bool ata_dev_check_adapter(struct ata_device *dev,
> +				  unsigned short vendor_id)
> +{
> +	struct pci_dev *pcidev = NULL;
> +	struct device *parent_dev = NULL;
> +
> +	for (parent_dev = dev->tdev.parent; parent_dev != NULL;
> +	     parent_dev = parent_dev->parent) {
> +		if (dev_is_pci(parent_dev)) {
> +			pcidev = to_pci_dev(parent_dev);
> +			if (pcidev->vendor == vendor_id)
> +				return true;
> +			break;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int ata_dev_config_ncq(struct ata_device *dev,
>  			       char *desc, size_t desc_sz)
>  {
> @@ -2217,6 +2236,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  		snprintf(desc, desc_sz, "NCQ (not used)");
>  		return 0;
>  	}
> +
> +	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_AMD &&
> +	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)) {
> +		snprintf(desc, desc_sz, "NCQ (not used)");
> +		return 0;
> +	}
> +
>  	if (ap->flags & ATA_FLAG_NCQ) {
>  		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
>  		dev->flags |= ATA_DFLAG_NCQ;
> @@ -3951,9 +3977,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },
>  	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
> @@ -6108,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
>  		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
>  		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
>  		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
> +		{ "noncqamd",	.horkage_on	= ATA_HORKAGE_NO_NCQ_ON_AMD },
> +		{ "ncqamd",	.horkage_off	= ATA_HORKAGE_NO_NCQ_ON_AMD },
>  		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
>  		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
>  		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 3fcd24236793..ef1417152ecd 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -422,6 +422,7 @@ enum {
>  	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
>  	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
>  	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
> +	ATA_HORKAGE_NO_NCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */
> 
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */
> --
> 2.31.1
> 

