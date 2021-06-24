Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605C3B2DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhFXLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhFXLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:19:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72283C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfReeu0dJKzIeg2BgFYSOkZyK6s3mc3KPP/KhBuenyY=; b=lO3x15aO+H8qwI+t//6WYC7WHl
        RiKchv9n3r6OLd5/pgJ7D1tuZ6EQApIuH0qxL3ElTsS81IwkLNx4341XVBmK43GYpKP7whoRHJ+SS
        VDW2/x4doJcJ9mfCRUAeo4scbtDPzG907T41Vt6iegiLQXukyblzsQV8giGHeMCDDL3hZBtuzbhgy
        dguiNavnzYMI1cLmqywlC9+t5nN3m3Y7iuXVWkLofYfv033zhDCA0zbqTTF/ysSBEpySjbCfysbtV
        HOZXC1NkeT8x/38WqchMcFMR7Q7WUuN/cAtcDy6ZxxA27aUsymihPDj9ICe65lumVAl/fjAsB/wEf
        uQbf292w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwNKl-00GVCu-09; Thu, 24 Jun 2021 11:15:59 +0000
Date:   Thu, 24 Jun 2021 12:15:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <YNRpYli/5/GWvaTT@casper.infradead.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNQuZ8ykN7aR+1MP@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 08:04:07AM +0100, Christoph Hellwig wrote:
> On Thu, Jun 24, 2021 at 04:24:46AM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
> > > In userspace, I perform such operation:
> > > 
> > >  	fd = open("/tmp/test", O_RDWR | O_SYNC);
> > >         access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
> > >         ret = write(fd, access_address + 2, sizeof(long));
> > 
> > ... you know that accessing this at unaligned offsets isn't going to
> > work.  It's completely meaningless.  Why are you trying to do it?
> 
> We still should not cause an infinite loop in kernel space due to a
> a userspace programmer error.

They're running as root and they've mapped some device memory.  We can't
save them from themself.  Imagine if they'd done this to the NVMe BAR.
