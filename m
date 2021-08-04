Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9223E0184
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhHDM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:59:29 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:49338
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236777AbhHDM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:59:22 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 99F253F0F9;
        Wed,  4 Aug 2021 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628081947;
        bh=gRYiPHltXl1ab4ROKl548BWP/IqBGUAthHnSDS3smEw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=rUEGUoWsIo5Q0hwJx0wDVffZe1p7bBrU/MjUaAXMADlSYYHWOF/nC32quaBeWo0ER
         BZpPdoWtYm8WSZ1EQ0QhUDK2PzgHqICAHAhsTfrIqR/qeUqauea8+K/kUnsJ58uqUS
         rWCAP/QjzKcHqz5owAcjxsA4IYlstfLOdKOejyH8tlfZOmiZbdOj5HZI4LG6IsP8fX
         f/YekIg9NaH85GEIyIQLmK9/qUfbGo4RD7Wt0056wH2VCwX8cwDFACITiyIbdPY6ye
         Dg9YOACgKB+QMCQs6PoIhlEmkirMnkbvaCAjZgmEqinza6mK2Ll8Acs3I6DcTKG8Vz
         Vjr1rcDi2L07g==
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: f_uac2: remove redundant assignments to pointer i_feature
Date:   Wed,  4 Aug 2021 13:59:07 +0100
Message-Id: <20210804125907.111654-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer i_feature is being initialized with a value and then immediately
re-assigned a new value in the next statement. Fix this by replacing the
the redundant initialization with the following assigned value.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/function/f_uac2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index b9edc6787f79..3c34995276e7 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -970,17 +970,13 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	std_as_in_if1_desc.iInterface = us[STR_AS_IN_ALT1].id;
 
 	if (FUOUT_EN(uac2_opts)) {
-		u8 *i_feature = (u8 *)out_feature_unit_desc;
-
-		i_feature = (u8 *)out_feature_unit_desc +
-					out_feature_unit_desc->bLength - 1;
+		u8 *i_feature = (u8 *)out_feature_unit_desc +
+				out_feature_unit_desc->bLength - 1;
 		*i_feature = us[STR_FU_OUT].id;
 	}
 	if (FUIN_EN(uac2_opts)) {
-		u8 *i_feature = (u8 *)in_feature_unit_desc;
-
-		i_feature = (u8 *)in_feature_unit_desc +
-					in_feature_unit_desc->bLength - 1;
+		u8 *i_feature = (u8 *)in_feature_unit_desc +
+				in_feature_unit_desc->bLength - 1;
 		*i_feature = us[STR_FU_IN].id;
 	}
 
-- 
2.31.1

