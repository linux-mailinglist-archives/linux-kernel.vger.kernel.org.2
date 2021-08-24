Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD453F684F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhHXRmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242728AbhHXRjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D472610A7;
        Tue, 24 Aug 2021 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629826006;
        bh=aIgNnNWgoZHQIiACgNhH+aNjlUHVUpf4mP6Hd9AYmJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSeeaSKCriryh/io7TCKIjo5xUuUMX1HI/pARLoZcfeWy6iZBgey5msDgWfNi1Jt6
         Fa1+CM0ITFBVMj8TJJagrs/EL1RhzYW5fu2JQgJlu45MRuQjRmh3TN/nM0s2DZGSxb
         OQZlp05VQv8U3lph0UL3BIVuiwklgjWblZnSTMeHRzXkvYhgKrSQicx2Kq6gEKcJud
         uzcBhnSf2p+RN0g8QU4+RqtP4VErG6UtmEAjfnoHfdfmb6cmT8lb4K5qawm5g9jT/F
         LTyBj1A6GN3etNnhZ/1N+Aucp23md5QmOuLVLNoR59E9OPABVTygWmJKjeEnGDxZmJ
         ss3UjX3PPB97g==
Date:   Tue, 24 Aug 2021 10:26:45 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [PATCH] f2fs: fix wrong option name printed by parse_options()
Message-ID: <YSUr1GS0M7weoRTt@google.com>
References: <20210824011948.15408-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824011948.15408-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24, Chao Yu wrote:
> It prints below kernel message during mounting w/ checkpoint=disable
> option:
> 
> "F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"
> 
> Fix typo "checkpoint=merge" w/ "checkpoint_merge"
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 49e153fd8183..88c66e46bd5c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1289,6 +1289,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		return -EINVAL;
>  	}
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> +			test_opt(sbi, MERGE_CHECKPOINT)) {
> +		f2fs_err(sbi, "checkpoint_merge cannot be used with checkpoint=disable\n");
> +		return -EINVAL;

What about disabling MERGE_CHECKPOINT autmatically?

> +	}
> +
>  	/* Not pass down write hints if the number of active logs is lesser
>  	 * than NR_CURSEG_PERSIST_TYPE.
>  	 */
> -- 
> 2.32.0
