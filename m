Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB373DB93E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhG3NTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbhG3NTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:19:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:19:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gs8so16706338ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MF64PGrmt62Tg3j2Q8W8RIILeBRNoYtBq41HoRE+f8=;
        b=Tc9lEn7j6y/aCKAXrNMnvd+Q8kTkrCT6KqRNBpFm0jHiIsUEmqec2Bv0d6GycFf/uo
         B7dEGqczLg7gw/8SW1D214ApumxbhzQBLBLFvNDMs5XmaP2c/d83S7QenrvdUse+fEXn
         bFoJe9fTQl6b+u49HM2skCyEY/Bq4LZgtn8ruy8DtNvKh5IxzDFckUyxuSz8MfuJ1pv2
         BoeHP/qruhjRfcjjVToZWo48OqDxQABM4tBpeueDXD2TxjzaAgd+vSLx5HwFvgwC3Lpz
         B+H6kgFePYhf+LLOAlEqm3jK1SWa0ovlwvBOnlcdvTkDJ58w0NPrZ+3ncTm8yYzZZsdU
         meXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MF64PGrmt62Tg3j2Q8W8RIILeBRNoYtBq41HoRE+f8=;
        b=VfMRUXgbOjEhtCMeK/tKdIIE1WderR5I4xf5TbSdFOGxyD+KQPf3QigFWS19rNxPiO
         hz/KJTztp5B1qBVUuhWq0/Zt204EbCZURH5os5bCynpKUvRpsXfmzwiIv5ZwH341e674
         Bf9LOZAOwby3Nji14IixA5zfiAhxsCKAbC7pl5zwS+aGJfL2rIAayDEgGx2Vskw/ZScq
         RYCO8qjnHj1P76/+RCjRXx0OXownDSP0DFtHAQeHaQXBmdVJM5adZSgkW9KU57Qxwgn7
         NFyHywX3vRDX2v7c5kJPdd911O9Tcee5m+HbQ3pPuHl2tH8VuATwLuFgmvyS5mbk5yjK
         FyLA==
X-Gm-Message-State: AOAM533FNuX3LlPf6OPHWCvSnxP+Qk3nM/tBOADsn0DIBP8cSMxsMtAO
        ac+Y5toSfCdr7lefwAM4DAc=
X-Google-Smtp-Source: ABdhPJyS2LLUlLpQY+tL1leyrtNyXICYy68OFAYSNK1qlpPmhkS/M65NC7DnNNzPYsJ8Rs+j5awIgg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr2612186ejc.188.1627651145081;
        Fri, 30 Jul 2021 06:19:05 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id g8sm699706eds.25.2021.07.30.06.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:19:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH] staging: rtl8723bs: remove unused BIT macros definitions
Date:   Fri, 30 Jul 2021 15:19:03 +0200
Message-Id: <20210730131903.4846-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
---

$ ./shift
ffffffff80000000
80000000
---

So just remove redundant, less safe macro declarations.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
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

