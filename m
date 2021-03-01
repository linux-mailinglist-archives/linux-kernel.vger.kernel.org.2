Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264D329FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575014AbhCBDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:52:31 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37225 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236001AbhCAVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:54:44 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 63B6B9EA;
        Mon,  1 Mar 2021 16:53:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 01 Mar 2021 16:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=S4b5+NurlEBsV
        R9ztR1KSCVaeM8CfuGor82aOogFUWc=; b=aNwJNQH6xyGeBTzpeqUuicfY2/U4w
        EFLQK7z91xzRG7tTVa6ax51Mr1bxPztwms0vi9/tPW+rwyYubZ3gZaATLf2ICaY0
        r1gkKchf/7QKKJRp4+Ulsf8wM1vVWLhNjbQuBErF8edoEy/xqsUeSc9sBbS7heAV
        A5E77vSnCaIxmTnu6ocQRTDF8ukBs7Q5v9o0xQe5eTxw5TMgfmdrn6VHCxFt0UWh
        HTvyn9L1mYYOzW0dDjWzAYZiFyzBAxv04aVrTmtE3gn8HHKZ1igi4Gps/pAPkZwI
        o+c8gkKtoxBZs2/uCm5KHRpdp8aNDmZl/hg4SExbstnSECABVKWHT/Gtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=S4b5+NurlEBsVR9ztR1KSCVaeM8CfuGor82aOogFUWc=; b=MQ2nTMve
        rlIX1Jnp5Ps1JS8QmgsdZw6NfWkmwfPzMvyr68Y5h8g90QCiye8wvTOJUmVS95Yi
        rdBo8ZJ9n5NJJsa/eqzbBM+towCXpe79YxqE7Rc6vlsunt8yH3bIhYG6XeJx052/
        M1SDEHnnpnpUHGjTcJWAnaSp4J1ys5EYdu1T4cH1+iUW3z5IXnQc+rJnUqxCdEGh
        l4FSm8VwA+tEyvykyWk1aCEuemwX+98yVqFoEi17BARkbgjs4K0mIHopui7qKBl1
        E8x9yPz0DvsJ/0DuLcPBxQG6TYCn5Xz5WF8xCwWzzmMDxsQ7DcIIbiaeCM2Gcv/V
        KKDmd700nmXy+w==
X-ME-Sender: <xms:ZGI9YNPyzmC9VHzn0QzM52uneIIJ7JWZT3h9VgC0UCFMWISFd7l-SA>
    <xme:ZGI9YP52QGOhUQk5WLS1agaTzBl2VlBpsQl-DjWrHMk6og1B6y9aO3tHDFrkndx2j
    cq6S4SIbaBI8uvA8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:ZGI9YJLTp8RzWwialiEwRgIvtYtQrIAVxZtDQYTNZwVf__ZgUHqsfw>
    <xmx:ZGI9YBcuzesERLXsfM0x8KReBZP8rRRqkM8FszP-86uGOVYKOSUBAQ>
    <xmx:ZGI9YEdT-DtcaBtPNrWc6YVGgn_MfLfQfTVKTRiMCXHgK5g-qccAgA>
    <xmx:ZWI9YH80iFFwKkMZ6jyXbJ6y3Kg7rERz9J8c5MYCCcTml7Gr4gZH6w>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B067240068;
        Mon,  1 Mar 2021 16:53:40 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: rtl8192e: rename RxPendingPktList to rx_pending_pkt_list in rx_ts_record struct
Date:   Mon,  1 Mar 2021 21:53:29 +0000
Message-Id: <20210301215335.767-5-will+git@drnd.me>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301215335.767-1-will+git@drnd.me>
References: <20210301215335.767-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename RxPendingPktList to rx_pending_pkt_list to silence a checkpatch
warning about CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib_rx.c      | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 045093c1eb79..3fc89906b309 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -45,7 +45,7 @@ struct rx_ts_record {
 	struct ts_common_info ts_common_info;
 	u16				rx_indicate_seq;
 	u16				rx_timeout_indicate_seq;
-	struct list_head		RxPendingPktList;
+	struct list_head		rx_pending_pkt_list;
 	struct timer_list		RxPktPendingTimer;
 	struct ba_record RxAdmittedBARecord;
 	u16				RxLastSeqNum;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 004a2f65436c..0195c75ec59c 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -31,9 +31,9 @@ static void RxPktPendingTimeout(struct timer_list *t)

 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	if (pRxTs->rx_timeout_indicate_seq != 0xffff) {
-		while (!list_empty(&pRxTs->RxPendingPktList)) {
+		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
 			pReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTs->RxPendingPktList.prev,
+					list_entry(pRxTs->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			if (index == 0)
 				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
@@ -167,7 +167,7 @@ void TSInitialize(struct rtllib_device *ieee)
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
-		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);
+		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);

 		timer_setup(&pRxTS->ts_common_info.SetupTimer, TsSetupTimeOut,
 			    0);
@@ -408,9 +408,9 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 		if (timer_pending(&pRxTS->RxPktPendingTimer))
 			del_timer_sync(&pRxTS->RxPktPendingTimer);

-		while (!list_empty(&pRxTS->RxPendingPktList)) {
+		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTS->RxPendingPktList.prev,
+					list_entry(pRxTS->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
 				   __func__, pRxReorderEntry->SeqNum);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 76a671ec4d35..cbf314cbfebf 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -449,9 +449,9 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 static bool AddReorderEntry(struct rx_ts_record *pTS,
 			    struct rx_reorder_entry *pReorderEntry)
 {
-	struct list_head *pList = &pTS->RxPendingPktList;
+	struct list_head *pList = &pTS->rx_pending_pkt_list;

-	while (pList->next != &pTS->RxPendingPktList) {
+	while (pList->next != &pTS->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(pList->next, struct rx_reorder_entry,
 		    List))->SeqNum))
@@ -537,7 +537,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 	u8 RfdCnt = 0;

 	del_timer_sync(&pTS->RxPktPendingTimer);
-	while (!list_empty(&pTS->RxPendingPktList)) {
+	while (!list_empty(&pTS->rx_pending_pkt_list)) {
 		if (RfdCnt >= REORDER_WIN_SIZE) {
 			netdev_info(ieee->dev,
 				    "-------------->%s() error! RfdCnt >= REORDER_WIN_SIZE\n",
@@ -546,7 +546,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 		}

 		pRxReorderEntry = (struct rx_reorder_entry *)
-				  list_entry(pTS->RxPendingPktList.prev,
+				  list_entry(pTS->rx_pending_pkt_list.prev,
 					     struct rx_reorder_entry, List);
 		netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n", __func__,
 			   pRxReorderEntry->SeqNum);
@@ -693,12 +693,12 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	}

 	/* Check if there is any packet need indicate.*/
-	while (!list_empty(&pTS->RxPendingPktList)) {
+	while (!list_empty(&pTS->rx_pending_pkt_list)) {
 		netdev_dbg(ieee->dev, "%s(): start RREORDER indicate\n",
 			   __func__);

 		pReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pTS->RxPendingPktList.prev,
+					list_entry(pTS->rx_pending_pkt_list.prev,
 						   struct rx_reorder_entry,
 						   List);
 		if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
--
2.30.1

