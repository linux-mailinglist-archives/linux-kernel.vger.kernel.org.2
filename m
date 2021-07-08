Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3CA3BF43D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 05:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhGHDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGHDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 23:16:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 20:13:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l26so6127192oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLq+m8mRzEZ5b3sETJPsOqtUDE3wGL5gfvCXClShmb0=;
        b=OAKMai1UQ8NEZXqNXBcbgikoW5/jXe6mp4CJSkrldyrY23PL2FHfc/uWzXgFNZUq/o
         wWVbUZeVdzvdzlb+B0+E7YJ7cFJxybpkNho19k6M5co2ba4H6HkEMBMXfsGfxNeBKieq
         l+AhELx4jRYJ+rrHv1+q/PMV+VO7QgBYQCxTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLq+m8mRzEZ5b3sETJPsOqtUDE3wGL5gfvCXClShmb0=;
        b=BNxiUh6sGz8oAYJzwiwG2tJakYgG9HnOqB6MhHHptWeHgVLIZGHoKxtMspylYyPb/6
         2XTh9fbqP2duoIwPGZ84fjM1MKMLi+vqHM+BJxMuo8z0mAeYsFLFk17FP2lHuN84ayDo
         3qQ8Ke+lYaKP6A+npfshu/9nKnUW0AIg0xfz4DO4uqPMkWrF7oFYujZN2BvWRxXISWi9
         d8Nkt1d7lYC7F/DS14HWJYF+nD2IH863bv/cVz6mu3VzL5EXSFuZ9bkaZz5/LJCwCBJ7
         tCPsndjvb6CPGa9HIn12v2kUBCOC5yiurA781ngvob38vW9/d3LI605qZmJxcuaORN46
         9FyQ==
X-Gm-Message-State: AOAM530P7TtVrEH3qPkX9UYuZPHdNghr2wRnlzRuL3DyDeCoBrE7SZVu
        eZoULNKJVJlkKCOG3xB0Yw/aEA==
X-Google-Smtp-Source: ABdhPJzqgVPiezueLlr3ZlY7zO5/wkCCQC840FTUCce3OhPyfxTmnx2ofIfbVCt8dCXRlFyB6LBXUQ==
X-Received: by 2002:a05:6808:159d:: with SMTP id t29mr21335223oiw.159.1625714003373;
        Wed, 07 Jul 2021 20:13:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t12sm266872oic.33.2021.07.07.20.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 20:13:22 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com
Subject: [PATCH] firmware_loader: Fix use-after-free Read in firmware_loading_store
Date:   Wed,  7 Jul 2021 21:13:21 -0600
Message-Id: <20210708031321.50800-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user writes to 'loading' between loading aborted and 'loading'
gets removed, __fw_load_abort() could be called twice in error
path setting the state to load aborted. __fw_load_abort() checks
for fw_sysfs_done() case, but doesn't check for abort case. This
opens the window for use-after-free Read in firmware_loading_store().

Fix it by adding check for fw load aborted in addition to done in
__fw_load_abort() and return if either one of the states is true.

BUG: KASAN: use-after-free in __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
Read of size 8 at addr ffff88802b3da2c8 by task systemd-udevd/25252

CPU: 0 PID: 25252 Comm: systemd-udevd Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 __fw_load_abort drivers/base/firmware_loader/fallback.c:97 [inline]
 __fw_load_abort drivers/base/firmware_loader/fallback.c:88 [inline]
 fw_load_abort drivers/base/firmware_loader/fallback.c:105 [inline]
 firmware_loading_store+0x141/0x650 drivers/base/firmware_loader/fallback.c:297
 dev_attr_store+0x50/0x80 drivers/base/core.c:2066
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6d0b3fe970
Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
RSP: 002b:00007ffde8a82ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6d0b3fe970
RDX: 0000000000000002 RSI: 00005567e595b380 RDI: 0000000000000007
RBP: 00005567e595b380 R08: 00007f6d0c58c8c0 R09: 0000000000000002
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000001 R14: 00005567e59427d0 R15: 0000000000000002

Reported-by: syzbot+77cea49e091776a57689@syzkaller.appspotmail.com
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/firmware_loader/fallback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..e6a18c2a6c43 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -89,9 +89,10 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
 {
 	/*
 	 * There is a small window in which user can write to 'loading'
-	 * between loading done and disappearance of 'loading'
+	 * between loading done or aborted and disappearance of
+	 * 'loading'
 	 */
-	if (fw_sysfs_done(fw_priv))
+	if (fw_sysfs_done(fw_priv) || fw_state_is_aborted(fw_priv))
 		return;
 
 	list_del_init(&fw_priv->pending_list);
-- 
2.30.2

