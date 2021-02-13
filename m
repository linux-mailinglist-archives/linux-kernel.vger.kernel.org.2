Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC531C26E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBOTYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:24:46 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40901 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231168AbhBOTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:24:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 89351F11;
        Mon, 15 Feb 2021 14:23:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Feb 2021 14:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id; s=fm2; bh=qtZ88+eccUpDy/N+YVtKwx
        /Db1dOaYm7Hq3J1rmzqh4=; b=KFhp97DQaqFzDIbMjDm63fdF7BQ+RMdq5B6gHu
        Cp4D2pt0OlbKvVGe7Tp4DsHCbbdCao/UM0ON2Z3uBAPtCPf114wIScSRW3gDn5d9
        bDwutnK4Dz8uje/IQnBD79gi15LOFgnjyd1EY/5kWRJe3XgwCb232rlRXPOS7hlO
        Xo2WFOqtr229hw85O0srJ6p2JV47sZ2H8qsTMMJEfHJ2mxYB/BiSDty2b8Zj68ZQ
        zyxMjR0fEunyDRLp8Zf5CpMRbge/iWLfdIEAl76rPw8MiquDqKO7VLldvF8JA67Y
        3iSYWsCI+h30MyytLRk5moXq+qnnipi9Vj+SkE3oj9HLEEdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=qtZ88+eccUpDy/N+YVtKwx/Db1dOaYm7Hq3J1rmzqh4=; b=L3XQYYMr
        emVS+nG6F+KBb1ir6/DgVbX8+Jne8+EA9xEDkTFe+JFaHp2WrLiSuLt+GYDXplPG
        52i2m4M2gFI9mgn5gz8KCyf6Dv0rimJULJZbCdl5y/47FRf1yauSmJtdUqSzo1mT
        M5KR2VPiochdGLbZDY3thK+MWIy6NcEAKwullzuShVJHmErXV5/iyYzdIxINmNUD
        ZxHCGlRxKnQybGuu7WYYOe20UytuVPHmlpgjN4JPZhUJd3HXQqQ/hsOGbOBDbSrC
        Jr/mLmPoMYTVsSS7/+QiGVaM2Gb7fSJBpe82Wy0TtF3RRv4TC4s8ppau8N2+9nY0
        YmxOuvamKBDeAg==
X-ME-Sender: <xms:JsoqYH5MOA5pnvT2KUbJvZKgSxu3vdp-tLD6sSbiKwNW_RTcceDMQA>
    <xme:JsoqYM7hz7I1WXcsSagpAPIdXhWDNsTv_JR1MPOEyeP-j4uAUo5FSaXmY9ZN1cPfR
    hPHVt1F6AsY8QpHlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieekgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpeghihhllhhirghmucff
    uhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrthhtvghrnh
    epjeetudeiveejfeduueehgfdvveegheeghefgtdeuueetveelueehtdeukedvgeetnecu
    kfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:JsoqYOeQqqz9iNJl2DZlubX5G_nxqge4Rd4c2qcKp-v1pINPeG6Iow>
    <xmx:JsoqYIKopu4oeOH3rOpQkmg_8NZuafzk6prW753-kmyEQCoVzgBkVQ>
    <xmx:JsoqYLJPdqj883BaI8yNKMDX_pBbluttUvrhA95m0CiRj6dIRbr6eQ>
    <xmx:J8oqYNxDrMSyq5HRY84RUTFqAje6Tr6mL8ekCXoZUWOUeJON9q3wag>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18A521080059;
        Mon, 15 Feb 2021 14:23:18 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: fix typo in a function name
Date:   Sat, 13 Feb 2021 14:54:21 +0000
Message-Id: <20210213145421.31031-1-will+git@drnd.me>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo here where it says "qurey" but "query" was intended.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8add17752eed..50cf10201fdd 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -339,7 +339,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	}
 }

-static void rtllib_qurey_ShortPreambleMode(struct rtllib_device *ieee,
+static void rtllib_query_ShortPreambleMode(struct rtllib_device *ieee,
 					   struct cb_desc *tcb_desc)
 {
 	tcb_desc->bUseShortPreamble = false;
@@ -928,7 +928,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->bdhcp = 1;
 			}

-			rtllib_qurey_ShortPreambleMode(ieee, tcb_desc);
+			rtllib_query_ShortPreambleMode(ieee, tcb_desc);
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
 			rtllib_query_HTCapShortGI(ieee, tcb_desc);
--
2.17.1

