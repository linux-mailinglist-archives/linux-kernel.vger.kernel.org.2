Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736DD40992B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhIMQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:32:10 -0400
Received: from verein.lst.de ([213.95.11.211]:56177 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237873AbhIMQcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:32:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 34C5167357; Mon, 13 Sep 2021 18:30:44 +0200 (CEST)
Date:   Mon, 13 Sep 2021 18:30:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dma-debug: prevent an error message from causing
 runtime problems
Message-ID: <20210913163043.GA9401@lst.de>
References: <20210910235337.13172-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910235337.13172-1-someguy@effective-light.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.

I've applied this with a little change to avoid breaking up the
printed string into two lines.
