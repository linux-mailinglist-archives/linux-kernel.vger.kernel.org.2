Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFD42D64A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhJNJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:43:31 -0400
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:38218 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhJNJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:43:29 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 19E9WXlx029314; Thu, 14 Oct 2021 18:32:33 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 19E9WLoC025911; Thu, 14 Oct 2021 18:32:21 +0900
X-Iguazu-Qid: 34tKJZBnPUks7DZbff
X-Iguazu-QSIG: v=2; s=0; t=1634203941; q=34tKJZBnPUks7DZbff; m=a1oj5tUy3wwpIzpppPM4Z/BMNDNEME2RrpnL1vlFa0g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 19E9WLWb001384
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 18:32:21 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0ED9D100095;
        Thu, 14 Oct 2021 18:32:21 +0900 (JST)
Received: from enc01.toshiba.co.jp (localhost.localdomain [127.0.0.1])
        by enc01.toshiba.co.jp  with ESMTP id 19E9WKCf024562;
        Thu, 14 Oct 2021 18:32:20 +0900
Received: from enc01.toshiba.co.jp.mid_24808776 (localhost.localdomain [127.0.0.1])
        by enc01.toshiba.co.jp  with ESMTP id 19E9RH4Y021220;
        Thu, 14 Oct 2021 18:27:17 +0900
X-SA-MID: 24808776
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: visconti: Add Toshiba Visconti TMPV7708 VisROBO VRB board support
Date:   Thu, 14 Oct 2021 18:27:00 +0900
X-TSB-HOP: ON
Message-Id: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a device tree for a new board 
with Toshiba's ARM SoC, Visconti[0].
The board system, called VisROBO, consists of two parts: 
VRC SoM and VRB base board.

Best regards,
  Yuji

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Yuji Ishikawa (3):
  arm64: dts: visconti: Add 150MHz fixed clock to TMPV7708 SoC
  dt-bindings: arm: toshiba: Add the TMPV7708 VisROBO VRB board
  arm64: dts: visconti: Add DTS for the VisROBO board

 .../devicetree/bindings/arm/toshiba.yaml      |  1 +
 arch/arm64/boot/dts/toshiba/Makefile          |  1 +
 .../boot/dts/toshiba/tmpv7708-visrobo-vrb.dts | 61 +++++++++++++++++++
 .../dts/toshiba/tmpv7708-visrobo-vrc.dtsi     | 44 +++++++++++++
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi     |  7 +++
 5 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dts
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrc.dtsi

-- 
2.17.1


