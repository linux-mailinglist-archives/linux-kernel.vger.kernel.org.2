Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B737404565
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351146AbhIIGIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:08:25 -0400
Received: from verein.lst.de ([213.95.11.211]:41357 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhIIGIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:08:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 127A367373; Thu,  9 Sep 2021 08:07:13 +0200 (CEST)
Date:   Thu, 9 Sep 2021 08:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210909060712.GA25485@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908074822.16793-1-andreas@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:48:22AM +0200, Andreas Larsson wrote:
> Commit 53b7670e5735 ("sparc: factor the dma coherent mapping into
> helper") lost the page align for the calls to dma_make_coherent and
> srmmu_unmapiorange. The latter cannot handle a non page aligned len
> argument.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Andreas - while I've got your attention:  I've been looking into fully
converting sparc32 to the generic DMA code.  Do you have any
documentation for the Leon cache handling in dma_make_coherent,
and more importantly how that applies to the dma coherent handling?
I could see how a flush might be required for the streaming DMA mappings,
that is mapping normal cached memory for I/O.  But for the coherent
allocations which can be accessed from the device and the cpu without
another DMA mapping call this seems really strange.
