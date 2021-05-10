Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54437930B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhEJPwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhEJPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28A7B61400;
        Mon, 10 May 2021 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620661866;
        bh=hkkN+e6e7hZtW2JQW0aa8RC0nE8vCe5rD2p3FvXk50E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nblvgp3EbIdEG81sFNJ3PTuF5B+s+jMhc6DEgWFY5O6jJeNNFHTvl+Y2H2vS6KrsW
         LVtHaM86EL7RCZwQPUGfhTUGDMkOXUTzMX+vgAcqZ6zDHK8FZ2rCtrliI3HOq0ruN5
         cCNYPHJgvUINKEeOeJ5j02qtjmFuH+eXAxf6wNfCsWFIVsIv8jyU1XEwa7CLPOGXrH
         aBCN8gvWGdzZTKIxSTEbLGajPFV6i5D9J6qx4rw/rd4YRFifdrdtvu9dI6p9OUoPhI
         Bjw+2afV1Nb1NqMfw4fCchF+qtVu9yXjvpKObIZEpBuBlDk0HIfPpotsJgLPkHbRd/
         HRsoEHMI+fj7g==
Date:   Mon, 10 May 2021 08:51:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/3] f2fs: compress: fix to call f2fs_put_dnode() paired
 with f2fs_get_block()
Message-ID: <YJlWaOSZNLkdGNnQ@google.com>
References: <20210510093032.35466-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093032.35466-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Chao Yu wrote:
> f2fs_get_block() and f2fs_put_dnode() should be called as a pair,
> add missing f2fs_put_dnode() in prepare_compress_overwrite().
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c208563eac28..d5cb0ba9a0e1 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1088,6 +1088,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  
>  		for (i = cc->cluster_size - 1; i > 0; i--) {
>  			ret = f2fs_get_block(&dn, start_idx + i);
> +			f2fs_put_dnode(&dn);

f2fs_reserve_block()
 -> need_put = true;
  -> f2fs_put_dnode();

>  			if (ret) {
>  				i = cc->cluster_size;
>  				break;
> -- 
> 2.29.2
