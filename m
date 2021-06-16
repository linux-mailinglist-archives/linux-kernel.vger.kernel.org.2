Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B63AA080
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhFPP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhFPP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:57:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840FC061574;
        Wed, 16 Jun 2021 08:55:18 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D5D9C22284;
        Wed, 16 Jun 2021 17:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623858915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yxtyq1V1YWMiD4gkO6icAY55wXSW7H9YNOaGVoLVCrM=;
        b=VyLSba0FUw5S7ox0RkcYmb81ze0itMIEwlc6tjmbxj/t5ULDmYmQsKuStnDH3+SHYW4fIE
        1WqwNjkt0eH75pneVULoX7O+2FE3pJ71MkqdMb++w3/5MRxb1o7CzFRU5I7npFhiXW18bZ
        qPjtYvOx4ElQYXIHI4ryNuCqF97RII0=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH 0/3] ARM: add NAND support to Ebang EBAZ4205 board
Date:   Wed, 16 Jun 2021 17:54:34 +0200
Message-Id: <20210616155437.27378-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Miguel, there is finally a NAND driver for this SoC and we can
now support the NAND device on the EBAZ4205.

Btw. I'm not sure how often the PL35x NAND controller is used in SoC and
if it qualifies to add it to the multi_v7 defconfig.

Michael Walle (3):
  ARM: configs: multi_v7: enable PL35x NAND controller
  ARM: dts: zynq: add NAND flash controller node
  ARM: dts: ebaz4205: enable NAND support

 arch/arm/boot/dts/zynq-7000.dtsi    | 21 +++++++++++++++++++++
 arch/arm/boot/dts/zynq-ebaz4205.dts | 12 ++++++++++++
 arch/arm/configs/multi_v7_defconfig |  1 +
 3 files changed, 34 insertions(+)

-- 
2.20.1

