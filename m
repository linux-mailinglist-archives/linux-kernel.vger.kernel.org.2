Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A573CE375
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbhGSPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbhGSO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:59:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D7C06A01F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:47:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o2-20020a0568200402b0290258a7ff4058so2416254oou.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=asQrWP/KNFhAup0eq5AJmEotdNpzwTXJeOEaFS3um+E=;
        b=GjUpvRa856+70k+PCoIP+G1edhPmUfXWAXbNAw4Le//f3H8Sg8ZVD6Vk/1oh34B5Ip
         ntJfMKpU0Jwt50Ipt9ua/4AwzNu07xcbwWD+pW1r48RXXd+Krl6SjQ82yzuYLb6rkOMp
         mWu5Y4x1e4qJdCFeB9Y11QsJlc6rNM/4dCw1lrSLTZF+U8rmSE2wVbkmVkShBjEgbQ7Q
         F71Ir7+CvFUvhLV5aFZt130p76gywCod7Jmpjx4sIESxmRlbF4FHU4vbE6Y7ziKi1nb7
         59VLM7nBBJvsnfT188Rrl5WHVnzQyPk+VMLFrowPhPOfBi9fR+MdcWW4nZwexT5MvYkl
         qz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=asQrWP/KNFhAup0eq5AJmEotdNpzwTXJeOEaFS3um+E=;
        b=l5pH7wc/JgjKGty8Cuex2hOr/XRWt7TToiN2JJfVN7B2bG1paHjMu5/T3jt1UzYFMp
         dGrYxlyx2x0pRt2bb3aeDI8bji/+/FXEb0fyP8rv3wERR6BVrkJaDjyy8osxDUs03ioS
         qa4rCPmt4BEJ8NYgI0hI4k3cynTKZiMiVUblOBYrOMPTsoo4gvE1tTMLCgsh7xg3h91j
         gM8mi1yZx1NVHBVSJ1t/aBBeHdvh2xsX/Sb/w7ma6tTqnGxF9UV2M453uZQIc0B1RvPs
         jBzYmR9gfPVwxQ28LqDguw3+O6at1gFpE1XertoKPL5ENYwPlaI+Lv1uf4hS3DS6mmiZ
         1S4Q==
X-Gm-Message-State: AOAM533xCiuLcmztYwIUrZxz3rmKO/RfYlbFkr3Liqvxsu91MLnC3kYE
        rufHvzFXIa1ILujEvsj4xAexh+9k/Io=
X-Google-Smtp-Source: ABdhPJwM8tnUCPUm4QK+QMwwokqcmNwqIwJMF1deabKfedDEvAFtL3xiNUtjYbHjsvXY67zKj6ZA0g==
X-Received: by 2002:a4a:9406:: with SMTP id h6mr17804555ooi.36.1626707815145;
        Mon, 19 Jul 2021 08:16:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2sm3776717oij.45.2021.07.19.08.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:16:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
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
 <718c5a83-de9f-3b5a-ef36-e52ad5bb4d67@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
Message-ID: <c19f05f0-985e-ca6e-7cfc-af5c69e155fd@roeck-us.net>
Date:   Mon, 19 Jul 2021 08:16:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <718c5a83-de9f-3b5a-ef36-e52ad5bb4d67@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 7:49 AM, Akira Tsukamoto wrote:
> 
> On 7/19/2021 11:24 PM, Guenter Roeck wrote:
>> On 7/19/21 7:00 AM, Akira Tsukamoto wrote:
>>>
>>> On 7/19/2021 10:51 PM, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
>>>>>
>>>>> This patch will reduce cpu usage dramatically in kernel space especially
>>>>> for application which use sys-call with large buffer size, such as
>>>>> network applications. The main reason behind this is that every
>>>>> unaligned memory access will raise exceptions and switch between s-mode
>>>>> and m-mode causing large overhead.
>>>>>
>>>>
>>>> I had to revert the original patch from the mainline kernel prior to applying
>>>> this patch. Obviously that means that there may be other changes affecting the
>>>> outcome.
>>>>
>>>> riscv64 images work, but riscv32 images still fail with this patch applied.
>>>> The error is a bit different than before, though.
>>>>
>>>> ...
>>>> [   11.899979] Run /sbin/init as init process
>>>> [   12.152666] random: fast init done
>>>> moun: applet not found
>>>> "�����V�t: applet not found
>>>> /bi�����V�F-: applet not found
>>>> moun: applet not found
>>>> swaon: applet not found
>>>> hostname-F: applet not found
>>>>
>>>> After this, the image hangs.
>>>>
>>>> For comparison, the mainline kernel (v5.14-rc2) fails as follows.
>>>>
>>>> [   10.788105] Run /sbin/init as init process
>>>> Starting syslogd: OK
>>>> Starting klogd: OK
>>>> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
>>>> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
>>>> Starting network: /bin/sh: syntax error: unterminated quoted string
>>>> sed: unmatched '/'
>>>> /bin/sh: syntax error: unterminated quoted string
>>>> FAIL
>>>> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
>>>>
>>>> I'll be happy to provide information on how to reproduce the problem
>>>> if needed. Please let me know.
>>>
>>> Yes, I do would like to know the procedure of build instruction of your rv32 image.
>>> Then I would reproduce the error and look into how to fix it.
>>>
>> Please have a look at http://server.roeck-us.net/qemu/riscv32/
>> and let me know if you need anything else.
> 
> Thanks for the link. I will work on it tomorrow in my time.
> Building the kernel with defconfig looks much quicker than the config.
> I will try it from defconfig and then config.
> 
> Also I would like to use the same rv32 toolchain. Are you using prebuilt
> riscv32-linux-gcc? Should not make differences but just in case.
> 

I use a toolchain built with either buildroot (when building the root file system)
or with the buildall scripts from https://github.com/jmesmon/buildall.git
(for the kernel). Either case, it is the default riscv32 toolchain from both.

> Is there a public reference for the way of building your qemu and opensbi?
> Not sure which version of qemu with which rv32 to build them, rv32i, rv32imad or else.

I don't know about rv32i or rv32imad, sorry. I build qemu from source using
	--disable-user --disable-gnutls --disable-docs \
         --disable-nettle --disable-gcrypt --disable-vnc-png \
         --disable-xen --disable-xen-pci-passthrough \
         --disable-libssh
configuration options. The firmware image (opensbi) is built as part of that.
You should be able to use a pre-built version of qemu v6.0 if that is available
somewhere.

Hope this helps,
Guenter
