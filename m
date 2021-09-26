Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839074189A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhIZPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhIZPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:01:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057BFC061570;
        Sun, 26 Sep 2021 07:59:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so44102666wrq.4;
        Sun, 26 Sep 2021 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aNtDTuzOAT+YuiF30Z3WS40pgPV+F0Fyu3AoNR9Jqc=;
        b=BnzD6wDSAOJGpAE8g+zqjJ8lSPCNOBe1KfdAu3gg85bMB9cg7Mc5ojDS//WRtgDBMK
         Mk280sBRIn+IeIumLrI246xdzCF5ApQ1VAgJhWczn9EHxJsNVftc0GPmZrO8R54AZ6qv
         /tXXbvoe0Yqg49u/ePwVS/HLDGg2+CJ8ElQeLppgzebH6Q5fZtoCDRPtEiZ1X9m14iRm
         o9RaAzwZFkH66txn+V9cvmKb7pHFjIXwfKqLKmS9PNBs91074OAgwQOSnnkuM3/H9UYW
         99Ln0mb/YYknyhpnCojTF59XoKdpfeEt9+uULGVlsyGU+2URtQV5sjHPnmq2OnrPmFj/
         GXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aNtDTuzOAT+YuiF30Z3WS40pgPV+F0Fyu3AoNR9Jqc=;
        b=OH1LCKjmXB6BrgfFxJyoFn38p3LGRjiq11ggPnv89i3tROXu1UEnbYYmxc+JvL5OZ7
         eBQA89trQyRhJJkTs42fcYwdCSbF5JG2pW1cWKho9LdtlbvM7fTMltcUVZvH6O7tVao2
         fboL1nhRAjUbG03wddisrNwnHfZ5lna/Wq/oA8Gm4Kzi+PhJxP3VE5F7Os1IRHjwGPLb
         sX76WWwpD0bZwYZa0zBmQ30ajRflF/zK2+M0WgMKl1h9BEYb9YH6TKg7MdS8L+YyYxIR
         oZRfTS5EwTX7+0fjDWSbWfE71/8uI0UrYochMI/RKmKL9rHKfIq5N15Rvtqx2iyGul+I
         w0AA==
X-Gm-Message-State: AOAM531XTEmGU/kqKkNEuABwL/j5U0+IRY8L6IkkSsDs6aAW/Y38/n/k
        GMp5V5ZXSiqHsxh/O3cV79Y=
X-Google-Smtp-Source: ABdhPJz5HQT/5F3ODgZeID6PuqLBe26fEAIMr57W/qTuVp+IPx1rwLYnD1Bpa/8/zbJ7jjZgR2XCTw==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr11896994wmc.141.1632668373619;
        Sun, 26 Sep 2021 07:59:33 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id n7sm14143840wra.37.2021.09.26.07.59.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 07:59:33 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     robh@kernel.org, john@phrozen.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: mt7621-dts: complete reset missing stuff
Date:   Sun, 26 Sep 2021 16:59:28 +0200
Message-Id: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Mt7621 SoC uses reset controller from ralink rt2880.

In order to get 'mt7621.dtsi' file out of staging there are still
some nodes which are not documented at all. This patch series
add documentation for reset controller in ralink rt2880 derived
SoCs which corresponds with 'ralink,rt2880-reset' compatible.

It also align new binding documentation using defined reset bits
along the device tree file itself.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (3):
  dt-bindings: reset: add dt binding header for ralink RT2880 resets
  dt: bindings: add ralink RT2880 resets device tree binding
    documentation
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/reset/ralink,rt2880-reset.yaml   | 39 ++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi        | 23 ++++++-----
 include/dt-bindings/reset/ralink-rt2880.h     | 40 +++++++++++++++++++
 3 files changed, 91 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
 create mode 100644 include/dt-bindings/reset/ralink-rt2880.h

-- 
2.25.1

