Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C603D324E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhGWDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhGWDFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:05:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB4C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:46:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c11so1597859plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8J5f50KlXoN8UBa4hsGQdCO3pR6zbgd+IL6vlgdIA=;
        b=iAQ6k8veZVRfwPug4/1OBTNdEWKkRPxAxSyZ/f8mpMOfNfAJyVjdEP2F9ULLfJlLOB
         x1uWSB4lt4IxACeCX9BTksIm0Z9W+4vf2Dkz1ndTta9AHh4QbUW3uLBdL8QrVprreLqm
         vLlIogBn3tTdgxzcj5BUeDYtXcNCpfB0uAa6ppI39lwvqSXDjQ/g6foQAjoBAikT0I7F
         M+uJsMPjUdvGAM2AXQYY5cFahqciraWSrimVdLtMgCnGWAX7PXOUrAAgjPKe0K/ugtFX
         jeaoIj7xu+Z8Q+0QFW7c24H4lbKdRkbDxF8Lq2F/Bc6qo/mWLFEVrwK0xgsJvtPth4w/
         ztkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8J5f50KlXoN8UBa4hsGQdCO3pR6zbgd+IL6vlgdIA=;
        b=Nn4XjEaFppDQz5PSuj9pT5jYqVFzw1+D1xqOibrBHVnwGmtNjbvIzL6M8/Fd+xxoPN
         YC633ZO94Ci5tY3ENfoM2t1PiaIycnhfUT5fDhRjzMlO2uEXd3L8LcafEZ1kjQwC0Fag
         9xUp2SjAQCxKrA7KMTEhUxEtyppU8tcdJCA95g+cctk6V8XkRT6MmK0SFKcGVcyITKra
         QtmZhmhhKqT8rBGuhg7SA/sspvgKcd9t3YaGpVKLk7Iv45HdvuMhYnmAsvTHR+w3R9aY
         KzLz1umNLZbt/b9OiQmYlM2ehDJEusQi9uA31kR6znPZMLbehTfwcxDI+E16pwfA4Q9R
         ZpZA==
X-Gm-Message-State: AOAM533LS7PJLI6uNcTz7PjZEtQXvgRt1AotaQccbtm12osEKlptRDU6
        6+vDhlSHdlw/fW82M5sFhn6dm3S3o6Jspl5V
X-Google-Smtp-Source: ABdhPJwmKxsx4jDBZRVi9I3PIQPRWdwBZWIVPipFmkZQNC48qTp+VlbMI8W3VuNL8VUbnXePDU7yNQ==
X-Received: by 2002:a65:5684:: with SMTP id v4mr3057869pgs.388.1627011988015;
        Thu, 22 Jul 2021 20:46:28 -0700 (PDT)
Received: from liuchao12-Ubuntu.xiaomi.com ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id k189sm35860899pgk.14.2021.07.22.20.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 20:46:27 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
X-Google-Original-From: Chao Liu <liuchao12@xiaomi.com>
To:     chao@kernel.org, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] resize.f2fs: add option to manually specify new overprovision
Date:   Fri, 23 Jul 2021 11:46:22 +0800
Message-Id: <20210723034622.1820891-1-liuchao12@xiaomi.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make.f2fs supports manually specifying overprovision, and we expect
resize.f2fs to support it as well.

This change add a new '-o' option to manually specify overprovision.

Signed-off-by: Chao Liu <liuchao12@xiaomi.com>
---
 fsck/main.c   | 8 ++++++--
 fsck/resize.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 260ff29..06253e2 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -124,7 +124,8 @@ void resize_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
-	MSG(0, "  -s safe resize (Does not resize metadata)");
+	MSG(0, "  -o overprovision percentage [default:auto]\n");
+	MSG(0, "  -s safe resize (Does not resize metadata)\n");
 	MSG(0, "  -t target sectors [default: device size]\n");
 	MSG(0, "  -V print the version number and exit\n");
 	exit(1);
@@ -529,7 +530,7 @@ void f2fs_parse_options(int argc, char *argv[])
 #endif
 	} else if (!strcmp("resize.f2fs", prog)) {
 #ifdef WITH_RESIZE
-		const char *option_string = "d:fst:iV";
+		const char *option_string = "d:fst:io:V";
 
 		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -563,6 +564,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 'i':
 				c.large_nat_bitmap = 1;
 				break;
+			case 'o':
+				c.new_overprovision = atof(optarg);
+				break;
 			case 'V':
 				show_version(prog);
 				exit(0);
diff --git a/fsck/resize.c b/fsck/resize.c
index 78d578e..85a53c5 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -146,7 +146,9 @@ safe_resize:
 						get_sb(segs_per_sec));
 
 	/* Let's determine the best reserved and overprovisioned space */
-	c.new_overprovision = get_best_overprovision(sb);
+	if (c.new_overprovision == 0)
+		c.new_overprovision = get_best_overprovision(sb);
+
 	c.new_reserved_segments =
 		(2 * (100 / c.new_overprovision + 1) + 6) *
 						get_sb(segs_per_sec);
@@ -476,6 +478,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 						get_cp(rsvd_segment_count));
 
+	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.new_overprovision);
+	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
+					get_cp(overprov_segment_count),
+					c.new_reserved_segments);
+
 	free_segment_count = get_free_segments(sbi);
 	new_segment_count = get_newsb(segment_count_main) -
 					get_sb(segment_count_main);
-- 
2.32.0

