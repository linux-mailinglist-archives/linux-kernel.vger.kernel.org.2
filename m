Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25832A1E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836412AbhCBHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:02:03 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:44090 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835858AbhCBGLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:11:44 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 314571B4053;
        Tue,  2 Mar 2021 15:10:53 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 1226Ap9J626828
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 2 Mar 2021 15:10:52 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 1226Aoc53244048
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 2 Mar 2021 15:10:51 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 1226Ana13244045;
        Tue, 2 Mar 2021 15:10:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     dingsenjie@163.com
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: fat: fix spelling typo of values
References: <20210302034817.30384-1-dingsenjie@163.com>
Date:   Tue, 02 Mar 2021 15:10:49 +0900
In-Reply-To: <20210302034817.30384-1-dingsenjie@163.com> (dingsenjie@163.com's
        message of "Tue, 2 Mar 2021 11:48:17 +0800")
Message-ID: <87ft1eqe52.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dingsenjie@163.com writes:

> From: dingsenjie <dingsenjie@yulong.com>
>
> vaules -> values
>
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/fatent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index f7e3304..860e884 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -771,7 +771,7 @@ int fat_trim_fs(struct inode *inode, struct fstrim_range *range)
>  	/*
>  	 * FAT data is organized as clusters, trim at the granulary of cluster.
>  	 *
> -	 * fstrim_range is in byte, convert vaules to cluster index.
> +	 * fstrim_range is in byte, convert values to cluster index.
>  	 * Treat sectors before data region as all used, not to trim them.
>  	 */
>  	ent_start = max_t(u64, range->start>>sbi->cluster_bits, FAT_START_ENT);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
