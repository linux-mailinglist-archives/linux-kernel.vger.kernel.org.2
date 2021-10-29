Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDD43F883
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhJ2IHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:07:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39494
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhJ2IHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:07:17 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D41913F190
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635494688;
        bh=gORZX0yVzoq2Pz3qmNV7v4k3dxqbLEeJY96EVFHtvGw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ERtWDP61cuauom36zc0DovRS+G/4rmwPGjl3ZtjUm3vvSsuy41csvlnY+67FEfX9w
         oRtfc1jCNjjpH2uV8RI5sNSj9kgmakjHc+6h+cAww08n89Izz4F4xrvAVbhiN3u3ED
         JInrHFqpqOwzTXO2pHtPLW6c1tfynoy1UGnDL+VETHGxFtUmjbDJMSmNZR8KkN4AGd
         m5xFN3locVXivfC+ONQRtXmeAKfxrTRmnjyu/Xqrp3kKPqqlfAVjwW7dB9nsWzJgy6
         eRg+qho6RoDXqjFcn+LD4I0Z5jf3bINBuWObSY4dB0nBk6RYKn6ziGFU7hzSXwZq+Z
         dsPorw2JibR3g==
Received: by mail-lf1-f70.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so3846093lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gORZX0yVzoq2Pz3qmNV7v4k3dxqbLEeJY96EVFHtvGw=;
        b=rULIoVFvV7weBRvUMF2yH4Z8oHgSFPnbK09RrH1mBZ2usr0aix0/dhAv534fDW1qAV
         QoVwnY1AEaStSmb8BHfjeN6iWJZVGNBqGtJ4qD75qAUPmk/Dv5YLZcdqKZC1f6BCc5P5
         IHSvbBkENT8dfjDEElVZGkaajNl6aDHMCzyXdy8aZMvjtp38DKFsE7BQkg0FQVhUTvLW
         47Fs7Lh8SfDx1Htx9sKS+pebehIokjUS1PA+WHZCAwlorjFjQKsskugXV2uYEG1SKkzC
         YR+jHaoa3uHU6OjIOa563WDyjhYtHL3GcKGeDBGNdxWn9qAJUE0Cfg1dOL7kRM7uRmVm
         1mIg==
X-Gm-Message-State: AOAM5305N/5r7uWHbpvgNc3V+UPsUg2VnC/6sFeBjS4KR75JSr8wF3fo
        RBh1jaji5CslpDCoalEdA8yI4GOHSuPkl443yMLajuPplUI/KKu2lesoqbpXBIFNeElliDiTsBO
        7nU1faNPuPL5nsdlVnL+3TqrUT6DK4hkqKMrg9Qk56w==
X-Received: by 2002:a05:6512:114f:: with SMTP id m15mr9740358lfg.140.1635494688392;
        Fri, 29 Oct 2021 01:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbyLMzs+ms2kQOLdOYd2/yiv+HtnDZo2M293OptXi22K4l4nItsFMCPCA4hNH+rhY4cNTzlw==
X-Received: by 2002:a05:6512:114f:: with SMTP id m15mr9740342lfg.140.1635494688236;
        Fri, 29 Oct 2021 01:04:48 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c24sm537891lfc.155.2021.10.29.01.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 01:04:47 -0700 (PDT)
Subject: Re: [PATCH 3/7] watchdog: s3c2410: Make reset disable optional
To:     Guenter Roeck <linux@roeck-us.net>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
 <20211028183527.3050-4-semen.protsenko@linaro.org>
 <b9c33def-6b12-1e5a-4449-b1e0869a0e3a@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2a5ff8d0-c665-e25e-cb40-51326db2e26a@canonical.com>
Date:   Fri, 29 Oct 2021 10:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b9c33def-6b12-1e5a-4449-b1e0869a0e3a@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2021 02:16, Guenter Roeck wrote:
> On 10/28/21 11:35 AM, Sam Protsenko wrote:
>> Not all SoCs have AUTOMATIC_WDT_RESET_DISABLE register, examples are
>> Exynos850 and Exynos9. On such chips reset disable register shouldn't be
>> accessed. Provide a way to avoid handling that register. This is done by
>> introducing separate callbacks to driver data structure: one for reset
>> disable register, and one for mask reset register. Now those callbacks
>> can be checked and called only when those were set in driver data.
>>
>> This commit doesn't bring any functional change to existing devices, but
>> merely provides an infrastructure for upcoming chips support.
>>
> 
> That doesn't explain why the callbacks are needed instead of additional
> feature flags.
> 

Or why not skipping the disable operations if disable_reg is not provided?


Best regards,
Krzysztof
