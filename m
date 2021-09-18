Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE04106A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhIRNLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 09:11:48 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:20127 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhIRNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 09:11:47 -0400
Received: from [192.168.1.18] ([90.126.248.220])
        by mwinf5d38 with ME
        id vRAM250064m3Hzu03RAMdF; Sat, 18 Sep 2021 15:10:22 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Sep 2021 15:10:22 +0200
X-ME-IP: 90.126.248.220
Subject: Re: [PATCH v2] misc: genwqe: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <590154f2ab113088346ae76c3f13f8b1cbebccbb.1631942274.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a3umbVdPv1omKd5p1gH3JzUEB_MJrK0xQmXok8iSY_haA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <4cb6f731-7f4d-21d0-c88d-37664ea35002@wanadoo.fr>
Date:   Sat, 18 Sep 2021 15:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3umbVdPv1omKd5p1gH3JzUEB_MJrK0xQmXok8iSY_haA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/09/2021 à 11:42, Arnd Bergmann a écrit :
> On Sat, Sep 18, 2021 at 7:20 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> In [1], Christoph Hellwig has proposed to remove the wrappers in
>> include/linux/pci-dma-compat.h.
>>
>> Some reasons why this API should be removed have been given by Julia
>> Lawall in [2].
>>
>> Finally, Arnd Bergmann reminded that the documentation was updated 11 years
>> ago to only describe the modern linux/dma-mapping.h interfaces and mark the
>> old bus-specific ones as no longer recommended, see commit 216bf58f4092
>> ("Documentation: convert PCI-DMA-mapping.txt to use the generic DMA API").
> ...
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> How much is left now overall? Are you getting close enough that the
> remaining patches to remove the header can be done as a short series and
> merged through Andrew's -mm tree?
> 
>         Arnd
> 

Hi,

considering that the 3 patches that you have just review are done, the 
diffsat of what is remaining is:

   32 files changed, 309 insertions(+), 272 deletions(-)


All corresponding patches have already been proposed.
Most of the patches are not that old (i.e. < 1 month)

They all *look* trivial to me, *EXCEPT* the ones for message/fusion.

I've tried to split the latter in small series in the hope of easing review.
Moreover the drivers/message/fusion directory seems to be inactive since 
a few months. I don't know if it is just related to the summer or if 
this code is for some reason stalled.
This is funny, because the very start for me of this clean-up effort was 
related to an issue in memory allocation in message/fusion fixed by 
Christoph Hellwig :)


The details are:


Patches with a Review-by tag
============================
bus: mhi:
 
https://lore.kernel.org/kernel-janitors/bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr/

fpga: dfl:
 
https://lore.kernel.org/kernel-janitors/c23cf1cfa058456da69849de22b957c6c414766d.1629643816.git.christophe.jaillet@wanadoo.fr/



Patches waiting for review
==========================
arch: sparc:
 
https://lore.kernel.org/kernel-janitors/aa28186920a1bb964ca03723e482f130cd8e9322.1629663425.git.christophe.jaillet@wanadoo.fr/

agp/intel:
 
https://lore.kernel.org/kernel-janitors/e6b5bc8d1f79955ebba652df3deff6b8b39cc607.1630136212.git.christophe.jaillet@wanadoo.fr/

i2c:
 
https://lore.kernel.org/kernel-janitors/fad542b558afc45496f7a7ba581593cd46e68f7c.1629660967.git.christophe.jaillet@wanadoo.fr/

mt76:
 
https://lore.kernel.org/kernel-janitors/83b2da6ff8a07d576fa3627051daa705aba37a3c.1629617782.git.christophe.jaillet@wanadoo.fr/

rapidio:
 
https://lore.kernel.org/kernel-janitors/20210117133929.563645-1-christophe.jaillet@wanadoo.fr/
    --> Sent a long time ago, should be ping'ed

scsi:
 
https://lore.kernel.org/kernel-janitors/3899b1ed4abac581c30845d82f33ec6df8b38976.1629633207.git.christophe.jaillet@wanadoo.fr/

media: v4l2-pci-skeleton:
 
https://lore.kernel.org/kernel-janitors/7191e316ea3b61b6a015d063d2b068a9f4a965aa.1630230428.git.christophe.jaillet@wanadoo.fr/
    --> Unsure if the one I sent the patch to is the correct one.
        get_maintainer.pl is of no help here

message/fusion:
 
https://lore.kernel.org/kernel-janitors/cover.1623617903.git.christophe.jaillet@wanadoo.fr/
 
https://lore.kernel.org/kernel-janitors/db56a78d7d04b809abd32a6fb4839d698587bf7c.1623580326.git.christophe.jaillet@wanadoo.fr/
 
https://lore.kernel.org/kernel-janitors/cover.1623579808.git.christophe.jaillet@wanadoo.fr/
 
https://lore.kernel.org/kernel-janitors/cover.1623571676.git.christophe.jaillet@wanadoo.fr/
    --> these series are a bit more tricky. See each cover letter


Patches that could be applied as-is, but which received comments
================================================================
drivers: dma:
 
https://lore.kernel.org/kernel-janitors/547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr/
    --> Need to be rework because Andy Shevchenko (intel) wants some 
additional clean-up.
        Setting 64 bits DMA mask can't fail, so some code is dead and 
should be removed.
        I think that it could (should ?) be done in another step

drm/i915:
 
https://lore.kernel.org/kernel-janitors/dbf1018fb773785e0b3b40e601246ed6438e645e.1629666258.git.christophe.jaillet@wanadoo.fr/
    --> The original code was apparently weird
    --> I'm not sure on what do do. Send a v2 (which would be a blind 
fix)? Send a serie? Wait for Robin Murphy to "do what needs to be done"?
        I think that it could (should ?) be done in another step



Patches that I need to resend
=============================
arch: alpha:
 
https://lore.kernel.org/kernel-janitors/18ab2b83b05b50a00ef673e320c8ddc0d19f099a.1630230112.git.christophe.jaillet@wanadoo.fr/
    --> subject is broken (s/sparc/alpha/)
    --> I will send a v2 to fix it


Let me know what is the best way to finally end this clean-up which 
started a *long* time ago. (see [1])

CJ

[1]: 
https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
