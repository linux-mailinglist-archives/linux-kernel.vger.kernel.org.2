Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890334455D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhCVNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:17:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40133 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232538AbhCVNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:09:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9B3D1580E66;
        Mon, 22 Mar 2021 09:09:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Mar 2021 09:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=2fR5y46qj1Pumlm7W0usPS7NWH
        t0hwprR9UyPY36VBQ=; b=oVoWwel5o8kZ483H6c+uFuxubQEX3VaIOVxKkiS6Ri
        rY43hsgGZp8hu3LIFC6BV4kumq18nvz4eJk8A7czEN0oibfLvGH17ZsU0ANnDwOZ
        jfajfh6xfmAZMnsJwEPEjZwEwmhpLSakjS+uswfDGvySUw67z+iI9y3m4C8MEP3A
        oGSO2v2e8k/QPTdqyutXmCI4Dfv631CRf4L/XgmC5h0XooNZqrwfEaHmvOkeYrbS
        zn7JOkEWutRk5SFNJGxE0P9hs35UakUCvodJVEqDeUtCIdmWtSv1ESbPO0XLexhh
        PiAIbzVO5QE2FMF009ek6vTxp2wIYVrULN3H0fb3ZGPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2fR5y46qj1Pumlm7W
        0usPS7NWHt0hwprR9UyPY36VBQ=; b=dxt3zY2ErZFhvMh5+MmC//BnovngGJ3TA
        brTC3jAI9bnj9zmrVYIXFy+eIalQVoBW3gLEvL9zhISM+Y/80DXUFKiyTXWtgyP5
        ZPj1xwuUKFPUV/2xkTtDA4c1lyaeWkUHdVAyNqvxzSqi3LPzqzt04FlQCXq3v6a5
        PTDmRgN493hxoWtccrBSHFSflbewZcTZay6SxvQgbqa9by6eS95sDopbMKjx4w5/
        CvQakrqfZBcQeSf7akD8v9ekw/BBzfTHMS39DhA2dHUqzm4F41WBgPnt6+ccahX3
        feMUxmbi7+xZiaZj2UpS1IsCU8AyhmbpXwZVjtinzQuPoG3bJDWBQ==
X-ME-Sender: <xms:DJdYYJvWvRWBSURf-hOCLjeH6ThOWdqRZFhBfWVbNRBkbRC5G6EXFw>
    <xme:DJdYYCYj_Xk9zsrLGpathp-q3e_T1MIWyC269He5_L4CNKeGmQhfiw8D59yOaMQ0E
    fWOxdYmC-XX-GfTch4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucfkphepudelfedrvdej
    rddufedrvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:DJdYYJoQiVplTIBoWpKdzzzM9WuzqrSrTaB9AJWcpCMEK7Q5Y6YM3w>
    <xmx:DJdYYH9a6Uzaqc-mq40CifrPCAJpuqXwPARRkKDJ0Q3SgKIGAI3eNg>
    <xmx:DJdYYI-rvAT9JgG4ifu_qTVipDwBoN0sBeOTLYe0EZQFvKXpiVH0RA>
    <xmx:DZdYYNp33qQ3eMvmB3BMuPk9zO_sVV0GMHr9mzbYErrLGMCGLxlDUQ>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40DCF1080069;
        Mon, 22 Mar 2021 09:09:31 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 1/3] dt-bindings: Add vendor prefix for reMarkable
Date:   Mon, 22 Mar 2021 09:09:25 -0400
Message-Id: <20210322130928.132-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reMarkable AS produces eInk tablets

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..a8e1e8d2ef20 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -932,6 +932,8 @@ patternProperties:
     description: Unisoc Communications, Inc.
   "^realtek,.*":
     description: Realtek Semiconductor Corp.
+  "^remarkable,.*":
+    description: reMarkable AS
   "^renesas,.*":
     description: Renesas Electronics Corporation
   "^rex,.*":
-- 
2.30.1

