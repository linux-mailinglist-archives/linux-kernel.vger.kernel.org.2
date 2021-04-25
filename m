Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4E36A8CE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDYSUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhDYSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:20:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0B1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 11:19:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ja3so5164531ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qk166Mtr97Uegou75uz10LObRraPNJwyXwP+uE6LyQw=;
        b=IPe6mj81gSuElvbNYDwwcogHPUiaEEHuSJy9quaslWl/dT7MiQqbHhjoEzDh3kA2GZ
         4gYDSo6YoyBA+r7y+WhgBbQkJt1GdEdEI3HqWs/JeBPqrSDH6ppdU33F/+Xgo5MkeNJ6
         Nmsv/bbUkGRUfznUXErRf8mBtlNMkBEauOQAsj403Dwfxh6N5dG1mdFCCuqMzXWo6Zyt
         jS8appOXEPIk2tJbekjlFvY1biZ7FXDpyYWVYfcq+QIfXztP9v2Swu5Gy6WHKXOU/q7j
         Q4P99U19DNfrtkp7CGqxnC2ouzKUh/cGvj1NnN0XBRa/zIkBQSqKnGTvIyRe13mJKdB1
         poqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qk166Mtr97Uegou75uz10LObRraPNJwyXwP+uE6LyQw=;
        b=p0YL2kQFndFANnUmh35qZOOF9xNX9Igj2bsQLmekJQzAq8d/xQJ/7IUDfOCv/nxEiL
         8PbYud0FoiV5ZQA8Z5T5d0gbHmFC/F6fPdKrisBev/1t+k8G5Fr8KYDiCzo7ykiVOYi0
         e8v1UUwokeXfhe4NtJMdT/LrRbYfFum90mORzQ+Vu2tWj18tLcDea+Y86eUHPIikCmlZ
         s3Dz92Vv+KOC16Mr/y5EbIJomBJ0X7ppbboaQedpKJ7gAOQAYkFc0oF5HhdeNJCvn6ZS
         GLNlLpDXZWwyRmx49g//mu8HuNgHNfy2fAGQ9uFOCEj3yfIssCOFausB08HvvVIdpX2n
         xPJA==
X-Gm-Message-State: AOAM531mm63yiqEmhkAxKaAKRGpms8jORTzn9DEHtmUB3zQTC5Ekffnu
        sBpmHkuSpw/nsKp660ummyWhzQ==
X-Google-Smtp-Source: ABdhPJwK336xqeeN0qCMFyS5+HPkdQBoFcU38Q0ElaOFUxrFifDkymZ0bNNyGQL77ZwZpt/Ou59AjQ==
X-Received: by 2002:a17:906:88b:: with SMTP id n11mr14255156eje.26.1619374792417;
        Sun, 25 Apr 2021 11:19:52 -0700 (PDT)
Received: from localhost.localdomain (p200300d9971998009e1ae620ab52a3b7.dip0.t-ipconnect.de. [2003:d9:9719:9800:9e1a:e620:ab52:a3b7])
        by smtp.googlemail.com with ESMTPSA id t14sm9992715ejj.77.2021.04.25.11.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 11:19:52 -0700 (PDT)
Subject: Re: [PATCH 0/1] ipc/util.{c,h}: Use binary search for max_idx
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
References: <20210425075208.11777-1-manfred@colorfullife.com>
 <20210425180729.7ew42ab5ygstbwm4@offworld>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <3b503caa-2f2e-3b9a-e513-342509b668c2@colorfullife.com>
Date:   Sun, 25 Apr 2021 20:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210425180729.7ew42ab5ygstbwm4@offworld>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On 4/25/21 8:07 PM, Davidlohr Bueso wrote:
> On Sun, 25 Apr 2021, Manfred Spraul wrote:
>
>> 2nd version of the patch:
>> @Andrew: Could you add the patch to your mm tree, as candidate for
>> linux-next?
>>
>> Note:
>> I have tried to remove the ids->max_idx cache entirely. Unfortunately,
>> this causes a significant slow-down of semstat(,,IPC_STAT):
>>   * no object allocated, no ipcmni_extended: +50%
>>   * no object allocated, with ipcmni_extended: +80%
>>   * 30 objects allocated, with large gaps, no ipcmni_extended:
>>           +350%
>> Thus I haven't removed ids->max_id.
>
> Right, IPC_STAT is the main usecase for max_id. But I'm not sure why
> you were looking to remove it in the first place - or was it just to
> avoid this patch altogether?
>
I had assumed that after removing the linear search, the lookup would be 
so fast that the cache can be removed entirely.
It would save ~20 lines of code and one int in struct ipc_ids (12 bytes 
per namespace?).

But: My assumption was wrong, the slowdown is too large.

--

     Manfred

