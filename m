Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE83A1384
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFIL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:56:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbhFIL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:56:24 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqwmy-0007BV-BR
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 11:54:28 +0000
Received: by mail-wm1-f71.google.com with SMTP id f186-20020a1c1fc30000b02901aaa08ad8f4so2432870wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLhTmNdHd7QsVRSZXglysFm3zyoNBR2RnD/RonHYik0=;
        b=O92YcEibone4kDkEr8UmWHeGkjjqjKxc5Bys3Hq6JTbO4iaY3GA2gwUTcaoZGPnP+C
         H8Z4DaHxFm+jF2jTc6cDqvH/BDtjN3l5/Tksk863PUxG1T0drEfh4wCWNGdGvKPCPRbY
         k4l5ph5BQkvt2T3TvfGx85UWsMQXsul+RgPqux+DXdQMYK9Y9ZIAwaUmUgL5XM34U/sD
         KuC1uEyoiBWSBJkV5wJ2ySBoR7aYCcZxbYbKM+c/tfzyeWuam0Aq3M6UKl3ymMQJNZtI
         8d/T0fW7c/Rj7RytRjFoVzVR0POG/9Xc0zdTKgHaQYpibC+QiMKqszELC8wdJwtCLUGk
         V1PA==
X-Gm-Message-State: AOAM5329fNQvJSh+ieVclyd/9eLirihYT7zGGuW5bBXFYxouu4brFNSW
        g/3x8YTD3ofBruzzNVBIQnnVIrh80fzPbmQJMEXHwWEduW8Vzl3UXdZwuy7GIom1GO+aL3YHHl6
        SOCONVDF+DLyZ6Mcwxn6+Moni+gJ9XLCca7G6AJRsXw==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28653525wro.345.1623239668055;
        Wed, 09 Jun 2021 04:54:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCt33hywH+M3y1CT+bTXzh8xJ2GJIIBftxRP+jWPUmJmFgjRVOBzLHkNPNuSSYkP5EMOKO/w==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28653501wro.345.1623239667931;
        Wed, 09 Jun 2021 04:54:27 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id u15sm5852148wmq.48.2021.06.09.04.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:54:27 -0700 (PDT)
Subject: Re: [PATCH v22 12/18] memory: pl353-smc: Let lower level controller
 drivers handle inits
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-13-miquel.raynal@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b9be2ca0-7d62-c5fd-6aa8-e04c57b0f75c@canonical.com>
Date:   Wed, 9 Jun 2021 13:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609080112.1753221-13-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 10:01, Miquel Raynal wrote:
> There is no point in having all these definitions at the SMC bus level,
> these are extremely tight to the NAND controller driver implementation,
> are not particularly generic, imply more boilerplate than needed, do
> not really follow the device model by receiving no argument and some of
> them are actually buggy.
> 
> Let's get rid of these right now as there is no current user and keep
> this driver at a simple level: only the SMC bare initializations.
> 
> The NAND controller driver which I am going to introduce will take care
> of redefining properly all these helpers and using them directly.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/memory/pl353-smc.c | 294 -------------------------------------
>  include/linux/pl353-smc.h  |  30 ----
>  2 files changed, 324 deletions(-)
>  delete mode 100644 include/linux/pl353-smc.h
> 

I see you remove here a bunch of code. Are the series still fully
bisectable?


Best regards,
Krzysztof
