Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA883F5850
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHXGgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhHXGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:35:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2833C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:34:51 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d9so15901253qty.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPhOENbkauMLOa57AsKQWI/Z/lqp0BC3AnA/n0Luw9E=;
        b=vhZErCbreGsSUNSd2yv0iaJamKK4vSyQsZPH9Dwg0U7OSD6eoe/WjE8JeTGnCuN4Gl
         iYPkzv3OvZ/2HE8w5y1yMpS0t75Hlx3a1nBZ9iswlKFl7PYdkWTLm1ASDlx5ArpExL4q
         XI5A37Z17kNV+c/bUo1TjFpkeJJdXzpJZrC+xf72Pd4mpVtxOY9XyEcYmUF9ZtlshmBr
         yYELiYQbwtUBiM4SQ24/bWCCzYdH7gxIl0Ek0Kj8Dk/jbQj/ZJbYIYMgBHWOANRHm7ca
         N58HfZqdUUqLdEQVtsW3FoQZuJJsz5EIX2xMlRbdkOY3ksKCCxGRpaPev+05W3wcaKSY
         a8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPhOENbkauMLOa57AsKQWI/Z/lqp0BC3AnA/n0Luw9E=;
        b=hHSfNKpR4iSuCbi5o8JDcElCzoUDa+2n25UbYoCSAWTSjVO/5cI3VtJY05tREjYAJu
         EjC3tpwjgvXr0GNBJWrKLN5G0N9XEa0acp9EQdjOVEOkZJ1lMi5lwvK2i3t/v3zYtUKE
         tnzOo5bQii2rjdcC2Tvz3d/esss5G062wAWZbKqYIGVf7oyT3H1MnLoKF+2OPndfNYNM
         KeGuao/c4ynGVnntxS/XDv6o5XbS7s7Dp8kveNGiDgNC8JV6UUMbEwOCZSyPzfQoP8oq
         GL9x49mBI65AGbArmIr9xtf8PmNWRv7D4G6y40whCFJlMTrG6X4oI7VG+FMUx+3SJ4Z4
         HRiA==
X-Gm-Message-State: AOAM531/Hn0GPvCx5aD1kSZbOiG8z1SxC/voVTFOg464kuMo0RrzyH5h
        WmmoCGq1f1/QpSvrI0Ye+ho=
X-Google-Smtp-Source: ABdhPJwZchB1kYNDeE1rITckLK/rvUxZa1c5/XCQ8FWy9KMnJg3pvfxXB1PabKD7KQETFYPncP1J0w==
X-Received: by 2002:ac8:7118:: with SMTP id z24mr6866941qto.244.1629786890950;
        Mon, 23 Aug 2021 23:34:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z21sm5326680qts.27.2021.08.23.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:34:50 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] r8188eu: remove unneeded conversions to bool
Date:   Mon, 23 Aug 2021 23:34:43 -0700
Message-Id: <20210824063443.59724-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Found with scripts/coccinelle/misc/boolconv.cocci.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5325fe4..20dc4d4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3758,7 +3758,7 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait
 	u32 start = jiffies;
 
 	do {
-		ret = _issue_probereq_p2p(adapter, da, wait_ms > 0 ? true : false);
+		ret = _issue_probereq_p2p(adapter, da, wait_ms > 0);
 
 		i++;
 
@@ -4890,7 +4890,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 	u32 start = jiffies;
 
 	do {
-		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0 ? true : false);
+		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0);
 
 		i++;
 
@@ -5605,7 +5605,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		da = get_my_bssid(&pmlmeinfo->network);
 
 	do {
-		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0 ? true : false);
+		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0);
 
 		i++;
 
@@ -5728,7 +5728,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		da = get_my_bssid(&pmlmeinfo->network);
 
 	do {
-		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0 ? true : false);
+		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0);
 
 		i++;
 
@@ -5839,7 +5839,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 	u32 start = jiffies;
 
 	do {
-		ret = _issue_deauth(padapter, da, reason, wait_ms > 0 ? true : false);
+		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
 
 		i++;
 
-- 
1.8.3.1


