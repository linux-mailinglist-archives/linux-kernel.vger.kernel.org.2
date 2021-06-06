Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17A839CDE9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFFHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:42:43 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44989 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:42:41 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 89713E0002;
        Sun,  6 Jun 2021 07:40:44 +0000 (UTC)
Subject: Re: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip
 soc
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210604120639.1447869-1-alex@ghiti.fr>
 <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
 <1287f6f3-2f07-3269-9048-8f7d08eecc09@ghiti.fr>
 <CAK8P3a1_N6dAdjWR10FtgaVz828o7W5Mp55DO3Ex+3en-ikOUw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <5d3a00d1-9e45-398a-39cf-1e6e9924eb18@ghiti.fr>
Date:   Sun, 6 Jun 2021 09:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1_N6dAdjWR10FtgaVz828o7W5Mp55DO3Ex+3en-ikOUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 5/06/2021 à 13:00, Arnd Bergmann a écrit :
> On Sat, Jun 5, 2021 at 8:37 AM Alex Ghiti <alex@ghiti.fr> wrote:
>> Le 4/06/2021 à 15:08, Arnd Bergmann a écrit :
>>> On Fri, Jun 4, 2021 at 2:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Fix BUILTIN_DTB config which resulted in a dtb that was actually not built
>>>> into the Linux image: in the same manner as Canaan soc does, create an object
>>>> file from the dtb file that will get linked into the Linux image.
>>>>
>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>
>>> Along the same lines as the comment that Jisheng Zhang made on the fixed
>>> address, building a dtb into the kernel itself fundamentally breaks generic
>>> kernel images.
>>>
>>> I can understand using it on K210, which is extremely limited and wouldn't
>>> run a generic kernel anyway, but for normal platforms like microchip and
>>> sifive, it would be better to disallow CONFIG_BUILTIN_DTB in Kconfig
>>> and require a non-broken boot loader.
>>
>> I kind of disagree because if I want to build a custom kernel for those
>> platforms with a builtin dtb for some reasons (debug, development..Etc),
>> I think I should be able to do so.
> 
> How is the builtin dtb better than appended dtb, or passing the dtb to the
> boot loader in that case?

Ah never said it was better, just it was available so there is no reason 
we could not allow it :)

> 
>           Arnd
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
