Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6646B3950D5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE3MUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhE3MUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 08:20:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A92C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:18:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dg27so447347edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N60HzV+cqUOHSm0xyO9PKF9fq2+mfN8wKnJGwhzE5P0=;
        b=FannPbVx6zDTBZ8ual3QJ1hWadBUE7+ETukrrYUV8G6kh2ijS3Oq50ZJPv3+nvJWYC
         +liOgi9DM5RK6/fjdwU6MYzKUA77WjAXXxlSd6I25m07KP70FtGlYt/1CatTCJrMJFPd
         1siSWY9N2qMYnSduCXtoiNw7VfECam9QKx2PN76VgPeR11pMXtzChP5paYeLLb6XiEUj
         3S2ptmpiUGlhsrFkh9rcPwyRhwWqX/51lf1dY8vT7P05Ffbf1spkM+45HuPpr+IY8kzw
         +5Jbj7HaLowReAwU/C7jNvugSpf0ln6remwwKTi1J/NIfh1cH/ZKx1V7ZABdoHo2HsiB
         N51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N60HzV+cqUOHSm0xyO9PKF9fq2+mfN8wKnJGwhzE5P0=;
        b=Q3bj4vUZp8/0maJsVUR5DkSm8DdEjPuap3yhNrR8NVwTjSt+1R7hH5dZ1cGVnP7V1h
         V6HOXxMdlJMc3DcEN81IS6na6ptoxlfYUHI4d4r4AHSzTOc+r5+xJLojgyW7YIlfqlHE
         YP4rbLLfti1YqXLDlU2rtJKSxNLFEth+AtWqtJW9UAWk1Rv9SsXbk/NIkVXPMu8SASn9
         ZduprmICVX259nhfibxLVZhea5+0+MmnLVzGThVUASDnPNa+fkKae7EkzWPp6VH7OEY+
         woXjHSiXD8y+icBSOgj65VX62cDGoFlnvfKkvoi0p3QidD/+2H/5v3LTgnofarl9HdMg
         x+UQ==
X-Gm-Message-State: AOAM530NWSewXu3iTT2Z/IMI6/kLO0g7/GheR27eyj9Fm/sh6ECxBkoF
        9jCYz9J5QcrR7C20vKqf1DWMIg==
X-Google-Smtp-Source: ABdhPJzCLE0AIneNRFOtS3RvKV29UmSYZ+JVPAKK1b8DePSPTqZ1JY+eUU17r3xH1h5Zjtp2lti9zw==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr20411865eds.163.1622377106692;
        Sun, 30 May 2021 05:18:26 -0700 (PDT)
Received: from PackardBell (192038129069.mbb.telenor.dk. [192.38.129.69])
        by smtp.googlemail.com with ESMTPSA id jx16sm1311662ejc.49.2021.05.30.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 05:18:26 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id fcbb3f26;
        Sun, 30 May 2021 12:18:22 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: msm: Add SAW2 for MSM8226
Date:   Sun, 30 May 2021 14:18:02 +0200
Message-Id: <20210530121803.13102-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530121803.13102-1-bartosz.dudziak@snejp.pl>
References: <20210530121803.13102-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dt-binding compatible in the SPM AVS Wrapper 2 (SAW2) for the
MSM8226 SoC platform.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index ae4afc6dcf..94d50a949b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -25,6 +25,7 @@ PROPERTIES
 			"qcom,saw2"
 		    A more specific value could be one of:
 			"qcom,apq8064-saw2-v1.1-cpu"
+			"qcom,msm8226-saw2-v2.1-cpu"
 			"qcom,msm8974-saw2-v2.1-cpu"
 			"qcom,apq8084-saw2-v2.1-cpu"
 
-- 
2.25.1

