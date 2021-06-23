Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB853B1AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFWNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFWNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:07:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00994C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:04:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw2YR-00BX5y-SA; Wed, 23 Jun 2021 13:04:31 +0000
Date:   Wed, 23 Jun 2021 13:04:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNMxX0Do9GSNiXSH@zeniv-ca.linux.org.uk>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <YNKhjkuzXEJrBUA8@zeniv-ca.linux.org.uk>
 <92fa298d-9d88-0ca4-40d9-13690dcd42f9@huawei.com>
 <YNK4OSdoo/4wjhd7@zeniv-ca.linux.org.uk>
 <20210623093220.GA3718@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623093220.GA3718@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:32:21AM +0100, Catalin Marinas wrote:

> On arm64, neither memcpy() nor raw_copy_from_user() are expected to work
> on Device mappings, we have memcpy_fromio() for this but only for
> ioremap(). There's no (easy) way to distinguish in the write() syscall
> how the source buffer is mapped. generic_perform_write() does an
> iov_iter_fault_in_readable() check but that's not sufficient and it also
> breaks the cases where you can get intra-page faults (arm64 MTE or SPARC
> ADI). I think in the general case it's racy anyway (another thread doing
> an mprotect(PROT_NONE) after the readable check passed).
> 
> So I think generic_perform_write() returning -EFAULT if copied == 0
> would make sense (well, unless it breaks other cases I'm not aware of).

It does break the cases of source page eviction under memory pressure.
That aside, why the hell is that memory allowed to be mmaped?
