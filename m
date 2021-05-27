Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617CF39312B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhE0Oo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:44:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhE0Oo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:44:26 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmHDo-0003pu-Gy
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 14:42:52 +0000
Received: by mail-ua1-f70.google.com with SMTP id o7-20020ab01e870000b029020d37e3e144so294503uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iC04+3jvNubfg7Wrkd8hW+CgM3ijDgG7hLUEPwBFh2o=;
        b=Kt3uU4mOQWYKhltV0HwOKa6s3QH+fvfYHSEtv1pMrXWzSGlgWjL/iiJZ7020WHGEtb
         XrrByPDi+hwt0phL/knoAzTzyIroytVCsiwsu5MWtAkgvT/nqt8wv7oZN+RxIvAa4/ob
         Zyrum0bwr13X0mKbkypFbaLBlnnmiOnKZ2cN1DiHEPaUcqwwqt8+qiVoYE79twSb7fdq
         mQT0NmyyswkpxGhXzbEk2DSTNBXkRVaBVxxOOVg3QvDhVpJ1T6HCu+wi4pHDJgTnysFb
         Hz3Bz0l12aq/bSo0pV+H5/MP4+4EMJffV/brg7e2euEwmbIkZRNs5PX9kYxGduZ9AJ4I
         Q7LQ==
X-Gm-Message-State: AOAM530TPBo5NI+26i29hrEsS4+fWZDbUWAJpmAeiXGD45g+L/G15TY6
        Ag/NYV41PubzOsRFt9AdcTIGR9jPKvYJemIPUoIFVLJUG1rKFtOuHNQbM6tg1+1C/r513IVJ3RN
        SiZn4MwmTLTqTciL+GOiFrpN5TBOWyHldWzQWyBuEVg==
X-Received: by 2002:a1f:c1d5:: with SMTP id r204mr2429671vkf.13.1622126571641;
        Thu, 27 May 2021 07:42:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5SrgHyiwETLfeWQwugX5MzFhyZbywio/gjMMALzmHQvM5RRX6gcPFaWG4JPkfMbQuLAgmTA==
X-Received: by 2002:a1f:c1d5:: with SMTP id r204mr2429649vkf.13.1622126571431;
        Thu, 27 May 2021 07:42:51 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id i7sm459198uab.14.2021.05.27.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:42:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org, Raghav Dogra <raghav.dogra@nxp.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFT PATCH 1/2] memory: fsl_ifc: fix leaking IO mapping on probe failure
Date:   Thu, 27 May 2021 10:42:39 -0400
Message-Id: <20210527144240.56365-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe error the driver should unmap the IO memory.  Smatch reports:

  drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.

Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Only build tested.
---
 drivers/memory/fsl_ifc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 89f99b5b6450..a6324044a085 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -219,8 +219,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	fsl_ifc_ctrl_dev->gregs = of_iomap(dev->dev.of_node, 0);
 	if (!fsl_ifc_ctrl_dev->gregs) {
 		dev_err(&dev->dev, "failed to get memory region\n");
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	if (of_property_read_bool(dev->dev.of_node, "little-endian")) {
@@ -295,6 +294,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
 	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
 err:
+	iounmap(fsl_ifc_ctrl_dev->gregs);
 	return ret;
 }
 
-- 
2.27.0

