Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1208C327053
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 06:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhB1FJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 00:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhB1FJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:09:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7555364DEF;
        Sun, 28 Feb 2021 05:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614488953;
        bh=Ej6/D8sPUSzoSYrBsnK9kjX3l7rsK8BCE0b9CJjqLUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1GJ0gRVCEXahurUhNi6t5VsEpwyQPaPvh4qowDcOmdn/4k5vhlnqgJHUEsnrmn19
         pgdmQLizXxd6pcjBbGgbDPJjTOoRz/xObRjJnTGJJYYbto0XyMP7XGGT69v4ZkDxWC
         FGkMfY2TP1QOiKj0jKCIm9vx9obhpJ1sEeSj8c5BA/I5XrwiVYgwFjI53yagGBSwAU
         qUDYJsdYkSrmZSIoua0hzjNx4a5SHn4yZIYGpccbTtoWYUoPj0y6OrwmSriqFSWFd0
         ZckQiM80uPXCrj/J5YzvTpJBjbsr+MnCfQcrAd4hllOXyjKZ7f/vz5VC9msX5/XP2J
         m+NEd4DoDbOyQ==
Date:   Sat, 27 Feb 2021 21:09:12 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v4] f2fs: compress: add compress_inode to cache
 compressed blockst
Message-ID: <YDsleDjeIcpuBXKA@google.com>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04, Chao Yu wrote:
> Jaegeuk,
> 
> On 2021/2/2 16:00, Chao Yu wrote:
> > -	for (i = 0; i < dic->nr_cpages; i++) {
> > +	for (i = 0; i < cc->nr_cpages; i++) {
> >   		struct page *page = dic->cpages[i];
> 
> por_fsstress still hang in this line?

I'm stuck on testing the patches, since the latest kernel is panicking somehow.
Let me update later, once I can test a bit. :(

> 
> Thanks,
> 
> >   		block_t blkaddr;
> >   		struct bio_post_read_ctx *ctx;
> > @@ -2201,6 +2207,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
> >   		blkaddr = data_blkaddr(dn.inode, dn.node_page,
> >   						dn.ofs_in_node + i + 1);
> > +		f2fs_wait_on_block_writeback(inode, blkaddr);
> > +
> > +		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
> > +			if (atomic_dec_and_test(&dic->remaining_pages))
> > +				f2fs_decompress_cluster(dic);
> > +			continue;
> > +		}
> > +
