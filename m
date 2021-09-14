Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED67240A8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhINIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhINIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:06:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE14C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:04:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f65so11398048pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mPxf8n4L3IhQim+FqxOgbXfL3jMltbQ5PguuhqlZwis=;
        b=jXuhTz2cNKtJ3NPxnOg3cpQ0f/hkZoz0EZ9XWrpKu5pQMOAWGEhYgfINCwMnPHZ0lQ
         YVdkKLJwwQgTDtl7sWrMut5/du/OFrbE3JAsL03JhFKa30Vxg2pTpiae18R1lCLfQWCn
         V4K/admGlmXsBKbbVTd4LhrwNpRrLKcUdKOnPgURsSh9MOL1y7hvUU0gUJJVef49EY9E
         Ae9xZQr2HvAWF8Ge0MleZYx5YBPG6pO0GpkJXQjpyz+xOo9B1TBWEqpTQSjLHFvdAqLf
         2rPbKN7KucbU8Q3zmTODxbKU35eUVgKGWS5UksNYYRSyc8HzdgRvdwBoMYkSq61NFVqA
         ZHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mPxf8n4L3IhQim+FqxOgbXfL3jMltbQ5PguuhqlZwis=;
        b=fhF51XCD61kWeM6fHZu/98aNkmSuEL4kkp+IttqWdjL/1TncSoq/e/yAtfX5DXASth
         pWdbtq/U3N34iJ4mIm3gvkep+LcG2ht9fsr9SjF0pMWrexV0x+W5vHX0mXz6L6pccKCM
         V7XuiYyQgoI9ILJDJtsVKZ1D6XKuCOs8D+Q1I5FPiZwEmu5AgTbSa8RarCkm6n2ZBc4o
         XBS2mbNwF3ZXO4d0/7Fc5JuMQNror/xbeFqZIjNhreuZTnsgenYhCCzdyvZZ/jAkLgXY
         wSSo4Igv8GG9YmC/Y2TCVo0qlZe/trMBSw+O36xJxvWiQCFGDejPVrsNmUXH1MJ3VBA4
         V1Cg==
X-Gm-Message-State: AOAM533egSyo1LH9DCZ/4NETgqrr72gc2zohhkpFXL/cRc3gt35TQ34/
        JU3CZji9Zry3yD+QhB0bVe0iUubiVl02tA==
X-Google-Smtp-Source: ABdhPJyBV4Xv+A6RpGj+/8WZTrDIvEBMuenzOA/XTxb+vQGguV8s6pAEMow9p4iiamqfR0koc1YENg==
X-Received: by 2002:a65:6ab0:: with SMTP id x16mr14713986pgu.181.1631606681022;
        Tue, 14 Sep 2021 01:04:41 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y6sm9328396pfb.64.2021.09.14.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 01:04:40 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] dt-bindings: mailbox: Update maintainer email for qcom apcs-kpss
Date:   Tue, 14 Sep 2021 16:04:33 +0800
Message-Id: <20210914080433.13499-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sivaprakash's codeaurora.org email address bounces.  Before he comes
back with his new email, fill Jassi's address in there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 6395281b0cec..371cf31f4154 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -11,7 +11,7 @@ description:
   platforms.
 
 maintainers:
-  - Sivaprakash Murugesan <sivaprak@codeaurora.org>
+  - Jassi Brar <jassisinghbrar@gmail.com>
 
 properties:
   compatible:
-- 
2.17.1

