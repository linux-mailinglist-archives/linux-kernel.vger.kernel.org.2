Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2255408D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhIMNY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:24:56 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:39405 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240191AbhIMNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:00 -0400
X-Halon-ID: 1b6c260b-1495-11ec-8b2b-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from [192.168.10.42] (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id 1b6c260b-1495-11ec-8b2b-0050569116f7;
        Mon, 13 Sep 2021 15:18:39 +0200 (CEST)
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
References: <20210908074822.16793-1-andreas@gaisler.com>
 <20210909060712.GA25485@lst.de>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com>
Date:   Mon, 13 Sep 2021 15:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909060712.GA25485@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-09 08:07, Christoph Hellwig wrote:
> Andreas - while I've got your attention:  I've been looking into fully
> converting sparc32 to the generic DMA code.  Do you have any
> documentation for the Leon cache handling in dma_make_coherent,
> and more importantly how that applies to the dma coherent handling?
> I could see how a flush might be required for the streaming DMA mappings,
> that is mapping normal cached memory for I/O.  But for the coherent
> allocations which can be accessed from the device and the cpu without
> another DMA mapping call this seems really strange.

As long as the area passed to arch_dma_free is mapped by
arch_dma_allocate, I don't see why the call to dma_make_coherent in
arch_dma_free should be needed. I am not sure if there are any current
(or historical paths) where we nevertheless have a cacheable mapping
when we reach arch_dma_free (or the historical pci32_free_coherent).

The usual case for LEON systems is that cache snooping on the CPU side
invalidates cache lines matching DMA that the CPU sees on the bus. Under
the assumption that DMA accesses are seen on the processor bus, this is
the reason for only flushing if snooping is not enabled in
dma_make_coherent.

-- 
Andreas Larsson

