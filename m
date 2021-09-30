Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF42A41E0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbhI3SVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348216AbhI3SVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:21:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28373C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso8426041otb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td5nNKXFe0z6BB+o9VMLaTYliYU7qDR+uAvJ2+VJffg=;
        b=Ag0Z6xiuaEsDk4p0ERmC/jV+ZY+zGz/93n/yNpcW1XUe7/e/sd7+ayNOv3p8TpBQp0
         5bnC8A7K6YS+mghgU8ZLK9tEwN4lDI8o5r++lKH3OoZlnDBqBI7qR4b//ccH6YWAezQ3
         7uqXA0us193BPfqeyuo9ys4GKiVvdH3I5AuSL5DzgPgEH0VSKTGwWOKFk3PptGWVYxOs
         snqN2xbqfGktLWhqwWKCmvEola3Botbvwq53+0sH21rqtEp7KyA4X4TL69trNEEg04o9
         mxlRtKwdA4CKHtDXSKQ88OlckHFI1mStopmcxbDif9+wq7as7mbl502UwCGTZZr+VCeJ
         HR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td5nNKXFe0z6BB+o9VMLaTYliYU7qDR+uAvJ2+VJffg=;
        b=wncgEjXGelHZfFagnZC7HO5ucnNmxr4sHNWN4dQq6A8FA2B9Oa4XzjVX7TCuZ1FMu4
         yK71iWCvi/dyiaurS85WjnpWb+JbhYUEU9KOty2SHnie8dA0Enli4GOPViqGxifvTxMc
         lttX/LbZgC0dk2mTXYMljPlVaPrCyJ4e7PEHbGvHEfUs+gsAt2AmdYVgXeYTKu+jLa5k
         2SjOK6mTOu1Co8G6PM1vOxjbwMZSQdC5nCZ7zDQEXHICpaOXRwJzh/JinX1DXgC8mpb5
         vH8hdOfjazSXF+a9vlxph9L/0YlR9hxSF4ZndFPr6UJMrvfJNS7fRpDkBa3O1inUWIEx
         +3hw==
X-Gm-Message-State: AOAM533EypaX3M2ao3mNz94p/dx8YowW3dLh1ts0j/XLzaf1iBlBVh1x
        9V8a6HD6etwovq3t4LRGqCwXjA==
X-Google-Smtp-Source: ABdhPJxw9PsqwVDhjtyg9myFohulOkwSpYUdlB4lFF0YGMRrcnR+hPxiwHJxWhVfDQT0tOzhAssLrw==
X-Received: by 2002:a05:6830:1d8b:: with SMTP id y11mr6555934oti.291.1633025963500;
        Thu, 30 Sep 2021 11:19:23 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k6sm727416otf.80.2021.09.30.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:19:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH v2 0/4] dt-bindings: soc: smem: Make indirection optional
Date:   Thu, 30 Sep 2021 11:21:07 -0700
Message-Id: <20210930182111.57353-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the modern Qualcomm platform there's no reason for having smem as a
separate node, so let's change this.

Bjorn Andersson (4):
  dt-bindings: sram: Document qcom,rpm-msg-ram
  dt-bindings: soc: smem: Make indirection optional
  soc: qcom: smem: Support reserved-memory description
  arm64: dts: qcom: sdm845: Drop standalone smem node

 .../bindings/soc/qcom/qcom,smem.yaml          | 34 +++++++++--
 .../devicetree/bindings/sram/sram.yaml        |  5 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 10 +---
 drivers/of/platform.c                         |  1 +
 drivers/soc/qcom/smem.c                       | 57 +++++++++++++------
 5 files changed, 77 insertions(+), 30 deletions(-)

-- 
2.29.2

