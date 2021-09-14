Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6C40AC65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhINL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:28:07 -0400
Received: from verein.lst.de ([213.95.11.211]:59800 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhINL2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:28:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 642E967373; Tue, 14 Sep 2021 13:26:46 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:26:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210914112646.GA18171@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com> <20210909060712.GA25485@lst.de> <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com> <20210914061705.GB26679@lst.de> <87971ad4-9519-cf0d-76a8-6baa253d0122@gaisler.com> <20210914104256.GA14645@lst.de> <a5483206-0539-1d3f-c8e8-e66dbb6c8d96@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5483206-0539-1d3f-c8e8-e66dbb6c8d96@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 01:16:16PM +0200, Andreas Larsson wrote:
> Before the patch, arch_dma_alloc did via srmmu_mapiorange set up pages with 
> SRMMU_PRIV, which is all fine as it sets up kernel buffers. With your patch 
> we get PAGE_KERNEL as an argument to dma_pgprot in the corresponding call 
> path that earlier lead to arch_dma_alloc. PAGE_KERNEL already includes 
> SRMMU_PRIV so adding it again should not be necessary.

You're right, I missed that PAGE_KERNEL already includes SRMMU_PRIV.
