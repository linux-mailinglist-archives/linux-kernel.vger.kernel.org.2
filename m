Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F33CCFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhGSISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235642AbhGSISp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 678D16100C;
        Mon, 19 Jul 2021 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626683018;
        bh=psjqFkgBEdDqYXlksaHaln38UuS8wGxXvJHwZlCLzbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p9uWOVEbJZ81vMLz3GvXjxBZCrKXPWO3uk5YbvM3O7HaOlEMLAzLVvG6Z72vUtpk6
         Pf0qRZLW1vaoHR1jSMwKPP0P6S+/HFoIoF9a4W1tuD3VsiLDe6n2aNp8P1MlH1kKji
         zfnJQ/Yzg0UK7+QPUovRTSmPQsmRcthEUFgoTo20de4WGjtfpyHuJGrhUp3By2Uiqo
         wB3qMBalTYOoypDkDz72Bluv+u0A2VWcgnxC+Hp4vD2Xe/15NxHndeCUL4CEMPfDdT
         0RuXvb+s/GsQulNJ6EdU5CKufX/1jwqOq32nsZGCao9zLfR1IQxey8Nk+hfWfeEhtr
         8FDTUWDIychOQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's keep writing IOs on SBI_NEED_FSCK
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
References: <20210714231850.2567509-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ae44f40d-4727-92af-9f0b-ffb8540da872@kernel.org>
Date:   Mon, 19 Jul 2021 16:23:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714231850.2567509-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/15 7:18, Jaegeuk Kim wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
> is not fully critical to stop any IO writes. So, let's allow to write data
> instead of reporting EIO forever given SBI_NEED_FSCK.

Well, it looks we need to check why there is SBI_NEED_FSCK flag.

If this patch breaks something, how about forcing OPU if SBI_NEED_FSCK
was set?

> 
> Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
> Cc: <stable@kernel.org> # v5.13+
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 15cc89eef28d..f9b7fb785e1d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3563,7 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>   		goto drop_bio;
>   	}
>   
> -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
> +	if (f2fs_cp_error(sbi)) {
>   		err = -EIO;
>   		goto drop_bio;
>   	}
> 
