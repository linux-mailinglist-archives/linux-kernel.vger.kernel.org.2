Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4A3E34BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhHGKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhHGKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:24:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E31C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:23:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nh14so20474050pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UZjwhGsWE2MzAi0fvgWAJ8/2iuyl1IZbIl1M7BcHXVE=;
        b=LaXUbmLH2u8Ly0CtDIDTPgvyrFAOOj2CnKLkPl7QuZsh53Vfn1XOka1VZdtnF74UhF
         6RbWndnbS1RAsWNhCWvgGNRaHFM8JkkZW3OXCxccA0HXddvzxJ+cC7oNgFtNA3fQiy80
         mI52IF4ARHYqjqyKSLEI5+pzdNscpC8lh7jNK1WD/TuQ9GqdCaKoOlNP7OVn0U+eAw0u
         2UradTawmEOHSlyA3l9g73YD8615nV+8rd5BaobTDTkCLLGmN7RvuUcmb9v6Aj97n3RQ
         seH+hOaAP5fQMZzcAUobZ6Mbm1UAYsqPufvV6HFMgjq31NPuG75Ajra4tzQFnqoGOaGT
         BzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZjwhGsWE2MzAi0fvgWAJ8/2iuyl1IZbIl1M7BcHXVE=;
        b=jEHDpRBx+MxOiV5GDDYwqBIOheFuuc4c693CJ4x/lqVbmK8dl1kKPuWFzU7idavg4c
         pFaehTbgMSqRgTF6WqMvgyiZRSiqOKa0UVz+plXfl70DF1Ll4GFS1cJ3xiYjffpbKa6a
         1X4wtbgRzJp6E8zT7dGIq/4c0d5Pys6LJSdIcN1BTQkt0tuft68KTvFbLAgmosjhjgVk
         eU9KTqnSCe2Wg14mDLzZUw2kPynD/JHyBU3TBm+CNrc4hQnBGsKGtsN4FVy+9U8CUqK5
         99dy2UEMdqtbuxiUhCFy+fNveNNlciMuBDHDDxqsU9ElVSdmnBu4DYfHVlqyCpEemTGJ
         45hA==
X-Gm-Message-State: AOAM532d+lfkQbYTJskocyE2dsVkfkEWTWdnS1wQBNxjXbmGvgyuRDik
        FJvua486S1jfD8BKTry09PM=
X-Google-Smtp-Source: ABdhPJwioxTHU6RP+UPc2xVIPeU6x9eblVif/9bw0S0943txMF3tKryN0GrVF+k5iPBWUUTr+nI+cQ==
X-Received: by 2002:a17:90a:a4c2:: with SMTP id l2mr25756212pjw.17.1628331831791;
        Sat, 07 Aug 2021 03:23:51 -0700 (PDT)
Received: from user.. ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id d17sm13290717pfn.110.2021.08.07.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:23:51 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8188eu :os_dep :os_intfs : remove unused variable
Date:   Sat,  7 Aug 2021 15:52:30 +0530
Message-Id: <20210807102232.6674-3-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807102232.6674-1-saurav.girepunje@gmail.com>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable pnetdev from loadparam in os_intfs.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index a826228cbbe9..81360cee7140 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -136,7 +136,7 @@ MODULE_PARM_DESC(monitor_enable, "Enable monitor interface (default: false)");
 
 static int netdev_close(struct net_device *pnetdev);
 
-static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
+static void loadparam(struct adapter *padapter)
 {
 	struct registry_priv *registry_par = &padapter->registrypriv;
 
@@ -315,7 +315,7 @@ struct net_device *rtw_init_netdev(void)
 	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
 
-	loadparam(padapter, pnetdev);
+	loadparam(padapter);
 
 	return pnetdev;
 }
-- 
2.30.2

