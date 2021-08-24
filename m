Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DD3F597E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhHXH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHXH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:56:34 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:55:50 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 083FAC01E; Tue, 24 Aug 2021 09:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1629791748; bh=HY+s8dAWtBVC1NQcYR31Db/d1oIyDMY7BPmWngYbVZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBHh5DF50poo1yzJfA1GqA/00aB5BKQ/G3LAcXJ40cn2/pj7ZViOt4hY0YtU7bkPZ
         LNOtRz9aWLllJ5zGHqhW+dwhCmT7iN/DIrnMNgoQbvHsFwoqt/Dc4Bqsa+/9kR6i++
         C6iomiSA1X4RutIn6lJKh1FISb8Vi2coTN0GZT6mZwVqyYzjMCiRDmPiUFXQOcw+hT
         dJhh9tM6cpHKYQy1sEOlw03PrDPKBUFYx0KYvRv5n0clThYHFulQ5DB4KRIEzHbYsY
         JoZliCsoYpare683mvUWBSyCIHwftVLJzcm/vNNR8mVvYDF2zsuKZYLwsq1o3mEyy3
         lHhQyvmSZw5eg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AA486C009;
        Tue, 24 Aug 2021 09:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1629791738; bh=HY+s8dAWtBVC1NQcYR31Db/d1oIyDMY7BPmWngYbVZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfYtPwxvKrGTs41RMrmtnBWOMZe3VubriCrlVblZYLf+zwBFoEX5HSgjAmVpob2V0
         1WdavT3SqhOEh7njThH4OJngu9BXo6bgt2mJCklinf6GXejcemnAX8iS+yuxp0XZrc
         Qb04bhVA5vdxNKb3tyjpYTj2YMvCfWvOPsvZdfO+BBgcfMom5FdbP/1J9YIl9CFRhM
         ylQdYdH76bZNgFgp3qvw4VVMlzIjV9ovhAT4U63JZcdJompvSHHJNYJuVT0qFxMZMU
         YjCS8yM/92dvCwayGijpguNQxVkdbkBQWWlgEt6tTovqn7IlHq0C4hmWWn/WP5t/sl
         ziwNQ8GrVrCQQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id cce5ff41;
        Tue, 24 Aug 2021 07:55:29 +0000 (UTC)
Date:   Tue, 24 Aug 2021 16:55:14 +0900
From:   asmadeus@codewreck.org
To:     cgel.zte@gmail.com, Jeff Layton <jlayton@kernel.org>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs: 9q: remove unnecessary label "out_err"
Message-ID: <YSSl4tPGeowannmy@codewreck.org>
References: <20210824074503.62333-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210824074503.62333-1-ran.xiaokai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com wrote on Tue, Aug 24, 2021 at 12:45:03AM -0700:
> From: CGEL <ran.xiaokai@zte.com.cn>
> 
> due to commit 798b2ae3cd58 ("Merge remote-tracking branch
> 'file-locks/locks-next'"), label "out_err" should be removed to
> avoid build warning.

That commit is not in master (it's a linux-next commit), you cannot
refer to a commit id that hasn't been merged in commit messages.
Also given it's a trivial merge commit so please take a minute to find
the real culprit (fs: remove mandatory file locking support) next time.


Given it's not merged yet, Jeff can still fix his patch in his branch,
I've added him to recipients -- can you remove the label?
I've never used mandatory file locking myself so I'll admit I didn't
really look at your patch the other day...

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: CGEL <ran.xiaokai@zte.com.cn>
> ---
>  fs/9p/vfs_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 978666530d8e..d2d83163d6b0 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -319,7 +319,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
>  		ret = v9fs_file_getlock(filp, fl);
>  	else
>  		ret = -EINVAL;
> -out_err:
> +
>  	return ret;
>  }

Thanks,
-- 
Dominique
