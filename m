Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7A348D89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhCYJ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCYJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:57:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:57:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b9so1610070wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS88VoX8ZZlakrWWcv16+p54kgnbozpp/01RtCA8wMQ=;
        b=Dr9wbqWxgaGT3xu69eZKsUhoP4rMuflsB4BORRHGacKySHutIurjd2gOQgbpxi/ht1
         cJcU/LsVh0UDrdAWnPZCgtr+TLb66VG/XVlvNgSKVDUmqWJ5pngDTHRh86voH5vaZ3+F
         Q4P81DCQbCXeoH01g2zf5p7KH0j5IGTLhOENXrG0sHEBy3iBJnaVh5a5pbKcAgGr6rwd
         T/qRhsnO4lszIJMhN2BVB3T9UfiJRpoD8aVZfR3BwdEZjZSIm0I0gHOzZ0ZlZhykODxR
         CjpIak7iIvcWrFndDQFy49tBmRWoNL8NNxFfUiOEDprEP/Mh6tzR5NB+PLsvKYhjmKc+
         JJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS88VoX8ZZlakrWWcv16+p54kgnbozpp/01RtCA8wMQ=;
        b=Gsi1prVnRmsyVH6Fgrhd1kzSr4YMuevG+fa/T4X2mNJJL7XkatjYnkC2vkNnkXrEnD
         XlGu7Ev1EtZkjsJCGVOFSp7RzSEmjNRTQgjqpwxrCzNOgexvi6o0yNkRLmkrl9hGpWaY
         VO3thwlG6diL9XcOZzxwNz/s1ThyHJ59H9TOmRavaOHdRIlhXV4NNPXJev7UZahNojFO
         USp30x9uRSR266jrJHSqnk+oHM6XGztHVnhQweJPrl9Wj+4Iq/ZaxZE5iGixJaUDoL2J
         fugHk5Qy/Lc6cm5GVOlKngZXyac5fSLmiQnGXjh+yD7kEvYm9ZM++vznZ4RY36H0EkhA
         Nd3w==
X-Gm-Message-State: AOAM531CGkYSPoZFPzgGUvpGZfPFzn83ZhNTNO0GBkaskr+mThnZ5e/C
        81eW2zXS1LxdqCHbQiLXlf8=
X-Google-Smtp-Source: ABdhPJzOqMoRetThYDOZu10Es0oWF6yRvuFTRNTOAl4zuslzDGZGzdXlvhMAMfmkEj2WCJW6kFEceg==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr8332721wrt.115.1616666232709;
        Thu, 25 Mar 2021 02:57:12 -0700 (PDT)
Received: from agape ([5.171.80.127])
        by smtp.gmail.com with ESMTPSA id e17sm7101891wra.65.2021.03.25.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 02:57:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix indentation broken by previous patch
Date:   Thu, 25 Mar 2021 10:56:20 +0100
Message-Id: <20210325095620.11251-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YFxQSJXXQ4dFPGS4@mwanda>
References: <YFxQSJXXQ4dFPGS4@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix indentation broken by patch removing conditional
code blocks checked by unused
CONFIG_INTERRUPT_BASED_TXBCN family defines

https://lore.kernel.org/r/9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 3cd9c61eec99..dc56477eb084 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -907,9 +907,9 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	if (pmlmeext->bstart_bss) {
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
-	/* issue beacon frame */
-	if (send_beacon(padapter) == _FAIL)
-		DBG_871X("issue_beacon, fail!\n");
+		/* issue beacon frame */
+		if (send_beacon(padapter) == _FAIL)
+			DBG_871X("issue_beacon, fail!\n");
 
 	}
 
-- 
2.20.1

