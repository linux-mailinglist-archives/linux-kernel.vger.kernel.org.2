Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5983AF4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhFUSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhFUSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:16:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF36C08ED6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 17so3535962ill.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akzgFtmgF+CdBGifyk1rw0w+qVh3UK440Vu2WfXCaUc=;
        b=TlL31i+5DGSa2KSeDSKE9m3tLYAnA3RhVCnTFVGlGTdMzRLkIgzrHlfU+SXbfvyOAi
         I85SKzF7Tb38Qw2DaQ0I1sWUMN5VPxEjHZPWpN/ahCUE0uLa37TwMaCV9t5BeRJLcysQ
         gqu6/hH8SuyDlKrp7sbpABGnzjAetIB3gotBsMdpbHGViEQv08ZR1wjFq7nghVg5Lzum
         lgG3R4W95dE1rFT0G9c1/gLmo3XmPCcF9j2j3Tee8NWhJr0iFoMVU3mLoUFfLQfQFQOY
         yuLuEn1C7eICNG+OftUWXe5K62xGDUkMozXF1v8qN+BEt1+h+riK21MjSExGbouVwcF7
         MRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akzgFtmgF+CdBGifyk1rw0w+qVh3UK440Vu2WfXCaUc=;
        b=fPLUFVltYnErtiGKdh4Ewql57a4sJ0YaUrqYS8zR875ZtQi5SjiGloZif+2vqJ07i1
         W5jQINxksD0uqeLkBmlo75XYfBXjejL1KEu8PgCHm9xL1ebabvvz305Lk1XmTLaWw0m6
         0rmlk3hJIxfIrfbss14BVobLccuYGnyWi7K/+VJQNbVx3FukBzpfkv0z4RxgCisy2JCN
         8nzHUtHHobTX3YaAMBisWyAGE9+G78yuRa4HRCv1WOVm6K4cAZOU5hpAZPkChC/PMyk+
         dvDlshXoBjXyBYcDOm3pYKrK71Z+ap2JKLttHrmlRWUbasGbPk4zScOp8sX9OwlPR6fk
         xYmw==
X-Gm-Message-State: AOAM531cX9MrEAC6qOe5H/tGldr8oSRNMVj0dTk/m/AfjN9opXs2+ThI
        QA7XZ1s6XDTMmx2r9LjqlfUFxA==
X-Google-Smtp-Source: ABdhPJymfUiaLImoqo/ZgRpFizkf3lHZ3nBsWiL0ig19escJ6nfeuMQRVdWv8xlA7GJtFLkiKnjKRA==
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr19224965ile.274.1624298192234;
        Mon, 21 Jun 2021 10:56:32 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m13sm6259264iob.35.2021.06.21.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:56:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org
Cc:     angelogioacchino.delregno@somainline.org, jamipkettunen@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] dt-bindings: net: qcom,ipa: add support for MSM8998
Date:   Mon, 21 Jun 2021 12:56:22 -0500
Message-Id: <20210621175627.238474-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210621175627.238474-1-elder@linaro.org>
References: <20210621175627.238474-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for "qcom,msm8998-ipa", which uses IPA v3.1.

Originally proposed by AngeloGioacchino Del Regno.

Link: https://lore.kernel.org/linux-arm-msm/20210211175015.200772-8-angelogioacchino.delregno@somainline.org
Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 5fe6d3dceb082..ed88ba4b94df5 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -44,6 +44,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,msm8998-ipa
       - qcom,sc7180-ipa
       - qcom,sc7280-ipa
       - qcom,sdm845-ipa
-- 
2.27.0

