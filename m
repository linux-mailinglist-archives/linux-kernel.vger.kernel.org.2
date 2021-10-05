Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637F6421C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhJECMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:12:34 -0400
Received: from mx.socionext.com ([202.248.49.38]:40418 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhJECMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:12:33 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Oct 2021 11:10:43 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 30AAD2059034;
        Tue,  5 Oct 2021 11:10:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 11:10:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D7BD2B62B7;
        Tue,  5 Oct 2021 11:10:42 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] reset: uniphier: Introduce some features and NX1 support
Date:   Tue,  5 Oct 2021 11:10:39 +0900
Message-Id: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the patches to add audio/video reset lines for PXs3 SoC
and basic reset lines for new UniPhier NX1 SoC. NX1 SoC also has the same
kinds of reset lines as the other UniPhier SoCs.

Kunihiko Hayashi (3):
  reset: uniphier: Add audio system and video input reset control for
    PXs3
  dt-bindings: reset: uniphier: Add NX1 reset control binding
  reset: uniphier: Add NX1 reset support

 .../reset/socionext,uniphier-glue-reset.yaml       |  1 +
 .../bindings/reset/socionext,uniphier-reset.yaml   |  3 +++
 drivers/reset/reset-uniphier-glue.c                |  4 ++++
 drivers/reset/reset-uniphier.c                     | 27 ++++++++++++++++++++++
 4 files changed, 35 insertions(+)

-- 
2.7.4

