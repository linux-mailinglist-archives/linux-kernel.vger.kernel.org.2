Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6C33BF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhCOOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbhCOOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:44:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:44:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o9so33617480iow.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcipKqoWFtXpAVNkD1RaOe/O477VWQDhGe2XtwR99R8=;
        b=VOANSum6tBUc4oeU0vZzYdu6gNSlNaS8t0Je6WSl9k/oIRbtXT9x7Su/krafehnybC
         W4VzQMmEvcCJ+b4wvXh4UHMY3m1eCvB4XMsfEyml896H9eZl+Nm+LFW1sfuVBa8OGgmY
         noiTsAVuMT0VHM37FHbqEr2i+8YdrCGM/ocJJ8/2lHn3oUog90Smx0d9Rz7C/W7hIbm6
         DJ9VDd+oN9jbo+x902kw2OLDa85ueuyDfCSxJUuRvAPlSny2SwSPPKkfk1/ioXENm771
         BGBWjvIDTBRiUYRO6ZxwYrfaGB/uhF70kZ3Ub7Hvh92sU4thYI0J3aJ2QHn/nBCgOk7d
         X9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcipKqoWFtXpAVNkD1RaOe/O477VWQDhGe2XtwR99R8=;
        b=fAynuambJUmN8gKZ6uOcHcLr/vDoUoaQg2eGTfoZVcViwWG0w4H014Q5op4B8nYPFG
         PjP3+/U+jgbacgjk7UeJrhc5mqmJvbCkTmXSRn4AOFyz7ercnB/nun+1dxF4ZAPIMtBQ
         9VriUPGAfg0sbzRkK+gNLfR3Scm2kEhgESP1YVsosYjeEhqdS3j8Q/g6ZNg9FTFDNAb+
         UsPb9XCSBu1IhgjCyw7149c1TsHsQuYvUiLZ4Z8b0UhdQ3n11QePxquEQFtmX7Ifq78B
         9CqhcNtQfFnrlyiOK5nLxBelWcta5v0f8R6AKW2Q0eUdn39UafgqXIhpPTCIE+KX380C
         sddg==
X-Gm-Message-State: AOAM533GPNJlPCuHVl0acWXbHF2beYmNpdIM827CDudLk4YyskwFykdC
        9tHqilRnF7FTg/lhdtPiWPTDiQ==
X-Google-Smtp-Source: ABdhPJz7qpMEGoyaaD3AxzRtxEGesDLehqgc8LoD2FkPG8kPHnAtQUj6VwvsoPXmoHi2pb52ETN8gg==
X-Received: by 2002:a05:6602:21cd:: with SMTP id c13mr7325782ioc.44.1615819498793;
        Mon, 15 Mar 2021 07:44:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a4sm6474074iow.55.2021.03.15.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 07:44:58 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: mdt_loader: be more informative on errors
Date:   Mon, 15 Mar 2021 09:44:55 -0500
Message-Id: <20210315144455.1770492-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __qcom_mdt_load() there are cases where an error occurs that
cause a message to be printed.  In some of those cases the errno
value can be helpful to understand exactly what caused the problem.

Print the errno (as well as the firmware file name) where it is
helpful, and in a few cases reword the error message.  Consistently
use the private fw_name for the file name.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 24cd193dec550..22b8116a1c424 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -166,6 +166,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		metadata = qcom_mdt_read_metadata(fw, &metadata_len);
 		if (IS_ERR(metadata)) {
 			ret = PTR_ERR(metadata);
+			dev_err(dev, "error %d reading firmware %s metadata\n",
+				ret, fw_name);
 			goto out;
 		}
 
@@ -173,7 +175,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		kfree(metadata);
 		if (ret) {
-			dev_err(dev, "invalid firmware metadata\n");
+			/* Invalid firmware metadata */
+			dev_err(dev, "error %d initializing firmware %s\n",
+				ret, fw_name);
 			goto out;
 		}
 	}
@@ -199,7 +203,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			ret = qcom_scm_pas_mem_setup(pas_id, mem_phys,
 						     max_addr - min_addr);
 			if (ret) {
-				dev_err(dev, "unable to setup relocation\n");
+				/* Unable to set up relocation */
+				dev_err(dev, "error %d setting up firmware %s\n",
+					ret, fw_name);
 				goto out;
 			}
 		}
@@ -235,9 +241,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		if (phdr->p_filesz && phdr->p_offset < fw->size) {
 			/* Firmware is large enough to be non-split */
 			if (phdr->p_offset + phdr->p_filesz > fw->size) {
-				dev_err(dev,
-					"failed to load segment %d from truncated file %s\n",
-					i, firmware);
+				dev_err(dev, "file %s segment %d would be truncated\n",
+					fw_name, i);
 				ret = -EINVAL;
 				break;
 			}
@@ -249,7 +254,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
 							ptr, phdr->p_filesz);
 			if (ret) {
-				dev_err(dev, "failed to load %s\n", fw_name);
+				dev_err(dev, "error %d loading %s\n",
+					ret, fw_name);
 				break;
 			}
 
-- 
2.27.0

