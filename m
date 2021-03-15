Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B980833AFD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCOKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCOKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:17:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g20so7770811wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=483MsuDXnE3RLzpAgeT1+D3H8iMhTgEIGI+7YS5vbGk=;
        b=gUJ+iDOd/hrZQ8CclyK4m6pm5Cq9McQVETEe3Zjf22sJ28FDACVqmGUJOlegK2Ipvn
         sqxGwlEGVAAFKJS0V4SyIbOFYf480OwRx8fEkXU5CGxRUy/p684/a04hmHbpjIUE1yli
         ca5Np78hHUUn0GijVoXU19YnWtRD4hROVi5gJhWB2YfZUMdAl7k/y5b37Wiew1FVKVSf
         RI4mO2VRRqiY7FZQ+bH0tFvExc86tajcJC1+8H5LF/Ck+QnFos78Tquh/EKXyvYDTVtB
         +KTgBN4+m+ycHndtp1Y8HCfEhdUNIbn2tM6ZUbzXZpdhDq7ZgycASU0GziJQo3cc2wlv
         F8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=483MsuDXnE3RLzpAgeT1+D3H8iMhTgEIGI+7YS5vbGk=;
        b=LCouqsSHMD8mRwx9vYmtigVcsfAzDEknkgp7ACq7fWtm3Nf+etVbUv7rYc50X5NNGi
         Xb0EMKLPAwyAQb/TpONKM1JFBnz5sHO8eb9kA5mzay2AZohoGKuhfUWpejH77U2XgYjj
         wFD76pUlg/Vd7pblz7XrRtpB4ER9of155R8SEEma1Ig+DluACm9Rp2x7t3rbIGzKPBB7
         zpqF4HzoPB17ssnJE+p4xfhQaaQg1mPhOp1m9ktNS7d6DEaizPHVX9jOuMe2ni2d8EoN
         1P6xolffBcgL6LAezfn8Xp5kcQlrCWXWiHISOsd2q2hsluogsePDpSb9KE9gUC2fFn84
         nykw==
X-Gm-Message-State: AOAM5317Y+FaXwhLF8r5C4zDTeZzoqd3c3IGvYqkGqyRy2KFlwLSTi9E
        zGgP3s69DjrW2kVyfKQcioPDr+3X2s0=
X-Google-Smtp-Source: ABdhPJyRgNaVct6ICfAvGXKPms/Nv53BAGG/Ou8qQVTJZdvFrJffW/XwRR+USefCm6kUbkb5Gds5Vw==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr2359479wmj.188.1615803432395;
        Mon, 15 Mar 2021 03:17:12 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id v18sm19410032wrf.41.2021.03.15.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:17:12 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:17:09 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_SW_CHANNEL_PLAN
Message-ID: <fff259ea5895a5875c37ee0cfacd1be6cd5664fb.1615801722.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_SW_CHANNEL_PLAN

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index bf07251a07d7..368807e05830 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -132,10 +132,8 @@ u8 hal_com_config_channel_plan(
 
 		hw_chnlPlan = hw_channel_plan & (~EEPROM_CHANNEL_PLAN_BY_HW_MASK);
 		if (rtw_is_channel_plan_valid(hw_chnlPlan)) {
-#ifndef CONFIG_SW_CHANNEL_PLAN
 			if (hw_channel_plan & EEPROM_CHANNEL_PLAN_BY_HW_MASK)
 				pHalData->bDisableSWChannelPlan = true;
-#endif /*  !CONFIG_SW_CHANNEL_PLAN */
 
 			chnlPlan = hw_chnlPlan;
 		}
-- 
2.20.1

