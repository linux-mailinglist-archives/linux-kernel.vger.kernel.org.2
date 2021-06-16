Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2E3A9CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhFPOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233674AbhFPOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623852110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuigkSf3oVyn4uOeOvAmJ67b8TwOsP+BB6Vyhnv1wMY=;
        b=Mrwa83EtN9ndwy6xEEsuBXotscKkyV87OKlIdWtoub1dcj4ikUrkdjm13IdNL1GYr48Ff3
        BYOL1uxqsXcHFKgb+OC9rhvSrtRbebMhorFlhh1A90L8Sp7ySkC2hy0+n8tDlaA45+hFXC
        7/a60tNHWINO7WddH29vV4Nu+WZdgZs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-I5-mcmEmMm-SNqoedzeUBA-1; Wed, 16 Jun 2021 10:01:48 -0400
X-MC-Unique: I5-mcmEmMm-SNqoedzeUBA-1
Received: by mail-ed1-f72.google.com with SMTP id x8-20020aa7d3880000b029038fe468f5f4so1084688edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EuigkSf3oVyn4uOeOvAmJ67b8TwOsP+BB6Vyhnv1wMY=;
        b=Pdt//KupBrG20G37x4j3yILHtR8ENMxuQ5PQNiFZ8mgIkma41/CvOjd2tuvU3Irgal
         KifYBlTqKR05jgEMz7Jr6oMHUGpgNLvx6Im9MgqCJA8wM/QQbWR9TIi/7ccBq19hsdmg
         lEGS/y5neNjdtkqxhOn5qMqGhE29El6aazQFiX8wMzKCmqOJdSD1A6TzKqKKEu89p8SC
         lF/6vWxUdt1o1tSliiFrXyqm3FljDnYhIpnLJAHmeUWn+HoAQ4VuqRvzvtdv1tRfIqii
         2UPBnfZBZGKrRAD5Vxh+qVehCd64rrRcS26ir9cGMIGXFxHc+opSTyuzO1DXSnW5yLoG
         9Fqw==
X-Gm-Message-State: AOAM531AYFWOY3r1oybhOaJhFHSed7zru+SKLmng4ZYBXz6lSqmnME46
        I0rn6Q3lpeAOMGwCZRY4iE1xq0Z1WBZ6ZRUdkIEFT8KV4LSUTLw2CUpEEPYpCzT755IRovJmRsR
        VLkGYC8b4nmkUrBvdlaS5sVsjIIdGJAqSC/ek+SimQQ01sSSGfhqmAIouKTgRZBh7+GZIGo/Zom
        mQ
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr4452654edc.174.1623852107536;
        Wed, 16 Jun 2021 07:01:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznb4e7pprjbLMhePXyxYl/0qX3QcF+KCI6z8PYYpeVrtTTvPjegzp7saSVNyej2GY84a3/8Q==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr4452623edc.174.1623852107288;
        Wed, 16 Jun 2021 07:01:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f15sm1706051ejl.60.2021.06.16.07.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:01:46 -0700 (PDT)
Subject: Re: [PATCH -next] platform/x86: think-lmi: Add missing
 MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, markpearson@lenovo.com,
        mgross@linux.intel.com, Maximilian Luz <luzmaximilian@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1623811809-65099-1-git-send-email-zou_wei@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a53b7c08-ef8c-6b88-cb5a-99fca16dd526@redhat.com>
Date:   Wed, 16 Jun 2021 16:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623811809-65099-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 4:50 AM, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've fixed up the vmi typo notices by Maximillian while applying the patch.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/think-lmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 7771c93..6e1fbc4 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -873,6 +873,7 @@ static const struct wmi_device_id tlmi_id_table[] = {
>  	{ .guid_string = LENOVO_BIOS_SETTING_GUID },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(vmi, tlmi_id_table);
>  
>  static struct wmi_driver tlmi_driver = {
>  	.driver = {
> 

