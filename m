Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8240466C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352705AbhIIHlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41911 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350893AbhIIHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631173205; x=1662709205;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JwXOYUD0HXBuNjK22OA3wKgiWWPyrSWEyqKe+FxiyRw=;
  b=U84PgxSMItujl28Eq2txD57rg0X6tFma3VRVMkcnQ2qsp/vtgty3ntaH
   JbNhhVC5Au3WYFboMCgAdD1/nytZSpvCIrij1L4AiqkIYgEsG6toB9+5B
   rmd6uE3tq4gydHhk1Np8ZoISQrVdxN1RpDl6PyoAKAv05qxJFu3DMTt+r
   4rvu1XlSmRGXqNUyO68i460vh+HxnFyCgysR7ROuimKif2Zj8p5ma/alm
   ZJB0MNEWD4bGAx7Ga8KfIUw0iFnzprlGzb02ltrxVKkccP93zQUcmfdlr
   milbO0jX5XknMSeqNo8DzSVYbtZQfO6MUlukhiC06GhMTF+472tDAIj/g
   A==;
IronPort-SDR: ggStyoJAzQaZ18R9r+g6qvxJMZqLc2TgdiO8OeTUo0xBd08KtIKL1LVH/VOgRHVi7roIKNPYvl
 ho7cQd7Pu5jysm6j20sqr/1FW06Fzx2VFkp8gOqWAVMOPi8lKWEpCz4TE21bR04XTERgKUjSw0
 //vPvIHkx+ctYwu0CKPptl0D3Ze9ABaauP3nbfZY47hum3BgV40hRjNWTgYccqe1Fv3DWOoxfE
 cpA7PWfiYxJqXucZ7ZCQmTc2t+z+wBvUeQqfc9Vyqgz8FljL7/h02Thq4a2ad8HNVLztkXwzlg
 1Sgsdmhp319hnKcfu5TkcoxK
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="135355301"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 00:40:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 00:40:03 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 00:39:59 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v3 0/3] Add driver for lan966x Generic Clock Controller
Date:   Thu, 9 Sep 2021 13:09:44 +0530
Message-ID: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated license in dt-bindings.
- Updated example provided for clock controller node.

Kavyasree Kotagiri (3):
  dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
    clock IDs
  clk: lan966x: Add lan966x SoC clock driver
  dt-bindings: clock: lan966x: Add LAN966X Clock Controller

 .../bindings/clock/microchip,lan966x-gck.yaml |  64 +++++
 drivers/clk/clk-lan966x.c                     | 235 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 3 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

