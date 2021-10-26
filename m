Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7824343A999
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhJZBMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhJZBMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F8AB60F02;
        Tue, 26 Oct 2021 01:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635210577;
        bh=9IShqJt6djvjPUKPObtm68+6DHvwPd46YWHkaPWwxPU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DKhWB2ZLMvh4VvXNoIzw3Nasi5QXYIle57ZQGP7SXLJMC9rMhhnIGUkYjUAteIwwC
         yaocx7eqAQoB9qepVh6S687VAGEF7iRusH2xzdw5iHrL0tQamQsep9Tn3YzxpcT1er
         CWqTtj/jhCcpM2izuV4e2YGnL2IxICf0AEoDUqVEet8IhZqT2AW7GvNtBbFg0hZrVc
         vhocZOatFjgNBOIidlWIWhjfy4VA7IIrEIM0fpCLrFAm5IcPXCmY70rbnqees0pfH/
         U/NWZf6pnhD12uH8ENGjIWxFADzJGWFgS+n2NDQJYDgaBV52yWIsbkoU17/BDfz6Un
         fmq4cM66pLmWA==
Message-ID: <c93106ef-b567-b973-7241-ea2fcef84855@kernel.org>
Date:   Tue, 26 Oct 2021 09:09:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20211014190503.717830-1-daeho43@gmail.com>
 <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
 <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
 <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/26 0:22, Daeho Jeong wrote:
> On Fri, Oct 22, 2021 at 8:32 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2021/10/22 0:44, Daeho Jeong wrote:
>>> There is a deadlock between sb_internal lock (sb_start_intwrite()) and
>>> dquot related lock.
>>> It's because we call f2fs_truncate(), which eventually calls
>>> dquot_initialize(), while holding sb_internal lock.
>>> So, I called dquot_initialize() in advance to make the 2nd calling of
>>> it in f2fs_truncate() ineffective.
>>> This is similar with the thing in f2fs_evict_inode() in inode.c
>>
>> Well, if dquot_initialize() fails in f2fs_drop_inode(), will we still run
>> into deadlock?
>>
> 
> Do you think the same issue is in f2fs_evict_inode() in inode.c?

Yes, I doubt the problem may also happen in f2fs_evict_inode() with below
callpath:

- evict_inode
  - dquot_initialize failed
  - sb_start_intwrite
  - f2fs_truncate
   - dquot_initialize lock dqio_sem

How about this?

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
old mode 100644
new mode 100755
index b24b9bc..0e49593
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -728,6 +728,7 @@ enum {
      FI_ENABLE_COMPRESS,    /* enable compression in "user" compression mode */
      FI_COMPRESS_RELEASED,    /* compressed blocks were released */
      FI_ALIGNED_WRITE,    /* enable aligned write */
+    FI_QUOTA_INIT_FAIL,    /* inidicate failed to initialize quota in drop_inode()/evict_inode() */
      FI_MAX,            /* max flag, never be used */
  };

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
old mode 100644
new mode 100755
index 13deae0..2fb53f54
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -789,9 +789,11 @@ int f2fs_truncate(struct inode *inode)
          return -EIO;
      }

-    err = dquot_initialize(inode);
-    if (err)
-        return err;
+    if (!is_inode_flag_set(inode, FI_QUOTA_INIT_FAIL)) {
+        err = dquot_initialize(inode);
+        if (err)
+            return err;
+    }

      /* we should check inline_data size */
      if (!f2fs_may_inline_data(inode)) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
old mode 100644
new mode 100755
index 1213f15..16cf50c
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -758,6 +758,7 @@ void f2fs_evict_inode(struct inode *inode)
      if (err) {
          err = 0;
          set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+        set_inode_flag(inode, FI_QUOTA_INIT_FAIL);
      }

      f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
@@ -770,6 +771,8 @@ void f2fs_evict_inode(struct inode *inode)
  retry:
      if (F2FS_HAS_BLOCKS(inode))
          err = f2fs_truncate(inode);
+    if (is_inode_flag_set(inode, FI_QUOTA_INIT_FAIL))
+        clear_inode_flag(inode, FI_QUOTA_INIT_FAIL);

      if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
          f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);

Thanks,


> In fact, I picked up the idea from here.
> 
>          err = dquot_initialize(inode);
>          if (err) {
>                  err = 0;
>                  set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>          }
> 
>          f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>          f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>          f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> 
>          sb_start_intwrite(inode->i_sb);
>          set_inode_flag(inode, FI_NO_ALLOC);
>          i_size_write(inode, 0);
> retry:
>          if (F2FS_HAS_BLOCKS(inode))
>                  err = f2fs_truncate(inode);
> 
