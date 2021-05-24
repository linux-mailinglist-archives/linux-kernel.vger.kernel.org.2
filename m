Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6638E8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhEXOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhEXOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:39:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:37:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso10632602pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3Uq4oq7Ompa2kiUFdgBYSmuttV60/M5LDy9XENGK3do=;
        b=k+aKf2H8gnaq7huzoijV1mzwXt70AEwvC8SHlDkj3OH5AOfd6O37hhTd7rMStl5hYQ
         64xuvFd+kWMAQ0IJrGR3vZJENa2udBI3RgQksm2zvfgK7WQlbkVFf8cWihznwslj344h
         CelkfpM6o2UVg35rncrstBiAQjZBFkKQ8zc9nSYNBUREp4jcWVgqeBKLGHW0tNqUeAXP
         wxMe59Lh8ZKPWfmJY1T2M+OvlY7RINp7Dsv19HqEJrbm639Zy6wN7r0DaNMURnD6FQ7n
         KHilOFFcpr92/Cx9fVYJ8t2TPLxgikEpiH0fbg0L0vO6VGcCMomZHoQLmU5DHrTfctZP
         9k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3Uq4oq7Ompa2kiUFdgBYSmuttV60/M5LDy9XENGK3do=;
        b=GHy3vUreSP8A4NVfNaNK4dN547rvg5Nu9Gy8s9zmJX1h3mTrnWeKkELSrOcjjUv7X4
         l1L0g6zkQ5GcNvMSMktIFd1ttHW/E9tN7oTGNHfNqt0yWY7KC45XdSUmagfRALBnd04w
         RpxDWw9Hl0l5XOPhwjPr3nCZiZ1lwQSDjjDehjYSpJ1j6T0r81YN01C4rjImmvQkHIHS
         RX3D9lb13wUOE10Uq+FlhnuxTBzb5wsbA5LSZbC5IQYz6eHBmfIyH9bCIA4OtZb0pezm
         JUPkenYeu0hYcg9Qn+C0r18hH5g6GjoBquMZeKr2mPh60J4T23BzLm/NYO1RITU0wq08
         eQDA==
X-Gm-Message-State: AOAM530xzsVEvT5VF8I6bRfXAZ9vmWSoI34tHlRAZ/KAW0XKfC7SCwkS
        4E4AEPNSf8UBQhjbKuoZ/+Mi+n7SXZsPyG9dD/r5tA==
X-Google-Smtp-Source: ABdhPJweshDCbXtZRFtCR4Rs+ZXY/9ytLALf4IYhT+aW0M48GTy+GVqY75S8SaAMsTPY934Lnyr4Zw==
X-Received: by 2002:a17:902:c951:b029:ef:9dca:9943 with SMTP id i17-20020a170902c951b02900ef9dca9943mr25960614pla.62.1621867065091;
        Mon, 24 May 2021 07:37:45 -0700 (PDT)
Received: from cryptik ([2405:201:4018:90:22f7:c0a0:5144:ae09])
        by smtp.gmail.com with ESMTPSA id c3sm10996774pfi.213.2021.05.24.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 07:37:44 -0700 (PDT)
Date:   Mon, 24 May 2021 20:07:41 +0530
From:   Swapnil <swocp19@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed kernel code formatting
Message-ID: <20210524143741.GA529321@cryptik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed lines ending with '(' by moving an actual function parameter from
the next line to the end of the current line.

Signed-off-by: Swapnil <swocp19@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index ecc5c9da9027..b6abd3770e81 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
-					p_buf_32->dw);
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
+					       p_buf_32->dw);
 
 				p_buf_32++;
 			}
@@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 		return;
 
 	if (ep->epnum > 0) {
-		length = _nbu2ss_readl(
-			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
+		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
@@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
-- 
2.25.1

