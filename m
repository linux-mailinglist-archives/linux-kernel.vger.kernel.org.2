Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308E41ADCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhI1Lci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240172AbhI1Lcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632828656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBc3jZoXfduxvlm/XcU+502MGDbE2GfRXb76r3oPrug=;
        b=exREwNfpXTz9YOo/L1NGja20kSz0hLghh4ML5GO33keHKqhyIrUcWjctwrFve+y8/fRfkw
        jRrHc6ZRvV8veFvyjjW6ZW60CHFRNdpWURDM2aqwQTMgtEwe/299UCilCVDx9nOHF9IArn
        YbSmYKRiY30ZocehOHQGBjLhZdLXDXY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-_qihybd5NLyilndxaLFztA-1; Tue, 28 Sep 2021 07:30:55 -0400
X-MC-Unique: _qihybd5NLyilndxaLFztA-1
Received: by mail-ed1-f72.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so21382001edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBc3jZoXfduxvlm/XcU+502MGDbE2GfRXb76r3oPrug=;
        b=U4nZN1Qj20YLzfz9jr9Gvy0FJbApz8JNKsppJVBAmFMShi7Kag4iVgRO+J33Zk3cX2
         12fPNglrYeHpbMTAOUr3r5pIc7VwliewJG6hcH5AFrsSoJMMQVu7J1gv82Rj+qZ9hOXt
         d8glKWvU0LbmO2xgs3jl4p53TQbXsM8AtedwTFDJr5zqpvEWeE6a8hukGSuzuQR0+d1A
         PsZ9cCFWjQ+3mLaQVqG1St5oORvVmVTjsdh4dV+zYvjhfkFHdhVRJ1uNka/XzRRc0FJp
         hf7k8uu/ioSubeQgWZDlrdphFLMNjpK597rCH/eCtKfIp0qUNTLluMEpLFtmdp9OVefr
         rg2g==
X-Gm-Message-State: AOAM531ivmX9ZCG4qjYwrCs1Y2G9E0auWWUXjNWNVhlGV1/w2SoVCX/8
        VxpgvjCpBt+KT5jvI3/WU58Ug0UQaO7xGn6f0CLoovCWcFqMf5iD6zL3nf2vdThafg3HocUNehp
        5H0BLf8qeTsHwBa7OTHvDrpHlnWPOZq6fu2Vwigqa5pVi4GSIcfBEYIrii200fEP7z+6iAmgeAw
        52
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr6238812ejb.224.1632828653789;
        Tue, 28 Sep 2021 04:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNOC17RfuJND/OOBpP6nW6t3kC9KX7YUneMG9keKlqNZiumgAzcacly7S4OhFZt4/jhVlD9Q==
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr6238793ejb.224.1632828653569;
        Tue, 28 Sep 2021 04:30:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ds10sm2649112ejc.99.2021.09.28.04.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:30:53 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: amd-pmc: Send command to dump data after
 clearing OS_HINT
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210921115910.19401-1-Sanket.Goswami@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7eecdc89-4a59-4a2a-9663-795629657d60@redhat.com>
Date:   Tue, 28 Sep 2021 13:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921115910.19401-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/21 1:59 PM, Sanket Goswami wrote:
> It was reported that the resume stats received from the firmware are
> always zero. This happens because the SMU expects the driver to send the
> command to dump the log data after clearing the OS_HINT.
> 
> Adjust the order of the commands sent to SMU.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Question, should I also submit this as a bug-fix for 5.15, or
can this wait for the 5.16 cycle ?

Regards,

Hans


> ---
>  drivers/platform/x86/amd-pmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 91c1f1c6c929..bc7c4498067b 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -436,14 +436,14 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
>  	int rc;
>  	u8 msg;
>  
> -	/* Let SMU know that we are looking for stats */
> -	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
> -
>  	msg = amd_pmc_get_os_hint(pdev);
>  	rc = amd_pmc_send_cmd(pdev, 0, NULL, msg, 0);
>  	if (rc)
>  		dev_err(pdev->dev, "resume failed\n");
>  
> +	/* Let SMU know that we are looking for stats */
> +	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
> +
>  	/* Dump the IdleMask to see the blockers */
>  	amd_pmc_idlemask_read(pdev, dev, NULL);
>  
> 

