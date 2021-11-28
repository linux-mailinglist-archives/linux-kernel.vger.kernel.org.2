Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB9460277
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356612AbhK1AMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 19:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhK1AKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 19:10:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C1C061574;
        Sat, 27 Nov 2021 16:07:23 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E512B80B23;
        Sun, 28 Nov 2021 00:07:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5952F60524;
        Sun, 28 Nov 2021 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638058040;
        bh=qezTYQseI9DxNpOdmT5kuzbuG73JbvoENi5WMIb3UJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wqJban2R9O7yF/wfcwEI4K4ewdbM6sKnUWWUVW47r212gOjNx18PFLesOFaVBDsq3
         23UqWBAtQRubS7Ips1ydm9qOT7CzelMqDvbO+0iE5DvCC4nrU8DDJJHNZx4pfYqvT5
         G90iNCll6YneKYh+AF64jnxHQVZ12GpU+v+KUAqM=
Date:   Sat, 27 Nov 2021 16:07:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Calvin Zhang <calvinzhang.cool@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-Id: <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
In-Reply-To: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:

> Just like this:
> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
> 
> Add kmemleak_ignore_phys() for CMA created from of reserved node.

Could we please have a full, standalone changelog for this patch?

The 620951e27457 changelog says "Without this, the kernel crashes...". 
Does your patch also fix a crash?  If so under what circumstances and
should we backport this fix into -stable kernels?

Etcetera.

