Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E239E49A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFGRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhFGRAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:00:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06C161003;
        Mon,  7 Jun 2021 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623085101;
        bh=3OHaxHnrqCqFc0XRzdeLGi3zdP/7IfOv5Abe7zqPa7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgtpeJ8qZx2HSNVeYNsZuWDcOfoWb8mf5uM9QGjl321kTmaTz2y+ne3B6ie9cs1K1
         Wvt8sm9k4C2IRs5qFpMiSS+aCiZpfpHrCKBnoRlQ5sshUfPDLXELSM88QG32nMlzHw
         oa1TUkrfZoCsCHncc9DFm035yv2rk0QI3wDzVAhPUFMm8p8YxEvGL+fMVjCxxJOrKH
         5lF1rQqOb3rpfy/p+pePY1x0hnKCsCk9yRyHynXyo/2iVLu4OFqwyMyioCvKinnAAc
         1t7LoUWMLrfxoTYyi+IvTJxKf1UDz9QxZPglFf2xE8EorawrGmuEN/8sKyTmTaeoxQ
         sI2CIj0ccW2NQ==
Date:   Mon, 7 Jun 2021 09:58:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
Message-ID: <YL5QLFl4RKpL/vAR@google.com>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org>
 <YLxeynwR0v23c3sV@google.com>
 <f8edad10-dfad-d12e-9c60-e007d132fbda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8edad10-dfad-d12e-9c60-e007d132fbda@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07, Chao Yu wrote:
> On 2021/6/6 13:36, Jaegeuk Kim wrote:
> > Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.
> > 
> > Note that there are three feature list entries:
> > 1) /sys/fs/f2fs/features
> >    : shows runtime features supported by in-kernel f2fs along with Kconfig.
> >      - ref. F2FS_FEATURE_RO_ATTR()
> > 
> > 2) /sys/fs/f2fs/$s_id/features <deprecated>
> >    : shows on-disk features enabled by mkfs.f2fs, used for old kernels. This
> >      won't add new feature anymore, and thus, users should check entries in 3)
> >      instead of this 2).
> > 
> > 3) /sys/fs/f2fs/$s_id/feature_list
> >    : shows on-disk features enabled by mkfs.f2fs per instance, which follows
> >      sysfs entry rule where each entry should expose single value.
> >      This list covers old feature list provided by 2) and beyond. Therefore,
> >      please add new on-disk feature in this list only.
> >      - ref. F2FS_SB_FEATURE_RO_ATTR()
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> > +static struct kobj_type f2fs_feature_list_ktype = {
> > +	.default_groups = f2fs_sb_feat_groups,
> > +	.sysfs_ops	= &f2fs_feature_list_attr_ops,
> > +	.release	= f2fs_feature_list_kobj_release,
> > +};
> > +
> > +
> 
> Nitpick, one redundant blank line.

Done.

> 
> Thanks,
