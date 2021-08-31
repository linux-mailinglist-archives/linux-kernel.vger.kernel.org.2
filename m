Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5853FCCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhHaSQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhHaSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95856C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m28so682198lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAusKbpb86Vg8k5m89yF2Mh6kI0kDJIwV1Xq0hJWA0I=;
        b=rqrCS+RxI/ekdxKFmYlycymJSguGBQKJHXcU43HB1sHn6OPmupvwEmIsd69snQRjIx
         BQpqSueP5p6VI6OALuuTSnm6vHwDsTCv+Hu2X1k7fjbsGZIpOhVmZzvlD9CpofADPI76
         XeXNEKcp2aGhbCBY83R+Xk6JmjABCqNg0FwVNmx1ZKbPTpIXs2ZbKyBhqBr9y+8/zE9Y
         7RVUUVdyQUdCEnLIa78RfTPl9/E8y2Nvb3weD82wJvFbQNAaJnO9bL7lsJqdsgi92AHx
         BTdtMafN57kcKhupMB6k1NjENC0+SrchewVB/jMezkH634zHxLpTuLdAwNgYZRt7FXUr
         Nyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAusKbpb86Vg8k5m89yF2Mh6kI0kDJIwV1Xq0hJWA0I=;
        b=fxypmz0zdlvHFg1tc+4JbtAJ/+8UZnK1IUB1z5Mu2KQUTn0Tzy4+0igmlmt7ajtY22
         lWhJ/jtyLPXkrQoQyn3FPQKulI5IVk645wRq8tjTDZdImukksBpNYLG23UILT9RJDUb7
         11ooWK+v3A2W6TCVzflNHeLud4RJhsp9klZwx92NAnBkQP60pf7teSvTMD+XVa7GpIrp
         ntKOcBEm7V4BAVBLF6hVa4zG6PikJnEbUCIcYLTY/Lkbv03WIPf+n/tIZ3QzFwJt2UDm
         PTAAza10sE/gQnqQDbi++GgdIA5EDzw9xh0ll0ZqHWwtMD7fAFbHrgDggGSx0vATvqgJ
         T3hA==
X-Gm-Message-State: AOAM5322Iufe73R5JRtpzBy+RAeo3kibk4uG0qbO6KmqW2P3MIuo3fYQ
        k7CEh8YlVWznzlEJOuabu+NwnT1ZyMi8qg==
X-Google-Smtp-Source: ABdhPJzrd9aT+f5ERjLskDYJiGvaEYnZizSLZ/u+TwtTjeoh9qqRlIS4d0aR5Fn7vig9dY0U1+WHJQ==
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr22003224lfo.99.1630433716453;
        Tue, 31 Aug 2021 11:15:16 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z11sm2270757ljn.114.2021.08.31.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:15:16 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] fs/ntfs3: Use kmalloc_array over kmalloc with multiply
Date:   Tue, 31 Aug 2021 21:15:01 +0300
Message-Id: <20210831181505.1074767-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831181505.1074767-1-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not use kmalloc_array we get checkpatch warning. It is also
little safer if something goes wrong with coding.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/bitmap.c | 2 +-
 fs/ntfs3/index.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 831501555009..aa0b1ea66cd0 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1331,7 +1331,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		new_last = wbits;
 
 	if (new_wnd != wnd->nwnd) {
-		new_free = kmalloc(new_wnd * sizeof(u16), GFP_NOFS);
+		new_free = kmalloc_array(new_wnd, sizeof(u16), GFP_NOFS);
 		if (!new_free)
 			return -ENOMEM;
 
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 0daca9adc54c..7676a4a657d5 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -685,7 +685,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	if (end > 0x10000)
 		goto next;
 
-	offs = kmalloc(sizeof(u16) * nslots, GFP_NOFS);
+	offs = kmalloc_array(nslots, sizeof(u16), GFP_NOFS);
 	if (!offs)
 		goto next;
 
@@ -707,7 +707,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 		u16 *ptr;
 		int new_slots = ALIGN(2 * nslots, 8);
 
-		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);
+		ptr = kmalloc_array(new_slots, sizeof(u16), GFP_NOFS);
 		if (ptr)
 			memcpy(ptr, offs, sizeof(u16) * max_idx);
 		kfree(offs);
-- 
2.25.1

