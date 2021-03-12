Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28483388B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhCLJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhCLJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:30:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D68C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/PY1FtmG3ac2SthA8z5yZwsXBWGLH/vri2vgNuCMVKM=; b=P5wamdz2faf+EoMA1yl/bkt1Kn
        tBG5+2J7pgNwd9gxHE2WLsWsWJZORrx0XrqI3Ks2LnCF0E7ntIPNhbz5W5WJgsHQsLy4JATrQxGrd
        17CxkCwVA1meyjfsDUBXTrz6ZQPmxj2W9KdmtHyWxQtG8MJtQijljhcGb/+RVHU0VHaJLo8W53Adv
        Nui1OWTkrp0C84Z2bkKN5sWDvVDYU2HF7SNgIYJiEMCBfR13/416fteRMbXpMMbgcgM8DjkTejAwQ
        hphyA/VW2FmrJnvc/afWDKGL8BTshsa9N/FFGXBNlaoTFV9sKFwUwd9dRMdm5F5MW3fvbwIXGv/NY
        PltV3i3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKe70-00A7fg-GY; Fri, 12 Mar 2021 09:29:45 +0000
Date:   Fri, 12 Mar 2021 09:29:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     cl@linux.co, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] mm/slab: kmalloc with GFP_DMA32 allocate from
 SLAB_CACHE_DMA32
Message-ID: <20210312092938.GA2412021@infradead.org>
References: <20210312080320.1965201-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312080320.1965201-1-jay.xu@rock-chips.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 04:03:20PM +0800, Jianqun Xu wrote:
> The flag GFP_DMA32 only effect in kmalloc_large currently.
> 
> This patch will create caches with GFP_DMA32 to support kmalloc with
> size under KMALLOC_MAX_CACHE_SIZE.

No.  No new code should use GFP_DMA32, never mind through slab.
Please use the proper DMA APIs for your addressing needs.
