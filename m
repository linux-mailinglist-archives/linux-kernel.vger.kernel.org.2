Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98B420285
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJCQAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhJCQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 12:00:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF74C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 08:58:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l6so9477939plh.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zpKWH0o273AwWKOQiai2l6VJtqelQ9CIZR7+0FF4a/Q=;
        b=KoxV3SM2WFC7MOiOemAi9dqB9EG6YCOd0bOVfTS51nI2G+//Y/5y8N/TpQekZzciVu
         9JGi0znDIAUg00JXJN7PG3PrHpDFR58Uawa1c6CVGVo5uxh0WOizeZJRDcxm6ufkeJ2g
         KPky2EPZurhMRJkLoyyw96p6Yk/F4PcfKuF2nzsRYJef74xH17o+viHB/mEy54iOx4vb
         2YFl0meg9gyzN0d/g72UfH3pa/SRLh1zKky1GfUPSAcZhSmoIY4hV1diiFuZQHU6uG7S
         t/xQUVkQkTFwJmiEES5SdlroWZZ4Kt8g7msCBlALXq34K2Acr0nRnhtkP8NyCa3aoMCn
         CkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zpKWH0o273AwWKOQiai2l6VJtqelQ9CIZR7+0FF4a/Q=;
        b=es4f9AP1jzucG/whAQeDqk/CQL9qqm6Tv6J/Aq6R+n4FjFZ7SnfYkdjuHElvkxBlsQ
         U/4ghT6pWb8ZikfHjXRdtICCOKkFDP0ebK4wWJ0Yuly4r/zX/GtU1/I0LS4h6TjDBwJL
         C28+N4uiEnCXWNAx+0USzUho+mKxLCSWf3AAKxpNgdLOVkUWHdJGpt+/7FhH8hCehVcn
         DNFtwdRtXpTAzNdTDIuTXHhFAi1pR61tb6Y7Mn/pmf4vPNM29QpAPHIZbnQz4GUpllNv
         sm4Sv2249W2YNvZOs9cTm41fCYii2APAacZUH1+Qv5OS9Ggh+UiLqfoJsiHcImo/wOJg
         mmnw==
X-Gm-Message-State: AOAM530DhUhPqbcURTcPSQuKeLiaEnHjM2s8d8ZZiNVb+PaAdRVx0G9f
        Zv9xjHWdLaD6AjIySymYV4FIqENBSjmRlA==
X-Google-Smtp-Source: ABdhPJxRlha2CtuW7W9Z3ZD1BKYKzrLOHNcuEHdyN5zmLYQIwc3tbGW3dq5S34VzpT9TkQ/I4iOyVw==
X-Received: by 2002:a17:903:31c2:b0:13c:9de8:d314 with SMTP id v2-20020a17090331c200b0013c9de8d314mr18954554ple.1.1633276714407;
        Sun, 03 Oct 2021 08:58:34 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id u17sm10423421pjn.30.2021.10.03.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 08:58:33 -0700 (PDT)
Date:   Sun, 3 Oct 2021 21:28:28 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: remove condition never execute
Message-ID: <YVnTJCoz2qsXDXGc@user>
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
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b2c042c36777..3ee4d35ca8d7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3222,9 +3222,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);

-	if (pattrib->mdata)
-		SetMData(fctrl);
-
 	qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);

 	SetPriority(qc, tid);
--
2.32.0

