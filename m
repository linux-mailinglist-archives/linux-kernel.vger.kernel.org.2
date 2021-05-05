Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1E373C98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhEENmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233263AbhEENmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620222072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SvDOc2cSQFyiOQl5xUCSS7yLKATWDvDoAhPfKv8w2E=;
        b=GuHnQP+95DDGhMak677ThKjgNCS28MnsKYKEoeOAeNO+bRKqbmZbfYgA6q51jF2XMAG3Ck
        pL0xrQh37NIP4/dgV1GT1MiayfL1Wn7+kmHWFVkpKrHBfhAv/Xw8VjX8P8lczNkDWWUVqz
        BqmPs05lKwLKaux0ThSJZ2eUztf6Iv8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-_ycEfEG2Oh-UQntNHdF0pA-1; Wed, 05 May 2021 09:41:11 -0400
X-MC-Unique: _ycEfEG2Oh-UQntNHdF0pA-1
Received: by mail-ed1-f70.google.com with SMTP id g19-20020a0564021813b029038811907178so859560edy.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SvDOc2cSQFyiOQl5xUCSS7yLKATWDvDoAhPfKv8w2E=;
        b=A7q1TNGQWurm6R1ePtstaoM+VFRLLMCtI7DHCkGy+PseaAkb30ATfbdEmaLGvoZkAn
         PTEtk0KltHa9OJj8N0pMElaxzIIUi4Qf7evEk7FYSzN69rr8IaGhKqmguGE06a0s4j5v
         vFrVkcC23BTaLLwaKdXvY5qo+U4My8Fd/6ztbcXEbD3k5YMnWm4VZx/7P+ow2vOc4EgJ
         Y7Xvv/HFNFRghHB+chDarIAVFSoiGdh8B0VJC6evZtSndYSYzJPpeCGRXifrwiZMkudD
         fqsamADzXi8PGahHGbJ6J22DiSSwUFzrxPqglHMTLxvm+DePj8q8pxaD3id2eGqPeMWR
         VteA==
X-Gm-Message-State: AOAM532PuZV18swz0Iy/vWiDSDTMVFcCRrXgC/SM4o0pPGJYNPcdF3DU
        ceH20aOe/M3szYKHRrRDlzmcxCI9CAtsbZ1eSgIGCaL2zhFlOzmPsg31TAhXMRD9drM4N/rt6f8
        rZCVgbCKwMyzV6JVJoHX5DqV+3JlWPxGVW6kBIeVmQlqS5n15fwZM7wdKAcpygo6YvUMaWS3U7t
        i2
X-Received: by 2002:a05:6402:5158:: with SMTP id n24mr32094319edd.74.1620222069669;
        Wed, 05 May 2021 06:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWo2ZfxiXHGn8NhGbl7X0qDlgKK/ISF6oNF/JmFAq74DaEN7Tv7cyExL8OYk1dGyZorzrHyA==
X-Received: by 2002:a05:6402:5158:: with SMTP id n24mr32094299edd.74.1620222069521;
        Wed, 05 May 2021 06:41:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t14sm2872225ejc.121.2021.05.05.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:41:09 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: Do not mark interrupt as
 shared
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505133635.1499703-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <733587d7-8373-e157-4c9e-4b53d387cb82@redhat.com>
Date:   Wed, 5 May 2021 15:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505133635.1499703-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/5/21 3:36 PM, Maximilian Luz wrote:
> Having both IRQF_NO_AUTOEN and IRQF_SHARED set causes
> request_threaded_irq() to return with -EINVAL (see comment in flag
> validation in that function). As the interrupt is currently not shared
> between multiple devices, drop the IRQF_SHARED flag.
> 
> Fixes: 507cf5a2f1e2 ("platform/surface: aggregator: move to use request_irq by IRQF_NO_AUTOEN flag")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you I'll pick this up (and at it to the pdx86/fixes branch too)
once 5.13-rc1 is out.

Regards,

Hans


> ---
>  drivers/platform/surface/aggregator/controller.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 69e86cd599d3..8a70df60142c 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -2483,8 +2483,7 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
>  	 * interrupt, and let the SAM resume callback during the controller
>  	 * resume process clear it.
>  	 */
> -	const int irqf = IRQF_SHARED | IRQF_ONESHOT |
> -			 IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
> +	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
>  
>  	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
>  	if (IS_ERR(gpiod))
> 

