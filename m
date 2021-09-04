Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FBF400B65
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhIDMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhIDMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:51:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB1C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:50:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m17so1170270plc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hWdLCsJwPXe5S+PDhMU75473QN73+wYuiuXu5T3CTIc=;
        b=qesyA4Cbsvrn1UJfP5GeveoMwAdqJ7Bl6Xe4QZaJoC+bSH+gjY0uDnbZNM1bYldQDX
         mLzolZyOcamwdGinpRkfWrN+ekTVLRhIMjaKb8fv+VtSJUtL242FDaGsH6GJIHbiGh97
         dvajymDDOIzETw2aB+IrrIA5VwtIzcZZYlzfxrdMdfFwQFRQxkOQU4Z7jEMWuk0OzRIn
         TChRUATegYoJBYbdeasDErJhCMpBhHIMD1B/KyrkCwvBbkDcBEBT4/wONIjyfe3L7WSU
         LOxegMOf84uUcjhOuQV3ce67OC9BWgxiAkkUPf2qYLP5O1xR/6FxTaDDI+DwleaYmT89
         IN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hWdLCsJwPXe5S+PDhMU75473QN73+wYuiuXu5T3CTIc=;
        b=Y3smVAeD5NlNNh0Uooeqs4KmWRU5tYj9pprwd12/xYouC7J8ItAdCfWm/C9AItEgYY
         RrY8BvGz7oD+P4klT9sdoA/OO+TXFGNmsZXTPNidY7XF9BnfRAm1xNwcppCo987Q7jZ8
         G8ybzF2Ehb5TuxUeJuf42eFzTNSLijTR0H9NYiVUIYvVM1iz3PIhxG8YYUscr/f1F0ss
         v5Yvcjmbm63dI51VibzTrYvUxgsiVuAxAkhPUUBAAAGmA/ijdiNSfWAnDFGd0Dj3SQwI
         3pDwTIw28jFN+dfBHMo/PVxqrnG0nbjxHOTT+CRI+IZlcxt0yaXaszzNWFWxQ4Va+jkY
         kkiQ==
X-Gm-Message-State: AOAM533WfzK/xPwl8nagJYYOrOAaoRx+3ZgaSj/XJmDfH8g5wL9f0A9B
        lYcd3jsBW07G+HUoKknM6bs=
X-Google-Smtp-Source: ABdhPJzanTEFb4WGTwtpCyV+7oYQG2dwo75cUhClbBqLcoHIHQACiVXN1sZhDc/0Ad+hCccv0z4ujg==
X-Received: by 2002:a17:902:b7c8:b0:138:c28f:a775 with SMTP id v8-20020a170902b7c800b00138c28fa775mr3033168plz.11.1630759826388;
        Sat, 04 Sep 2021 05:50:26 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id x3sm690764pfu.164.2021.09.04.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:50:25 -0700 (PDT)
Date:   Sat, 4 Sep 2021 18:20:20 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove condition never execute
Message-ID: <YTNrjG1y05ByN54+@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove condition which never get execute.
as pattrib->mdata is always zero before if condition check.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 4178b3c1ff57..f314f55997bf 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5669,9 +5669,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);

-	if (pattrib->mdata)
-		SetMData(fctrl);
-
 	qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);

 	SetPriority(qc, tid);
--
2.32.0

