Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBC3F5560
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 03:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhHXBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 21:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhHXBJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 21:09:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 516CA60E75;
        Tue, 24 Aug 2021 01:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629767324;
        bh=LSQQ8f2336RqKfQCfFwxIJbJmAz6IrEiwfJq0dXEJHs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=peUVUEi8Ed4L1jgy0LaSo37hcPqErMZWI5INKYQYW7tajawga1E+uVRgJ0nXa0h8i
         nq+WNmTwJHGPq69mfkud/yitLjBCu9Sxa2iZaDlnvgsEbdt7IgLQRxJOto24XjSEib
         +HzEG5R8II8SVf017lbNUjBBESc5MvrY+YwZCKvlkEj0Bx4LDGiezdql+sE478/3mG
         Wum3s+qyR4bUrFJmfWi08MBOp9jAm7mlPwFHtFJlzpydoGDCPlhRbKKybijJZS2wjr
         z4H5pq7UdlyLoF9z7nUp/nCBQSTYOdbD7zG9ieNkBlYFIARjDu9kiMqdKq7ev4uN1O
         HTc+yD3IQvEyA==
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
Date:   Tue, 24 Aug 2021 09:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823170151.1434772-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/24 1:01, Jaegeuk Kim wrote:
> We must flush dirty pages when calling fsync() during checkpoint=disable.
> Returning zero makes inode being clear, which fails to flush them when
> enabling checkpoint back even by sync_inodes_sb().

Without this patch, file can be persisted via checkpoint=enable as well, my
testcase:

- mount -t f2fs -o checkpoint=disable,checkpoint_nomerge /dev/pmem0 /mnt/f2fs/
- cp file /mnt/f2fs/
- xfs_io /mnt/f2fs/file -c "fdatasync"
- mount -o remount,checkpoint=enable /dev/pmem0 /mnt/f2fs/
- umount /mnt/f2fs
- mount /dev/pmem0 /mnt/f2fs
- md5sum file /mnt/f2fs/file
chksum values are the same.

Am I missing something?

Thanks,
