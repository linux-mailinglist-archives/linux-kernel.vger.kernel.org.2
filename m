Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D23FCFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbhHaXGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:06:05 -0400
Received: from rosenzweig.io ([138.197.143.207]:44856 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241184AbhHaXGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:06:04 -0400
Date:   Tue, 31 Aug 2021 17:39:35 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
Message-ID: <YS6hl0gAOMoMxNhf@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828153642.19396-7-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {

Not a fan of this construction. Could you assign `(1 <<
__ffs(domain->pgsize_bitmap))` to an appropriately named temporary (e.g
min_io_pgsize) so it's clearer what's going on?

> +		pr_warn("IOMMU page size cannot represent CPU pages.\n");

"Represent" how?
