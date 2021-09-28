Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD56041B6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbhI1TJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242155AbhI1TJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1A6A61209;
        Tue, 28 Sep 2021 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632856095;
        bh=fBHQNVYni7drO15VqxNgNsWT8o0vf2pPho5LYOalSRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnpH9gDVSVlXr0aZrYOoY3tVtnsZ1nVyg0JOOHTM9WoJ42V+Z87TT2zYROFgX7Nky
         izF1Uue4tgAx2q0ZiX/lBTl2Exqnfboptzkr9jSgKjnJ2AolissG/LAekzxyjXEbjW
         7deKIW9u2yhceCfxFyoMKyMYYSef1kYxm6qV3iHzevty4bRfh9U5Y3QEK2VimaT8UH
         W9ZLyiRY5DK1Jf60+hkXgl3WKB0DdoY4s5PTTSHorUZ2ycbn8Dv+UiOLPlBcg/x6Ym
         qups0fDbeEQwfR/8gjbpAUvCSeOhChmwRICo6Cl1FwwseQ8nZq9Mup/qIFPhdRDOEI
         cW6hNOKH2dGYA==
Date:   Tue, 28 Sep 2021 12:08:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: skip f2fs_preallocate_blocks() for overwrite case
Message-ID: <YVNoHudG5c65X85G@google.com>
References: <20210928151911.11189-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928151911.11189-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28, Chao Yu wrote:
> In f2fs_file_write_iter(), let's use f2fs_overwrite_io() to
> check whethere it is overwrite case, for such case, we can skip
> f2fs_preallocate_blocks() in order to avoid f2fs_do_map_lock(),
> which may be blocked by checkpoint() potentially.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 13deae03df06..51fecb2f4db5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4321,6 +4321,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		preallocated = true;
>  		target_size = iocb->ki_pos + iov_iter_count(from);
>  
> +		if (f2fs_overwrite_io(inode, iocb->ki_pos,
> +						iov_iter_count(from)))
> +			goto write;

This calls f2fs_map_blocks() which can be duplicate, if it's not the overwirte
case. Do we have other benefit?

> +
>  		err = f2fs_preallocate_blocks(iocb, from);
>  		if (err) {
>  out_err:
> -- 
> 2.32.0
