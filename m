Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F73377F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEJJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:19:24 -0400
Received: from verein.lst.de ([213.95.11.211]:57809 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:19:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBDA367373; Mon, 10 May 2021 11:18:16 +0200 (CEST)
Date:   Mon, 10 May 2021 11:18:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bumyong Lee <bumyong.lee@samsung.com>
Subject: Re: [PATCH v2] swiotlb: manipulate orig_addr when tlb_addr has
 offset
Message-ID: <20210510091816.GA2084@lst.de>
References: <CGME20210510091047epcas2p46daccaa59f30e7444be0ff2b5955228c@epcas2p4.samsung.com> <20210510091004.111006-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510091004.111006-1-chanho61.park@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
