Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1630DD58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhBCO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhBCO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:56:01 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E990C0613D6;
        Wed,  3 Feb 2021 06:55:21 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n15so23595197qkh.8;
        Wed, 03 Feb 2021 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ij1i0UczQXsIIs1RbuItXD4NnMbz6A6r+qR8YxjqoOQ=;
        b=DDVB+By/qRpJD2qNg7kXnh3pITR4OQmhzJQn8PVmHaSedW4Nt7cPzaI3J3sXGEjKlg
         qzotZThBJzYqrwoXx5DM8G/xtP48S3lr9BS0giOfLiEqen8FWMW6uhGSvLQcOmlDerfb
         6AXaxfTTOnIilZn/oIYlpntdNsciU24ft/59BSMjP+/D2Y16mJ9she304yEku3PktbZv
         PwQEcj+0+wg79DGMlju9rJ1F0ayQ+zywcKpHrCdCKMvp/gqRcvQW3lXy+1+OM/kcfhiq
         K/6KRwAYz8XPuKAkpOgFKZvtorT510SQHOFcrmrEzMEO2AteaFPN7kksk+cwvnbv7WaB
         ZK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ij1i0UczQXsIIs1RbuItXD4NnMbz6A6r+qR8YxjqoOQ=;
        b=hngsCRDR/W7NvjHw6e3dPSG01OocT1ggwnd2Ol8KeHQTf1UN2zHOxi9UYdxliBbgBj
         osSi5i5SGqrQOauJ7iezaeghitdd9HyYNRNKXblBVRQIIiFsOdMk0BKs0B5X25M61N90
         nC8ecPFA0djRxpAIzSEFF1Q5yy37jlJeKLnBoesAWttR/CiCVNS+EpQg8rIDiGkgE4QM
         twHDaXN0v6AIpeq5sZ4VL2ThlESXPxKjYieuvECZ31gPF0kq2iOV5rGe2nOda3GyHKjF
         DGt2Tcet8A06EmTiaqyeUHMLMVjAJ2Inw6o6Wb4PgC0YPqfDlovd3ejl04EApayWPz3O
         ATDQ==
X-Gm-Message-State: AOAM530ynEMzSEo9n//MU7bPD1lrJivi2VO7th1eoxXYTRHGGzFfMpAp
        ovBSJcZQsJhaad4K4D5sVCc=
X-Google-Smtp-Source: ABdhPJwbZXgbAEOuUTMf6C8yiMxA9BvoABXOTZvoogN46BSoroXZwnSkkSRDgdLABV6yTuBMJrhPGA==
X-Received: by 2002:a05:620a:12dc:: with SMTP id e28mr2774104qkl.151.1612364120708;
        Wed, 03 Feb 2021 06:55:20 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id 11sm1884799qkm.25.2021.02.03.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:55:20 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, gustavoars@kernel.org, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: crypto: qat: qat_common: Inside the comment a spelling fixed in adf_pf2vf_msg.c
Date:   Wed,  3 Feb 2021 20:25:06 +0530
Message-Id: <20210203145506.11928-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/messge/message/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index 8b090b7ae8c6..a1b77bd7a894 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -169,7 +169,7 @@ static int __adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
  * @msg:	Message to send
  * @vf_nr:	VF number to which the message will be sent
  *
- * Function sends a messge from the PF to a VF
+ * Function sends a message from the PF to a VF
  *
  * Return: 0 on success, error code otherwise.
  */
--
2.26.2

