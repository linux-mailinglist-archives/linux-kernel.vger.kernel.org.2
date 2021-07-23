Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16DA3D357E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhGWG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbhGWG7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A11CE60F02;
        Fri, 23 Jul 2021 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627026012;
        bh=OL8dCFXVHZ6IGGcIwpxKI/zg3sNOpblUin1Ka6UUq+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=tVM5nXhPD+1vNVuzcLxcdN46lI/6zX+oUcDFcB3VmzBSEhqmS3Zr9l70QZ/6tYoMn
         jjXPxNDKpuGwBM/FssJm7fWqcSF/Z1pBn3/LrKIdBt8ax1wu9iMmH4NspMW/RQM+sN
         REp4oCWdHHZTyFsCQRliY5kwOfWK8Awi0yFsxiZB3jtG8VQdKcRy7ca7AuK1iMeOA4
         w8hnVKvfG4J1qCf5TU81Wz8jszpQ4BiwE2/DChO01wZTbTKzIqkOyQV1cy9UXbOOW/
         8+ryhZYNJ5wkqdYy8nQ1lcIMn/Enrk5MKT8BfBGJR+0pICo+mOQ8vZCOzd4MhqL/xx
         n3YLWzclGhmZg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6pn0-00A6vF-G8; Fri, 23 Jul 2021 09:40:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v15 0/3] Move HiSilicon 6421v600 SPMI and USB drivers out of staging
Date:   Fri, 23 Jul 2021 09:40:05 +0200
Message-Id: <cover.1627025657.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Those are the remaining patches needed for USB3 to start working on HiKey 970.

I would prefer to have those merged during this cycle, as the PCIe patchset
currently under review depends on patch 1 and 2 of this series.

So, I dropped the cleanup patch from this series, due to a merge conflict with
the regulator's tree. I'll re-submit it against the mfd tree after the merge window. 

Mauro Carvalho Chehab (3):
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 136 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 ++++++++++++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  86 +++++++++++
 drivers/mfd/Kconfig                           |  16 +++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                |  72 ++++++++++
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 ---
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   |  72 ----------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 136 ------------------
 15 files changed, 484 insertions(+), 257 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml

-- 
2.31.1


