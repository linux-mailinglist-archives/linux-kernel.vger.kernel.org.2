Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC83B2827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFXHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFXHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:07:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5809DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsbMe0UYJrl3p5Jyun5PuLc/wVC9inJZkiV8VlIDno4=; b=otL3DrhgXFR1s1ccV9fei0VdBK
        9L9kjUtOnSNzhxyLfCl7aIjOCP5w7DJwBt/OfSIsdm2Bec69K/nSdXpkd1Y+oHrJs4pegNRFmcm+U
        BYz87OLaIiHUr7fi0fSiUERbOsO3EM7ImdBCQ56tiFsFz8KdOQKnnE/M/3bzeP9yJPhDjMT/w4SdK
        DXWnrUvuKy5XfCKWRrx3A+bRl9KIYGk3YrTntpj9fu2kcnoRipjxiYTgPwtDHgJbQAsNBcuj8lgSD
        2Npis0lLGF+kBn0EX/ATcCN3P5rs6Hlqn2637NVqiRwzST42HlehatdaIR+fH80gIRIZ3jrU8Nx9V
        mNEYqkXg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwJPD-00GHgJ-PW; Thu, 24 Jun 2021 07:04:13 +0000
Date:   Thu, 24 Jun 2021 08:04:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNQuZ8ykN7aR+1MP@infradead.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNP6/p/yJzLLr8M8@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:24:46AM +0100, Matthew Wilcox wrote:
> On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
> > In userspace, I perform such operation:
> > 
> >  	fd = open("/tmp/test", O_RDWR | O_SYNC);
> >         access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
> >         ret = write(fd, access_address + 2, sizeof(long));
> 
> ... you know that accessing this at unaligned offsets isn't going to
> work.  It's completely meaningless.  Why are you trying to do it?

We still should not cause an infinite loop in kernel space due to a
a userspace programmer error.
