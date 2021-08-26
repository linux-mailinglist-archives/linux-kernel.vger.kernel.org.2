Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A53F88A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhHZNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241738AbhHZNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629983954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UG4xgc4VRqvEE/QaJxednaYILCuxIK3bpHXcaYfdk0=;
        b=NjAjjZg1TOEkToYfzTWAUCY8ylpN+AsWpZz1bp5HEqjZi/icIeJAHwUTsVccUxcP2VWm/3
        O0WzGKLoc859whZp1Cbe9ivFENYZZLR6fFjpTcYQAbWJRD1aPwoDEpDVrgBQHcnEA9zayn
        8RNmEB+33YzMqE4PV8zs7XwSVEOx7x8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-0_a1-idbNJuFhwT6fPm51Q-1; Thu, 26 Aug 2021 09:19:13 -0400
X-MC-Unique: 0_a1-idbNJuFhwT6fPm51Q-1
Received: by mail-ej1-f71.google.com with SMTP id gv53-20020a1709072bf500b005c0428ef7e7so1154878ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UG4xgc4VRqvEE/QaJxednaYILCuxIK3bpHXcaYfdk0=;
        b=XsVv3GNY2G34ZKOJc9oRdMR13xAP2B2n5RPLIux657ZUjz46tjzYsi3esGXR//wQNH
         Xu+on1b+ThK1Ekv5tvXgv2oPdlzQ6MUPXqxCiYZ5BrtzZPv0e7Q9o+O7SELMm2z1f7eA
         wNOlO25bP6niNP9qo57H3pNRWYSmA/vfJ/lEhv9igntAqacHR/qYn3wYorsDhcCk0Emw
         a/VI+HVlJyQKsZWLlauXBF1fJKLvN5fnELcQKHCz+ONsk2OcOQqfnDQaXFBc2jkmRQVN
         01dWOnaOV2ncvKZqhUdPdFmHqZSHN/c12+7GTLuViIgjmPMf0A9dwAIRCUivby3ZGjmR
         FYZg==
X-Gm-Message-State: AOAM531KIx5rR3R/r+1KP6P6x1nOaZjs95VFG2TxUNdKOKWF6FYfaBTg
        OAmzY4ahFkvAG1ilt38yMrI1Sll2Znp3cq+QvykyO56+q1Getp8cNpCB+b+IwC2PYeMktjRnahL
        mieGXlcu1vV7MT7cdOsf+jFH8
X-Received: by 2002:a50:ed06:: with SMTP id j6mr491031eds.148.1629983951694;
        Thu, 26 Aug 2021 06:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9zKmAOT2Peu+QzI1JXfRm3T4n32XC8pLXHddwR54u8HnB9UzeBjOgn48EwNpjVUSQDIaLIg==
X-Received: by 2002:a50:ed06:: with SMTP id j6mr491021eds.148.1629983951595;
        Thu, 26 Aug 2021 06:19:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b18sm1432274ejl.90.2021.08.26.06.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 06:19:11 -0700 (PDT)
Subject: Re: [PATCH] mfd: intel_pmt: Only compile on x86
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        "David E . Box" <david.e.box@linux.intel.com>
References: <20210825125735.621799-1-prarit@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b075d481-f1a3-22d5-24b7-0b170d2908a1@redhat.com>
Date:   Thu, 26 Aug 2021 15:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825125735.621799-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/21 2:57 PM, Prarit Bhargava wrote:
> The intel_pmt driver shows up as a compile option for all arches but is
> 32-bit and 64-bit x86 specific.
> 
> Add a CONFIG dependency on X86 for intel_pmt.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..0f12b00955b4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -676,7 +676,7 @@ config MFD_INTEL_PMC_BXT
>  
>  config MFD_INTEL_PMT
>  	tristate "Intel Platform Monitoring Technology (PMT) support"
> -	depends on PCI
> +	depends on X86 && PCI
>  	select MFD_CORE
>  	help
>  	  The Intel Platform Monitoring Technology (PMT) is an interface that
> 

