Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6703AFE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFVHoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:44:07 -0400
Received: from verein.lst.de ([213.95.11.211]:45481 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhFVHoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:44:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8FFD67373; Tue, 22 Jun 2021 09:41:48 +0200 (CEST)
Date:   Tue, 22 Jun 2021 09:41:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dma debug: report -EEXIST errors in add_dma_entry
Message-ID: <20210622074148.GA601@lst.de>
References: <20210518125443.34148-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518125443.34148-1-someguy@effective-light.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
