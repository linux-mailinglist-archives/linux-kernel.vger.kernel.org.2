Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEA3E34BE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhHGKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhHGKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:24:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:24:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ca5so20440700pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n0WYjDn/Hk7WnWbcRBK4RMrec6sKgFH/C1TYM3Ko0Rs=;
        b=YQu96Z3cdLcwtD5NV1Whhw/XHd03p2upsUo6L2om93ajP/gv0cY40pyphLgnNsYEkN
         Qa4K0eDk5mL00leLuZP5kPbciZABvr4RAVj1PhOUqqh40hGn2lDUk+g2dJY8tONl9B4p
         E1xchr588myR1z//LqrY2jNwaMtWxnO9/fK9uObVEITHgER5yw6Xb16m4Meqn32Auwcv
         gg0DiwqSh2op0XeYJivNpAiIXAixdRsYIXecJne/KUVRMN5AZlFfEvybGpC/JQBQsEL0
         zeihF3ZMAmWwfLdf5B5TEnzrPxvChuEM8O1zowDn9amlDD3uEXDzW5nHilrMg8bd2pcn
         RjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0WYjDn/Hk7WnWbcRBK4RMrec6sKgFH/C1TYM3Ko0Rs=;
        b=QAui4Sz/qU6C3xHEZ0womF9CMIpqN45Ilh3l1jcfZ6iMYhHo4XpahPwl8nxwvnP7FS
         gTekBcADe/q7q4WO+6/FzSXSPA9DbqmbJlA5Ko6xDoFP1M7Xxvhozobs1w7VA3o5+cWp
         shhh9bk07jql2B2FkGHVmpYcZqsf91a8RaV/rUuXZmR509pWDXbfTh18Yx0rWNqTgRoJ
         bi7Lm+0ezWbQ0jgKJSld03XM1neBW6jvwC6zkItvG5owE7RPI+kFjHE19xV32wplxu6I
         5GtpUoU2XDLfx93phxWrVv+8/P+558s83nu+zW+5CDF7ldfpYoxyr7RJPqtIT1mWGGWO
         2cAA==
X-Gm-Message-State: AOAM532B0Sulrq6NH3joaVCzQCygiuItcggW4Xq8kR4UNTGDo/qWgRPQ
        aCaI26CT1es/6bQHDXXVdwk=
X-Google-Smtp-Source: ABdhPJwRlehCl6FzdeBvXbmFqv96ruoIj62UME0I6LJA6sSDLywjo2ywXjD4Moo2VCAClsMAvbl7uA==
X-Received: by 2002:a17:903:181:b029:12c:e578:5a4e with SMTP id z1-20020a1709030181b029012ce5785a4emr10570478plg.12.1628331843823;
        Sat, 07 Aug 2021 03:24:03 -0700 (PDT)
Received: from user.. ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id d17sm13290717pfn.110.2021.08.07.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:24:03 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8723bs: os_dep: remove unused variable
Date:   Sat,  7 Aug 2021 15:52:32 +0530
Message-Id: <20210807102232.6674-5-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807102232.6674-1-saurav.girepunje@gmail.com>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below unused static variable from os_intfs.c
rtw_enusbss
rtw_hwpdn_mode
rtw_hwpwrp_detect

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 724909078d80..71c9e7eec206 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -109,11 +109,6 @@ static int rtw_antdiv_cfg = 1; /*  0:OFF , 1:ON, 2:decide by Efuse config */
 static int rtw_antdiv_type; /* 0:decide by efuse  1: for 88EE, 1Tx and 1RxCG are diversity.(2 Ant with SPDT), 2:  for 88EE, 1Tx and 2Rx are diversity.(2 Ant, Tx and RxCG are both on aux port, RxCS is on main port), 3: for 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */
 
 
-static int rtw_enusbss;/* 0:disable, 1:enable */
-
-static int rtw_hwpdn_mode = 2;/* 0:disable, 1:enable, 2: by EFUSE config */
-
-static int rtw_hwpwrp_detect; /* HW power  ping detect 0:disable , 1:enable */
 
 static int rtw_hw_wps_pbc;
 
@@ -159,9 +154,6 @@ module_param(rtw_wifi_spec, int, 0644);
 module_param(rtw_antdiv_cfg, int, 0644);
 module_param(rtw_antdiv_type, int, 0644);
 
-module_param(rtw_enusbss, int, 0644);
-module_param(rtw_hwpdn_mode, int, 0644);
-module_param(rtw_hwpwrp_detect, int, 0644);
 
 module_param(rtw_hw_wps_pbc, int, 0644);
 
-- 
2.30.2

