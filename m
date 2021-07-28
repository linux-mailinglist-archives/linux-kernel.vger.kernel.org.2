Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB93D8B53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhG1KBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234649AbhG1KBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627466466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuzMO/cl95LwiOj8k16xF3MZrsBqRw/bir3k0C2wtnc=;
        b=KinP5rqTkVwukaKMoxKgoxYgx3vfw7PjpN1fXrRsAF4L39G/o6IVMpdv7JZ7e0IaPOE9MF
        SW4GAxscgvT0VS/4A+tqyJag7M3JH7joyjHfx7kcJRjknx+C5XPXfPUhcdweWJ/p4UowRH
        dRH6ZKTLMpdb513Os8HMnMv1Ex/0o6I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-0Hc6J42tMDuXnyQXVKeeoQ-1; Wed, 28 Jul 2021 06:01:05 -0400
X-MC-Unique: 0Hc6J42tMDuXnyQXVKeeoQ-1
Received: by mail-ej1-f69.google.com with SMTP id pv7-20020a1709072087b02905119310d7b9so625857ejb.23
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuzMO/cl95LwiOj8k16xF3MZrsBqRw/bir3k0C2wtnc=;
        b=k9R6n9Zb4x1xmSlKnXu3s9MqpByS1ku6OdXmz1LkQEeDy5CqI2iay0GRb1s83radbY
         0oJu4LB3onMiaMeEiQ748LCy1QxKdzxtA5jYAAOPDO2lAA5K4FTEIKE/vyWfZ/9/VeDT
         r6zuDPhB07a5r7khGlCipzpXgKlpUiTKcOJYLcZFsN3yP4NaHNxM0LbreUhwMfVvTL3w
         4MWFTxhpPl5ziVCJiT3hUDK1Gpf2P9qB/Of4DRrvDuRoEhtOhYdnLdk+vZrMrnhZH3ha
         rgA7dA+C0kayTX5RMlG801ClwTjxGeeSWeL3DGLZGHkgrb20tclxVVc/V8ZmR3b52Vin
         sGKg==
X-Gm-Message-State: AOAM533sRcdFWeMV/jvmpQipDIvSeF54HUzf0NtuH21HCwaceBTfU8nS
        4yQVVqHZEcbEGEu8YYdiZfkPYYAi2hjQjjvJY+aSYD9Mf48TdjOMm5nOdrcQN2hBuGSg//0qW0Z
        1G4jfbHA4eYZQMM0hUyRa7Tof
X-Received: by 2002:a17:906:3fc2:: with SMTP id k2mr26599127ejj.440.1627466464075;
        Wed, 28 Jul 2021 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVcwMHCtCdr0aPIYRwLjFYJv7iO+jzCt+0kJrvrG0/uWXbRZAmf9MfRYi1NWkKv1x1u5n3hA==
X-Received: by 2002:a17:906:3fc2:: with SMTP id k2mr26599116ejj.440.1627466463916;
        Wed, 28 Jul 2021 03:01:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id qa34sm502153ejc.120.2021.07.28.03.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:01:03 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B550 Aorus
 Elite V2
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20210726153630.65213-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bba2f992-d392-4087-c32d-ae60bf05d9ff@redhat.com>
Date:   Wed, 28 Jul 2021 12:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726153630.65213-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/26/21 5:36 PM, Thomas Weißschuh wrote:
> Reported as working here:
> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1#issuecomment-879398883
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also add this to the pdx86/fixes branch and include it in
the pdx86 fixes pull-req for 5.14 which I plan to send to Linus soon.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 5529d7b0abea..fbb224a82e34 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -141,6 +141,7 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
>  
>  static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE"),
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE V2"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 GAMING X V2"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
> 
> base-commit: ff1176468d368232b684f75e82563369208bc371
> 

