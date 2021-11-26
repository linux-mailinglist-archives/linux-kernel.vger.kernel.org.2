Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1830845E834
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359112AbhKZHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhKZHIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:08:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07441C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v23so6595911pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1ILYtinVwd0mkwf055YK252Zf97GHuWql+Jyy65qoA=;
        b=lUoqKFA7wF7TBlQnazfz94JjWQSDAeVQaRn1p38Rk9zTKRnnM2nZ3PUZzsAELGlUs0
         OiZwooQpcVoCY6Lmgi7UcBOpBKuATQaQ80hS8GIMzKWDrwSESbhx0hGTOIu1qGEWnSiI
         meD0g2CR/T8UUS3kfYoFsPfFShNd2JPYZPy5o8NUneA6A/gsFcz7fWd0vb3Xssyu+iDR
         8PN2+9IZqRW8vTNMhHxcSWzXMolpf4tgj8+pmx49nFFG2vnSya0Qe3/qCufuzebK/XoB
         JcWO+Hm9ab3oa6HdtQa4JfcqWQ7oczicxif1LRE73LgpIl/c+XyCr6ZCVWf3+oLxRB0p
         Dhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1ILYtinVwd0mkwf055YK252Zf97GHuWql+Jyy65qoA=;
        b=InoQTDHJT/fYDr79FYiUm5rXNftP9OV8ee5dcP4tS7ywcZWfsjgyYq6zYZ68sTMBWi
         ounaPY3gCP61qTcvVTE/TlyN0atXEYXDG4OKXIBZHMO+YxRHdqMoSlo6HFcUpuSJ8dfB
         GU0WqeizIJEB5cBFzeibeAHWv2CX3monzJMJDqTVI8ZiPOX44g5wvHiJYSBTvRRiLdmy
         aeHE+jX9LZKrrJMekA/RCPuOCjkWWXd6sunLLDxgF7a4V6ea30yKT+m/oNhl6wTY5gib
         qlN+pB28wxVMdvjHAm63kRVMJTX/az+3u7cb2wRqAMkBxt6/lYBCwK+8Hyx1PJD+5Osj
         gUOQ==
X-Gm-Message-State: AOAM530wJqkyzFM2MaioGbACYd6tjkztCfaGQO/PsK6o/Mae7F5UQuj7
        vHHZsvLYv9qgLVLwGw5GKjJr
X-Google-Smtp-Source: ABdhPJx2GKz4dN+VPfHHobP8KobaR+8T+eVckNaOsRxk8EN+f7YYm81qizDfUhCG5V6eE/F+R6PmJg==
X-Received: by 2002:a17:90a:f00e:: with SMTP id bt14mr13660700pjb.219.1637910327442;
        Thu, 25 Nov 2021 23:05:27 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/6] Add PCIe EP and IPA support for SDX55
Date:   Fri, 26 Nov 2021 12:35:14 +0530
Message-Id: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This series adds the devicetree support for PCIe PHY, PCIe EP and IPA on SDX55.
The PCIe EP is enabled only on FN980 as there is no endpoint support on T55.

For IPA, the support is enabled on both FN980 and T55 boards. With this, IPA
seems to be functional as the modem ready interrupt has been received. But there
is an issue with some QMI command failing with the mode, so can't do the
data call atm.

Thanks,
Mani

Manivannan Sadhasivam (6):
  ARM: dts: qcom: sdx55: Add support for PCIe PHY
  ARM: dts: qcom: sdx55-fn980: Enable PCIE0 PHY
  ARM: dts: qcom: sdx55: Add support for PCIe EP
  ARM: dts: qcom: sdx55-fn980: Enable PCIe EP
  ARM: dts: qcom: sdx55-fn980: Enable IPA
  ARM: dts: qcom: sdx55-t55: Enable IPA

 arch/arm/boot/dts/qcom-sdx55-t55.dts          |  6 ++
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 59 ++++++++++++++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 80 +++++++++++++++++++
 3 files changed, 145 insertions(+)

-- 
2.25.1

