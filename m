Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB6429A99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhJLA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:56:00 -0400
Received: from mx.socionext.com ([202.248.49.38]:50014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhJLAz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:55:57 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Oct 2021 09:53:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CE33D2059034;
        Tue, 12 Oct 2021 09:53:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 12 Oct 2021 09:53:55 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 602A3B62B7;
        Tue, 12 Oct 2021 09:53:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/5] clk: uniphier: Introduce some clock features and NX1 support
Date:   Tue, 12 Oct 2021 09:53:50 +0900
Message-Id: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the patches to add audio/video clock control for PXs3,
SoC-glue clock source selector for Pro4, and basic clock controls for new
UniPhier NX1 SoC. NX1 SoC also has the same kinds of clock controls as the
other UniPhier SoCs.

---
Changes since v2:
- Remove SoC-glue binding example

Changes since v1:
- Fix dt-bindings to replace spaces from "\t"

Kunihiko Hayashi (5):
  clk: uniphier: Add audio system and video input clock control for PXs3
  dt-bindings: clock: uniphier: Add NX1 clock binding
  clk: uniphier: Add NX1 clock support
  dt-bindings: clock: uniphier: Add clock binding for SoC-glue
  clk: uniphier: Add SoC-glue clock source selector support for Pro4

 .../bindings/clock/socionext,uniphier-clock.yaml   |  6 +++
 drivers/clk/uniphier/clk-uniphier-core.c           | 17 ++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 47 ++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                |  6 +++
 4 files changed, 76 insertions(+)

-- 
2.7.4

