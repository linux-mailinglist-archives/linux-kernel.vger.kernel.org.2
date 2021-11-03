Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E389B444710
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKCRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230198AbhKCRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635960499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3vUfVtNAp+NHc0VZGMqWaMG2ICg6HEbKSf06yppkuM=;
        b=cDmR6QrKUIiNVQZLkADjV2DEu3GPIeSi9rHzBtLVeP9dJtuLB7AadhXoI9247kGrwTdhWx
        Tk0Ir8pFgZCLU9bUQtCGOw0U3EfFIBtnyDqexU+JgfELjFA0mpIj8sYremRlu7bs35HUG1
        KIgTCGxgVCRPxVG58eFsD1L2DHhns6M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-kuvw_CapN4quKgNSOXapeg-1; Wed, 03 Nov 2021 13:28:17 -0400
X-MC-Unique: kuvw_CapN4quKgNSOXapeg-1
Received: by mail-ed1-f69.google.com with SMTP id o22-20020a056402439600b003dd4f228451so3166322edc.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/3vUfVtNAp+NHc0VZGMqWaMG2ICg6HEbKSf06yppkuM=;
        b=FMC0j34ANpRU6VZSHN5qh2pYVwd4qiDVvdMamFQPAzoMBBwyMXh/z3fP59n7Ct52/j
         YVtIRYJArqDNhpoTlAqxPHRZ7L7QiIKUe3vwFbgZmWX2K90rd4FRqYBWuRkTOP1zntSA
         /4SCyK3VBRu3PembPCvQm5f41viH8iwZwDwq10xsmkK/hdUfoDrgM6y8NrxJGW2eUU1U
         mwqA39DBAO/FxlSYxLY3bQkIo9wPWJaGqwClvdYE5BsHq93EV1WLlllYxQC9E2Noj2ve
         3L8RZ8G4I4D/49MATj0I9Hf3kd+gofftPO9HqrrsrC0Y23NRHBgDeXkzy/5fMvZwy3U5
         692w==
X-Gm-Message-State: AOAM531ZFHdvrGdNv8dcguT4l12dU2NmcQfNTd2lI1wdEfNtgXKwvJrU
        RQ6Yf+83V6elBsF3Kz7SfNRFCTrQ9gzk4N0kw8kbTi9WpkM9WmZo9ZzO5nY74oO7rxd91aJ9He5
        W8JEZBL+rkTBuo9kXu/X1dA+6
X-Received: by 2002:aa7:c053:: with SMTP id k19mr60902711edo.293.1635960496654;
        Wed, 03 Nov 2021 10:28:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNRnaHb5jF+zfe4fkL84C73Vq/hpN9b4BZRfrqQi6jeIgKg0x54vAQgmUcJMDLIby7rEUY9g==
X-Received: by 2002:aa7:c053:: with SMTP id k19mr60902675edo.293.1635960496469;
        Wed, 03 Nov 2021 10:28:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm1sm1464617ejb.38.2021.11.03.10.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 10:28:16 -0700 (PDT)
Message-ID: <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
Date:   Wed, 3 Nov 2021 18:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
 <20211103171756.wxthncse2f4syeiz@maple.lan>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211103171756.wxthncse2f4syeiz@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/21 18:17, Daniel Thompson wrote:
> On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
>> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
>> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
>> "XMCC0001", add support for this.
>>
>> Note the new "if (id)" check also fixes a NULL pointer deref when a user
>> tries to manually bind the driver from sysfs.
>>
>> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
>> so the lp855x_parse_acpi() call will get optimized away.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thank you.

So what is the process for upstreaming backlight patches,
do these go through drm-misc-next (in that case I can push
the series myself), or will you pick these up ?

Regards,

Hans

