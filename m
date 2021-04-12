Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5B35C53A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhDLLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583ADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:33:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so19691242ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFOYSnG0uAZOFDRBzKSLYJWpH1A2gN1Kh1MIiN8Kse4=;
        b=ZfIb+yOrllbJjIxtzUEUbY2HofNSJxmYBhnPCPDkFYz2CLUs2KXAzIIpn7v7YKbRVE
         or6nNNylncFAQ8WRUupyirMTdv02HSLE43rq4eWis2eV4TxEajlEM4CbddLLc57Ekqoh
         reMfLIzFWgAXP1MV2G4baewCSm8QwnK7hRZSXvtbtfHRCIQuuaq4ZOwZKjfjioA48+TI
         NCrY4HPIgyK/Y8Q/ZTMKn/lEvNTrmJz+QtiHE5S9/9AdXTti/EsSs0afqHLzYB3xQv2x
         GKK2/gTByD+nqLrM9L/Noqyt+0EzwJ5shiFi256q8rIa/DcagSW6nqAGq19Eb6oT+ZBv
         waSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFOYSnG0uAZOFDRBzKSLYJWpH1A2gN1Kh1MIiN8Kse4=;
        b=bWOyHvS2h3jm/8adIy764gIlc5Nekpauvip/YSFGv9YKpzl77/18YmOeulNPLiQR7X
         dEtg28qhP6AnVDCtFajDjCmcZ85sQmgeAkyqyH/UodM44fXJkeh1MCjzn90bM0g0qP25
         SOq0g9Z2o0o7JsPy9MLrYi+5WHLqJQQNEjDewLgU026OqJ3itNd9Q+9V4Pitl90mZerR
         ke95cL6VD11UgDSflHgARSXMa71XMwDVob+CJLDUaf9QlorTTHF7bwS1gj7J3VtojnIe
         QHWIq+BxWNQm9N+BHTQqe6qQqxsxTmBdiCt822n7BYwsqe7A/UmhH822Phn3KB3HLvQ7
         H6XQ==
X-Gm-Message-State: AOAM531reyZbV+I+27r3soOkj7EnMS2+dYyxCdluXV74ZW1BVo4hqhf6
        /XRls2EwS1snF4nlyVgZGJY4ZJdXpyV5aA==
X-Google-Smtp-Source: ABdhPJx+gt1zq2N+CJOqhtGWK/9A48fAHAVdqQrhevcUMhQY+/+dAL2ib41rLo+VJSr+N7gc7SII1w==
X-Received: by 2002:a17:907:760a:: with SMTP id jx10mr16076840ejc.126.1618227197981;
        Mon, 12 Apr 2021 04:33:17 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id lj21sm3490434ejb.74.2021.04.12.04.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:33:17 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     ndesaulniers@google.com, gregkh@linuxfoundation.org,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH] lib/string: sysfs_streq works case insensitively
Date:   Mon, 12 Apr 2021 13:33:15 +0200
Message-Id: <20210412113315.91700-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the name shows, it checks the strings inputed from sysfs.
It should work for both case-sensitive filesystem and
case-insensitive filesystem. Therefore sysfs_streq should work
case-insensitively.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 lib/string.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 7548eb715ddb..d0914dffdaae 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -688,7 +688,8 @@ EXPORT_SYMBOL(strsep);
 #endif
 
 /**
- * sysfs_streq - return true if strings are equal, modulo trailing newline
+ * sysfs_streq - return true if strings are equal case-insentively,
+ *               modulo trailing newline
  * @s1: one string
  * @s2: another string
  *
@@ -696,10 +697,11 @@ EXPORT_SYMBOL(strsep);
  * NUL and newline-then-NUL as equivalent string terminations.  It's
  * geared for use with sysfs input strings, which generally terminate
  * with newlines but are compared against values without newlines.
+ * And case does not matter for the sysfs input strings comparison.
  */
 bool sysfs_streq(const char *s1, const char *s2)
 {
-	while (*s1 && *s1 == *s2) {
+	while (*s1 && tolower(*s1) == tolower(*s2)) {
 		s1++;
 		s2++;
 	}
-- 
2.25.1

