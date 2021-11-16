Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646334531AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhKPMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235777AbhKPMCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:02:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66E7460FBF;
        Tue, 16 Nov 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637063977;
        bh=jElWUyaPNxsQyv/zmG34jEX9jRDkdynJPTuwlTkXAsI=;
        h=From:To:Cc:Subject:Date:From;
        b=TAz3cYjAl1np9jrAbazIl8lOkM6OCZkk/bKeINo89l+V7Hs5g6RLt3/0CEL+DVnUW
         l04l7Stgal/7E6hdoTu8eRCRRZs2Xf2dCs8d6iMsmm0qXJVuIqaK+dXEObpdVK6mRd
         ZQ74YxvuAYdMby4pbZLM0mMGdNqH5hamwiMOS3ABoOMC0S9IgDRF/6q1PZ4vKkuMUc
         0/DedCjXv0fzhZ0gyCMc0XbkYSEgic+acjYrX0hYcQtsNry82rvgS5GcPJq1a3TF4N
         HE1/DYWXnSh7jNOpiAVZXABTJG7QEC8avxsbvsMzM9+08Eg/WUCwLIQD5kctaD4pNR
         aQHPTd8hKIrEw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmx7e-00A97F-Dz; Tue, 16 Nov 2021 11:59:34 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Hikey960/970 Enable USB and PCI on such boards
Date:   Tue, 16 Nov 2021 11:59:28 +0000
Message-Id: <cover.1637063775.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei/Rob,

Now that all USB and PCI/PHY drivers/patches were upstreamed, the only
remaining bits for USB to work on both HiKey 960 and HiKey 970 and 
for PCI to work on HiKey 970 are the devicetree logic.

Those patches add them.

Please apply.

Regards,
Mauro


John Stultz (1):
  arm64: dts: HiSilicon: Add usb mux hub for HiKey 960

Manivannan Sadhasivam (1):
  arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller
    hardware

Mauro Carvalho Chehab (2):
  arm64: dts: HiSilicon: Add support for HiKey 970 USB3 PHY
  arm64: dts: HiSilicon: Add usb mux hub for HiKey 970

Yu Chen (1):
  dt-bindings: misc: add schema for USB hub on Kirin devices

 .../bindings/misc/hisilicon,hikey-usb.yaml    |  87 ++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 106 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 163 ++++++++++++++++++
 4 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

-- 
2.33.1


