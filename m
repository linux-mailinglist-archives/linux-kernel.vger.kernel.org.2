Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4E3A72E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFOASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhFOASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:45 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id if15so10616281qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arf2O8mNj2CjfUwpKned7GmEP+iVp6VeDjXoD+oq6Gk=;
        b=eiBBJLYnzvTgFwQ3ZS6i7Q5rVcwrTBg6w6TRnsgKZI9BgH50njJXCGuafILLGjUWAx
         wXyf9lPhtNfk5utiV8gXz9lUh9MxSj/xfTy6p3p+SYbav0SvXgp4P/tAyrYvDkgSFF4P
         3sNSujvIPQoZppT20YCvwJNPcjLaj5AN0qawX+21J/H6XO4COJoZzW92GcIdc9Syo4xc
         RkF6GbfWC5xtrs/e+ygmZ3gGA4PXezpV5bIe3LY3N6sQewPoz3B9OugkMFaGiA+oQjDW
         5QZPYLlOKb793WRfVV9Kjym7Ey0HppLLstUVW5G0MtYwLXov7O1NjtCi9Uw1BeMUriR/
         zznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arf2O8mNj2CjfUwpKned7GmEP+iVp6VeDjXoD+oq6Gk=;
        b=OfvcEOLYaZrSUa644u+QEAE5nESlEOPzJQejEinETtepQC1g1RKMYnQciUi8mHoIjW
         fKhB4J4aqkqnPuXoQvKHuxqPoyaGlNfhI3ojYlucKVSZVKwuLwhwg4PEo/cC3tV6MhMY
         IVMxA9E09AZeU9xoiQfczE74n9WETqJYjbvvxvVGZ3bmIxUxowSNl5GJUO735aNtusKI
         RerWTA28lo9C5iQPFsOw4agrw+gJoGCDmloUya3w0oyJGY5NGxyNPLOOAh0fH8XwW6su
         //Utu4s0Jxk+9jFtBbaTY4jfqlWLUb35LCwy/vLSWhaKX0JMkcOlmtcgaJJZnhvoHDBA
         PC3g==
X-Gm-Message-State: AOAM532YPcWsoKiu+wONuQSwa0d07u6VkSQ7uoJqJBdjiisABMDXtu1E
        G2GFRPfiAXvxjiDtAh4ANwq6Vg7W/3SDb5Ic
X-Google-Smtp-Source: ABdhPJy2chXCy/XcQ2wBwS2HDq3sEZxaI11zxGHHQHGhkx5c3Ueh6JDTsUT5afXPM5BKFBGbNhdy2w==
X-Received: by 2002:ad4:4c0c:: with SMTP id bz12mr1898654qvb.21.1623716185180;
        Mon, 14 Jun 2021 17:16:25 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:24 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 21/28] staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_xmit.c
Date:   Tue, 15 Jun 2021 01:15:00 +0100
Message-Id: <20210615001507.1171-22-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/rtl8188e_xmit.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
index 9b8a284544ac..0d5608766a0e 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
@@ -33,25 +33,10 @@ void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
 	rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(dmp_txpkt));
 
 	if (dmp_txpkt == 1) {/* dump txdesc for data frame */
-		DBG_88E("dump tx_desc for data frame\n");
 		if ((frame_tag & 0x0f) == DATA_FRAMETAG)
 			dump_txdesc = true;
 	} else if (dmp_txpkt == 2) {/* dump txdesc for mgnt frame */
-		DBG_88E("dump tx_desc for mgnt frame\n");
 		if ((frame_tag & 0x0f) == MGNT_FRAMETAG)
 			dump_txdesc = true;
 	}
-
-	if (dump_txdesc) {
-		DBG_88E("=====================================\n");
-		DBG_88E("txdw0(0x%08x)\n", ptxdesc->txdw0);
-		DBG_88E("txdw1(0x%08x)\n", ptxdesc->txdw1);
-		DBG_88E("txdw2(0x%08x)\n", ptxdesc->txdw2);
-		DBG_88E("txdw3(0x%08x)\n", ptxdesc->txdw3);
-		DBG_88E("txdw4(0x%08x)\n", ptxdesc->txdw4);
-		DBG_88E("txdw5(0x%08x)\n", ptxdesc->txdw5);
-		DBG_88E("txdw6(0x%08x)\n", ptxdesc->txdw6);
-		DBG_88E("txdw7(0x%08x)\n", ptxdesc->txdw7);
-		DBG_88E("=====================================\n");
-	}
 }
-- 
2.30.2

