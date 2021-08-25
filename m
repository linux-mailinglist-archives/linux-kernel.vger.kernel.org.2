Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822413F6F43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhHYGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbhHYGQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:16:28 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DBBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:15:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id ay33so14436798qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHpfJ/+giY//PTSV9hmjgFnWiFlaULLHw5pVUFnZXjI=;
        b=JZp+aGqCxDPf0C2vqWl3gA2RSraLRFI1hV70cyMpIkRx5EsSHupFwyXuMRF2sY0o/V
         3exx9IPtaTXNJZVSFYan6mqnNA3KxqBC39RXykjscq3IDmE5Y7Kn42/Ja3Bh8zpCrLun
         UXeuRCwGzg16JxZxt25nL/DDN/mACvf4wGIQUnn9/ZFUZSZA30xAMXSfzzDc0p5apHyT
         vE4GEL5gRgXaljlWZGFfto19WbDSj7ZLqTbDeoCF1hr7bTvUcu8cGDvRqEwRDQa7HDoN
         Xn6YqpqUF4yUpuf5h5jQVz2yv4JUWpZCXdOOeaqjtvmnQyF1bMr+VYZZyHofB4ZDHPjh
         VJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHpfJ/+giY//PTSV9hmjgFnWiFlaULLHw5pVUFnZXjI=;
        b=Wit6kudsG+ydXiWJ7xit+DdgUQR3L8bxGykXrGww2Roj/9A4KbFGd1MMsO537P2FgH
         JBTVS9TV1sBAYKlBBp/VNCl+PjqT9Y9Z48+j5zBw3+yFBN32B0QfJxom505EDGyTxSJs
         e9dXf/xHpM8NUf9JVZ7qdL6vJITDSuY7JsGuSNDNYAvzJ8V/OUirhKhagBcgOPjTuF7n
         k4yUtzBjHtR+PoRQpT4IJZt7xjPVSlWaJ5YWfD7Z3JEUSdhnKbJtXhJDxtAmSR6mJouE
         0LM1drFNQpK6Wd6DAMNx+3kcMsMJ5UNSImVocDd36aqmAkKVYik78tD/wZxCo9Ik4vdN
         l9eA==
X-Gm-Message-State: AOAM53353becJTNJfpmfTl8HBNAZT6dQ2fUBcVj/E1tSyQiddkTFSub1
        9gyEpAX895zOexTiqsGIiiQ=
X-Google-Smtp-Source: ABdhPJwhUJUOg82ro0dDkyiSwfBWb+7ycl9aLnNjwi6aXYf1eB3dwg9mrOqQkoLySuxT66fAme/wCw==
X-Received: by 2002:a05:620a:14ad:: with SMTP id x13mr30242912qkj.172.1629872141200;
        Tue, 24 Aug 2021 23:15:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x8sm9397102qts.69.2021.08.24.23.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:15:40 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drivers:r8188eu: remove unneeded variable
Date:   Tue, 24 Aug 2021 23:15:31 -0700
Message-Id: <20210825061531.69678-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Eliminate the following coccicheck warning:
./drivers/staging/r8188eu/os_dep/os_intfs.c:505:6-12:
 Unneeded variable "status". Return "_SUCCESS" on line 577
./drivers/staging/r8188eu/os_dep/os_intfs.c:772: 4-7:
  Unneeded variable "ret". Return "_SUCCESS" on line 818
./drivers/staging/r8188eu/os_dep/os_intfs.c:823:4-8:
Unneeded variable "ret8". Return "_SUCCESS" on line 849

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/os_intfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 9d7d2b9..8436a43 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -502,7 +502,6 @@ void rtw_proc_remove_one(struct net_device *dev)
 
 static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
 {
-	uint status = _SUCCESS;
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
 	GlobalDebugLevel = rtw_debug;
@@ -574,7 +573,7 @@ static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
 	snprintf(registry_par->if2name, 16, "%s", if2name);
 	registry_par->notch_filter = (u8)rtw_notch_filter;
 
-	return status;
+	return _SUCCESS;
 }
 
 static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
@@ -751,7 +750,6 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 
 static u8 rtw_init_default_value(struct adapter *padapter)
 {
-	u8 ret  = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -797,12 +795,11 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 #ifdef CONFIG_88EU_P2P
 	padapter->bShowGetP2PState = 1;
 #endif
-	return ret;
+	return _SUCCESS;
 }
 
 u8 rtw_reset_drv_sw(struct adapter *padapter)
 {
-	u8	ret8 = _SUCCESS;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
@@ -828,7 +825,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-	return ret8;
+	return _SUCCESS;
 }
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
-- 
1.8.3.1


