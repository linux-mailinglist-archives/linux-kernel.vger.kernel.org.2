Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742CB34455E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhCVNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:17:15 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37839 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232608AbhCVNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:09:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3BD10580E68;
        Mon, 22 Mar 2021 09:09:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 22 Mar 2021 09:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=92XOOa+ur/a84
        uPShOywvmSC/C/CugKKUW0fdrNwndg=; b=RgMrRXhW480+EUAEC+yuXUjP8NxJG
        M50OIz5d6bJp4OtTSQQ00bZ3R7ta2TVSaTM9eEoHFTg3SiSd/cor1VUlndwfkfGe
        UK/B0rOp0vrMst3zGGvQJb3GOpKJ+zUxJt2i7ozLtAokSw9vER7d/BLFjSqjMgWG
        vKeEd1SkIlA0NW+PoNSi3xa4KcATGDZZ/A42OWrhbzte7qNgoDJIbn0qsAp24n59
        5ba4RJuP4FKwN8M1Crlc29qRif3kWYTpTO0ZFwvXliMZm7ezvfDCSlRxgDsQZpHj
        c6y0hivTXgEp6zW23NkF0iKBkhw0FOdvN8WjY3S7iMYG9GpNlXnu0Sx/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=92XOOa+ur/a84uPShOywvmSC/C/CugKKUW0fdrNwndg=; b=I3CnByTm
        lz5gZEuyB4faxP1MTQH1hMh2VVxPEXoNgHkLvzpVxbtafSAhq8jxYOiRPc5pAeVp
        6QMJVeuPVOrcAPjGBD2kEJ2UdFRtdvXuOuv6ihdefdCd7A9UUJShw+UiLuRYL9H9
        UG0kCnk0J1EhKk5knpHNC471vWd9NtsRWuO7YqW1qda+WzTt5sf6B4ilsCBiJTUT
        /lLmUGGyrSmvKtlvHe3bIHcoYDTj8DNLJHSJeqi6kE/6fdYN/P7GXS4Voph+QmlY
        IuKOHdCy9i5QV9UMi42po1GHwA4CPFPZase4Qu0ALACVDXCoYMMpdqIpS/d9BfCN
        j26c+hDRd71K2Q==
X-ME-Sender: <xms:DpdYYFbE2LR5_uZcmkjb0-OeadZb9dTxGdfxXMRsPICcJl1njOKZYA>
    <xme:DpdYYMVdbrwp7xWOkjgzZ9yD36Gw0dd61-LiU1O2V6Uq_9elu02GHqWBa4hAzlATf
    iYSY61jqsklIFLrwaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepudelfedr
    vdejrddufedrvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:DpdYYE3g_UsBS1qFywZ9zAwEV_ae7wPniO972c6VrcOxy7ruVnHKNA>
    <xmx:DpdYYLabRME3mlJGKnnEIx0GNvyvrvgKX1j61xKndxMmGgOMF-O1NQ>
    <xmx:DpdYYPrZ4lwjnt3A5waDRC2WT8YBt76gnAy2U_uBFthOm0kKeqxeAg>
    <xmx:D5dYYNF0eBOtYXVCCU1AmGIV2UPKUDjoJnSw7Vdiy-D6MIGqvp55Sg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id B63071080066;
        Mon, 22 Mar 2021 09:09:32 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 2/3] dt-bindings: arm: fsl: Add the reMarkable 2 e-Ink tablet
Date:   Mon, 22 Mar 2021 09:09:26 -0400
Message-Id: <20210322130928.132-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322130928.132-1-alistair@alistair23.me>
References: <20210322130928.132-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f45db8..d139440c86b6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -617,6 +617,7 @@ properties:
               - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
               - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
+              - remarkable,imx7d-remarkable2  # i.MX7D ReMarkable 2 E-Ink Tablet
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
               - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-Nymph
-- 
2.30.1

