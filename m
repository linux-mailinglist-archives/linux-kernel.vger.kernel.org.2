Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB431DCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhBQQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhBQQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:00:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:00:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b21so8751956pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOQVmvgp4dt65rKsAQWxL7KavP/pmOa+Mhm9+94yhA0=;
        b=OgWgfmcXzUIfi/RaYLY+BdMNraMTmk6AGXnvuMXh263tKqYsVRvv5S6QkszHfK6p9e
         R7ugb2dwa7Sys1Pdo2kHaqCYHLUo4t7HGHzt1X7d0Y5gqr7awVtUJh1+VKnQsDtsgcb4
         MpHY6dJyhLutgPzx08UrSWpabf4/q+scQi3p4S74LBkq2x4/NrxQf1OnXUdk8O7Imu/6
         TvoJ/FFTaQtt3bW4ciD5DSBsDjfrdLaDM+AgRwWLbDTTqnO9XUvrbuuKVQBDNbWRjS1Q
         xUFs4lmZmP95+DzJefEFUcvMVvKjAVpMWcJzx7vOpqzCw1FIW7Nq3cVS5VBu++zkbnWI
         WVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOQVmvgp4dt65rKsAQWxL7KavP/pmOa+Mhm9+94yhA0=;
        b=L4DQje9CZcOgcL55HQo2cODp/KyaFmhhZ8F+elO28ospPN0Eh0pi7wpJD5336FJwaL
         kLDmhtP1XmE8qArZwWpdS2FFc/mIKDajOsK7O9Cok9fRrQNBOjM1LxPJJS0j3HpZl8Uw
         LTXh1A6M2vHfCO/+jVPIIdCtIaJIU97uVqXtPfmcmPITp0QdyLnWCNc9SuVbM5wyK/Ed
         Gl758Nhv1xpadqJlrk4Lpj52ORJNPGMXr++cfjLSWj/CD8sT7hbeJHNrJ1nBvYag+phH
         OB6lKqFhGsjtGvxbxUnfC2xDrw8CXmYD56VDHjcSlAOMD5baky0t9DV4UU4PPXbSgEKA
         5pRw==
X-Gm-Message-State: AOAM531qmfmdX8sM5wpSgnsoG03T0bEJVscYRMas4iGN9BPl2t/c8nx9
        k8LrXbZVziTde77LUPm/+b8=
X-Google-Smtp-Source: ABdhPJwwiktyfKOXgb8Yb//e1wziSLZ4qWg8ZQIuFlYzLgICbjZMZ+Sc5K/88aC9aX/mkrZnPbAJuw==
X-Received: by 2002:a63:e602:: with SMTP id g2mr57105pgh.290.1613577608768;
        Wed, 17 Feb 2021 08:00:08 -0800 (PST)
Received: from nuc10.amust.local (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id 74sm2911183pfw.53.2021.02.17.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:00:08 -0800 (PST)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] ntfs: check for valid standard information attribute
Date:   Wed, 17 Feb 2021 07:59:30 -0800
Message-Id: <20210217155930.1506815-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we should check for valid STANDARD_INFORMATION attribute offset and
length before trying to access it

Reported-and-tested-by: syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
Acked-by: Anton Altaparmakov <anton@tuxera.com>
Link: https://syzkaller.appspot.com/bug?extid=c584225dabdea2f71969
---
 fs/ntfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f7e4cbc26eaf..be4ff9386ec0 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -629,6 +629,12 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	}
 	a = ctx->attr;
 	/* Get the standard information attribute value. */
+	if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
+			+ le32_to_cpu(a->data.resident.value_length) >
+			(u8 *)ctx->mrec + vol->mft_record_size) {
+		ntfs_error(vi->i_sb, "Corrupt standard information attribute in inode.");
+		goto unm_err_out;
+	}
 	si = (STANDARD_INFORMATION*)((u8*)a +
 			le16_to_cpu(a->data.resident.value_offset));
 
-- 
2.30.0

