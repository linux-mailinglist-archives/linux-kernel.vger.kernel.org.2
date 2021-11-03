Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC044471E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:34:15 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52969 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229654AbhKCReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:34:13 -0400
X-IronPort-AV: E=Sophos;i="5.87,206,1631545200"; 
   d="scan'208";a="99379490"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2021 02:31:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2F48540B5168;
        Thu,  4 Nov 2021 02:31:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] RZ/G2L SCI support and sh-sci driver update
Date:   Wed,  3 Nov 2021 17:31:24 +0000
Message-Id: <20211103173127.13701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series updates binding doc to support RZ/G2L and 
adds support to perform deassert/assert in sh-sci driver.

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: serial: renesas,scif: Make resets as a required property
  dt-bindings: serial: renesas,sci: Document RZ/G2L SoC
  serial: sh-sci: Add reset support for RZ/G2L SoC

 .../bindings/serial/renesas,sci.yaml          | 43 +++++++++++++---
 .../bindings/serial/renesas,scif.yaml         |  1 +
 drivers/tty/serial/sh-sci.c                   | 50 ++++++++++++++++---
 3 files changed, 81 insertions(+), 13 deletions(-)

-- 
2.17.1

