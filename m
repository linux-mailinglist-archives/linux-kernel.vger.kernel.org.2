Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539F83FF765
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbhIBWs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:48:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:33924
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347772AbhIBWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:48:59 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0E04940178;
        Thu,  2 Sep 2021 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630622879;
        bh=3iDBfRvhomh9X+gFCqZtgh0m4po45XBVC3v+ri4pzy8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Gc4ayHRKr1vSqhh5tEj1ZQ3g7lpw+dtOyjwt++ZFrfwC/pMTtbxhK/co7yj8OCHdS
         M0ktAzfJTdhkuH55J5lLq/S/vi8G6EV/ldipDTNWoO522oMl8HmQlnsXm/an9X1Xh3
         H9dYfYK7vkBgGCsNAdBN+f5Y+e/8OD+UniNsCdNTJcIyB632HUpSvZ+8guCQY/oHme
         eRtZ0WaYVyZ9NVaIby2LT0SgPmBWohpzI8qVVDJGVxKp8DTzo532ym65otNmV9XGrV
         naTPEMqcLaNEaY18BxfWlDxzrDAKBkV6pveFC6kMPHyq5e0Qv2pf69umsSm3/Lqodh
         /8DzeBjW+IV/A==
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_uac2: clean up some inconsistent indenting
Date:   Thu,  2 Sep 2021 23:47:58 +0100
Message-Id: <20210902224758.57600-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are bunch of statements where the indentation is not correct,
clean these up.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/function/f_uac2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 3c34995276e7..8659784dcc78 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -743,15 +743,15 @@ static void setup_headers(struct f_uac2_opts *opts,
 		headers[i++] = USBDHDR(&out_clk_src_desc);
 		headers[i++] = USBDHDR(&usb_out_it_desc);
 
-    if (FUOUT_EN(opts))
-      headers[i++] = USBDHDR(out_feature_unit_desc);
-  }
+		if (FUOUT_EN(opts))
+			headers[i++] = USBDHDR(out_feature_unit_desc);
+	}
 
 	if (EPIN_EN(opts)) {
 		headers[i++] = USBDHDR(&io_in_it_desc);
 
-    if (FUIN_EN(opts))
-      headers[i++] = USBDHDR(in_feature_unit_desc);
+		if (FUIN_EN(opts))
+			headers[i++] = USBDHDR(in_feature_unit_desc);
 
 		headers[i++] = USBDHDR(&usb_in_ot_desc);
 	}
@@ -759,10 +759,10 @@ static void setup_headers(struct f_uac2_opts *opts,
 	if (EPOUT_EN(opts))
 		headers[i++] = USBDHDR(&io_out_ot_desc);
 
-  if (FUOUT_EN(opts) || FUIN_EN(opts))
-      headers[i++] = USBDHDR(ep_int_desc);
+	if (FUOUT_EN(opts) || FUIN_EN(opts))
+		headers[i++] = USBDHDR(ep_int_desc);
 
-  if (EPOUT_EN(opts)) {
+	if (EPOUT_EN(opts)) {
 		headers[i++] = USBDHDR(&std_as_out_if0_desc);
 		headers[i++] = USBDHDR(&std_as_out_if1_desc);
 		headers[i++] = USBDHDR(&as_out_hdr_desc);
-- 
2.32.0

