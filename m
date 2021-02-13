Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5E31B063
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 13:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBNMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 07:47:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60259 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhBNMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 07:47:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D7AB55C0066;
        Sun, 14 Feb 2021 07:46:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 14 Feb 2021 07:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id; s=fm2; bh=8z0qK7rxavdcusxFXSG+Oa
        HOXJors9iF1oz/GdrM7rA=; b=IxhbxqAFfCC8Jmh1UTjX+5JMWDFtI0Fk19EkWz
        NYrYMx8loExi2bp2Rlu7fhotI+O8vllnh8+tlg15SZfhf+jZXgn0ShMijiMc3utQ
        O73kF2+rq6zH+bBnVXKox7fDt+5qiuMIuV4kqY7h1j+FHxlxgVYJ5MtCv4mjguCw
        04nV6jXEOKwxwLdTcPnJ60I9xVPZGv9xTBnBlxdCS2a3yng+8sOC4PiRCakpIPD5
        cUsDpraOBSFYoaC9Ky3pkkL43WUsqDTxBojGCug04IFERes3k15uwEHpA2pydfPJ
        QWQlO8vKPoIG3mDLsB9RpxWlLz77Gqij69DkYzmkyL2zDAFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8z0qK7rxavdcusxFXSG+OaHOXJors9iF1oz/GdrM7rA=; b=ILcxYv3x
        4nqj9mRYTQE+vxvYnoFAnzFphTViedh9gG8ZFAnVJ7FU+GnjLMKWEKZeG0yFqlyM
        5mOzJnTCnfFVx5n8cabxD/oe8C05aK2rmsQ2NbwoZkU64Nc3846iuV1fkFpNA/06
        OrUOGX2ndHw+JC+AKkOpyVQhvsnPtfao1WK5N0cErqEZcnRSK2dZPwy5b4W+9ZQc
        5evRxuYpfIl28XmtJiJle5FNSOGmKvi4gcRywDuYUYDaZKdT8er54ifVcMX4scat
        0euLUxNDB2IVBEgif3mlfiuPiSZFdsdLMGxhcXnTvSBYFHGYpQTvIEcwlCisUDNr
        Wqj0WiV7JGnqLA==
X-ME-Sender: <xms:uBspYH4i1nH20ARVfnxGESnVt5YIZ977rjTXctqT1B12RFC-gq7-Cg>
    <xme:uBspYM7_RzMIMhXyNnGPMXJAZ7RvXiC0sqDXNI9YsLBrABm-DCpumHNYlfdOmm9Ss
    YWo72wUV1N_6QmjXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofestddtredtredttdenucfhrhhomhephghilhhlihgrmhcuffhu
    rhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtthgvrhhnpe
    ejteduieevjeefudeuhefgvdevgeehgeehgfdtueeuteevleeuhedtueekvdegteenucfk
    phepvddujedrvdefkedrvddtkedrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:uBspYOdWw_IzRGIaOIzyokrkO-uvZWMzNo6xvCMuKfwWTV5lv7IsQQ>
    <xmx:uBspYIL2FpHiGITsa_58UlsKStEZZ95vtKACknHwEWxp_tMH4WjAjw>
    <xmx:uBspYLKFW6Bs5y-KZkvVbPa_KcAjZYh664mZxuFk_XsKpKJBUnB6PQ>
    <xmx:uBspYNzJ187WettQQB3UXHW7ZmS9grBOB03oQXqctQtD9GDaGRaUJg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5A051080059;
        Sun, 14 Feb 2021 07:46:47 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix typo in a function name
Date:   Sat, 13 Feb 2021 09:20:14 +0000
Message-Id: <20210213092014.29466-1-will+git@drnd.me>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other function names use the verb 'query' so this function should
probably use it too and that's what this patch is about. I didn't
find any other occurrence and the code compiles.

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

