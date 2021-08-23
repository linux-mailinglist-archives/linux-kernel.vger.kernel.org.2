Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B93F4A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhHWMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhHWMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF907C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so25912732wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nFvKZohSldweLRD9i8ZSMqO75V6j9PCQarwLkmvZ/A=;
        b=Swj+lapReGd5GQnQfLQSBijEKvKGSKfKn4g5L4Ldn92B1Dr53rJ590mzpzCwAcvmPt
         ++b9+OT0BGJJvhQLoIrghzL3EjQJAbZ0hKd6WlYeLLxC4CyYe711xXJz/uuHtxbvA9bt
         yiAfryrEHXyZr5f4le5HdyqKSlNA3F7V+5E0lReO4lG9PwIZcHav8dHoYrpGS0if6U7C
         1JeHNXgphJ7Inm9LBpdPFIOkQxyABE9JvYFbttpznrUZWraLF3K2Z5iBbZiPYO6Q4yO5
         eCGeTS2Vawkmg5Amx7Yd/r4XZ443c2kXG8BiXOY/cpnsB4+kw0+NdVqeQMrEwJ9lf3cE
         fXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nFvKZohSldweLRD9i8ZSMqO75V6j9PCQarwLkmvZ/A=;
        b=hgh+lgps/+hIqdu8RwRt6AlHHdBKxQ+ZJw8W2Z/gJMRiWnHGJQFMFo+bhR5Nk7ewy+
         kmaWM4hayNfCqsHEEX46TjpAheOvtxmiDn2/R/UJXIhjrDG99yuDHg4sK9JcMGXchesE
         VrmhxwzJcjBRP2n5faoo3/TZoA2FB9FcioB7m4xMHwIuSL3hOzFPfimvrBBK2Q+6YY50
         Dzo+RcYPamnl5vsEBSxygNKMekt3PQOZiypF4KxTrFDxcxaCAMd2yxZuhCVTz3hsOrez
         /UJuswBVggn5vKKVHbX0DVHzyUTK7tHISW3IrVZcw6rlQmY0nLgKSbQrAhn7qzKid2AH
         iofQ==
X-Gm-Message-State: AOAM532plHlarJwkA2pSEHl3PUvuESsqC66+bRNhLurPm02Zq5H8gkGy
        kG6oQFTqwj9WIvmFX172BJzNq+TD/dM=
X-Google-Smtp-Source: ABdhPJxb1vFP8+cGZR0EygyTlLOovc+FVMe4tc4M4rLW5mr4JAKjJBuAZExlBefbBgFYxUNCfvznOg==
X-Received: by 2002:a5d:64cb:: with SMTP id f11mr12963203wri.85.1629720143598;
        Mon, 23 Aug 2021 05:02:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: r8188eu: use is_multicast_ether_addr in core/rtw_mp.c
Date:   Mon, 23 Aug 2021 14:01:01 +0200
Message-Id: <20210823120106.9633-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
References: <20210823120106.9633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom macro IS_MCAST, the
buffer is properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 93bb683b628f..e66b7333077a 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -635,7 +635,7 @@ void SetPacketTx(struct adapter *padapter)
 	struct tx_desc *desc;
 	struct rtw_ieee80211_hdr *hdr;
 	u8 payload;
-	s32 bmcast;
+	bool bmcast;
 	struct pkt_attrib *pattrib;
 	struct mp_priv *pmp_priv;
 
@@ -651,7 +651,7 @@ void SetPacketTx(struct adapter *padapter)
 	memcpy(pattrib->src, padapter->eeprompriv.mac_addr, ETH_ALEN);
 	memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
 	memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
-	bmcast = IS_MCAST(pattrib->ra);
+	bmcast = is_multicast_ether_addr(pattrib->ra);
 	if (bmcast) {
 		pattrib->mac_id = 1;
 		pattrib->psta = rtw_get_bcmc_stainfo(padapter);
-- 
2.32.0

