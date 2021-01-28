Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1E307CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhA1Rgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhA1Rfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:35:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CA964D9A;
        Thu, 28 Jan 2021 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611855297;
        bh=TkMt06C39KAtu27x1DMMhjzHHmvklcYVEo9Dtplc7bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXEDB2oB667WqtQ3FaoY5JbM3br+ouLPdfGippereJ3bazR3YvSFM3/yMYFpa5s9m
         I3SLgnoW2gL6Jbrl0kvEocY30o4L6ccfLwVjicpke430MgCinys1z1Y8ZjlkpNLhpE
         g1awn+IWlMu9bBOvr2kGhOYvZPJdtnAxTl/ElWA1Kkxp2dBivL/yinx1thffOp56BA
         c09mNreubOtXTYEMkNE4RDILxeC7fCCmKi/l/KLiP9RLTZJYJtMrr+UWxsfX8dlkoE
         8oS+ZuDaIDSNTtp+vAovpleEwM5FNHZlLbeagoI4a8EUOCNol4DfH7U9m4l+ZR9e07
         FxoB6QhkZCDiw==
Date:   Fri, 29 Jan 2021 02:34:51 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
        marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, gregkh@linuxfoundation.org,
        saravanak@google.com, heikki.krogerus@linux.intel.com,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
Message-ID: <20210128173451.GA31631@redsun51.ssa.fujisawa.hgst.com>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-3-jxgao@google.com>
 <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:15:28PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:
> > For devices that need to preserve address offset on mapping through
> > swiotlb, this patch adds offset preserving based on page_offset_mask
> > and keeps the offset if the mask is non zero. This is needed for
> > device drivers like NVMe.
> 
> <scratches his head>
> 
> Didn't you send this patch like a month ago and someone pointed
> out that the right fix would be in the NVMe driver?
> 
> Is there an issue with fixing the NVMe driver?

You got it backwards. The initial "fix" used a flag specific to the nvme
driver, and it was pointed out that it should just be the generic
behaviour.
