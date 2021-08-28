Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DEA3FA555
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhH1LLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhH1LLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:11:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048EC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so5715832plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9F4jfrLgK6xkABY5wRk3B6guk9L6WzewIDyIT8iVCaA=;
        b=O/fZDbwg6YCb+ch877n6TpUXVoYZXAHtY44usHekDpgOqmSVSy0arv0C7yZ3WbEYeH
         QdGgxRUjkjq4Jy+j8+u1mhjVZMWBAmBrDjqL+g4RP35UB/sY5O1wNBPSX/F0pRu+EOQr
         vXHxg+/6cI2Og1nUQWDqtYvVVY3dKyraT8aPLjnFewNEHelb51D0gFGGMx7YanvWtZx7
         Yf7sVVwA/earxAza+azraGDejdgY/lcoOpo+P4Q0Wjbx3/D/vb+dIQFi/FtGKMl/GABz
         II6sOdnRrJ90qzYSO4dvZi4gtTkZN5ebsbraTUholi4RGmowoJv55YMeEwsKO1jVK+3w
         8ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9F4jfrLgK6xkABY5wRk3B6guk9L6WzewIDyIT8iVCaA=;
        b=sHDIt1+Gnw/1QcRApC9puMvW+Tf1a0m/ivLJF3wdTM35z0HPkr7Us6Ch3k1shIoinC
         axB6kJP+I9qjtbyaOSsSFxvfPQEattgP5rx5t+Pvp1w+kqOvcXg/ihRf/fGvdE5ER4Lz
         MNCk3tLQqZwhq+OF47wZ/nFPwplm+cWqpztqPrqrlVNHY+YYky5l1xBk5LisYy9jfoGY
         dcdJzQCp3l3waUdPAYbswQ+xdL2auxrkRHSt6/Of7DxxfICLrVQG+HPlrRO89EfX+Kct
         /xcQIyKimILbCmO2d0PK3zWlYOrvi92aMQH5vEGbxyNouvZoZiSWnC3E/Y45PguBy6Tg
         RNVg==
X-Gm-Message-State: AOAM532lAbo/HFGTRYO8QTXotQVKTK3paN9RkWTXFFwSsoLYmROKhPBK
        JRjtirk28mltnMa2dw7McppSdj0OUEE=
X-Google-Smtp-Source: ABdhPJwSums78rXCFDJWuWb2jR2/oE9omHib7JXkEQi0wpObFUiA4lUFeywL5a0LkKWTx54O5mMEpg==
X-Received: by 2002:a17:903:3047:b0:12d:c724:8c22 with SMTP id u7-20020a170903304700b0012dc7248c22mr13205663pla.59.1630149053806;
        Sat, 28 Aug 2021 04:10:53 -0700 (PDT)
Received: from xps.yggdrasil ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id y64sm10205379pgy.32.2021.08.28.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:10:53 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] staging: r8188eu: restricted __be16 degrades to int
Date:   Sat, 28 Aug 2021 16:40:44 +0530
Message-Id: <652e62b7f30d216bafc6ef390ed27c2c6864fe95.1630148641.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630148641.git.aakashhemadri123@gmail.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer

Here tag->tag_len is be16, use be16_to_cpu()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 62a672243696..aa56cd1a8490 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
-- 
2.32.0

