Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED63D939D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhG1QyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1QyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:54:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBC0C061757;
        Wed, 28 Jul 2021 09:54:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d2so1826783qto.6;
        Wed, 28 Jul 2021 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5WRc7NZsG224KMOLzT6MF0xtQDYlQYQ+sE4yZrsGKwI=;
        b=pBbZcC8qkw1M+SzXsZgZ5rDmHtG5kHyuGt7FeWdqYfewy8ozYb23OuFRnZl27Ig3Gq
         8nJRAv0WeA7zY3g96vIf1jKVCOaGmPnwL4AEMbZ3WEWzUXO0v8m7zmMijhJReAkJgK+w
         zIAf0ffeQOEHQDLHuRBs8C0C9Ya1+Y1oPhQqjhYsPGioMYhpwItCppl8GgSVdk/XOH60
         C4teyvrMbxJBXCut4FzlKDhHJT4b+hpnZRxKEd1pUdr3gUTBdpfbQXx8a5Db9wwermez
         FQsIfy7NSl6FJJX0KAXmcKsiqoDjlVAbiT4r9M2yYTp5pZbPzzxTp/iSBy35T3fyCTUX
         sjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5WRc7NZsG224KMOLzT6MF0xtQDYlQYQ+sE4yZrsGKwI=;
        b=B40N3FTHGresIcadDsizX8sY++iqSI0h4XgKKjZkyNpUHljdFrK8ofxjDd1ElB+C5w
         MMnhQSbnmxcBYTxpg/sHp6iSpcTSbJiNbpi3fMGXSz3YlqIAVUd9g1ohotGxr7p8O/Xv
         3Q0YwCaSf+w4p2LgxJWDw2TQhY7DGXPKOU6Hv0WFtq1SJ7n3jCDr1pKS3umWzCRJ3c0N
         Di6z06HSXR+12M/NNRcnE2eGsRNVghM75nBqYgQzq0Dp0mpm1cDyYuTpUwp9Hrjo85Zw
         2RgtemnVVf/Eo7jKAMdIa8dVWgdoH8SnnLIzNJVfo2x9H8wC49oCQMd/fDY9gkMrvMvI
         Vh9w==
X-Gm-Message-State: AOAM532zBGIXda1/1sjECdHeTK11A0yAq/zowEXKRbWF6/ytGIsEePRk
        7qoRHX3S+mmH3FtL+PZhPE4p5jNmw6Y=
X-Google-Smtp-Source: ABdhPJwVA0b4E2zT2rdSCKwbX9fTqBQ5wfZz9pIwBnO5KXoem83v2RNfPRnRMaXGRn7rUPQceKS1Zw==
X-Received: by 2002:a05:622a:283:: with SMTP id z3mr459040qtw.312.1627491258155;
        Wed, 28 Jul 2021 09:54:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17sm169167qtu.34.2021.07.28.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:54:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: Add StarFive JH7100 temperature sensor
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210726171802.1052716-1-kernel@esmil.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bcc9de67-f006-0a81-8c3f-2ae5188dca48@roeck-us.net>
Date:   Wed, 28 Jul 2021 09:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726171802.1052716-1-kernel@esmil.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 10:18 AM, Emil Renner Berthing wrote:
> This adds a driver for the temperature sensor on the JH7100, a RISC-V
> SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
> JH7110 version.
> 
> The SoC is used on the BeagleV Starlight board:
> https://github.com/beagleboard/beaglev-starlight
> 
> Support for this SoC is not yet upstreamed, but is actively worked on,
> so it should only be a matter of time before that happens.
> 

Hmm, makes me wonder if I should apply the series now or later,
when the chip is actually supported by the kernel. Comments/thoughts ?

Guenter

> v3:
> * Handle timeouts from wait_for_completion_interruptible_timeout
>    properly.
> 
> v2:
> * Fix checkpatch.pl --strict warnings
>    - Add myself to MAINTAINERS
>    - Fix multiline comments
>    - Use proper case and whitespace for #defines
>    - Add comment to sfctemp::lock mutex.
> * Remaining comments by Guenter Roeck
>    - Add Documentation/hwmon/sfctemp.rst
>    - Use devm_add_action() and devm_hwmon_device_register_with_info()
>      instead of a driver .remove function.
>    - Don't do test conversion at probe time.
>    - #include <linux/io.h>
>    - Remove unused #defines
>    - Use int return variable in sfctemp_convert().
> * Add Samin's Signed-off-by to patch 2/2
> 
> Emil Renner Berthing (2):
>    dt-bindings: hwmon: add starfive,jh7100-temp bindings
>    hwmon: (sfctemp) Add StarFive JH7100 temperature sensor
> 
>   .../bindings/hwmon/starfive,jh7100-temp.yaml  |  43 +++
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/sfctemp.rst               |  32 ++
>   MAINTAINERS                                   |   8 +
>   drivers/hwmon/Kconfig                         |  10 +
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/sfctemp.c                       | 291 ++++++++++++++++++
>   7 files changed, 386 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
>   create mode 100644 Documentation/hwmon/sfctemp.rst
>   create mode 100644 drivers/hwmon/sfctemp.c
> 

