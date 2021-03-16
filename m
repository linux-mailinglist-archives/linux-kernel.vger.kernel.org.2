Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1FC33CB64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhCPC2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:28:09 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53553 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhCPC1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:27:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B61C75809B1;
        Mon, 15 Mar 2021 22:27:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 22:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=92XOOa+ur/a84
        uPShOywvmSC/C/CugKKUW0fdrNwndg=; b=Fd7VVql53um9GCl8jzxZt0QQubNDB
        4fnOvbz4ty/BcAWYja0PX9+3PN8hvj7Ik0DhZpEFMRs7Nkjt2KwZBY7pwgyyFjud
        zIsbhOZiGxHE1W8Y5DVRy16quCzHq2yQDHQThhTkTvDc1cJ9LtPO+Wfyonwmoutx
        9il+diqTZ2ZLhBkZekf9VtGX7OpxyzgaNuj/bSvUvaWaiWRox6GLeovPTXB5r4d8
        cS2YytrcvXoCSGaa+M+nhJBOFcRgnk00p9AE+FowoNAYuFsLprECMmbSIYN4vr4L
        B95ZPiciTeb4R7G1cBPKa7z390Ty2Uyi1ckKP25HxfMkubCLTnf9vxY5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=92XOOa+ur/a84uPShOywvmSC/C/CugKKUW0fdrNwndg=; b=qenBykLh
        VQXwMymrJTEuO6qOMhAz02czWo2v0cFrOFO2BSPdO4umUM0+On2hXgn9ywXu5Evu
        EzXBgkCQAIOXpaW6IiP3nz30IIhBxOoHfd23KufN89lHNMxOxphzdsfpVW4BMCSR
        kpcmhKKFT88ZX45YIyBWKPuxna5gS3H686YQKKZ7sJJoHAiLfUqSZhEnFnt7VQpt
        xadkwCe75WjlHWXaUwtDHrapHOKpRLaBOvEhpOpmxecp6aY5juAj/WTq0Sjs76Ro
        QpYpehV1NNbdq+RNSfKBFPT62Jcnd8R9AP7uUvbk9IfK1+mBqeim86WM3EZ9P1W/
        CMt+BK6CgUpumQ==
X-ME-Sender: <xms:ohdQYIdyrxe4Eu81f1auLYGWWGyVntCGznkN3pZ8gJpjibm4KDiPpQ>
    <xme:ohdQYKMpA6WFvlhuefpfJ42l0wE_6F7LbfI2kz7I8QEyJa1YrB-f0JxnX5_nF_uDV
    ujWn-xYOOxLPdoSWb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepieeirddu
    udehrddukeelrddujeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ohdQYJiEZc036We2MLGoXa3_taQKPpmCEv3u3-j9-WhrnjzU9Ut_Bg>
    <xmx:ohdQYN9wXfoY2KK4xQp0YvVDrUsrNtN85kysKjyY4QkfprUc-CACjA>
    <xmx:ohdQYEstCTmQ0jkvBUxW4fKHOu5FaEABzjANYF5KF9fzkQX1f38kdA>
    <xmx:ohdQYGKHvC4jRaYr0tMSS8LMJXArpB6MQpI-N5eAQN-kTembWci9UA>
Received: from ThinkpadX1Yoga3.localdomain (unknown [66.115.189.177])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30C3D24006C;
        Mon, 15 Mar 2021 22:27:45 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 2/3] dt-bindings: arm: fsl: Add the reMarkable 2 e-Ink tablet
Date:   Mon, 15 Mar 2021 22:27:39 -0400
Message-Id: <20210316022740.132-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316022740.132-1-alistair@alistair23.me>
References: <20210316022740.132-1-alistair@alistair23.me>
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

