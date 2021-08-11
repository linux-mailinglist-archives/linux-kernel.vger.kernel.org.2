Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F293E91E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhHKMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhHKMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBFF860FD9;
        Wed, 11 Aug 2021 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628686209;
        bh=XrnVlW9yQyXAgrKI++FIwfqsSND7wqcHNFFTWnOl7Go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tOKh+EgD/Ulo9JRzEd+3VI/YnzdcQowxG3I90r5ppWv956X2yT101p5as8YimFk5z
         fLzaWUiV8UgQGOBoGyVpE0QP4V796uAJ2Xp0sgGQiPutr6lHKhOw1CtiS4KhG+t2PA
         dsGKEt4Vz+JTkb+5GcfCgQWXDuhx1vndUpfq83eM09UcLihzL2qNINNWnAG3PDzi9S
         NgWrpJyjPCaHnG3p/0460f1zrMGxu4W8p7b2NbmVseYMFU6qFwrduqpPkw6BrUDyvD
         auu9pydSLTP6CHtPXNLWtDU9CdwjqEClX0RXfK+1qUihK1js5XRA1/LR8MslEj3IZr
         g3rueqSnwN/QQ==
Subject: Re: [PATCH] f2fs: warn on when fsck flag is set
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210811101608.197664-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <94c463e8-264b-47e6-f2d6-c7c42a6e3d80@kernel.org>
Date:   Wed, 11 Aug 2021 20:50:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811101608.197664-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 18:16, Yangtao Li wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
> this flag is set in too many places. For some scenes that are not very
> reproducible, adding stack information will help locate the problem.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 67faa43cc141..7e185446d2df 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1999,6 +1999,7 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>   
>   static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>   {
> +	WARN_ON_ONCE(type ==  SBI_NEED_FSCK);

One more blank character.

>   	set_bit(type, &sbi->s_flag);
>   }
>   
> 
