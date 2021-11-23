Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9945AE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhKWVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWVnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:43:33 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA7DC061574;
        Tue, 23 Nov 2021 13:40:24 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r26so945741oiw.5;
        Tue, 23 Nov 2021 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=biwLPQARcTwGOiP1bWND5yac2R/WEsvRTGTIxaW0R5o=;
        b=E03DDfM2ovJPVhEYYvbE8os0VIK33P41RiuCqN6IPssFl77BrW0GrpKHPpQeKDJybq
         8A59+dce/e6uNb+ezFmNKoDVOeuDB3B3lloDolMYedF6R38M3uiDUV5TUGPxblnK/yVi
         KP4MXG5hZHdykDG0WVujsT//iDUAj2aCDAMODLIShJYje56O/8nILMgjqsSyziFrKpj8
         MotZYaVwg7mMbbE2j5JxCllVounW0Udf0TKWeIkGa9ITSKOSaaDzJNDfXdyonOKwensG
         Vb7O39Rm+zZbJoQ4Kqd0xQK+yO0ZwhwfK0/6IDYpnpcv83yNzF6Csh3ucro1WNzxXlvJ
         05uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=biwLPQARcTwGOiP1bWND5yac2R/WEsvRTGTIxaW0R5o=;
        b=gk2qHdy897jiKj8bnvOG/WiBHSS6MDKI7zNLDKOjJHYnQnbQc+iWN9ar/jiKrBGrXW
         Kos7oEQBRvF4Zc3ploHKgqIhflMAaYtKRSfkim+9Ifx4pRS/GQ/y/TZZBT92Jko1SkBg
         fhPLApUKp8/DRXgv3PesUAobdQPICMpLo1QRBYzj9Oc1fiFRhqCIKo7/vGmkM2/mEoGg
         /Yff/ngVjAt9NGCWqa8agEa+3hFbGgsE12YBuJxCS+PV7InPPBcplnOH8VaoKhaA1YMO
         X0LD8bUtWbu3Aj3DE5TTYBDV4GLbvEYy4EX6AkYHHBhvAL/U38oIg5ESVlb5kNymzBbJ
         92DA==
X-Gm-Message-State: AOAM533S2+l8LJiaJ3BWi9dtvqbQC1NSMorauvBCeuA2K0+cOhpCpndi
        9xPzCYm04qeCL53dym6N4YzwJLRJ8kc=
X-Google-Smtp-Source: ABdhPJwjDe6Em99xskCCIg7du/dckVMb4T2T9s5LwySFjpOnvrPT4kf2WhiJYPMZws9GZpypYPDuXQ==
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr444141oil.65.1637703623842;
        Tue, 23 Nov 2021 13:40:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s13sm2489629otv.34.2021.11.23.13.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 13:40:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hwmon: (k10temp) Move the CCD limit info inside
 k10temp_data structure
To:     Babu Moger <babu.moger@amd.com>, clemens@ladisch.de,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <937b305c-c61d-e754-c86f-7019b57dd737@roeck-us.net>
Date:   Tue, 23 Nov 2021 13:40:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 1:16 PM, Babu Moger wrote:
> It seems appropriate to move the CCD specific information inside the
> k10temp_data structure.
> 

Why ? I don't see it used outside k10temp_get_ccd_support().

Guenter

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> Note: Generated the patch on top of hwmon-next.
> 
>   drivers/hwmon/k10temp.c |   17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 880990fa4795..bd436b380a02 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -85,6 +85,7 @@ struct k10temp_data {
>   	u32 show_temp;
>   	bool is_zen;
>   	u32 ccd_offset;
> +	u32 ccd_limit;
>   };
>   
>   #define TCTL_BIT	0
> @@ -357,12 +358,12 @@ static const struct hwmon_chip_info k10temp_chip_info = {
>   };
>   
>   static void k10temp_get_ccd_support(struct pci_dev *pdev,
> -				    struct k10temp_data *data, int limit)
> +				    struct k10temp_data *data)
>   {
>   	u32 regval;
>   	int i;
>   
> -	for (i = 0; i < limit; i++) {
> +	for (i = 0; i < data->ccd_limit; i++) {
>   		amd_smn_read(amd_pci_dev_to_node_id(pdev),
>   			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
>   		if (regval & ZEN_CCD_TEMP_VALID)
> @@ -411,14 +412,16 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		case 0x11:	/* Zen APU */
>   		case 0x18:	/* Zen+ APU */
>   			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 4);
> +			data->ccd_limit = 4;
> +			k10temp_get_ccd_support(pdev, data);
>   			break;
>   		case 0x31:	/* Zen2 Threadripper */
>   		case 0x60:	/* Renoir */
>   		case 0x68:	/* Lucienne */
>   		case 0x71:	/* Zen2 */
>   			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			data->ccd_limit = 8;
> +			k10temp_get_ccd_support(pdev, data);
>   			break;
>   		}
>   	} else if (boot_cpu_data.x86 == 0x19) {
> @@ -431,13 +434,15 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		case 0x21:		/* Zen3 Ryzen Desktop */
>   		case 0x50 ... 0x5f:	/* Green Sardine */
>   			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			data->ccd_limit = 8;
> +			k10temp_get_ccd_support(pdev, data);
>   			break;
>   		case 0x10 ... 0x1f:
>   		case 0x40 ... 0x4f:	/* Yellow Carp */
>   		case 0xa0 ... 0xaf:
>   			data->ccd_offset = 0x300;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			data->ccd_limit = 8;
> +			k10temp_get_ccd_support(pdev, data);
>   			break;
>   		}
>   	} else {
> 
> 

