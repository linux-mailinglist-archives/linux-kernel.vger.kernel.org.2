Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB6331439
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCHRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:09:57 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOG-0003Gq-25
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:09:56 +0000
Received: by mail-wr1-f70.google.com with SMTP id v13so5096362wrs.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TYM4mQkGBM+Vm5jThXgeurS1WNknTfQQR/nCCTS0TA=;
        b=gTzx3K2LXOvuXaHOjRVSRpCjrZpnwcyud3xtNVQosNOhaSP/XSN/h9NlHMvil0BNOV
         /LfOpe7TdzFGST2hVgcrBaFdZb+iW7GtnRLUWtK9wIhKtCNNNigmU8ETSQNOEDke67Fa
         ohSw5OkqrPgOEv8uw2bcJVAx3v9E15r33AfSnVZjmRKw9JN7Je/SJNHSVX9ywE1ycqDs
         JlroUZ4k/8NceQoOV/nEGIWh9GzlZkyIq/X1Jx9CFG5IbZ4ZE3e5MJjcI2CoZ6KyQDyt
         TgJagtSDyPSwrZa5Y6dtzo2vEfOhEnipVL9BrQP9argQK04igqH+0L1rEdSbUOOxMymO
         TcHg==
X-Gm-Message-State: AOAM531gvtqzAEWJaikvIPqMxm6GFkuqsueZjc/7stQm9BEAbKbAuSHY
        uO2rftBNJDObD/qvOoA1LTEBrJYYcFU3TuSjgbAg34ZZiGlst63opm6Yh9mBJt1f72lHAgvA1PH
        T83xMAV85JbJ7/VrMa8wO47XRp2PLEFJRVIPPCOMAYQ==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr23418916wmd.21.1615223395828;
        Mon, 08 Mar 2021 09:09:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwG+297APszJHmRk5Kfvv6ww1EBrj8jV/78RETfl4fuasWWF0yJAFcdA2rg9uPD8rMJX6gjtQ==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr23418891wmd.21.1615223395569;
        Mon, 08 Mar 2021 09:09:55 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:09:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 00/10] arm64: dts: intel: socfpga: minor cleanups
Date:   Mon,  8 Mar 2021 18:09:35 +0100
Message-Id: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Hi Dinh, Arnd and Olof,

This is just a resend of previous patch.

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  dt-bindings: arm: intel,keembay: limit the dtschema to root node
  arm64: dts: intel: socfpga: override clocks by label
  arm64: dts: intel: socfpga_agilex: move clocks out of soc node
  arm64: dts: intel: socfpga_agilex: move timer out of soc node
  arm64: dts: intel: socfpga_agilex: remove default status=okay
  arm64: dts: intel: socfpga_agilex: move usbphy out of soc node
  arm64: dts: intel: socfpga_agilex: use defined for GIC interrupts
  arm64: dts: intel: socfpga_agilex: align node names with dtschema
  arm64: dts: intel: socfpga_agilex_socdk: align LED node names with
    dtschema
  arm64: dts: intel: socfpga_agilex_socdk_nand: align LED node names
    with dtschema

 .../bindings/arm/intel,keembay.yaml           |   2 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 222 ++++++++++--------
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |  18 +-
 .../dts/intel/socfpga_agilex_socdk_nand.dts   |  18 +-
 .../boot/dts/intel/socfpga_n5x_socdk.dts      |  12 +-
 5 files changed, 144 insertions(+), 128 deletions(-)

-- 
2.25.1

