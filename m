Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876FD39329F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhE0PpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:45:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41363 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhE0PpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:45:08 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmIAY-0000ci-Bx
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 15:43:34 +0000
Received: by mail-vs1-f69.google.com with SMTP id m15-20020a05610206cfb0290248aedd0e0dso334124vsg.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMXfa6DeEoOo09Lo0wzFrgDkLwFolrpXQaM+71Ofz6c=;
        b=pNH6WymAyaYJahVgp3OlDxz5w9fUw20RzaD8z4IOZoU8tWWLq2np4L8CP6KN8/RsHH
         q2AHZH8wM+IyuJWXhJwDNTclQ399MRivokgSf2YJ1wZaDwxDx2CbByM6QukJ5gWvMWWS
         aZSMOAxwhmXAooHspXEsCnT+gFd9zlwwL9VwEotnET+fxAnY/+gh9aJ7HiA6/MK25/r4
         xXnTaUe8c/dcFpDecL42OLr3uxIdbxrtERzkaKRsk5VZTtBiWgzbK2icGgBVVBkhtc0o
         GX/7xQ06KINwQErs+nLA+eCSQVPONjSE9bNL4YifzaYHmwUjQFeufbKwJKj6stMJm0CI
         LL1A==
X-Gm-Message-State: AOAM533pSzXQoTW25m3owD+UpdFCMzXFuiau4e0I7fY/Gcbpd8dP/NLI
        IvD+PkZ4kfFmQoHlHBbyA+4p+Mg2/SvacbUyDgKOJjmv8ar2g79TYqQYc6x+3FOmS0GAbvC9uPi
        GQm3XqfZzTeq6zEcv4gExHcPGv7EHSZb29oaKOJk2XA==
X-Received: by 2002:ab0:380e:: with SMTP id x14mr3166955uav.17.1622130213544;
        Thu, 27 May 2021 08:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpS+TjGl0zghVShoWhw8/U3BihoV8wtwTNCv9FP+M923G+zUF7nn0D8/fpKAJtS0+2X7arYQ==
X-Received: by 2002:ab0:380e:: with SMTP id x14mr3166934uav.17.1622130213395;
        Thu, 27 May 2021 08:43:33 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id m27sm339087vsj.4.2021.05.27.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:43:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [RFT PATCH v2 2/2] memory: fsl_ifc: fix leak of private memory on probe failure
Date:   Thu, 27 May 2021 11:43:22 -0400
Message-Id: <20210527154322.81253-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527154322.81253-1-krzysztof.kozlowski@canonical.com>
References: <20210527154322.81253-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe error the driver should free the memory allocated for private
structure.  Fix this by using resource-managed allocation.

Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Only build tested.

Changes since v1:
1. kfree() in remove() as pointed out by Dan.
---
 drivers/memory/fsl_ifc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index a6324044a085..d062c2f8250f 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -97,7 +97,6 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
 	iounmap(ctrl->gregs);
 
 	dev_set_drvdata(&dev->dev, NULL);
-	kfree(ctrl);
 
 	return 0;
 }
@@ -209,7 +208,8 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 
 	dev_info(&dev->dev, "Freescale Integrated Flash Controller\n");
 
-	fsl_ifc_ctrl_dev = kzalloc(sizeof(*fsl_ifc_ctrl_dev), GFP_KERNEL);
+	fsl_ifc_ctrl_dev = devm_kzalloc(&dev->dev, sizeof(*fsl_ifc_ctrl_dev),
+					GFP_KERNEL);
 	if (!fsl_ifc_ctrl_dev)
 		return -ENOMEM;
 
-- 
2.27.0

