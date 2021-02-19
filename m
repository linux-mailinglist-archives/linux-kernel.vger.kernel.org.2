Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C131F72C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBSKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:13:53 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39921 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhBSKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 27FFF5C00D3;
        Fri, 19 Feb 2021 05:12:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Feb 2021 05:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8CqcAz4OhjeWS
        t8m301mDBQNDC5ZhXRfTbe/yhYAKZg=; b=vGn9KUHpt2Rau3CtLYUyFwmMorDEJ
        QAO9Qr0azSmf+VvbJaoq2xT+ozWMGJ7sY9cmTqRZh4W0AtfQ2y/DwPEEEUlrMhhv
        wxVtX+Axq7i6Rzbr54lOCIce0/HcMthIbtJ63PVUNAi/VKdSiIrXF9p1NEjrkxd1
        4tW5CVa6Bh2Zn6pkm1yJRP3Ao0GLdv6PtnsM0LSmXO0BSPj3n9DSb0zGcsIFOytY
        ThqdcA1bLaFwpUo7iskZ94RMjJwR8CAdTtjLdkfXGyeGJmx/Yv6u/0wUHjQoH7cC
        Z3nNZ9wXzvB1KCJGHMJmNhc64C4WgL8isjd+h54PGy4Glfwndgs6vu+EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8CqcAz4OhjeWSt8m301mDBQNDC5ZhXRfTbe/yhYAKZg=; b=lUHzMLiN
        zTBm6IZ0JNRsTUzUm8THHD6SjQVGS6U96UlekU7Y1fqDQSBUw1AbK4jFHtpIq6bg
        Rir1bl1ji0w8F+aGLfslXaoOGQr8X8xKZy+QBM7DM6uLYNM8b8hmEw6jL2pGG0+D
        O7ZR/uFJZjU0qRIPA+HngFEG51SMm2XYaqNMwaaZreLLOOaz/xDYANLCAEm7xT96
        42GRz1Mb8dkcJqpYraY9VDJ3Tu68xdV26O8fdvwgy1m0ubs+oC3913fAJ0mc7umy
        c/jfumy3kkGQOPLFGXzqcFKtQqN0/G2Jla3b7+zGPhLv6BNJ78FpUgHXzLegrpHC
        JQXoVcbXQcR7yg==
X-ME-Sender: <xms:-44vYNln_VYOMWAWckqGrovHpQPyhtsibhShV8ssQaUvfc1yJ_seWA>
    <xme:-44vYGx1d_WkKniTEezCfaKboZ28qNtXtaZhrDQ3n9tuieyac5V1Y94m8mUGMHoXD
    LXSBsoo6WuVv-uJwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhephghilhhlihgr
    mhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtth
    gvrhhnpeejvdegffeiiedvfeelkedvvdduffevhfeigfeuueejvdfggeefleekudffleff
    feenucfkphepudefvddrvdeftddrudelgedrjeefnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:-44vYF9IXbb6dOFZMR79wZhiu1pUnb0iM3zEU_eL5nlhWsvFMiXGpw>
    <xmx:-44vYCKFFNcZyESmJRX3iiT3wc7CGR1yrL-QsM3HU5KrJUionRSNyA>
    <xmx:-44vYDernh7alU9DQGLKwBvmhfmZiWKPclonEpS9twwvSEswDSk-aA>
    <xmx:-44vYKwvprNYIPww1wKBPEGU_X1wS9kQJx_F0DRm7KMSqaDbW_GtLQ>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7EDF108005C;
        Fri, 19 Feb 2021 05:12:10 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192e: rename shortData to short_data in ba_param_set union
Date:   Fri, 19 Feb 2021 10:12:02 +0000
Message-Id: <20210219101206.18036-3-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219101206.18036-1-will+git@drnd.me>
References: <20210219101206.18036-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a checkpatch CHECK message.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index 4fdff19bb4ae..50e87ab1bbcf 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -29,7 +29,7 @@ union sequence_control {

 union ba_param_set {
 	u8 char_data[2];
-	u16 shortData;
+	u16 short_data;
 	struct {
 		u16 AMSDU_Support:1;
 		u16 BAPolicy:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 07dade37d4eb..1d6fa6cae61c 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -58,7 +58,7 @@ static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 void ResetBaEntry(struct ba_record *pBA)
 {
 	pBA->bValid			= false;
-	pBA->BaParamSet.shortData	= 0;
+	pBA->BaParamSet.short_data	= 0;
 	pBA->BaTimeoutValue		= 0;
 	pBA->DialogToken		= 0;
 	pBA->BaStartSeqCtrl.short_data	= 0;
@@ -107,7 +107,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 		tag += 2;
 	}

-	put_unaligned_le16(pBA->BaParamSet.shortData, tag);
+	put_unaligned_le16(pBA->BaParamSet.short_data, tag);
 	tag += 2;

 	put_unaligned_le16(pBA->BaTimeoutValue, tag);
--
2.30.0

