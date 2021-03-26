Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3F34AC01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCZPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhCZPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:53:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44353C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:53:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v4so6074285wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5k/BVMfwAegukvEElIIGUwfHYfApU29sbEenfi66cXQ=;
        b=cGVxh0aGFLtX5bmpyNUup4SVjQaADeguIlmuvskWpz6ghfhMzQpiVrrOj5sV8mv+EC
         tb0kGKF3tl5llVQjvUiZhXeIEcggEyLN093fVlAM6UQJCkOTyMpcnX4+13OfrTmIrNU1
         JBZn47Dbt9SKfx1uIFRd0Tr2DnzBJ23NEstVdQKVHW7daKdUwwJHDi1DH38kE+Oqtjt1
         zERs64eoTDtKDDN+o+fTNnm0uvP98P6dHKQzlEHCffjjQUuQH9y2JHqSev3WA7Ox3QLE
         nmRilC+hbcsbtanHckG8cdcuLFtaPp57SwkjDw9GwOMYR/52i0GE8SaxRFFKaA4wDIWi
         zNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5k/BVMfwAegukvEElIIGUwfHYfApU29sbEenfi66cXQ=;
        b=QKXPvQN2cMfhjuAx2EHGqR6RE+C9N6Qn0rgw5DEW4SrA8uQduVQ6Gu5juYOS4ycoSc
         lvuZcTG/mylJ3TXTThE9wq378a8C3fI41/xxMCUccQ0yvlVOVDLwhmG348WOC+oFWhum
         xuE9Lqo93nFs4F1khL28aNzfqSF3xkNn9rFjt2r928AH66phjPw3CjyXzQWNrnOUQodL
         IPYIDNvD6e+ZEKIrOMN0tDszWkbzJYM98niPxzrZlJJ6qeZyN73OMCAQ5bjnYmH4ruQg
         vJoA4OkSRQ8wFrkKwK5FdUZnRqoHggjbIi7lljy1mhKraHEG8s/MIylFVHlXqAndp136
         W1GQ==
X-Gm-Message-State: AOAM533+SYsUYDPkBoiBiW+hlKIC9Xmk1sPd4FlLw7XsALwXKBhgvEll
        b2XRVdrB3zoCK6vN2Zu5tP4=
X-Google-Smtp-Source: ABdhPJwNWPcwRly02eq531zgTLQ3emt4eOoE5mMtsIz8wgWhWaDUNO6xneYGf7lTwDqLRep3BhY1Yg==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr15141963wrd.47.1616773999060;
        Fri, 26 Mar 2021 08:53:19 -0700 (PDT)
Received: from agape ([5.171.80.141])
        by smtp.gmail.com with ESMTPSA id 135sm11939750wma.44.2021.03.26.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:53:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] Fixes: 65f183001f6e (staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*)
Date:   Fri, 26 Mar 2021 16:52:52 +0100
Message-Id: <20210326155252.6746-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YF3qSsH/3vRy7BRy@kroah.com>
References: <YF3qSsH/3vRy7BRy@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix indentation broken by patch removing conditional
code blocks checked by unused
CONFIG_INTERRUPT_BASED_TXBCN family defines

https://lore.kernel.org/r/9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
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

