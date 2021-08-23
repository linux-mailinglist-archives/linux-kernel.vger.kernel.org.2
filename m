Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F93F4A42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhHWMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbhHWMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so10555173wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmtc5bJ1VOtrjv9Nl+cOcRNE4MiTt6cvRbrnfn8s2tU=;
        b=mRtp8u54MR2reqhTeDNjaFLpEjefgZY6I8+oWCDMTVcXbCOCc0AjnpRmxl6TNdaUpv
         Rl4xOVr6VhdODxtf6Hf6+JkJdezM875KxBlhTVCIXndBl1oNAkkpN2xIcn1P/PsDAmEM
         8T51SOY3/gqq7n0QEkn3DxmOR+wg3e1nZd/GRRo6gmbAjEJqJh9H2bQ9SFrV9llGA/ke
         XKinT8f+CUe02lenhmSrSUpVs0FhEjw50oy9/7dltvXsq3WQl23TOy4wGsmXetf3e1ij
         ie+uKCl+R94Z9cWd8AwqaS7zodmPwTYPEgAWVc5/T+pAyh8ZGX0OXHhkQN3pknIbVRAp
         4x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmtc5bJ1VOtrjv9Nl+cOcRNE4MiTt6cvRbrnfn8s2tU=;
        b=qgHFQXgbrUQGSYfx3UBvMo4jx+L+o42vGqR2YN4zwGoDN/j9OZGVGNHV0yWcI54TBV
         qmfNuke7tI+q8jvgxq9xXFmvKATSz4CSICijNT7Z26xPgNLWWqjHthMborzQFNFV+Rfc
         5LRDn0BwlTvwv2Oo7/57aHkUUN0NSFKOZ3rY8dDUG4M5O3YZO0130OVwDeFB8ZLns7kt
         YZeN3q4+/Bz2eCzuunYFHY6L4BePoaf7DmCzRRW1zexOw64zpZiZhXk79pQg28b4z0Yu
         kGIjJhnUPFmQbu8ISm55aCtccDjehyLntRuCTfv0n0PJ8fY0M0yODTutYa3ACQyoyWui
         jF3A==
X-Gm-Message-State: AOAM5306uWCNz/vLlnLn7Oxj5CkYJetmxQ6DHJkCMXeA2iBUqNwWWTTf
        urusMDiPGwxUwMz4s1F7azA=
X-Google-Smtp-Source: ABdhPJyTsYrcwTrZF0H7XKtvwgKssKj2T9C/9Wp5lH0exUTQQt7K7SB8sy5g/MjiOa47coagAA1kcQ==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr15946644wmq.116.1629720148836;
        Mon, 23 Aug 2021 05:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: r8188eu: use is_multicast_ether_addr in hal/rtl8188eu_xmit.c
Date:   Mon, 23 Aug 2021 14:01:05 +0200
Message-Id: <20210823120106.9633-8-straube.linux@gmail.com>
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
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index d22b16cc5a30..17be67ac5fae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -167,7 +167,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	int	bmcst = IS_MCAST(pattrib->ra);
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -186,7 +185,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 	ptxdesc->txdw0 |= cpu_to_le32(((offset) << OFFSET_SHT) & 0x00ff0000);/* 32 bytes for TX Desc */
 
-	if (bmcst)
+	if (is_multicast_ether_addr(pattrib->ra))
 		ptxdesc->txdw0 |= cpu_to_le32(BMC);
 
 	if (adapt->registrypriv.mp_mode == 0) {
-- 
2.32.0

