Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8FE318605
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBKIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:01:00 -0500
Received: from verein.lst.de ([213.95.11.211]:54361 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhBKIA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:00:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6C8267373; Thu, 11 Feb 2021 09:00:56 +0100 (CET)
Date:   Thu, 11 Feb 2021 09:00:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page_alloc: Fix pageblock_order when
 HUGETLB_PAGE_ORDER >= MAX_ORDER
Message-ID: <20210211080056.GA14448@lst.de>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com> <1613024531-19040-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613024531-19040-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (HPAGE_SHIFT > PAGE_SHIFT)
> +	if ((HPAGE_SHIFT > PAGE_SHIFT) && (HUGETLB_PAGE_ORDER < MAX_ORDER))

No need for the braces.
