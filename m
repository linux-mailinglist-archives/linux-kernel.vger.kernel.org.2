Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563103AB1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhFQLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFQLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF90C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a11so6267439wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yp6ROMTiloVG6stEmBaLgZkyXoJ2CqjrbrJg7R1ExEc=;
        b=IYOPAeUxFe1LjiwEXH19bHYwT+Mv8fP4yT5DgGDZ2v5W6nwF6Uu73i56si4ffJNnVE
         dp5Op0FG/faho7EjzHPTll0dgCyCVDRLS9ejhWYYig9CnnQo78zV4BVK8jyTE/JzbF5p
         UuoD7Fbo1cwHN0i7CiV0Xc7NuVn2DDchprvcEon+y+X0QX7Mkaq8vbE8gHJ94cGhgChD
         0IqOt+/nQE/rJ7vOHH/mBA2tvo81TdPH5TrLLWfHmekTuZeJIr/2u8mLLpp6RtlCd5wT
         5Q262xYyCxYCQ5rC7A5IDXa4itGz5XaM/QHE5phg9oOWYoxZUDBeW+yDpk+4hzlqgAMZ
         GOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yp6ROMTiloVG6stEmBaLgZkyXoJ2CqjrbrJg7R1ExEc=;
        b=NEyuuIpAuGKAcNltrVgu1OFr+S6eq+/wye27GKMOoESBaeBBMpNBeGG1sZbFfQRXnA
         VCLKttubREyf6LYSbt+eKI6lhBobEJMojpr6hGmaK+rsp8VHtuItNaQvvCHG+y2SIMYa
         2SYdYsicoARs/Gyhq3cpYuPHcSeVi4bp+tsOuHw+Rr9fzFcyGU/hPdEurqnCv3TVQk1v
         yi7oRSpRvYakjeGWaVV+iAfoiinBu0Eo8axhxeBQczs5d1PXnyCPmzt8ov0QgJipNFlX
         r22VF6/vDGurAG6MboH6y6aiKt5Bc05zapUnAK+zFIvEwm1oOa6joRJ6ET04rlPozYoZ
         wk7g==
X-Gm-Message-State: AOAM533hpXoeIV6/qMBy4bxmEMx8vwpOl/Wqa83wkYbH4DdgNvPsuymB
        TNUTnyoTzBmImBVnCpyqFU4qng==
X-Google-Smtp-Source: ABdhPJzb/Ns5GGxNFfsts/uTTrY4yHiM8Usad9JLNT7xDADoiUNhjCBF4hpcP0arhqQ6zX/ulHoM3g==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr4836712wrf.130.1623927910717;
        Thu, 17 Jun 2021 04:05:10 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/8] bus: fsl-mc: mc-io: Supply function names for 'fsl_create_mc_io()' and 'fsl_destroy_mc_io()'
Date:   Thu, 17 Jun 2021 12:04:53 +0100
Message-Id: <20210617110500.15907-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/mc-io.c:53: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/bus/fsl-mc/mc-io.c:126: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/mc-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 305015486b91c..9af6b05b89d6f 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -50,7 +50,7 @@ static void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io)
 }
 
 /**
- * Creates an MC I/O object
+ * fsl_create_mc_io() - Creates an MC I/O object
  *
  * @dev: device to be associated with the MC I/O object
  * @mc_portal_phys_addr: physical address of the MC portal to use
@@ -123,7 +123,7 @@ int __must_check fsl_create_mc_io(struct device *dev,
 }
 
 /**
- * Destroys an MC I/O object
+ * fsl_destroy_mc_io() - Destroys an MC I/O object
  *
  * @mc_io: MC I/O object to destroy
  */
-- 
2.32.0

