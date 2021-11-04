Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92821445239
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKDLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:33:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B246C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 04:30:59 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id v2so4999105qve.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XI7srUscK+Y38/Rxj8sDNS7Olpg887NgDMGVmRQv+y8=;
        b=GTZx0G9tMBm48ys0jclkhqpFjUgcGjpRl0HcyPh1VsfbXFPPio1IAUAqiubBcql+KP
         WzRDFR3KejSKCRPQNoiGq2nz2nSejbhBsf+eu71Qpjx/aHShLqJttKr4VDcsgF4dvRfC
         jUmuA9UqYCv91cj9x2l4Y1fPYvAk4SRfsDGbg9VoSIne4uus+i0h0HH8i5XNLgyb9xtU
         nXXkxcPp40iBEu6e1gVnugmGN36kru73bt69x1u/6zBCOcM+J3TBbSgHRzf1+98lEuaY
         +f4cNa+nZrbDf9p/juY/8xbdbDdmX3tTt17vNkMkff60UWZFk/+WJGF4PHzVs9IDfn30
         vt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XI7srUscK+Y38/Rxj8sDNS7Olpg887NgDMGVmRQv+y8=;
        b=O1HiH27W0VOtb9q0Q7quqwDup6SA/9eASjc8jd3/UFMyvZ/nEO/6MDYj1CzSGU0pb+
         Kn6q1CuVqRDL+CiXHCULWKupUZBtvChSwzDCC+lRphkeM2f1u7YDIYEUMIemJjrO+9OI
         /A0r3PferyT5W1j+YO5hjXthMpf1WS5vZW0W8GjPchxx9x05/70MsJl1mVwSUHtMt0pv
         K1S0uQ+eG3HPQx/S16CJ6vd4C9+6gd53Z5pcXplic58pBXSXDFtwWSdAtBc9tlkWDZVz
         yfJyKdVrlirduuF+3i2sHfcAmVzsHOsM8jUvMh835dlz16V1a9inB3ncreTdhrorDefv
         fQIw==
X-Gm-Message-State: AOAM530ChuTuy827PFqyXuS1ic25WYYlXeUPtGRp8erHqu/d3siEMgXW
        DpvkF6rH+VBq9zGOx8L7+66ajBnrA9U=
X-Google-Smtp-Source: ABdhPJyIywkpivxgIkJwyn5gNdwk0JeRrw9h7QwhKZJFgroXdvsptNgp/vhFN7yYZWaf4hcRTfL2RA==
X-Received: by 2002:a0c:9d05:: with SMTP id m5mr47454320qvf.30.1636025458621;
        Thu, 04 Nov 2021 04:30:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o8sm3732206qtk.77.2021.11.04.04.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:30:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] optee: fix kfree NULL pointer
Date:   Thu,  4 Nov 2021 11:30:47 +0000
Message-Id: <20211104113047.28585-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

This patch fixes the following Coccinelle error:
drivers/tee/optee/ffa_abi.c: 877: ERROR  optee is NULL but dereferenced.

If memory allocation fails, optee is null pointer. the code will goto err
 and release optee.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/tee/optee/ffa_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 6defd1ec982a..8d9d189557f9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -811,8 +811,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
-		rc = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 	optee->pool = optee_ffa_config_dyn_shm();
 	if (IS_ERR(optee->pool)) {
-- 
2.25.1

