Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6B3E92C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHKNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhHKNhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42858604D7;
        Wed, 11 Aug 2021 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628689016;
        bh=uPiiNoU7abmvTh+81t3BZey2nxgh29+Zkt88SCl39gI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ndb2Q2zAV7a3YGW4i2KHergGhyxjWQPadWdk9t8hyR0EqwRK0pnFPI+3MPUvQzxMC
         PSpsaShqeGL4PrLAMuVt+FLA8TNS0zpsw6rAu2cZe1pTo5xcNVrebL1U+1NHK/NWd1
         zmnF+K46r6Vx/QzofIIaw0WCu02HUOxlGkJPkvej1OYWWvvqS5ZbFeTMgJns+OR0FM
         2QX1y95yottw/cCgMKhqrL5iFoPg6Xn0wzbqwjomBaVso2X4/qy1PqNFCh5jtOYZP5
         oCRK2/Y5M27iYiXiGf6HCBC7ijdMK1UVUW8pyZmtztTS195I5FOg2O9xqqdI4HIPCg
         Zc+X2tWnZ4Tbw==
Subject: Re: [PATCH 1/2] f2fs: fix potential memory leaks in
 create_discard_cmd_control
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210811131826.223141-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <90182f6a-9582-f1a6-e6b6-8f4088e80ce0@kernel.org>
Date:   Wed, 11 Aug 2021 21:36:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811131826.223141-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 21:18, Yangtao Li wrote:
> Release f2fs_issue_discard every time it is destroyed,
> otherwise it will cause memory leaks when remounting.

I didn't get the problem here, could you please explain a bit more about
details?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index afe20c5c3c08..363779a4402d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1741,6 +1741,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
>   
>   		dcc->f2fs_issue_discard = NULL;
>   		kthread_stop(discard_thread);
> +		put_task_struct(discard_thread);
>   	}
>   }
>   
> @@ -2168,6 +2169,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   		SM_I(sbi)->dcc_info = NULL;
>   		return err;
>   	}
> +	get_task_struct(dcc->f2fs_issue_discard);
>   
>   	return err;
>   }
> 
