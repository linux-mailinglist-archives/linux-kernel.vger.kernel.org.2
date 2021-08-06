Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680F43E26A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbhHFJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbhHFJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:00:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320EC06179B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:59:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso8346140wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+kMyfhCPzlS7skqnAcT+FomwoDNF/rh7mzm45omea4=;
        b=XBituPdoRBD4NPkBxGHNHQKpa+mSpTG2q1H+ncPn7Qx3SpwbM+MR/UPgiMAm8hwHjG
         bymLY6c3l9YpmVnO4K/Fo13he98ySWK2HF6lhIAvv/mgz6jP7nl3n7wVAoXSFPPOAt7u
         hUD6cjZl/qL+AIPCfrnoYhPl7KltEatZ0aiiG2YyJfGY99cnt4sSWlGibat8Yboa6+TK
         aOQiYK0RmPuxPKvMc+tLDMkmbiqJuUHUY4831srhhPbKnBsMv+m6Ahh8AlLCm565NXDK
         IxDBUNUSiXxtF2btC6/QyyffOpEp1GSTMhIt5zJPtcLkd5D7Q3JsZFcZMIdE3zw1xknJ
         L1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+kMyfhCPzlS7skqnAcT+FomwoDNF/rh7mzm45omea4=;
        b=tqP2iQbKck0XRzJCSY8zMxnWo/o+2Q+NJUo40EcgLWcA3hgF7keVphKJL1K5uX2VDC
         l/hBXjBvCXYiq4HScEjVvcxXX5ZMYPEnCy+UUoNiKYaFcvVCwf0TxSD7jkRUiHCbsiV0
         A98YFhej+cqRdGK9ou6uGQy3czKVpVSVAarFrwDF5ufaiIH3n3NGiJcTMT1SdQaC4K3L
         W7LvQg6+mGZxTNDWx7avmD0ZQG8QQ8mDONVWw+5s3jyW+DzfuOHUilovt/yV9IOPjzo+
         nBRhb4jD9wLVfyjZ5qYUXXgWLx1jFO2qUnTHROIfWufjaWphxpN6bqlJzMft2CeKtsx0
         eUZQ==
X-Gm-Message-State: AOAM531ylCDlXXDifVao+dFsE/VSo2y1NypM3dt6aDm1jmala77RlDrv
        iSDbmb+oZ3NfI7Fpa1N66dBCuA==
X-Google-Smtp-Source: ABdhPJx3x9VcoJtYkQZ9Tpw1A3HRo8AUAmtPczxhg+VBGZzdJRhNUFsYihNI8qkUzvn5pBxWZtr6lQ==
X-Received: by 2002:a7b:c942:: with SMTP id i2mr2102701wml.153.1628240391396;
        Fri, 06 Aug 2021 01:59:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x18sm8506144wrw.19.2021.08.06.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:59:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] dt-bindings: nvmem: qfprom: Add optional power-domains property
Date:   Fri,  6 Aug 2021 09:59:44 +0100
Message-Id: <20210806085947.22682-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
References: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

qfprom devices on some SoCs need to vote on the performance state
of a power-domain, so add the power-domains optional property to the
bindings

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 861b205016b1..dede8892ee01 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -51,6 +51,9 @@ properties:
   vcc-supply:
     description: Our power supply.
 
+  power-domains:
+    maxItems: 1
+
   # Needed if any child nodes are present.
   "#address-cells":
     const: 1
-- 
2.21.0

