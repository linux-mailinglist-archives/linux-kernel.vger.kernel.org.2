Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88434A419
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCZJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCZJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:17:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:17:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5581521wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS88VoX8ZZlakrWWcv16+p54kgnbozpp/01RtCA8wMQ=;
        b=mXWaqovoH5O0Km6aAxN+DKXsqPFlrVfntnVgbcg4Q+QgqY3mBOODvgg5/kjSkqkRWk
         6jkH0zIZydGW0508MpuNnD8ESJ+Ndh5AW4PNXyIvWvdHLATq4kqQ/4IJf4Wr96yUvIKf
         euBZBmDodOsP4lAP3qNrGgXUvezmNMqmQxbPXqJ8nBey8A5fupXZXAZZUbmf92B4tqjT
         5EdLQY9dt/Po9KGxirGN1WgCd7o41E4EXOL7c5A1FBQlJH41LIbJJNdFvnEbdQTD1mxZ
         kXOu9gR3l6OheS5Sy8EcJ+aiJ2FR8aC65QmV93Znygk+SR3qZvJWLcFBeQ9MyCoV3i8B
         LAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS88VoX8ZZlakrWWcv16+p54kgnbozpp/01RtCA8wMQ=;
        b=LOX8Avc8mIJxmLsUA0NacT6NuD8qsJv9UDhJmbnqPUdMXLeXSvmD6pbk416CBUNlaG
         ivQuF7PndXkjYgXpcNEXRGjP6J3zgnx1oPhz+/t826FTo+qg1KvVYVKrf827UL1F9DMR
         4W1ew2/dVBWUvHma1X4KRKH6AoJJAcwLdNE77MdrabsXG4TJrsZVcauttzL9fGYyqPHn
         nRiCv3aikFqO69bHw6kkMB4vlUH0kUFEZrlvqHEiQNLKT0DYgKPlE0YUow69ynXnNLu9
         vyRhdQgD7104HPKxo+UdEfP8s+7pD+sFZO57vWzzJBkbqvGcrZVQhD8XRbLyj8dWMWgU
         hivg==
X-Gm-Message-State: AOAM533ss4d+TmpcPAJXHUF3X+6y02bfxJQM69LJ6AAtWz5Htoz78Zya
        811gBs1NrT/XDI0ZIEb2ocM=
X-Google-Smtp-Source: ABdhPJzdhXtvJUOkPaYr98SOo5KlxV5GGtkIzAzJD/YDwX5uI15EbrbzEhLRTM/lO8ip/v/fFessxg==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr12224505wmb.14.1616750259485;
        Fri, 26 Mar 2021 02:17:39 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id c9sm10937121wml.42.2021.03.26.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:17:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix indentation broken by previous patch
Date:   Fri, 26 Mar 2021 10:17:16 +0100
Message-Id: <20210326091716.6599-1-fabioaiuto83@gmail.com>
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

