Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931573FA0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhH0U4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhH0U4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:56:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB95C0613D9;
        Fri, 27 Aug 2021 13:55:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so9503460otk.9;
        Fri, 27 Aug 2021 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WRro33hgw6vxZ5x29P1j2z42fNtPupJ4CRCG/CSUfh0=;
        b=AQll2wnY3RUQhJSQ0WGnQB7QYaPcKKk5lLienqqSaPC+LoLnmymAIlC9UJ92wnDXlC
         l2lQZVTErurqeaBlSALSf0CJgYnUDS/tR+IsH2QZj2ZMJ2Y2UE/gv1ulHED8WHXehpxf
         Dn8iimnCIjVs7FxF/dtan4YySoneCw/KbdseicuRq4WnLNbxkEWzOZTm7qfgkPcsciIF
         2S+G2dsLMEVWI9XE3+q/cXGC4tU7fPYld4+qHfwpqHAy65tu5cLuRp7eze1Z3IixDGWs
         UoT3xEk7faBH3Rwf0nLTfoqeN8whi/5FNQ6BNXe+2pWBakYV8dD6nvWOdnB+YmunUVRw
         jRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WRro33hgw6vxZ5x29P1j2z42fNtPupJ4CRCG/CSUfh0=;
        b=K/9uFRxP8bwKaMLJQohHT15qcIv8Tw8OSDUsY0od+5G18aTmsbDTxeFQvNpw0THhAt
         mDolgr6wJcxrq47QCegOQNU38x3FoTWsSwurWJ+jSNoWdzk77AN1bWSG2kPqrrxyxfbC
         mEqtr1d7JLrbhXBHTc73KGO3pM0uuaV6J88stv94hN1ySpMlmRfavocCfJ8/T7p1LlZu
         jFCmsm1uGNBz8HUxZCtIN7V7I97gyMoUw1NvP42anGn6YJDmKApauoXnFt5y9x4mLPWs
         jI7pGXwvy/Cy9tHUh7q2qQYOEIo0RsnJp+DW7xwf3ZuPO2+/vUirAJXm31MHT+9Od1ID
         lUuQ==
X-Gm-Message-State: AOAM533KwlnSLvbbCPU93HSDM2g/lNIgljhSPuYLm22og/m04yxIKjY9
        41K3Hpn93B0qVH4ZPz1sna9vQEuupgo=
X-Google-Smtp-Source: ABdhPJz7XOZnY0c1A+NBnmS9QZ1QIzHTUHv70hXoC39GE4nkeP3dCCibMnOD36ASCFNxl+h1zE7Lbg==
X-Received: by 2002:a05:6830:1dac:: with SMTP id z12mr9652067oti.52.1630097716977;
        Fri, 27 Aug 2021 13:55:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o68sm1473437ota.33.2021.08.27.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 13:55:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 13:55:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Wei Huang <wei.huang2@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] hwmon: (k10temp): Rework the temperature offset
 calculation
Message-ID: <20210827205513.GA678683@roeck-us.net>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827201527.24454-2-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 03:15:25PM -0500, Mario Limonciello wrote:
> Some of the existing assumptions made do not scale properly
> to new silicon in upcoming changes.  This commit should cause
> no functional changes to existing silicon.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index f6b325b8463e..159dbad73d82 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -65,10 +65,11 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
>  #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
>  
> -/* Common for Zen CPU families (Family 17h and 18h) */
> -#define ZEN_REPORTED_TEMP_CTRL_OFFSET		0x00059800
> +/* Common for Zen CPU families (Family 17h and 18h and 19h) */
> +#define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
>  
> -#define ZEN_CCD_TEMP(x)				(0x00059954 + ((x) * 4))
> +#define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
> +						 (offset) + ((x) * 4))
>  #define ZEN_CCD_TEMP_VALID			BIT(11)
>  #define ZEN_CCD_TEMP_MASK			GENMASK(10, 0)
>  
> @@ -103,6 +104,7 @@ struct k10temp_data {
>  	u32 temp_adjust_mask;
>  	u32 show_temp;
>  	bool is_zen;
> +	u32 ccd_offset;
>  };
>  
>  #define TCTL_BIT	0
> @@ -163,7 +165,7 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>  {
>  	amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -		     ZEN_REPORTED_TEMP_CTRL_OFFSET, regval);
> +		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>  }
>  
>  static long get_raw_temp(struct k10temp_data *data)
> @@ -226,7 +228,8 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  			break;
>  		case 2 ... 9:		/* Tccd{1-8} */
>  			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -				     ZEN_CCD_TEMP(channel - 2), &regval);
> +				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> +						  &regval);
>  			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>  			break;
>  		default:
> @@ -387,7 +390,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>  
>  	for (i = 0; i < limit; i++) {
>  		amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -			     ZEN_CCD_TEMP(i), &regval);
> +			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
>  		if (regval & ZEN_CCD_TEMP_VALID)
>  			data->show_temp |= BIT(TCCD_BIT(i));
>  	}
> @@ -433,12 +436,14 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		case 0x8:	/* Zen+ */
>  		case 0x11:	/* Zen APU */
>  		case 0x18:	/* Zen+ APU */
> +			data->ccd_offset = 0x154;
>  			k10temp_get_ccd_support(pdev, data, 4);
>  			break;
>  		case 0x31:	/* Zen2 Threadripper */
>  		case 0x60:	/* Renoir */
>  		case 0x68:	/* Lucienne */
>  		case 0x71:	/* Zen2 */
> +			data->ccd_offset = 0x154;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
>  		}
> @@ -451,6 +456,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
>  		case 0x21:		/* Zen3 Ryzen Desktop */
>  		case 0x50 ... 0x5f:	/* Green Sardine */
> +			data->ccd_offset = 0x154;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
>  		}
