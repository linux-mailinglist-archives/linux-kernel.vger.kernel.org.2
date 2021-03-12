Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE4338F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhCLOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhCLOEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:04:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BAD064FFB;
        Fri, 12 Mar 2021 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615557850;
        bh=Z08KZd6XrMC6qRWdyb9R0p3Owz2c8ouzIqWGshwdS5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJE8acp0N06zbLPyerx23BzjyRy1DimyrdB/y9XdHQ+nQR0Jh0dZHJVWPdqJtJR1V
         fs65+hQUbaUrfleJ/Srfak8oSBFLXeEQ88fm0CdvIET/cI9thvVbsnJbCS93LRoziH
         YtXwJnQrNVNf4NDU1/Q/CoW5mwovfuLw5apyfsdk=
Date:   Fri, 12 Mar 2021 15:04:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
Message-ID: <YEt00vJ6oVfoRjSJ@kroah.com>
References: <20210312122531.2717093-1-daeho43@gmail.com>
 <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 10:56:13PM +0900, Daeho Jeong wrote:
> Thanks for suggesting me sysfs_emit().
> 
> For atomic values, actually, those are needed for writer part, not reader.
> 
> +#define add_compr_block_stat(inode, blocks)                            \
> +       do {                                                            \
> +               struct f2fs_sb_info *sbi = F2FS_I_SB(inode);            \
> +               int diff = F2FS_I(inode)->i_cluster_size - blocks;      \
> +               atomic64_add(blocks, &sbi->compr_written_block);        \
> +               atomic64_add(diff, &sbi->compr_saved_block);            \
> +       } while (0)
> 
> I needed a protection here, because they might be updated in the race condition.

Why?  What are you trying to protect from "racing" here?

thanks,

greg k-h
