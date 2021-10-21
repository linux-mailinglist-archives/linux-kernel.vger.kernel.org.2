Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02470436C90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhJUVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUVVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDC8D60F8F;
        Thu, 21 Oct 2021 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634851129;
        bh=Gwyq+zNT7ASn4trOpGqWOvEtfQM+rFmKZzNvILCKN9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcLpceroDe5GwilFBhvK4YwRln2QMZHCQQTbfaAuSrb54zKI/z78zgl1CCotid7sS
         evww543WI/EGj4u3XeQDfK6OHFT3svqclTNAFyLPVyOGGB2pyN29fNqWGIrJluGmvc
         h5cJ1uB8PKVsFmASlG55lN9xhqU2x/YNk+ElOVTaTfybnsmDSd/WPlWnNNvj80V4z5
         IXGkLX2cbLcxHacvlQlXWYg8wHndQ6BTI9d4lteM69Brvme3CaPQt3pbBDtWxYLw2S
         uFxidjj/1OfxkiVyuep6pMEV+g4XpOADFUuWXy/K7op4ulig0Gg6wqjD35jv4l8LUH
         SxmKoTn9ZtJ1A==
Date:   Thu, 21 Oct 2021 14:18:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in
 compr_written_block
Message-ID: <YXHZN5J2jyPG5tcx@google.com>
References: <20211006174910.2964885-1-daeho43@gmail.com>
 <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
 <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
 <CACOAw_xW7MZi8BVi-2Zo-=LruZr6k7fC7huYiYuWyaDDDti6WA@mail.gmail.com>
 <02abeeba-c359-cae3-4759-ee2087f21cc9@kernel.org>
 <CACOAw_xh2HSQDjb_tGopvssipDJYnpi4O1X5_eJqSOLpLebqsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xh2HSQDjb_tGopvssipDJYnpi4O1X5_eJqSOLpLebqsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21, Daeho Jeong wrote:
> > Okay, shouldn't we Cc stable mailing list for this patch? otherwise
> > userspace tool may get different stat number with the same compressed
> > file in different kernel?
> >
> 
> Oh, could you let me know what the address of the "stable" mailing list is?

Added Fixes and -stable. :)

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
