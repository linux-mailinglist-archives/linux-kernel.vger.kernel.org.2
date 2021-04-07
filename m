Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0843561D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbhDGDT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:19:26 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:37828 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348294AbhDGDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:19:20 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1373Im4f012009; Wed, 7 Apr 2021 12:18:48 +0900
X-Iguazu-Qid: 34tKsSMCifwFP2m4qR
X-Iguazu-QSIG: v=2; s=0; t=1617765528; q=34tKsSMCifwFP2m4qR; m=3Rg2dNMK+BiYMP+O60RfHf8tcAtN0nkQ49kntlaEmj4=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 1373Ilsc040172
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Apr 2021 12:18:47 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 47E8C1000BC;
        Wed,  7 Apr 2021 12:18:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1373Iksc020194;
        Wed, 7 Apr 2021 12:18:46 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 0/3] PCI: dwc: Visoconti: PCIe RC controller driver
Date:   Wed,  7 Apr 2021 12:18:36 +0900
X-TSB-HOP: ON
Message-Id: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Nobuhiro Iwamatsu (3):
  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
  PCI: dwc: Visoconti: PCIe RC controller driver
  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller

 .../bindings/pci/toshiba,visconti-pcie.yaml   | 121 ++++++
 MAINTAINERS                                   |   2 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-visconti.c    | 358 ++++++++++++++++++
 5 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

-- 
2.30.0.rc2
