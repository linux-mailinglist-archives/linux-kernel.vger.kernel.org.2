Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28E3D335F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhGWDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhGWDTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:19:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D3C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:58:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t21so1536482plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8J5f50KlXoN8UBa4hsGQdCO3pR6zbgd+IL6vlgdIA=;
        b=Zbs/2a6fQawK/CttSHM+tr2A79wyGBgbeXhuuOJLULOF14Nw1VYVjzO/8YcyLa+cXY
         ALoICMmLFg71PiIbbyBShV6mYQceCxLyYlrSmZoxwVpB1Pa30pDY6K5I/rqtL69spztX
         cep9NOSEN9uBdDtq7RsAfVTC8E8ECzsGOQBgywDGB7ieYXHi3SXDODIFof/cxJK6ZlfA
         hGVcBmJ2CxfYTFb6nJDdkcQxFjfTYanZ9SVJXqASwnS16VSTBGh/W2+mR966mSp1+OJr
         exBSR+Z0nMwBIHgoTq6JUqlXmGc0SmLKb8FqW4aADnCp+rc/3DCI6TxgIVT8DxDW5RJi
         B4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=un8J5f50KlXoN8UBa4hsGQdCO3pR6zbgd+IL6vlgdIA=;
        b=E8mXZ21GJZ5PHWxyWoxSbbOFiCBmJtNkUZgnDh7kijA9HXEtVZH1DLGbU1I7BkFeZA
         cwXaPMVdH64g3dmy3Y4KnablyRGeoypeE2asRb25OEGalOdJdXPGkzu57QXn4GFUJGkc
         s5xOVjuuPg9blav/0djTOJy92E54TrvU7XLJ2QzmTJjJuVsI4IlFe3r3KeLNZd0NXGko
         lPAxZYAert9Q/zFqTNfM+dmS+0gD7wnN3K4uSM4WUMfbHCbmaFdKcFm6SmnfZtfhHsZK
         cO1HUQTPkFDXIBD+gexQbjuXQgt5v0Af5MynD5xMlBX31BZj4/ZLrU3Sr0VNRxwuCUwC
         YEBA==
X-Gm-Message-State: AOAM532s2VWjBvSdwIF1Jsct35R/Z6himW634W8tD7yf2yc8nuNU12pI
        xWzAiTvN9IcHp212gj11x3s=
X-Google-Smtp-Source: ABdhPJw60JjpiyduZTVSwtK0+21UlfAsWzjv4g9tsxF57a7UL3pFL5+sybvri7NujsaWjUN6iv7ODw==
X-Received: by 2002:a17:90a:b28a:: with SMTP id c10mr11587363pjr.59.1627012725726;
        Thu, 22 Jul 2021 20:58:45 -0700 (PDT)
Received: from liuchao12-Ubuntu.xiaomi.com ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id x40sm32710755pfu.176.2021.07.22.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 20:58:45 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
X-Google-Original-From: Chao Liu <liuchao12@xiaomi.com>
To:     chao@kernel.org, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [f2fs-dev] [PATCH] resize.f2fs: add option to manually specify new overprovision
Date:   Fri, 23 Jul 2021 11:58:41 +0800
Message-Id: <20210723035841.1829101-1-liuchao12@xiaomi.com>
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

