Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61F43373A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJSNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:41:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93963C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:39:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ez7-20020a17090ae14700b001a132a1679bso2157598pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fu/N0/wfJM/gNSAgQFxGKP2CBqPDLA0sLqKbjnA3xdY=;
        b=Sle7GBCUBcaMrbCqc/kapDupfY68tIlY5S++TgCSHHZtBhc1aMcV4FYyztVYS9amR0
         uz0NjpiwpgL+O/IXtUAcO172eGrG8HyoURZwHUnT9A0wLAuhLcodsbY8lLbBbmKCNDv3
         m1xKhoXeNsOv95UOslEfSRjdGhq9c3w7Gb2AsKXr2COj27uewgC/QpIJnK5sh206FCVq
         qD/v+FyXnLLL0/+FfqC6xu4pfzukqdu1MP7iL3E85eh6uX1ShdL2VpuYTSWr/yZngBzX
         D1GmfNxFVxTZDuktj7pAs5WuKf8s25kbKsUSavW8hgUvpQJiDdk3yLYOTtWbrxfrIGcV
         ZAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fu/N0/wfJM/gNSAgQFxGKP2CBqPDLA0sLqKbjnA3xdY=;
        b=170PAI02sgTwE98sBI8N840lw3CutbtfrVqmulTxd9V3F/V+4nxPB6JY75pdpfHpIJ
         KzG5Qe8cLTVYFiVzdSvZUzaYqB8wyiNQb10SPbcz/GAiTHe/1+J79MGLTyEhTLMfpX/1
         r4fXfSgZcaWmt02j4Ekk5mGOArY2Yer+4RPXzeepPB2Tmk0miM8yrOZEh60KzdaVoTip
         PXUA99JzSX4jZHukEsg889Q7Du0ieoZejf6XLXBZf7YGmgRa47kwrk9OCXx/tmPbRmyV
         cnM9ojU7StKic4BSWC372Ltlwf0P55f7XQhynfdw4wbuWyINTSi8Vpx4IWqSmY8iKjMQ
         ITvQ==
X-Gm-Message-State: AOAM531QmR2DeO+HCoaSl7BjgDd8Zoo1SzZBhhDnYQV5WaOrVmjq5s+K
        0UI2N4Hb8f73Yc0vn/5H8oqg
X-Google-Smtp-Source: ABdhPJwZyYaewx1KbnTgde48SxICfHFIR6T6egzKlyy+QHDPCrs3EolfNClqU6G512RRJMFKemEndA==
X-Received: by 2002:a17:902:64d6:b0:13e:a5a9:c6d6 with SMTP id y22-20020a17090264d600b0013ea5a9c6d6mr34024953pli.52.1634650766905;
        Tue, 19 Oct 2021 06:39:26 -0700 (PDT)
Received: from localhost.localdomain ([202.21.43.8])
        by smtp.gmail.com with ESMTPSA id g11sm16020033pgn.41.2021.10.19.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:39:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] MAINTAINERS: Update the entry for MHI bus
Date:   Tue, 19 Oct 2021 19:09:01 +0530
Message-Id: <20211019133901.173966-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Hemant is not carrying out any maintainership duties let's make
him as a dedicated reviewer. Also add the new mailing lists dedicated
for MHI in subspace mailing list server.

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Added Hemant's Reviewed-by tag

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..8ae357d746c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12191,7 +12191,8 @@ F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
 MHI BUS
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-M:	Hemant Kumar <hemantk@codeaurora.org>
+R:	Hemant Kumar <hemantk@codeaurora.org>
+L:	mhi@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
-- 
2.25.1

