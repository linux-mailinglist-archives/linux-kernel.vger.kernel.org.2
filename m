Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6032A755
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839306AbhCBQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446273AbhCBN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:28:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A82C0611BD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:28:12 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so13803865pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4Ad7Ent8cof3XMClRVgB8zjonCBcH2IrC0ql/TQI38=;
        b=l8tRrWapgbJRkYaus/ItyDv82nTfHZpF6+OqBUdkRkJI7yPujxRr2oz/pyWwuB8LuF
         //zcr6Dk9KA3KMvAtldOErs+j2sgJbzfR2yDp7RauZIsKXoe8xtRbxZwQnAzxmHNvyC4
         8axFWG+9e4S5+caDu3lcpvNs9YuC6VAQynPgBD40VHbDb2pVUzccAipV9LvCHJiSaKbH
         /Da7k8vN/ABqvhg8itwiPFEhpSsjLjJBfVUrfHwyfF4m2KOkhP/7DeOHdanrtrwR8PhX
         u/veZdXSs9qUcc5HiZEbuOwS+jaw0P8j2QfBX/ET4aGv0UdSPM1ggTdbi87MyeuUWUTd
         SnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4Ad7Ent8cof3XMClRVgB8zjonCBcH2IrC0ql/TQI38=;
        b=hhQQ41Shzxp5PwyLE2pBfw2RGO1S45ZBRtu29J0869oI/ycZvV4H8ebJIdif+gvY91
         9Jl4qHJKyvP/Bt5N8auG5zwhwWV4eQUKnBFPxfdR1Yv4Vhe+/Vu9/eGnIjMFHd6AipZm
         zOn/BEbQ84pbYUhpdhY8WOcLwWYYHo5euBXR4WaCoD8x7xxG3Fnc42/0k8RtWsstyT+K
         rp2juMz5gidzFL/oKyGVxIQTZCkbbnHgcJ/EihpQA6d7xrbxLckp6QKUAPRptUceYXlX
         OFFCX6srShVh+gheLmTRxKy9pyc2POQbznGy33owXtpfKgOeh1wJsl8+w8wJ1C4dqIoA
         bIvQ==
X-Gm-Message-State: AOAM532E7MqfjpvZ2AH2hDDxfzJxfh91U57MEN2dmoL9F35GY1ao3Aqt
        8isHQkQhV5G4oDE7tviBw+lJ
X-Google-Smtp-Source: ABdhPJzLbkWTyQk4y0GRM9ZfbaZuf3I4UEKB1ioFKcMq2eC/YLMqWeWZ1I05pt+w1IBSL89+7tvGTg==
X-Received: by 2002:aa7:9182:0:b029:1de:e96f:a866 with SMTP id x2-20020aa791820000b02901dee96fa866mr3292765pfa.67.1614691692127;
        Tue, 02 Mar 2021 05:28:12 -0800 (PST)
Received: from localhost.localdomain ([103.66.79.74])
        by smtp.gmail.com with ESMTPSA id w1sm13027454pgs.15.2021.03.02.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 05:28:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
        Daniele.Palmas@telit.com, bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Handle probe defer properly in MTD core
Date:   Tue,  2 Mar 2021 18:57:55 +0530
Message-Id: <20210302132757.225395-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These two patches aims at fixing the -EPROBE_DEFER handling in the MTD
core and also in the Qcom nand driver. The "qcomsmem" parser depends on
the QCOM_SMEM driver to parse the partitions defined in the shared
memory. Due to the DT layout, the SMEM driver might probe after the NAND
driver. In that case, the -EPROBE_DEFER returned by qcom_smem_get() in
the parser will fail to propagate till the driver core. So this will
result in the partitions not getting parsed even after the SMEM driver is
available.

So fix this issue by handling the -EPROBE_DEFER error properly in both
MTD core and in the Qcom nand driver. This issue is observed on Qcom SDX55
based Telit FN980 EVB and in SDX55-MTP.

Thanks,
Mani

Manivannan Sadhasivam (2):
  mtd: Handle possible -EPROBE_DEFER from parse_mtd_partitions()
  mtd: rawnand: qcom: Return actual error code instead of -ENODEV

 drivers/mtd/mtdcore.c             | 3 +++
 drivers/mtd/nand/raw/qcom_nandc.c | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

