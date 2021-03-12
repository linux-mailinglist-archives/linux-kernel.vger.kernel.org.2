Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F062A33891F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhCLJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhCLJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27348C0613D8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso15385374wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TKoXnvIDGaG9mQ9ffqN6eqPBIG/XMBZKnS/ZHsZvNk=;
        b=nzyvqhhToDGBMD1H+5K71jkJajZQm+txYMxGQ0Jygup7M6VUx1LUGjKP09It0oOCra
         0jncPYC+gtTyQrUAofcH0Xi3FCz/dNw8xqGdD34XErEX+nYFpwt6PkJj/Tfoan7C9rHd
         uJRciNGzJNNIKe/HEnpOZkGxXQkPA33K9asn+gjxCG/k+LpykVWaoRKkAWQdzJ5qqqMx
         Xnn060ci19tH0qQO8RZnBLQwc5qWbAkKEmlkUBHewxHrKrxJUsumZNtK2pHP8a074OrI
         041a/RcbTcuA+SsMzO2KWyqxdZzFsHFekk+14M1cflenctKg3tdOFPwIARa0KPOa2567
         hTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TKoXnvIDGaG9mQ9ffqN6eqPBIG/XMBZKnS/ZHsZvNk=;
        b=OQ/+gseWV/Cf0VQD18bTtWFI6Rq+M4T+Snff9/SHFvPe7vPlrqKWQRLhsm3ob6uNbc
         ZrQSd//7UKzL15CxDqK+z1Lj4BaTRgK1/N4IWt7WXv5wN5Wp+cElllCWasg3PaLejTZ5
         fmsO2XLXXQnY7tkr13kaCt2Abs9jWUqz0gL21lKPxylWMNS6hX51KxyCPcvDTTOtKijp
         OzUUN3phZGkj9N58HM3rICxYzTDBd/lqJLeMG9IYa1GAY3bNG2YsQjA+UWbOP6yI06/5
         tbWhZgHg6oHcQ5gpQWJ4sKm3jTk3jeTamB6An9lUf2gHEZMyPSIdTpqzP/d8b2HYg4No
         e/Yg==
X-Gm-Message-State: AOAM531/q6xtkGy4DAE8qiEDuGbdKEEFjsf4fiwbfvZuKDg5h0Es642R
        Uh9qn892sNbYzAInAiyfyr5yNw==
X-Google-Smtp-Source: ABdhPJzi4MxxRcuH6p+fMpBx2PqyIGHoOa+j1FPM4XS9qEplmlHxPBSwTCTFKacVCgvcEPAdK4wZkg==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr11827885wme.19.1615542490888;
        Fri, 12 Mar 2021 01:48:10 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anil Veerabhadrappa <anilgv@broadcom.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        QLogic-Storage-Upstream@qlogic.com, linux-scsi@vger.kernel.org
Subject: [PATCH 22/30] scsi: bnx2i: bnx2i_sysfs: Fix bnx2i_set_ccell_info()'s name in description
Date:   Fri, 12 Mar 2021 09:47:30 +0000
Message-Id: <20210312094738.2207817-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2i/bnx2i_sysfs.c:118: warning: expecting prototype for bnx2i_get_link_state(). Prototype was for bnx2i_set_ccell_info() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: Manish Rangankar <mrangankar@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anil Veerabhadrappa <anilgv@broadcom.com>
Cc: Eddie Wai <eddie.wai@broadcom.com>
Cc: QLogic-Storage-Upstream@qlogic.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2i/bnx2i_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_sysfs.c b/drivers/scsi/bnx2i/bnx2i_sysfs.c
index 3dc790089f0fc..bea00073cb7cd 100644
--- a/drivers/scsi/bnx2i/bnx2i_sysfs.c
+++ b/drivers/scsi/bnx2i/bnx2i_sysfs.c
@@ -104,7 +104,7 @@ static ssize_t bnx2i_show_ccell_info(struct device *dev,
 
 
 /**
- * bnx2i_get_link_state - set command cell (HQ) size
+ * bnx2i_set_ccell_info - set command cell (HQ) size
  * @dev:	device pointer
  * @attr:	device attribute (unused)
  * @buf:	buffer to return current SQ size parameter
-- 
2.27.0

