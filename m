Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B232003C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBSVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:18:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40937 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhBSVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:17:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B96C05C0052;
        Fri, 19 Feb 2021 16:16:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 16:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=T7kZBWGtwlYfJ
        QzClfvANGxTmDmAS5OVF2+z7DXCfrU=; b=rc1n1qxEhBcFX6+rDndUncwhJjyew
        cFLY+Ck/iA8yfqO6LnNu4ZXFRHJH7uNqbnY7kNZaIAOaoDjMiFSJYvCkQ+t8FGk1
        j94yL4ly26l3Qbczowh/UYkByYksrZZKJZuLghkIMnsuhTp7yD30zOw/geuFByq8
        0C0YXCUYaxWqkY43KL0+IZ0t90/Y48+N4Vap0eS0ZKCO3Yt0vQuIAnoBp81iJxnV
        W3Hj7oxSJ4GNeL8cHjpe4qadBDVhJuqr8xcTUK8amLdCwRIxpb/NFgdp1aCEO8xC
        dOMAPD6kxX8dsrGwN52fUpTJCV8FB0DQXfedbfAufOd/vVmretDIEQ2gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=T7kZBWGtwlYfJQzClfvANGxTmDmAS5OVF2+z7DXCfrU=; b=XeK+IZ6Z
        Jy47aywbBcRHhSDMnDyGgEw4QUpS/6arAq81sZydwUyOd1fVL9GWRsNN7vU8tASU
        KEgDJ/NXhA3mhvIvi12gYBRnB++Fo236wEb4DD7P1nzL+KrOIFJ72oQgGOrSYvC7
        RIP/IgLBgCMid96kAJnRsiwv/7yNfuf0XP8UQBTGL5S5dN4x4wwvJyTylXT/wwVn
        1NbOmsQ/r+4l8dq++Eneeb3ZE9hvOfTHXIo5p3cbfYcDTs876oJv5mGEM2ssnh4s
        5vy/CI8uZAJ6QjWdZvHSV5Rk6ZelxO36siJNfDxFO5SkJtnrReM0CN7AA4LB24/7
        LRUObDZIPPYZ8w==
X-ME-Sender: <xms:xSowYDrzMfl-x4pXSBZjC13f0sM7i7qmte6i27qUC_epdsIEbRpfgA>
    <xme:xSowYNrHOMgvq0vU4seEsLvb6CrSanBG7H05Q7jwcv93Etom-21_vxYwSuXG14uaB
    Gv9HeACSzXi_tfvfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:xSowYANME4S9fcvFjYzsnG694wIYp_ISMpTMT16SslkmPcy9mbuCSw>
    <xmx:xSowYG57KYS40Puj7a8QY9oBOyLSJFplgfmjgsAd0UlClXDtkarshQ>
    <xmx:xSowYC4mOvSyoEj23viQ3op7sYuU_H0uthWnjC1629XcKR_GDklrrA>
    <xmx:xSowYHjGbgRbpCKp6jptRbvGliXietOv5V_U0kKJN3sUPqcw4YK9gw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB6C6240057;
        Fri, 19 Feb 2021 16:16:52 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8192e: rename Initiator to initiator in delba_param_set union
Date:   Fri, 19 Feb 2021 16:13:59 +0000
Message-Id: <20210219161400.29316-5-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219161400.29316-1-will+git@drnd.me>
References: <20210219161400.29316-1-will+git@drnd.me>
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
index a482cb3b081d..f94ce2d7d166 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -43,7 +43,7 @@ union delba_param_set {
 	u16 short_data;
 	struct {
 		u16 reserved:11;
-		u16 Initiator:1;
+		u16 initiator:1;
 		u16 TID:4;
 	} field;
 };
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 46028f74776a..3594d432b2a2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -141,7 +141,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,

 	memset(&DelbaParamSet, 0, 2);

-	DelbaParamSet.field.Initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
+	DelbaParamSet.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
 	DelbaParamSet.field.TID	= pBA->BaParamSet.field.tid;

 	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
@@ -440,7 +440,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	dst = (u8 *)(&delba->addr2[0]);
 	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];

-	if (pDelBaParamSet->field.Initiator == 1) {
+	if (pDelBaParamSet->field.initiator == 1) {
 		struct rx_ts_record *pRxTs;

 		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
--
2.30.0

