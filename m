Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3E3FB584
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhH3MFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhH3MF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DBCC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so22047938wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAHgeCZ2aQN7mfS6aEnntPuA7ia/SDZIlFdYCZ9jF4o=;
        b=OSFOFuAqKf3goy5aqvTEuxY4R0/5tVaD5DiqZnoLAJqP9CuavD8yx9doe8auBn5ysV
         cFiEXeNcKhFrJvN4EbMieJXobHNLv9umzPrwiPIG6B/WO9WQdEaJsnBdBylCCvhRaNeH
         6eV4VWv+4VGMys/TNHv3PYdsCvvdUYS/xXtUCh094cfiIy3VKxpILXuCXjlF/aXq+mQK
         CudRq7LO/iBoiHf+EXwUkxQaAesaXFa/0ZuMr+NxV5q02YLaKMsSajBhim0ZHhM50ngY
         dCYdiBq6Nz1EWLCDbWk5MW0lJJFvoPcdTHBpRADE88PAlhI+PqWfrGy+uv7ixXbn28iB
         qPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAHgeCZ2aQN7mfS6aEnntPuA7ia/SDZIlFdYCZ9jF4o=;
        b=PTHgwBPcJQUkcC9mvc9ZQ9STlLJSf4oQlAbCiSW4++sAIC3V6RK0iezWpDhkcgyGsr
         TnpzFfTVSzCAipDAQLd2C6X3mYuBOyS6rlkPOemM+yZSjzHZEgYi2DJ32G8JE9A8v7WP
         4D/AKPvtnczTskLiHWCc/+VKedS200zcpZf2sX2/nyIIXIRaP7x0+GUso3AWzBmDphlp
         ylBhAZVjmpeGKVc1oU1ipx4TU2cXQx3dJ5ZFfN0hd5seli9BhKORY+BHmXlJrgkOgnaI
         SfhV02AT1lDB5CN+EhVPIfVf8APfDdBTJ2GxUBuHMvPmhxasVQ+6wz9rrhqLFF+p4FtQ
         XWpw==
X-Gm-Message-State: AOAM532XWJbFRp6rlR9v1HTv692P5n7SZDxFqNJ+SIyJFBqVCgGIn5v3
        O/Cw9G18XCWks9ZSTA00DlM=
X-Google-Smtp-Source: ABdhPJypqxFGS369zI3GE3gLDaemspg7op8bOEXngpu5ewOgDuspaUna0hIi78teLSe1aShNemZycw==
X-Received: by 2002:a05:6000:1627:: with SMTP id v7mr4765552wrb.195.1630325074726;
        Mon, 30 Aug 2021 05:04:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: r8188eu use mac_pton() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:04:13 +0200
Message-Id: <20210830120420.5287-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a custom approach use mac_pton() to convert the mac
address string. With mac_pton() the driver also validates the
input now.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index b3a74198596a..205798b76cf9 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1024,13 +1024,11 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 	if (!mac_addr)
 		return;
 
-	if (rtw_initmac) {	/* Users specify the mac address */
-		int jj, kk;
-
-		for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-			mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
+	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
+		/* Users specify the mac address */
 		memcpy(mac_addr, mac, ETH_ALEN);
-	} else {	/* Use the mac address stored in the Efuse */
+	} else {
+		/* Use the mac address stored in the Efuse */
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-- 
2.33.0

