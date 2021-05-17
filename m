Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F48383B43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhEQR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhEQR3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E1860FDB;
        Mon, 17 May 2021 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621272467;
        bh=XEjLvdy0CWJOwACIZyypbKf5Baefw5IgizZM3DSDsOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKkUoCkRwjSqbF2vpGLse+53r6EzeCWPt7SVerxnnYnOzfdwZ61CLDFfYDXCfycFi
         dspssmA7VWLGheh5gLMKLZeKe07whbcZfwknycQgwGybq2ZPH3dcwkDjgqg8HxMrs5
         z2BtP4yXrCQ4OdUMou1LAHFhNoiEqlFqB1jbMxepbpa9hIpkckL+FpmHPmZSTGLErN
         eIs1/BuQeXZ67BPsHVo2MJsxVJMR33IZt/4aMJ9hjgc0DkXT7UoaPovQA0M1vQ928T
         J8/IMVmFBs7oGVelUzb7wHMRl1GOr1vwiga2MKYsjhLv4UJyh98n2GPpnhZr6BQnqX
         cWkp1nQQUK+Tg==
Date:   Mon, 17 May 2021 10:27:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, marcosfrm <marcosfrm@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add MODULE_SOFTDEP to ensure crc32c is
 included in the initramfs
Message-ID: <YKKnkSag35cDXh0Z@gmail.com>
References: <20210517011557.21722-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517011557.21722-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 09:15:57AM +0800, Chao Yu wrote:
> As marcosfrm reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213089
> 
> Initramfs generators rely on "pre" softdeps (and "depends") to include
> additional required modules.
> 
> F2FS does not declare "pre: crc32" softdep. Then every generator (dracut,
> mkinitcpio...) has to maintain a hardcoded list for this purpose.
> 
> Hence let's use MODULE_SOFTDEP("pre: crc32") in f2fs code.
> 
> Fixes: 43b6573bac95 ("f2fs: use cryptoapi crc32 functions")
> Reported-by: marcosfrm <marcosfrm@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3f8a7a6c250c..fa0ce6301c16 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4431,4 +4431,5 @@ module_exit(exit_f2fs_fs)
>  MODULE_AUTHOR("Samsung Electronics's Praesto Team");
>  MODULE_DESCRIPTION("Flash Friendly File System");
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc32c");

Shouldn't it be crc32, not crc32c?

- Eric
