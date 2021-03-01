Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE7329FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575034AbhCBDwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:52:38 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47871 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240063AbhCAVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:54:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8A294BE8;
        Mon,  1 Mar 2021 16:53:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 Mar 2021 16:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=QVPFFQi0U1nnE
        QSMyR8r21axQo9LtbKoHtTzqm3bSUU=; b=bujaHfR7DZqDGYUGCGMyWFLVqFNR+
        N/fak5racrkAkVR+FibKdynQUZLddXiI1jVImPPjSz/ngVhC8YkRr7T3lmt8vJlu
        Irs6CR0we1asjXIPT6MoI4xsT4bE4s3FM1owBXS/atUXczLi7JMxidXhBmLhlq5l
        TrUYhJg8uYpaVr+saz2Vg8GZXU9htJ8qOctF/E87MNz75Ydz/sosGJHZFoWqqEAa
        kkipq4OLwfHrhpRpunILrJX1tmQSnotAda3Qb1l8ZhGX73R+4yFdEsGp39PvXCGk
        jNyXwv6SnD/r+mdEuonN14ENQ/fH/i20tva5RS4GeAh94qozOsesvJpwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QVPFFQi0U1nnEQSMyR8r21axQo9LtbKoHtTzqm3bSUU=; b=POsdOMhb
        +FgUImgcW8TMTa4DidrWQ6+PMkU71d/8qNfkSohDWux5CGrjm2Vay47QZUZgu5u2
        7FrhJAa9L5RSkePSF5VTk74KnQqyH61X7IK2AmQmdYHAcIIsnCuVc+CbcgD9sKjC
        epfxucMn5AdvQ2w+uar3WNAJIcCi1aAdZQCCwV6y2Ts4p10awzNoXUG0+4FhuQec
        lPJLckta5BYf2/L31EJzD1FbR3guWS1gwZ1gWBvLXXPkBztqHJRVYR0i6ItakhOE
        +dH+4SOW0vPEKRkqK3BSmMNLHxjkJ06F6tcEoqq2GDqeWETYkATnhnF5GOPNv6xD
        fvvp5xt9wWw3QQ==
X-ME-Sender: <xms:YmI9YK7_Mtd-ft9qHVOXr4t_Dtcg0PpEUPDZFO2MoJhDoS64ehXtIA>
    <xme:YmI9YD5Ny1LLDPJrIVs6lMrXftGTy--B03RtfMfNkNS3dExPcUQ_tCKEQXI_U5kQ3
    PhRd9MiY2Oz5XEsog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:YmI9YJfvfdhkwVaU6WPyTQrxnPAfywlE8k07qIx4O7Gnux0sj2KTNA>
    <xmx:YmI9YHIZ-GjqJJmrHxEcBiqxR45TaZMrCWAy5F7_0I4GjqoVOiPGew>
    <xmx:YmI9YOIF2yVJUZENOv0U4f_aKVdwqcZEZ_weoTwGden57eWnTAAN3A>
    <xmx:Y2I9YIzIKrK07NRboZAgWPeum1u2-qBQQIO3LiRcbGgN7NSiKv41VQ>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 729D7240068;
        Mon,  1 Mar 2021 16:53:38 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: rtl8192e: rename TsCommonInfo to ts_common_info in rx_ts_record struct
Date:   Mon,  1 Mar 2021 21:53:26 +0000
Message-Id: <20210301215335.767-2-will+git@drnd.me>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301215335.767-1-will+git@drnd.me>
References: <20210301215335.767-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename TsCommonInfo to ts_common_info to silence a checkpatch warning
about CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c |  2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 880b5f1c14d7..760d143cb3bd 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -549,7 +549,7 @@ void RxBaInactTimeout(struct timer_list *t)
 				     RxTsRecord[pRxTs->num]);

 	RxTsDeleteBA(ieee, pRxTs);
-	rtllib_send_DELBA(ieee, pRxTs->TsCommonInfo.Addr,
+	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
 			  &pRxTs->RxAdmittedBARecord, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 9dc93d41939d..58879fbba9ef 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -42,7 +42,7 @@ struct tx_ts_record {
 };

 struct rx_ts_record {
-	struct ts_common_info TsCommonInfo;
+	struct ts_common_info ts_common_info;
 	u16				RxIndicateSeq;
 	u16				RxTimeoutIndicateSeq;
 	struct list_head		RxPendingPktList;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ff65aa45abe0..f8e7beb7909f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -123,7 +123,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)

 static void ResetRxTsEntry(struct rx_ts_record *pTS)
 {
-	ResetTsCommonInfo(&pTS->TsCommonInfo);
+	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->RxIndicateSeq = 0xffff;
 	pTS->RxTimeoutIndicateSeq = 0xffff;
 	ResetBaEntry(&pTS->RxAdmittedBARecord);
@@ -169,10 +169,10 @@ void TSInitialize(struct rtllib_device *ieee)
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);

-		timer_setup(&pRxTS->TsCommonInfo.SetupTimer, TsSetupTimeOut,
+		timer_setup(&pRxTS->ts_common_info.SetupTimer, TsSetupTimeOut,
 			    0);

-		timer_setup(&pRxTS->TsCommonInfo.InactTimer, TsInactTimeout,
+		timer_setup(&pRxTS->ts_common_info.InactTimer, TsInactTimeout,
 			    0);

 		timer_setup(&pRxTS->RxAdmittedBARecord.timer,
@@ -181,7 +181,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		timer_setup(&pRxTS->RxPktPendingTimer, RxPktPendingTimeout, 0);

 		ResetRxTsEntry(pRxTS);
-		list_add_tail(&pRxTS->TsCommonInfo.List,
+		list_add_tail(&pRxTS->ts_common_info.List,
 			      &ieee->Rx_TS_Unused_List);
 		pRxTS++;
 	}
@@ -364,7 +364,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 			struct rx_ts_record *tmp =
 				 container_of(*ppTS,
 				 struct rx_ts_record,
-				 TsCommonInfo);
+				 ts_common_info);
 			ResetRxTsEntry(tmp);
 		}

--
2.30.1

