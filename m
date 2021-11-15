Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14FC45016D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbhKOJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:34:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:34110 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhKOJeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:34:03 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Nov 2021 18:30:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 93494205C83D;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 15 Nov 2021 18:30:57 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 245293DD46;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 08068B6291;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 0/4] Add clock node and phandles for M10V platform
Date:   Mon, 15 Nov 2021 18:30:52 +0900
Message-Id: <1636968656-14033-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a clock node of Milbeaut driver and clock phandles
to clock consumer nodes.

Changes:
from v1
 -fix wrong property name "clock" to "clocks"
 -add milbeaut MAINTAINERS

Sugaya Taichi (4):
  ARM: dts: milbeaut: add a clock node for M10V
  ARM: dts: milbeaut: set clock phandle to timer node
  ARM: dts: milbeaut: set clock phandle to uart node
  MAINTAINERS: Add entry to MAINTAINERS for Milbeaut

 MAINTAINERS                          | 9 +++++++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.7.4

