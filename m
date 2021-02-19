Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081A31F732
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhBSKPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:15:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49525 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhBSKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DB255C00DD;
        Fri, 19 Feb 2021 05:12:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Feb 2021 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=B+Q+0feTTa8n4
        k2FOf74aHgyjJK/tdDT8ou8gCaXpFQ=; b=LLvEoBkerk6Fnz9KWKrBkfhn3ledG
        PkFfIJPOl0N62tENucrdssZie1Mwk1t2PcKwYNlqXifXXbFpeJoDkPMeik5jv5XG
        hliOnbbDoun0FPzxlwBta6D+4j8j3CnOg/CWNjYI8VuQPkz5KSini9JSjMYWmFBC
        Q97Y+DIU9nyTp8mjRMrW/jbMyoE9Vc6Lf1pEhkcPyzfl8IrX0wiB9Ne2jb/GGTQ8
        IMwKLcJ5A39RhR8s8IMaTI0Mbmw9n26jWXKtrh304VWt6oHaSUX6ZpqxotAEQqIt
        zurW6YnXXS5qTSXQBIzoGEcIVp8s3QynDjpuf+F8ZMQv7S+i92cyarBFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=B+Q+0feTTa8n4k2FOf74aHgyjJK/tdDT8ou8gCaXpFQ=; b=kmGPQSBX
        1cwqFb9k9kui3t6PBA349EVJv7tR/oLdqd394tunLFFk2tkpkjfC53nArFquRTa+
        88JCItWvwJ/RveL0hXNZR6NDKc8/xDwNd0kfU9luMU+BUXz33ZIjGOFjEkK0p4d2
        SRCEL+pFoqlfhmZNcf3+UWoh7hLoYBgKiPskq/u+TmquIiYf4jQS+gWCWUmdOrxs
        ZBRiJM7XeT3arYJlZ+rdHqlWWi05q5Sxzkp9b4MXiPwEp5BoUEpikokD7g1aiQoi
        7tQ1TiDCCiAD89LQdZ702+2/SZPflgFlNq9JUOtB9glwIw2HgsuwVEOWo2nx2fru
        NKOm+0pO8OnVKg==
X-ME-Sender: <xms:_Y4vYJ0SU9o0X9gZp8ng2uGhD82W6UUtHS8rpWlTAkiwBF7P48sPPQ>
    <xme:_Y4vYKsqVGg0mVuoNO9sV3c4CQIxDR5qd7Xc-CSYrHvW_SG6RYofn5cpoiFu-7ddB
    yYlfidC8r_VhLMDeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhephghilhhlihgr
    mhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtth
    gvrhhnpefhjeelheehvdfgkeffieduieefffekleevudeuleffueevkeejveetgefhtdef
    gfenucffohhmrghinhepfhhivghlugdrsggrnecukfhppedufedvrddvfedtrdduleegrd
    ejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeif
    ihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:_Y4vYP6CcbvzOI3qnPS-Exnc-L87abqQa8It4lo6Q-v6A10aJxPz1Q>
    <xmx:_Y4vYGf2M5pggqjr3aDWESi-xHTzjJmRj32UK2ikT1ecHxSg6r1GAw>
    <xmx:_Y4vYMxaQEge3Q18EFGY1PVacvBOtTFDuckfKp-8NGc8-SxNPRpLCA>
    <xmx:_Y4vYJvOjk8BYL1hBvymuy4N4nEj6JmObKkD5B9lGAXv_GlCwVPBGg>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8EDE7108005C;
        Fri, 19 Feb 2021 05:12:12 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8192e: rename AMSDU_Support to amsdu_support in ba_param_set union
Date:   Fri, 19 Feb 2021 10:12:05 +0000
Message-Id: <20210219101206.18036-6-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219101206.18036-1-will+git@drnd.me>
References: <20210219101206.18036-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change does not fix a checkpatch issue but it is more consistent
with the rest of the union.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index af25b4850975..1a8ca249ed23 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -31,7 +31,7 @@ union ba_param_set {
 	u8 char_data[2];
 	u16 short_data;
 	struct {
-		u16 AMSDU_Support:1;
+		u16 amsdu_support:1;
 		u16 ba_policy:1;
 		u16 TID:4;
 		u16 buffer_size:10;
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 17520fcbc1bb..002ec9a7a8c0 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -483,7 +483,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	DeActivateBAEntry(ieee, pBA);

 	pBA->DialogToken++;
-	pBA->BaParamSet.field.AMSDU_Support = 0;
+	pBA->BaParamSet.field.amsdu_support = 0;
 	pBA->BaParamSet.field.ba_policy = Policy;
 	pBA->BaParamSet.field.TID =
 			 pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
--
2.30.0

