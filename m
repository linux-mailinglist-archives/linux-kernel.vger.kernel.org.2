Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8436982F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhDWRVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhDWRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619198456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQRF3ySH2gOm83I7SlkKz3DtYomS95h5OnWbpauJ/WQ=;
        b=C2sl4Z13Ex6JneEuqg/tgzxPWOEKSUGAD+kYgjsxw6H+6gqYCB85d4NjMY+UuiRzimlSPB
        FxiSzvmKi/PbarljH5pDH0IHKIZcECPOKTjECjJJ4hck6DZgmzTF9GFBrkbQAcLQCYynKo
        fX0TkgnMqCwRLKAqdtHiXzFq2+tculE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-uT5ib1TxOeyeKTOpzEDrpA-1; Fri, 23 Apr 2021 13:20:54 -0400
X-MC-Unique: uT5ib1TxOeyeKTOpzEDrpA-1
Received: by mail-ed1-f69.google.com with SMTP id w14-20020aa7da4e0000b02903834aeed684so17188454eds.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQRF3ySH2gOm83I7SlkKz3DtYomS95h5OnWbpauJ/WQ=;
        b=BtXtIjMurNsiNGaz+smG9n9Ile3TntsmkCecfRGTO7O0vcDV+jWwf6LrOnRuaqHvw4
         jWtRDHjfVVpQD3ShN5b2Uk/iInCwU4HerGZYk0/vLzGiCrl2CsNyo0gtjTDNAXC3AZxu
         te/fsLu9e71QQ3J/kPxbX81OsWkDsiFZxmsAecXpdPGP4esmiRMBMePKka81c0ny06Lw
         hRFCXi3W92dbOyswsk8Fk6G5wJ4mFUzQjAE5Wue4+fG2X3mykO9Reu5egwauuIKs+KgR
         cyNahLguEJMjhIaVP96l3naECgttRmDF1Apj99MRmyoO2RHTHQnIlFIPGX0VCtuF/WFt
         /Gfw==
X-Gm-Message-State: AOAM530IF9oCewvpExS3K/OzKb2w+Jd+i6TyNY7mPaRUoX1T2fntIboB
        uhcbBfmUDq1HXNUSApdRPcxD1be7wdj8WmhiQcjbnDTuIFM2mqtfpDSduUaE/qdbiVUe+CdGIgs
        gP3RkYcP8zAa22n2+zGzeQpRIfmBGoebUJRcYjgF41jBSabRGWgOW2tGTp9qXqqYhW+PhTMUhi8
        Oh
X-Received: by 2002:a17:907:7745:: with SMTP id kx5mr5368088ejc.3.1619198452739;
        Fri, 23 Apr 2021 10:20:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybpinwvHNzNNOmAwimRbZx2AQltb6voiv1k3bsDDQvAWvCEKCNL5MWokb8C8E4LFMARSxxEA==
X-Received: by 2002:a17:907:7745:: with SMTP id kx5mr5368057ejc.3.1619198452489;
        Fri, 23 Apr 2021 10:20:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r19sm4308152ejr.55.2021.04.23.10.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 10:20:51 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B550M AORUS
 PRO-P
To:     Alexey Klimov <aklimov@redhat.com>, thomas@weissschuh.net
Cc:     mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210421234156.3942343-1-aklimov@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86f6570b-cd92-3256-9fdd-4ef4e4038762@redhat.com>
Date:   Fri, 23 Apr 2021 19:20:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421234156.3942343-1-aklimov@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/21 1:41 AM, Alexey Klimov wrote:
> From: Alexey Klimov <klimov.linux@gmail.com>
> 
> From: Alexey Klimov <klimov.linux@gmail.com>
> 
> Add the B550M AORUS PRO-P motherboard description to
> gigabyte_wmi_known_working_platforms.
> 
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
> 
> The driver works fine on this motherboard with force_load=1 and
> it seems that temperature values are correct.
> 
> gigabyte_wmi-virtual-0
> Adapter: Virtual device
> temp1:        +30.0°C  
> temp2:        +35.0°C  
> temp3:        +30.0°C  
> temp4:        +32.0°C  
> temp5:        +28.0°C  
> temp6:        +42.0°C
> 
> The patch is created against review-hans branch on platform-drivers-x86.git
> I am available for further testing on this board if required, feel free
> to reach me. Thanks.
> 
>  drivers/platform/x86/gigabyte-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index e127a2077bbc..13d57434e60f 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -138,6 +138,10 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>  		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550 GAMING X V2"),
>  	}},
> +	{ .matches = {
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M AORUS PRO-P"),
> +	}},
>  	{ .matches = {
>  		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>  		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M DS3H"),
> 

