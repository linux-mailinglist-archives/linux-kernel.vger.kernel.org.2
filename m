Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E083A9037
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFPD7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPD7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:59:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B259C061574;
        Tue, 15 Jun 2021 20:57:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso3178558pjb.0;
        Tue, 15 Jun 2021 20:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0XScMpE/KyQ6mTT7ibcYvmiqGT2GxiUA6wdpffAVhtg=;
        b=rS2L1uii8ph5f6AwSoEQ+dQmyNm2fAi6bwo3O+b3PkicI/jt2DHZ/zwqxyiCe8B3Qs
         E1UGO7a+VLeIdNhpXoPjJ9wkTRtUWA81GJrqMjVcEcvFB4e4vQPUGVRnXRRt+7PoFFXI
         X8RhX4mAy2bUGGlJjR8B6sQeRvrwjx1sZfe9vlSiXPiyBZ00so62Syt+78WqmfhspRm4
         TE6jWES2GBpPVxvmPACfjGBWTuawVz8ELGbUee9JYd9Kd62+xSfDLkGoJ7+Dui0NERg+
         ARaLNpSuTpAbod5VOFDpNwZ7rACJMfO4B509p58WSNowvpgi6vFuoJ/bEvIK1e0EOjbW
         OtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XScMpE/KyQ6mTT7ibcYvmiqGT2GxiUA6wdpffAVhtg=;
        b=hMREUmhEX07Yrf8QVPpqYOnhpjczjxkNVebqD/AOKX7R3EVKkH1+s8oBzKaZs5b0fR
         DUfMufwD8ruCFiJeRqA0puW/aFtKbc6f4r0BuAcbHD1MQxKbetLj6h41D6Y8gq6s7XiF
         vwL4Ua4pknYwvFfZJdwCKrTr5SqGoqKRACn35j1BuYTOHrkqtyyAtTM/CwJc29HX6vCh
         b0SHIHIniCscqpNDfbalHZrAIE5cf6EvOtkfGA2Xm27+e62fqmm7J51KQauINYw5gaa0
         mg5BnQ8fkKfZR9+y/7w70AAQhBYkQsv05kbahB5rdG308VQr751d4/sAh0wXAPefg1wy
         +zlg==
X-Gm-Message-State: AOAM530pNYhD2hkDHwxiBVfVE6eQ626ixRMUFVyPvzqC+cJBDmZusDYF
        23k8mjVZS990wBGTjx7oeFFjnHZZSR8=
X-Google-Smtp-Source: ABdhPJzx+z6JI3LO6cuT6NRvu3XABKQIkLjNjUiFdak1nKdDpi7fryBnZOWSMhnhyoxhgOwc7lT5bw==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id h4-20020a170902f704b029011acdee0490mr7061642plo.37.1623815845616;
        Tue, 15 Jun 2021 20:57:25 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d8sm548902pfq.198.2021.06.15.20.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 20:57:25 -0700 (PDT)
Subject: Re: [PATCH -next] drivers: usb: add missing MODULE_DEVICE_TABLE
 definition in brcmstb-usb-pinmap.c
To:     Yu Jiahua <yujiahua1@huawei.com>, alcooperx@gmail.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210616035003.38149-1-yujiahua1@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <35c58215-10e9-94d6-b82a-dbd1daaa77cd@gmail.com>
Date:   Tue, 15 Jun 2021 20:57:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210616035003.38149-1-yujiahua1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2021 8:50 PM, Yu Jiahua wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
