Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9B416EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhIXJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbhIXJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:16:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92EC061574;
        Fri, 24 Sep 2021 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yCzQnI4ZNUlGbsEPcLtNKrcjeXOS4TBz4xCyuD7D7ZY=; b=TygsKBomnnh+mvdd/vpjJYbeUn
        KyEeVyKizy1IGjiUzQgDdGC02TIEc+3edV0aLF1o5aFu7/LC0Iffb7x0iHK5cXtTGuWcrmPscQ6o1
        hnu7ZrGBJgOnrlYXKN0rLA5WxiLGadaIevpQUlyHivp8VS7ELc3JSpKa3X1S6ESJDCnA=;
Received: from p200300ccff0ce8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mThI1-0002OE-6d; Fri, 24 Sep 2021 11:14:41 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mThI0-00AkUL-P9; Fri, 24 Sep 2021 11:14:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/5] ARM: dts: imx6sl / imx6sll: dtbs_check errors
Date:   Fri, 24 Sep 2021 11:14:34 +0200
Message-Id: <20210924091439.2561931-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some errors found by make dtbs_check during adding of new device trees.
These are not all errors, just the ones which seem clear to me now.

Changes in v2:
- style: correct align in operating points

Andreas Kemnade (5):
  ARM: dts: imx: e60k02: correct led node name
  ARM: dts: imx6sl: fixup of operating points
  ARM: dts: imx6sll: fixup of operating points
  ARM: dts: imx6sl: fix mmc compatibles
  ARM: dts: imx6sll: fix mmc compatibles

 arch/arm/boot/dts/e60k02.dtsi  |  2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 26 ++++++++++++--------------
 arch/arm/boot/dts/imx6sll.dtsi | 28 +++++++++++++---------------
 3 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.30.2

