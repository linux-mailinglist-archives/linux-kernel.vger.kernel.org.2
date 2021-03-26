Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A45349F39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhCZBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:55:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58441 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhCZBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:55:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B3E15C00CF;
        Thu, 25 Mar 2021 21:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Mar 2021 21:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+3mSUNs7V7gMe
        ZmaZzxh0zwf9felk6kAj/w+6MxYX3k=; b=BcbYSleAIkZjn8PSve/LctqlMRREJ
        XGgCkVPESD5fTFnkMwb0OJok+q6xZLvID46ctcM1DGMMMjrw9bAySLZY83Md9fd8
        lwy09LcJcl5u1GCXGY/43uET+UsutlMAc43wWJ+sg0FoufL3HDU9Y/0AeqniQuGp
        j+VilSGwOUXbirOnovdIbXGPbK5CiCMDitIXGHHuZluNHYtNwQkT1Epao46XeJeh
        V5DlszfEXDPuKUTRlzAk8bVYZVh9WJXnMUw63/RbK8J0OBqLwn0y6ZpKsy/7Wral
        Semub0AVHnc50EtpdsggUpU8Hasgh+e6oB/piJnDsZe4QD0a0PX1QuIGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+3mSUNs7V7gMeZmaZzxh0zwf9felk6kAj/w+6MxYX3k=; b=qzp79U3F
        4FIJfUjyCF1NBytMZ3PWrp6jRPKmVek+PgfNynqRJP5l0iDmxvO1cuamR+5s72iN
        52ySyR/ULEibS8Xak++qXCdk+e0ZgEHPBTJAmS2odKt/nfpUk8JTNQ3/3njezOgG
        J0wKg/Ai1J5yBYRskOthh9bNphSK9Y5huimwNIPZDnUyAkl4OpGNerajlHA4hKF5
        ipjS3v8vi+K3zaD6HmyQSUZerXcR0pdhBWCY3d1XJvJ7Q28YC3Prq1ubckbbgEud
        DxXluHbNwuhvdeYWVayzEbt9CgMbs/fqzYt8DMw7a6Ads2cnrjYv1aNhjyrTXukE
        2NGFjzmrn3gbxQ==
X-ME-Sender: <xms:ED9dYCjG7ufAimWa2O7GPu3T07FDieOKwFvDn2xa1iKdXmIlvD9K0A>
    <xme:ED9dYKdGZFXTVbOXmIm7LD-OUaJGLLfBTrpKub6BN9zrm-GKO-94PSKIPruGlsliR
    TYWe1u3ue8snZbZj_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepudelfedr
    vdejrddufedrvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ED9dYHcnnpsZaWEST2OD8JMWb2bxZG0MtSsRBOAnx0FB45HXl1t5Dg>
    <xmx:ED9dYE87StYFvvnZLRlTtsebbcmdIJ13t4aMosFeTcAqmbBHqNM6Rw>
    <xmx:ED9dYDm2GYh0mJSuPKAa8yPZc8EvzFt45moM0RjdEU25tlX49EKCuA>
    <xmx:ET9dYJNOsTRgezmg5DnCfEB9H4qsG-vdVIpl-H5E84wfzv-RdPUL8g>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2AA91080054;
        Thu, 25 Mar 2021 21:55:27 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 4/5] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Thu, 25 Mar 2021 21:55:10 -0400
Message-Id: <20210326015511.218-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326015511.218-1-alistair@alistair23.me>
References: <20210326015511.218-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v3:
 - Change patch title
v2:
 - N/A

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
2.31.0

