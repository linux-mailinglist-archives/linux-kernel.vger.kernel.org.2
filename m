Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765C231F72F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBSKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:14:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56401 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbhBSKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 686FE5C00DE;
        Fri, 19 Feb 2021 05:12:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Feb 2021 05:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8wWt+QaCRuvhJ
        jZdZ5q+HJZUxBW2732UrgjAA6FOeKo=; b=lx57ihM5UDpLPZBxD1DdCmkgVSLJ4
        wkdk8oDr2fMK39BeF83VCzTtVEgvp9Gj02neVAmGPJRYJyVcJOYKCyJmODqWIrZl
        kEKWju7VAUGxKNoKKOFzuFg4A5Ko7WUpmwgqa7cIUTzlykKFc3s+lhPKx+RobPxW
        EINPLVCrbEG5c2NGMggCZmRwO7Q6t2e88Qe602pGDctHikldm8RtK8Bk/qWLQEBD
        waGqdWMnMxO76yzVCSsJqdrv/HnaGSj0LytpM71Adti42/jqggqlUnQR4pu3qxMv
        sHPyvOZKCp7ixXQ+OY2OZGwxidHjfDIL+qdR7zZX45NZ7Px9V9UXAXu6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8wWt+QaCRuvhJjZdZ5q+HJZUxBW2732UrgjAA6FOeKo=; b=jpe7F7xZ
        9dgKqFXOn8n1qf+Ku+TdTlIn2sxjpkXcfV9j4BcySTjT3KqipFAyqzry383+suuP
        UamxegC7w/nW5hhNuHav3blkvVuDnk6vPns2ERCTVdhc782VGxkpb3O20K9tLyHn
        YcC1oLnbbKRCVqjJIhXY50U0jZebr5hqEDkY6ZQxUvqnTUFPL0IWa0A7r8uST5QG
        T5nGTxLo4TX2CaH7EOpzAivR8gjci8FYU5tlvQoaIjkrJnjlxxT3dle7QEWdtiYr
        m8q0PvYf4MKJ0Sd5Va669z6ZpYbJscDI1bhtqIz3drMtDuY1K+5uokp94fx8xef2
        in8HKcxU5p0Z9w==
X-ME-Sender: <xms:_I4vYKGo2y50Vp3-sOn2rPVzg005-3yAGw0LF1tJJyktclyM9ts9hg>
    <xme:_I4vYFbSwLGME8JB18gc9XsBBufFI4UBzNLhcyu2ZS_mW70cQkFITJk3797DcfU6T
    2dBGVMPB9mN5B6Gpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhephghilhhlihgr
    mhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtth
    gvrhhnpefhjeelheehvdfgkeffieduieefffekleevudeuleffueevkeejveetgefhtdef
    gfenucffohhmrghinhepfhhivghlugdrsggrnecukfhppedufedvrddvfedtrdduleegrd
    ejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeif
    ihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:_I4vYEAuNdvSmG1eu_wKJHyN6AA86Iu8xTVVmB8Vwh8DlGXUouZXsA>
    <xmx:_I4vYFksm85srb8FFy8_cQ2sp_8S40giN2XijyN4fxFLMiRUs-FPLQ>
    <xmx:_I4vYNyVggVpBhxapFPCHbuKCT4d1WFMVsg-N_pQGJAp3cciNBK2eg>
    <xmx:_I4vYP6RTuIKYFzeKyTJxoADryN6U7vhT23CkloE4u3MMOMnTQ2tNQ>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6ED2108005C;
        Fri, 19 Feb 2021 05:12:11 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: rename BufferSize to buffer_size in ba_param_set union
Date:   Fri, 19 Feb 2021 10:12:04 +0000
Message-Id: <20210219101206.18036-5-will+git@drnd.me>
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
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index a36e4488b849..af25b4850975 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -34,7 +34,7 @@ union ba_param_set {
 		u16 AMSDU_Support:1;
 		u16 ba_policy:1;
 		u16 TID:4;
-		u16 BufferSize:10;
+		u16 buffer_size:10;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index b695a56a44b9..17520fcbc1bb 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -284,9 +284,9 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
 	   (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
-		pBA->BaParamSet.field.BufferSize = 1;
+		pBA->BaParamSet.field.buffer_size = 1;
 	else
-		pBA->BaParamSet.field.BufferSize = 32;
+		pBA->BaParamSet.field.buffer_size = 32;
 
 	ActivateBAEntry(ieee, pBA, 0);
 	rtllib_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
@@ -487,7 +487,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	pBA->BaParamSet.field.ba_policy = Policy;
 	pBA->BaParamSet.field.TID =
 			 pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
-	pBA->BaParamSet.field.BufferSize = 32;
+	pBA->BaParamSet.field.buffer_size = 32;
 	pBA->BaTimeoutValue = 0;
 	pBA->BaStartSeqCtrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
 
-- 
2.30.0

