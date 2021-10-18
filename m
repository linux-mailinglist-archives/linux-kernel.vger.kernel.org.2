Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6493E431669
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJRKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:49:28 -0400
Received: from verein.lst.de ([213.95.11.211]:33343 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhJRKt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:49:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7184968AFE; Mon, 18 Oct 2021 12:47:13 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:47:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] dma-debug: teach add_dma_entry() about
 DMA_ATTR_SKIP_CPU_SYNC
Message-ID: <20211018104713.GA9559@lst.de>
References: <20211012055404.88571-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012055404.88571-1-someguy@effective-light.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
