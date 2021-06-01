Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36C396CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFAFc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:32:58 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:37238 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFAFco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:32:44 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1515Uoah003175; Tue, 1 Jun 2021 14:30:50 +0900
X-Iguazu-Qid: 2wGrbz1dNdizgTkdja
X-Iguazu-QSIG: v=2; s=0; t=1622525450; q=2wGrbz1dNdizgTkdja; m=mIZLztjuKnQq8Caa1gB4JPLYqjV9QtiaARAly0kxN5U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 1515UkOU010224
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 1 Jun 2021 14:30:49 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id CCDAF1000A6;
        Tue,  1 Jun 2021 14:30:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1515UkZY008240;
        Tue, 1 Jun 2021 14:30:46 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 0/4] clk: visconti: Add support common clock driver and reset driver 
Date:   Tue,  1 Jun 2021 14:30:33 +0900
X-TSB-HOP: ON
Message-Id: <20210601053037.233573-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is PLL, clock and reset driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

  clk: visconti: Add support common clock driver and reset driver
    v1 -> v2:
       - Fix warning with W=1

  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV7708 SoC
    v1 -> v2:
       - Update subject.

  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV7708 SoC
    v1 -> v2:
       - Update subject.

  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller
    v1 -> v2:
       - no update.

Nobuhiro Iwamatsu (4):
  clk: visconti: Add support common clock driver and reset driver
  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti
    TMPV7708 SoC
  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti
    TMPV7708 SoC
  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller

 .../clock/toshiba,tmpv7708-pipllct.yaml       |  49 +++
 .../clock/toshiba,tmpv7708-pismu.yaml         |  50 +++
 MAINTAINERS                                   |   3 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/visconti/Makefile                 |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c          | 249 ++++++++++++
 drivers/clk/visconti/clkc.c                   | 219 ++++++++++
 drivers/clk/visconti/clkc.h                   |  75 ++++
 drivers/clk/visconti/pll-tmpv770x.c           |  96 +++++
 drivers/clk/visconti/pll.c                    | 373 ++++++++++++++++++
 drivers/clk/visconti/pll.h                    |  62 +++
 drivers/clk/visconti/reset.c                  | 111 ++++++
 drivers/clk/visconti/reset.h                  |  35 ++
 include/dt-bindings/clock/toshiba,tmpv770x.h  | 181 +++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h  |  41 ++
 15 files changed, 1550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv7708-pipllct.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv7708-pismu.yaml
 create mode 100644 drivers/clk/visconti/Makefile
 create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
 create mode 100644 drivers/clk/visconti/clkc.c
 create mode 100644 drivers/clk/visconti/clkc.h
 create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
 create mode 100644 drivers/clk/visconti/pll.c
 create mode 100644 drivers/clk/visconti/pll.h
 create mode 100644 drivers/clk/visconti/reset.c
 create mode 100644 drivers/clk/visconti/reset.h
 create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
 create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h

-- 
2.31.1

