Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7284F3401A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCRJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCRJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:14:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 02:14:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t9so4658701wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BKucLzdro3KHbFXy/FZ0+97pPZlyAwExs7eXjsBI+0M=;
        b=jsIfdlOWe6yjpjtK2O4L9O9y/+jDQ5vhw0UEJTuOi1LrA1yD3L+r+wT5rl0SfdYTVa
         UVrfyoG/gJO4Yz1ho4uZRPGWQV4SEwLGtahmaRcaJj6yxKDKqgDaVl/GA2PXulmWiC6I
         J2V3MRKV7uGVku3FYl0JjlB8jpawo9mi06W4NQo7sS7LcnMhW2PTsXJAcyZODLWOKdiz
         TQSylPyx9aI4zV/IAozsWOZhKdQgNBzbR1Ti5T6ceuLTm8qLckeoiD1njwxiYA15O7DG
         UgTiCOV5SdyhhajkJpgSe9ZfE+742P3FAmvEN/QA+MPnwTC3yQu3fqb06ZIqcLgZHM+L
         OVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BKucLzdro3KHbFXy/FZ0+97pPZlyAwExs7eXjsBI+0M=;
        b=SUalhrhyL+ORrvbtRKynv7I/3Z4ZNgY++YJRboVmsuBuOsgb6AuuEUXrbpV2CYsXdH
         apT4Gisahr8r5kBLP8ts57deKRM4548ek8OIF1aI5zb2M+H0WucoGt36cbBz07/63XKN
         ljdw5HmzSt4c0MJ8Qp+DY2XyPBhVxdRq9pTPs7JE9N4A1sih7GOFswjgUbkmVU3mbvWC
         e+8Ora3CToMJwETs4v7RZovP9tmhoFYNqyaWauH+jJ2WWYetItB5FqGzMfPRnO4DH3lm
         TwNKI4rAyfkmz7DiDK0158n1CfPWcXHPG02/T7FP4Yc3l3Tgvi5xXmaRU6Os7dBkV3yS
         L8lw==
X-Gm-Message-State: AOAM533fe1Gzna89hpcSwQDXF8VIK12p0pyQXU7bAWQL5E6uMeFJPKt8
        m03rKp+5DeJNSKE9UPpb0d5i1rZLWQsw+Q==
X-Google-Smtp-Source: ABdhPJyBMte5nwgCGcw2rV3ofIP3ipWMWxzKktmx8s9ZDjEIl/Q+tTSFTDyhmTbNVgV5R8Fv9QYYCg==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr8641660wrz.74.1616058857576;
        Thu, 18 Mar 2021 02:14:17 -0700 (PDT)
Received: from agape.jhs ([5.171.80.211])
        by smtp.gmail.com with ESMTPSA id x23sm1540116wmi.33.2021.03.18.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:14:17 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:14:15 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: staging: rtl8723bs: prefer ftrace
Message-ID: <20210318091415.GA3683@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some suggestions before diving in a new task.
The following checkpatch issue:

--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
#559: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:559:
+	DBG_871X("%s\n", __func__);

simply says to remove the line, due to the existence of the more
appealing ftrace facility, right?

@@ -556,8 +554,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	/* set intf_tag to if1 */
 	/* psta->intf_tag = 0; */
 
-	DBG_871X("%s\n", __func__);
-
 	/* psta->mac_id = psta->aid+4; */
 	/* psta->mac_id = psta->aid+1;//alloc macid when call rtw_alloc_stainfo(), */
 	/* release macid when call rtw_free_stainfo() */

thank you,

fabio

