Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5763FD61C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbhIAJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239862AbhIAJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630486906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZVOsRN4Ic8PAaVhwnIlJwbUMW+HGolIlNkBoE85AwY=;
        b=U2xpw2q3YNq1IHlMYW8QvrB41zs07BcuYJsx+aHkzCFqFou8DvPAjFIzN4XSkm0L3n6Q9x
        j1Iw5e/9jAhaiGIYURNe4v9ZmbcYDI5btU43a8o+JCrSluS4B9N/sWMI9jTnni781kzpPe
        qdpMENwzjqz6iw3rFHEoe4SfzVBYVsQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-clTiR_ILM7i0xRC0O17pGA-1; Wed, 01 Sep 2021 05:01:45 -0400
X-MC-Unique: clTiR_ILM7i0xRC0O17pGA-1
Received: by mail-ed1-f72.google.com with SMTP id i17-20020aa7c711000000b003c57b06a2caso937363edq.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 02:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZVOsRN4Ic8PAaVhwnIlJwbUMW+HGolIlNkBoE85AwY=;
        b=cYAmteLpTqWC6uKTrXaphoOzPJEw+mtxSfOXFu/TNF0Hyk7QY+5KCRvJxooLLQ7+FT
         VAmy3Ur7Ji1bixy0++Y4P0guxHfTG2o97O0HhR46NPsbjDcPpuyPuSTMxJPxvnKwQkOc
         d+E/OcEWXSMmQBeYVxTsJHzLmv3coJ6pF6TD2kCAVviGIOaiA6Va6DEYpSrR7YLkUSb/
         Ch80RFVa7VpXeyYK8ErmGH5qDo6Pd+VCdAigSSjY48yycWsk8mzVS6Mo3w7iSQJiYK1W
         rvDlj2rRltkHjg27Gb08G1iCUv475ANnbgytSxbvYigPq62cQczMRbvla5sYphYSdc4M
         rZMw==
X-Gm-Message-State: AOAM531FRZBQPl2kfU+OlappLOwNDeylWl5z7mMXkuPELCtAy2h1CWV8
        YKhLc7X1Dyei8VtKQOLg2jaKi5zbM3yuNN5Gn2FyG/2/6CDJrP55mFmQuN0TMyJe/rAk4eS2cVy
        y5GdGqgDxWijfL/bC7p7DUJOo
X-Received: by 2002:aa7:cb8a:: with SMTP id r10mr34364996edt.237.1630486904388;
        Wed, 01 Sep 2021 02:01:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypO/CZO9MtgWdVySOO2F9GWsTnYKRummQPhQU6MB+ouyqplEr3Rn4oEeLtdABfGqF5TmOcsQ==
X-Received: by 2002:aa7:cb8a:: with SMTP id r10mr34364968edt.237.1630486904135;
        Wed, 01 Sep 2021 02:01:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d3sm9472726ejw.18.2021.09.01.02.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:01:43 -0700 (PDT)
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvic9@mailbox.org
References: <20210901045220.27746-1-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f923a8d9-4da5-7e66-55fd-7c07cfc9fccf@redhat.com>
Date:   Wed, 1 Sep 2021 11:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901045220.27746-1-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

On 9/1/21 6:52 AM, Kate Hsuan wrote:
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
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
> Changes in v4:
> * A function ata_dev_check_adapter() is added to check the vendor ID of
>   the adapter.
> * ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to
>   align with the namingÂ convention.
> * Commit messages were improved accordingÂ to reviewer comments.
> 
> Changes in v3:
> * ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to
>   ATA_HORKAGE_NONCQ_ON_AMD.
> * Codes were fixed to completely disable NCQ on AMD controller.
> 
> ---
>  drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/libata.h    |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c861c93d1e84..49049cd713e4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2186,6 +2186,25 @@ static void ata_dev_config_ncq_prio(struct ata_device *dev)
>  	dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
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
> @@ -2204,6 +2223,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
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
> @@ -3971,9 +3997,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |

Something went wrong when you applied my pre-cursor patch to your tree
as base for this patch, you have spaces in front of and behind the
"NULL,", where there should be tabs. So this does not apply cleanly
on top of my patch.

I'll forward my patch to you as an attached .eml file. You should
"git am <file>.eml" that file on top of the latest linux-block/for-next
and then rebase your patch on top of that.

> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },
>  	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |

Idem for this line.

> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 860e63f5667b..cdc248a15763 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -426,6 +426,7 @@ enum {
>  	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
>  	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
>  	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
> +	ATA_HORKAGE_NO_NCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */
> 
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */

As discussed elsewhere in this thread, you should allow setting/clearing
this flag from the libata.force kernel commandline option by adding the
following extra bit to the patch:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index daa375c7e763..e2e900085f99 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6136,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
 		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "noncqamd",	.horkage_on	= ATA_HORKAGE_NO_NCQ_ON_AMD },
+		{ "ncqamd",	.horkage_off	= ATA_HORKAGE_NO_NCQ_ON_AMD },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },

Regards,

Hans

