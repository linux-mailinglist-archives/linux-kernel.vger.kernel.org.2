Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15B3B2EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFXMNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFXMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:13:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57336C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QH9oNP4WxmW/vqhGxs1tvug21wBWTRQZH4Pz9lfIN0w=; b=fCAvHGokMgzygcSaFz3S9lmVOO
        q0dtFwlNDb6upr5nxand1xWi4g7sykXK08St9vEnu5zsOqVVESgQO5OK3sozKz2MdRukHMDbJ6x1W
        NM1tnDSi/oevECgfaVqHsQYqDQZYkgaY8inkBm+0CD/cYzV4J4LkBtsjWDCLubwdk6CLLz8hDDYkV
        YBG2YwZTIqZ7I0PG/rEwzPH5JSBoxLjels54hDDj7oJc/7AaazqK5mcIZd0HFCJu0MRCuDrxOQfSv
        FLppucvxAGePCIABaV6ZRhREoyFVRv5A6evXuwvDFv0V7Q7qNcKU+8SIYbFqvirpngMhJ5kn2q1+p
        7UyuCEeg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOC3-00GYDo-SO; Thu, 24 Jun 2021 12:10:58 +0000
Date:   Thu, 24 Jun 2021 13:10:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <YNR2S02hWS2hwNiz@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:47:31AM +0100, Robin Murphy wrote:
> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
> that was the original behaviour anyway. However the implications of
> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
> should only be relevant if mem_encrypt_active(), so it probably does make
> sense to have an additional runtime gate on that.

Yeah, a check for that would probably be useful.
