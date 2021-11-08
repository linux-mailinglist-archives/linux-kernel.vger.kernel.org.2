Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E20447D09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhKHJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:48:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:62305 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhKHJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:48:01 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Nov 2021 18:45:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 29BB2203F6D9;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 8 Nov 2021 18:45:14 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 0624FB62B3;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id DF230B6291;
        Mon,  8 Nov 2021 18:45:13 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 0/3] Add clock node and phandles for M10V platform
Date:   Mon,  8 Nov 2021 18:45:10 +0900
Message-Id: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a clock node of Milbeaut driver and clock phandles
to clock consumer nodes.

Sugaya Taichi (3):
  ARM: dts: milbeaut: add a clock node for M10V
  ARM: dts: milbeaut: set clock phandle to timer node
  ARM: dts: milbeaut: set clock phandle to uart node

 arch/arm/boot/dts/milbeaut-m10v.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.7.4

