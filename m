Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D03DF8EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhHDAYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHDAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:24:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B61C061798;
        Tue,  3 Aug 2021 17:24:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l4so613142ljq.4;
        Tue, 03 Aug 2021 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jrawWkwTlvICE/UJLSV29yZ8/AAL2WUUO01O/vVAfI=;
        b=BYLalVv24KoBEHrVTTDNuXuQ7GVo/MG1qnmPDpIDQ2w6JcvtnmLzXMJuixQ8bKR6Cs
         hMWtGXun57N8xLnrUUJf7Vo5Mf4e5r1aHfj423qjFKyhLWRZbTuwU90x98Dvc42lMT/6
         5Jp8esejLjjArFMT2uhClsa0QK43eo0pmmG+6hfiUQw4RGoMmYgJP3qRz37BSRdD6m9J
         P9u6uGURkUqgcNEtI7BKUBlcYuHquiIL1oz9yN9cyeqpkrfMlCs3RDiRb8/jGPCkn5mH
         XA2Hv7uhvNzTTdkeoichP/X3shTQVtZLhvMfsJhjOvaxvDlb4Fh/V1hxHOez3GGw6qCL
         FYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jrawWkwTlvICE/UJLSV29yZ8/AAL2WUUO01O/vVAfI=;
        b=F5df1P3yWf2nGwdB9FGsbDGNZf2ojEjaGKjipoTHT3Al6nKBbpBZJ5SqygDMREuxn/
         LOETmJO7uX+gz6VKz6q5r4i6onWdSfFU/yVbq1cOOnwhw6MplVWI4TN6e6/NiwnRqJdL
         Pl5bxX777L7s9NYeCre1iD+NmqRZBIwNaKBP+wjVqiV9wfN+/v0tYp4sHRX6IlLtR3on
         RDn3mfQu9ofMqUnxmA797oddpGRBcpsNud1eB3nXtqIU8lL53sNlSQeq5Q2goRjjNCZE
         la6V4MAavpuyrJ2mkLlqOSIyjmDYXE0X64TdFw56egO4NbL34qHygOWDiOq9dBAXAwyL
         DEvA==
X-Gm-Message-State: AOAM531n3BqMKRgR9LCPsbkZ/vhwCNe7bypOna4IqVqGuTDK7WEK0DxW
        Fwy8lJ7bCh2hRwKEZZiloes=
X-Google-Smtp-Source: ABdhPJyotbUOK2wp6dRGves0T/153s/WsreiKOScQsCgZOuKSDzsYsjGMaZlm7v1W9DegiBZkR08Qw==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr16452226ljp.237.1628036646369;
        Tue, 03 Aug 2021 17:24:06 -0700 (PDT)
Received: from akaWolf-PC.. (broadband-5-228-138-51.ip.moscow.rt.ru. [5.228.138.51])
        by smtp.gmail.com with ESMTPSA id t17sm40992ljk.102.2021.08.03.17.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 17:24:06 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v4 2/3] dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
Date:   Wed,  4 Aug 2021 03:23:52 +0300
Message-Id: <20210804002353.76385-3-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804002353.76385-1-akawolf0@gmail.com>
References: <20210804002353.76385-1-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for QiShenglong Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel.

Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3624363938dd..d7e9e516751d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -244,6 +244,8 @@ properties:
       - powertip,ph800480t013-idf02
         # QiaoDian XianShi Corporation 4"3 TFT LCD panel
       - qiaodian,qd43003c0-40
+        # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel
+      - qishenglong,gopher2b-lcd
         # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800
       - rocktech,rk101ii01d-ct
         # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
-- 
2.32.0

