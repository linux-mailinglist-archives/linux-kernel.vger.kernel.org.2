Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA43372C56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhEDOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:46:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:45:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id di13so10771037edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=B4nHiLO2wh+UWSS8nMkowN8uoGLUGP4ng5bJA6Dn/aT2mk9HEDCujMImCC8qUF8Z8a
         1ee/oRreuGcHIIJqyliPBDM2yLSnoAoloOPsIo6qZyRj6hi2C5FWkMYvJszCrfCZOIkv
         c4EFLCgWc7StNWAzCejjn6UbFNV3iVttdt3DfzSELZbt/Z9d93H6pWtuTJRay4WxbQ98
         zP41tLWqB5sDBw3vqn0zwzWrtV+bZ/LUZWwFr/FuNe+s5NCR3E13SaP1t7MQ8Ot2Bi9a
         VDu3Flust2W7xTSxK3TN1/m4HVCHXqanjRYwJuB3RndVYkZ8AYi2CD6khcw6qLitUxKr
         PiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=bmgFd4vu9OG/90Ac/4OkF/h6JGoU4wJA+jeqfxPGyUzfjl4sJhpfBrVSGE6PtcHawS
         VFvFXlRsLOTMygktaeoLf79xQCheFq1n8SvK6V2Yx0x+rYn8B3p1GQn8T9hqx+2qZZ6Y
         5Y9Fhfs/Hd4IQStIbw0lVZCdR+RjEnhHny2VUCuurwNwsqTOVg2YKMKqvOiS+ajcqcGn
         mDylXLmJI6H6ZozHGqb4qhb0iMDzJzfUvLKrGIOONgBCjwEh/ZDWI/fGD5t5f1RuvCaN
         WdaeljOjbUigZGNY9yOBNBK2FhnOSCX/dEtw5BRKrZjCGBd8iOW9785dybrislgVMV+z
         eVcw==
X-Gm-Message-State: AOAM530l34nnjmPgIMot2gPMqvXSo+7ksvAH3P3LYVdf7++axiFBBDMm
        l4HaHhMhMvoijSvL0QuooBHPTEqRJ6ZdQQ==
X-Google-Smtp-Source: ABdhPJywQh7Z/rRiT2Oj0+raENKuvxQxv6SVX6mNXBfLv5LTcmgM6SS+h/NyKOVGEbJMXQsUftsGSA==
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr26626682edy.66.1620139534461;
        Tue, 04 May 2021 07:45:34 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id ne17sm1496221ejc.56.2021.05.04.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:45:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: rtl8723bs: align argument position in a new line
Date:   Tue,  4 May 2021 16:45:29 +0200
Message-Id: <f195bc7d72c122e5e16b3857cf99ae1f84734915.1620139318.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620139318.git.fabioaiuto83@gmail.com>
References: <cover.1620139318.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

align function arguments position on a new line to
open parentheses.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e4f3049ac351..0cb603aa4ee6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -2056,7 +2056,7 @@ static void aes_encrypt_deinit(void *ctx)
  * (SP) 800-38B.
  */
 static int omac1_aes_128_vector(u8 *key, size_t num_elem,
-							 u8 *addr[], size_t *len, u8 *mac)
+				u8 *addr[], size_t *len, u8 *mac)
 {
 	void *ctx;
 	u8 cbc[AES_BLOCK_SIZE], pad[AES_BLOCK_SIZE];
-- 
2.20.1

