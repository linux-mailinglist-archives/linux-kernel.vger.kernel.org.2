Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA13399F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 00:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhCLXTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 18:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhCLXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 18:19:01 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1965C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:19:00 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o22so18798885oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqvOzI2zLGFbJ4M0ftg4qd6WsZiHet0rFkxEAgLUmfE=;
        b=YT6UKyVuPLm4XGX36k0chID5JVFUTUm8zaC+8n0ONRpoHzG7rrb+CAtxz+dNj1/idI
         XZQ3hYQwvEsFIZYhB0FlM5dHlIWLS0AgfNLTQpqn08wjRutjktwcT7WWJAnTboSY672l
         vbmx9Kycbh/EUq+HLiM2n/3rWT6fas3Vn0KBlj1PM9u5QGwn6F1p09hvTB7gWbLESuIC
         pEfmxn9BGn0UCJXDhkyL/blBVSRPOPoS2a9JtHhLooOGF/8+tY1o+FW1OM3j65u2CIoE
         VSinbeu0oomzXzf0R+3MAxDWr/F1pCNDlik2l6Df+q7Fj1Wg4v0ScbwfV/S7pLkNjMbL
         U8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqvOzI2zLGFbJ4M0ftg4qd6WsZiHet0rFkxEAgLUmfE=;
        b=kms/6Bc1LiLmv7Yal1jcuoX0bSpUXNnYIViMexNDGBniQfY9hUs53IzuPQm7LqHfaK
         e4aEpcUUuGQLler6IuO3ZXM0T5JRQeKBJYu3ZU3rjorqGHEMwg8Owr0BxetHjgwuI4ib
         FXKUyRpsuqjV0ZzC9gKnmdc0243Ae4RSg243HdmxXe5gY+oN5j5w/gcPg9GpJ5nC+Zss
         YTl0r93I1UHGW63ByfUelyI1YZO71jNBV8LzNa8Nr7ziKrHqDMS/VB3v/gHmTvxs63ky
         b5CP5a7UJg1rD9q1WfwCONw6ARyUOfW/aBQuZ1dws21yUWy0ZED3644/IzYFU59NDtKI
         n9ag==
X-Gm-Message-State: AOAM533JUqdXglLVNvZPdiDGIVD+dgaJnf/QQQc0zaVVrWegDsARXPZP
        2qsXLhBX3iML5NfVOFVuiydo0w==
X-Google-Smtp-Source: ABdhPJw/TE826y3cCk5GoSXdsaveulfLIV2FWeeDDqCYgmnOZpSqOXgwjmiPKrITASCSH4LmS2zi6Q==
X-Received: by 2002:aca:3cd5:: with SMTP id j204mr11413488oia.29.1615591140160;
        Fri, 12 Mar 2021 15:19:00 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a6sm2326663otq.79.2021.03.12.15.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:18:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] remoteproc: qcom_q6v5_mss: Validate p_filesz in ELF loader
Date:   Fri, 12 Mar 2021 15:20:02 -0800
Message-Id: <20210312232002.3466791-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analog to the issue in the common mdt_loader code the MSS ELF loader
does not validate that p_filesz bytes will fit in the memory region and
that the loaded segments are not truncated. Fix this in the same way
as proposed for the mdt_loader.

Fixes: 135b9e8d1cd8 ("remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Don't just break the loop, goto release_firmware.
- Release seg_fw as well.

 drivers/remoteproc/qcom_q6v5_mss.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 66106ba25ba3..14e0ce5f18f5 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1210,6 +1210,14 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			goto release_firmware;
 		}
 
+		if (phdr->p_filesz > phdr->p_memsz) {
+			dev_err(qproc->dev,
+				"refusing to load segment %d with p_filesz > p_memsz\n",
+				i);
+			ret = -EINVAL;
+			goto release_firmware;
+		}
+
 		ptr = memremap(qproc->mpss_phys + offset, phdr->p_memsz, MEMREMAP_WC);
 		if (!ptr) {
 			dev_err(qproc->dev,
@@ -1241,6 +1249,16 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 				goto release_firmware;
 			}
 
+			if (seg_fw->size != phdr->p_filesz) {
+				dev_err(qproc->dev,
+					"failed to load segment %d from truncated file %s\n",
+					i, fw_name);
+				ret = -EINVAL;
+				release_firmware(seg_fw);
+				memunmap(ptr);
+				goto release_firmware;
+			}
+
 			release_firmware(seg_fw);
 		}
 
-- 
2.29.2

