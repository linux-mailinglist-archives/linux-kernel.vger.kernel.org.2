Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA98D33AFBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCOKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCOKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:14:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B816C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:14:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso19888541wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=So7Sq781A1ayPY0NQcU/yfj8RcUkjakOhLcaEWlMRK4=;
        b=LIwaOHbmdOXVmOFip+Pt4d6F2/YZM/eLtPX75E7O4vlRA2sjKChWt+qSZ7hlvaHEc3
         5PuHbGulKAr71RAz1ouqqE8IAorwKCLTJrXxE4fixKwl/L9dNTSu2DdsDm7DjnRUO6Iy
         Yu+5IjM278yGAzcv6FYc7XIXjj1eeigG5vkW1ak2NAKgNDT4dRhHfc6hyFmBcClcLgGb
         dmxQqo6jg3PQBLE1NP+aY1XBNdQbrPjfoqDIVr0hp/RKxzXZIOBdIpl5UU7vF5cu885y
         6cHgS4Y51HSVMLHxegDkq3KBuBJyMHG/c7i/pEGVAfV52s/0JgVZOUhBQc/TBg1qEHbU
         RrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=So7Sq781A1ayPY0NQcU/yfj8RcUkjakOhLcaEWlMRK4=;
        b=YlEd/2LC+NoUAcb9aWt73+9frx6hk/zurnrHwEBYmkvua/pUV0xSUaBRp3SSHi7fYY
         PJ9oe3ZpNx/TO4PbyYq7Jrmhtu45Mccs55yy4d5f2mh8IBzU7QPu2x60AFDUxm0uEgc/
         z0xNdqwsB29LeAo/vq/LHffKwuOuf/rYU/buwGDxJm+tnq3fcSSUCoKdMJOXP1lfZ5g+
         UC/gOjp4RPaA7oU6XcnUlzy2Y3AhkuDh+lwxujyLB04oRf7j7ci46WjGylQbsgpNJUmP
         meRwlbk/TWWEpqLwXprKmlURnmiy7VWjBp0Jpx3UBSDhRWDHuYeLD6X3cmm06eWMlSoh
         WoCQ==
X-Gm-Message-State: AOAM531qkhx7K9pUryvMui6dSFrsMSYP/5/FLHSzHv/mjSdSQqW2zfpQ
        U1zcLluRl+reKebqXxp+GFY=
X-Google-Smtp-Source: ABdhPJziM+yqT1i0A+Paka7NOxDCJ8fwYZzhAp0jfWCHoiVM42G0HUK1qVzq0MTUyCkgin1fO0Jf1g==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr25273837wmi.143.1615803281225;
        Mon, 15 Mar 2021 03:14:41 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id d29sm17745519wra.51.2021.03.15.03.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:14:40 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:14:38 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_QOS_OPTIMIZATION
Message-ID: <a63664946ac3c79832b7e97c42e825ac5c1ab252.1615801721.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused CONFIG_QOS_OPTIMIZATION

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index d643e9a59e6b..270f93e90e07 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -121,11 +121,7 @@ int rtw_mc2u_disable = 0;
 
 static int rtw_80211d;
 
-#ifdef CONFIG_QOS_OPTIMIZATION
-static int rtw_qos_opt_enable = 1;/* 0: disable, 1:enable */
-#else
 static int rtw_qos_opt_enable;/* 0: disable, 1:enable */
-#endif
 module_param(rtw_qos_opt_enable, int, 0644);
 
 static char *ifname = "wlan%d";
-- 
2.20.1

