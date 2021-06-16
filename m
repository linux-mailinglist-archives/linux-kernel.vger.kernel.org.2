Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50A03A9DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhFPOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhFPOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIXwhCiivN2/2EEIJhW4aEymd94Mvvrv7X7NQrtq+U8=;
        b=WIeci0nn8GW9L0JF5FygPeidWZQOA4KnHm0SFedU3+9sWM2mEeVKw0b0lrMdDePKsWt/bt
        mOUvuwqemvPxNQNQi4mWXfT2VkDsQh+TxtbCfxO7klfkTO3HVLyJ9jVVgU/COOWGFHom0+
        CQzULRI+NutSsB4uPsI5Aw6TLdK6LfE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-pFfy9Lr2ORKeyU2Vtfm4lg-1; Wed, 16 Jun 2021 10:36:11 -0400
X-MC-Unique: pFfy9Lr2ORKeyU2Vtfm4lg-1
Received: by mail-ej1-f69.google.com with SMTP id o6-20020a1709063586b0290454e77502aeso1045060ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cIXwhCiivN2/2EEIJhW4aEymd94Mvvrv7X7NQrtq+U8=;
        b=kvQ0mrAEPDFmUxKGtGqa91IYAanEvnXDb/kOfGtarbJ8PmzpcOzDU+6XOmNaSNsZx8
         iUNlWXOWsimNYag7FXUlBiAxva3pUFwNzONcA6gkKxgj80PHolyKRgABuFIRxQrdKy3/
         0n0ge8Icth/wZY0kA4Emr3+go/iANzB3iU49cqWX8V0tjC1W7865PZd5fnkupJ43JIR+
         SVFBrMW9ICDNsfSi2GMiLx9JdzO/K+wrCysghnLcfKr4HgLV/jvvGRnXvOnxp6/SLu0Y
         LtCj/uQkVpC5gFpq9lHVk8B/+iIOCUoXRZHpIjBkfub5e3i1o+YiFzuacwm5bY6uXnnS
         nvsA==
X-Gm-Message-State: AOAM530rhiG31mDiZzZpepDxeVZfzqtcyj980i9lU0VMdyTB9vsRy+dJ
        +SWG07tFDOi9Aq9zMOVvD3Eq47dQPwBNvaXVKKqZ8hqxCdm9hu1eNomOlwc2+oobW0aFTOPP/qW
        IRmUXAFs0zyhaLyijNon6EIyoGWBOiBipwhEizikx656pE0Md5NXJkYV5v9V8BXm6r6ZeUm1fyx
        cN
X-Received: by 2002:a17:906:9516:: with SMTP id u22mr112349ejx.442.1623854169099;
        Wed, 16 Jun 2021 07:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPCD2JgYIR20tTh83PkrjX/7c8LpiFVshRDBld6FHse3iQ6bzc9TSeCNJzmqLnjQIIMBw6ag==
X-Received: by 2002:a17:906:9516:: with SMTP id u22mr112325ejx.442.1623854168874;
        Wed, 16 Jun 2021 07:36:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x3sm1734908ejw.69.2021.06.16.07.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:36:08 -0700 (PDT)
Subject: Re: [PATCH 1/5] ACPI: scan: Rearrange
 acpi_dev_get_first_consumer_dev_cb()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <9924939.nUPlyArG6x@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <308f4eb8-8a8b-2cb8-bf99-cc112e812f47@redhat.com>
Date:   Wed, 16 Jun 2021 16:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9924939.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 4:21 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make acpi_dev_get_first_consumer_dev_cb() a bit more straightforward
> and rewrite the comment in it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/scan.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2107,13 +2107,12 @@ static int acpi_dev_get_first_consumer_d
>  	struct acpi_device *adev;
>  
>  	adev = acpi_bus_get_acpi_device(dep->consumer);
> -	if (!adev)
> -		/* If we don't find an adev then we want to continue parsing */
> -		return 0;
> -
> -	*(struct acpi_device **)data = adev;
> -
> -	return 1;
> +	if (adev) {
> +		*(struct acpi_device **)data = adev;
> +		return 1;
> +	}
> +	/* Continue parsing if the device object is not present. */
> +	return 0;
>  }
>  
>  static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> 
> 
> 

