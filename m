Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173A0314071
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhBHU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236030AbhBHTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612810876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsOZdP6JaGBCys6lI8Ps0nCa4t1QI6F4FQf8RXTti5c=;
        b=cMCW3tFy/xnkG44LXmfpmHPxrd5ewSzu5hIx80ebRQw8033N4UyJ6PBbpwfhw1b8HiekdD
        HYgK0kSmGPs8zK9oktq762okbuk8R39eK9CHdTlcoe/NfuQVsqkNUL0VDVp7kpEj91WHrJ
        F3/e0g4GDQvKocL+Twr2j3WhFdM8u8Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-lIfo_S48NqCz7Jxgr8kpjQ-1; Mon, 08 Feb 2021 14:01:14 -0500
X-MC-Unique: lIfo_S48NqCz7Jxgr8kpjQ-1
Received: by mail-ej1-f70.google.com with SMTP id q11so13011008ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsOZdP6JaGBCys6lI8Ps0nCa4t1QI6F4FQf8RXTti5c=;
        b=SDlpPWDjjH+93mCqUZuWBO0hYQGZmkA7nceya0pRO+DiDpx2czMMMpmh1bKF1rBT9m
         oh8gPTStImKlmRU39Nx4SlMrOfU/h2BLxoXyWZP4BUv49sruuLrUvoVb6n+/kSoxJ0YB
         FSzRTde1RSOD5GzmnOLzJCX9IY4KHSvS3wOOJcsR4DhCctkAEbvo2laFrRHXHMbwOJBf
         OeWdNiWhYV4E+zLQSBUffiD6j0XNvYq7t2RCGHbMe0x94mnUwQ4SIe1IWBKPgFzL4svY
         DaduLoEyOnANUdLA0SOlKICTFPeBh6syrO7dmMS5gNyzfAyTa4VgDGEDxZNN9ozLweO+
         SBvQ==
X-Gm-Message-State: AOAM532fVWIresIFrnvOAYQ55dGI6VCf5gJgAMk8K6higYp7MSzZUSt5
        tts3wag7Fdyn1rsmHEEff/IroXBT1ajjhBbuwGHF7g3MnUc7xxZPZrZOsE/WswSGNKJAikQ2++o
        Aldfb5MZP9Jsx1oYgyTxj+6ic0bjss+Tr3Ayz85gY3vBT2iyvPxM9s+VMPH6TbJ6Jnyp4MHKBsI
        6B
X-Received: by 2002:aa7:d58b:: with SMTP id r11mr18480102edq.241.1612810872969;
        Mon, 08 Feb 2021 11:01:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrKaV6M4wNhPDX70JYnsrA7SHTqWJx6bMT62GOn1cJQvQVqzhPKKQ7HGRLi0rlL6RL/liZ5Q==
X-Received: by 2002:aa7:d58b:: with SMTP id r11mr18480077edq.241.1612810872685;
        Mon, 08 Feb 2021 11:01:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id kv24sm8947329ejc.117.2021.02.08.11.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:01:12 -0800 (PST)
Subject: Re: [PATCH] Platform: OLPC: Constify static struct regulator_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210206232152.58046-1-rikard.falkeborn@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1c0f6456-56cd-0778-fda1-98d810963225@redhat.com>
Date:   Mon, 8 Feb 2021 20:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210206232152.58046-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/21 12:21 AM, Rikard Falkeborn wrote:
> The only usage of it is to assign its address to the ops field in the
> regulator_desc struct, which is a pointer to const struct regulator_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

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
>  drivers/platform/olpc/olpc-ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 72dbbea0005c..4ff5c3a12991 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -386,7 +386,7 @@ static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
>  	return ec->dcon_enabled ? 1 : 0;
>  }
>  
> -static struct regulator_ops dcon_regulator_ops = {
> +static const struct regulator_ops dcon_regulator_ops = {
>  	.enable		= dcon_regulator_enable,
>  	.disable	= dcon_regulator_disable,
>  	.is_enabled	= dcon_regulator_is_enabled,
> 

