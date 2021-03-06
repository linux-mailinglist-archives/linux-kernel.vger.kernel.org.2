Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA80E32FBBD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCFQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 11:13:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCFQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 11:13:41 -0500
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIZYh-0004ak-UY
        for linux-kernel@vger.kernel.org; Sat, 06 Mar 2021 16:13:40 +0000
Received: by mail-ej1-f72.google.com with SMTP id n25so2419834ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 08:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kSOpPvwteB7OgdggMYlflHqoFNnAak/wbdk3zQ46jYs=;
        b=hYF8YKQxOzOG11rj8lmBs172sutaNNNAW6iXHYdkzNfHP5QeN7PiTGOlT5AQGAQ1C4
         nE95Ju6zoEpx6lmlqE+d4kQKJNB05c8BRsiTVBRZIJS66qUJ0llXszbrGCoNl6sACyKu
         6c+3D4VzmTLH8gPVIZXH89nRxjAQK4m0BhPp6TihBhHnnPccVygYMsHoKeVaw+we5Ji9
         7EV2e9zMZLXCg2nFJg0y1zWNl1I5ma4jbkrOh5Ib10p3GhtMqCNObAaYwuDrR8TyT6uZ
         x/46mU5bzfP9+yAojn8jEV9sAekz8VRGIjHAWeiEuOuWiWVkdp2j+4sqOLTS4bVdSoG3
         0WBA==
X-Gm-Message-State: AOAM531P0BqeP3SUGX066Lsm+sfWbkia90RXzYZYmg7RkUnkqTC3f0uk
        oDhqcQBW0kxKMWJThQE5ecJ5yMgaNLPVDYkny5A5DgFxSp1IJsP95X274ytyDqjd7D6Wq06gIs2
        JF72Yvn/fvP9VMN9kdBGDlNLuiFTXxyT+e3evVo0qVw==
X-Received: by 2002:a05:6402:704:: with SMTP id w4mr15006214edx.175.1615047219623;
        Sat, 06 Mar 2021 08:13:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdAGCIq65lZYlyAxqCZzWAm3VpQnb3VqeFecUkSHeg10URY0/jp2c3aXPC8lt9nQB63KGrWg==
X-Received: by 2002:a05:6402:704:: with SMTP id w4mr15006200edx.175.1615047219456;
        Sat, 06 Mar 2021 08:13:39 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id k5sm3487412eja.70.2021.03.06.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 08:13:39 -0800 (PST)
Subject: Re: [PATCH 1/2 V2] usb: gadget: s3c: Fix incorrect resources
 releasing
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        balbi@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        gustavoars@kernel.org, arnd@arndb.de, ben-linux@fluff.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210306142108.3429-1-christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4ef30769-91c2-031e-8e19-af25d26c848c@canonical.com>
Date:   Sat, 6 Mar 2021 17:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306142108.3429-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2021 15:21, Christophe JAILLET wrote:
> Since commit 188db4435ac6 ("usb: gadget: s3c: use platform resources"),
> 'request_mem_region()' and 'ioremap()' are no more used, so they don't need
> to be undone in the error handling path of the probe and in the removre

You ignored my comment about typo here and did not add my review tags.
Did my emails missed you? The made to the mailing list...

https://lore.kernel.org/linux-samsung-soc/f63496f6-f894-2a86-0328-0f8dadbd28cc@canonical.com/

Best regards,
Krzysztof
