Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480A3CED6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384485AbhGSS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383708AbhGSSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9DE60232;
        Mon, 19 Jul 2021 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626720598;
        bh=rlRvHesfEjeUlsO8Hwp41C5FiOVzlwcYj70KV6aM430=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSImICV0ySVrVR3XZl3Xw3ry0LlnwYEk3HBW7QQZP1TAwwbEfD4rRqaJDRZECY0ty
         yj3TjzDU7LJFtDv1ntxUu/Wgy9HkJRlMxH41e3Xx7TgwukhBsUaLjTMzz/laRHyh1j
         ElmgTbrKCPw+dxvtBExYdrNCh/QFokPSlt+kU6Clpm1wKLriflubYNMLVAx0zwGCVc
         NLE+EmS1Uq8kf0cJlKN3cWrliF+TM3429JfhU2Xg/XrrLknI9aFneYR42pdMaW5b2q
         bjGW99cfwJmAbIaalyugU8y0mZd/CQJ7ueKgZ5NMzZImmo0xsN1ianOQBbAbsSgept
         Uod9M75DXoOHA==
Date:   Mon, 19 Jul 2021 11:49:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's keep writing IOs on SBI_NEED_FSCK
Message-ID: <YPXJVWflOq1lwoL2@google.com>
References: <20210714231850.2567509-1-jaegeuk@kernel.org>
 <ae44f40d-4727-92af-9f0b-ffb8540da872@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae44f40d-4727-92af-9f0b-ffb8540da872@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Chao Yu wrote:
> On 2021/7/15 7:18, Jaegeuk Kim wrote:
> > SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
> > is not fully critical to stop any IO writes. So, let's allow to write data
> > instead of reporting EIO forever given SBI_NEED_FSCK.
> 
> Well, it looks we need to check why there is SBI_NEED_FSCK flag.
> 
> If this patch breaks something, how about forcing OPU if SBI_NEED_FSCK
> was set?

Yea, let me take that.

> 
> > 
> > Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
> > Cc: <stable@kernel.org> # v5.13+
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 15cc89eef28d..f9b7fb785e1d 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3563,7 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
> >   		goto drop_bio;
> >   	}
> > -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
> > +	if (f2fs_cp_error(sbi)) {
> >   		err = -EIO;
> >   		goto drop_bio;
> >   	}
> > 
