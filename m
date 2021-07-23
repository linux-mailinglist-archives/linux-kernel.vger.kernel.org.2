Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863A43D40B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGWSq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:46:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD3C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:26:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gt31so5062290ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHwCGAY5+wniXoPebuo13yAahRUagGiLTP3xMaCSN1c=;
        b=cQXkPTAMOkgwrSv1SNH3Yu9UD25U6rystuCc6rxGXWSkEVpLDpOSzOKqrrQOHJgeae
         ZyXd1WSGkaDvKL9BfwatsyVGRiXYi/qhOC8+ougOFVWhSsDa3y4NZz1XzpXQw10bM1ej
         Nh+kjTqNBrtp0p7RrKu+N7RTIdt947ZdwhnAhW+rrJUfY7gyEAgOD+JRP6Tx/WxpUsCV
         uehE4xh22msTEufQLNDGNkuy41ucRvkwaPi83br3lpN+OHmrfZH7hUfIT9mfgQUNR+yt
         aDN+sYpXqx6dk+kEXUSp3kGvk2BYtiZnVEhDVBwEwGLcl63ak1yHAItF2+vSnlJ93ruh
         2vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHwCGAY5+wniXoPebuo13yAahRUagGiLTP3xMaCSN1c=;
        b=ZgYTPbM2RajIR40LKSqoRZKkQdRMcPM/wbSoaiiOFCNxMeFXVYEjx1xURU3FSvNDwT
         p0Fq9VjklmK4pcj0gqJmEh1A4CdJJDc+gAnzw2S4HGHHBOB4q9mXjGPeMFl02TOmlySD
         JC1/o7mb3kbbd8b8SXz3cmx0Ml89uSqRlEf5kER7xcgmAjffVsdyH3vbG0harAMBBrC5
         sqQ5VIEoWegMGUQ/OQOfUxbu4WFX4USdM/cBxQ+QDCdZNoM/AClanabdNXpBxMVA+NQl
         Du/IOCfwK44vHYCq9ua8kGW2Ra4/kKS6ndD9XvucoCJW8uUiAK3bXKyTTrWD/dEz/912
         1zVg==
X-Gm-Message-State: AOAM533qMMgEqvHhQPLCQ59dQuupXqvkFh94ipSDradWDb+1cvfi+eqF
        fIzwlMt2O38f2CfdPnygSnI=
X-Google-Smtp-Source: ABdhPJyuMr5/o4o3LlmaD2bzkBA49FpPfrIptZBv7U/mH7KOFyNyrCJeEHunOMZU0hvhIQrbUrxL5w==
X-Received: by 2002:a17:906:3555:: with SMTP id s21mr5883352eja.394.1627068417034;
        Fri, 23 Jul 2021 12:26:57 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id v24sm14621129eds.44.2021.07.23.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:26:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 2/2] staging: rtl8188eu: Remove no more used functions and variables
Date:   Fri, 23 Jul 2021 21:26:20 +0200
Message-Id: <20210723192620.10669-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723192620.10669-1-fmdefrancesco@gmail.com>
References: <20210723192620.10669-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the functions and variables from rtw_security.c that are no more
necessary since the patch that replaces getcrc32() with crc32_le().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v3 --> v4:
No changes.

v2 --> v3:
Join two related patches in a series because they must be applied in
order (first 1/2, then 2/2). Rebase to the current Greg K-H's tree and resend.

v1 -> v2:
Update the commit message with the URL of v2 of the above-mentioned
patch.

 drivers/staging/rtl8188eu/core/rtw_security.c | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 7001f24f118d..7185c1ae2ab8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -76,42 +76,6 @@ static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32
 		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
 }
 
-static int bcrc32initialized;
-static u32 crc32_table[256];
-
-static u8 crc32_reverseBit(u8 data)
-{
-	return (u8)((data << 7) & 0x80) | ((data << 5) & 0x40) | ((data << 3) & 0x20) |
-		   ((data << 1) & 0x10) | ((data >> 1) & 0x08) | ((data >> 3) & 0x04) |
-		   ((data >> 5) & 0x02) | ((data >> 7) & 0x01);
-}
-
-static void crc32_init(void)
-{
-	int i, j;
-	u32 c;
-	u8 *p = (u8 *)&c, *p1;
-	u8 k;
-
-	if (bcrc32initialized == 1)
-		return;
-
-	c = 0x12340000;
-
-	for (i = 0; i < 256; ++i) {
-		k = crc32_reverseBit((u8)i);
-		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
-		p1 = (u8 *)&crc32_table[i];
-
-		p1[0] = crc32_reverseBit(p[3]);
-		p1[1] = crc32_reverseBit(p[2]);
-		p1[2] = crc32_reverseBit(p[1]);
-		p1[3] = crc32_reverseBit(p[0]);
-	}
-	bcrc32initialized = 1;
-}
-
 /* Need to consider the fragment  situation */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-- 
2.32.0

