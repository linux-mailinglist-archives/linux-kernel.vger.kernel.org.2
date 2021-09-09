Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA6406040
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhIIXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIIXwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB36610E9;
        Thu,  9 Sep 2021 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631231490;
        bh=fztYKXwCNriqil1UbKCuyBqnFoKNcnIMC9/mJUjAils=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=urGtZ56EpHaXAcPm9F103+W/UhQ6A5tOHIELnS27hJPbf0riXPNIIaQ/6F3sxJOLO
         bleOHITbxmgh64Aok8t3qKQ2IvxGOz4caCBewz8dMSN/OSkaQ/hnlU/37Bew3u4/zK
         l5BuFR+6K9rYH1aMV+28+uxaTtd0gcpLPEmTgBlH81ht7SNMjn+/2T7vpiKzcRvLUD
         eAvifvkG18e2XX6OlzN5s0Xi8T13NAbh2Uj6k2Rhl0n/wyTW823AyiihfH53kfpB4Z
         msrSzms5LlrOrJ2+WvX9PnhlkVWSnpAEY33GO/N5HMT/JDaMtx38UXGDgxVT0ixU5p
         E5UMLNWsHyqMg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: should use GFP_NOFS for directory inodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210907174351.1104857-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6c40b766-2bdc-03c2-9e8a-e399d6e83282@kernel.org>
Date:   Fri, 10 Sep 2021 07:51:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907174351.1104857-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/8 1:43, Jaegeuk Kim wrote:
> We use inline_dentry which requires to allocate dentry page when adding a link.
> If we allow to reclaim memory from filesystem, we do down_read(&sbi->cp_rwsem)
> twice by f2fs_lock_op(). I think this should be okay, but how about stopping
> the lockdep complaint [1]?
> 
> f2fs_create()
>   - f2fs_lock_op()
>   - f2fs_do_add_link()
>    - __f2fs_find_entry
>     - f2fs_get_read_data_page()
>     -> kswapd
>      - shrink_node
>       - f2fs_evict_inode
>        - f2fs_lock_op()
> 
> [1]
> 
> fs_reclaim
> ){+.+.}-{0:0}
> :
> kswapd0:        lock_acquire+0x114/0x394
> kswapd0:        __fs_reclaim_acquire+0x40/0x50
> kswapd0:        prepare_alloc_pages+0x94/0x1ec
> kswapd0:        __alloc_pages_nodemask+0x78/0x1b0
> kswapd0:        pagecache_get_page+0x2e0/0x57c
> kswapd0:        f2fs_get_read_data_page+0xc0/0x394
> kswapd0:        f2fs_find_data_page+0xa4/0x23c
> kswapd0:        find_in_level+0x1a8/0x36c
> kswapd0:        __f2fs_find_entry+0x70/0x100
> kswapd0:        f2fs_do_add_link+0x84/0x1ec
> kswapd0:        f2fs_mkdir+0xe4/0x1e4
> kswapd0:        vfs_mkdir+0x110/0x1c0
> kswapd0:        do_mkdirat+0xa4/0x160
> kswapd0:        __arm64_sys_mkdirat+0x24/0x34
> kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
> kswapd0:        do_el0_svc+0x28/0xa0
> kswapd0:        el0_svc+0x24/0x38
> kswapd0:        el0_sync_handler+0x88/0xec
> kswapd0:        el0_sync+0x1c0/0x200
> kswapd0:
> -> #1
> (
> &sbi->cp_rwsem
> ){++++}-{3:3}
> :
> kswapd0:        lock_acquire+0x114/0x394
> kswapd0:        down_read+0x7c/0x98
> kswapd0:        f2fs_do_truncate_blocks+0x78/0x3dc
> kswapd0:        f2fs_truncate+0xc8/0x128
> kswapd0:        f2fs_evict_inode+0x2b8/0x8b8
> kswapd0:        evict+0xd4/0x2f8
> kswapd0:        iput+0x1c0/0x258
> kswapd0:        do_unlinkat+0x170/0x2a0
> kswapd0:        __arm64_sys_unlinkat+0x4c/0x68
> kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
> kswapd0:        do_el0_svc+0x28/0xa0
> kswapd0:        el0_svc+0x24/0x38
> kswapd0:        el0_sync_handler+0x88/0xec
> kswapd0:        el0_sync+0x1c0/0x200
> 
> Fixes: bdbc90fa55af ("f2fs: don't put dentry page in pagecache into highmem")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

