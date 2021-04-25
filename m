Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A846536A3C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 02:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhDYAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 20:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhDYAsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 20:48:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2FCF613C4;
        Sun, 25 Apr 2021 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619311658;
        bh=mijs84e9TdAULlSFMzEsjGetGLdyir4mZ+ORmJUQPxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkvpZaFuiMXZxiAo7kTJH47fZSBRkvK4MeVbZuQZVnqR3facBiY/7U1yUxzzSmpw6
         H6hN9sTuGUSinznQNiywDO6aIwjvnONqO4pn7AfL5me9xUF7rA99Je7yW4rTWgeEYe
         w8Zde1WJ7tySt5Oc3+DtfOOoKebLD8I6kf1lTHMwmikfQ277dA0NVLLziGeZokRfZN
         AqNbLcMnvEQKNrOzTZ0/71I0tqc9yD3OkB617y9Th5AIL63JgwSidgKJIW74UmCt/s
         zGFAI3V364zr5zNBaFkFJkYBUy0+mCEv5HGMDVxKtRi+WVa5GBluTIihP4miMChqOR
         +D9aZGoWXwSlw==
Date:   Sat, 24 Apr 2021 17:47:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: compress: remove unneed check condition
Message-ID: <YIS8KHf9VPxZl85b@google.com>
References: <20210421083941.66371-1-yuchao0@huawei.com>
 <YID1sqemJVeBcdqD@google.com>
 <2c6f17e6-ef23-f313-5df2-6bd63d7df2b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6f17e6-ef23-f313-5df2-6bd63d7df2b1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22, Chao Yu wrote:
> On 2021/4/22 12:04, Jaegeuk Kim wrote:
> > On 04/21, Chao Yu wrote:
> > > In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
> > > has checked SBI_POR_DOING condition, and also cluster_may_compress()
> > > has checked CP_ERROR_FLAG condition, so remove redundant check condition
> > > in __cluster_may_compress() for cleanup.
> > 
> > I think cp_error can get any time without synchronization. Is it safe to say
> > it's redundant?
> 
> Yes,
> 
> But no matter how late we check cp_error, cp_error can happen after our
> check points, it won't cause regression if we remove cp_error check there,
> because for compress write, it uses OPU, it won't overwrite any existed data
> in device.
> 
> Seems it will be more appropriate to check cp_error in
> f2fs_write_compressed_pages() like we did in f2fs_write_single_data_page()
> rather than in __cluster_may_compress().
> 
> BTW, shouldn't we rename __cluster_may_compress() to
> cluster_beyond_filesize() for better readability?

f2fs_cluster_has_data()?

> 
> Thanks,
> 
> > 
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >   fs/f2fs/compress.c | 5 -----
> > >   1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > index 3c9d797dbdd6..532c311e3a89 100644
> > > --- a/fs/f2fs/compress.c
> > > +++ b/fs/f2fs/compress.c
> > > @@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
> > >   		f2fs_bug_on(sbi, !page);
> > > -		if (unlikely(f2fs_cp_error(sbi)))
> > > -			return false;
> > > -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> > > -			return false;
> > > -
> > >   		/* beyond EOF */
> > >   		if (page->index >= nr_pages)
> > >   			return false;
> > > -- 
> > > 2.29.2
> > .
> > 
