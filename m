Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D53450AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCVUXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCVUXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:23:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B770C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:23:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g24so13351654qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnJ/63wmFQEzzwpKK6049nIs+4oissyxFFyozTwnUYM=;
        b=hSyAbI8WfnvZXFYabJXhhi4xpNgkC7vwIV51vfxXOUJOT/5Wpu5atfY1KdkB+jimfX
         KCIxgDR8/GKCd3PI/S/KGvuHZNF0Rb2r0SNlgK2jkQELravK3j8uond2Ay8JGAzSHF44
         1mc6gKaTbfwf0PzDzsfIM37rOp1tByIagQZIaowDgzLMhPskTbCkU3yAWiQKCK3PV2q3
         8aVwtCtOERZSo80+lqastKZIF09W3sylnwyw55NeTQWF4qhO2BxDsndktiZttFD4nisv
         pGGuI9DvCNpjFAg6eZXvGccCUptxzBU9JYFHCvxUf4YvjdJs91q2xDUcb47WqStp9IdV
         BHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnJ/63wmFQEzzwpKK6049nIs+4oissyxFFyozTwnUYM=;
        b=Uv3RCuZBGcCr/HNCDvMMZPSojHkdtG0HhjOpuV2dK5z83KH4lVcvpWP2NivUo76ruJ
         tZAXe5oiqF+rRT+mrbVlR9da2cBCNxff1wm+buE2fmyarcmIZhmcWr5ULXy9ATvxrs1y
         KTUGSPN7avIpx8tRKECCjC9PXJrorb7P82ZFkzz6KS/2cpgQ1zBZWcz9hAwDjxZwZaVP
         xr21eyADQET/22+0fInMGvFrVVy9sCp9N3R8J/1P6R80Yq/BiWvLDGFtx9QyZ3eqCsxQ
         0z3J1GIXYG5wLBh7x1tulXEzYBhFYxXzKhrle5rMhCoygQJuu2K22iSQRIYfuh9OycLB
         4kQA==
X-Gm-Message-State: AOAM531y2aufeZzAG5TcPU/aFU27ijcQiCe/xql/oUFpEjtPu2HDAnBX
        YnKFLRbcwppRAFDppsYHNPc=
X-Google-Smtp-Source: ABdhPJzqgFWtDp4ZWRucWiih1ur+EkNLACfHfZ5ue9exunebcqFQdpXaXFlDFa52GVklrNLavgX+5w==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr1633705qtn.66.1616444624582;
        Mon, 22 Mar 2021 13:23:44 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:edbf:169b:db3:60e6])
        by smtp.googlemail.com with ESMTPSA id f9sm9776710qto.46.2021.03.22.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:23:44 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v3] qnx4: fix use-after-free caused by strlen
Date:   Mon, 22 Mar 2021 16:23:28 -0400
Message-Id: <20210322202327.1361932-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If di_fname is not terminated by '\0', it can cause buffer overrun and
trigger a user-after-free bug. This can happen in some corrupted or
 malicious qnx4 image. Use strnlen to prevent buffer overrun.

[  513.248784] qnx4_readdir: bread failed (3718095557)
[  513.251109] BUG: KASAN: use-after-free in strlen+0x1f/0x40
[  513.251268] Read of size 1 at addr ffff888002700000 by task find/230
[  513.252069] Call Trace:
[  513.252869]  ? strlen+0x1f/0x40
[  513.253237]  strlen+0x1f/0x40
[  513.253329]  qnx4_lookup+0xab/0x220
[  513.253431]  __lookup_slow+0x103/0x220

Co-Developed-by: Anders Larsen <al@alarsen.net>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Anders Larsen <al@alarsen.net>
---
v2: The name can grow longer than QNX4_SHORT_NAME_MAX if de is a
QNX4_FILE_LINK type and de should points to a qnx4_link_info struct, so
this is safe.  We also remove redundant checks in this version.
v3: make commit log short and resend

 fs/qnx4/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..2bcbbd7c772e 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
+	thislen = strnlen( de->di_fname, namelen );
 	if (len != thislen) {
 		return 0;
 	}
-- 
2.25.1

