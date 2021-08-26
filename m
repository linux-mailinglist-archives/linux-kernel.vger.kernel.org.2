Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCC3F82D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbhHZHEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:04:30 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:49926 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZHE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:04:27 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 17Q73cRR007240; Thu, 26 Aug 2021 16:03:38 +0900
X-Iguazu-Qid: 34trLrrEFS3VOkNjG4
X-Iguazu-QSIG: v=2; s=0; t=1629961418; q=34trLrrEFS3VOkNjG4; m=ID4ovHPKXulDD5XaFmvlEYgDdEIabD489lCMhbVfybo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 17Q73b6f017917
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Aug 2021 16:03:37 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 7F7EF10016E;
        Thu, 26 Aug 2021 16:03:37 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 17Q73bBT002403;
        Thu, 26 Aug 2021 16:03:37 +0900
Date:   Thu, 26 Aug 2021 16:03:36 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: clk: visconti: Initial support Visconti SoC for v5.15
X-TSB-HOP: ON
Message-ID: <20210826070336.wr3gskwsgeuwii5d@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
tags/clk-visconti-5.15

for you to fetch changes up to a2bb51ea38e5551dcc84695aaf6e1b5a3aea9efa:

  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller (2021-08-26 15:23:16 +0900)

----------------------------------------------------------------
Visconti clock changes for 5.15:

- Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
- Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
- Add support common clock driver and reset driver
- Add entries for Toshiba Visconti PLL and clock controller

----------------------------------------------------------------
Nobuhiro Iwamatsu (4):
      dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
      dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
      clk: visconti: Add support common clock driver and reset driver
      MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller

 .../bindings/clock/toshiba,tmpv770x-pipllct.yaml   |  57 ++++
 .../bindings/clock/toshiba,tmpv770x-pismu.yaml     |  50 +++
 MAINTAINERS                                        |   3 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/visconti/Makefile                      |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c               | 232 +++++++++++++
 drivers/clk/visconti/clkc.c                        | 220 ++++++++++++
 drivers/clk/visconti/clkc.h                        |  75 +++++
 drivers/clk/visconti/pll-tmpv770x.c                |  85 +++++
 drivers/clk/visconti/pll.c                         | 369 +++++++++++++++++++++
 drivers/clk/visconti/pll.h                         |  63 ++++
 drivers/clk/visconti/reset.c                       | 111 +++++++
 drivers/clk/visconti/reset.h                       |  35 ++
 include/dt-bindings/clock/toshiba,tmpv770x.h       | 181 ++++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h       |  41 +++
 15 files changed, 1528 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
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


