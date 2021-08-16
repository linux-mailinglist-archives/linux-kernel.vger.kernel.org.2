Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38E3EDA39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhHPP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:56:15 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44018
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237099AbhHPPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:53:21 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 0BA60412AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629129133;
        bh=4MVdP8jXnYTCG+53VuCVyBAjVTVm4TY2psh1h+dsRxs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=MVsQUmeNgcYdEJ2e9Htscj54kUvnUQHMJo8vsviHbfbag5fFsg8Xhv2LBsaLnkLYN
         f96klDWJAz3bZ+N5F6cYikLYQLh6qJ13jkFfvS6BilS6R87RiXZ9Q3zSRKF6XyQazl
         eDxmhcRE/H9hrMhLBouTXczVNWUUFrun4cbMJ2zZISP1XcQai++CmrpR7ZAXErPNaQ
         JOw9E60fupYzCj3oGL0w4lvNy282bgwCnl2FU4VZesZsZFFErHmZRsuxWkXU8/4XZZ
         MluV7j7gj9TwKWfC9A47gKme+8sOfPfWK/vAL0pOVRtoaS1ptVrcec89HqexjRkQWL
         CdtorVzFzlhxw==
Received: by mail-wm1-f69.google.com with SMTP id n20-20020a05600c4f9400b002e6dc6a99b9so113887wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4MVdP8jXnYTCG+53VuCVyBAjVTVm4TY2psh1h+dsRxs=;
        b=RNLSghdAguYjihBXTmf7+MGJTVMb6CfX4052RpjTEiquxItORrobB12yMN/wVZvd9U
         2pz/xCIa32wmEIf52rrtylPwNdyAASPMdIyo4p9yG72A35ZbKmccEisAT9UVQJhehz36
         VyOXQlzGhRexRH+i7pjLjJPpFaFCi26GYDErOHzgi2RNly1wq2DZ9v6ecj2M28uoug8b
         O9J7mm3GYceFpYPsZCdvXy0bIwiN2stsTaLfkKq5c66IA+2FRa78zKoUYVBbqhGupSW1
         MSkXX9+PMwxXvYw+Ov5AggaDm0v4/Q0BsV6HsqaqDVxWDMbzqc3Ebvt5uSgL8W7KOzR4
         pcyA==
X-Gm-Message-State: AOAM530jSggOooXLUlvo9RGyOHG5VYbsFBhdaY6NOuI9dP+/325GRU6D
        zqB1pqOVn5IsA8DsebRjiGOhspBlfWciFClJqg/OpAlXlRZsRPM2YhUJQauMdScouYj19YQANV4
        Lsf1qc8ATNJig19mp/V9AZa0lIpLGN77aJfmJtuhxgA==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr16026916wma.9.1629129132303;
        Mon, 16 Aug 2021 08:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqlBRnNFswf1ZrCbVN5bSe3Ayurc7d02vrCkm5wcHz2tQmOyPQNShzeTasmBIfgXuhemOH6Q==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr16026904wma.9.1629129132112;
        Mon, 16 Aug 2021 08:52:12 -0700 (PDT)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id h16sm12180359wre.52.2021.08.16.08.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:52:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
 <bef20bf2-538d-1319-ba22-6774efa10ebc@huawei.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <d9d9f764-2bc7-ddf4-2353-dac323e4416d@canonical.com>
Date:   Mon, 16 Aug 2021 17:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bef20bf2-538d-1319-ba22-6774efa10ebc@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 5:30 PM, Kefeng Wang wrote:
> 
> On 2021/8/16 22:47, Heinrich Schuchardt wrote:
>> For analyzing memory blocks we can either use the memblock=debug command
>> line argument which creates massive output or a debug file system.
>>
>> Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
>> /sys/kernel/debug/memblock to analyze memory blocks. The
>> same is already done for arm, arm64, mips, powerpc.
>>
>> The actual provisioning of the file system depends on CONFIG_DEBUG_FS.
> 
> Hi，for riscv, it don't use memblock(eg, no provide pfn_valid to use 
> memblock),
> 
> we could call memblock_discard() to discard memblock private memory to save
> 
> some memory, right?  So I think we don't need this config for now.

What do you mean by "it don't use memblock?

If you boot the HiFive Unmatched with memblock=debug you will see output 
like the one below. This is the information that you can see in the 
debug file system if CONFIG_DEBUG_FS and CONFIG_ARCH_KEEP_MEMBLOCK will 
be enabled.

