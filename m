Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF03D724C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhG0Jou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhG0Jot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:44:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD1FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:44:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l18so6745610wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rAnUOD60UWbYI3PmAoUnnbt/WY/WxPSncO2uhBInP20=;
        b=MZRiCufJhh1N8KhiaHW7Ht8Drxsx3tA7EqoSepn7KkLv3lojr6apA6NnX71IxeQs/t
         fEBd26GgwxktQvSriNHO+pMeDh6LCfL3dD5DRDGmA5+bWXf4So/pDBaf5IRU7YktvC6v
         CbrkiCk5ijUKscAQx8R7+JZ5SFeSGp+BIDleC6rGoEBkgdPZr7UpR8HSuXx6qWMrHj0f
         wqVOwP+agpfB/QvYyYaX+K/OxCGo3ONan4hD3omyaGaaeYvBf0VtYNJEP3XbEM/9b7HX
         AGLZj20wbfVhZrQ7JIKQ0aqsfiVTFPv2J074brlpqjBPVQiH7KNM9IP48vLgL3oC2AUP
         cVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rAnUOD60UWbYI3PmAoUnnbt/WY/WxPSncO2uhBInP20=;
        b=SES9Bf78PFLzGQ+EsCVJ34QMMFioeosEoQQbHtb3jpcvn3iLKKSIan1jB5S25jObK/
         B00vjnOSGCLI0W34HSew3TFWB8Mr0glO/xyJ6spYH6aWDWXHc5WgwyadTNJoptljuRz/
         hMpOSnmxTm54jb5VUKrxANgEhiU+0wBIG6KS2Iz2mKmQmeVGtysC3PM7GWHYA6FAjHoO
         jZIvC/RK5ejA1TOF6HfIrlEsMPRZrzibDduDIOd6aqy5VybVE36U1ehmTZLyPJjMgqU5
         g8rxpfsJDHKDbLZvl0tRSYKTCvD634yZs9TVCe3opqePb4VWjcdFDaSFEZmbKo48t57+
         mFkg==
X-Gm-Message-State: AOAM533YVo8g/+F0HJvCjvlODUcsXW8AEGkoQWzFs9VzOC+ZHXTFH8wP
        +Ipcm4N1FpUbhYmCfI+6IdxprTuLZzx8AviHK15oBQ==
X-Google-Smtp-Source: ABdhPJzN/C3ZrHODi2ae41yCoLA4ZB/o8q27bAUtuZ6+kLPyH58svkgLARZmGnt1TiD6cue7cS3f1Q==
X-Received: by 2002:adf:c3c4:: with SMTP id d4mr13704607wrg.27.1627379087138;
        Tue, 27 Jul 2021 02:44:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:2e5:a482:16dd:a9ff:fe7e:d57f])
        by smtp.gmail.com with ESMTPSA id z11sm2610328wru.65.2021.07.27.02.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:44:46 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH v1 1/1] bitmap.h: add const modifier to bitmap_next_[set/clear]_region() argument
Date:   Tue, 27 Jul 2021 11:44:41 +0200
Message-Id: <20210727094441.9815-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two functions don't modify the bitmap, so their bitmap argument
should be const. This patch add this.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 include/linux/bitmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index a36cfcec4e77..ea4a8f1a2545 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -458,7 +458,7 @@ static inline void bitmap_replace(unsigned long *dst,
 		__bitmap_replace(dst, old, new, mask, nbits);
 }
 
-static inline void bitmap_next_clear_region(unsigned long *bitmap,
+static inline void bitmap_next_clear_region(const unsigned long *bitmap,
 					    unsigned int *rs, unsigned int *re,
 					    unsigned int end)
 {
@@ -466,7 +466,7 @@ static inline void bitmap_next_clear_region(unsigned long *bitmap,
 	*re = find_next_bit(bitmap, end, *rs + 1);
 }
 
-static inline void bitmap_next_set_region(unsigned long *bitmap,
+static inline void bitmap_next_set_region(const unsigned long *bitmap,
 					  unsigned int *rs, unsigned int *re,
 					  unsigned int end)
 {
-- 
2.17.1

