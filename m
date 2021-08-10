Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54703E86BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhHJXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhHJXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC3C06179A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so701244wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkoHKZLIi1vYnWinE724V7HbW0RVvMW+Hqsc7/sVvBE=;
        b=K/2EMxsg4HLZb7mljvR8T4HU/DbvwG2J7KJab7E63OdgAIJCp44bBnvIbMSfvAiFHR
         zjPaPWZWM6Sd/xbJU82lAubvEAYGS+d4I0qMAr8MIW1s6JPRSgN2G9obBmOZyAkCbJin
         dEME9JeqIHdU3G9sYT+lGYmySA2ilrhkgQNdtFVtxA+d8Fc0ShY1u4qmDEzGzfe+mLbL
         0EZfEGpnG5/7aMU9oYJtTlAJT5zyZM8F8NfUYaBnIrQDWROyPBE6gnWfSXYVvpCzg85j
         dO0tI2HVC0JrTGHaOXcaURPLOBM4Uo3iYEbwQk5lXJ4z9FFHmCgHMTgMpCUHRzIGAcb/
         EJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkoHKZLIi1vYnWinE724V7HbW0RVvMW+Hqsc7/sVvBE=;
        b=bsCw4Bvk5HU8tF7vdxDvBz3xtbqEHj7p6VkeR4n1hE1izpnUxNrzfmgcJ6ih6VPvlT
         xYWr53tH/Vlygtj7MlbKkZlipyMl5jjei2AFuQxCGcf/lGyHXDcftxMc10LSHwzy0fyl
         TbHU9OHAAluDsO81isuD2usF9yxExtMF53K8wPja1CB8+szB4KXjWioZvzayRs9hLOP9
         xjQx8L/dkujDi6o6buU2ROplzT4xF/qrP5fvaAM/YSs3n926v2yClxHrpG2B8XeEDJIY
         g0f5FvOOikG8/QTAA5EklpKdXspwhU3QI8pFiU61rjMpd28FG1aBSu2k0NZTNYcrsYWz
         vFDA==
X-Gm-Message-State: AOAM5335W9KmjJW/8/mYoTwURrlCQrUmcUweym/utcR+InH7z45oKzy+
        Q2J/C+h73G/h+in50Z9LULzmZw==
X-Google-Smtp-Source: ABdhPJzoAbYCpWWOb4+rC+9T+SiL5kKl4hTBqxWbDwn14ing8IQkAzUPBueggGAhD1WsDzMGaaLwEQ==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr16699879wma.25.1628639452939;
        Tue, 10 Aug 2021 16:50:52 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:52 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: r8188eu: remove unused variable from rtl8188e_init_dm_priv
Date:   Wed, 11 Aug 2021 00:50:44 +0100
Message-Id: <20210810235047.177883-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable from the rtl8188e_init_dm_priv function in
hal/rtl8188e_dm.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index fab385774400..78552303c990 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -185,7 +185,6 @@ void rtl8188e_init_dm_priv(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
-	struct odm_dm_struct *podmpriv = &hal_data->odmpriv;
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
 	Init_ODM_ComInfo_88E(Adapter);
-- 
2.31.1

