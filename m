Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889CE3107D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBEJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:26:52 -0500
Received: from verein.lst.de ([213.95.11.211]:59550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBEJV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:21:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F7B668B05; Fri,  5 Feb 2021 10:21:13 +0100 (CET)
Date:   Fri, 5 Feb 2021 10:21:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Message-ID: <20210205092113.GA870@lst.de>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:00:35PM +1300, Barry Song wrote:
> +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
>  	__u64 expansion[10];	/* For future use */

We need to keep the struct size, so the expansion field needs to
shrink by the equivalent amount of data that is added in dma_trans_ns.
