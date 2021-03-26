Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64C34AE21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCZR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:58:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y1so8351127ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcQzTMILK75vkJ7HrFpUsFeadhrqqgnoJj8l6pMg2E0=;
        b=cCmVEkNAO3CSNkizj4S0CRatIlx/hUglkQbwApjM7ENh8SwPcOpZs1uMzs0IhHFffj
         +zPKkHr6LEPRvPliUxpOhsdQVhQNqATADL7DLHol6UhdDNNTT72BC4AxkRnVbc1gICOb
         ByWrEnKtbQ9aNvEnhj8BGxaYzGzUjSs/gme/7iIZdBS+kCUtjRRcFKS1X9+fDvJksJeM
         EsOGRzJhlXL6rXmQfvPqq+LBG4bbThRjjEpfD6B4JaprJ29fG64otsF4/IxvOGS08wTE
         nIl+AzGFYfJP9aaQw9ixIDQoEiOHnf2FGxJRW/nP60DFbBtJvN9Bg0u8MRjDEV1+9b1B
         aJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcQzTMILK75vkJ7HrFpUsFeadhrqqgnoJj8l6pMg2E0=;
        b=PtofRBy9hnkzvQY/1ZnZ7sfaUOL1APfGO9gZUMhnu9wHMXhWspx0TEeBXjJx8UJLbw
         paaYf7wa2TFoRLg+ZBULdcO7WEUx+guWkGS8EwmURf4Xw/gcQKOCmvrx+b1SMZRYaLAY
         M4aA2r8d9jq/7h/fDYTUJQ7kQ4K3Feo+/vrK9NkKSsLaBSpkUMuhxxTWhTVYTRIDuQOa
         Jsc9ql86100LKt129FUtIGSntTUesWbPk3oRo+fZTWLmBSrPay1KNf8DXh2hxK2Iw9YV
         fpiszKcVZPvEtc9KQB0oPRrEp0h2IXkJm1UzngkxGST8xYNzDEQEMvRYWdLfqWlJ49zt
         qUFQ==
X-Gm-Message-State: AOAM532aPrhRp1jPBXr0GAi2bCEWAaaizeBuFx2Mmpohn6AkcS12LQp7
        1eBggXGaXa0kfKEZhD5vkQBVXQ==
X-Google-Smtp-Source: ABdhPJyI9bZ1TlxCCO1oNWqQBchjpGf81z6SKUqDj3MKClhNympPrzkOi3o/ISuyUNtfEsYQFoWacw==
X-Received: by 2002:a2e:545e:: with SMTP id y30mr9897883ljd.46.1616781491377;
        Fri, 26 Mar 2021 10:58:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3sm1249554ljm.5.2021.03.26.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:58:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] phy: qcom-qmp: provide DP phy support for sm8250
Date:   Fri, 26 Mar 2021 20:58:02 +0300
Message-Id: <20210326175809.2923789-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
 - Move qcom,sc7180-qmp-usb3-phy and qcom,sdm845-qmp-usb3-phy from
   qcom,qmp-usb3-dp.yaml to qcom,qmp-phy.yaml
 - Do not touch qcom,sm8250-qmp-usb3-phy compatible

Changes since v2:
 - Drop unused qmp_v4_usb3_rx_tbl

Changes since v1:
 - Provide dt bindings
 - Split register renaming from sm8250-dp-phy patch
 - Add respective changes to sm8250 device tree



