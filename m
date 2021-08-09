Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686703E486E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhHIPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:16:32 -0400
Received: from verein.lst.de ([213.95.11.211]:60950 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhHIPQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:16:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E64467357; Mon,  9 Aug 2021 17:16:03 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:16:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH resend] dma-debug: Use memory_intersects() directly
Message-ID: <20210809151603.GA22445@lst.de>
References: <20210722105512.183795-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722105512.183795-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
