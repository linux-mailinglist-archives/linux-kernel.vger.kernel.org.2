Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC733E1469
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhHEMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhHEMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:06:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A09EC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 05:06:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cf5so8039643edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ertoc34XQ2YSK37Kysk0lOwTGhFvoRTCVq5kxbjqo+U=;
        b=CBxWj1sSeE3vi+yhdMWpQOTw8qlPx07H7aWU82ZZquLz8RVcAWTAj+jFayZbVo/Wk8
         jBhAV8A4IIZIa6x1sr/vT85pT0plwJCgnmBQ9TrHnb66D/dGxuPebqs1JAh/8JorQi1w
         KhFut1dy8BPqhMqMeACjbnASxGg6CrOYJxRDMnUF2X+IWw/+WwXhrMR0cWYM3Mvi74u0
         yQMnSc7lytZy70YY0zXPf9VjS6MmrfpnlVnbmjy9EDIgwjoCHo7rmS06zXHTglc5/GVM
         ljwJUo33GriHSpEbeXujiRCORyhl7pjJGT73s62vgMDMPjGVDvbOKJrRW57hwzn+XmaP
         CgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ertoc34XQ2YSK37Kysk0lOwTGhFvoRTCVq5kxbjqo+U=;
        b=XClJT7whE55FdCix2dlloFWdWMPaZ6OQ7nHTqdtOibelgsIgnvY0+wOOF+2vOYH7r8
         i8zgJnN+RymcnsPTPvvuDTFuiIxeDwytYdggOyKgCU/rubYhehacsrZCqfwVCkxVRXPM
         C7qJiDSrdCs6gf+iMVDnTgwMjAmrq29Pxq/GgxOcN7rg8/x0iEOT4K2lEXwaNEJeAyMl
         BstDPGOL/2VLmkYW1gkn1O4PWKkfR8aIw758NgfBEfK0QJLh8LIYNcdCL25uwMY1/dEp
         WJ0pdRWl9lmaG92d1R65uFmPwVpDl+VZu1eO/+rJ2Qqe0OW+fxpfHQUHdvAyRoKp5nbr
         1pXQ==
X-Gm-Message-State: AOAM530g5x3oB4fFYqv1rkYEC4vzqKlV8u4LTo5++sR3RKDuOzajoj7f
        oFHbcvhibhfdyNe+sROJAxA=
X-Google-Smtp-Source: ABdhPJw8PM+trx4KYu7wd3tmbcRq1jQ1J2yfZxOZ69fA3kgSsqHHa4YQcb9VfcIxLrRJqEpXwdot4A==
X-Received: by 2002:a05:6402:d4e:: with SMTP id ec14mr5891853edb.277.1628165172143;
        Thu, 05 Aug 2021 05:06:12 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id c6sm2191565ede.48.2021.08.05.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:06:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove unneeded comments in rtw_mp_ioctl.h
Date:   Thu,  5 Aug 2021 14:06:09 +0200
Message-Id: <20210805120609.28588-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 85143bdc731b ("staging: r8188eu: include: Remove unused
const definitions"), some comments are not anymore needed. Remove them
too. In the while, remove also a line with a void comment.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mp_ioctl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
index 0376ddbf6011..cf99f39a582e 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
@@ -11,7 +11,6 @@
 #include "rtw_efuse.h"
 #include "rtw_mp.h"
 
-/*  */
 struct cfg_dbg_msg_struct {
 	u32 DebugLevel;
 	u32 DebugComponent_H32;
@@ -52,7 +51,6 @@ struct dr_variable_struct {
 
 #define _irqlevel_changed_(a, b)
 
-/* rtl8188eu_oid_rtl_seg_81_80_00 */
 int rtl8188eu_oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv);
@@ -60,7 +58,6 @@ int rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_p
 int rtl8188eu_oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv);
 
-/* rtl8188eu_oid_rtl_seg_81_80_20 */
 int rtl8188eu_oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *par_priv);
@@ -78,7 +75,6 @@ int rtl8188eu_oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv);
 
-/* rtl8188eu_oid_rtl_seg_81_85 */
 int rtl8188eu_oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
 
 /*  rtl8188eu_oid_rtl_seg_87_11_00 */
-- 
2.32.0

