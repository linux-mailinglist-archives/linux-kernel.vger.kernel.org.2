Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3003BD463
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbhGFMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:08:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56797 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237255AbhGFLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:44:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BD3915C04F5;
        Tue,  6 Jul 2021 07:41:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Jul 2021 07:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ORTFWfGfmVDvV
        qUZa5twP/5gAngN/yaaZb97zKQnkXU=; b=mvCXZVexLKcV3a0IuEqxHnXx0bDtx
        4sEt44IAkjaza5Iz0+xtkfvvEYDNIXsvq8nsh63eI+d92HwDefh4HsF8rsI01oAa
        Il6QyewvxBXg34yf2BQmergZzXFdF6Ku02Slv87Xy1YohRRP7QCb+C4+8UfiIFgI
        Wz4w5rIVTHNcpPw/Wxhyu1F8XQVzvEbr7QwT/9oMe4JJ0t9UE9fTp1OISqG+4/yq
        iyp/yimExyqVrDdd5Uv/vHOrR8Qz02TJfy3og+mNa7pod3muqLGIp0vOwW8XVsbm
        XMe8ZFLBk/p04Zk4gOeXHNKfCN7NamRGEURhLudTZ1xdg2IYqTnIHSJ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ORTFWfGfmVDvVqUZa5twP/5gAngN/yaaZb97zKQnkXU=; b=DAQa/3Du
        KJMzP8nRGON2FvWF1EAvJpWssxmMM2JCOlHhEgxZskMuJUMDY4N4+n7smANPT7Uj
        uv7mIuIPR/fnqtUMgsZpuhdO7Eu8qE69Pt1J6RY8VH98eUZHZQqr5ikhuN6N1yC4
        aEKDfHclf1d/uTpqn7o3IKRUswN/vdB/zDO7zDWyif3zPhZXPEliaQQzA2NyJgtx
        yuU032Rn1hlEMkfd6N3l3HsgsCQ1UCp4cetgp9aCOFXXAb2vbjCHMVJpJiU4/ABH
        zUw86/PNsmoGsIsX8hZLytFn9MKh77Z4PP0KLzzWAnoSqtjnLbefL2FQF8SddpRK
        Z8WizbN+LMEPUQ==
X-ME-Sender: <xms:bkHkYB_7cIs9HB8P9a2n-9CDB-42HUMzq3e5dn560BIOYrce6OXPaw>
    <xme:bkHkYFviQouUNpQP3DLU6A9PPQVTQQD0WMi5el9S5G_awLDMDvHtj5PRMd_33XE0A
    prIaXFg3o2EDkrJHVs>
X-ME-Received: <xmr:bkHkYPB6HPCyqxbfgnXAdy5C-rdEbqCwoR4R-AgT3thkllmnlmtf2VG91-6qMyCMVpL9sji1WxqkHzDVQcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:bkHkYFdkt4yPKYMZmzzxzkySvWTZIE3nAAFEfs6YS71OsRzzgbIr5g>
    <xmx:bkHkYGOns9xhE751bm1NO2cqePXbK7Av7SS1TrhnXxf87dt_l1qjhA>
    <xmx:bkHkYHnTCwvk4-f1qV22FhU5hbpAyNF9h7vvC4avQsgDMVeXzB6oVg>
    <xmx:bkHkYPYdOXPelXWguw1Zae0dMsm3eFmkFoZVSsM8-efnYo2ywmNsvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 07:41:32 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/2] regulator: sy7636a: Use the parent driver data
Date:   Tue,  6 Jul 2021 21:41:20 +1000
Message-Id: <20210706114120.197-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210706114120.197-1-alistair@alistair23.me>
References: <20210706114120.197-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the parent's MFD data instead of our data.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index c3b34cac8c7f..ddd7f8e435ea 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -33,7 +33,7 @@ static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 
 static int sy7636a_get_status(struct regulator_dev *rdev)
 {
-	struct sy7636a *sy7636a = rdev_get_drvdata(rdev);
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
 	int ret = 0;
 
 	ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
-- 
2.31.1

