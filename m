Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C083B51EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 06:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhF0EyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 00:54:17 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:45779 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhF0EyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 00:54:16 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d42 with ME
        id N4rq2500221Fzsu034rqeR; Sun, 27 Jun 2021 06:51:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Jun 2021 06:51:51 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] Coccinelle: Update and rename
 api/alloc/pci_free_consistent.cocci
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Gilles.Muller@inria.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.comp.version-control.coccinelle,gmane.linux.kernel.janitors
References: <edc2fdb429d184d05a70956ced00845bca2d4fe9.1623871406.git.christophe.jaillet@wanadoo.fr>
 <alpine.DEB.2.22.394.2106262154280.3562@hadrien>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <65419e5b-6c82-cf5a-071a-a3421f6b846a@wanadoo.fr>
Date:   Sun, 27 Jun 2021 06:51:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2106262154280.3562@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/06/2021 à 21:55, Julia Lawall a écrit :
> 
> 
> On Wed, 16 Jun 2021, Christophe JAILLET wrote:
> 
>> 'pci_alloc_consistent()' is about to be removed from the kernel.
>> It is now more useful to check for dma_alloc_coherent/dma_free_coherent.
> 
> dma_alloc_coherent has four arguments, and in the script there are only
> three.  Is the number of arguments to dma_alloc_coherent going to change?

I don't think so.

Just a stupid "typo" from my side.

CJ

> 
> julia
> 
> 
>>
>> So change the script accordingly and rename it.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Not sure that the script works.
>> There are 718 'dma_alloc_coherent' calls in 5.13-rc6. It is surprising
>> to have no match at all, not even a single false positive.
>> ---
>>   ..._consistent.cocci => dma_free_coherent.cocci} | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>   rename scripts/coccinelle/free/{pci_free_consistent.cocci => dma_free_coherent.cocci} (52%)
>>
>> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/dma_free_coherent.cocci
>> similarity index 52%
>> rename from scripts/coccinelle/free/pci_free_consistent.cocci
>> rename to scripts/coccinelle/free/dma_free_coherent.cocci
>> index d51e92556b42..75f159e7b6d7 100644
>> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
>> +++ b/scripts/coccinelle/free/dma_free_coherent.cocci
>> @@ -1,10 +1,10 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>> -/// Find missing pci_free_consistent for every pci_alloc_consistent.
>> +/// Find missing dma_free_coherent for every dma_alloc_coherent.
>>   ///
>>   // Confidence: Moderate
>>   // Copyright: (C) 2013 Petr Strnad.
>>   // URL: http://coccinelle.lip6.fr/
>> -// Keywords: pci_free_consistent, pci_alloc_consistent
>> +// Keywords: dma_free_coherent, dma_alloc_coherent
>>   // Options: --no-includes --include-headers
>>
>>   virtual report
>> @@ -17,12 +17,12 @@ position p1,p2;
>>   type T;
>>   @@
>>
>> -id = pci_alloc_consistent@p1(x,y,&z)
>> +id = dma_alloc_coherent@p1(x,y,&z)
>>   ... when != e = id
>>   if (id == NULL || ...) { ... return ...; }
>> -... when != pci_free_consistent(x,y,id,z)
>> -    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
>> -    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
>> +... when != dma_free_coherent(x,y,id,z)
>> +    when != if (id) { ... dma_free_coherent(x,y,id,z) ... }
>> +    when != if (y) { ... dma_free_coherent(x,y,id,z) ... }
>>       when != e = (T)id
>>       when exists
>>   (
>> @@ -40,7 +40,7 @@ p1 << search.p1;
>>   p2 << search.p2;
>>   @@
>>
>> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>> +msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>>   coccilib.report.print_report(p2[0],msg)
>>
>>   @script:python depends on org@
>> @@ -48,6 +48,6 @@ p1 << search.p1;
>>   p2 << search.p2;
>>   @@
>>
>> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>> +msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>>   cocci.print_main(msg,p1)
>>   cocci.print_secs("",p2)
>> --
>> 2.30.2
>>
>>
> 

