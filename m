Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B493DB984
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhG3NlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhG3NlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:41:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C61C0617BA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:40:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id go31so16855483ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7470Qthj2WoaNQVaHaNL2p6JSX91F+g/VNrFt77iGeI=;
        b=nvjUC4gNjw2JuQDVO6ggPrZDVysNA8E0HOXRenPw/LZLrKVY+Ao+hUmV4KemczMwmt
         zrmr32M65dBC3hNaqV7M5CaLsA/kSVQdubQMKQULsVI/mOTBDSowi1kNAh5IuriJxTSC
         dQd85zJOWN30aLDjqqBFDPjgNGgjc8axDWFVPFv4zGFkd0Ye/lLeO9pAjp9PY1wGACDi
         IYP4ZQ1yE//NP1ZCnMjJFvf69WJJiQoLvH6vy1AG6GMHOb6HZbeOOpDWI/RLbzQw5/T4
         xA9ZsJwtmd6Mesu41u73x7qU/nUWpBmNLfgqiSrGtF77g6bKSfVDLRGRFhb/x/he6HTO
         CJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7470Qthj2WoaNQVaHaNL2p6JSX91F+g/VNrFt77iGeI=;
        b=rqtd4MjXNrWK+7mCZaWCvfzJagLFMJH15seB7J0ZMlzdwDw/YCy4EYrLK8n8xU8tlF
         ltnObvZyPHBHrqeDDS9oP0TznWNQLgnWuDbvUXoYPTz7skqpVNgqwGplcNm3zWBGASsm
         S5z7ZjG8p+s+g+tvBADd+b77KxlQyjN2MpiWQP1Y7X83IwZjHI1fvGRbmzMTgZj3s9ds
         34jsydckZhor4lhxLkd2p4WUObvx/vlVs7hUHVQwYDvw79fbFCjuKoQw7TZa2FpaMkte
         6OJ0pcPEpn/DJgxZ6fQ+GFIGfVprGMxk+0K/3if5aVDRsXDUO28sUwLyEm6bnjoZRkD5
         A3Cg==
X-Gm-Message-State: AOAM530GXIj4Xi67D4J9LcKu1jHhSn+ZILSxQ60XXZDYjAyHDoOj5iBj
        6yRf5kwSL2DaRCY+QEd5K4I=
X-Google-Smtp-Source: ABdhPJxvlPv3Eu6LxFIMgqRhcsgQGVn9JrLOqSdWTuC38Omx10DRbw0NlAt+TMzgozC61Rnnrc+e0Q==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr2591713ejn.57.1627652450605;
        Fri, 30 Jul 2021 06:40:50 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id n13sm574146ejk.97.2021.07.30.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:40:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] staging: rtl8723bs: remove unused BIT macros definitions
Date:   Fri, 30 Jul 2021 15:40:48 +0200
Message-Id: <20210730134048.8736-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIT(x) macro used all over the driver is defined in
include/vsdo/bit.h as

	- #define BIT(nr)	(UL(1) << (nr))

which is safer than the local BIT macros declared.
Local macros shift a signed integer which brings
unespected results. For example:

(unsigned long)(1 << 31) => 0xffffffff80000000

shift.c:

int main() {
        printf("%lx\n", (unsigned long)(1 << 31));
        printf("%lx\n", (unsigned long)(1U << 31));
        return 0;
}

...

$ ./shift
ffffffff80000000
80000000

...

So just remove redundant, less safe macro declarations.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
Changes in v2:
	- Edited changelog

 drivers/staging/rtl8723bs/include/osdep_service.h | 4 ----
 drivers/staging/rtl8723bs/include/wifi.h          | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index b49838c7e457..bde415db4114 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -14,10 +14,6 @@
 
 #include <osdep_service_linux.h>
 
-#ifndef BIT
-	#define BIT(x)	(1 << (x))
-#endif
-
 #define BIT0	0x00000001
 #define BIT1	0x00000002
 #define BIT2	0x00000004
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 0bd7b662b972..f03e26818d45 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -7,14 +7,6 @@
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
-
-#ifdef BIT
-/* error	"BIT define occurred earlier elsewhere!\n" */
-#undef BIT
-#endif
-#define BIT(x)	(1 << (x))
-
-
 #define WLAN_ETHHDR_LEN		14
 #define WLAN_ETHADDR_LEN	6
 #define WLAN_IEEE_OUI_LEN	3
-- 
2.20.1

