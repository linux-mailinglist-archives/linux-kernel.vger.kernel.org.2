Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D532A003
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575128AbhCBDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:25 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52317 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244304AbhCAV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:57:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7F51CC38;
        Mon,  1 Mar 2021 16:53:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 Mar 2021 16:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=KWoRJ7MJkvASB
        w3E/6I4S1amxgoH1dDur0T6BQR6PWQ=; b=jmvio9Gseq5XlqBsr+PKvf40ijViC
        IGQGK1XEx+qUBBYVvi5QwRicRFfPyH3MuyXd60/JxUrvaodXNZuClf/UzVg7dXoZ
        Y5hYMUGTn9Of2oXC8B8GBY0XN8dMwjV2yIWNUv86GSbyy470bvHN8IN5aWZQ6Ub/
        il7rY/xiFbq12wq9sHAgDH7XsQCk1EjtsuCrS1kxl8rdqYoA/L9CLL4jiC/fYuDs
        cpknXlLME4VT2cZ2WnRITUIdPHsYF4GCWJfEWJa7Zvwem02BFiAiwA39IE5jshib
        jEpm2CLPWLdIsQS7Ac9/Hil0Daao96lEKXLbFI0mcDBkBDktOqW7VZzbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KWoRJ7MJkvASBw3E/6I4S1amxgoH1dDur0T6BQR6PWQ=; b=bPw25FaL
        5MUIX32lI4uZt+WlV+cJhAtHMq54PbI8UJ0qJCp9ODsABYYmwjMRDs2iHC5yvilX
        EXjiF2IMvhu954h3iT0hkWhhGJn4o7+IDtmQvuZ6sug4VMv5eQSWiAehgA+gC3eU
        5bvHEWW+ntTfCeTAvTK0CzXBLTjaH9RaxlXhegRev20BPAFOWURmT+Dzkdo7Ov3C
        7F9Olm1uxNcwHWzYXutTS0dYWufp+T01EHcCHNDPKqWPGme3AG61YIEfsRSlwilW
        EBAnfSqsIp6k2wG94cX4IOA2s15rjV/YM6S0TWQPyxZE16M044yF38jKk1xjG2hy
        MiiOQmeZgjQNuw==
X-ME-Sender: <xms:aGI9YPVsDVzIgnsCa7KVp3gEJXmv3J9C2ocWBErtMjkf-D-nJ4RKEw>
    <xme:aGI9YIVR7Y_oC4pTN3YnLt_2ht4pU25ynr9QNe6qWUtalwLvFmPbfs-s6NZf8okVY
    KKqlyi9-9fJl5aWnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:aGI9YHhSFYs-oT2Zsi85_vOysGOL7A4yer9GRTuWmt1fmZs3jeL8Fg>
    <xmx:aGI9YLZj1IQ8ItMl5_2lnyo97_k0ChX8AlrzpBNRXO2OlSPEQAcyAw>
    <xmx:aGI9YMr8mR7YUb22Z-XfuvU4cQlnaIdeVbN2v7svYg4ipY1feeKf1A>
    <xmx:aGI9YAc_Dumw9vQMuJXxy4m2BQYGn2B0YEJr5cTmPA-XXoIPAzoLBg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9474224005B;
        Mon,  1 Mar 2021 16:53:43 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] staging: rtl8192e: reformat rx_ts_record struct
Date:   Mon,  1 Mar 2021 21:53:34 +0000
Message-Id: <20210301215335.767-10-will+git@drnd.me>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301215335.767-1-will+git@drnd.me>
References: <20210301215335.767-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses a space instead of tabs between the type and name of
each member of the struct.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_TS.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index c4995fda9ebb..4aa9b12a2dd5 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -43,14 +43,14 @@ struct tx_ts_record {

 struct rx_ts_record {
 	struct ts_common_info ts_common_info;
-	u16				rx_indicate_seq;
-	u16				rx_timeout_indicate_seq;
-	struct list_head		rx_pending_pkt_list;
-	struct timer_list		rx_pkt_pending_timer;
+	u16 rx_indicate_seq;
+	u16 rx_timeout_indicate_seq;
+	struct list_head rx_pending_pkt_list;
+	struct timer_list rx_pkt_pending_timer;
 	struct ba_record rx_admitted_ba_record;
-	u16				rx_last_seq_num;
-	u8				rx_last_frag_num;
-	u8				num;
+	u16 rx_last_seq_num;
+	u8 rx_last_frag_num;
+	u8 num;
 };


--
2.30.1

