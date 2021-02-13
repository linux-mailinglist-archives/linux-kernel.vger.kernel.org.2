Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4131B056
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBNM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 07:28:35 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43687 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhBNM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 07:28:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 233145C00BD;
        Sun, 14 Feb 2021 07:27:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 14 Feb 2021 07:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id; s=fm2; bh=1VY33AhqE1N3y4vDykDeA1
        +0wGn/+EB7Iplukdy4obA=; b=SZAiM3Rhb0Fo3fgLHpldcppOsou5eOtIyzZIHT
        vIpoYjbKWe5ta8vnrYmL+YVIJ1XHHbGm2helky84Fp579SmZdjPTNoIgfarMU5TL
        m/hTb60Ec8S/9lQ3l5bu9EXnaIAGb8+qR4kAbdOIsak2MoRtSxFzbY4/CGba1ePH
        bppGqBJQBbd090zep2LMKgD0mMKTcIeu4x+zcjmt1iRvqNkKnH09nLCP1rWsZCgi
        LXR5ifIgY1PCJ9SFTYN83R6S786RHHcxvoPzyNT9RxyqPeBpJLoDC5J0ix2Vfc4u
        EKcMBnpXd30RvUlWnQo8Y620ji8inwfxmUaixGH25in71hvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=1VY33AhqE1N3y4vDykDeA1+0wGn/+EB7Iplukdy4obA=; b=ClQ8i0ge
        HG0GGGRopeLXJjpQWic7HXOgt3J1vWYxEYn98D24w2w/dYej0RLRBHvbHFMqlBLz
        erQa5Q7qn+1lKpOlTkKBU87VJ1OKCsGP3HNlUGFFkA8fiWmyqXqw18NzV1yFzohq
        mUyCrg2xK92VoI0IHDmkX2QuVHoS89AR7qsbYoWJoENCIWHDFTNI9FtaGXZtIMj5
        lNyky/gwCQln7rQoECj0GQG/bn9UnzO+G/uFvJVQn1/omdzV1zsyhgTl4avxiJj0
        LYONfBkMiVBWhqXnkTsGunTOR9kkwlMh+5HFYlv4zxCiv8lHWwZl5NkpjpA1Bw9g
        2evK0fEu62ZQZQ==
X-ME-Sender: <xms:QhcpYLZ-5sfYdC9EcjdrsAbw2ayTOy2PbJqkCeBVzk5mw5lXdg07jg>
    <xme:QhcpYKaTuR67vySwASo-7r1qjB8o4qdG3fkpFbmm2VELAqtQc03bWTz0oIbBHYLYX
    nDDxW8yoGgeVOCUqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofestddtredtredttdenucfhrhhomhephghilhhlihgrmhcuffhu
    rhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtthgvrhhnpe
    ejteduieevjeefudeuhefgvdevgeehgeehgfdtueeuteevleeuhedtueekvdegteenucfk
    phepvddujedrvdefkedrvddtkedrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:QhcpYN9ZE9gRrxbkEfcWvfbBJMpVGKA460XwVD7suI1B9ID8acSdlQ>
    <xmx:QhcpYBoKc-NSchqjwJJQybah2c_OAHrq32z8OgwBA4ZqrR2fvNy4zg>
    <xmx:QhcpYGptSkub9ovFKUuEc3zJ7fImtfW4Pi6xzvfpFC1C0YkfyeMWZQ>
    <xmx:QxcpYNQz2IWlEhLl18O-3QlOOcQi12Ge63DVkslNMuY30zXWZGcAgA>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1610A108005C;
        Sun, 14 Feb 2021 07:27:45 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix typo in a comment
Date:   Sat, 13 Feb 2021 09:01:12 +0000
Message-Id: <20210213090112.24616-1-will+git@drnd.me>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a checkpatch warning by deleting a repeated word.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2d3be91b113d..ab4b9817888c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2443,7 +2443,7 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
  * N = MAX_PACKET_SIZE / MIN_FRAG_TRESHOLD
  * In this way you need just one and the 802.11 stack
  * will take care of buffering fragments and pass them to
- * to the driver later, when it wakes the queue.
+ * the driver later, when it wakes the queue.
  */
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 {
--
2.17.1

