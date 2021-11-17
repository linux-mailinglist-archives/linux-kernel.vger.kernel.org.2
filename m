Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE295454E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhKQULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhKQULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:11:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D54C061570;
        Wed, 17 Nov 2021 12:08:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z6so1969849plk.6;
        Wed, 17 Nov 2021 12:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXhQ+3Jn04hZWAOWWwSrrBaqDHKb3qy7BUYLOzIA82Y=;
        b=AnbFPe4rxsVvoP5ThzxdvzzUonrraShg4Gp9LKY/T7ZCP/OeA0BXBHSIlArEgISHub
         NgF1ro6yj8DWgysNhbjrQgleIptq0BcehiDgsqyjGRla8s19jqKvF6fRaufhBM3rVUdV
         BiOgw0xuujKmVdAM3r4s12olwSsQT208oIXIjiPJkinmqJBFpVZ91IXJHFUZaA1qOhAh
         qhKzBFX1yKddzxKOYN9kP8T9qrZZerW0RKr5efE25pKeERFMkIp0tuSUbVPX6OVBUtUT
         TdaF+Fkn2MU67UyD+QgLnsJHhye4e7rigHeo46EOugS5T5bjcGQyoGA0tE1BaHTbP1lT
         WXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXhQ+3Jn04hZWAOWWwSrrBaqDHKb3qy7BUYLOzIA82Y=;
        b=NdzK8/cx/aCIfM2swuc4JXOgifIjbP5hcwyOmBZaESFz9kGWOd/zaXZREjCwps9Adp
         26pt+qWD4DV/EBd2dhW4l+EXhgHzEn+dVfZK47m5xfL1G3ogxxnpS84whbWjhDFNck4b
         jfGzK0CQsi5avKCIOUrADrXRg173MPHzHhrYwRn1UWYHAIXzmTkj+3C9yTixuGqqJzwH
         Cw7jjFfB4hyXPLFfCCrAZTvW7sqfTdTkcduW3xzvMegApCjQshBW1z/b+gcHxofT3/1R
         0e5I9nkT43MvSpjTkVayawgDkOYsV98eMWnqw3T/P0HjOk57V5Jq0qdZJXbhhV66ng3+
         wS2A==
X-Gm-Message-State: AOAM530xGdop+Ytxy68nu8ei4xr7L5Vz1jvBfWp/9wx+W6YItYR3A7Au
        Bz8m4g/WJ5+8XKW8z+ulN+/J8HNOuE8=
X-Google-Smtp-Source: ABdhPJyj8VpHNsX4Lt8HOHn8AADwSZvEGUG3efZ+Hs9TbPRQ3Dh61Vw5RzjCHealiPii3lV1qfbWfw==
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr3027078pjj.40.1637179713711;
        Wed, 17 Nov 2021 12:08:33 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id rm1sm6511050pjb.3.2021.11.17.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:08:33 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 3/3] lib: zstd: Don't add -O3 to cflags
Date:   Wed, 17 Nov 2021 12:14:59 -0800
Message-Id: <20211117201459.1194876-4-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117201459.1194876-1-nickrterrell@gmail.com>
References: <20211117201459.1194876-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

After the update to zstd-1.4.10 passing -O3 is no longer necessary to
get good performance from zstd. Using the default optimization level -O2
is sufficient to get good performance.

I've measured no significant change to compression speed, and a ~1%
decompression speed loss, which is acceptable.

This fixes the reported parisc -Wframe-larger-than=1536 errors [0]. The
gcc-8-hppa-linux-gnu compiler performed very poorly with -O3, generating
stacks that are ~3KB. With -O2 these same functions generate stacks in
the < 100B, completely fixing the problem. Function size deltas are
listed below:

ZSTD_compressBlock_fast_extDict_generic: 3800 -> 68
ZSTD_compressBlock_fast: 2216 -> 40
ZSTD_compressBlock_fast_dictMatchState: 1848 ->  64
ZSTD_compressBlock_doubleFast_extDict_generic: 3744 -> 76
ZSTD_fillDoubleHashTable: 3252 -> 0
ZSTD_compressBlock_doubleFast: 5856 -> 36
ZSTD_compressBlock_doubleFast_dictMatchState: 5380 -> 84
ZSTD_copmressBlock_lazy2: 2420 -> 72

Additionally, this improves the reported code bloat [1]. With gcc-11
bloat-o-meter shows an 80KB code size improvement:

```
> ../scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 31/8 grow/shrink: 24/155 up/down: 25734/-107924 (-82190)
Total: Before=6418562, After=6336372, chg -1.28%
```

Compared to before the zstd-1.4.10 update we see a total code size
regression of 105KB, down from 374KB at v5.16-rc1:

```
> ../scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 292/62 grow/shrink: 56/88 up/down: 235009/-127487 (107522)
Total: Before=6228850, After=6336372, chg +1.73%
```

[0] https://lkml.org/lkml/2021/11/15/710
[1] https://lkml.org/lkml/2021/11/14/189

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index 65218ec5b8f2..fc45339fc3a3 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -11,8 +11,6 @@
 obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 
-ccflags-y += -O3
-
 zstd_compress-y := \
 		zstd_compress_module.o \
 		common/debug.o \
-- 
2.33.1

