Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0996232BB68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446513AbhCCMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356174AbhCCHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:16:54 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1959C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 23:16:13 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o8so19267367qkl.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Mnua9sIpK4opv1bat3S4YMVM0wLz7zG7EDFUzDE8sqE=;
        b=hrT1ZnLtQU+yhwzRAN83U2EvzE0FXH5gAcsU/4kIr7dt6WlCWitE6Zo4dcHWpT/xfN
         S8Bksk5PZK8jeiXjD3s91Eplec/+1eTPJGl5rTAqIP5GwQhD7rkPpSDBNy+UEBF+GySd
         yCQK23q5uHZGpA+bBUBVNvdpdbPfjlK/dAwuAZbwJIikjS6GuWDXmi8wpp/tPT/etAoE
         b+A8MIprP6qE2T5WH+CIedjotGXMb8fopDkdIz/3vVqc2Eq5EGdfaiiP7woksQ3PNuiy
         PU0A2wwI+DE+6DCtmliZw9cDO+GMbnlHE1ymcc9olNm474R/F45cdVnbVOLwlAEy37UL
         nNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Mnua9sIpK4opv1bat3S4YMVM0wLz7zG7EDFUzDE8sqE=;
        b=C+x2HEPutSYdEKNr3mVOCBRMU2fc6/Y2auz9n+Y+XfSz2RIHjwpPQPuK6BI/xKmdV1
         lLprfiqqJAxlu9dZnLtF7pn3sxDuKqdUw0DEVR3FVu4z7Cm4oS8K1YmFBv3s8GE4dnzA
         5LQBMkBsjEznPODnn1gOEoUMTGEHueiZubMlLWlBIdqzfWy8JSv4YqnD4UN2B8943p5r
         bvZCAAZs69zRfwT+FvpVHqH5zqgly9mxOSNk6QnlSDYsbY58BI1/PanqyNu4bGTVYfZ/
         n7Bzo+SgrUXTrHUi+sDJpx6HM+P8bbtsMq6dOtf5QHA5Hy5MCGdxyh7dEAbB5fe8YX0T
         4v5A==
X-Gm-Message-State: AOAM531iTiwARz8G4kSFT1wu3TWEgiLXobYUZx7sPGvK+ZH4lNId2V+S
        1stAfTKmImrHaSud51A0oMwlCTQ0uM8=
X-Google-Smtp-Source: ABdhPJyGSB4z+pduFim01lG0Bb1doDwpJf2J5Ka4e2MdOhYE45ZwWhwKA0kUzFI/+t2Id2aBe4JXpHo/vKI=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:4877:a627:46e9:4b6])
 (user=yuzhao job=sendgmr) by 2002:a0c:e84d:: with SMTP id l13mr7151041qvo.28.1614755772802;
 Tue, 02 Mar 2021 23:16:12 -0800 (PST)
Date:   Wed,  3 Mar 2021 00:16:08 -0700
Message-Id: <20210303071609.797782-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/2] mm: correctly determine LAST_CPUPID_WIDTH
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming convention used in include/linux/page-flags-layout.h:
  *_SHIFT: the number of bits trying to allocate
  *_WIDTH: the number of bits successfully allocated

So when it comes to LAST_CPUPID_WIDTH, we need to check whether all
previous *_WIDTH and LAST_CPUPID_SHIFT can fit into page flags. This
means we need to use NODES_WIDTH, not NODES_SHIFT.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags-layout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7d4ec26d8a3e..295c2c687d2c 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -83,7 +83,7 @@
 #define KASAN_TAG_WIDTH 0
 #endif
 
-#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT+KASAN_TAG_WIDTH \
+#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_WIDTH+LAST_CPUPID_SHIFT+KASAN_TAG_WIDTH \
 	<= BITS_PER_LONG - NR_PAGEFLAGS
 #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
 #else
-- 
2.30.1.766.gb4fecdf3b7-goog

