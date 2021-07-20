Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930163CF58D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhGTHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:11:56 -0400
Received: from verein.lst.de ([213.95.11.211]:54111 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhGTHKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:10:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA8BF6736F; Tue, 20 Jul 2021 09:51:12 +0200 (CEST)
Date:   Tue, 20 Jul 2021 09:51:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 2/5] swiotlb: Point io_default_tlb_mem at static
 allocation
Message-ID: <20210720075112.GB17565@lst.de>
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719123054.6844-3-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd prefer if the next patch is merged into this one, to avoid the
confusing state inbetween entirely.
