Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F87359B86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhDIKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhDIKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6520C0613AE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so7725246ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWOSqiWpOhJZjEMGKOoWhzf8snbAJ3zmlA3CV7qQ4vk=;
        b=F+23DgC5BvrPHIFs5vrK/WyibC/UlxnBRr/9ACjgP5kKSpXuWVDEZqGOBi2FjB0gml
         YEnT31aomgfOgOYJ9UCKDgGhzkooVIzzpgsPaKFnVXcyvCz4IpmYuh3skKvK3uxUcqRL
         pIPcPON+7SsOLjpfqcqxepmbtnbxfAPWtwnAQIu03vtk9YmK06KQcKN+Ld8DeB/GKbZj
         FYek9IihA6D/5Tnu2AFG+cCjopa9MdU7/XChyu3JDU4MCq19KiTC/ENaI9IgM1/sqpoO
         tz1IjcDXtBBtLHkfnY3+MNUB4tp+ZMr2eUuiH+7G756SDcSCCNKk27FhIVwRhuPcbcXA
         R7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWOSqiWpOhJZjEMGKOoWhzf8snbAJ3zmlA3CV7qQ4vk=;
        b=FyW2afpgJOwswR/e9QLHjWIeM7Oi3TW/WfCTDoOiymsW82Q+I5JmVYW8J04OCDXotL
         r+MHCfZvQnWcGvmocwBKTNCQgwotF1IfGuRhNZ9Fy9/WhFb0/oM9g6ySp3v8NDdw4FHU
         IVM6K67myIW04HW4Fy/LhKRs/mY/vKK4EM3UXE3CgJnUH7ARolvTMZuHOu8KOSl8HvcH
         +b/+UEUqdsrOFpKMwFnR5Uuia4E25amG0OO7pOFdbI50SierlW/qVIJRtH0O6JcoXgcl
         ydKUkmyKJH18kEWdu/014pN/HvOyOE+Wld9jrqgPipb4PEpOfxGwv26yR8X7FYGtyj0N
         3edg==
X-Gm-Message-State: AOAM531gZ+JEn+SBnMpvS4wS6uhK7Km36gSgh7f4v/V0H4hm4lKY4HvZ
        c54ww0Gj6tGP1RyvWUrzsGZWTwK19Ww=
X-Google-Smtp-Source: ABdhPJyQm3WxMLkzT2w28VmujVLs1D0LmdCv/VLt9kXoDNhl+KOs+WRdZYQ1MOoFHyn3uVGkO3sIvg==
X-Received: by 2002:a17:906:8988:: with SMTP id gg8mr14998848ejc.264.1617962515696;
        Fri, 09 Apr 2021 03:01:55 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id cf4sm1135685edb.19.2021.04.09.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/11] staging: rtl8723bs: remove set but unused psta variable in rtw_dbg_port() in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:33 +0200
Message-Id: <62b6c48b887decdde4b5343472089665518d205b.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove set but unused variable. Fix W=1 compiler warning:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:
In function ‘rtw_dbg_port’:
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2443:19:
warning: variable ‘psta’ set but not used [-Wunused-but-set-variable]
  struct sta_info *psta;
                   ^~~~

Remove also the function call that sets this variable.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index d70e2d5d51e7..d4392459082d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2440,7 +2440,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	u8 major_cmd, minor_cmd;
 	u16 arg;
 	u32 extra_arg, *pdata, val32;
-	struct sta_info *psta;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -2542,7 +2541,6 @@ static int rtw_dbg_port(struct net_device *dev,
 
 					break;
 				case 0x05:
-					psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
 					break;
 				case 0x06:
 					{
-- 
2.20.1

