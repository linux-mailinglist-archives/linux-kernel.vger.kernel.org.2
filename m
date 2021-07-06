Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D133BD458
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbhGFMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:08:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51009 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237029AbhGFLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:44:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1330A5C04A5;
        Tue,  6 Jul 2021 07:41:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Jul 2021 07:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=jcXn7Uzs7Rb29QcnVO48/qoLIH
        G3J7H1wv2fWRrP/oQ=; b=U2ZzizyyQqiqcoZCvUd8gsnd9QTb+xxd7FUrQ7wA1j
        1FbrQzCPTMxiLmbn3wtrH34k/B1gFIRfhNgYwE/UCI3vQJLjKvrOZ7ya5Ga3Yzaw
        tWHrLBigmeQgNjXHeH+tBnaHJY+Y2tF2kCzBHD8XEECm952OTsHSsiMXq7M75biF
        leuSVkSc2afkzyG+kacPgqGfpNLGd09aDVUGt/SYJc17rNhBCPYVdSFhdxF3p79w
        ywWBMVVzWZ1j0kI5jq53h1s4J3xIElmCWNGzL3p3jCYvHkTc55HiNbSY9wlSEsMA
        Vst7ocRk8OgfKrUXzTWZ9uYrwK6iKM7xdn7CqcamCU6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jcXn7Uzs7Rb29QcnV
        O48/qoLIHG3J7H1wv2fWRrP/oQ=; b=IUXZ2arTMMEwjqFVNllXBkwHMKrSax0eY
        C9vQzmeXTA8UokUcAWJ4BxHrthx6bTp8A4OSgedqEvnsNDScbX3mL+u+k2T/avrC
        K5VU6Q5JSOoMoBKidM0w6OwA3Ok8hrcUICIAPfGjW01bQr9k978wWZNWcFGZBXTz
        L5MlDw/2uaSllj0BpggZhZ3ra15EpSOlLlrEFim5S80cQmXJB2mq96C4SYZxcSMp
        ySuJi/6I6pQnlWdx3mWeHFnKQSXUiCDe0ur1Dtqg5gVvir4F9Mm2LpZB66qDIANg
        pH2OxAzzzd14bTJCZc86j2vSh1roJ3d1ec05pUIh9M3Q25GUCjMBw==
X-ME-Sender: <xms:a0HkYHEs36pVd8SPMR_TK5yrtzVeyBiJGYysymUL6KAjqhX1Qv4j2A>
    <xme:a0HkYEWOFYE00sCYoX30-kQj61Fpzs40QUtXktSHWLNfu5anKjfkIXLG51S4sXTdr
    1B0GIJNZSwmZicTaM0>
X-ME-Received: <xmr:a0HkYJLp-0jWQ0CyJceXY6DXDt34S2Cj6_h9EnQwtuUW56ypiNWInDUUx6h875-v3SJJH0hR3vEd_QewYnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:a0HkYFELl5q-A8g3e7R9Z67V_2ACKjY6xvrsW3HGOIOLvu0B4QDyAQ>
    <xmx:a0HkYNVbam8c3DWk6xLAgTZz7LSjL0kHA2QYqEFYLW8f_DyTm6_IpQ>
    <xmx:a0HkYAMUDd7Ta-U5bMdrJ1C5XkYxwKUc6k2lsSIBfy8B0nANVQDYTQ>
    <xmx:bEHkYKguU7n2RIxA5dF_KcX8wWKVt4yE6TmAVg909hP8YbvKhX9zUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 07:41:29 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/2] regulator: sy7636a: Remove the poll_enable_time
Date:   Tue,  6 Jul 2021 21:41:19 +1000
Message-Id: <20210706114120.197-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From testing on hardware the poll_enable_time isn't required and
sometimes causes the driver probe to fail so let's remove it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index e021ae08cbaa..c3b34cac8c7f 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -13,8 +13,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/sy7636a.h>
 
-#define SY7636A_POLL_ENABLED_TIME 500
-
 static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 {
 	int ret;
@@ -61,7 +59,6 @@ static const struct regulator_desc desc = {
 	.owner = THIS_MODULE,
 	.enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
 	.enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
-	.poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
 	.regulators_node = of_match_ptr("regulators"),
 	.of_match = of_match_ptr("vcom"),
 };
-- 
2.31.1

