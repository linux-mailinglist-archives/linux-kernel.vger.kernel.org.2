Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041613A1576
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhFINZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:25:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhFINZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:25:08 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqyAr-0006wS-55
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 13:23:13 +0000
Received: by mail-wm1-f71.google.com with SMTP id a25-20020a7bc1d90000b029019dd2ac7025so1949559wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZHcwmcBCk5lvprMQJK82JaJ9zMetfOy1nrGFdC8Lf8=;
        b=WAcGvaFHLyZsaesZaJsPI/6Kvw0bs4t9CG2cskP9ED0mQXhqatt+QMrF2KLEuN4Jgj
         S7LJIb+8Wa62e7FSl3uvfuNon4oSlyX3FJy0bE0Z44o/WDIVdN46KDGMHh2RxF23CDPn
         p2DL2X4D9aoznYH+crBPRQYYvOpvkRksxVsmeX7hswgjy/C2Y8LB7s/jagJ/g4Gji1K0
         HSmJDpVPbsO6xeconLFlvfAw7WyPk/S+JgSXwfUcno38pSHbvNhd6x9TDKNNa3vRDIwG
         E4qcXKC6+K/WunbmDra0zDpaRGq7VbCag0UeuzntTJcYvxNOa1QvdL89DZrIv0AkebnM
         sQfQ==
X-Gm-Message-State: AOAM533Hs4l/zqtckpLLLC+xYSIQE7gNSLDR2C4yxaZQtK0FUtgbL6NB
        /JysiEGm8n1s+ldLCS3Sh/kpXSZ2dsv3VKszMBS49OykhaVO6eXb5wAcDIsq1JTn7uSvXHrU2mB
        wduwzTQam9QBIpxYAD0NeYeqMJIJy5uC635/QeZdQ2g==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr9555978wmi.6.1623244992938;
        Wed, 09 Jun 2021 06:23:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE07PURI2CbXH6LOfvKl/P4UxKK5oXM/IoS0mjhrCSr11j6J28ssoLODge0i12ZK8N16q/iw==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr9555966wmi.6.1623244992844;
        Wed, 09 Jun 2021 06:23:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id e16sm3716389wrw.49.2021.06.09.06.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:23:12 -0700 (PDT)
Subject: Re: [PATCH v22 15/18] MAINTAINERS: Add PL353 SMC entry
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-16-miquel.raynal@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f04b06fc-72f9-8f90-343d-e4826a3bf4d7@canonical.com>
Date:   Wed, 9 Jun 2021 15:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609080112.1753221-16-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 10:01, Miquel Raynal wrote:
> Add Naga from Xilinx and myself responsible of this driver.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Memory controller bits look good to me, except few things in bindings. I
can take them up to this patch, for which I would need also Ack from
Naga Sureshkumar Relli confirming he will co-maintain this code.

I assume the NAND driver depends on this, so I can prepare a stable tag
with the memory controller part, if needed.

Best regards,
Krzysztof
