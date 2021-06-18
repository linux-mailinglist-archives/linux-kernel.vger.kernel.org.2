Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724EE3AC699
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFRI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFRI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:57:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B879C061574;
        Fri, 18 Jun 2021 01:55:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so15448603lfj.1;
        Fri, 18 Jun 2021 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TR3LSe08B0VZmXwtt0SjL4NzG7xNJ6GN5RaZ0JtqwcA=;
        b=HAeUlIUKPOtNKpZMhU+cRl5gKW5NrNADPv6br7SCGp7hz7tIt7fa0r3jOF+92iAHsX
         tT2g4lOYfaZupd6EnW3q9Q9JwajYFcgJzRWfFFishNDzAqF5OXG1CZkJv+drbnmXnKvX
         ht7crdYDjLNlRy2U7QwqB+y9rmivDWUgZyiMovoGWgi9eVIIeBn0BSMExk1Ec0TXawWu
         TAqGy1jIje+MIxJW3uv+v1JCm3WhWqcEnEU2vblkBolUtx6cUGAixNvx9m/touRA9vH8
         p9oLy7jMxqpY3D3/UvoAy0QF05ek3g5XzwzQ75eO8LDmuJPfL9QsxFBZjIEclb20Y/5M
         6fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR3LSe08B0VZmXwtt0SjL4NzG7xNJ6GN5RaZ0JtqwcA=;
        b=Pnl3WIApn56iO6MokONP9XzqW1LLX73apnLx/0SXbTW72vYDY8EZcIRO3RjHLKE0Mj
         IfoZrtx5BqieOZT98yWoeGzAVHrpx77TVyMspwLUpHNWuziW4XYoSnk5u3bEk+/Jzv8R
         74SksBSDEZuWUxVl5xhwKKC56kFeknmF0TMrd8/ajk3k4YUB4KEruWrQYV8Es4n1NLem
         AoiF2BRWaMkCfjhJEQeYEs3mHtrjpttS6jt9vDBNjnQ9+iLE6LPfkdfI9F6BRPawD8AK
         tBOQ5ZW4DU8JDVfwLjwEHU/n62d0cU2v6+0e8a0mm8fh5RFdxecI/WiBG9Su3XXz4d92
         +BHg==
X-Gm-Message-State: AOAM533yTEd2+DvdsiibRSl1LN1cvWwVbK1AbsGXp+RuiIGRlMed0voI
        uju/2SiJIy22dpNOE7OdZcnbkrT8Y0w=
X-Google-Smtp-Source: ABdhPJz8rtgCFRtt+wfhGtROJ0K3MkUy11ftbc2yESqeulQRkqFGxj6GrcOLdsGbFjr+3q0xsyINbg==
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr2367542lfb.165.1624006514654;
        Fri, 18 Jun 2021 01:55:14 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id q7sm726736ljm.139.2021.06.18.01.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:55:14 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
 <20210617141300.GA1366442@roeck-us.net>
 <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
 <20210617151236.GB2676642@roeck-us.net>
 <b97e3a75-f1aa-95a4-187d-97dc95e57e2b@gmail.com>
 <20210617214257.GD2244035@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ae32e69-1d2f-f75b-ad86-10eac15606df@gmail.com>
Date:   Fri, 18 Jun 2021 11:55:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617214257.GD2244035@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2021 00:42, Guenter Roeck пишет:
> On Thu, Jun 17, 2021 at 06:27:50PM +0300, Dmitry Osipenko wrote:
>> 17.06.2021 18:12, Guenter Roeck пишет:
>>>> For now I see that the rising edge isn't needed, the TEMP_ALERT goes
>>>> HIGH by itself when temperature backs to normal. But I will try to
>>>> double check.
>>>>
>>> The point is that a sysfs event should be sent to userspace on both
>>> edges, not only when an alarm is raised. But, you are correct,
>>> IRQ_TYPE_EDGE_RISING is currently not needed since sysfs events
>>> are not generated.
>>
>> Ok, thank you for the clarification.
>>
>>>>> Anyway, the tegra30 dts files in the upstream kernel either use
>>>>> IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
>>>>> in the upstream kernel has no interrupt configured (and coincidentally
>>>>> it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?
>>>> I have a patch that will add the interrupt property, it's stashed
>>>> locally for the next kernel release.
>>>>
>>>> IIUC, it's not only the Tegra30 dts, but all the TegraXXX boards that
>>>> use IRQ_TYPE_LEVEL_LOW are in the same position.
>>> I still don't see a IRQ_TYPE_LEVEL_HIGH, though.
>>
>> Could you please clarify why you're looking for HIGH and not for LOW?
>> The TEMP_ALERT is active-low.
> 
> Because you stated earlier:
> 
> "... cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH ..."
>                                              ^^^^^^^^^^^^^^^^^^^

That was a typo, my bad.
