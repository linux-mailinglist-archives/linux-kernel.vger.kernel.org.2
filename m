Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE243F9041
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbhHZVpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbhHZVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:45:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72840C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:44:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq28so9869811lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u2sLPCG764dlCtKjjjtNZELRgckudXyv4A0JZ99TCE=;
        b=SfSEYa4ceYcMZE2vD2nszV8PMEFaES6s3jdiDsBWEOpmGo+FrCEN0M8B+rDxByMSjY
         u3wY9gpsHVakFG6pfrUv0HgbObKjGFR5fL/8BR9sxZMq4+C6b75Zc2ZOLqhd1diABJJ8
         XRB8xZLCFloO4wzEddwaY5cifBFXRY3B8KZfvGRZQHsrUtyzR+FA7xFwBY+69KQLiYUR
         Izx1vG6OcsiTzeWNfvbY972w3tYk9FFUfkj/6E8naor0bI9agoGlb51jE6Z9GieTORDs
         QpzAXB/vPUMSCGcTHYGqK5uSEDnK+O0s1A33Che0Ioxkk0do8Kc8BMnJtGSwmLUYi4by
         9hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u2sLPCG764dlCtKjjjtNZELRgckudXyv4A0JZ99TCE=;
        b=Asa5kCz7988xdofbX2ajF2Apc8XrZAQG89RvU1yimsxALl3rfBfpS0ikzPyjlDG2Gn
         AwjvznrxT5HaFkeX4VkjFRi96TWrVFIs3zcP6hZa3GUYF+61XXu3RxHGiOqUyat15M+f
         um/9ZOEGWq9zOTzglFj92bbgpt20zJ2tQtvnOoZxSFzetTi6RsFl4hQ7UYFSWFlZRbw1
         wjyeZox/NA70y4QvTym5XGe/O7z94nj+nc8QNd7SkwAUBcUt0qzf5xB/JacaA8cgWarM
         vkzxCkREqBkMBF3+Y1Dub1qwNHyJbaNdq/lA2nNfp7qYq6sDCQQ60eSSZwovxbXOx447
         FwIw==
X-Gm-Message-State: AOAM533hi3p2S4OxSKjVLvAwgE6HaX78mpBGYmpyucXPBU4XyhigzpKr
        VJRlKan/mGvHsOa8U+ehQCqafZhD0RsXaQ==
X-Google-Smtp-Source: ABdhPJwwz38b8mBJebUOlQXwkwCI9+afKCegro4gLYqgnO51PBRpZEotn+1jI+/9sAUNWuU8yycVQw==
X-Received: by 2002:a05:6512:21a:: with SMTP id a26mr4140030lfo.223.1630014288041;
        Thu, 26 Aug 2021 14:44:48 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 23sm417724lfp.47.2021.08.26.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:44:47 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fs/ntfs3: Remove GPL boilerplates from decompress lib files
Date:   Fri, 27 Aug 2021 00:44:41 +0300
Message-Id: <20210826214441.1614837-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files already have SDPX identifier so no reason to keep boilerplates in
these files anymore.

CC: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
This is probably ok to you Eric just wanted to make sure and be polite.
---
 fs/ntfs3/lib/decompress_common.c | 13 -------------
 fs/ntfs3/lib/decompress_common.h | 14 --------------
 fs/ntfs3/lib/lzx_decompress.c    | 13 -------------
 fs/ntfs3/lib/xpress_decompress.c | 13 -------------
 4 files changed, 53 deletions(-)

diff --git a/fs/ntfs3/lib/decompress_common.c b/fs/ntfs3/lib/decompress_common.c
index 83c9e93aea77..09e9e6544946 100644
--- a/fs/ntfs3/lib/decompress_common.c
+++ b/fs/ntfs3/lib/decompress_common.c
@@ -3,19 +3,6 @@
  * decompress_common.c - Code shared by the XPRESS and LZX decompressors
  *
  * Copyright (C) 2015 Eric Biggers
- *
- * This program is free software: you can redistribute it and/or modify it under
- * the terms of the GNU General Public License as published by the Free Software
- * Foundation, either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "decompress_common.h"
diff --git a/fs/ntfs3/lib/decompress_common.h b/fs/ntfs3/lib/decompress_common.h
index 66297f398403..2d70ae42f1b5 100644
--- a/fs/ntfs3/lib/decompress_common.h
+++ b/fs/ntfs3/lib/decompress_common.h
@@ -1,22 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-
 /*
  * decompress_common.h - Code shared by the XPRESS and LZX decompressors
  *
  * Copyright (C) 2015 Eric Biggers
- *
- * This program is free software: you can redistribute it and/or modify it under
- * the terms of the GNU General Public License as published by the Free Software
- * Foundation, either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/string.h>
diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
index 77a381a693d1..6b16f07073c1 100644
--- a/fs/ntfs3/lib/lzx_decompress.c
+++ b/fs/ntfs3/lib/lzx_decompress.c
@@ -6,19 +6,6 @@
  * this is the only size used in System Compression.
  *
  * Copyright (C) 2015 Eric Biggers
- *
- * This program is free software: you can redistribute it and/or modify it under
- * the terms of the GNU General Public License as published by the Free Software
- * Foundation, either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "decompress_common.h"
diff --git a/fs/ntfs3/lib/xpress_decompress.c b/fs/ntfs3/lib/xpress_decompress.c
index 3d98f36a981e..769c6d3dde67 100644
--- a/fs/ntfs3/lib/xpress_decompress.c
+++ b/fs/ntfs3/lib/xpress_decompress.c
@@ -5,19 +5,6 @@
  * based on the code from wimlib.
  *
  * Copyright (C) 2015 Eric Biggers
- *
- * This program is free software: you can redistribute it and/or modify it under
- * the terms of the GNU General Public License as published by the Free Software
- * Foundation, either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "decompress_common.h"
-- 
2.30.2

