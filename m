Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28245C7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349121AbhKXOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350273AbhKXOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:47:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34360C08EB34
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:23:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so4553638wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTHWBEbfl6JqlHFLRok24iptXGc883mbd52CNkIxXfI=;
        b=bSODPksyMmyxyHh6830sXlC57MgdbAo+ApijXj+vGXkgdoKxpGbztww9Cer0lbDqxB
         WhyGBYVtBTkKBfcYQoGcKc6WIBgQvxOqZX6mrFnaGHgiret4pdf5wj364pdNKQZNpHm4
         pDZBe4HmT1Ht41iRkT6lZCxHpKn3TMmGPOXWKOB81Rxnd3Eiexm/wr3vN/Bo4B/s5eVb
         MhGmsKhACewHWJfVEiFFYp3z6Mm6GdzK5b/2jHJC4yInV6qYutJOmuZITjE3YNzh6BYC
         Mp70JGP35UU2PlKbVUi6nbPHucsO7CKocVwp3ETSMl0V4O5oa2Z/5rfXdmdkToZZJM5P
         JlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTHWBEbfl6JqlHFLRok24iptXGc883mbd52CNkIxXfI=;
        b=HIIyHE8O5zMCvQHw/I5H0bJqGempfDZ6HrNgRI6eoEcB1JdCOYIkq/+1o7/4jOMdd8
         t5uQ8/RZkn76ksUDzeFcJXKYOwk3CbXKlmp8jZrdP9ZJRmbw8cN9C/f35WreJThPgJzu
         8zfXHfMnqoJ7Ypk/FqA+YV3CUMcxzC36WvPPo4fMpGVTd9ThLPYqsDI8nxwLongfyyaQ
         zD4BEdeSUCGYyj6S5ajgWN6uZPTw2F6SkKJTSgPJF1e7RDCghG+jSfrfPwPxG3XalLNw
         ntuzD0lTxV3OMGxOWTkAEAzEFuNt3sA7YPISIw9fuu6nDkNSkf2N8cyUOXSU0WsdADlL
         pVzg==
X-Gm-Message-State: AOAM5322iaJPwSPpoKGxIkTcXEBcADH63otd6UbAFg9AmGOkBamEhRmk
        Q2/mAvjcuhF+PIiI0ADIPwVhccTOcyf+uw==
X-Google-Smtp-Source: ABdhPJzhUqVXfFe4tJ0Xnk8PTMOr2zKFvtEBV4r5HTqXlsj/yYz7hUbszho3s0oZYe5RjCzqqtrDwA==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr19163299wra.43.1637763808756;
        Wed, 24 Nov 2021 06:23:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id p12sm15529705wro.33.2021.11.24.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 06:23:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] MAINTAINERS: add maintainer for Qualcomm FastRPC driver
Date:   Wed, 24 Nov 2021 14:23:25 +0000
Message-Id: <20211124142325.27108-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I forgot to add myself as maintainer when we
upstreamed FastRPC patches.

Add myself and Amol from Qualcomm as maintainers for Qualcomm FastRPC driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09734251e1de..abace2e2c4ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15761,6 +15761,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.txt
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 
+QUALCOMM FASTRPC DRIVER
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+F:	drivers/misc/fastrpc.c
+F:	include/uapi/misc/fastrpc.h
+
 QUALCOMM GENERIC INTERFACE I2C DRIVER
 M:	Akash Asthana <akashast@codeaurora.org>
 M:	Mukesh Savaliya <msavaliy@codeaurora.org>
-- 
2.21.0

