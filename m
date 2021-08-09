Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F913E486B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhHIPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:16:07 -0400
Received: from verein.lst.de ([213.95.11.211]:60946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhHIPQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:16:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB09C67357; Mon,  9 Aug 2021 17:15:43 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:15:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: fix debugfs initialization order
Message-ID: <20210809151543.GA22395@lst.de>
References: <20210722091818.13434-1-ailiop@suse.com> <1ea36b32-9bbc-a611-402d-9fa196eda166@arm.com> <YPl8b7KuoNBg52LE@technoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPl8b7KuoNBg52LE@technoir>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
