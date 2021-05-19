Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B4388F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353727AbhESNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235855AbhESNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621431764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZruJbBBiPyol//Y6D1lcVyQcd9DKEkSU7NK63ClYKU=;
        b=UW9LbhNeESwo1B4nMcfa/HuGyW2kATkXbAE9pqWvXG67kWtLaq//wu2/5gp5oiv+ReMPuf
        MAnEB0vdx6IiZ8tMmXusH44wT5C+tUw0MblbrsbxVL/ustppBqD+DJsgJdOg7k8F5CMsOX
        z8927YuiE5MHYhQZJN/Ji5W8U7aVZ+E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-arJeO-ZMN_m-Czj5cccijg-1; Wed, 19 May 2021 09:42:36 -0400
X-MC-Unique: arJeO-ZMN_m-Czj5cccijg-1
Received: by mail-ej1-f69.google.com with SMTP id sd18-20020a170906ce32b02903cedf584542so3716429ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZruJbBBiPyol//Y6D1lcVyQcd9DKEkSU7NK63ClYKU=;
        b=RuY5Ls4g3OHpUjwlQl0N3885BRJ9dCcue9H/pbMwn7AfpyXKFhTBkh0nD1mpfZdbIS
         DIar7BBqx9MLaoovsqvQqpMatc5+5NpIDCARdRM9afvnAhPN0fJ9JWdTlIFAAl4yjfsR
         pxUoAWooNuHedQedGCSNuHmx0gN1xXhkiU1nr2d+VyKYTlFN2jO094qm5LdTSlpEMcgH
         jBvtBFb7w5Ip7j+csZQqC7kViMWty6NLT8DdNBsosxsHmrludi6pNDetg8+8+l4h87Mk
         Pn61UHDsiCqqJTxTTSUWWsWW33DzMpaaohBhb9RvAd0J9hgKSBE0h4XBGZ+pZ7N9C+iN
         906g==
X-Gm-Message-State: AOAM532jPhyxH/TeyTAZNUQOuqYR947hnl4qVEst4JpS6yvSXRJeFGu9
        9bNtTHoQ9281DI4VI3FN9aR++98HscezJn4fCP0UtwnOkyMQGyjDUFpgaC28w5y/o/yZw/1sQk/
        leskSErADdjju5rNBaXNa+rtUTwjhVYoIorhjaf0Ss+hBPbbee29Pk9ZzR9cHOzDeLhhscLeLel
        N5
X-Received: by 2002:a50:ab16:: with SMTP id s22mr14347997edc.323.1621431754988;
        Wed, 19 May 2021 06:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLFNYffy1Be3WQ+WowlzfbWgKqT7yGAs5ntPDDBau1K9D5xso4+M88j9EeQimOuuq6ltMZ4A==
X-Received: by 2002:a50:ab16:: with SMTP id s22mr14347977edc.323.1621431754835;
        Wed, 19 May 2021 06:42:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm9396334edc.96.2021.05.19.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:42:34 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: drop unneeded assignment in
 host_control_smi()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     stuart.w.hayes@gmail.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1620809825-84105-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f52156f6-a9db-e936-81e9-16049deba54f@redhat.com>
Date:   Wed, 19 May 2021 15:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620809825-84105-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/21 10:57 AM, Yang Li wrote:
> Making '==' operation with ESM_STATUS_CMD_UNSUCCESSFUL directly
> after calling the function inb() is more efficient, so assignment
> to 'cmd_status' is redundant.
> 
> Eliminate the following clang_analyzer warning:
> drivers/platform/x86/dell/dcdbas.c:397:11: warning: Although the value
> stored to 'cmd_status' is used in the enclosing expression, the value
> is never actually read from 'cmd_status'
> 
> No functional change.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

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
> Change in v2
> --According to Hans's suggestion, store the inb() value into the s8.
> https://lore.kernel.org/patchwork/patch/1419026/
> 
>  drivers/platform/x86/dell/dcdbas.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
> index d513a59..28447c1 100644
> --- a/drivers/platform/x86/dell/dcdbas.c
> +++ b/drivers/platform/x86/dell/dcdbas.c
> @@ -394,8 +394,7 @@ static int host_control_smi(void)
>  
>  		/* wait a few to see if it executed */
>  		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
> -		while ((cmd_status = inb(PCAT_APM_STATUS_PORT))
> -		       == ESM_STATUS_CMD_UNSUCCESSFUL) {
> +		while ((s8)inb(PCAT_APM_STATUS_PORT) == ESM_STATUS_CMD_UNSUCCESSFUL) {
>  			num_ticks--;
>  			if (num_ticks == EXPIRED_TIMER)
>  				return -ETIME;
> 

