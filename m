Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6087347F86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhCXReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbhCXReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B513C0613E0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so28530652edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YX2rXBybL20wXzWEgbJFWLYt9DGgkwCmYeXkOpQbl+4=;
        b=Bfp57e1lQCY5EFWX4luD5N2fEWYpccMVTLKliRDQiNa6NB9MeuKuVW/OnZAxt3gryp
         87Myoc7DNQFoZSRfyQDVUc6ww4tJE7LQmZWMF7uBiQFF0zFIfruv5I0pTSvWtCWqkAme
         Br+V0yd4e9SUTg2fPyk+z2nvqy+EeFUtkJdGHUyz7CtXqfBCF4uZkIyDkhQv145f7Q1T
         5TjjYkcNVGcAEjJoTI+EnZFyqXZU/Gk0+38r2/geqhI20tLUZU1um5zEwsCnO0kgPAoB
         +jobYECsruYUzK/2mZ3qRQURK3G4u2uezIik7Q8hsWPTJo0gEBNh8C5TvxICZBnwN75v
         arSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX2rXBybL20wXzWEgbJFWLYt9DGgkwCmYeXkOpQbl+4=;
        b=tAyN5A5xvgDGqukZTa34b25RpRZ3ECDl9PH/msQde690Ne46TSKX4Wo3ukLtS1oNjz
         U6hsnkcFr5YpqbukuIiRWdOao1d1P2zUx0SL0xA4hmQCVqmgovdOZw6pxlX1QlnFBP/c
         oGTGCZ2NIQfTJsFb9iTJjRoRJkTIZbcZbdb+ymJJ38XCPxHmxwIXUziOcO96Vh0pGSJH
         tOHBszxW38rrF5JQ+JO+BZzZXcagZ8VN+VzZBilLoavZo+BIWA7ebGOeOPDMtG2fcFU6
         uQey/vKSQd3agj8+x1qr5QwSQKp+yfcDW0QqCgqDiuexde7BW9QGOkvNhCbgI6h72uGt
         2UVA==
X-Gm-Message-State: AOAM531C18XrwHF4IBuo2gYHLpe+aZFI9n7TMflE+TKGWT5W9OgqUREB
        PNGAlscvXqN36VGjFtllJAz61Q==
X-Google-Smtp-Source: ABdhPJwCPqXP3jqO62z9IUUGkbePEAMenKTIuU1I7W2tHc5o4gR44zrdACq+n9DNpRRywppISA6OkA==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr4677887edu.2.1616607253067;
        Wed, 24 Mar 2021 10:34:13 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 05/25] HID: intel-ish: Fix a naming disparity and a formatting error
Date:   Wed, 24 Mar 2021 17:33:44 +0000
Message-Id: <20210324173404.66340-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/hbm.c:409: warning: expecting prototype for ishtp_client_disconnect_request(). Prototype was for ishtp_hbm_fw_disconnect_req() instead
 drivers/hid/intel-ish-hid/ishtp/hbm.c:433: warning: wrong kernel-doc identifier on line:

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index dbfae60f26216..9c031a06e4c40 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -398,7 +398,7 @@ static void ishtp_hbm_cl_connect_res(struct ishtp_device *dev,
 }
 
 /**
- * ishtp_client_disconnect_request() - Receive disconnect request
+ * ishtp_hbm_fw_disconnect_req() - Receive disconnect request
  * @dev: ISHTP device instance
  * @disconnect_req: disconnect request structure
  *
@@ -430,7 +430,7 @@ static void ishtp_hbm_fw_disconnect_req(struct ishtp_device *dev,
 }
 
 /**
- * ishtp_hbm_dma_xfer_ack(() - Receive transfer ACK
+ * ishtp_hbm_dma_xfer_ack() - Receive transfer ACK
  * @dev: ISHTP device instance
  * @dma_xfer: HBM transfer message
  *
-- 
2.27.0

