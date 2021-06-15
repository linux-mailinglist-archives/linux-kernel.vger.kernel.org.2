Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70843A72F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhFOAU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:20:29 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38499 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhFOAUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:20:22 -0400
Received: by mail-qk1-f180.google.com with SMTP id c138so27449351qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2RtLeUvNWeQVpxnunV3kXh/kArwBIjO2OgKILZ+2XQ=;
        b=00QJ6XzDtYVN0QpYNWqlEc1VolxQfmOSwH0rO4G5xSQIys8i308FCLdvixZ1+vAOEN
         JkGnvnCHZBvetSmZ9WxuyUMdB1iQwfOz5YMTyBkoczaoQ9smgsMnxiTaZFn2esv4Zedr
         ojO6nvqhPkPFVyijw/zE6PNby37+zDMdtFlNauH3Pj2t2/NtjajKOvVbhHE1OZft/dnj
         Xo7FUF/QshE3G/adPdKE5hqjb6rsHoVHML37qq3nhiVyX0j0XmKYdUsxmj6dIPtxy+3q
         Wco4e3veoM6varbP05y8L9xF2Qt1cCeyUZw6yjrje2sxCqaXoQLDKN+gcCAgaVuHRj9P
         2tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2RtLeUvNWeQVpxnunV3kXh/kArwBIjO2OgKILZ+2XQ=;
        b=fY4oKR3aj6DZ+PH3+dJPtrH8ISXzxsaTnze502eW8RQSZfwzImDBandD7tJ0QLZTuH
         J7ZB+U+985YCppFY9vQfdovzkBhbdhFIiMQe4xEj+18/V8UyHnYMZ0N/omMWdKIAiLBw
         tTDeyZ7CrXHebLo1uzy+EHQzHp3FhHvTidGNbSIFuRca+71AHeReHPFwQHIlBNjNruM2
         bO9BCHFs4nNZt2u2THirYzfwhb9uyDAFtloDU8Arw69OROx3TSLy5cbhs0B0XCAFF+S/
         6tvGRHweHQVz0EfQ9p+RYoZV+i3tMR+kJBqyjIdTV5uYufuYORf9uhnREtNMYv62/6Nf
         7WTA==
X-Gm-Message-State: AOAM5328Vblz2nzSZF33jq0p2+tEnWgKqfu48D8dh5GJ+iHnfZtqmiOd
        bk6e8nVXQU21Tzmsr0QthOe2uA==
X-Google-Smtp-Source: ABdhPJwCJ45piE7Op7TVbmTKqsC0J1THpb+rlNxlexqQk5XAteuBV9+BfiTP0GddgRXYSMoc+40+pQ==
X-Received: by 2002:a37:f502:: with SMTP id l2mr18624271qkk.195.1623716224947;
        Mon, 14 Jun 2021 17:17:04 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:17:04 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 24/28] staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188eu_xmit.c
Date:   Tue, 15 Jun 2021 01:15:03 +0100
Message-Id: <20210615001507.1171-25-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/rtl8188eu_xmit.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index d82dd22f2903..7ca0a45dd0c7 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -287,11 +287,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
-	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
-		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
 	} else {
-		DBG_88E("pxmitframe->frame_tag = %d\n", pxmitframe->frame_tag);
-
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32((4) & 0x3f);/* CAM_ID(MAC_ID) */
 
@@ -620,7 +616,6 @@ bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	if (res == _SUCCESS) {
 		rtw_dump_xframe(adapt, pxmitframe);
 	} else {
-		DBG_88E("==> %s xmitframe_coalesce failed\n", __func__);
 		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
-- 
2.30.2

