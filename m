Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7359932BF01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577111AbhCCRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359549AbhCCOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:49:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42DC0613AF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f12so20168440wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03tsdJPhWuYiSI0vJFPWzGstz88JASegtGpotthaiZA=;
        b=fxop5XSojvd0qLVyjl9NSYYbfO289XRBh7TnVKZ8AUP7qlQqhkVMDCsaBbmh1o8N1m
         IZTj/mkXgBPTbgHCOzPwMYut7OGfeTAOa9Fwj5DTRahGmahmNp885YfS+9T7Ja7hlRth
         gNpliWedUAWddaYJVPX+f6aJ/8Paqa0l14ml083Y4hOE8e00Ecmm1mMkd3H59Sj/zTHR
         BXbCWL0jp5xZpzXPR+cdCxDL9LVTlh3J/gl8lzL87CY7TVfAw+BSPInONJe5ANgh41ID
         PnIDFaUSnAvxuVNJe8fTyKhiz7rlJjnDXG5mrvRV8Z3OkHtwivQzK4VuzJ2CBaPKYjD5
         plBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03tsdJPhWuYiSI0vJFPWzGstz88JASegtGpotthaiZA=;
        b=ewiIaB320S51PMSqoNSwzU7bURJYIyNj4kCBlKbSYsdcVr8GiMFroLtClQCAN5O1N3
         /TkmFe0zVnGfMwMMIAGGceHnoYuKk8E5cMe4xEipslp3Q7QC0BHYIxaqEiI9GZG+ISzW
         lgXwJ3k7MliHOZig/u9xRAt1VZQUc+ix84T1EQygZu+MDekEcLyWjSMsxj4P4wN+ITY9
         fY0IRtP0YczatNHPBq0iM/ZvhLcQmh6RTwHnX3THk9d5MK/O82WxEbnrQrgAr5BBrA6r
         OxZfI48kaFMHB76zV810gIIEXSD48p/JS+QnDvU3rgIOGm7KAniQMYAwo7SiGyg7Fqg/
         wSIA==
X-Gm-Message-State: AOAM5339i84v3KJ1eMDLVKeKpG5PtfKS7c+K/bs0ZKFlHZxIHi99FuKj
        fzkC2QYm8OeiJ7V4QDCYps6a7g==
X-Google-Smtp-Source: ABdhPJxvyd/Qrr/gP4Z+wpquuQecyDRePOIyvznf9CTCYZ5472NrUWvunZfzpLhAklmGcrL1V5fIwQ==
X-Received: by 2002:adf:8445:: with SMTP id 63mr28130475wrf.222.1614782839508;
        Wed, 03 Mar 2021 06:47:19 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luben Tuikov <luben_tuikov@adaptec.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 14/30] scsi: aic94xx: aic94xx_sds: Fix asd_erase_nv_sector()'s header
Date:   Wed,  3 Mar 2021 14:46:15 +0000
Message-Id: <20210303144631.3175331-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic94xx/aic94xx_sds.c:1253: warning: expecting prototype for asd_hwi_erase_nv_sector(). Prototype was for asd_erase_nv_sector() instead

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: John Garry <john.garry@huawei.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic94xx/aic94xx_sds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_sds.c b/drivers/scsi/aic94xx/aic94xx_sds.c
index 105adba559a1e..297a66770260c 100644
--- a/drivers/scsi/aic94xx/aic94xx_sds.c
+++ b/drivers/scsi/aic94xx/aic94xx_sds.c
@@ -1244,7 +1244,7 @@ int asd_chk_write_status(struct asd_ha_struct *asd_ha,
 }
 
 /**
- * asd_hwi_erase_nv_sector - Erase the flash memory sectors.
+ * asd_erase_nv_sector - Erase the flash memory sectors.
  * @asd_ha: pointer to the host adapter structure
  * @flash_addr: pointer to offset from flash memory
  * @size: total bytes to erase.
-- 
2.27.0

