Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35CB33F771
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhCQRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232691AbhCQRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616003234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9dOkUTln4r0Gj3+3gqTTjBhzkRmDBouD59jvisuBCU=;
        b=dr7P2cNQI+82RPNswJTM9AtiMuT9s1SC+8tppnlAP0aworOumrKndTJ4GBOftaWJ9esFQ/
        tGENMhld9c4A3FwqUCRlRNLu78QA1Qsqj+OfJHaVLtfrwiXtP29fg6/Td4BE1z/F+KmLFu
        E5EvwFzeXwC5JXvzl54yTECymvkhvPo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-KeW1h84UPWKi9GFR2UJBdQ-1; Wed, 17 Mar 2021 13:47:12 -0400
X-MC-Unique: KeW1h84UPWKi9GFR2UJBdQ-1
Received: by mail-ed1-f69.google.com with SMTP id w18so16967238edu.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C9dOkUTln4r0Gj3+3gqTTjBhzkRmDBouD59jvisuBCU=;
        b=SpAEhV/DmtgZK9ryuxaOhFNhtxpW5psRYzA/UP9SMm8gIx6C//lkg/xutyfDIfV9Fb
         TayvKoCWAEABVQ3u2SIengihGgAvxo/e+NGsH0klSL5Lq0fvwCfUcGVUuGr8IxxPfgkH
         lxZoe64RrvFqNIL29qaLdMYvngE6eApn0Loxj7qRj0Ii0qyg2lLiNubz3mg+omeSIryt
         9fJrA3CHjyu/nSeA8RT++fKNF4p3BxGyLOg9KX09TDZLAfaqvRM27vVLOKlVlptba8ze
         0dvBG8JCPDVwzSPCyMIn2fQ4KnkYSmHfCZA3INhZbyDABIVdsrO9xv8S9hh3lP263ksR
         4sAQ==
X-Gm-Message-State: AOAM530r5bWxqhnd/9SKICs9I2cA7q97AGP0ZSYZrHXFBo0h7wpp3gFE
        usRvT0/GoUUUWxt7T/J0FYcNFm0PIOHElVpUYej+IG3ECVd0eLm99hrbJ/M5+4Txt3i4d2XSk2k
        NUyljbySKMS7VApaMkji3JJXt0xUIWFsrfEBllC7/+oLe70vgGFNBs9A6L13G007JHXlkhsbtE2
        IE
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr26587701eds.244.1616003231210;
        Wed, 17 Mar 2021 10:47:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpCj5Mfn1CSF/zpDxQRKMf2ghZMltaucO+43fOdTzLm5Os82pWnRnmI5Av9l8qR0xNvisUcA==
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr26587676eds.244.1616003231006;
        Wed, 17 Mar 2021 10:47:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c15sm6290011ejm.52.2021.03.17.10.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:47:10 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add support for
 Surface Pro 7+
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309162550.302161-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dff36756-9de4-750e-b7af-f65c97acc42c@redhat.com>
Date:   Wed, 17 Mar 2021 18:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309162550.302161-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/9/21 5:25 PM, Maximilian Luz wrote:
> The Surface Pro 7+ is essentially a refresh of the Surface Pro 7 with
> updated hardware and a new WSID identifier.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index cdb4a95af3e8..c42b97f61a57 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -191,7 +191,7 @@ static const struct software_node *ssam_node_group_sp6[] = {
>  	NULL,
>  };
>  
> -/* Devices for Surface Pro 7. */
> +/* Devices for Surface Pro 7 and Surface Pro 7+. */
>  static const struct software_node *ssam_node_group_sp7[] = {
>  	&ssam_node_root,
>  	&ssam_node_bat_ac,
> @@ -521,6 +521,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>  	/* Surface Pro 7 */
>  	{ "MSHW0116", (unsigned long)ssam_node_group_sp7 },
>  
> +	/* Surface Pro 7+ */
> +	{ "MSHW0119", (unsigned long)ssam_node_group_sp7 },
> +
>  	/* Surface Book 2 */
>  	{ "MSHW0107", (unsigned long)ssam_node_group_sb2 },
>  
> 