[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x00000003ffe00000 reserved size = 
0x000000001290fb70
[    0.000000]  memory.cnt  = 0x25
[    0.000000]  memory[0x0]     [0x0000000080200000-0x00000000fe6e2fff], 
0x000000007e4e3000 bytes flags: 0x0
[    0.000000]  memory[0x1]     [0x00000000fe6e3000-0x00000000fe6e5fff], 
0x0000000000003000 bytes flags: 0x4
[    0.000000]  memory[0x2]     [0x00000000fe6e6000-0x00000000fe709fff], 
0x0000000000024000 bytes flags: 0x0
[    0.000000]  memory[0x3]     [0x00000000fe70a000-0x00000000fe70bfff], 
0x0000000000002000 bytes flags: 0x4
[    0.000000]  memory[0x4]     [0x00000000fe70c000-0x00000000fe70ffff], 
0x0000000000004000 bytes flags: 0x0
[    0.000000]  memory[0x5]     [0x00000000fe710000-0x00000000fe710fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x6]     [0x00000000fe711000-0x00000000fe712fff], 
0x0000000000002000 bytes flags: 0x0
[    0.000000]  memory[0x7]     [0x00000000fe713000-0x00000000fe716fff], 
0x0000000000004000 bytes flags: 0x4
[    0.000000]  memory[0x8]     [0x00000000fe717000-0x00000000fe717fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x9]     [0x00000000fe718000-0x00000000fe71cfff], 
0x0000000000005000 bytes flags: 0x4
[    0.000000]  memory[0xa]     [0x00000000fe71d000-0x00000000fe71dfff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0xb]     [0x00000000fe71e000-0x00000000fe71efff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0xc]     [0x00000000fe71f000-0x00000000fe71ffff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0xd]     [0x00000000fe720000-0x00000000fe720fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0xe]     [0x00000000fe721000-0x00000000fe721fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0xf]     [0x00000000fe722000-0x00000000fe722fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x10]    [0x00000000fe723000-0x00000000fe723fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x11]    [0x00000000fe724000-0x00000000fe724fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x12]    [0x00000000fe725000-0x00000000fe725fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x13]    [0x00000000fe726000-0x00000000fe726fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x14]    [0x00000000fe727000-0x00000000fe728fff], 
0x0000000000002000 bytes flags: 0x0
[    0.000000]  memory[0x15]    [0x00000000fe729000-0x00000000fe729fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x16]    [0x00000000fe72a000-0x00000000fe72afff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x17]    [0x00000000fe72b000-0x00000000fe72cfff], 
0x0000000000002000 bytes flags: 0x4
[    0.000000]  memory[0x18]    [0x00000000fe72d000-0x00000000fe72dfff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x19]    [0x00000000fe72e000-0x00000000fe72efff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x1a]    [0x00000000fe72f000-0x00000000fe72ffff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x1b]    [0x00000000fe730000-0x00000000fe730fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x1c]    [0x00000000fe731000-0x00000000fe731fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x1d]    [0x00000000fe732000-0x00000000fe732fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x1e]    [0x00000000fe733000-0x00000000fe733fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  memory[0x1f]    [0x00000000fe734000-0x00000000fe734fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x20]    [0x00000000fe735000-0x00000000fe736fff], 
0x0000000000002000 bytes flags: 0x0
[    0.000000]  memory[0x21]    [0x00000000fe737000-0x00000000fe737fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x22]    [0x00000000fe738000-0x00000000fff60fff], 
0x0000000001829000 bytes flags: 0x0
[    0.000000]  memory[0x23]    [0x00000000fff61000-0x00000000fff61fff], 
0x0000000000001000 bytes flags: 0x4
[    0.000000]  memory[0x24]    [0x00000000fff62000-0x000000047fffffff], 
0x000000038009e000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0xd
[    0.000000]  reserved[0x0]   [0x0000000080000000-0x000000008007ffff], 
0x0000000000080000 bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x0000000080200000-0x00000000815fffff], 
0x0000000001400000 bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x0000000087f00000-0x0000000087f05fff], 
0x0000000000006000 bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x00000000db0a2000-0x00000000db0a48b4], 
0x00000000000028b5 bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x00000000db2a2000-0x00000000dc709fff], 
0x0000000001468000 bytes flags: 0x0
[    0.000000]  reserved[0x5]   [0x00000000fe701000-0x00000000fe701fff], 
0x0000000000001000 bytes flags: 0x0
[    0.000000]  reserved[0x6]   [0x00000000fe704040-0x00000000fe70404f], 
0x0000000000000010 bytes flags: 0x0
[    0.000000]  reserved[0x7]   [0x000000046ffe1d40-0x000000047dfe253f], 
0x000000000e000800 bytes flags: 0x0
[    0.000000]  reserved[0x8]   [0x000000047dfe2548-0x000000047dfe2578], 
0x0000000000000031 bytes flags: 0x0
[    0.000000]  reserved[0x9]   [0x000000047dfe2580-0x000000047dfe25ae], 
0x000000000000002f bytes flags: 0x0
[    0.000000]  reserved[0xa]   [0x000000047dfe25b0-0x000000047dfe25de], 
0x000000000000002f bytes flags: 0x0
[    0.000000]  reserved[0xb]   [0x000000047dfe25e0-0x000000047dfefffb], 
0x000000000000da1c bytes flags: 0x0
[    0.000000]  reserved[0xc]   [0x000000047dff0000-0x000000047fffffff], 
0x0000000002010000 bytes flags: 0x0

Best regards

Heinrich

> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4f7b70ae7c31..a6e57614c3fd 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -31,6 +31,7 @@ config RISCV
>>       select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>>       select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>>       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>> +    select ARCH_KEEP_MEMBLOCK
>>       select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>>       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>>       select ARCH_SUPPORTS_HUGETLBFS if MMU

