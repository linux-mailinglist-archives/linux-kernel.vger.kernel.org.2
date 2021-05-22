Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1C38D231
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhEVAFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:05:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEVAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:04:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14M03LDL087850;
        Fri, 21 May 2021 19:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621641801;
        bh=rIsAFzqfSDl4qnomEf/i3Yun1KIgz+WMiy2kwkK3VVc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M+/G4idxvr+0cMA+heAG/9siC4UhZTmUQI9VuKgCiUqpOlneIRMMoth5BF6C997FM
         GVunOBWOFc9F8P5AdM/N6K0WTKnpSMahKCInZipqAPOjKac/KUszwJPnjAjT8RJqjP
         9k81C1cG76sgfbVCUH35VxTLizKGHzv4PGOyMU4o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14M03LS6123691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 May 2021 19:03:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 19:03:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 21 May 2021 19:03:21 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14M03LZf089883;
        Fri, 21 May 2021 19:03:21 -0500
Received: from localhost ([10.250.35.153])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 14M03LTJ091513;
        Fri, 21 May 2021 19:03:21 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/6] remoteproc: Introduce rproc_detach_device() wrapper
Date:   Fri, 21 May 2021 19:03:04 -0500
Message-ID: <20210522000309.26134-2-s-anna@ti.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210522000309.26134-1-s-anna@ti.com>
References: <20210522000309.26134-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .attach() rproc ops is invoked through the helper
rproc_attach_device(), but the .detach() ops is invoked
directly at present. Introduce a similar wrapper function
rproc_detach_device() for .detach() ops so that the code
is symmetric.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c     | 2 +-
 drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 6348aaa42bbb..6019f46001c8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1869,7 +1869,7 @@ static int __rproc_detach(struct rproc *rproc)
 	}
 
 	/* Tell the remote processor the core isn't available anymore */
-	ret = rproc->ops->detach(rproc);
+	ret = rproc_detach_device(rproc);
 	if (ret) {
 		dev_err(dev, "can't detach from rproc: %d\n", ret);
 		return ret;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index a328e634b1de..931d50b6a0d1 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -121,6 +121,14 @@ static inline int rproc_attach_device(struct rproc *rproc)
 	return 0;
 }
 
+static inline int rproc_detach_device(struct rproc *rproc)
+{
+	if (rproc->ops->detach)
+		return rproc->ops->detach(rproc);
+
+	return 0;
+}
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
-- 
2.30.1

