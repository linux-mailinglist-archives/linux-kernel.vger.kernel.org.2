Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD28408C16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhIMNJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbhIMNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:08:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE4C0613E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:04:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c21so6427232edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V69rkmBV3GQTLfHYSfkRm46ouFvvTB8dc9rFkPdH+N4=;
        b=hzIISs98X3O28GPVPgGG3S2iQKBJ1TSBHBqC277SM2ipl/ou8I+hafduL8CJBBp+zH
         2tmw5+S6LnaHgspzzI8GgtNkir2isdn99yVcEsI+Fd3t5sYySPtMI2h5Te+FFFKmIJrQ
         2t9PUO+KGKJsXPnCGXOxH0JmE/k+P7cfzkQHkC4MQuf/HKVE8UCg+a3KgmeOOIQNB52O
         dYeHbzf4UfmH/2PShMW/CfpNZEkxXwJElGs2E0XW05ImA1xOi6dmkZVJKUPpRDJMqe1p
         plIn3j+qGvpEo3a8sq5EuVaJ53i5ks1b43N3ecwyBzPA5Wd2VlVkLxJiYq5CUF9MvQVA
         ORwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V69rkmBV3GQTLfHYSfkRm46ouFvvTB8dc9rFkPdH+N4=;
        b=Kf6x0c5viOcC0GnWDC8Kg4dz0C4l7vvGVl3tG9CuDfNC048iYf1iHIuGE1aBjqARGm
         nAnnDeNUU7k+5TR44ecIH+uICdDLnmnA5V9Zwp7n7EtOtkzuc2njr6bpG3WTLiILtWcz
         IsP0H3hJuF6WuV9vXl7gp1ejO6YyR2aizreNZvipTlIuayor7s3YenvMq8ECo7WBteOg
         uFEGrnAvNDvM6+XhR8ab8PDw87NgUZjjJXZ8rDXvlgDHXrmKoBFGy0L6o3Pw4TptUGAT
         rmbkLyTEvNWnpEpONKb5RgnZzzJijbLZyQFJ4/VsAdaB3fQgCa5QppL+tn5XGubvrHkM
         E+ng==
X-Gm-Message-State: AOAM53108PJjZkUArW6muSCl/S1TOGhBkHL5yfPjx1biO0GVdEu+7PTt
        3f/1nQXCFRuwl+ZLD99XtIE=
X-Google-Smtp-Source: ABdhPJxcVQQ0dSffVIoSF53GEszp5OQOx8RTomDzzVpofor24GI78fPOuE+UX9tEGTlMIVr1z0fXow==
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr13172804edd.236.1631538264036;
        Mon, 13 Sep 2021 06:04:24 -0700 (PDT)
Received: from agape ([5.171.73.21])
        by smtp.gmail.com with ESMTPSA id by26sm1922554edb.69.2021.09.13.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:04:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] staging: rtl8723bs: protect sleepq_len access by sleep_q.lock
Date:   Mon, 13 Sep 2021 15:03:46 +0200
Message-Id: <20210913130346.2390-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

protect sleepq_len access by sleep_q.lock and move
pxmitpriv->lock after sleep_q.lock release.

This fixes and completes a lockdep warning silencing
done in a prevoius commit where accesses to sleep_q
related fields were protected by sleep_q.lock instead
of pxmitpriv->lock.

Note that sleep_q.lock is already taken inside
rtw_free_xmitframe_queue so we just wrap sleepq_len
access.

Moved pxmitpriv->lock after sleep_q.lock release to
avoid locks nesting.

Fixes: 78a1614a81f0 ("staging: rtl8723bs: remove possible deadlock when disconnect")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index bf090f3b1db6..c98918e02afe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -294,10 +294,12 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	/* list_del_init(&psta->wakeup_list); */
 
-	spin_lock_bh(&pxmitpriv->lock);
-
 	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
+	spin_lock_bh(&psta->sleep_q.lock);
 	psta->sleepq_len = 0;
+	spin_unlock_bh(&psta->sleep_q.lock);
+
+	spin_lock_bh(&pxmitpriv->lock);
 
 	/* vo */
 	/* spin_lock_bh(&(pxmitpriv->vo_pending.lock)); */
-- 
2.20.1

