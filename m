Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1040AC45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhINLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:17:38 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:14179 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhINLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:17:37 -0400
X-Halon-ID: 2e0d504d-154d-11ec-ac84-005056917a89
Authorized-sender: andreas@gaisler.com
Received: from [192.168.10.42] (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 2e0d504d-154d-11ec-ac84-005056917a89;
        Tue, 14 Sep 2021 13:16:17 +0200 (CEST)
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
References: <20210908074822.16793-1-andreas@gaisler.com>
 <20210909060712.GA25485@lst.de>
 <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com>
 <20210914061705.GB26679@lst.de>
 <87971ad4-9519-cf0d-76a8-6baa253d0122@gaisler.com>
 <20210914104256.GA14645@lst.de>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <a5483206-0539-1d3f-c8e8-e66dbb6c8d96@gaisler.com>
Date:   Tue, 14 Sep 2021 13:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914104256.GA14645@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider the environment before printing this email
On 2021-09-14 12:42, Christoph Hellwig wrote:

>> The added pgprot_dmacoherent is problematic as it sets SRMMU_PRIV, which
>> sets up kernel access only. This was fine for arch_dma_alloc that sets up
>> kernel accesses only, but for user space DMA mmap this would make them
>> kernel accessable only. Having no sparc-specific pgprot_dmacoherent,
>> keeping it to default to pgprot_noncached, is probably better.
> 
> I've just tried to keep the existing attributes.  If SRMMU_PRIV does
> indeed mean that the page can't also be mapped into userspace page tables
> it would be good to remove it in an incremental patch.  If OTOH it only
> means that this PTE is a kernel mapping it should not affect a userspace
> mapping as that will always use separate PTEs.

Before the patch, arch_dma_alloc did via srmmu_mapiorange set up pages 
with SRMMU_PRIV, which is all fine as it sets up kernel buffers. With 
your patch we get PAGE_KERNEL as an argument to dma_pgprot in the 
corresponding call path that earlier lead to arch_dma_alloc. PAGE_KERNEL 
already includes SRMMU_PRIV so adding it again should not be necessary.

The problem I am pointing to is that adding a pgprot_dmacoherent that 
adds SRMMU_PRIV, changes the behaviour of other call paths that calls 
dma_pgprot but are not mapping in kernel pages.

Now this is not confirmed in execution from my side, but it seems that 
from following the code that e.g. this call path that is about mapping 
DMA pages accessible from user space:

dma_mmap_attrs ->  dma_direct_mmap -> dma_pgprot -> pgprot_dmacoherent

goes from making it merely uncacheable with the default

#ifndef pgprot_dmacoherent
#define pgprot_dmacoherent(prot)	pgprot_noncached(prot)
#endif

to also being non-user-accessible if we change to this  pgprot_dmacoherent

#define pgprot_dmacoherent pgprot_dmacoherent
static inline pgprot_t pgprot_dmacoherent(pgprot_t prot)
{
	pgprot_val(prot) &= ~pgprot_val(__pgprot(SRMMU_CACHE));
	pgprot_val(prot) |= pgprot_val(__pgprot(SRMMU_PRIV));
	return prot;
}

-- 
Andreas Larsson

