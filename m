Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED709370B82
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhEBMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhEBMVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 08:21:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF9C06138F
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 05:20:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gx5so3785500ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsvE6WtMIKMdgchel4AwZbyPodFOn787PJi5Em1/sIU=;
        b=b6uyzwIqE/5gAw4uTRy7Lk+AHHUw4it3l+zWdboAjKsDf6/3ROvE3AMBy3qVIgYy1y
         qEsqFM/zI1gK8dc279V4PERd8TskJy6cs2IsRoW1e1DE5gGlhVeEkHRTxd0s2Mg0OECt
         eoz9URkSDAuLOid4gJ2vSduTY4SQ0hFnboBHvKAnGoIlCf4Tv7eGeokv/2GWechIM2Gy
         VfQamtu9bc4RiT9LQ+0ztn6/GjBO2Qd/4PDYKsG5UpoWCMeJQeVpf6kbiZFW+DH8uPjE
         k5Ejf8o2+btvm3TS6KF2DuzDfHRYEu1QcPSnEYXN6+IYejEhzLDYx0sr8i1dnAN4YhiB
         EZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsvE6WtMIKMdgchel4AwZbyPodFOn787PJi5Em1/sIU=;
        b=Chlgx3wcaaon8a8TZ8hgWWwiJnhfW4tiB2czgOiZVRC+v623H3R8fc0IU3E24rQ9eX
         L+ar79NeF1e+AHO8+B8vNnJKqnd0OhsIXRNXIqI7JauEMAo1nCvnrOBhqDwl+J5mXsRc
         f6heeE64pGqNplG8yp7cM2yCdUMH8lrl62j6qhbTdLAcwHusBnn8HJHlFZPa36Wxb05F
         J812hCxr2Oa3bWHV/5/4LqIQsT2u2TO5vpgcCJN06FtRiqsUCGOheQ7zqzhPySPtkJN3
         iPb4LV7BrQ+K5YNADzw6dh52jIikIaP4qpEHbjUFfiDMfLr07GnByTZzytVESXJKfVty
         UMmg==
X-Gm-Message-State: AOAM533tmXxT6Er+uEQIzrPqxgzWCw9TsqwJiWy89XxhX2w28s8mKRff
        znQK+5WqM8ayWAuFSxk1OEbHxqlxypX3QwS8
X-Google-Smtp-Source: ABdhPJwI3BtPLCf/2LScXjOjr1q3ID5iBq8yyFRYna9IQEs33/TuZVWGiC+fYR6G9uJM6parQx0AeQ==
X-Received: by 2002:a17:907:3e27:: with SMTP id hp39mr12611354ejc.373.1619958049372;
        Sun, 02 May 2021 05:20:49 -0700 (PDT)
Received: from PackardBell (192038133011.mbb.telenor.dk. [192.38.133.11])
        by smtp.googlemail.com with ESMTPSA id b8sm9866238edu.41.2021.05.02.05.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 05:20:49 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id acc05d90;
        Sun, 2 May 2021 12:20:32 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH 3/4] dt-bindings: clock: qcom: rpmcc: Document MSM8226 compatible
Date:   Sun,  2 May 2021 14:20:26 +0200
Message-Id: <20210502122027.9351-4-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502122027.9351-1-bartosz.dudziak@snejp.pl>
References: <20210502122027.9351-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dt-binding for the RPM Clock Controller on the MSM8226 SoC.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index b44a0622fb..6cf5a7ec2b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -12,6 +12,7 @@ Required properties :
 
 			"qcom,rpmcc-msm8660", "qcom,rpmcc"
 			"qcom,rpmcc-apq8060", "qcom,rpmcc"
+			"qcom,rpmcc-msm8226", "qcom,rpmcc"
 			"qcom,rpmcc-msm8916", "qcom,rpmcc"
 			"qcom,rpmcc-msm8936", "qcom,rpmcc"
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
-- 
2.25.1

