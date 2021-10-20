Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99E04345A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhJTHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:03:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51098
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhJTHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:03:05 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64F2F40257
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634713250;
        bh=9bjdXHVOrSvIBWOc34yHW9pLuEO40fxL7CkdiqqaGyY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ie9K8/jTBu0b+adN7P1Zup44PFfnjfZkf23OsL6OTF6FW5oebVdR7RXIWYPJaBAU6
         Q3U7WDT5DiSHBEyZRE/pM8bmJmW08MehpD4jLERZIFl2Gicly3U6tq2PCVshSipPJX
         Sfy1AaD5fK9BXWbRAz89wVbMMv4d4Mbbr4Hqn4ccHNeVRgaZ1pE1YlCXZRH4lEFhjB
         N8Jq7Xcjj+wfRsMKwixzuI18u6wTC8Rm78g3z8vALsPJsjOkGLsMJiyuPG4WvSelcq
         1y0F1aquFTO6EnbpcxSMwZC2d4EMevxsE/IBX2w2aV/4y9eNSwieveQREvWO2axCxt
         d9AtMsEC7DIxQ==
Received: by mail-lf1-f70.google.com with SMTP id h8-20020a056512220800b003fdf2283e82so2722088lfu.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bjdXHVOrSvIBWOc34yHW9pLuEO40fxL7CkdiqqaGyY=;
        b=GbJju9Jo7X+gRrsbCLBODb2buuWjiKWTQcik8J2guKvodvcK0v71d4ESXAW1m4Kq1A
         upUHMhEVP4+qp4auJ3P6r1YiC3Y0nYCr3u/PiQsLVxKLt8D4jpXshtXf8JNHh5t7Yqtc
         4buvzRSqpIVIKZgqR+0tQqkEaEPuLtvqUiEmNbe5Zrn53vDE1UKyl/fzVQZB+oO8tgH/
         AIammifKbnUVv6+ufP0pUUWgjCaXtjLPjrp+6idnf8V6GliYiRfOyOrZ14uUbF4PDJNG
         K140OV985F5t6+OgD2tMOlP5aihc83Gi/F9fiwEHL6PuqoAejxYRTdXdcgh5sgUXMkmM
         FgAg==
X-Gm-Message-State: AOAM532o7c/kI1FHPD9p0pO3SPqjeUmQiQzsk/3aL+oc2JBa4JvpeYji
        cRw6qkTNfFlY7q52/q2HC41BT19Qk0ZJiNAu5kHRthXt5+XKbeX8yhL7vAbK0sAG94ozH98rq0x
        IPszpide2DbYo6WQrwaR3BNmObqLhBuv9CfhOiq7x5A==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr10274536lfa.269.1634713249508;
        Wed, 20 Oct 2021 00:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFnuOeJrsLzrbx6D4CBtk/GXOJiTJ5G3/0lCJFHQczwnpGGx59K2hBW6Uu+m127SqlR7eGSw==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr10274504lfa.269.1634713249254;
        Wed, 20 Oct 2021 00:00:49 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id q24sm117882lfr.138.2021.10.20.00.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 00:00:48 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mfd: max77714: Add driver for Maxim MAX77714 PMIC
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211019145919.7327-1-luca@lucaceresoli.net>
 <20211019145919.7327-7-luca@lucaceresoli.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <50ada6b7-44e6-6d4b-6784-405bb86aebbc@canonical.com>
Date:   Wed, 20 Oct 2021 09:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019145919.7327-7-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 16:59, Luca Ceresoli wrote:
> Add a simple driver for the Maxim MAX77714 PMIC, supporting RTC and
> watchdog only.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v2:
>  - fix "watchdog" word in heading comment (Guenter Roeck)
>  - move struct max77714 to .c file (Krzysztof Kozlowski)
>  - change include guard format (Krzysztof Kozlowski)
>  - allow building as a module (Krzysztof Kozlowski)
>  - remove of_match_ptr usage (Krzysztof Kozlowski / lkp)
>    (Reported-by: kernel test robot <lkp@intel.com>)
> ---
>  MAINTAINERS                  |   2 +
>  drivers/mfd/Kconfig          |  14 +++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77714.c       | 165 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77714.h |  60 +++++++++++++
>  5 files changed, 242 insertions(+)
>  create mode 100644 drivers/mfd/max77714.c
>  create mode 100644 include/linux/mfd/max77714.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
