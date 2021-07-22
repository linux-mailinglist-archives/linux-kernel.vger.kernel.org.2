Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB273D2047
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGVIVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:21:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50991 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhGVIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:21:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GVmfr5TrWz1sGKb;
        Thu, 22 Jul 2021 11:02:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GVmfr45ZJz1qqkg;
        Thu, 22 Jul 2021 11:02:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id B3xsr2CvvLrS; Thu, 22 Jul 2021 11:02:11 +0200 (CEST)
X-Auth-Info: 5K2eEbDaqyAfIeaYUxnfMTLK7qDLkZsfKwuZYZ+up/2N3WzIN6C1Edq5vLWLBZlv
Received: from igel.home (ppp-46-244-188-81.dynamic.mnet-online.de [46.244.188.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 22 Jul 2021 11:02:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id D0B2C2C2647; Thu, 22 Jul 2021 11:02:10 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     tongtiangen@huawei.com, jszhang3@mail.ustc.edu.cn,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
X-Yow:  Yow!!  "Janitor trapped in sewer uses ESP to find decayed burger"!!
Date:   Thu, 22 Jul 2021 11:02:10 +0200
In-Reply-To: <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
        (Palmer Dabbelt's message of "Wed, 21 Jul 2021 23:12:20 -0700 (PDT)")
Message-ID: <87k0lizppp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21 2021, Palmer Dabbelt wrote:

> On Mon, 19 Jul 2021 00:23:06 PDT (-0700), schwab@linux-m68k.org wrote:
>> On Jul 19 2021, tongtiangen wrote:
>>
>>> On 2021/7/17 14:55, Andreas Schwab wrote:
>>>> Please use
>>>> https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
>>>> and run it in qemu with u-boot as kernel.
>>>>
>>>> Andreas.
>>>>
>>>
>>> Hi andreas:
>>> I used today's latest mainline code and .config provided by you, and I
>>> can't reproduce this panic.
>>
>> Did you test it like I said above?
>>
>> Andreas.
>
> I'm getting this on and off, with just 
> CONFIG_VMAP_STACK=y
>
> on top of defconfig, when running on QEMU.  It's not showing up right now:
> I'd thought it was an issue with that initrd patch, but it went away when
> I re-ran the tests so I'm guessing it's something non-deterministic.  I'll
> try to take a look if it comes back.

The crash happens reliably with the image above.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
