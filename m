Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7013EFB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhHRGKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhHRGJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:09:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D1C0604C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:06:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u1so1163333plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps9jShnfYkcW7CF3s3J9G8+oGaQDbHRpYLWBXR8U5HA=;
        b=hJ+1pw+QR8SAzBduLeTRl7IL8WmBzmKdGAGA6oK7/b7O4sS34IuV1dVSvfAtXQZ8H6
         1+G1v4Tqmg5dSvosNjNMogPfbguMo4ntV0wpYm3/J+c9PeLMlM0pj3RQV41NuXQrnYYq
         S1XAq2zikRpAp6sdSo1lnGzaSXIhWByiPdi1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps9jShnfYkcW7CF3s3J9G8+oGaQDbHRpYLWBXR8U5HA=;
        b=e8tqvxdB5oj8aqHTx5lNaZG++86ViALgenCAVYgWD4egXccfbw8kikys+eKjrcPClJ
         bsUPBFe+IyEhxD7S4NiUfZZTrpxeZYXh9nQwA6t7noNpWVFMAdjXhRcFk5mc/NRzNJJR
         LXYmGuWpCqi79pW43Cv0Xm5pjSTmNa97ZvF80wY5Xr33knS3T3ZKMsRTHVaobiPkkKsv
         pNCisy/QibU3x3nMvCrYMgVnd+7Q4ixygWVolPFv7cP9pTTGJ5qkXNmF07B6nxwOyDuq
         UYTMFXivRi6qkdmb+LI0L7wNksMqZo9LtGvD6J3m61+j136HNhwpo25amE36PyTPm92N
         Xhag==
X-Gm-Message-State: AOAM533tJByw9BfbKEWNoNUppPtoQOXZgf9uBMUXSdx9SBS2XlgmpFdA
        FrgXLMIqsVwgXqJRkNkxutE5sw==
X-Google-Smtp-Source: ABdhPJxsNLILAxQG10XCyPYjemMd7a+ckBg4K7TIyR7mHtdyoVONVT0Fx6+Gjges8rNdRNesUHRD7A==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr7900521pjb.174.1629266760808;
        Tue, 17 Aug 2021 23:06:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm4817746pfo.175.2021.08.17.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 24/63] sata_fsl: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:54 -0700
Message-Id: <20210818060533.3569517-25-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; h=from:subject; bh=490IGoO3mtJCjh0g8l7zMoK6+vhQucUWQpUj+3laYeM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMjgKcbQTO9FDMOsyq/janGS26xgJD+GS/2zaUs ZM2eCZeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIwAKCRCJcvTf3G3AJptmEA Cfi+co78goyBBrH+Zm1R/id0yh2CmjqSZTgJNwAn+IsBhLLep3r74z/+4G0L5HEEsO7K/F763D7FzV qyqSu18qX5XPvdiy0atubLyGda3UuI3umIbTFgsLY66SeEZbWNudGvJ5l2NlJeuEupRNrDDp6WTB04 +juq9wzztFjSrw5OPlb7mi4UllFs8pzBTlwgp0MlwVSG57JFMFv3kGQXHjlEXuWNfiINs3OZhr2g1Y +V2oJMY1cAXD57fne3MAALUSSuHcL59yIGtul0hNa5VmLGIBBdUwcorbjRgNqEvsgFoL3oWb78eC53 eWKn72M+cBfKnBw6p7ak9Y1aXrUbhCOU0IpIrNgQ0fS1/AWVyGj7M9WTeK4POwXFQcsbBMmsXeAVId SmQi/80UCLxGlC80dJmtFJJg794N+o2TMvlfe8RQc2xEp4HDqVCG6xAiA6VL1biQl/bMXi2/gnsZGk 5vEIc8263QtaFStfx8cXsh5/D1ZLtfxcqc99evQE+x1Z2AtFfCRvPXqUEnA5uL9Ird97I148pH2vsi YUgkY8gs+vLWH/DcLD8PuWXxZqes8m+snkfJjISzYk1/D7Vt1hdG9XS5SowqP4R1A/de8CANYlKoki VgBCMKLldP0qegznO020Xhe22ClCpYaDlUaI3GR0HC98cUXBvOfGGnUJ/5Fw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct command_desc around members acmd and fill,
so they can be referenced together. This will allow memset(), memcpy(),
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of acmd:

In function 'fortify_memset_chk',
    inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ata/sata_fsl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e5838b23c9e0..fec3c9032606 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -246,8 +246,10 @@ enum {
 struct command_desc {
 	u8 cfis[8 * 4];
 	u8 sfis[8 * 4];
-	u8 acmd[4 * 4];
-	u8 fill[4 * 4];
+	struct_group(cdb,
+		u8 acmd[4 * 4];
+		u8 fill[4 * 4];
+	);
 	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
 	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
 };
@@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
 	if (ata_is_atapi(qc->tf.protocol)) {
 		desc_info |= ATAPI_CMD;
-		memset((void *)&cd->acmd, 0, 32);
-		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
+		memset(&cd->cdb, 0, sizeof(cd->cdb));
+		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
 	}
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
2.30.2

