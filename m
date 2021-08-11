Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C943E92D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhHKNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhHKNkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:40:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5841A60F56;
        Wed, 11 Aug 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628689226;
        bh=emclmPkr2pkmYes0OwQt9cn7VPGaZs07M35hp5zRS04=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZuLexe4hdSRZWNRENXBh6gVThXxe9CfcLT4oWfpZ3mWJmfojr+8UNOleW0pe1VmR9
         l1rxMTip5wSbayqjSqIah6kphD7Amv4bfAGDzQ/8v+zKXpIBHMKTpo3XLQ7o/LoyH4
         1yVZzC78X1QnNqnI6zejHoCtSL75NTEZrb6GPDaN7mGOo9RqllFqygqye+cM58SECM
         XglqcB6xSskM2SVSVuyMBw3YGnd35oosLEtLrT0DIm+pXyVNiRrScVB/B8QVoVQREc
         Vz9pkt+SDyKLE+pXXsnvScbebsgk2tPgGZGNwBz1N7VOdntoMmLtKV70DptDsQGQZ9
         zEi7ouDLirxlg==
Subject: Re: [PATCH v2] f2fs: warn on when fsck flag is set
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210811133013.225825-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <17ecb791-efa0-3e81-f9e5-eef321011b9e@kernel.org>
Date:   Wed, 11 Aug 2021 21:40:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811133013.225825-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 21:30, Yangtao Li wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
> this flag is set in too many places. For some scenes that are not very reproducible,
> adding stack information will help locate the problem.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -convert to WARN_ON
> -one more blank
>   fs/f2fs/f2fs.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 67faa43cc141..2e2294234c0d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -33,7 +33,7 @@
>   #else
>   #define f2fs_bug_on(sbi, condition)					\
>   	do {								\
> -		if (WARN_ON(condition))					\
> +		if ((condition))					\

Why removing WARN_ON()?

>   			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
>   	} while (0)
>   #endif
> @@ -1999,6 +1999,8 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>   
>   static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>   {
> +	WARN_ON(type ==  SBI_NEED_FSCK);

Again, please remove one unnecessary blank character before SBI_NEED_FSCK.

WARN_ON_ONCE(type == SBI_NEED_FSCK)

> +

No need to add blank line.

Thanks,

>   	set_bit(type, &sbi->s_flag);
>   }
>   
> 
