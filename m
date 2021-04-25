Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FEF36A596
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhDYHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhDYHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:49:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D03C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:49:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g16so10457792plq.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMC9VyMwLf/GfBfr0WOgCBomIsX/etjUIbslChnLKO8=;
        b=rdV7Uk+Lv//4PPy3jrfkDGOF6hsGrCo/rxBEcBU119LGQ3eA1F5lciK9q7uT3RvADx
         LpuNhCevhuwkrKKNPW/strFN3EjeCTtskyZI1gpGrq5qVA86I4RjaZGpBwx8ohxuko65
         jysPfUbiuoRY3QHdbVdP7xFI1cW4IQRmdBP47QDQSPJm2LzogoK32Wt2B/GLOXFy/VVz
         I4m8sWIXEKXwe5SfAzjtgnU67XTq/d2suQbtquJVw3clnkp5du7y1hvn41B2NN3WozX5
         v+0eEw4SEUpCz6Gd5peIW/h1Ay+gtRybdvgNdHSTN7vk1O7lOvK++sXyFF51J1l0w/eT
         yySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMC9VyMwLf/GfBfr0WOgCBomIsX/etjUIbslChnLKO8=;
        b=NkDst9DN6ADArUOQuvLM3JVzp9huKfY2y7YNFeotddNes+QdW9SbdcB6u3hp6f2KEP
         NaKdyRapvAY0BhYLTqqjyFjn4Ai4qKz63d/VB9afO+NtcR1elgt7wjjsBPCpGfxGpqdH
         qBGr4QJ46hq4suDv55ZlWktrfs20+lNh6Cq9QAj3YtIoC9vCpyY0CbCbZaQnBhY7hlKg
         AGaAK6juWt1wadpUxlO+EwWG/cQDGi+2hk1V0xqeo3lvIcEdPOcxe60QBZ6t2R4iq2zb
         5wdyWTk/gI2foQlUaWkMXtrpr4kvBgJ4+nguOilFhB+JZgrjLpurZL8ZdK2CItbocy7x
         tdJA==
X-Gm-Message-State: AOAM533f78qBQDw1nkDgR1QgmRG0yCINuijbiSc0ez+vdJ+5XGwCsWmn
        pp5BRJyvIC8RqHWZrn+51Ww=
X-Google-Smtp-Source: ABdhPJwnraxQf8SxUW4EDxzy/W00s1TOYyNp5Kl6lwkYzgYX6ImkouH2o9bW+CQnzZ28kosGTVmFUw==
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr14504341pjy.69.1619336941649;
        Sun, 25 Apr 2021 00:49:01 -0700 (PDT)
Received: from nuc.wg.ducheng.me ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id a5sm2737862pja.37.2021.04.25.00.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 00:49:01 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org, Du Cheng <ducheng2@gmail.com>,
        syzbot+651ca866e5e2b4b5095b@syzkaller.appspotmail.com
Subject: [PATCH] fs:minix: catch inode->i_nlink == 0 in minix_rename()
Date:   Sun, 25 Apr 2021 15:48:51 +0800
Message-Id: <20210425074851.14100-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the destination inode has i_nlink==0, it is invalid. Hence we should
return an error instead of proceeding with drop_nlink() which causes
WARN_ON().

Reported by syzkaller:
https://syzkaller.appspot.com/bug?id=0b1ac5e39c478b05355e189451b5379dc925fd2e

Reported-by: syzbot+651ca866e5e2b4b5095b@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---
This patch fixed the kernel panic on my testing envionment with the syzbot
reproducer.

This patch works in a similar spirit with the following patch on bad inode:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=facb03dddec04e4aac1bb2139accdceb04deb1f3


 fs/minix/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 937fa5fae2b8..96761536b8d4 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -215,6 +215,10 @@ static int minix_rename(struct user_namespace *mnt_userns,
 		struct page * new_page;
 		struct minix_dir_entry * new_de;
 
+		err = -EINVAL;
+		if (new_inode->i_nlink == 0)
+			goto out_dir;
+
 		err = -ENOTEMPTY;
 		if (dir_de && !minix_empty_dir(new_inode))
 			goto out_dir;
-- 
2.30.2

