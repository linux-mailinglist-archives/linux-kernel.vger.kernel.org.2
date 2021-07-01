Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBD3B984B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGAVqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:46:05 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53802C061764;
        Thu,  1 Jul 2021 14:43:33 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so1974291oos.1;
        Thu, 01 Jul 2021 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K75TMc833Hnb3K5ewk2HbYnNKfUBgfQkkOxc24B6DT4=;
        b=vRn3yfZ8+4E3qWPjdUGgXR4HGXqqJ/qUjMGAP90AWTjVl4wnA56aTtxKvjPBaEblBR
         Es4GusU8pQmCTnG+WX/Mv/E7S101G3hjV3ItxdZxBH0LhD4o7soKHJ7teiB3E+MyjehB
         sHs+E6RqYyy3k9Xzm5G6UnHs6Cz/TREKSRYXsh/36rgR96RDs03QvZla92C+7hYDtiP9
         65QR7z5S5HoTdKgGs1UzU+b0UJmPX5YLdE6J8Hq6BHuI4A1dcujApZaYwvdQ/7xIACzN
         LLJB/MNz4gmQux0TLWXkhjUgvmQTNzkNqwYzDMyyfV6y0VjFv81B9jrN+dos290NIzX7
         WXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K75TMc833Hnb3K5ewk2HbYnNKfUBgfQkkOxc24B6DT4=;
        b=K1k/KdBJlq1dc3EpzkKxhVkRf53gGXjtUpys6Dyt/zlL8t6CQEYObv6PoVWDRo73/O
         WUmDQFTrKee+N4Ij1oIpDIZFaEDv5hATeM0nY+vQKsy9KPz4Xoc/0d6WIYQz0sMuM94z
         z7XmjdOl1der4+QSIKIiIAgNE/PofwD4fyWcUzi+kOXYABS3hfbTMdIsd1QAA/qlzqEX
         UWqFpeJs2atCRVBcPA9N1CHiGBQ81Vqku/OIG5pojxGB0JFzsEcrk83rI0R88j8tayT2
         VqW1GWWfzs9/8sRWlbZnj3g8ml3HdjFSysA99wCC9I5uP09xVa1fP3C8XmHNGcj3tGt4
         7iLw==
X-Gm-Message-State: AOAM532jSDfbEauaZTPDk2akzf6Jr4s4CByYTfJqDpr5ZK3yz10LGEb9
        IVSiIAiwHQX2a7yRxp75q9o=
X-Google-Smtp-Source: ABdhPJzIRrjoijEn1koxIO+9bmtEXdAF29WNwuReepWnxaWoHI0uNMwp+/TA2WeEqF2v5v+xIFiLXw==
X-Received: by 2002:a4a:8241:: with SMTP id t1mr1609090oog.13.1625175812601;
        Thu, 01 Jul 2021 14:43:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18sm252459oiw.27.2021.07.01.14.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 14:43:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
 <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
 <20210701202540.GA1085600@roeck-us.net>
 <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7a06cfaf-4cae-5c4c-edff-16d6406a1b6c@roeck-us.net>
Date:   Thu, 1 Jul 2021 14:43:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/21 1:57 PM, Martin Blumenstingl wrote:
> Hi Guenter,
> 
> On Thu, Jul 1, 2021 at 10:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> [...]
>> [    0.000000] [<c07be330>] (clk_core_determine_round_nolock) from [<c07c5480>] (clk_core_set_rate_nolock+0x184/0x294)
>> [    0.000000] [<c07c5480>] (clk_core_set_rate_nolock) from [<c07c55c0>] (clk_set_rate+0x30/0x64)
>> [    0.000000] [<c07c55c0>] (clk_set_rate) from [<c163c310>] (imx6ul_clocks_init+0x2798/0x2a44)
>> [    0.000000] [<c163c310>] (imx6ul_clocks_init) from [<c162a4e4>] (of_clk_init+0x180/0x26c)
>> [    0.000000] [<c162a4e4>] (of_clk_init) from [<c1604d34>] (time_init+0x20/0x30)
>> [    0.000000] [<c1604d34>] (time_init) from [<c1600e0c>] (start_kernel+0x4c8/0x6cc)
>> [    0.000000] [<c1600e0c>] (start_kernel) from [<00000000>] (0x0)
>> [    0.000000] Code: bad PC value
>> [    0.000000] ---[ end trace 7009a0f298fd39e9 ]---
>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>>
>> Bisct points to this patch as culprit. Reverting it fixes the problem.
> sorry for breaking imx6 - and at the same time: thanks for reporting this!
> 
> Do you have some additional information about this crash (which clock
> this relates to, file and line number, etc.)?
> I am struggling to understand the cause of this NULL dereference
> My patch doesn't change the clk_core_determine_round_nolock()
> implementation and the new determine_rate code-path (inside that
> function) doesn't seem to be more fragile in terms of NULL values
> compared to the round_rate code-path.
> Instead I think it's more likely that the problem is somewhere within
> clk_divider_determine_rate() (or in any helper function it uses), but
> that doesn't show up in the trace
> 
> I don't have any imx6 board myself and so far I am unable to reproduce
> this crash on any hardware I have.
> However, if it's a problem in my clk-divider.c changes then I'd like
> to find the cause (ASAP) because possibly more SoCs may be broken...
> 

I don't have such a board either. The problem shows up in my qemu boot tests. See
https://kerneltests.org/builders/qemu-arm-v7-next/builds/38/steps/qemubuildcommand/logs/stdio
for an example. The problem reproduces with qemu's mcimx6ul-evk and sabrelite
emulations.

Guenter
