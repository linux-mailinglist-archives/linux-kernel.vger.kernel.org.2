Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEB30EE1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhBDINL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Feb 2021 03:13:11 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:57443 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhBDINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:13:08 -0500
Received: from xps13 (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 848E0100011;
        Thu,  4 Feb 2021 08:12:16 +0000 (UTC)
Date:   Thu, 4 Feb 2021 09:12:15 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: convert sysfs sprintf/snprintf family to
 sysfs_emit
Message-ID: <20210204091215.38ca0f99@xps13>
In-Reply-To: <1612410921-80984-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612410921-80984-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote on Thu,  4 Feb
2021 11:55:21 +0800:

> Fix the following coccicheck warning:
> 
> ./drivers/mtd/mtdcore.c: WARNING: use scnprintf or sprintf.

That's not what you do in the below change :)

> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/mtd/mtdcore.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 2d6423d..c37056e 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -131,7 +131,7 @@ static ssize_t mtd_type_show(struct device *dev,
>  		type = "unknown";
>  	}
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", type);
> +	return sysfs_emit(buf, "%s\n", type);
>  }
>  static DEVICE_ATTR(type, S_IRUGO, mtd_type_show, NULL);
>  
> @@ -140,7 +140,7 @@ static ssize_t mtd_flags_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)mtd->flags);
> +	return sysfs_emit(buf, "0x%lx\n", (unsigned long)mtd->flags);
>  }
>  static DEVICE_ATTR(flags, S_IRUGO, mtd_flags_show, NULL);
>  
> @@ -149,8 +149,7 @@ static ssize_t mtd_size_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%llu\n",
> -		(unsigned long long)mtd->size);
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)mtd->size);
>  }
>  static DEVICE_ATTR(size, S_IRUGO, mtd_size_show, NULL);
>  
> @@ -159,7 +158,7 @@ static ssize_t mtd_erasesize_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->erasesize);
> +	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->erasesize);
>  }
>  static DEVICE_ATTR(erasesize, S_IRUGO, mtd_erasesize_show, NULL);
>  
> @@ -168,7 +167,7 @@ static ssize_t mtd_writesize_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->writesize);
> +	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->writesize);
>  }
>  static DEVICE_ATTR(writesize, S_IRUGO, mtd_writesize_show, NULL);
>  
> @@ -178,7 +177,7 @@ static ssize_t mtd_subpagesize_show(struct device *dev,
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	unsigned int subpagesize = mtd->writesize >> mtd->subpage_sft;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", subpagesize);
> +	return sysfs_emit(buf, "%u\n", subpagesize);
>  }
>  static DEVICE_ATTR(subpagesize, S_IRUGO, mtd_subpagesize_show, NULL);
>  
> @@ -187,7 +186,7 @@ static ssize_t mtd_oobsize_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->oobsize);
> +	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->oobsize);
>  }
>  static DEVICE_ATTR(oobsize, S_IRUGO, mtd_oobsize_show, NULL);
>  
> @@ -196,7 +195,7 @@ static ssize_t mtd_oobavail_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->oobavail);
> +	return sysfs_emit(buf, "%u\n", mtd->oobavail);
>  }
>  static DEVICE_ATTR(oobavail, S_IRUGO, mtd_oobavail_show, NULL);
>  
> @@ -205,7 +204,7 @@ static ssize_t mtd_numeraseregions_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->numeraseregions);
> +	return sysfs_emit(buf, "%u\n", mtd->numeraseregions);
>  }
>  static DEVICE_ATTR(numeraseregions, S_IRUGO, mtd_numeraseregions_show,
>  	NULL);
> @@ -215,7 +214,7 @@ static ssize_t mtd_name_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", mtd->name);
> +	return sysfs_emit(buf, "%s\n", mtd->name);
>  }
>  static DEVICE_ATTR(name, S_IRUGO, mtd_name_show, NULL);
>  
> @@ -224,7 +223,7 @@ static ssize_t mtd_ecc_strength_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->ecc_strength);
> +	return sysfs_emit(buf, "%u\n", mtd->ecc_strength);
>  }
>  static DEVICE_ATTR(ecc_strength, S_IRUGO, mtd_ecc_strength_show, NULL);
>  
> @@ -234,7 +233,7 @@ static ssize_t mtd_bitflip_threshold_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->bitflip_threshold);
> +	return sysfs_emit(buf, "%u\n", mtd->bitflip_threshold);
>  }
>  
>  static ssize_t mtd_bitflip_threshold_store(struct device *dev,
> @@ -261,7 +260,7 @@ static ssize_t mtd_ecc_step_size_show(struct device *dev,
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->ecc_step_size);
> +	return sysfs_emit(buf, "%u\n", mtd->ecc_step_size);
>  
>  }
>  static DEVICE_ATTR(ecc_step_size, S_IRUGO, mtd_ecc_step_size_show, NULL);
> @@ -272,7 +271,7 @@ static ssize_t mtd_ecc_stats_corrected_show(struct device *dev,
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->corrected);
> +	return sysfs_emit(buf, "%u\n", ecc_stats->corrected);
>  }
>  static DEVICE_ATTR(corrected_bits, S_IRUGO,
>  		   mtd_ecc_stats_corrected_show, NULL);
> @@ -283,7 +282,7 @@ static ssize_t mtd_ecc_stats_errors_show(struct device *dev,
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->failed);
> +	return sysfs_emit(buf, "%u\n", ecc_stats->failed);
>  }
>  static DEVICE_ATTR(ecc_failures, S_IRUGO, mtd_ecc_stats_errors_show, NULL);
>  
> @@ -293,7 +292,7 @@ static ssize_t mtd_badblocks_show(struct device *dev,
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->badblocks);
> +	return sysfs_emit(buf, "%u\n", ecc_stats->badblocks);
>  }
>  static DEVICE_ATTR(bad_blocks, S_IRUGO, mtd_badblocks_show, NULL);
>  
> @@ -303,7 +302,7 @@ static ssize_t mtd_bbtblocks_show(struct device *dev,
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->bbtblocks);
> +	return sysfs_emit(buf, "%u\n", ecc_stats->bbtblocks);
>  }
>  static DEVICE_ATTR(bbt_blocks, S_IRUGO, mtd_bbtblocks_show, NULL);
>  

Thanks,
Miquèl
