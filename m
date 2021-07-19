Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2743CD72C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhGSOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbhGSOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:09:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65356C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:18:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d12so16711975pfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B2nzWA43SctfqP1ezHeTfan06KfDKnUBR++2X2af3Gw=;
        b=k+YOkWKVK04qEvZ7AKLWBw5Ds+C57Bfyows/xXAnoc/eKY1AMXvJAveZT0N1gryE/g
         f8ZEphAOk5uXp/ZRhDyOSXrPv/1jP47b880We+EupRmaIa3Z36JgL8MCSaZ2Hxo8mKCP
         TNVuaiV9kXyVlni6kC/Nvt3SWQ09lax2g1yuJWQvNqLs5agKkLwEUGNX066oDtBBirg9
         HTtnykKZEFTSFSndrRRYsPlz7yOLzunVkVdLjVaiau7BjhduGnQE4vexisIQYXJ+EhCy
         EVa25z+rhOaJ9SG8G+aFxFlML0ZYpjHB4+W9viKxy9mM3WXLzbJkjs8aCFDjbbZ3yXIT
         AiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2nzWA43SctfqP1ezHeTfan06KfDKnUBR++2X2af3Gw=;
        b=uGrnNQEu4tyW/gOjSxrCUvLMW2A51FWPjyJj10TR04Pek8uwmgsOC7UvI8kwr6eIe5
         q0nP+YSjtRytIEN49o8rk7tskZbVESHsrmXDKrUt6saiEXUlqme2aJjZrq5pIO5lW4Cu
         Xr8NxmR7TyERnfmz/nW3WK4+FDRKvZYgViHtUt550WsDwmAUHiitMUi9uMX0TVlRmOP7
         C9rqfMsds2lTRqhXhp/Q+D43qFiTKcHX1zqctC0SwipGALsN/A/m3jQr07Kc9TU6PvWz
         ji1r03tYW43ngP1ZPwLK+Rg/eF5VTONVsEDrsmLRTXQxK+efOlAWb2QqCt4jkY9yoFLK
         brMg==
X-Gm-Message-State: AOAM532UZwA22HOe0MR/ej70+6kWSt4BcfywTZG+a3sf5dBC4fEJ8beW
        ZPoQ7FFdqzCQ+7b+vNu6F24ETwAhMHo=
X-Google-Smtp-Source: ABdhPJxc7fHduUTAef7dKUoDC71acywe90tKbLmnGKCav/9cta3aM5e7ckVLjCVYAqWJxRDM6xThmQ==
X-Received: by 2002:a63:1266:: with SMTP id 38mr26190909pgs.154.1626706197950;
        Mon, 19 Jul 2021 07:49:57 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id gb10sm20161764pjb.43.2021.07.19.07.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:49:57 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
 <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
 <e1bb4768-5517-8ef3-eaf3-bbfc103fa918@gmail.com>
 <9a2bf544-2aaa-d175-bc0a-c8bcefd8141a@roeck-us.net>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <718c5a83-de9f-3b5a-ef36-e52ad5bb4d67@gmail.com>
Date:   Mon, 19 Jul 2021 23:49:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9a2bf544-2aaa-d175-bc0a-c8bcefd8141a@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2021 11:24 PM, Guenter Roeck wrote:
> On 7/19/21 7:00 AM, Akira Tsukamoto wrote:
>>
>> On 7/19/2021 10:51 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
>>>>
>>>> This patch will reduce cpu usage dramatically in kernel space especially
>>>> for application which use sys-call with large buffer size, such as
>>>> network applications. The main reason behind this is that every
>>>> unaligned memory access will raise exceptions and switch between s-mode
>>>> and m-mode causing large overhead.
>>>>
>>>
>>> I had to revert the original patch from the mainline kernel prior to applying
>>> this patch. Obviously that means that there may be other changes affecting the
>>> outcome.
>>>
>>> riscv64 images work, but riscv32 images still fail with this patch applied.
>>> The error is a bit different than before, though.
>>>
>>> ...
>>> [   11.899979] Run /sbin/init as init process
>>> [   12.152666] random: fast init done
>>> moun: applet not found
>>> "�����V�t: applet not found
>>> /bi�����V�F-: applet not found
>>> moun: applet not found
>>> swaon: applet not found
>>> hostname-F: applet not found
>>>
>>> After this, the image hangs.
>>>
>>> For comparison, the mainline kernel (v5.14-rc2) fails as follows.
>>>
>>> [   10.788105] Run /sbin/init as init process
>>> Starting syslogd: OK
>>> Starting klogd: OK
>>> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
>>> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
>>> Starting network: /bin/sh: syntax error: unterminated quoted string
>>> sed: unmatched '/'
>>> /bin/sh: syntax error: unterminated quoted string
>>> FAIL
>>> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
>>>
>>> I'll be happy to provide information on how to reproduce the problem
>>> if needed. Please let me know.
>>
>> Yes, I do would like to know the procedure of build instruction of your rv32 image.
>> Then I would reproduce the error and look into how to fix it.
>>
> Please have a look at http://server.roeck-us.net/qemu/riscv32/
> and let me know if you need anything else.

Thanks for the link. I will work on it tomorrow in my time.
Building the kernel with defconfig looks much quicker than the config.
I will try it from defconfig and then config.

Also I would like to use the same rv32 toolchain. Are you using prebuilt
riscv32-linux-gcc? Should not make differences but just in case.

Is there a public reference for the way of building your qemu and opensbi?
Not sure which version of qemu with which rv32 to build them, rv32i, rv32imad or else.

I really appreciate your help.

Akira
