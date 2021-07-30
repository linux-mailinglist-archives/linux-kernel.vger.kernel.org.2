Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F33DB982
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhG3Nk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbhG3Nja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:39:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE369C0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:39:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v21so16929131ejg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0btF4f/Zvh8ltVtQYn7h5KQSDQ3I8KDE+5fPKu995k=;
        b=hPiUBRyGda0IX/B4j3VjgPyJnQFYM02UALv5krx+Kre10dP4TC5N3wtXmpk8iGuSNh
         k40fqHNR9LvU0b3umAKFhJkKKPAPgam7hWUy/noT5QgD9D2jslVizzGEx3w71oZ/j11s
         +GHI28AxrqsLk/dMPtyX8WAn+EwUjQ5Rc7nPWoo1bjJUSlKYaY5FDiknJJxogcJ5MMEW
         TWLH4pWFDgszr/dF8XeGZFgRMKtid/pDu8LEOMC4AMlDcRzKsSYMXdNz/b54oWyEbzvl
         YeRNZ64jXpxc9FJ4NiqkPtmmUL3Vq8HrAX6qc0KQf1iIpCdeN1YsY7BcZqoO5roDDiYr
         Iz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0btF4f/Zvh8ltVtQYn7h5KQSDQ3I8KDE+5fPKu995k=;
        b=SdP/dhea+dlmPui5Nn28h18EU96c+7zK5qDQ8mY8Tf6fkklfYpA/x4gfQC9Fbdp1gu
         PKN6RREiWIvambewBF6YBNy2zEnJUlxANrQL8otEIqqLsXU0sygwISqWBvdcnqnyfJar
         SAjoRW8adR/KpRkD0a5am6DIR3Lr/7ZVdrZ8ctmEHYrZK6deIVIZ8N8yt341P7tztWco
         uuF7EswVHAA9VE2p+C4Sg/VWy1XvtBsvjHSx27KAURiXXRKEjTbjUo73V4C/a2a5HsI9
         iEHbuspaSu3c5KUc1IXYatLpQHBVMFKlFmbSTyxAu3iZUY9Eid91/JgE0wbrTM2862KI
         ERQA==
X-Gm-Message-State: AOAM532UUEkhp4uVBrxUWYLIJKrWwaqL5sKJNJWVH9vu8I9gcrEGGR2s
        iHe7KtcPqn0q4n0lJSjVnh8QF4heeHg=
X-Google-Smtp-Source: ABdhPJzkonuszswUXBNiYdEveClGgPkKuD+AySlZU3GjiykkX1D6Mz0yP9Jk1MIbgvTHB45UMFK/lA==
X-Received: by 2002:a17:906:7393:: with SMTP id f19mr2750212ejl.79.1627652355408;
        Fri, 30 Jul 2021 06:39:15 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id p23sm727983edw.94.2021.07.30.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:39:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     fabioaiuto83@gmail.com
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] staging: rtl8723bs: remove unused BIT macros definitions
Date:   Fri, 30 Jul 2021 15:39:13 +0200
Message-Id: <20210730133914.8625-1-fabioaiuto83@gmail.com>
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
	- edited changelog

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

