Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CDD3B256D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFXD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXD2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:28:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nyTPVWQigA5b5LTXeTBvmNaJcqPEw9/9blpnGa8JzHY=; b=pOesFcYObMXN92+ab0Ltvyvie4
        KRTMHZMvAsvWJuKFOiJDymZOlIHDjqc59KDoQhmGnqujA/34gQr9fvUFSOLIygdCcL6Raw/ENk3M7
        8sipgSPfGUzqUFdid8gW0eNtWlnmjSwbo9ecdNVWgc0TwnwZNJlI8F/+2sRYF//nzuu4w/h94sMOc
        tOvrGVjZTkeiyag+frtveayVKCmr6NaLImJGU/wTHCjN/iV/3PNJYGksyE07BvIEnbl6LYnLG5g76
        7ssBzFmqkrVWohquIQFbV1IicSzADO6Bqr8JOTrv5ZX7iPutjyGZKshP/I8bLlPvQCjHJ8V4zagme
        rip70Jbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwFyw-00G7yn-HB; Thu, 24 Jun 2021 03:25:08 +0000
Date:   Thu, 24 Jun 2021 04:24:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Huang <chenhuang5@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <YNP6/p/yJzLLr8M8@casper.infradead.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
> In userspace, I perform such operation:
> 
>  	fd = open("/tmp/test", O_RDWR | O_SYNC);
>         access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
>         ret = write(fd, access_address + 2, sizeof(long));

... you know that accessing this at unaligned offsets isn't going to
work.  It's completely meaningless.  Why are you trying to do it?
