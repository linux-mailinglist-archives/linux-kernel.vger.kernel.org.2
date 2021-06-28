Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AF53B58FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhF1GNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:13:52 -0400
Received: from verein.lst.de ([213.95.11.211]:35171 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhF1GNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:13:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B459367373; Mon, 28 Jun 2021 08:11:23 +0200 (CEST)
Date:   Mon, 28 Jun 2021 08:11:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 9/9] dma-debug: Use memory_intersects() directly
Message-ID: <20210628061123.GA23316@lst.de>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com> <20210626073439.150586-10-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-10-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You've sent me a patch 9 out of 9 without the previous 8 patches.  There
is no way I can sensibly review this series.
