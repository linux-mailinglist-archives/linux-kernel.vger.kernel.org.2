Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352D359B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhDIKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhDIKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23DC0613AF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x4so5884483edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8spghv9XGm/pmlCRiIePpg5j5meLsrNa3sxir/pbN4=;
        b=pT7z258TR3HYgU4wzw5AtbklWCfXpE6CpefLtTuK9H1NUkSWTHlcFVJujEKagn/q+K
         SF4HPUCRTTSgpJwyEzIHSwwgGX4y2r6fxBamRHvfKohyYQjAIK26TWUMfI9qIZ+/QfkJ
         iT1YBzblllBSs8UJwNOMY458hLXlh8lx5wUn4iai5llJjkAyS24zEdNsZHav6r2HZxYX
         VfIYjce6LntLPRe1a2D7fVE7uBkYBSHXa5g4NfChNoKrBz7VYZZ4wAHhlbb4mCf85rNZ
         Nsqr/9M6RpSyhpTaS21dNqeu4HDa7zSgHDbVP44qlAR4jZ34ZHoNJ5AEt/3L7R9iEmIF
         h6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8spghv9XGm/pmlCRiIePpg5j5meLsrNa3sxir/pbN4=;
        b=EgiXewFvtG6w3ZlAdnONSGH2HH8tUYOEn4RoYUx4JWtK2e1ywK8UxMfKPWJugWXPOn
         yInG5UdR4WfdqHAWwD0z3zHB0lDd2bZ2avWcz3wFaQAxxngYsNlRQ2E5I9FPv8Qm2T9R
         gKeT70357cv4N2coXfVrawVcffF9Ta+GZR2aWDG2pnL1rj4ihbyo3z6KZMgeyVC5rAqt
         Ohh8rfe7+dk01JR3iLi4IRWiVf6UAwKYGZQDG05xfcSGe5cStfyPikxyW7UoZiYghvhr
         +VM7G3PMQbwUNX4gB5K5KZcID7Ccy1ECijsegtbOJZE5BtSfQjlqTaoMGr+4+EMIWdJ9
         8tQg==
X-Gm-Message-State: AOAM531nI6Svwtl1NNEsGnojxYQ9c7zW2JWXoUu4XMblpbRVR9eutB32
        Ro9AzirHKWuZWADauK5+R4U=
X-Google-Smtp-Source: ABdhPJzEIlnBZqUdbbcpjpEbu4u8Ya+xR9jTJzYftj/W694IfeKfVRbBCss6VIfm/i3yypxPUdXkIA==
X-Received: by 2002:a50:f29a:: with SMTP id f26mr16694896edm.13.1617962517363;
        Fri, 09 Apr 2021 03:01:57 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id n5sm970240ejj.73.2021.04.09.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/11] staging: rtl8723bs: remove unused variable pstapriv in rtw_dbg_port() in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:34 +0200
Message-Id: <d433ffa5b52d6510811c882a80c1146c7d7be536.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused variable. W=1 compiler issue:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:
In function ‘rtw_dbg_port’:
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2448:19:
warning: unused variable ‘pstapriv’ [-Wunused-variable]
  struct sta_priv *pstapriv = &padapter->stapriv;

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index d4392459082d..ae74623bf1a1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2445,8 +2445,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_network *cur_network = &(pmlmepriv->cur_network);
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
 
 	pdata = (u32 *)&wrqu->data;
 
-- 
2.20.1

