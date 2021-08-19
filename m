Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA003F14FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhHSISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhHSISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36ACC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k19so4793174pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmsxjSFu3i7r3eCLeFpeZGvQeDgyZ9p5i9AV6MQK988=;
        b=U0/vKB6ZkgtnKF2B3r1+lPQsKooRBRF/AcWh77jbjPkKOZOG7UOWfYDADGNFemAAp7
         ksttYG+CBgLD4eYOotkoOf/y+GLSWubAv7HW8bw+hEXizE/nIaCTS/rQ2l0Cz7kYu9oe
         ow5SNoXX6my/4hrTQiZbzQiHKB/u/SUOKKy7FZLt71vCmg3kzDl4zbAeBg6ivNYHh3/E
         N0QEYSVUVWvtbkxBFcS/elhbzj9JoBTrAG6yZrGNpAB1fthHNRXdsGvGutm6n59P/LWh
         jxl1r5IZzr6QWXENgLaKJisy9tvb4n4GCqkhBAdDWcoZplLKdME1kEq7MLA0kHM5dmh8
         wRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmsxjSFu3i7r3eCLeFpeZGvQeDgyZ9p5i9AV6MQK988=;
        b=JnDM6VQ5FGRtfJQbFwnAAd2/P5yTWftpMNlDsR8onurgQXapEP6MIu/44pdCVeTLBq
         U/JNapC4d6d7oMjwD2l56ddIkXIH1cGa2NhRTBaatz0XL6/J99vPpRvcfkYBszR2zARw
         Ka+u+8MSr3wwf7xxTH4J+jWxipG2n4ph+IyKZ0yvK9LOlGB9FlSz0xw5bATL+2VA9U+M
         QzZ4+9BBNTO1+GwpYoUpJ6wtav5hAs7bl70ThqbtX6ZwWTNT1MyX31njJ2lepAaAwoNj
         +d5kHOev+OIffoZiQW5MtVA0xqpD1Zw2napBvFNo5t2/s7JcDcSVo0JTV1fTlguD1FgU
         ZhZw==
X-Gm-Message-State: AOAM5310wGnKvKb3dYZXrCY5oaClEdwR2BrApfzNk/9uAejBit1cC5Vn
        pk1ko616pFCdvEGDQs+CN01LyQMxo9rgKg==
X-Google-Smtp-Source: ABdhPJyGqlBpOT74lRTpXOMOG4tN3flMrP4LJmSXQr0f6nyNP38aCCvyABKBfeEdE92ths4b79llZg==
X-Received: by 2002:a05:6a00:1808:b0:3e1:f8c5:3436 with SMTP id y8-20020a056a00180800b003e1f8c53436mr13525967pfa.3.1629361089488;
        Thu, 19 Aug 2021 01:18:09 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:09 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Thu, 19 Aug 2021 13:47:53 +0530
Message-Id: <031b477891e5981897fba5c96ae2da922cac55ec.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629360917.git.aakashhemadri123@gmail.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer

Here tag->tag_len is be16, use ntohs()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index ee52f28a1e56..404fa8904e47 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = ntohs(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
-- 
2.32.0

