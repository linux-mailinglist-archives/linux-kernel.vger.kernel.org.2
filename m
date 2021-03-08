Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501BB3315E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCHSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:24:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36017 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCHSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:23:52 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJKXn-0004BD-Av
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 18:23:51 +0000
Received: by mail-wr1-f70.google.com with SMTP id h5so5175821wrr.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KX2v5j7I3zXLrg0qNAwZaGK6w9v9AXVKox7isWJgC+U=;
        b=nCtyYxrDY7Q69L9fYa2LJHXMzzAOq9a5iVwTm/vPisj8rqk4cvzUtz7brE/UPEOxL4
         OC0nlQ3kJeYIza/dGuC1OoOeBDqIQJD1tATUe2RWr1J3gPc1A7PPv+Op5oeVzSAU6qQd
         Ta57D54Tz7c+SNJ04Qrsr5o5eNUX8LpWZBaIDiZ5KhCMaHVO9V31S/uRK5aEHnp7habr
         I9DJ1QBie9tOTQFtXKyI1NPX3M+uGRf3g40neaG36EH08vj/Kb1Oo63lxc/nXX7PNmls
         6faNvP9H4Ny2Fkpl3QzuAKQa8zYDysllcSFn4YEuJ+RkJpNC1AmkKcuQtc8v26FyjRyh
         sTcg==
X-Gm-Message-State: AOAM5309BCvzgxVmIddvYaIyifyedXAnOK58f4Aa8uqJ312Wr1NY61P2
        +uCORJrNnLg2ocfPmMaEjySh9CK2Qj8W3tajcv8A1agVr2KdLT3brLBxl0/edmfeINK1bt9OCql
        hyolNoowaM6tPUxKErn+8hJHIEa8aRk5rZUN3RMy9Qg==
X-Received: by 2002:a1c:cc04:: with SMTP id h4mr108809wmb.142.1615227831051;
        Mon, 08 Mar 2021 10:23:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqgyApwcs5u2d3ykSYzyi7V9lCv6GKyln79Ae5GSas5Vc6LGu56wJ/JTtqVwCRsWeddWuSUw==
X-Received: by 2002:a1c:cc04:: with SMTP id h4mr108796wmb.142.1615227830933;
        Mon, 08 Mar 2021 10:23:50 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id f22sm158207wmb.31.2021.03.08.10.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:23:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RFT 0/3] clk: socfpga: minor cleanups and compile testing
Date:   Mon,  8 Mar 2021 19:23:36 +0100
Message-Id: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A fix, cleanup and finally compile testing for SoCFPGA clock drivers.
I don't expect any functional impact, however please test on real
hardware.

I tested compile builds on few configuratins, so I hope kbuild 0-day
will check more options (please give it few days on the lists).

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  clk: socfpga: allow building N5X clocks with ARCH_N5X
  clk: socfpga: drop duplicated lines in Makefile
  clk: socfpga: allow compile testing of Stratix 10 / Agilex clocks

 drivers/clk/Kconfig          |  1 +
 drivers/clk/Makefile         |  4 +---
 drivers/clk/socfpga/Kconfig  | 23 +++++++++++++++++++++++
 drivers/clk/socfpga/Makefile |  5 ++---
 4 files changed, 27 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/socfpga/Kconfig

-- 
2.25.1

