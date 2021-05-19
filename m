Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A21388FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbhESN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbhESN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:57:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD43C06175F;
        Wed, 19 May 2021 06:55:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ez19so6805204qvb.3;
        Wed, 19 May 2021 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3f+yTG1Y43kyfn2gz9Nshdtvq1qpcwEyoAHthUpllhg=;
        b=ujTnxy267R79o8tloOi8yakaiUosC+EyZRv9R+qxb7UAz5a/X8Q0yUIcFxqASwneM8
         Ajk2luWDZiVEAER2DhmHmIzGxMgAKoV6UXE746NyP/KWP1ah3mU2j5dZB/97BqdPtCvZ
         67m7GO5uISJ5FbAdueXoy1C2KvYzdkBNFZo7P8jx+VOLuDzPH3LzRjgwDGeBGH81q6/d
         JczRMboPi+53BOFljX0hLQxJV+ZcaVGzfgTVrmL7SV2zfXGWkKSBj+yCkCN6EZKI5W0A
         TBiigQ9HUQ0Ap3xWBQE7zjlCpIuG1CvlWqMsIXuzEcOzpCoi6dWvXE2U+AjC7aS/XSR+
         DULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3f+yTG1Y43kyfn2gz9Nshdtvq1qpcwEyoAHthUpllhg=;
        b=h6fsxKuwVnCWbcxmw93+bJf7VpQb+BFixwbVEK9zh4V7Sn3Rn0fflhFUuEGIm6rnmi
         mq92bsb5mq7U2a6NW6f2BnSqh0QCV4vXwKUvOpdjGIjmaPeOP2SBFgLkoRvUUM1hp8w9
         xiphulaDXWbhv0HCbHesFcf6cU7kXWIL3NFJgTsMKQ3uGRWR4UnPQgq6y8eZu5bjecJX
         J6sFRYQcnCeYvPDCpQ4G13cCGnEyKWZ53+y6GabKSXfw8TBuOq1Q1zzzmvn3vRRN1hX7
         yRzq3mUgm9oG9jdED/r+7aI3H0JRyaD7VZxUWWJ5gU+Q2W3no9k7PvlYaPL9ippKvapy
         6e4Q==
X-Gm-Message-State: AOAM531NrkkmhMWzQPM0Q9CPjFGNE30du2AE90CvMo93YXJLdubNfpM0
        dXHD0TEr5O6S+BNltNnkldXNVVAjUBM=
X-Google-Smtp-Source: ABdhPJyQtQyTdrZI/o7HM9Fsco/QYrd5AxeKNDK8sg6l83t+4/wOmbr+1BaBLDiE0yzf4TsrY6NY5A==
X-Received: by 2002:a0c:f294:: with SMTP id k20mr13602522qvl.45.1621432544634;
        Wed, 19 May 2021 06:55:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18sm14707875qkx.118.2021.05.19.06.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:55:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat@cesnet.cz>
Cc:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210518211609.GA3532746@roeck-us.net>
 <6f256c72-df4d-4f9a-ba5f-eabfd9f2365f@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Message-ID: <76619e11-3999-1e89-de93-fb5942970844@roeck-us.net>
Date:   Wed, 19 May 2021 06:55:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6f256c72-df4d-4f9a-ba5f-eabfd9f2365f@cesnet.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 2:10 AM, Jan Kundrát wrote:
>> As it turns out, even the current code doesn't really work for fans 7..12.
>>         sr = get_tach_period(data->fan_dynamics[channel]);
>> However, the data->fan_dynamics array has only 6 entries, not 12, so
>> reading fan[7-12]_input will result in bad/random values.
> 
> Hi Guenter, I'm Vaclav's colleague. The chip can indeed reconfigure each PWMOUT pin either as a PWM output or as a TACH input, but that's not something that's correctly implemented in the current code, and we have no use for that either (and we cannot test that on our PCBs easily, we do not have the manufacturer's eval kit).
> 
> It looks to me that the original bug is that the current docs mention 12 fan inputs. Would you be OK with a patch series which fixes the docs so that the chip always exports 6 TACH inputs and 6 PWMOUT channels?
> 
That would not be appropriate. The chip does support 12 fan inputs,
so that is not a bug. Its support has a bug, and the datasheet is kind
of vague when it comes to details, but that doesn't mean we can just
remove its support.

I see two bugs in the current code:
- pwm values should be read from the duty cycle registers,
   not from the target duty cycle registers.
- fan[1-12]_input needs to use a correct divider value.
   Unfortunately the datasheet is a bit vague when it comes
   to deciding which divider value to use, so the best we can
   do is going to use the values from fan[1-6].

Fixing this will require two patches, which should come first.
Let me know if you want to do that; if not I'll write patches
in the next few days.

As for fan[7-12]_enable, I don't even know if those can be enabled
separately. I see two options: Drop those attributes entirely (
assuming that those fan inputs are always enabled if the associated
pins are configured as inputs), or align them with fan[1-6]_enable.

Guenter
