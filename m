Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433A144666F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhKEPwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:52:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42494
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232592AbhKEPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:52:29 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B11AD3F1DD
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127388;
        bh=O16OdHn+GTs4ijs6PH3u89m4wmvvKfK54fa2lozmRZs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=r0S0hC2Zdk6ru6tVnHqGcTCQi7SyiqqVbaxA6dPaSmnq7hoRbJcMR67I0/jYyjZFI
         zHYFmUggBccXzEp7vt6bVrH3n2GruBDxcBiAECvfpAjD4yvO6vZjwRMYjdDggz9uy6
         42FcfzyE1c06aGcd34GO9Ads4f/Th++H5DXuoneZFOpFoG1aBPAMwWackJWsjiYapp
         R+UVy3NcsKPa04yec7OPXeqmFYYjKs7zIYguLHEJOiPd4nhIzZURxa8KvftMfKvSCL
         dJjrzaYtqVFWkU0P2+2o5E4Co6BRJKZGE9d/xAj0HPieSX0NU8p+Zcsnv2NibzM5xj
         xxyIN9oY7Xcsg==
Received: by mail-wm1-f69.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso5846634wml.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O16OdHn+GTs4ijs6PH3u89m4wmvvKfK54fa2lozmRZs=;
        b=wbXGMjbmVnDv7+FXm8P+XiV/Izd3NCtO9vIodCf8DC5n7j1TPiwErB1oIOJn5hleMs
         Wg9q3JFrW9gpyZ2WP12YbxRK8yrFlXixRx3AbIaPFtWGLjXkdn+whQSit4mPIWNehCoW
         wK25A/QoLZjLWojb7s7idkAeKNPT2Ncp2Om6T/HPPV01ebgDyOfvyvMUIa32Z80y3mLq
         HrPsh3Frf8BQqOljoMQe6MtJdxBr1cGfJGBKXZlhELx0ifQtkyrbXzx0WrRD2PgSGCPj
         yHrSXL+Mq6B0uNKSnE+Z6bwbjpRVN4h5vRZl2xENVQeaKCOEIC+NeTCpXes+fpBDNAN2
         xaBg==
X-Gm-Message-State: AOAM531r8vHCkP/pMhRFlWRbmqrOBIRUMoKOZ28OVhNkL30366qgKemM
        PqwyWeZ+hCFU3da5mfxLp0JyLj38vdTwvt+F6aKg+Bs9/MwW/prCKFWx4BS/yoqw5HMV6xq/9M2
        fkiUYtI12+jaB8PO2PSK1vVu9qqSAGHihvpcMBSVv0A==
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr51023057wrq.221.1636127388424;
        Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY603x0zr+Chuyb1t2ADL8WGsBiGEq/MpdSLq2l9mjdNq6e20HunukFRMlsP5KMMQo9T/EOQ==
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr51023001wrq.221.1636127388217;
        Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id o25sm8150426wms.17.2021.11.05.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:49:47 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 6/7] include: mfd: Remove leftovers from bd70528 watchdog
Date:   Fri,  5 Nov 2021 16:43:33 +0100
Message-Id: <20211105154334.1841927-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was removed so remove all references to it.

Fixes: 52a5502507bc ("watchdog: bd70528 drop bd70528 support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 include/linux/mfd/rohm-bd70528.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70528.h
index 4a5966475a35..297a4a84fff5 100644
--- a/include/linux/mfd/rohm-bd70528.h
+++ b/include/linux/mfd/rohm-bd70528.h
@@ -362,28 +362,4 @@ enum {
 #define BD70528_MASK_BUCK_RAMP 0x10
 #define BD70528_SIFT_BUCK_RAMP 4
 
-#if IS_ENABLED(CONFIG_BD70528_WATCHDOG)
-
-int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state);
-void bd70528_wdt_lock(struct rohm_regmap_dev *data);
-void bd70528_wdt_unlock(struct rohm_regmap_dev *data);
-
-#else /* CONFIG_BD70528_WATCHDOG */
-
-static inline int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable,
-				  int *old_state)
-{
-	return 0;
-}
-
-static inline void bd70528_wdt_lock(struct rohm_regmap_dev *data)
-{
-}
-
-static inline void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
-{
-}
-
-#endif /* CONFIG_BD70528_WATCHDOG */
-
 #endif /* __LINUX_MFD_BD70528_H__ */
-- 
2.32.0

