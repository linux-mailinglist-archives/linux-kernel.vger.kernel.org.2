Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE840A2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhINBzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhINBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:55:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B023C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:54:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so917281pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O5xAbLoEhqna5h0y/XyCAxx2q9zjnI4XayfwWBL9Zp8=;
        b=n+EbOg49G3Eq3WR+Gm9bBeHI88Bow8zkqZr9OmKMtepKOQwR3fBILY88fFK/5M1LEb
         6lsuL22Kv6RjpSUf5FeoFsW+9XY0/Z3WpALplvEeK8Q8qHouW4wfJlPPhTtMwi/IrwpN
         PsU4AoPKFecXKHYDYm8KaPCLZRqZKSUR7VN4f8XI6SoqBblpWMCt1fk5xllv+Mc9Za9V
         +RpsYnBQHFhRzE40GqlPLJeM0g5Gi79ZBoN2nYH5iCsnIQzdSTQvt6sDRUU6C6c41jc4
         16cYjvvtp8Sz+v49yjOFUlTu8mRgGP99PqOqwPmsgEpkJ12xhgy0CsCInK6JHMr/IObe
         N0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O5xAbLoEhqna5h0y/XyCAxx2q9zjnI4XayfwWBL9Zp8=;
        b=NrmqDJTd8eIZTM89eoivU2+Q+N+gou5g2ZvnvCgH8iJcielaiPWar7i3ZyxDt2eI9/
         YzMmSwwbJUOHvS+6CSVvB9QTgxUR8WXBWW0QesIx3Nt5z+9EH6b0twh2/XoYtB9Wu9IY
         ZTAo9XN2GXDG62MlOl+tWOuEkjQ5cjaCYh0hwh5p+YskUzJimY/6K6jt/I27r6DGyVqi
         Yg8/gVdsn9kOoCdWrm0MWk6/NEzEYHqjnNZik2tOjrlP4sKVWYKtMjZRHmO7Ucvz2gUV
         ftpuWrqhmT9JBWRhlQppkoPHvr0ZM9QnjxNdmbrjNIg+yxem4GD4SF6SX7eP5yWk8UAt
         i93g==
X-Gm-Message-State: AOAM530AHiP5EDb/qRxEbrAHkcmSgD1XRp4YXXJOQHRmBy2lh4R3NK0c
        hYZVDTpnDUKtX9xj9C1PA6Ffjw==
X-Google-Smtp-Source: ABdhPJw5UftYRnUyjXeMi5XhYPOFdwITKDVh7KwQRuGINbD4ojyB0oPf2xw5DpICTI/AQLEt5+PAWA==
X-Received: by 2002:a17:90a:9404:: with SMTP id r4mr2702303pjo.240.1631584441739;
        Mon, 13 Sep 2021 18:54:01 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fh3sm8089088pjb.8.2021.09.13.18.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:54:01 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: smd-rpm: Add QCM2290 compatible
Date:   Tue, 14 Sep 2021 09:53:48 +0800
Message-Id: <20210914015349.29295-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914015349.29295-1-shawn.guo@linaro.org>
References: <20210914015349.29295-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the RPM on Qualcomm QCM2290 SoC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index cc3fe5ed7421..3b6dba11208d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -41,6 +41,7 @@ properties:
       - qcom,rpm-sdm660
       - qcom,rpm-sm6115
       - qcom,rpm-sm6125
+      - qcom,rpm-qcm2290
       - qcom,rpm-qcs404
 
   qcom,smd-channels:
-- 
2.17.1

