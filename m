Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324A23A37AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJXLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFJXLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1FAA613D9;
        Thu, 10 Jun 2021 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623366558;
        bh=sehk7qVLTT99iBgWRG6d/XNEMQO3VwZUaO5rBbGONUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NF4EHiwQE/k2Ptgw6ReqIxI3Y7d3D6jDUeucaY9ot/SZGYXs2GfKym469zY9y+VII
         CMrHBZTY8Hp6MOU9wG7EsYmdBBd3RL2za0ykca8OhXMrgKm3ji2Chc5z8RvaoI1mEB
         TRyd1CupfTyQAlrdCkwsAGDH0dzSsX6YuaAHApth/Hf4dvY2UD7RbpLO0C40u4JPAg
         CIeZ76IJ85ZmCdEvWkXYtT3nDko4D+9CiBsUh9mcOmgg3eFkMT20OS/81Lh9cJkx/I
         FdULipM3yAfUWjl76a3h/hl6OkQxGMAMIQ6NnMLNXoNPwe0MeP3tdZLldV160zWbK5
         ywbbfKlQsQx8Q==
Date:   Thu, 10 Jun 2021 16:09:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
Message-ID: <YMKbncoLgqemjzmu@gmail.com>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org>
 <YLxeynwR0v23c3sV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLxeynwR0v23c3sV@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 10:36:10PM -0700, Jaegeuk Kim wrote:
> Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.
> 
> Note that there are three feature list entries:
> 1) /sys/fs/f2fs/features
>   : shows runtime features supported by in-kernel f2fs along with Kconfig.
>     - ref. F2FS_FEATURE_RO_ATTR()
> 
> 2) /sys/fs/f2fs/$s_id/features <deprecated>
>   : shows on-disk features enabled by mkfs.f2fs, used for old kernels. This
>     won't add new feature anymore, and thus, users should check entries in 3)
>     instead of this 2).
> 
> 3) /sys/fs/f2fs/$s_id/feature_list
>   : shows on-disk features enabled by mkfs.f2fs per instance, which follows
>     sysfs entry rule where each entry should expose single value.
>     This list covers old feature list provided by 2) and beyond. Therefore,
>     please add new on-disk feature in this list only.
>     - ref. F2FS_SB_FEATURE_RO_ATTR()
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> change log from v1:
>  - adjust Eric's comment
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  29 +++-
>  fs/f2fs/f2fs.h                          |   3 +
>  fs/f2fs/sysfs.c                         | 196 ++++++++++++++++--------
>  3 files changed, 163 insertions(+), 65 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
