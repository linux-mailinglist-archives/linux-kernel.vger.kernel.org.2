Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4720A3FB997
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhH3QAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhH3QAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:00:37 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D6C061575;
        Mon, 30 Aug 2021 08:59:43 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Gyw4Y5kDJzQk9P;
        Mon, 30 Aug 2021 17:59:41 +0200 (CEST)
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by smtp202.mailbox.org (Postfix) with ESMTP id F3A63269;
        Mon, 30 Aug 2021 17:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1630339180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KOqLxkiU+/8SIHhRrGil0tG6FLiytivUw+Y1vwHD7E=;
        b=Gx0oCk8l4/W2f09nVNR9rXnw9orFN5ykWxLr4+r/VuC3gsYxFVW0dZMn0cTPWdlFm/ylZr
        smZzyl21ueq2poPRv+pSoEEgSNO3Fqyy3tR4Rzcxd9MJF06qVCLWM6c/6JcgawNKbG+WDw
        vQApaMaIw69dICXeU2lhXkWS4Ho6UlcXd0/oklcIULUWyHguvUWAOPIya/tjbN6o8phfG9
        C2N+IpXA7Vkgp8ebXemZDSoJYVyIyim0INMu31C0xZKqcJMT/BSxbvrc0JQcVRuXlAHS03
        MhnExy6izNbHxGCLW9Eq7dEQbNL/ZHAucb3Zpmr0kYxPMe070dGgyVqCsJgrFg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp202.mailbox.org ([80.241.60.245])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id FmJvOHpQ8Wcw; Mon, 30 Aug 2021 17:59:39 +0200 (CEST)
Received: from ms-v3.lan (unknown [211.58.59.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp202.mailbox.org (Postfix) with ESMTPSA id 794D926A;
        Mon, 30 Aug 2021 17:59:35 +0200 (CEST)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v4 2/2] usb: musb: mediatek: Expose role-switch control to userspace
Date:   Tue, 31 Aug 2021 00:59:03 +0900
Message-Id: <20210830155903.13907-3-mans0n@gorani.run>
In-Reply-To: <20210830155903.13907-1-mans0n@gorani.run>
References: <20210822041333.5264-1-mans0n@gorani.run>
 <20210830155903.13907-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3A63269
X-Rspamd-UID: bb2745
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allow_userspace_control flag enables manual role-switch from userspace.
Turn this feature on like several other USB DRD controller drivers.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/usb/musb/mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 6b92d037d8fc..f5d97eb84cb5 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -185,6 +185,7 @@ static int mtk_otg_switch_init(struct mtk_glue *glue)
 
 	role_sx_desc.set = musb_usb_role_sx_set;
 	role_sx_desc.get = musb_usb_role_sx_get;
+	role_sx_desc.allow_userspace_control = true;
 	role_sx_desc.fwnode = dev_fwnode(glue->dev);
 	role_sx_desc.driver_data = glue;
 	glue->role_sw = usb_role_switch_register(glue->dev, &role_sx_desc);
-- 
2.33.0

