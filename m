Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071AC3E2019
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbhHFAlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242934AbhHFAlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:41:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F3C06179B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p5so8847895wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adeGQT1yoHTQPelS1dZGw9hZb+55BhHHSPoGSS3Br6U=;
        b=R+tm9Q3EB7YKjlcv0XvaEj+HFM30acGyjGoRpngXbuGQIcW5xdgzcw4OqpOaHKjlm7
         rolBQC6s19S4fCMxy+uUGsI2yDuSuUrgFcyjTz93IWolBlYYwY/1NbqdbUhn69mB2EX+
         uI0F+c0YseUXarn81p0kMIoTkdYrebvWCQ5VcSJO04z2WWMgYk3fgkiW+gFaOr89gL1i
         NMVKRQB8lvkJWzO+ufQeg6WCT1+J/R08oPVfitmuUSLsj+NUhqrJKELB8UlgITFp7wqD
         67/+FeKBU5zc6iixghF+f0NbyRqNqGk5/k/e2R+RgzjAX7xEBTMo4jE1MlrGQjnM53hv
         XsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adeGQT1yoHTQPelS1dZGw9hZb+55BhHHSPoGSS3Br6U=;
        b=dINTjsOMOQaPltMGCpwrhKlSq2IFm9YEmWNlRMqOqsAf8UwSRgkUaU9AabfyUby1U1
         B1FQuT64H8GotwZ5PRrVNmn1UBqrf4RTLC+8GfGj9GeGj0518Uu+L2XnGfkvL05ASICG
         Aqc7uTh0iMoaoqhmcrQFRJPYQT6ED9fPGgfY4gTAZy2rb5joqzB2Cpw4+njmAy0LK9/D
         0AlxxNF/4r50zLVfYKLCYF3w4/hDlV9ZasN9KfNjskPhxZxuHI0t4pOO+1T1v4KEHlMg
         WVHtGU1Co2yATq6G6YGbySCOsyqsebXIg6mQ2dUhEwecLXXeUMb2p/9MTbgPx5rLx87H
         eP+Q==
X-Gm-Message-State: AOAM531f4Bx09cmQEUtXitYJQtBzxFnNVKzuYSpVRIZUUnU0Cndf52Z6
        9ybg0bW8N5Lwzi1LWqFD+ufNNA==
X-Google-Smtp-Source: ABdhPJxrG3/1HHeZJzPrkFw5X5ME97jSfVAE7VTQQ0rc/Oo/9y28kyOvXM2q8I/LrqPTsK6tDnDwgw==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr7928217wrv.20.1628210446470;
        Thu, 05 Aug 2021 17:40:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:46 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 11/11] staging: r8188eu: remove two set but unused variables in core/rtw_mp_ioctl.c
Date:   Fri,  6 Aug 2021 01:40:34 +0100
Message-Id: <20210806004034.82233-12-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two set but unused variables in core/rtw_mp_ioctl.c to fix a
kernel test robot warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 8fcc74598e5f..fed94d66aee0 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -668,7 +668,7 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 int rtl8188eu_oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct mp_rw_reg *RegRWStruct;
-	u32		offset, width, value;
+	u32 offset, value;
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *padapter = (struct adapter *)(poid_par_priv->adapter_context);
 
@@ -677,7 +677,6 @@ int rtl8188eu_oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 
 	RegRWStruct = (struct mp_rw_reg *)poid_par_priv->information_buf;
 	offset = RegRWStruct->offset;
-	width = RegRWStruct->width;
 	value = RegRWStruct->value;
 
 	if (offset > 0xFFF)
@@ -1093,7 +1092,6 @@ int rtl8188eu_oid_rt_set_crystal_cap_hdl(struct oid_par_priv *poid_par_priv)
 
 int rtl8188eu_oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 {
-	u8		rx_pkt_type;
 	int status = NDIS_STATUS_SUCCESS;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
@@ -1102,8 +1100,6 @@ int rtl8188eu_oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 	if (poid_par_priv->information_buf_len < sizeof(u8))
 		return NDIS_STATUS_INVALID_LENGTH;
 
-	rx_pkt_type = *((u8 *)poid_par_priv->information_buf);/* 4 */
-
 	return status;
 }
 
-- 
2.31.1

