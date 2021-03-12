Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0926233891C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhCLJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCLJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u16so4437288wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMNrAANtdSm/KApZn99Iy+ukBxQxfETDJsJVLnxM0ss=;
        b=spXmC2/JKBd/fcKoBaLN9rUOh2lrc8tlt/Qu9hmPrnaeLvL63dpxTr1rk3azNkhEJp
         llosrA2xyN1pBe3gTj9enA2OyaeYkUPSOl12KZuF7jtIIvQImi/x2W6oFgn9LXvkuF4u
         82utRDsAJEKoRbxoQxP7mNunsoW+/4xMr6xo3QnXC9Wp5pQbqj4dCD9ENN2J6lhyXr4p
         9CVAGqSGvuP1Nj3MDNGt218pVtsI0f+zbDmiHSR6Xu5zkt7oMDTUI/qu4wlh2k7Rivl5
         w3ZCdNiaeo1iCB2fNiYzA6WQXnXxRfmMwJ9J65DSZnq6+LBbBu7472RsKhT30KGSxzjq
         zU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMNrAANtdSm/KApZn99Iy+ukBxQxfETDJsJVLnxM0ss=;
        b=pAkuLKqA7iNhCwkdJ1LfqcZO1sb4nEK0ScHWhoP7S5Y0d0HoMU7cJhzUCkEGiW3BTQ
         lwY0Mr7Z8MBOSbo04/KzX6zP5qzT+5oeLPEXlpzcO30Vrms1upJoaTxRtq2kgh/urqUA
         p35rxw0C+LHQlzVEvBPD2GX9UDC4JyE+SC/xGocq1nfX2SJ2t78As96AqPamAHEIUx40
         ghiX/9/WdqLsthQRmutWv0xoERmOdyKG01lIGjPH1ZZ5KUrXYxPmfX99oXSTpbyfsG8U
         GyUyJ0reS4Rv4ByOerv5iR4wLxANHYUvIaYTWj+erAdwM3tDtK9Voc72LUUqqE5J2YUB
         cFoA==
X-Gm-Message-State: AOAM533LsjocG+140hTWKVKKdl1SNAng7yFpsWC9JE3eANAGM5tTlIQQ
        Ox3p9yUCaHNFzl03d28Zt7MOhg==
X-Google-Smtp-Source: ABdhPJz+tnrsV1zdhCqwNcgmv8npJAuDGV5x5Q9B4Ny0XY8vHHMg9Ea6dY2WeSjB6/3frN5TEVKzBw==
X-Received: by 2002:a5d:4521:: with SMTP id j1mr12820216wra.354.1615542484778;
        Fri, 12 Mar 2021 01:48:04 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 15/30] scsi: lpfc: lpfc_nvme: Fix kernel-doc formatting issue
Date:   Fri, 12 Mar 2021 09:47:23 +0000
Message-Id: <20210312094738.2207817-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_nvme.c:2021: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_create_localport'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 5fe4e93fe984e..4d78eadb65c0a 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2002,7 +2002,7 @@ lpfc_release_nvme_buf(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd)
 
 /**
  * lpfc_nvme_create_localport - Create/Bind an nvme localport instance.
- * @vport - the lpfc_vport instance requesting a localport.
+ * @vport: the lpfc_vport instance requesting a localport.
  *
  * This routine is invoked to create an nvme localport instance to bind
  * to the nvme_fc_transport.  It is called once during driver load
-- 
2.27.0

