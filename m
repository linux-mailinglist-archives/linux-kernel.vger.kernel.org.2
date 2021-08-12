Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFF3EABDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhHLUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237149AbhHLUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F65F6103E;
        Thu, 12 Aug 2021 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628800569;
        bh=RmFGxQfXzDz3U9Ov7558Sj1L2+CQkR4vX9DtlN2wACg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIZe0Ibzub92QxH6g7FhkwsJZfZYJPlHxG56XDlecDAXhnbrZ1ac0t+EpYFUw+6iD
         vaFn5SDJPLd4Vx6rY+TP4I7RGbx/J7NlFJidoBv12M6UR5xGItC2R06QtPmlTPzHqJ
         7unkcZ7eiksTDPiP5C2+abzH84adw7sX6rC2wrJiaaAOlWdkUJnaEN6eQKyKJGUntj
         pjwyJ14U6prpPMfnRH7EYKKQt8BcvvZQan/l0HCdHingfR6KDV1oFDlCGrCBnniUoh
         ONEYN9U7Zu+UDhYRUYMGX0KvhOUFHhJZfOMvS8oj70zPIdb4Jw8bWOmAj39nSyC9Of
         /7LQtajWVAtVg==
Date:   Thu, 12 Aug 2021 13:36:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: warn on when fsck flag is set
Message-ID: <YRWGN+u09OFHAYOp@google.com>
References: <20210811133733.227456-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811133733.227456-1-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11, Yangtao Li wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
> this flag is set in too many places. For some scenes that are not very
> reproducible, adding stack information will help locate the problem.

Can we add an error history and expose it in sysfs?

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -Remove extra parentheses
> v2:
> -Convert to WARN_ON
> -One more blank
>  fs/f2fs/f2fs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 67faa43cc141..0d08e31214a3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -33,7 +33,7 @@
>  #else
>  #define f2fs_bug_on(sbi, condition)					\
>  	do {								\
> -		if (WARN_ON(condition))					\
> +		if (condition)						\
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
>  	} while (0)
>  #endif
> @@ -1999,6 +1999,8 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>  
>  static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>  {
> +	WARN_ON(type ==  SBI_NEED_FSCK);
> +
>  	set_bit(type, &sbi->s_flag);
>  }
>  
> -- 
> 2.32.0
