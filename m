Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABB36B784
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhDZRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhDZRFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F05061006;
        Mon, 26 Apr 2021 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456710;
        bh=whSWFtRguZn5IvIkXJMILpCPs0/SrQbz5xioyWmUip0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcCrHv6l1XKSipB1kZ6WFIp1UIndqQVKrn2FhsJAdSXUIjHJ1Op+ZLw/l2YlCBowT
         r+T3C6xgLX6QVe4PkKe5q/63+bcHF3AniBLuipOD7+NTxTeX9ML9gO4wwbr3exJCSP
         QZWs4iP9psLGB2KkRtoq46LpOMXoPfaOJ93BhjwKij+iROM/ZX8wu61xrxNO3Eg0VO
         /Sjqo+kI2+IK2pEbNzeL0W6uJ3uaeG9INMxNK0j3DHP/PwX7NwDek+gEe0srjI983X
         5Y8NoOJ4XxGp5rGuX+VSYbdervVGZF+Lu22iH4Y4Y7JLiG2SHe2liRARXoXEfDblVS
         RbK650EgEqGig==
Date:   Mon, 26 Apr 2021 10:05:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: compress: remove unneed check condition
Message-ID: <YIbyxNAaaWUiVDT9@google.com>
References: <20210421083941.66371-1-yuchao0@huawei.com>
 <YID1sqemJVeBcdqD@google.com>
 <2c6f17e6-ef23-f313-5df2-6bd63d7df2b1@huawei.com>
 <YIS8KHf9VPxZl85b@google.com>
 <5d7de7c7-5cc5-c342-3652-ab904b3e43b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7de7c7-5cc5-c342-3652-ab904b3e43b2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25, Chao Yu wrote:
> On 2021/4/25 8:47, Jaegeuk Kim wrote:
> > On 04/22, Chao Yu wrote:
> > > On 2021/4/22 12:04, Jaegeuk Kim wrote:
> > > > On 04/21, Chao Yu wrote:
> > > > > In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
> > > > > has checked SBI_POR_DOING condition, and also cluster_may_compress()
> > > > > has checked CP_ERROR_FLAG condition, so remove redundant check condition
> > > > > in __cluster_may_compress() for cleanup.
> > > > 
> > > > I think cp_error can get any time without synchronization. Is it safe to say
> > > > it's redundant?
> > > 
> > > Yes,
> > > 
> > > But no matter how late we check cp_error, cp_error can happen after our
> > > check points, it won't cause regression if we remove cp_error check there,
> > > because for compress write, it uses OPU, it won't overwrite any existed data
> > > in device.
> > > 
> > > Seems it will be more appropriate to check cp_error in
> > > f2fs_write_compressed_pages() like we did in f2fs_write_single_data_page()
> > > rather than in __cluster_may_compress().
> > > 
> > > BTW, shouldn't we rename __cluster_may_compress() to
> > > cluster_beyond_filesize() for better readability?
> > 
> > f2fs_cluster_has_data()?
> 
> Maybe cluster_has_invalid_data()? which indicates there is invalid data
> beyond filesize.

BTW, we can compress it with zero data?

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > > ---
> > > > >    fs/f2fs/compress.c | 5 -----
> > > > >    1 file changed, 5 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > > > index 3c9d797dbdd6..532c311e3a89 100644
> > > > > --- a/fs/f2fs/compress.c
> > > > > +++ b/fs/f2fs/compress.c
> > > > > @@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
> > > > >    		f2fs_bug_on(sbi, !page);
> > > > > -		if (unlikely(f2fs_cp_error(sbi)))
> > > > > -			return false;
> > > > > -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> > > > > -			return false;
> > > > > -
> > > > >    		/* beyond EOF */
> > > > >    		if (page->index >= nr_pages)
> > > > >    			return false;
> > > > > -- 
> > > > > 2.29.2
> > > > .
> > > > 
> > .
> > 
