Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB6460B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376418AbhK2A0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhK2AYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:07 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993AC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:51 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id m25so14712044qtq.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGalONJjum8+BTCilr/6jTZ2Yy0ur45TjitrLdlzsXE=;
        b=JmjNbHSSE+LeDUfc62PHSleBpZ/2IvXEV0avhyW0e9HzmbPYhEY/iZLoVVh3vGYFVa
         ir7pvE8h/PBY/WH+mCRkiIV5msI58O4R+S2YauZVixpCgUSp7BjxLx1MqLcmi9Xc1rkA
         3X31V+y76OYzcO50TXmO6BKhpclfGL/XTHnr9wTPRsM8YBmKjXe1xW9XiOvyRywrS26P
         lb2QxoMvfStlZ1+NVqqMb8uBVuqrqVWYotrMijuoXL0WPwEDzbgw2KepMxkEItgVoQvZ
         kvI2QAeod6J1EwhGWRfiBVwEetZ2JrXmq/ARVNWnexObktuC9D62yeO4HznY+TtjdINm
         QEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGalONJjum8+BTCilr/6jTZ2Yy0ur45TjitrLdlzsXE=;
        b=IOppEzs2/GptxDgaJ2LO8imfBfNSm3xcMgfG4YComvi3swoN61x/JkbcX1OpIkqMHL
         wGzDZOSVIODMfd+mcPcdzJgJkinilIl6vxcko9lMYmzsYVEMESw253RpgoBeJ3IsNHi4
         z0KRbZdAc5KJpMg9DjpkjKOAV9CKahn7tNDsnpU7BWPtJrBdIARTpnBMV0OXxAgBrlhw
         Wv4tXoXVRGDh6+UwEhVoeiHoFFtlJtRC5DNveHlvGIyasBPrp5cul2n0QXbjtR8TEZke
         MwZjMQ70Z8Wp+9AebCcBi2iDqaMJaQiJBvI+V46zldaiXMyqKod5RDixNdXPVxv5F91z
         jFDw==
X-Gm-Message-State: AOAM532N4TfyPLI6SSFwiHQdzNc9I4Kl9+MI9/GIRCyxUdddiyVBTpop
        RdBR2VQ9zRFJXHcdvuDi7O7nHA==
X-Google-Smtp-Source: ABdhPJzBz2buafsxbc5aSGnsT0eoavjN1Blo7UiQJItNDS5b+RYVSXS4OyWV2YIWjPRoJzBlFoC8Ig==
X-Received: by 2002:ac8:7c56:: with SMTP id o22mr30602254qtv.524.1638145250464;
        Sun, 28 Nov 2021 16:20:50 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:50 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: r8188eu: convert DBG_88E_LEVEL call in core/rtw_xmit.c
Date:   Mon, 29 Nov 2021 00:20:37 +0000
Message-Id: <20211129002041.865-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129002041.865-1-phil@philpotter.co.uk>
References: <20211129002041.865-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert single DBG_88E_LEVEL macro call in core/rtw_xmit.c to plain
netdev_dbg call, as although the information is potentially useful,
we should be exposing it using standard kernel debugging functionality.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0c033a077bf9..8503059edc46 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -461,7 +461,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			}
 		}
 	} else if (0x888e == pattrib->ether_type) {
-		DBG_88E_LEVEL(_drv_info_, "send eapol packet\n");
+		netdev_dbg(padapter->pnetdev, "send eapol packet\n");
 	}
 
 	if ((pattrib->ether_type == 0x888e) || (pattrib->dhcp_pkt == 1))
-- 
2.33.1

