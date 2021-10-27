Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9943D6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJ0Wgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhJ0Wgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4A7060EBD;
        Wed, 27 Oct 2021 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635374061;
        bh=4SqiEoUxJz4vtG++4/zpHHHXF6cTsG3IDqC+tBAV7BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1nbimgnUwu6ytcWSdSaArsq65+JkZFDoLif7EkFAQ8WHU3MX54WUEux3Av50svpQ
         wf4w1OqedzwetZ8vWSbmM1EduhPPR0TATul/CtZEV660GawZFZ46RkApwjRxwDrG96
         ihV7BTLZt6eEaHegdcKQbZsuajei28HAsHsdWD4/cWz8ZrX63wlw06lknPPRqsgXNn
         H23kwiDxVpRGt+sFIFXbxVLC8VIrEykXvp9ocBS/vH3OQMikto3PBcVBWe91gImCWi
         ChgBlLlCx1zo9my4ngeFNFoEjVBO8dVeS1lwwbDmPuU66fW/Xz8lCw7rOlpQoRhhe3
         GxciBF6wlzCNQ==
Date:   Wed, 27 Oct 2021 15:34:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix incorrect return value in
 f2fs_sanity_check_ckpt()
Message-ID: <YXnT7BcopqAG8Fe6@google.com>
References: <20210922152705.720071-1-chao@kernel.org>
 <20210924095021.GA16651@duo.ucw.cz>
 <4897a06a-9f9e-27ce-91d3-58721bee42ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4897a06a-9f9e-27ce-91d3-58721bee42ac@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you post the patch again? I don't see this in my box.

On 10/27, Chao Yu wrote:
> Jaegeuk,
> 
> Missed to apply this patch?
> 
> Thanks,
> 
> On 2021/9/24 17:50, Pavel Machek wrote:
> > Hi!
> > 
> > > This code looks quite confused: part of function returns 1 on
> > > corruption, part returns -errno. The problem is not stable-specific.
> > > 
> > > [1] https://lkml.org/lkml/2021/9/19/207
> > > 
> > > Let's fix to make 'insane cp_payload case' to return 1 rater than
> > > EFSCORRUPTED, so that return value can be kept consistent for all
> > > error cases, it can avoid confusion of code logic.
> > > 
> > > Fixes: 65ddf6564843 ("f2fs: fix to do sanity check for sb/cp fields correctly")
> > > Reported-by: Pavel Machek <pavel@denx.de>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > 
> > Reviewed-by: Pavel Machek <pavel@denx.de>
> > 
> > (This is good minimal fix, but eventually I believe the function
> > should switch to 0/-errno... for consistency with rest of kernel).
> > 
> > Thank you,
> > 								Pavel
> > 								
> > > +++ b/fs/f2fs/super.c
> > > @@ -3487,7 +3487,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> > >   		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
> > >   		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
> > >   			  cp_payload, nat_bits_blocks);
> > > -		return -EFSCORRUPTED;
> > > +		return 1;
> > >   	}
> > >   	if (unlikely(f2fs_cp_error(sbi))) {
> > 
