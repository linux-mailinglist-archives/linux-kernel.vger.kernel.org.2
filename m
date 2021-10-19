Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5343317C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhJSItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:49:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31029 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634633207; x=1666169207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bk9Tx3zKfcQwMoHRzzbud4bHR6HA4Ny0tNUYxpIIItY=;
  b=i0AUCVrRa5parscvXff+O+n1qWuQP/h5LA1DPZzAn1R2Z75CSnQZaYeo
   BVsn3Gg/d6/GSu2/GzKQIYovuqKgs/LdJZoCBNOjNhPxBio2lq+D7tSIL
   eZNhbkIVOn4LRGzSb6y9vX5Y6Tgn4vnfIfAZul6tVwwdgcVpRXrW6CNbH
   t7G9HVTA97j/wNmdvIPeFn7jvSMdbVSxqAUi5yZEBT3YJboq++6HUz+9v
   IvxIpny4AMDR7vfKWU4YXRRZU6mL/OV57jupQEodQ5htVGeWremZAbbTJ
   ko6VJMxMdjcZfLf1YypZch1+BA4wF6z/4nJaLZMM4JsRbLstgSzYn7oMX
   w==;
IronPort-SDR: YAYSf97tj9pBC6hIEKGAjSBKpwYpd3guEBuzPgsdgAQ0pQe83mtSjVFjM/ylYQqfIjksp6xhqe
 JrRm+2je2Leqi0jfODhPE0oAoAHPq9EPkDvtU7iWiHsZ9ra1+LtoETuuSpVD7/TT7qsvCPpWtl
 amf4PV1Ci9eZeRbG8nYIwmejX7sRjj76XXR0bL9cX8MIj4ZMFRkZLhBiB9vpb9CVf+IfMtUZP6
 r5rEd/BcRuX+gVuCDr2pVZb8psiTEISw78hp9MD1Ty4lpxDKuu9dkjY8XaMR1S3aNAIJLMIioP
 +QEis/29v1cazGZZa3D8muR7
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="136075866"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 01:46:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 01:46:44 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 01:46:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH 0/3] Extend lan966x clock driver for clock gating support
Date:   Tue, 19 Oct 2021 10:44:46 +0200
Message-ID: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on the following series, therefor keep it as RFC.
https://www.spinics.net/lists/linux-clk/msg62237.html

This patch series extend the clock driver to support also clock gating.

Horatiu Vultur (3):
  dt-bindings: clock: lan966x: Extend for clock gate support
  dt-bindings: clock: lan966x: Extend includes with clock gates
  clk: lan966x: Extend lan966x clock driver for clock gating support

 .../bindings/clock/microchip,lan966x-gck.yaml | 13 +++-
 drivers/clk/clk-lan966x.c                     | 72 +++++++++++++++++--
 include/dt-bindings/clock/microchip,lan966x.h |  8 ++-
 3 files changed, 86 insertions(+), 7 deletions(-)

-- 
2.33.0

