Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2A392A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhE0JG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:06:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5111 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhE0JG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:06:27 -0400
Received: from dggeml711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrMJj4VvKzYn5K;
        Thu, 27 May 2021 17:02:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml711-chm.china.huawei.com (10.3.17.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 17:04:53 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:04:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] drm/i915/hdcp: Simplify code in intel_hdcp_auth_downstream()
Date:   Thu, 27 May 2021 17:04:21 +0800
Message-ID: <20210527090421.9172-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If intel_hdcp_validate_v_prime() has been successful within the allowed
number of tries, we can directly call drm_dbg_kms() and "goto out" without
jumping out of the loop and repeatedly judging whether the operation is
successful. This can help us reduce an unnecessary if judgment. And it's
a little clearer to read.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 24 ++++++++++-------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index d8570e14fe60..c32a854eda66 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -663,13 +663,13 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
 
 	ret = shim->read_ksv_fifo(dig_port, num_downstream, ksv_fifo);
 	if (ret)
-		goto err;
+		goto out;
 
 	if (drm_hdcp_check_ksvs_revoked(&dev_priv->drm, ksv_fifo,
 					num_downstream) > 0) {
 		drm_err(&dev_priv->drm, "Revoked Ksv(s) in ksv_fifo\n");
 		ret = -EPERM;
-		goto err;
+		goto out;
 	}
 
 	/*
@@ -680,20 +680,16 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
 		ret = intel_hdcp_validate_v_prime(connector, shim,
 						  ksv_fifo, num_downstream,
 						  bstatus);
-		if (!ret)
-			break;
-	}
-
-	if (i == tries) {
-		drm_dbg_kms(&dev_priv->drm,
-			    "V Prime validation failed.(%d)\n", ret);
-		goto err;
+		if (!ret) {
+			drm_dbg_kms(&dev_priv->drm,
+				    "HDCP is enabled (%d downstream devices)\n",
+				    num_downstream);
+			goto out;
+		}
 	}
 
-	drm_dbg_kms(&dev_priv->drm, "HDCP is enabled (%d downstream devices)\n",
-		    num_downstream);
-	ret = 0;
-err:
+	drm_dbg_kms(&dev_priv->drm, "V Prime validation failed.(%d)\n", ret);
+out:
 	kfree(ksv_fifo);
 	return ret;
 }
-- 
2.25.1


