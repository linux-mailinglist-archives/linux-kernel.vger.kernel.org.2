Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529AB3F6C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhHXXbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhHXXbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAF9F610F8;
        Tue, 24 Aug 2021 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629847824;
        bh=aBZ/uH2vbAthAfmTJZ4TTBiPAcZ3NPXOPH71fmoGF0s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PrCA9PxHtwM75+FX3ElELCMEJrgZcZW+2ql/v8rBabw4KvT/cn0jJ6BUU6W0EA96H
         c/qIeJQQs5xS/rER4jK0ThdFWHwxQiPfgvwHKDZAZSJDABAdjrkHB+83HRZE3m1DfS
         its2b9N4AnXxPxKBU6sMneI8oYLhf74Edd2YmszS/vIuNOpIg5uEcUZPk3pDaa1xnl
         N7p19VsGKh6qO64HoSXQfw8BxBNrx7P85uRbrnlAodpio54t4mZ9yfzb+JTqIbwz/x
         TtEBNWS6eZVD0SiTtXr1x1NipzYwsFw746RqloXZH6e0+t//Ug1vbI5wiWhbSO0Fmc
         pfGe9LOFzm+mg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <baa8a361-1a22-76a0-423d-4378178f7073@kernel.org>
 <YSUn1j22s/kc+hWS@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d0a48947-e4df-9b0f-735e-6b306a64c4fe@kernel.org>
Date:   Wed, 25 Aug 2021 07:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSUn1j22s/kc+hWS@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/25 1:09, Jaegeuk Kim wrote:
> On 08/24, Chao Yu wrote:
>> On 2021/8/24 1:01, Jaegeuk Kim wrote:
>>> We must flush dirty pages when calling fsync() during checkpoint=disable.
>>> Returning zero makes inode being clear, which fails to flush them when
>>> enabling checkpoint back even by sync_inodes_sb().
>>
>> Without this patch, file can be persisted via checkpoint=enable as well, my
>> testcase:
>>
>> - mount -t f2fs -o checkpoint=disable,checkpoint_nomerge /dev/pmem0 /mnt/f2fs/
>> - cp file /mnt/f2fs/
>> - xfs_io /mnt/f2fs/file -c "fdatasync"
>> - mount -o remount,checkpoint=enable /dev/pmem0 /mnt/f2fs/
>> - umount /mnt/f2fs
>> - mount /dev/pmem0 /mnt/f2fs
>> - md5sum file /mnt/f2fs/file
>> chksum values are the same.
>>
>> Am I missing something?
> 
> I'm trying to address one subtle issue where a file has only NEW_ADDR by the

Oh, I doubt that we may failed to flush data of all inodes due to failures during
sync_inodes_sb(), additionally, how about adding retry logic for sync_inodes_sb()
if there is still any F2FS_DIRTY_DATA reference counts in f2fs_enable_checkpoint()
to mitigate this issue, e.g.:

f2fs_enable_checkpoint()

	do {
		sync_inode_sb();
		congestion_wait();
		cond_resched();
	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry_count--)

	if (get_pages(sbi, F2FS_DIRTY_DATA))
		f2fs_warm("");

Thanks,

> checkpoint=disable test. I don't think this hurts anything but can see
> some mitigation of the issue.
> 
>>
>> Thanks,
