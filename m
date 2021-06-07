Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C839DE3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGOCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGOCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A838061107;
        Mon,  7 Jun 2021 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623074440;
        bh=fb1SGOtDSePU0nH/toqqH2I5mjcpc4qNNrsdyTT80+0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gvG2vaVFv5OmgyWZ2YGypIotKmv6VX/GBD8KoBAwJd+yODAZ5xi5+FCPHQ7NFLwLs
         GktYBgTvYgT16rfQaiHKZHryWNcZRFjQ/dNfQOigRsFLFE9XJIY+bNIJp8/VJLsLxe
         KTDZ0Yj11kr7w/V8H1fcpCUKaak7TKCMs/Z59aJHR5ZiL76HtLeA14c9u9QDXRfEGA
         oxV1BFjt8PhyLFLvt6p+Cs45bCy0zoVeyc53d2f/D4GDKIMCrGdaxlSdYqcDMHAE2+
         v8PgD9o6KphOJEGWWdnUWHMfaLxXG73ANTCv13FGILeywDjnPLtNkNHwjJYzXwMN7v
         IXkJQZndkeIMQ==
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org> <YLxeynwR0v23c3sV@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f8edad10-dfad-d12e-9c60-e007d132fbda@kernel.org>
Date:   Mon, 7 Jun 2021 22:00:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLxeynwR0v23c3sV@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/6 13:36, Jaegeuk Kim wrote:
> Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.
> 
> Note that there are three feature list entries:
> 1) /sys/fs/f2fs/features
>    : shows runtime features supported by in-kernel f2fs along with Kconfig.
>      - ref. F2FS_FEATURE_RO_ATTR()
> 
> 2) /sys/fs/f2fs/$s_id/features <deprecated>
>    : shows on-disk features enabled by mkfs.f2fs, used for old kernels. This
>      won't add new feature anymore, and thus, users should check entries in 3)
>      instead of this 2).
> 
> 3) /sys/fs/f2fs/$s_id/feature_list
>    : shows on-disk features enabled by mkfs.f2fs per instance, which follows
>      sysfs entry rule where each entry should expose single value.
>      This list covers old feature list provided by 2) and beyond. Therefore,
>      please add new on-disk feature in this list only.
>      - ref. F2FS_SB_FEATURE_RO_ATTR()
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> +static struct kobj_type f2fs_feature_list_ktype = {
> +	.default_groups = f2fs_sb_feat_groups,
> +	.sysfs_ops	= &f2fs_feature_list_attr_ops,
> +	.release	= f2fs_feature_list_kobj_release,
> +};
> +
> +

Nitpick, one redundant blank line.

Thanks,
