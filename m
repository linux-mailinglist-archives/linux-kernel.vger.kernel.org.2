Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C14202A0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJCQUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 12:20:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79398C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 09:18:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y5so9518963pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wiTJBRq4UGMODPvYEyNV3oB8d3MZ6hINzZgUpTIRnFg=;
        b=IGbTGR7afZSkCOXJtiwKxmYnVPo/YCvglOkp8k+Idl5bj3Nx33PZAKES7kGhM8sr+P
         24JXDMRDwgaYISibW5B6jV1QN1YT5Ne0hvrSwoNO/EzxX8jrgo7z7S+vvchMLumyrIbi
         NKJbzfMFAjz8Gg6Yn0PH2v9PbJ20n8mxtQ84jLlPKAXIv5sYGZST6zS0G4BcmVLbLT6h
         2ai+1WmyO9XbCxTuR0pO/V4mUQna8jW/Ybc0mfNkBcISSHvxzrh7k4FlNVqxMjNOV6a4
         cqtu99qOjMO42zyV+bLV6p5gP7mtHVCXvGtnNQSzYdwkKZDY98T1g5Mw6i9VmGDYV+2d
         c0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wiTJBRq4UGMODPvYEyNV3oB8d3MZ6hINzZgUpTIRnFg=;
        b=Yp3DZwk51Dr7EcTFFBhj082+Rm71mAsiVZGWxmAG477tl/hMXvVm0FC2BNxnhkSvzB
         UIqsn5/VrmWQxaedVxbApcgadpjgZhkPLgDJB0JGpgwQWQsTXQ+iilCV0RwhlfjZpsRZ
         wd/rUAsQZDxCihEYesHjrTrXCw+RAI3/gWG4ULnHISOIRfhH7mmMs4P7Z1YR93v9fqlF
         6raMM83AHDmVVIyesZzE28Z5lUzt1C/BML1Dug2A2MpM2oo/lq8AZyADxlJAprSoietM
         Bt+Dp+Mp0++FsQ+UPr5w1lTwAxtm+c3WcpRzSaKohbQRS7lOjLVUOk9EtaCl4cZMfiAo
         G7fQ==
X-Gm-Message-State: AOAM5310IH021t+sIMSGNP5fHHZ1fgPpqQDLjqSQ8RpuI6h87qqRMUNP
        TtkYHFpFDsaueFXWmLgaWag=
X-Google-Smtp-Source: ABdhPJz9pjwAe9gvabiDAnDEiwL4XOcxppxKmiMf3zIyhLzVJ9TemVfVQcAvo1qW1L2B2ABPQ1wAYg==
X-Received: by 2002:a17:902:7d89:b0:13c:a5e1:f0f1 with SMTP id a9-20020a1709027d8900b0013ca5e1f0f1mr20512815plm.24.1633277914803;
        Sun, 03 Oct 2021 09:18:34 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id h13sm11364173pgf.14.2021.10.03.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:18:34 -0700 (PDT)
Date:   Sun, 3 Oct 2021 21:48:28 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: remove reassignment of same value
 to variable
Message-ID: <YVnX1HIYoisW621x@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reassignment of same value to variable pstat->auth_seq.
On if (seq == 1) assigning the value 2. At the end of if statement
also assigning the value pstat->auth_seq = seq + 1 that is again
assigning the value 2.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 3ee4d35ca8d7..059cd85f4b03 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -808,7 +808,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			pstat->state &= ~WIFI_FW_AUTH_NULL;
 			pstat->state |= WIFI_FW_AUTH_STATE;
 			pstat->authalg = algorithm;
-			pstat->auth_seq = 2;
 		} else if (seq == 3) {

 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
--
2.32.0

