Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE84262EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhJHDYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhJHDYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:24:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 20:22:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g14so7024974pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJfd+Dl6LyVyy7WHaPVunJ2WQBOC5w96NLDZ1F2YTMU=;
        b=0Wlfqkaji3y2OPBLxrydvegpu3NwJX3BH3aUX+HUK/cK90BRk93mKOGJhxiGNde20p
         hxl2iTMhB27qIDm0rENxNkUZ3D6oF6aU2yRimGwqr2lscapGuHS9MSTvnCeD/U4Ob9ZD
         P3wvU9OisBPOX6O+Bbjh3hOttqkVJ3tUk+wne9i340hgYWgWcH1xvsxNPibVTBs6rnpL
         HbSus7OM6YBBd+as51wiT9dk0kLB+1h29bN01AI6wjkp8EbVLaZIzYheTUFsUWzbB/J5
         LRyh3YGW4xS8kFbJjFZ1kr5B7JSnrSuuiw6q+agnBy3BJB1x1ncxjz+REorjEYudYenn
         +jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJfd+Dl6LyVyy7WHaPVunJ2WQBOC5w96NLDZ1F2YTMU=;
        b=6LsW1KvWdnln/i8vivYYrJ47ktJrk3JSvVIIA83img85PXSEBO1t8yPVHDdslZWlT0
         uNHR/7uKKfbaMHQmCRHPRcq41RZcsgX+OKoUF9x2uvlcXD9tdQgQZBlcok1wQ3WIXzmX
         ITDr5Vy0332/pXsltIxoc/wNC9APBWlyV3tWNyE44QTVEk0zRAaEVzjc9hO90XhdN6tI
         UHMuWp3A+6iBBafuZOtiH1gCGlBsJrgfFVqsXRDDmokyYYw5u3XzwSGZp/q6eu3OgPVZ
         add6QfS0P6Rznpdz2nuLNgcK6Zzd+HH9FtyKVqcgrF5HmDO2seWkVNrwtjAep92BgsbM
         V1PQ==
X-Gm-Message-State: AOAM533H9OaiaFTxVjbhC077RIsOoWe6p3taVovRgduojbxsETa4Ljm1
        +Cqh+WPcedyLPOue+JiTcrnfCw==
X-Google-Smtp-Source: ABdhPJxW1l429AsznSMTeokTvAn5jNPgEq0MifH/oiCpZXWRnoTfWE2wVNTbl49syfKFdWJVCfJC0w==
X-Received: by 2002:a62:dd0a:0:b0:44b:bd85:9387 with SMTP id w10-20020a62dd0a000000b0044bbd859387mr7982758pff.49.1633663372090;
        Thu, 07 Oct 2021 20:22:52 -0700 (PDT)
Received: from 64-217.. ([103.97.201.33])
        by smtp.gmail.com with ESMTPSA id h74sm729528pfe.196.2021.10.07.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:22:51 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Cc:     Li Feng <fengli@smartx.com>
Subject: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
Date:   Fri,  8 Oct 2021 11:22:30 +0800
Message-Id: <20211008032231.1143467-1-fengli@smartx.com>
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

