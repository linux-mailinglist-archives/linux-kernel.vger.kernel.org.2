Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71C40831C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhIMDXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbhIMDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:23:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81217C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:22:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so5561474pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJfd+Dl6LyVyy7WHaPVunJ2WQBOC5w96NLDZ1F2YTMU=;
        b=KmkXDaGXiNAV5S+8g9ac3wLbeYoy+IMJcexHOAVPtxdk27ksFOOClYU2Ou/enfSoWD
         kRjjyJTxA2B+X+G9TXX7nN1EOjToVKLBOYR5HKG1MiU3/hlFJFpoBf9vP7Ga87HTvrZi
         mmMk3Ma4N+103XjMsbzRh8cqhmzKnEK+MQU01ALDB1kX3hCj3KjzbR8dokd9F3xO4woZ
         cME5u9ygNGE4fJjJYanq18iDf9D3dVcpHCojJAEEsq8sqkIwIZjOSU24SgQb/QXSUlHw
         gqtw7qpyqrrMx29BaCpq29ymgit7itjOG4wjLKe6960m9RB+pQBRQHKuo3XB5Mheyn7q
         FcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJfd+Dl6LyVyy7WHaPVunJ2WQBOC5w96NLDZ1F2YTMU=;
        b=SihUqmlDKzY6qwrAwM6BgpXBXjoHSVb89fsJ9PwdcF8ZcjtbUEf7jro0duMyp2QCse
         ruDoDChCXl/hT70MGUjSs6YNxoV+1VnwpGrWnOpfTokiQeOVHjou9MNG3FlA0lRex31n
         vXWdCAQcCfRSBQfyCxrPKRo2KSO8sb2ONUwPhEI3M5AZYxsJFW8rIgjMmMl5Oa3EXQfn
         ivr8G87qoKsoGviMEOobwUJLlOwHkeE/tDFWwQuSQAaleku3OZ5uPHUOL8KdjQiMBuo3
         VXD1sOVVJxeb3RjVgTbyVVNBDR2sNMnzthor+KvMSnR3OWYYN7oig9e7Ttj4Bd7s1rk8
         SPJA==
X-Gm-Message-State: AOAM530HMwInJiXdJrAfQQmwLa5EjpyiIJ0nkE45sM8soXaLhw2K4Kel
        shd3DLXMi7mRbi3uQWj6yxkIcx/Y/DIWk4OB
X-Google-Smtp-Source: ABdhPJz/LJrGEeFqHQou6i5SysEv2s1GOhEKWvZxYRCQiM1Pw2xt2H16CF7bw3hKs6fgqyMiHnKaxg==
X-Received: by 2002:a17:90a:1d4c:: with SMTP id u12mr10217220pju.95.1631503321038;
        Sun, 12 Sep 2021 20:22:01 -0700 (PDT)
Received: from 64-217.. ([103.97.201.33])
        by smtp.gmail.com with ESMTPSA id k127sm5042950pfd.1.2021.09.12.20.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:22:00 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li Feng <fengli@smartx.com>
Subject: [PATCH] md: allow to set the fail_fast on RAID1/RAID10
Date:   Mon, 13 Sep 2021 11:20:03 +0800
Message-Id: <20210913032003.2836583-1-fengli@smartx.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the running RAID1/RAID10 need to be set with the fail_fast flag,
we have to remove each device from RAID and re-add it again with the
--fail_fast flag.

Export the fail_fast flag to the userspace to support the read and
write.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/md/md.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ae8fe54ea358..ce63972a4555 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3583,6 +3583,35 @@ ppl_size_store(struct md_rdev *rdev, const char *buf, size_t len)
 static struct rdev_sysfs_entry rdev_ppl_size =
 __ATTR(ppl_size, S_IRUGO|S_IWUSR, ppl_size_show, ppl_size_store);
 
+static ssize_t
+fail_fast_show(struct md_rdev *rdev, char *page)
+{
+	return sprintf(page, "%d\n", test_bit(FailFast, &rdev->flags));
+}
+
+static ssize_t
+fail_fast_store(struct md_rdev *rdev, const char *buf, size_t len)
+{
+	int ret;
+	bool bit;
+
+	ret = kstrtobool(buf, &bit);
+	if (ret)
+		return ret;
+
+	if (test_bit(FailFast, &rdev->flags) && !bit) {
+		clear_bit(FailFast, &rdev->flags);
+		md_update_sb(rdev->mddev, 1);
+	} else if (!test_bit(FailFast, &rdev->flags) && bit) {
+		set_bit(FailFast, &rdev->flags);
+		md_update_sb(rdev->mddev, 1);
+	}
+	return len;
+}
+
+static struct rdev_sysfs_entry rdev_fail_fast =
+__ATTR(fail_fast, 0644, fail_fast_show, fail_fast_store);
+
 static struct attribute *rdev_default_attrs[] = {
 	&rdev_state.attr,
 	&rdev_errors.attr,
@@ -3595,6 +3624,7 @@ static struct attribute *rdev_default_attrs[] = {
 	&rdev_unack_bad_blocks.attr,
 	&rdev_ppl_sector.attr,
 	&rdev_ppl_size.attr,
+	&rdev_fail_fast.attr,
 	NULL,
 };
 static ssize_t
-- 
2.31.1

