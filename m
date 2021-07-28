Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05883D8B57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhG1KD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233734AbhG1KDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627466615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GwhmQ7C85F230rECddooLFcsBp3jRhki99AY7vjwwSc=;
        b=eVc6GnRviZz4SvWxepBQsrKTjJV5r3UqC4TLZ7livpDsSWtlAOpIY7TAHX3aeXE4nSMJY2
        g8MfpBIa9zpmTVGEGUSj/Rf9KRlRW3e/hGXDP6SPO3ZDA6Ep/zLaDCnxW3XIUZodHo8uY7
        2b4XOrF6yD0SW4I7VY5l/caG4AN6jO0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-kFsxe3VdMu2KLE4l29_F7w-1; Wed, 28 Jul 2021 06:03:33 -0400
X-MC-Unique: kFsxe3VdMu2KLE4l29_F7w-1
Received: by mail-ed1-f72.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso976501edf.23
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GwhmQ7C85F230rECddooLFcsBp3jRhki99AY7vjwwSc=;
        b=W2Q0QVmi8YuoXGNFQXPOsLkfUZSt2AsHW+5kxi2gqob5G6X9qN5sIj4ZpJ+hq+xamp
         AHGPt3R4aj7U+GGZDccLMPfmBRYFIxNeYEc1nVZN1OttYGdZVS2uAy28eVTG4tna2KyM
         s8+N3j4/Efzb/smYMVSR5fd1ZOKQ1n2Wn6FC+kSiJaL74F6PxilToPSWEzzCVf+AYQaf
         7/lTKh+QHplR3Wj3xkabZsO1pITYutt1aF3dlJR7j9dyGUrlvTgDpkUnaIxn0zDo90KO
         hsXCcSPDAvAgt4KYgzV7aCt0No2HNAhKL+yFO+TpvEELTEGHWRtLv+cuSuZOLcCUla2u
         KvKQ==
X-Gm-Message-State: AOAM531uBu4Cyd7p7n224o7rE6TJp6tOO/i+DaqNthMGaPJfGGOH87/V
        Q6w1PFpPNuFX3/zPXMhMlvSKvZHNjdimsOyo5M02E6gNJ6BMSQs4G9LTVC7BMgPAvT1io3yQmyo
        enG+TUlAb+Ir3Ncf6Qvd2qLrOw6EQSGbPWhgNK51z+kj6jHQ4kv1UzxPJIt3qWOR/higpO5kYOx
        gt
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr32984442edu.74.1627466612372;
        Wed, 28 Jul 2021 03:03:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpaH4qZjVq5c1C3noTeH4oiEzRUqwERoQjxEjilavD9APIZ85teEGEaAN6otJBruhsQND5gA==
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr32984419edu.74.1627466612195;
        Wed, 28 Jul 2021 03:03:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id aq24sm1888816ejc.48.2021.07.28.03.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:03:31 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel-hid: add Alder Lake ACPI device ID
To:     Ping Bao <pingbao@gmail.com>, Alex Hung <alex.hung@canonical.com>
Cc:     Ping Bao <ping.a.bao@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:INTEL HID EVENT DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210721225615.20575-1-ping.a.bao@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9e95f7df-f12c-7a04-2234-279da65145f8@redhat.com>
Date:   Wed, 28 Jul 2021 12:03:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721225615.20575-1-ping.a.bao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/21 12:56 AM, Ping Bao wrote:
> Alder Lake has a new ACPI ID for Intel HID event filter device.
> 
> Signed-off-by: Ping Bao <ping.a.bao@intel.com>

[hans@x1 platform-drivers-x86]$ scripts/checkpatch.pl 00*
---------------------------------------------------------------
0001-platform-x86-intel-hid-add-Alder-Lake-ACPI-device-ID.patch
---------------------------------------------------------------
WARNING: From:/Signed-off-by: email address mismatch: 'From: Ping Bao <pingbao@gmail.com>' != 'Signed-off-by: Ping Bao <ping.a.bao@intel.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-platform-x86-intel-hid-add-Alder-Lake-ACPI-device-ID.patch has style problems, please review.

I'll fix this up locally now, but please fix your email setup
so that the Author field of the patch gets set to
"Ping Bao <ping.a.bao@intel.com>"

Regards,

Hans



> ---
>  drivers/platform/x86/intel-hid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index 078648a9201b..e5fbe017f8e1 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -25,6 +25,7 @@ static const struct acpi_device_id intel_hid_ids[] = {
>  	{"INT33D5", 0},
>  	{"INTC1051", 0},
>  	{"INTC1054", 0},
> +	{"INTC1070", 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
> 

