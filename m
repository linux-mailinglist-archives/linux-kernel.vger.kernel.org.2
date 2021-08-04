Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167E3DF8C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhHDAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhHDAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:14:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F6C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 17:13:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k2so1006386plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/UCtLUJfMOPjFMa3FSun6AI/QRILAfUuJo3JZX0fg=;
        b=elUaJCZRN3EO363usLpZzl18/cT4gFkB8vJu0xifJ1pgI1aUrEwF1Aqb+xcIKk/tWe
         F4M9gbUoH/bTNrYPDgLVjcH6VX3wI4WVUnvOTqn9eO7lk4e6C6U6/tJxIq0iqid3CNAM
         tdn+YdjOqgVfxep2mr8/UdSG58R7slkT9E4PRRsAOWYTo2q0Rd7QX5ozV5SM9BQHBSvJ
         //qGYGz0QyfsyHpNbei2+30YDoTYCq3N5jQF7u2VpvXEUnWVXD2u+S6nSgJreV8wS4UA
         aY3W+PYNOCq3f7ehtIHPs2OVTy6sEsbrMdO4174E/NAnxKOYqYeDsx2+ccMiFyU1uZWc
         sGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/UCtLUJfMOPjFMa3FSun6AI/QRILAfUuJo3JZX0fg=;
        b=dPXnHkVQnW/eMXQGw9L1so8mo//B7rJRxiSMeXbYvEwbBB4819EUG8PMVCIyaf1HMP
         m5WdVkFhHUdJKOFlnYz1VDmBEYhYT8XU5KqCamlSScSSptLZH14kFaITUjHHZ3bOhBoq
         KfW/yQjyFeEXrqDYCxDpvfIlJ929yaGXwINflZFmXOZF3w+NJdPxblgpygTR+ZLBkzSP
         2m1mfAbhEiVuP/LwWx16jt9kpFAWrPg9VJy+j6CpF4aO06h1DNhiUst8/1uniIWA2RLb
         tAkGRTQyYziW6S0ezZkTYYMNRtwc09wAbJjegik74q70kqO6kefvbYzFL24GDdfjU4iE
         Nebw==
X-Gm-Message-State: AOAM530m2S6Rcy8JkLlhkOV5+L6AfRmd9/jca+7E7xfTzWE/AmpGxZG1
        QXFaNMJym1lbvH7W8wEdmPg=
X-Google-Smtp-Source: ABdhPJzMNGF6LbiWAOwhuFjMYSP/ZflXBkO7SxTufDjoadatczNXyqXq+8wERU7Xjp0WAkz8gDPfcA==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr24704562pfh.17.1628036037014;
        Tue, 03 Aug 2021 17:13:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:8003:d90f:f801:7164:b4e6:b90b:c4d5])
        by smtp.gmail.com with ESMTPSA id x189sm382302pfx.99.2021.08.03.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 17:13:56 -0700 (PDT)
From:   "Scott J. Crouch" <scottjcrouch@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     scottjcrouch@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove initialisation of globals to 0
Date:   Wed,  4 Aug 2021 10:13:34 +1000
Message-Id: <20210804001335.16742-1-scottjcrouch@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl errors:

    ERROR: do not initialise globals to {0,NULL}

Signed-off-by: Scott J. Crouch <scottjcrouch@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index b9efc1dfe6c7..a6d3c6fa900d 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -111,7 +111,7 @@ static int rtw_hwpwrp_detect; /* HW power  ping detect 0:disable , 1:enable */
 
 static int rtw_hw_wps_pbc;
 
-int rtw_mc2u_disable = 0;
+int rtw_mc2u_disable;
 
 static int rtw_80211d;
 
@@ -122,7 +122,7 @@ static char *ifname = "wlan%d";
 module_param(ifname, charp, 0644);
 MODULE_PARM_DESC(ifname, "The default name to allocate for first interface");
 
-char *rtw_initmac = NULL;  /*  temp mac address if users want to use instead of the mac address in Efuse */
+char *rtw_initmac;  /*  temp mac address if users want to use instead of the mac address in Efuse */
 
 module_param(rtw_initmac, charp, 0644);
 module_param(rtw_channel_plan, int, 0644);
-- 
2.32.0

