Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD341B8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbhI1VAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242845AbhI1VAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:00:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6E560FC0;
        Tue, 28 Sep 2021 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632862739;
        bh=Gl+jfadpVvNOg2XJ45MvVWQ8l+OKiOdvBFfmcAUq9WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKalrk9XQuztHgAP4K4twJc90Mpy5HxW/4EL063Esk1cB2aTpkCDPOwoJx7WfgPck
         BoRArW/lQRw44gXDmpQJ/oanTSIBeUESshlmOOGgW/VEAtVB5yt0GmkY/L/bHa1qI4
         /FI00FFVBLAfAwKjIyaMUnl8zoxi8GnryHxdQdNSfFJ+C2NZaDjzICaon8YuT8TVFf
         1Pk28j9eP3fmqiqtoFDX5XYc7GhL3NWE0s3/T0FeewGOg5FVSc6+sowAss2HgxErJl
         8A3OirUoaKY5nMbmZKFgIa3wDKNJD5feGoDNgmjCstKS7e0GdO+pVzc82WKZg5hocY
         qweA4xvReocYg==
Date:   Tue, 28 Sep 2021 13:58:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs-tools: fall back to the original version check when
 clock_gettime is not supported
Message-ID: <YVOCEn9xHmHmJdDI@google.com>
References: <20210928204658.2230524-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928204658.2230524-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merged to address android build breakage.

On 09/28, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In lower versions than macOS 10.12, they don't support clock_gettime
> function. It breaks the build, so we need to fall back to the original
> kernel version check algorithm, in that case.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fsck/mount.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 7c4c681..c928a15 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -975,6 +975,16 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
>  		MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
>  		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
>  					c.sb_version, c.version);
> +#if defined(__APPLE__)
> +		if (!c.no_kernel_check &&
> +			memcmp(c.sb_version, c.version,	VERSION_NAME_LEN)) {
> +			c.auto_fix = 0;
> +			c.fix_on = 1;
> +			memcpy(sbi->raw_super->version,
> +					c.version, VERSION_NAME_LEN);
> +			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
> +		}
> +#else
>  		if (!c.no_kernel_check) {
>  			struct timespec t;
>  			u32 prev_time, cur_time, time_diff;
> @@ -1007,6 +1017,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
>  			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
>  		}
>  out:
> +#endif
>  		print_sb_state(sbi->raw_super);
>  		return 0;
>  	}
> -- 
> 2.33.0.685.g46640cef36-goog
