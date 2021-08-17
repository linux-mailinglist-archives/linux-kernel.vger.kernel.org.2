Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5083EE0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhHQAeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhHQAeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:34:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC3B60F55;
        Tue, 17 Aug 2021 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160426;
        bh=0WyoP9C0dbqqhcVR2hK/9OHEIvTuu5XMiMVutsFRIiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwyo1UD5tdAsySWy2W6wOGyPUwMm3rKPc9MI+AqHQtUDGBtJUOu6XrMMC1YpXVqPh
         bs8wc3zv0ZhP81A/loZzCY5UIFheFlJ1u2JDD7+HpJc7mvkWHFSudN/Z7zRxUKHg+j
         aWuJcTc/EeD8bEzzCDgd+bI82BVMQTUZE18HlCuhXD9lpGG7U9gzzMQ8VyLuLuWzxF
         Kx8i4h8prLkzhc9k4qypdWf46N7xYKEysdwpGdsA9G8h0J2BtCqyfm5l27/Oy0S6xU
         j2d4K570gSahuBncmdkDISA/mTpKAIEV5tO2KXUgp+BpuUzQjgi3CwU8CfCqyZ9Jf9
         uhgxi2kCN9jlw==
Date:   Mon, 16 Aug 2021 17:33:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add missing inline to f2fs_sanity_check_cluster()
 stub
Message-ID: <YRsD6P4x9v38oDWl@google.com>
References: <20210816234247.139528-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816234247.139528-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 08/16, Nathan Chancellor wrote:
> Without this, there is a warning in nearly every fs/f2fs/ file when
> F2FS_FS_COMPRESSION is not set:
> 
> In file included from fs/f2fs/super.c:31:
> fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
> static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>             ^
> 1 warning generated.
> 
> Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")

This has not been merged yet, so if you don't mind, can I integrate your fix in
the original patch?

Thanks,

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0c978f934dcc..fe1097e678da 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4248,7 +4248,7 @@ static inline void f2fs_put_page_dic(struct page *page)
>  	WARN_ON_ONCE(1);
>  }
>  static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
> -static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
> +static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>  static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
>  static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
>  static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
> 
> base-commit: f4b05791dda93edb03ebb6b48f1be104b2e64274
> -- 
> 2.33.0.rc2
