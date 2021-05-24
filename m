Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084D38F23C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhEXR2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhEXR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:27:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:26:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y15so9976638pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kc0+FMTh1fPx01D55Spy3LcqXmB7S09x8WY0Dxu365k=;
        b=fVTQMabckqboIr0/IMEVPxBxbF/HEtsovdQRtkXQiqkQOqTNwm/ID92EtPEYT2H6mg
         SqbYfSzv882VpyKwCoqaA73Eui7m/pXDku0QSpXoSkMuRnvYAASMG+8WRBna3VYsnVVi
         L1e8PRnRcoXF9TOvo5YuQ1H2x66VegH60wjEcUHtXFMqt+JQFwjUan+hCT7kW52DU2TC
         +q5aV/Li2YAeFmdKrBsykqJMSiCQ7HtkkpFGhIfLF7jx6ZordI5EAYh+akXgBcfIyChX
         a5DpY3PvYwZYz37rxG+g5THKVaNCdi7Y8uv1EnRIcdzlMzrF8wAF4uKey1CzScXHkryP
         GykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kc0+FMTh1fPx01D55Spy3LcqXmB7S09x8WY0Dxu365k=;
        b=e/LNMy1RRzMIfo9OhKrmjJaeWZ4344yP79hbUKDu/9pmFHrGruAp6pB4PlAYEPhkSU
         4jOBZUwJS3dacW/F4/61scqFThD4fHV7yyn/TPYX70NBCd1riM+uepLo+/+nJlFnp0b4
         gU9FkM9Lfal2Npnkqkuv6D22NqgJjJrNSbmy62Is+cfMEmoTxCF7YtIJHtIUzMTESp6T
         jUpsKoGfl5osOQG1VmUPGWrnDS8z32scsoagxpkkjOVjjH6caNSg8opJY3/wpobwdJek
         KX3SnocgCtInthDpnAJp83rXBUOEwnJoLoZwpLGT8lwxK/ayg5Xv7AOXDz0YuDfTk6q1
         wKZQ==
X-Gm-Message-State: AOAM533MPgzVwqf5Bb4x8asnCGo/w7C1P7afOO569KKjnPJ9tYSda3gU
        11xczFRlcjD9GImdNal6jCbI1L0AaBlBgoSe3FYnhw==
X-Google-Smtp-Source: ABdhPJzBL7dL+K4AaWffSd8Hhot68UFvNRF8DXg4o7RNb8LfCBNLbMB7ygs96g4hHsXIBRcg3JzZ8w==
X-Received: by 2002:a63:7107:: with SMTP id m7mr14927390pgc.287.1621877187748;
        Mon, 24 May 2021 10:26:27 -0700 (PDT)
Received: from [192.168.93.106] ([118.200.63.8])
        by smtp.gmail.com with ESMTPSA id c16sm11392439pfd.206.2021.05.24.10.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 10:26:27 -0700 (PDT)
Subject: Re: [PATCH] staging: vchiq_arm: Using copy_from_user() to copy data
 from userspace address
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        phil@raspberrypi.com, amarjargal16@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210522053429.82710-1-phind.uet@gmail.com>
 <YKilx7iNSBYYbXSs@zeniv-ca.linux.org.uk>
From:   Phi Nguyen <phind.uet@gmail.com>
Message-ID: <51eaace6-e464-147f-85be-ec8188e0e2ef@gmail.com>
Date:   Tue, 25 May 2021 01:26:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKilx7iNSBYYbXSs@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/5/21 2:33 pm, Al Viro wrote:
> On Sat, May 22, 2021 at 01:34:29PM +0800, Nguyen Dinh Phi wrote:
>> This commit to fix the following sparse warning:
>> incorrect type in assignment (different address spaces)
>> expected void *[assigned] userdata
>> got void [noderef] __user *userdata
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index afbf01b7364c..2a4fc599f977 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -960,7 +960,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
>>   			current->pid);
>>   		userdata = &waiter->bulk_waiter;
>>   	} else {
>> -		userdata = args->userdata;
>> +		if (copy_from_user(userdata, args->userdata, sizeof(args->userdata))) {
> 
> 	The contents of userdata (local variable of type void *) is uninitialized at that
> point.
Sorry, That was my mistake.

> Just what do you think that call of copy_from_user() would do? 

Because according to the definition of struct vchiq_queue_bulk_transfer, 
the args->userdata pointer is userspace address.
