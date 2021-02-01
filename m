Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82CA30A7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhBAMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBAMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BB064DAF;
        Mon,  1 Feb 2021 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612183241;
        bh=jhwNBzyC/o5yTSw30Y9cZ74FJik5O4OyLsFrVMfWDRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RLlnLX+rmgNDp499ERxzP8bzTrBS5b6WICyo9JpIfcCv6rkT2AjXMklnCvzJ50fHI
         rSeB61QY7x0FNSuzUOXf0EqmOt3HZD2cf/xmb4sZc5QM5GOJz4amvLearRuKRoIcBh
         mUBGyF7jjmMFojxaRjsNkl1/QpJFyseMMllcFc7Z0WNjfZNJi+EXIzz1TkTkxeOqCR
         0w2pz2dpryvi0ujsFG0y/hVP4tqSS3iaW7MH6pqE5r2H3xi5a3ZKWDzKUhmb+KWouz
         9dZTXnL+0sbSJlIo3C/Bd65k3i4nGdiBB2uXvvyjZwSfrrmnGMZrEnNnDxSmw3By8G
         iMVsFfEzBJkuw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint mount option wrong
 combination
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210201000606.2206740-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
Date:   Mon, 1 Feb 2021 20:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201000606.2206740-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/1 8:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> As checkpoint=merge comes in, mount option setting related to
> checkpoint had been mixed up. Fixed it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/super.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 56696f6cfa86..8231c888c772 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -930,20 +930,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				return -EINVAL;
>   			F2FS_OPTION(sbi).unusable_cap_perc = arg;
>   			set_opt(sbi, DISABLE_CHECKPOINT);
> +			clear_opt(sbi, MERGE_CHECKPOINT);
>   			break;
>   		case Opt_checkpoint_disable_cap:
>   			if (args->from && match_int(args, &arg))
>   				return -EINVAL;
>   			F2FS_OPTION(sbi).unusable_cap = arg;
>   			set_opt(sbi, DISABLE_CHECKPOINT);
> +			clear_opt(sbi, MERGE_CHECKPOINT);
>   			break;
>   		case Opt_checkpoint_disable:
>   			set_opt(sbi, DISABLE_CHECKPOINT);
> +			clear_opt(sbi, MERGE_CHECKPOINT);
>   			break;
>   		case Opt_checkpoint_enable:
>   			clear_opt(sbi, DISABLE_CHECKPOINT);
> +			clear_opt(sbi, MERGE_CHECKPOINT);

What if: -o checkpoint=merge,checkpoint=enable

Can you please explain the rule of merge/disable/enable combination and their 
result? e.g.
checkpoint=merge,checkpoint=enable
checkpoint=enable,checkpoint=merge
checkpoint=merge,checkpoint=disable
checkpoint=disable,checkpoint=merge

If the rule/result is clear, it should be documented.

Thanks,


>   			break;
>   		case Opt_checkpoint_merge:
> +			clear_opt(sbi, DISABLE_CHECKPOINT);
>   			set_opt(sbi, MERGE_CHECKPOINT);
>   			break;
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   		return -EINVAL;
>   	}
>   
> -	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> -			test_opt(sbi, MERGE_CHECKPOINT)) {
> -		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
> -		return -EINVAL;
> -	}
> -
>   	/* Not pass down write hints if the number of active logs is lesser
>   	 * than NR_CURSEG_PERSIST_TYPE.
>   	 */
> 
