Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7331F32C3C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhCCX7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235451AbhCCThJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:37:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D73E264EF0;
        Wed,  3 Mar 2021 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614799696;
        bh=8Ra0AMNh+KuCsZP9ZA7+W5cqVDNHMmMwTZByG6847LQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aCdQ2lhI4R9ZSpnrwjYno/GIfUoYO1enl4eBCq7vBku02IvLiXfv9MSMJUQe5QYqP
         YsWHU5/eYaz8oV6qFTAu5aXuS7pqp672gmBL+LLZYSl8p54wZ5Pm/TyzGmpDZhqtuf
         yoGC1EXWp4h4MMrdlr0nfX8laVYhPAVOEjEt3r5XI7RfHslg2fhvOqHYn1Kf6g/1vA
         6l03ZXNEfiiFUWLiuTjZ7gGlAxA7/dM/hjyd1W34bLDWcWSn4O1RYT3QUHXH+J05D6
         zL/mp4zek9wWs7DF5tYAMXsoClH/ULKW0G+WsA+M8pYjJ3tnTLZYXhSQfdlx++gBl/
         hq9oYfSu/m9BA==
Date:   Wed, 3 Mar 2021 11:28:14 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH v2] f2fs: expose # of overprivision segments
Message-ID: <YD/jTtjVqDklvoof@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302054233.3886681-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful when checking conditions during checkpoint=disable in Android.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 5 +++++
 fs/f2fs/sysfs.c                         | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9fa5a528cc23..4aa8f38b52d7 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -409,3 +409,8 @@ Description:	Give a way to change checkpoint merge daemon's io priority.
 		I/O priority "3". We can select the class between "rt" and "be",
 		and set the I/O priority within valid range of it. "," delimiter
 		is necessary in between I/O class and priority number.
+
+What:		/sys/fs/f2fs/<disk>/ovp_segments
+Date:		March 2021
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Shows the number of overprovision segments.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e38a7f6921dd..0c391ab2d8b7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
 			(unsigned long long)(free_segments(sbi)));
 }
 
+static ssize_t ovp_segments_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(overprovision_segments(sbi)));
+}
+
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
 F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
+F2FS_GENERAL_RO_ATTR(ovp_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 F2FS_GENERAL_RO_ATTR(features);
 F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
@@ -715,6 +723,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ckpt_thread_ioprio),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
+	ATTR_LIST(ovp_segments),
 	ATTR_LIST(unusable),
 	ATTR_LIST(lifetime_write_kbytes),
 	ATTR_LIST(features),
-- 
2.31.0.rc0.254.gbdcc3b1a9d-goog

