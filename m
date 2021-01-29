Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C781C308B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhA2RR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhA2RPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34727C061756
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so9610824wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/u+tVmo4ESUhHq5jv+Zf5FyEnfMANA4tIujiqKrcCY=;
        b=WF0tDv1LyWNVI9xa21J1Hvj8PtRYNWr+E2plpwfH0w1QckVv0RP3ENZQDLfaDs6MXn
         PKsVpNouxID+NofnkwTI957IQeNO4Fk7cGsDazZ9UDcbygtpm2k6C63ucryb142nwPB8
         Ca7MQV7tr6Se/irqDQVGx1ZXCZrCuJFWCRUCD9Apal4L+MKSx+evLR4vv3eAmqHNzUvs
         u1rXLSeqfbZOXyu3BLzabFnqO350mpu7xir526SBcQZQpSAtpcrOOmWlYIYy4XkQx1pq
         ldWoW36IF7DKXfgTqDFfbrkfpqpcsxLJHsa58L8JWb2tZqP/I9bH9jDcfDEjd/NDbzVT
         vhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/u+tVmo4ESUhHq5jv+Zf5FyEnfMANA4tIujiqKrcCY=;
        b=I+L1Cfsa1tzh6RLxNHx9sOutslxb0vULGDEojpUtR5HGZoXho5vgzWFr0cgyq6bzHY
         MHQfCRIsuwYU9XGX9jJLX/XYuUidRqr//fEQR3LzeA+gaLxMYd8e31kqC1hcJPoJjxgu
         MGL0Wr5ZdJRBBdgpAk36y9Mxb4WV+LtBfgbThW6cbopvH+VpAacjedD0wY0l1YFgNxz7
         L8EuMosuGrlM2nmCq/ieKrLDE7b6iR3B5lX7ZY3czDV4q22M0VsDFwAkuBD+rfY+kpUQ
         sTObaD7OlXjaeMXgY+U688YnO82OnWZmixiV7Oe4NoNmG1cpejvEwdMOUX0HFqibISV+
         vBag==
X-Gm-Message-State: AOAM531vZ7v8JaWehB018sRpzLF8bacjax1f2UfwTwaA6bF+Zw5JCVM2
        Jvv+x+Ps8XHTAvoa+5Rm5bAcH+eNQsZ/zQ==
X-Google-Smtp-Source: ABdhPJxLFDmY2NQMDT3n11JknR9Yi3+CToqHgnxR9DhMt4aRgRA7Vaqoxgzm3RQtYB7PFq4XdIsKlg==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr5760318wru.10.1611940483898;
        Fri, 29 Jan 2021 09:14:43 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] nvmem: core: Fix a resource leak on error in nvmem_add_cells_from_of()
Date:   Fri, 29 Jan 2021 17:14:26 +0000
Message-Id: <20210129171430.11328-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

This doesn't call of_node_put() on the error path so it leads to a
memory leak.

Fixes: 0749aa25af82 ("nvmem: core: fix regression in of_nvmem_cell_get()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 177f5bf27c6d..68ae6f24b57f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -713,6 +713,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
 			kfree_const(cell->name);
+			of_node_put(cell->np);
 			kfree(cell);
 			return -EINVAL;
 		}
-- 
2.21.0

