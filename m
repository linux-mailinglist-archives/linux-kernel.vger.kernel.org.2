Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE60E430D78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbhJRBcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:32:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:16497 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242964AbhJRBcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:32:19 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:30:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id F2D552059034;
        Mon, 18 Oct 2021 10:30:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:30:08 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B1509B62B7;
        Mon, 18 Oct 2021 10:30:08 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] regulator: Introduce UniPhier NX1 SoC support
Date:   Mon, 18 Oct 2021 10:30:03 +0900
Message-Id: <1634520605-16583-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the patches to add basic support for new UniPhier NX1
SoC. NX1 SoC also has the same kinds of controls as the other UniPhier
SoCs.

Kunihiko Hayashi (2):
  dt-bindings: regulator: uniphier: Add binding for NX1 SoC
  regulator: uniphier: Add USB-VBUS compatible string for NX1 SoC

 .../devicetree/bindings/regulator/socionext,uniphier-regulator.yaml   | 1 +
 drivers/regulator/uniphier-regulator.c                                | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4

