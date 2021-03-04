Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3F32DB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhCDUVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhCDUVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:21:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDE7D64F69;
        Thu,  4 Mar 2021 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614889220;
        bh=PK2fbfeEfKO2itjb1QWIZjHnUzohmqddhbtXHSB6zF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPTNuML+CXWJc09vt0JYNp710dMBVnLADtpB4+ca+W/0ZIp4JpYS7Mnz0y4PmsJuF
         0Z6IObjrFUS2/EHJ3bz1dGqsJKPryDiRtPUyZGkogQm8ISA+jCHka3xootyQXVQrV6
         vgS9r2c+eItNlycKDnzUm4g2Hq6h9ikuwbHBCnLUAP0mDm85rIPzklf7JMDIrThp1v
         yAbtzBIYK3p0Y+mZD0xwmZPg+FMLty+/Zec/DCWjC0x85qDA3F2W7jCQPlA5p1XZkW
         g7BaFPbA3NicrIr64iedQlKrKcgm02ZxHRzd+S+P2WDrdecAhCxF0aJKtV7OSh2M3T
         vrKQE3J+6hL0A==
Date:   Thu, 4 Mar 2021 12:20:18 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to
 cache compressed blockst
Message-ID: <YEFBAuP26t0RzVHZ@google.com>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDsleDjeIcpuBXKA@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27, Jaegeuk Kim wrote:
> On 02/04, Chao Yu wrote:
> > Jaegeuk,
> > 
> > On 2021/2/2 16:00, Chao Yu wrote:
> > > -	for (i = 0; i < dic->nr_cpages; i++) {
> > > +	for (i = 0; i < cc->nr_cpages; i++) {
> > >   		struct page *page = dic->cpages[i];
> > 
> > por_fsstress still hang in this line?
> 
> I'm stuck on testing the patches, since the latest kernel is panicking somehow.
> Let me update later, once I can test a bit. :(

It seems this works without error.
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9

> 
> > 
> > Thanks,
> > 
> > >   		block_t blkaddr;
> > >   		struct bio_post_read_ctx *ctx;
> > > @@ -2201,6 +2207,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
> > >   		blkaddr = data_blkaddr(dn.inode, dn.node_page,
> > >   						dn.ofs_in_node + i + 1);
> > > +		f2fs_wait_on_block_writeback(inode, blkaddr);
> > > +
> > > +		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
> > > +			if (atomic_dec_and_test(&dic->remaining_pages))
> > > +				f2fs_decompress_cluster(dic);
> > > +			continue;
> > > +		}
> > > +
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
