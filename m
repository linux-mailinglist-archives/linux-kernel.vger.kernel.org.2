Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9091E444D60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 03:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhKDCtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 22:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKDCtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 22:49:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46011C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 19:46:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j9so4146335pgh.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=s8xVEJHnK8mxFBkRIjbEvPg/yF4uFDtZoStxlT1zOic=;
        b=Lgs6paIzU01mGAH7RPWiMaEk8o0nn/ApZouOO4ovvj6fEove/OM4Yn8ns5Pf+tFcIH
         MR58i2GiLwVrmUcfPFvUgnmasMkdWP673eswFO2OLesDVc+7Utu5SU7YoZNl0n9k1zvU
         o9jk8n4aIYm8AzP1FJxzIb3nZ10v6eKGtta+eKtwj1TwkhavgRYy93wG4xzXPjrNCqP8
         MNvFmEHTCtJJGGimFxJJH/O0XSXFbSIJ2E3wnSXrpm1D3QCMvYCo1T/W1ndaI35AjGrX
         LUV9kqj3wC68ep+rAjUwiZ2NRkbrYMCs1/89jHbiEpNUERDfcWbbSHvFzidvTQzR6ZBL
         imaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s8xVEJHnK8mxFBkRIjbEvPg/yF4uFDtZoStxlT1zOic=;
        b=MKVdi1ip1ZhR/KAg52gbJ7X8ZrJBZAJNpfQdYCLhsqZkVj9kw6PK+FIpKnMdiZq3Hp
         w+4dimhrChm3taZ8z8Mk4RHIEAWeYkzQGcWCRmOSzCJUpyeKucbEvknrCD0Jz8kFBrIT
         dbH9E0eyPttKc6q7GuG/572URRt/Q+EfiO1qzXFnJ/dnOX//iiPcOg2aal2dI4Ol4yoH
         cY2qd4IL/IL3iDE9ZmSRcBvuxJmkXlS5/Dvx8xAWIre3k7odPUJ9N5kAN1oUyKv/g2zf
         5dW78Hu8LTKWJb/rfXMbCJEnd8du17rfoZK0AxTYueKen7O/jlIGKGInuJEeLkR+Rpm9
         34CQ==
X-Gm-Message-State: AOAM532GEfCvLbu3hGMHS2AFT5D74BjU33RS3wcfvv0hxKg4GB9/tDNa
        KZdh/ipaEk1yADtSRZvs/Kc=
X-Google-Smtp-Source: ABdhPJyafy5NH56iOO7yoAI0vwhQrlL9iKtGWTPBBoNlVkrQWjWh1aycOnBLuNGt3QkzgBnKspDLSg==
X-Received: by 2002:a65:684c:: with SMTP id q12mr2299545pgt.125.1635994002350;
        Wed, 03 Nov 2021 19:46:42 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.218])
        by smtp.gmail.com with ESMTPSA id w13sm2888687pgm.3.2021.11.03.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 19:46:42 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:16:35 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        saurav.girepunje@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove the function __nat25_timeout
Message-ID: <YYNJPCQ5hX8BTzwy@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function __nat25_timeout from rtw_br_ext.c file. This function
can be replace by single statement jiffies - NAT25_AGEING_TIME*HZ.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index bcd0f9dd64b1..4951f835feaf 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -105,19 +105,10 @@ static int skb_pull_and_merge(struct sk_buff *skb, unsigned char *src, int len)
 	return 0;
 }

-static unsigned long __nat25_timeout(struct adapter *priv)
-{
-	unsigned long timeout;
-
-	timeout = jiffies - NAT25_AGEING_TIME*HZ;
-
-	return timeout;
-}
-
 static int  __nat25_has_expired(struct adapter *priv,
 				struct nat25_network_db_entry *fdb)
 {
-	if (time_before_eq(fdb->ageing_timer, __nat25_timeout(priv)))
+	if (time_before_eq(fdb->ageing_timer, jiffies - NAT25_AGEING_TIME * HZ))
 		return 1;

 	return 0;
--
2.33.0

