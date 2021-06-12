Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51303A4CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFLEzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:55:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8871C061767
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:52:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v11so3831544ply.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnfTyPm3bgkOaqftF6Jo/n40i23c68ZJNhoFhLCQROQ=;
        b=n0uBf4U1sqSecxH8rPEucH91yjL9lJa88BRoLf6hAbY8X4la/Itg3RO164HwvkjygA
         vIrZpaz5Ip1ar0Vmn88wlSIMnKpzPh1YLNZkF/yANot3VSeEVSJkvFzhanvoa4/ZDIn5
         Yg8n/k3lwQ93+oUMnmt4F/0M3ghv0nbXlHOrduQC15XXjZBeu4x/vtY/TjrVbFvXFQU3
         pgUJvwJ1e4aAD0a/xJZWy6OQEYwsi/8RKjLaXFDe0138CylfXrRBxmzu+XjYgURMwYj4
         AH6qHOkJM0CQiJaLCfrSrDcpc2ZogZ44k3W76Y8BYeUnlf12DvNsqGWAPTlJpozB6lf2
         qPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnfTyPm3bgkOaqftF6Jo/n40i23c68ZJNhoFhLCQROQ=;
        b=eCQwoyZi3oCm4Kh9P+/lQtHnNCl4Y9qwqb7x1BfmHsFIEl8rekfOqdIhmPeLJQHG1r
         VchzdYHaoHX0aX6B0hdjE2JJyzjYtmUxRKWL4o57ted7u3rBKBWewiBNnmlmaNLb/5Gr
         +GPQ0zBmM3aMO0b+uLkX6I9yHTktoOIL5iyJXPdVMEbUcUSVPR2CeDuNYtMo1QUBpqAS
         chP6JnE9OIG6ElVQVcm7dXB0HHk64oqOfakXZlYG+bS+krCwDeRVWMD9I4qxp3vq9/jj
         GaIoR2bubUVY7SPRRU4SqxDPaBxHD89Vf+OAM4p0iHPRWvGaa9VK9pynFy4zMNmLiXcq
         65UA==
X-Gm-Message-State: AOAM533dk+A3EnIrszmkyhqbfiFfzVVbYzKf6gd3PIMlrOtZh2liNzHD
        /JPJVUgnHtMK5QEUHZdh4Hs=
X-Google-Smtp-Source: ABdhPJy2DLxABi4UfSPVDjOIsMkF7VS6GItUSiF7mtxu4wZNMGNTJ3tdwn4DJtYFVBFgwAmZN4gIUQ==
X-Received: by 2002:a17:902:d305:b029:10d:c8a3:657f with SMTP id b5-20020a170902d305b029010dc8a3657fmr7008127plc.0.1623473572326;
        Fri, 11 Jun 2021 21:52:52 -0700 (PDT)
Received: from lee-virtual-machine.localdomain (61-230-42-225.dynamic-ip.hinet.net. [61.230.42.225])
        by smtp.gmail.com with ESMTPSA id m1sm6076572pgd.78.2021.06.11.21.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:52:51 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kuan-Ying Lee <kylee0686026@gmail.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 3/3] kasan: add memory corruption identification support for hardware tag-based mode
Date:   Sat, 12 Jun 2021 12:51:56 +0800
Message-Id: <20210612045156.44763-4-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612045156.44763-1-kylee0686026@gmail.com>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory corruption identification support for hardware tag-based
mode. We store one old free pointer tag and free backtrace.

Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/Kconfig.kasan | 2 +-
 mm/kasan/kasan.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 6f5d48832139..2cc25792bc2f 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -157,7 +157,7 @@ config KASAN_STACK
 
 config KASAN_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
-	depends on KASAN_SW_TAGS
+	depends on KASAN_SW_TAGS || KASAN_HW_TAGS
 	help
 	  This option enables best-effort identification of bug type
 	  (use-after-free or out-of-bounds) at the cost of increased
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b0fc9a1eb7e3..d6f982b8a84e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,7 +153,7 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
+#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_NR_FREE_STACKS 5
 #else
 #define KASAN_NR_FREE_STACKS 1
-- 
2.25.1

