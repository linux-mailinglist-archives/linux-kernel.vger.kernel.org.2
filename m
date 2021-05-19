Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95A3894F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhESSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:04:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhESSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:04:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14JI3EFS040221;
        Wed, 19 May 2021 13:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621447394;
        bh=3HlSV2DK3wxAkft6ihFeA6Kggp4GxerizBvGiZviwdU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HbpPnHetHbEtQzgtLbRw8mwxNiU/6TGrUqIdv/MJOuQvIoFXDa1cTS9wZlDsJaIWI
         Vpi5Bz+Z6QW4H2AWh12TBeBKxZ9rHb6I2hxYJ10v2JAtbq7tC9bCjEf50/JkLcQh77
         Y/6tcp771z/PuCm1oJACwEQOSfyH5dVaJ89nkong=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14JI3DkG053351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 May 2021 13:03:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 19
 May 2021 13:03:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 19 May 2021 13:03:13 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14JI3DJd060970;
        Wed, 19 May 2021 13:03:13 -0500
Received: from localhost ([10.250.32.40])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 14JI3DAO104561;
        Wed, 19 May 2021 13:03:13 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] remoteproc: Add kernel-doc comment for is_iomem
Date:   Wed, 19 May 2021 13:03:03 -0500
Message-ID: <20210519180304.23563-2-s-anna@ti.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210519180304.23563-1-s-anna@ti.com>
References: <20210519180304.23563-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel-doc comment for the is_iomem function argument in
rproc_da_to_va(). This fixes a warning generated when building
the remoteproc_core with W=1,
  warning: Function parameter or member 'is_iomem' not described in 'rproc_da_to_va'

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 626a6b90fba2..8c279039b6a3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -165,6 +165,7 @@ EXPORT_SYMBOL(rproc_va_to_pa);
  * @rproc: handle of a remote processor
  * @da: remoteproc device address to translate
  * @len: length of the memory region @da is pointing to
+ * @is_iomem: optional pointer filled in to indicate if @da is iomapped memory
  *
  * Some remote processors will ask us to allocate them physically contiguous
  * memory regions (which we call "carveouts"), and map them to specific
-- 
2.30.1

