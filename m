Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3107633A44B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhCNLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhCNLCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:02:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6460AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hb/R5EmTCWcC7fN5ruuEXux4idHLiI2Ik4ejDDOKvw8=; b=hwqlbyL7rzkVrCvNNhFzRAh5bH
        hqRBcsVK/3aj3BF88MbgwbuS1GyL2iFquky5u3Ilu5Y+WPTVCH72YX4XUETh96dVlYYGYO5o3jNwA
        LTTD0ukaG8H5i+7NRHfrBDKl/eePr3vJVVGs6tkuZb6gA2LK3IeV5b6GfIRht+qRWTT0=;
Received: from p200300ccff4d09001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff4d:900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lLOWA-0003bA-H9; Sun, 14 Mar 2021 12:02:42 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lLOW9-0001Ls-9U; Sun, 14 Mar 2021 12:02:41 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: rn5t618: Do not cache various USB related registers
Date:   Sun, 14 Mar 2021 12:02:36 +0100
Message-Id: <20210314110236.5149-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These register get reset to their OTP defaults after USB plugging.
And while at it, also add a missing register for detecting the
charger type.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c       | 3 +++
 include/linux/mfd/rn5t618.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index dc452df1f1bf..6ed04e6dbc78 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -45,8 +45,11 @@ static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 	case RN5T618_INTMON:
 	case RN5T618_RTC_CTRL1 ... RN5T618_RTC_CTRL2:
 	case RN5T618_RTC_SECONDS ... RN5T618_RTC_YEAR:
+	case RN5T618_CHGCTL1:
+	case RN5T618_REGISET1 ... RN5T618_REGISET2:
 	case RN5T618_CHGSTATE:
 	case RN5T618_CHGCTRL_IRR ... RN5T618_CHGERR_MONI:
+	case RN5T618_GCHGDET:
 	case RN5T618_CONTROL ... RN5T618_CC_AVEREG0:
 		return true;
 	default:
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index fba0df13d9a8..8aa0bda1af4f 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -188,6 +188,7 @@
 #define RN5T618_CHGOSCSCORESET3		0xd7
 #define RN5T618_CHGOSCFREQSET1		0xd8
 #define RN5T618_CHGOSCFREQSET2		0xd9
+#define RN5T618_GCHGDET			0xda
 #define RN5T618_CONTROL			0xe0
 #define RN5T618_SOC			0xe1
 #define RN5T618_RE_CAP_H		0xe2
-- 
2.29.2

