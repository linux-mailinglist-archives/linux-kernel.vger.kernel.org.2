Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF833AF85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhCOKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:03:53 -0400
Received: from verein.lst.de ([213.95.11.211]:53215 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhCOKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:03:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95C1E68C4E; Mon, 15 Mar 2021 11:03:27 +0100 (CET)
Date:   Mon, 15 Mar 2021 11:03:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: fix inconsistent indenting in
 dma_alloc_coherent()
Message-ID: <20210315100327.GA3305@lst.de>
References: <1615515552-1432-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615515552-1432-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this to the dma-mapping tree with a more useful commit
log.
