Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153743F7DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhHYVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhHYVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:32:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5593F610A1;
        Wed, 25 Aug 2021 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629927105;
        bh=GQpaLXOeTre1tnsmkfBCzjL/6oulqKgM/Nfy5gJGBlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeTFnAR42dMEaeLmLllAJtGnnuzmOTJ2zuduQj1EvtxFxgbK1UB8lG+6GyHEg6I+t
         cDe8Lssni0jvQce61VRK6rx2/ZjiKIQLgCCStezU1EXnHH4ON4miFWP4wni7blVQFC
         mRbQ/9f8/ECcFAFrPDCOMOPWF3HJHiJtslKIUGiu/9tL7afKYrOxmoPA385+pha4cG
         g1moZrSG/jIBFYHiwc9R/tcFozpBOiqeNT7Fcnl70vYRsFrU/5EMPXwe9pYkhvBJGM
         ENHEoI0x43sGo5BF7gLD4bij8B7W1lfmjpTwJh7QtHfhvqITuryuL0JfOOC4nc/TZi
         KYHc77utMzp3Q==
Date:   Wed, 25 Aug 2021 14:31:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
Message-ID: <YSa2v7oLMAWZP+b5@google.com>
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
 <YSUn1j22s/kc+hWS@google.com>
 <d0a48947-e4df-9b0f-735e-6b306a64c4fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a48947-e4df-9b0f-735e-6b306a64c4fe@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25, Chao Yu wrote:
> On 2021/8/25 1:09, Jaegeuk Kim wrote:
> > On 08/24, Chao Yu wrote:
> > > On 2021/8/24 1:01, Jaegeuk Kim wrote:
> > > > We must flush dirty pages when calling fsync() during checkpoint=disable.
> > > > Returning zero makes inode being clear, which fails to flush them when
> > > > enabling checkpoint back even by sync_inodes_sb().
> > > 
> > > Without this patch, file can be persisted via checkpoint=enable as well, my
> > > testcase:
> > > 
> > > - mount -t f2fs -o checkpoint=disable,checkpoint_nomerge /dev/pmem0 /mnt/f2fs/
> > > - cp file /mnt/f2fs/
> > > - xfs_io /mnt/f2fs/file -c "fdatasync"
> > > - mount -o remount,checkpoint=enable /dev/pmem0 /mnt/f2fs/
> > > - umount /mnt/f2fs
> > > - mount /dev/pmem0 /mnt/f2fs
> > > - md5sum file /mnt/f2fs/file
> > > chksum values are the same.
> > > 
> > > Am I missing something?
> > 
> > I'm trying to address one subtle issue where a file has only NEW_ADDR by the
> 
> Oh, I doubt that we may failed to flush data of all inodes due to failures during
> sync_inodes_sb(), additionally, how about adding retry logic for sync_inodes_sb()
> if there is still any F2FS_DIRTY_DATA reference counts in f2fs_enable_checkpoint()
> to mitigate this issue, e.g.:
> 
> f2fs_enable_checkpoint()
> 
> 	do {
> 		sync_inode_sb();
> 		congestion_wait();
> 		cond_resched();
> 	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry_count--)
> 
> 	if (get_pages(sbi, F2FS_DIRTY_DATA))
> 		f2fs_warm("");

Agreed. Sent v2.

> 
> Thanks,
> 
> > checkpoint=disable test. I don't think this hurts anything but can see
> > some mitigation of the issue.
> > 
> > > 
> > > Thanks,
