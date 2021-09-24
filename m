Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD0416C74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbhIXHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbhIXHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:02:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 00:00:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so8937406pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDO4S6rhDP5VVHCExmtlE8+OqL7NPCZ3JyHHEHL0gNg=;
        b=BCGpatXOcynBQLUnV0XoIPZGp3+d0c1gk+xpJpwtGrFIJBPI+Cl3FTAZE9/JH/ujnP
         hbaqewvL++xY1zTQtij8SvinUfBdkfJS25tiL4CW1tY+kraCQfiBtv4K9PpIrHBvJ3Wn
         KrrV7IwmniqbY+NHaJTfyjr+waydGztYxCFC7nwh5kI27IV7dY1FFSNmlxVfumM9qMKd
         ccxSf9lWwCJOjfh5lX+F3GhkYFTwoke/+PDdBThjmfMrHF1oL2cHAJdbzudRUAdxeVbQ
         kKsq8mvPFgQCybaiEkOLqIvTghGc1Wzv7ApiO83AJffBGer7qYyvS6O/hbUN42/Q3j6c
         qd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDO4S6rhDP5VVHCExmtlE8+OqL7NPCZ3JyHHEHL0gNg=;
        b=RMv8AgOPagYJWz0N1Rg+ZoPRN2ynq6M4sEXpsu2U7zfnUr1zoogeu0h5qJyx3YeK+v
         uL9Bhpm5VBThup0qNA+2Km91+1AEoowiChSbXClZUzPrQeM9zZhiYmJpl2JStpyIQjAy
         jDwa8J6jrm3+CriraJJzoe7Yfa7K7SSzQV3k6LV7YtvC2AZh1wxQ+dVXpzRXq48NjHF8
         UWJT1OCvKGwLC8lyrtWodxT+lgbw4ZN8y6YRIb4QUorBmFSvEukQYYNXjnW/XUP8DjlD
         6sdfHryb+3nnxKpZhHPDI6gAQS6ozm46ksF42428VLMGEoa3sejFxoNx/JKoLOZgPZE2
         wx/Q==
X-Gm-Message-State: AOAM530CUWMYrMua0T0hkf5rKsTztO79pf+wHBsq2BRZ95wLsRBuSKgV
        zS6e6mguFNdReSYeRejILy4=
X-Google-Smtp-Source: ABdhPJzllHwyKiN66Yfh2p5fqetnOVAFhp733UjsF2pHyH643tnAMR67KuRDcIYqXSuuMMnn3N+9CA==
X-Received: by 2002:a17:90a:1944:: with SMTP id 4mr430388pjh.45.1632466848765;
        Fri, 24 Sep 2021 00:00:48 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id e5sm7893859pfj.181.2021.09.24.00.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 00:00:48 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 26D4323606C7; Fri, 24 Sep 2021 16:00:46 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, tiwai@suse.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoC: q6afe: q6asm: Fix typos in qcom,q6afe.txt and qcom,q6asm.txt
Date:   Fri, 24 Sep 2021 16:00:44 +0900
Message-Id: <20210924070044.569541-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two spelling typos in qcom,q6afe.txt
and qcom,q6asm.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index 2d6fb2ea75a0..1677448347da 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -12,7 +12,7 @@ used by all apr services. Must contain the following properties.
 		  from DSP.
 		  example "qcom,q6afe"
 
-= AFE DAIs (Digial Audio Interface)
+= AFE DAIs (Digital Audio Interface)
 "dais" subnode of the AFE node. It represents afe dais, each afe dai is a
 subnode of "dais" representing board specific dai setup.
 "dais" node should have following properties followed by dai children.
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index 8c4883becae9..0d0075125243 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -14,7 +14,7 @@ used by the apr service device.
 		    from DSP.
 		    example "qcom,q6asm-v2.0"
 
-= ASM DAIs (Digial Audio Interface)
+= ASM DAIs (Digital Audio Interface)
 "dais" subnode of the ASM node represents dai specific configuration
 
 - compatible:
-- 
2.25.0

