Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753BD3511E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhDAJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDAJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A69C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so1802809ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZoX+gcDb3Jy18EAvERN1m52sSx5ol5SrYTmapPbGFM=;
        b=c8qLMSuUvW7O8XKFffGsVUB88bbNVNadGNaUEIWDZfLsaiEFNGYragC3sNLhsKs4KO
         7nseukTup75+zaYe3G4Elb9QexF9cFgKtvixrtUvZqqjSCApnAKFdwWyrjOQxAAgBgnS
         UZUO9n7T+4ISW+yPpOHJIriT//mTgriavAK2GDlK4bZRufpZPnBxetvx5FyPE67kFRJC
         9bXfE3Q4KZjANhkNMHh4rx29Gb51bEw9AYjTvz+BsN+T3KvxNyU3GIycSdsJ07MCNm5X
         Ni2yGL6QCQ4q+hskxgYqhNOQIQAr8EPdDKnoGBHNh68DLr0bg5U45BPVTZQZTixclxVy
         jZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZoX+gcDb3Jy18EAvERN1m52sSx5ol5SrYTmapPbGFM=;
        b=J9l/JwLIWLEuMn4TBFdprE7EfwCpB5e6cip0Q6iKlB6rWhLkq0SG3M1LH5Ua8kzRFP
         bzKnJuFlWT6zjP2rO6gXTvBStQHNkoPveN9fwlAZJ0AMoEcifmC2oxBb7SJ5uZ93MSzQ
         jqXx34Kse1BdbDREDWn/NE7zQseV0q2Oe3JthDD/8RV3stEYQt7je9s4ZJSmyuxB0+wu
         0UwhPMn7BvB4UnWuHzaJ5nqNDrfNQFBaGS/xYJIZSjr0a35TK3MluhUA3MMOjc7EvamT
         1wamXyBfouy2/NG2DrzQ4vYHDsv1maDSgHa2QWiF+4jkRM1UkfwkouTB9bCogJDWr2en
         s+4w==
X-Gm-Message-State: AOAM531z4Ye6eAj0gmIBT2bq3hJ+RgTj2VXWt3pMzWH5FTIFsu0/zIeD
        +4CwaUZhUXs0TiIOcdFFAUw=
X-Google-Smtp-Source: ABdhPJwlTfZjI0tCBAlW5Loil26MaOOM22YKasC5KhJyUoOi0WHpcGAZBS4v1cITumALi8b+h9xzCA==
X-Received: by 2002:a17:906:af97:: with SMTP id mj23mr8363312ejb.419.1617268902696;
        Thu, 01 Apr 2021 02:21:42 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id y17sm2487620ejf.116.2021.04.01.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/49] staging: rtl8723bs: remove empty if-else block in core/rtw_mlme.c
Date:   Thu,  1 Apr 2021 11:20:42 +0200
Message-Id: <b18a50293d92c0cbb598e852a8e4f0a497f6ce3d.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove emtpy if else block, the condition is just a value check

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 09409330bf9d..84f348ab807b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1251,10 +1251,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		;
-	else
-
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
 	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
-- 
2.20.1

