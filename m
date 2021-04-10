Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39F35AE29
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhDJOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbhDJOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E51C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so11779136ejo.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtU46/1LCpoDHI5+ceEvS4Nt7VdlaOxxUtk2UGBgKm8=;
        b=eI0Lj7Aqibnkew9+QOBTwHGS3KGqUE6jZrKJ7KbdmTFwoGno79KJdlV+kB8ZgyaceB
         UUKOtauoBD/EsvOYdHSXK4eq4M3+WsiYxGuHMEuoE1gNYVmBMbVS66bZ+TNB5D1l/a9A
         bnPkoWeQjP6IATAH/521Sm4L8GMoi1JMz+LWIT+10e3uDRijFiuDm9OQ0qOWbyWh8zwp
         MBaWHRcIoT9vWRgVpuVmLEvaYQXpvMoGxJVHu5c14d+DPIUlpsXrVvF6RKy9NxOW1dEz
         XjYZvZTPBxZTGzHE8u4DLXv6NrvQIDSCk0DcNXLqe7GT9DpPm6yanIcRNKzIIiTVH/qV
         psxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtU46/1LCpoDHI5+ceEvS4Nt7VdlaOxxUtk2UGBgKm8=;
        b=NIZGzu3PM91xnInPkE6W7ht77QNU0l/yFEpP+7yUm0AE1sGkZvxm3KaxklkBhnGpxA
         9wXbMUkNSNhHvpmRfvDOqtCIIDyn9W9xI+YDv3rLZRSGSPG81JG9DIhIZPbKNRFSFzHn
         GH62eQkxBifR0rpE+9QkP3DOOAfjNdfVH8hcJ4RyLpPqvVeBS0rceZjX+bDEgNbTfGFA
         yA/2ae2A144Sn8I4IEPpaaWZf6Xz7QBn9PKaTDCB0NQj6B2hQYOx2O8H5w1+OwqyugxF
         Fl8cdlJGvaSVW6nixOMbmWnXMI6f9nKwwAVmdE3E8zNsdwCaMgB7aopHnYI1jHCNGO/f
         u4SA==
X-Gm-Message-State: AOAM530g89jPju3uT/6zdsnIdDLLUd/755Aj5Aheuko5+qKcaadskrg4
        Pxzf7wLuMXa95R/1wtRSG5EmthySw3Xiuw==
X-Google-Smtp-Source: ABdhPJz1xEAw3u2IcZGxZu4qXL/uaIyhynwx+/3kkB1S03ho323Ps6dBy+y9GOfURyAOKExEw+egGg==
X-Received: by 2002:a17:906:1e0b:: with SMTP id g11mr16659564ejj.291.1618064461246;
        Sat, 10 Apr 2021 07:21:01 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id f19sm3194711edu.12.2021.04.10.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] staging: rtl8723bs: remove commented out DEBUG_CFG80211 symbol definition
Date:   Sat, 10 Apr 2021 16:20:26 +0200
Message-Id: <b884ecb5c83c222f0b48839f89e53c45f4489e06.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out DEBUG_CFG80211 symbol definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 074fee2052c9..944a7d2a1e53 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -12,7 +12,6 @@
 /*
  * Functions Config
  */
-/* define DEBUG_CFG80211 */
 
 #ifndef CONFIG_WIRELESS_EXT
 #error CONFIG_WIRELESS_EXT needs to be enabled for this driver to work
-- 
2.20.1

