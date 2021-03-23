Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE8346964
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCWT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232711AbhCWT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616529465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbFqSrG2sRrCLakQgnlxjqEMdTAJbCULaJ2riG7khHk=;
        b=HBNpyoZOFeTRKtyWxdDZss/+4ejLSULonZrr6KzocgO65VvEGYAayFOMj1TSyPwV8WqDv4
        +pFr5R1IG5MaGQHG2VQDjByBXjlrzfpJhhokxfncJucjU4VZ7OvyXhHE2WtzISCdveIJ4S
        J2STXc+7Dpogx72Uo+ytlpAB+Fozsv4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-AD-UyLQMPJ24PaJl7IY5ZQ-1; Tue, 23 Mar 2021 15:57:43 -0400
X-MC-Unique: AD-UyLQMPJ24PaJl7IY5ZQ-1
Received: by mail-ej1-f70.google.com with SMTP id e13so1534840ejd.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbFqSrG2sRrCLakQgnlxjqEMdTAJbCULaJ2riG7khHk=;
        b=JNi5BENsUN4asalVQJKVYhoHRqyexCDqlbYfWbvAwu8Nw4c/9YB1DDBY3Tdl/MtJrr
         x815jEtvGlXtdHFkHvf/AuetZt+5V9Fzpulymx9FrgDN6qz9juV2LcEAe67I7e2uGJLW
         Vd/DCYDfuWSNr4ls6UXCPNKEB5JRMIN054K8vE2LzmqV4UdUmq7gB24o4S/dppLDPenM
         P6ZhiWabcaA3GaucVl9wUsvxlJDTgktVewXyw3vNoyI4JxNaM9os3q4MAReRbnLcpdIW
         FDx7fnwIq46lmdXAa/Xbq6+zbOaNcvjsmBvbx5RHt9y2FBjrwMWOMSetx1K+JuJtio3R
         amRg==
X-Gm-Message-State: AOAM532JBXdE5HmETYwPPNYPFiCv+Brvf1JVZeYCefCdaEb4hJRm3HqD
        HwFpbmMNhUyi+sAleCcwyXRwwzdIC2T7sXhrxFQnWNPDB4SBWpyvb+UKei3No55cFIaDb9hgsCQ
        PhOvm1mEMv0ox7ZuNaJvrQqWN
X-Received: by 2002:a50:f391:: with SMTP id g17mr6238596edm.26.1616529461844;
        Tue, 23 Mar 2021 12:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHHuV1vGaArVZf6uYZWNsgfyNiDSm5PaHkBe1EgY+BBelGFs+NY9EtrRK66hgC/Ad5LuRBaw==
X-Received: by 2002:a50:f391:: with SMTP id g17mr6238585edm.26.1616529461655;
        Tue, 23 Mar 2021 12:57:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f16sm3334768ejb.3.2021.03.23.12.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:57:41 -0700 (PDT)
Subject: Re: [PATCH] platform: x86: Typo fix in the file classmate-laptop.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cascardo@holoscopio.com,
        don@syst.com.br, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210317084343.3788084-1-unixbhaskar@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <458e9f69-6cbb-d470-d309-09feefef1475@redhat.com>
Date:   Tue, 23 Mar 2021 20:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317084343.3788084-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/21 9:43 AM, Bhaskar Chowdhury wrote:
> 
> s/derefence/dereference/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

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
>  drivers/platform/x86/classmate-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 3e03e8d3a07f..9309ab5792cb 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -956,7 +956,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
>  	/*
>  	 * If RFKILL is disabled, rfkill_alloc will return ERR_PTR(-ENODEV).
>  	 * This is OK, however, since all other uses of the device will not
> -	 * derefence it.
> +	 * dereference it.
>  	 */
>  	if (ipml->rf) {
>  		retval = rfkill_register(ipml->rf);
> --
> 2.30.2
> 

