Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCB3FA064
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhH0UOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:14:09 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:47205 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229591AbhH0UNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:13:49 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d77 with ME
        id mkCy2500K3riaq203kCyHe; Fri, 27 Aug 2021 22:12:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 27 Aug 2021 22:12:59 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] mei: switch from 'pci_' to 'dma_' API
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <d4d442f06c602230e8145a531647bbfee69a1e31.1629662528.git.christophe.jaillet@wanadoo.fr>
 <YST3d2kFISWty5EI@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <39e04750-a15d-37ec-6fa1-82591331702c@wanadoo.fr>
Date:   Fri, 27 Aug 2021 22:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YST3d2kFISWty5EI@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2021 à 15:43, Greg KH a écrit :
> On Sun, Aug 22, 2021 at 10:02:59PM +0200, Christophe JAILLET wrote:
>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>
>> The patch has been generated with the coccinelle script below.
>>
>> It has been compile tested.
>>
>>
>> @@
>> @@
>> -    PCI_DMA_BIDIRECTIONAL
>> +    DMA_BIDIRECTIONAL
>>
>> @@
>> @@
>> -    PCI_DMA_TODEVICE
>> +    DMA_TO_DEVICE
>>
>> @@
>> @@
>> -    PCI_DMA_FROMDEVICE
>> +    DMA_FROM_DEVICE
>>
>> @@
>> @@
>> -    PCI_DMA_NONE
>> +    DMA_NONE
>>
>> @@
>> expression e1, e2, e3;
>> @@
>> -    pci_alloc_consistent(e1, e2, e3)
>> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>>
>> @@
>> expression e1, e2, e3;
>> @@
>> -    pci_zalloc_consistent(e1, e2, e3)
>> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_free_consistent(e1, e2, e3, e4)
>> +    dma_free_coherent(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_map_single(e1, e2, e3, e4)
>> +    dma_map_single(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_unmap_single(e1, e2, e3, e4)
>> +    dma_unmap_single(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4, e5;
>> @@
>> -    pci_map_page(e1, e2, e3, e4, e5)
>> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_unmap_page(e1, e2, e3, e4)
>> +    dma_unmap_page(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_map_sg(e1, e2, e3, e4)
>> +    dma_map_sg(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_unmap_sg(e1, e2, e3, e4)
>> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
>> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
>> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
>> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2, e3, e4;
>> @@
>> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
>> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
>>
>> @@
>> expression e1, e2;
>> @@
>> -    pci_dma_mapping_error(e1, e2)
>> +    dma_mapping_error(&e1->dev, e2)
>>
>> @@
>> expression e1, e2;
>> @@
>> -    pci_set_dma_mask(e1, e2)
>> +    dma_set_mask(&e1->dev, e2)
>>
>> @@
>> expression e1, e2;
>> @@
>> -    pci_set_consistent_dma_mask(e1, e2)
>> +    dma_set_coherent_mask(&e1->dev, e2)
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> That is a lot of different things in one changelog text, yet you really
> only did a replacement for pci_set_dma_mask here.  Please clean up the
> changelog to reflect what you did, and most importantly, _WHY_ you are
> doing it.
> 
> thanks,
> 
> greg k-h
> 

Hi,

thx for the feed-back.

I've continued my serie and just sent "[PATCH] niu: switch from 'pci_' 
to 'dma_' API" where you are also in copy.

I've tried to improve the log message in it, giving references of why 
these clean-ups are done (proposed by Christoph Hellwig) and some 
reasons of why it is a good idea (argumentation from Julia Lawall)

The long coccinelle script has been reduced to only relevant parts.

I hope that this new version is good enough.


Comments on the "niu" drivers will also be taken into account when I 
will send a v2 for patches you have commented on.

CJ
