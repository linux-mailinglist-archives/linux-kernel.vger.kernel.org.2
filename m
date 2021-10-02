Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205F641FE3F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhJBVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:25:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCAC061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 14:24:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 66so12382713pgc.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tyaNHYSot78JIfayCvFdZP5ADG4ZrfdCKwO4KmosFLA=;
        b=ZKpEeCuxZEY/wCWn5h6rjv1EhuWNh5vf7TRcQEkxzP79Eou2MSW6rd+nU5is0iPds+
         AEQPVdjPQyyg67qPje1h1m6Atvtjtiu8dlN0eF/aOYGqKa9br5atkWTwUe2q7epEEty8
         QZuVUlE2y0H/x3jOGj9nfOI0ajsYgkYbgibqsUdjKlOlDO46aXkgx7HAVjiEw5u4pvdD
         HMAz3opxQuvyzpuEMfS13lcaCwnPy2iHI0QaxeS0fmoSuxpF90t2YBgyRfbRKSte594P
         jxj20v0xlDY2uFJmbRdzc9HLfuIcV1Iv+vXoUkelVk62WPNdY2ax/aGS3kfd9TUKSlzN
         tN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tyaNHYSot78JIfayCvFdZP5ADG4ZrfdCKwO4KmosFLA=;
        b=ECROtE3EnsTpE5rtr1sqHtA8OgJ5KBSv7XorAA+yzF7sq9KoV5VT/wFCz93qxB/Lh0
         eBaOESIEMOfvzHqjLayqhx4Ba9gJQiBADELZf29YPMfWKzhmK8kag3Q/ogLDeYvnGErv
         UKYCts7wyISLJO8gQX3c/A9IZIUzXCvQQXJBdKkCe94LkRkqaAakF46M35hGIbjh1gff
         LNAVBAc2+z+jFkdXiVVLvs1tIg/Y2t+NZd+YJymjoNTQ+nm1oRPC0tlp5Ai7m05Fv0Yu
         peKetmdT8Wobcb6LmUwCD4WdDZJBdQiZL2z2lVeYcWdV5XEbofmRCTChCBhbowle5op4
         QawQ==
X-Gm-Message-State: AOAM532oTWTiKOyTi+SqBZWNe0OvMq4Ic/eFq/nlF6hFG1Vwn+OY+AbD
        kfzwYqu6hfp+hjelqAH9de+CP7xZKxwXWA==
X-Google-Smtp-Source: ABdhPJx4NYcgw6T0x4hW7IZD7Il4i7ml3b5X8Cexl1Ll+qzqTY1Nl6/5Yid+bklBNEie72lMaJeYhQ==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr18366920pfl.51.1633209851302;
        Sat, 02 Oct 2021 14:24:11 -0700 (PDT)
Received: from user ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id h4sm290908pjm.14.2021.10.02.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:24:10 -0700 (PDT)
Date:   Sun, 3 Oct 2021 02:54:04 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        clrrm@isep.ipp.pt, colin.king@canonical.com,
        dinghao.liu@zju.edu.cn, nathan@kernel.org, zhangqilong3@huawei.com,
        jiapeng.chong@linux.alibaba.com, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8192u: remove unused static variable
Message-ID: <YVjN9FT4KjLGX/Zg@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused static variable channels.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b6698656fc01..594239990455 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -96,15 +96,12 @@ MODULE_DESCRIPTION("Linux driver for Realtek RTL8192 USB WiFi cards");

 static char *ifname = "wlan%d";
 static int hwwep = 1;  /* default use hw. set 0 to use software security */
-static int channels = 0x3fff;

 module_param(ifname, charp, 0644);
 module_param(hwwep, int, 0644);
-module_param(channels, int, 0644);

 MODULE_PARM_DESC(ifname, " Net interface name, wlan%d=default");
 MODULE_PARM_DESC(hwwep, " Try to use hardware security support. ");
-MODULE_PARM_DESC(channels, " Channel bitmask for specific locales. NYI");

 static int rtl8192_usb_probe(struct usb_interface *intf,
 			     const struct usb_device_id *id);
--
2.32.0

