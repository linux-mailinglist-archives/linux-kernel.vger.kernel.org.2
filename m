Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0240F3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbhIQIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:10:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45716
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245297AbhIQIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:10:08 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55C6A3F4B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631866121;
        bh=JQ215WaV0fJ7lfFcgk3AWKxJPWvRWqz6N9EycVhPbcY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=LFFaWduhuyjBG4guzjDyIWPP5P3V2eVIOdkFJLFiPEf/WjKDD3YYGWPW2ESIeDd+3
         3//eDDOOKvJrH2ClE6OjLUmbVdc9PPPa1zjCclB6xEmQNO4FygfnOfW87UJ4jKsU0M
         KoodVWUphgeR4mxFA6bqFKM+12+/KfWz6WiEnRXUvaHj08kE13kchMdV16ch/iM2vl
         NJAkoShT6ATcOd1k2V3aBecPB0FBCUsvNznDP4vY44iQCsLenQuzM3tET8GCbpMU5j
         kihACZFcJ6qC8e3GvDZHL/mrrTgOnN6qbjwf4iChqEYki9DD3snFQ618sp5pgbctpn
         n/uHqnALYsBjw==
Received: by mail-wm1-f70.google.com with SMTP id l27-20020a05600c1d1b00b00308ef9d8a98so2762127wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQ215WaV0fJ7lfFcgk3AWKxJPWvRWqz6N9EycVhPbcY=;
        b=De7lQiCxK+IWiTCZIuSfG+Qctm6btVLP7mEFdTkbe4F6x3u9EzxwyHdHthoAL7evln
         mJtgHYorEKYKKHneSXZpVvXM4Lo1mBMDScCuROI+OOxfq3MHMDD/VXGZm+PuHVoNXxnI
         aDISrouAgshlEAK4jWT9Ag2oeZHL2mEjFVWfFTv5/r1gdd09tOtN835UEV0uVGTG/Ig6
         3LJ9bXSYAWqTeDIa51JM7dnejlwR4Oc+6XItg98qJkQA365lAKy63Z7WW96a7hQ0oe/n
         NeGRnUgrIB46vz2QUNUwQJ0iNlEQLiy4KBFJdmLwhrHXS1cC9C8YOV6hPyX6EfI2mTW4
         vsFw==
X-Gm-Message-State: AOAM532T+Gd4oztocYNm0VsjciguPbtp9cdSwT2D3EH4oxEp3xY2oi//
        N/Po7zUHbj3agLrDeHH83NK3BDr2JExan9B7UP2sdm8tMXztz7W18oBG0VZe0Lcu1UK5lZtXDN3
        A9VK+v7+MTI+TeH5YZRU/I0iF+clgzqZaqkgmueJHPA==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr4972407wmi.37.1631866120596;
        Fri, 17 Sep 2021 01:08:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybmvG2ZP2OSs0SKxy2scM8q/zXOVZb7078WFLVPQlesnpGevmBfMU/lFv3k/VB/mjPb4gKRw==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr4972392wmi.37.1631866120465;
        Fri, 17 Sep 2021 01:08:40 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id y6sm5726381wrp.46.2021.09.17.01.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 01:08:40 -0700 (PDT)
Subject: Re: [PATCH] Input: ads7846 - Make use of the helper function
 dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916153104.13727-1-caihuoqing@baidu.com>
 <922265b2-bed7-8daa-3132-8cfc3b5e50fd@canonical.com>
 <20210917022910.GA17584@LAPTOP-UKSR4ENP.internal.baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <157cce4f-6a8c-bf53-3790-ea43d5662f7f@canonical.com>
Date:   Fri, 17 Sep 2021 10:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917022910.GA17584@LAPTOP-UKSR4ENP.internal.baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2021 04:29, Cai Huoqing wrote:
> On 16 9月 21 21:34:26, Krzysztof Kozlowski wrote:
>> On 16/09/2021 17:31, Cai Huoqing wrote:
>>> When possible use dev_err_probe help to properly deal with the
>>> PROBE_DEFER error, the benefit is that DEFER issue will be logged
>>> in the devices_deferred debugfs file.
>>> Using dev_err_probe() can reduce code size, and the error value
>>> gets printed.
>>>
>>> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>>> ---
>>>  drivers/input/touchscreen/ads7846.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> You sent 32 independent patches. Do you expect us to copy-paste similar
>> feedback on each of them? This would not make any sense. Please organize
>> all your submissions in a series with:
>>
>>   git format-patch -32
>>   git send-email ..... 00*
> Ok, I'll try. but there are different owners for touchscreen/xxx,
> is it ok to send them the whole series?

I see the same maintainers:
Dmitry Torokhov + linux-input

HWMON also appears because of usage of hwmon API inside, which might
happen anyway for few other input drivers

Best regards,
Krzysztof
