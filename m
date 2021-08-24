Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B703F6846
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhHXRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242405AbhHXRjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB4B613DB;
        Tue, 24 Aug 2021 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629824983;
        bh=k6/DyiNxY9iHMyx+vqOZpeLhFY0OrsTTDraIpNfySmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6mudTayuZeB7SiPMQXlGDH/1inDLPr+v9d0hlxVFaVmSr3pb9tz574iWPfbBC7N2
         jA5Lsn9U3zT49DcTaRzhe3Vs+4/tQqI3b0DLFlfBHDYpfPjSu2UJLsx14S5yh+kPCb
         uTcmtS1OufW7MKSbzo4MpzjbVg1xwxjN55SWRdowLT1hi1lcjntZoNeUGHkYnkxhnL
         OiHmQrIOmx8BA5DlrI+ZJKHCv9pkrhueHI52J8sZueo4exQ5m9lFi9Jlb7awJfYL1r
         PZPYvuouE3yOGDwC0wGwDOY1pkIuXWHFeY+hoY4qjv9e7RHtaS44Ia0dRtxnxVpg7P
         HOEi52W+z4HkQ==
Date:   Tue, 24 Aug 2021 10:09:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
Message-ID: <YSUn1j22s/kc+hWS@google.com>
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24, Chao Yu wrote:
> On 2021/8/24 1:01, Jaegeuk Kim wrote:
> > We must flush dirty pages when calling fsync() during checkpoint=disable.
> > Returning zero makes inode being clear, which fails to flush them when
> > enabling checkpoint back even by sync_inodes_sb().
> 
> Without this patch, file can be persisted via checkpoint=enable as well, my
> testcase:
> 
> - mount -t f2fs -o checkpoint=disable,checkpoint_nomerge /dev/pmem0 /mnt/f2fs/
> - cp file /mnt/f2fs/
> - xfs_io /mnt/f2fs/file -c "fdatasync"
> - mount -o remount,checkpoint=enable /dev/pmem0 /mnt/f2fs/
> - umount /mnt/f2fs
> - mount /dev/pmem0 /mnt/f2fs
> - md5sum file /mnt/f2fs/file
> chksum values are the same.
> 
> Am I missing something?

I'm trying to address one subtle issue where a file has only NEW_ADDR by the
checkpoint=disable test. I don't think this hurts anything but can see
some mitigation of the issue.

> 
> Thanks,
