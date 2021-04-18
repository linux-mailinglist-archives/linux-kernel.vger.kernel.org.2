Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A7363DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhDSIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:19 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44981 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233403AbhDSIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 36E2A5C0107;
        Mon, 19 Apr 2021 04:40:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=d8z0gS8HZr/N5
        ++6diSc7wdo4fZw0ZGyLBL09kv+EHg=; b=GZcuj/C/VVcquzX4QAS+0GcU7h01w
        K7AjqT1SKgdN7QBzmHuMoIN875IJiq7YB26/tEM/EEP3ElLKEcc+y282lxGCSPtA
        mdmtmdAAdsWAR10HRuWbU7nOTP/G1LLjf5+imbovMl9GuHDs7PwuX/1rKggWBaxU
        xPQ4+6/qJnB3vJX4PEfFHhRCFXQKQ83ePPsCRszehML5oaK+tfJ/3Bmk3wXoUt0S
        iL4LznrlSyXLMr0lUiGWBY+7Az9F0gXtxUCN+PWBXZBXeYvLKjCRQKmpKjc4G7RW
        OIanlO0iIQXrEgINvii1UGyZ/1WUWPP0l348jOtV/7SDeQMPcm3iVvvsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=d8z0gS8HZr/N5++6diSc7wdo4fZw0ZGyLBL09kv+EHg=; b=IY0fPBRI
        xLdtlfvhAMJwYZ/TVNW/ACrDcnxAoBI/AtXxLd/wn2/JreFN+mmUQ5tgipZMwHug
        0BcelB7BOeF0RT/z1JH5KWKGOQOuT8uOgP7SdYTe9BNUFvCFQ2c9PdHCldNtvZrw
        OoHP0FiTdPcEqgX68e9ZW8XE1asWK+cXd4KNAk9fTvXpELypuZz9wJa21HFUfg9I
        ettgCZzxacjVAJm1CElTCZKZlDK3YHCBM3eWWkwgklCbNGKlagCoiCIZ1/tlg5Mx
        kFd3IFd4aSXN829oSVn7OOMH7wOCm2ymtcrmN9/Y3j1NZf5Qfif9Chd+3ShLBLcQ
        mzGZnBtbNTEUjA==
X-ME-Sender: <xms:EEJ9YHSNGmHiNI0yjGJhI4dKpPM5UKvxr3J5qwj2SSRHgMIeFmrvwA>
    <xme:EEJ9YIyOSnppKckadLg7NwDyU1l7BoFahzJ7vN8hjCG99CGYT4CSyDfucGeeQPLU_
    MZME-pm7REzYVr9rbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepkeelrdeg
    gedruddtrdduvdefnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:EEJ9YM3RQNYQ8XfK-fyaZ_UxLpcm9vXPHnpWnFnob0ySJm9hxtt4Tw>
    <xmx:EEJ9YHDu9umni8ryBYALgv-5FHIYV2s_ZmsXdsHxWFPuMY3pfG8OaA>
    <xmx:EEJ9YAjq36PHiww0B9L09wmJx9wI3RWunyPqAOMkHohrTp2sVx7leA>
    <xmx:EEJ9YLU31iAVRxBHHjZ6qQxt1Ol04SL2T0X0YnWhLIbgFPS4za5C2A>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9935A1080057;
        Mon, 19 Apr 2021 04:40:44 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 4/5] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Mon, 19 Apr 2021 07:02:21 +1000
Message-Id: <20210418210222.2945-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418210222.2945-1-alistair@alistair23.me>
References: <20210418210222.2945-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cd80e85d37cf..bafd1d7b4ad5 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -245,6 +245,7 @@ CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
+CONFIG_MFD_SY7636A=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
@@ -255,6 +256,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

