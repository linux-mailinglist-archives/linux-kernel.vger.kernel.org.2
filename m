Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4534A4E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCZJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhCZJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BCC0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g20so2638629wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmWS1qUJ5YaBqLsn7vq5tr1Fq+olzTCspmcQ+a0RiMY=;
        b=qGElEP9okREA8l5rJd6lznZgRSRbuEMEiN81CgjLu3eI83m5AfZ7+rVKUUGklivQlC
         Py8WzrKvM7lunZ9g6mr6T8q/jh2k8b1+DBJ5Ti1M3/q+u6FOPgGzYqGu/1RPgDFHtrGH
         TRpG6icePLg4/748XF5ixxcSGYK75s8OOGwlmH5YIQJwwcBKCKbkuBfhBWSj20YKHZR9
         BM7UNM0qKvFSXZ8/LsI+LTcz2VLngP/I19CBmAGKVi0PnpHFEw8iM39z901iNuJlaORa
         jDUbfSOHJ9b70txQC+5wmgO3FDyF6QUfGCZ8vC+NYMpdTW6wIEtJzTSG91Ukbxcwfe2j
         Qm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmWS1qUJ5YaBqLsn7vq5tr1Fq+olzTCspmcQ+a0RiMY=;
        b=L5PCnw3zuWvbHwrHUEs4XbfOa1TcFAhfLY8DEj8ShiaDfL3VY0YpHudUfs/Fm1kE0T
         qpeBcEl9NGz+upVVAnRH6n0DsMu4qmVvAeXEO4NzUD9tkmfw87fgEVH/SuMpENaVxDC4
         1g8Ip89lN2Uuq93BhVa/W++gwkEWgcgPzn5ZuXJQbEt8jynoUB0uxs07PP/VZJI+0nfP
         6dyL4erTlELHUjhKlFNKeclkFg22RdPJwIGxy5L5lkwYW7SIiM3DhYdoFd5AozkISg/S
         ySMamHsCqWaqjCv3FXFEMb5hXuiNPMrSuxS22bNoCfOjfXlrtFPyfrSPY0xEDyQPcCEg
         usew==
X-Gm-Message-State: AOAM5320ZKchTpmOdOeL8kdB/AY3jQ5MrrHP0pWzHw7Cg/hZOE0288/k
        CU/i3ZF40Gm2UnNXrfq76t0=
X-Google-Smtp-Source: ABdhPJwJxDId7naINbDzBrgotI+DWZ6M9+BkDbb0elECL+IvzDSSA3+uyddkjFiawrpQeiXGfYq7sA==
X-Received: by 2002:a1c:5455:: with SMTP id p21mr12091070wmi.138.1616752162273;
        Fri, 26 Mar 2021 02:49:22 -0700 (PDT)
Received: from lorien (home.raoult.com. [78.214.78.108])
        by smtp.gmail.com with ESMTPSA id r206sm4191161wma.46.2021.03.26.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:49:21 -0700 (PDT)
Received: by lorien (Postfix, from userid 1000)
        id 39F561402FF; Fri, 26 Mar 2021 10:49:20 +0100 (CET)
From:   Bruno Raoult <braoult@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        zhaoxiao@uniontech.com, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bruno Raoult <braoult@gmail.com>
Subject: [PATCH 4/5] r8192U_wx.c: style: Unnecessary parentheses
Date:   Fri, 26 Mar 2021 10:48:34 +0100
Message-Id: <f42993e183e1127dcc9fce3f0ed42dd6d795c647.1616748922.git.braoult@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1616748922.git.braoult@gmail.com>
References: <cover.1616748922.git.braoult@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl check:

CHECK: Unnecessary parentheses around expr
in drivers/staging/rtl8192u/r8192U_wx.c

Signed-off-by: Bruno Raoult <braoult@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 03791613853f..e0d32f7b0ace 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -778,7 +778,7 @@ static int r8192_wx_set_auth(struct net_device *dev,
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	mutex_lock(&priv->wx_mutex);
-	ret = ieee80211_wx_set_auth(priv->ieee80211, info, &(data->param), extra);
+	ret = ieee80211_wx_set_auth(priv->ieee80211, info, &data->param, extra);
 	mutex_unlock(&priv->wx_mutex);
 	return ret;
 }
-- 
2.27.0

