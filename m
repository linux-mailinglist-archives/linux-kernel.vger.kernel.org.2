Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E903B2413
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWXv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWXv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:26 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4121C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u2so2360667qvp.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hzs0aRr/2FTo+ufCqPbo8wGeZKPZ+8aya5RUmspvHjU=;
        b=dQMDWyMK48FNMS5NdEouRQoBOEPwohFXj4YamZ/qDn6Te1H+9D5tTu0hOX1vdy6PUJ
         5x4elyuUJwvqxVZx+E6mR17omVSkzs0p0Pq6qyHEj0d1HgDyU1KMl/86WSKWAhcxV/Zl
         8IGELc8tLH6c17hh/TXl797DDYFnFoi5RCTj1KhtGkJ7o1hkl5h4nzy4i8ZhYtCj4YcM
         mbrABc0e4j3SPPGocuV48ETWwW6ChCyDEE/FgHrhl/0uv01T1SyAAaSiidyzohSo+le5
         ofsgLWWvOBMcyzawuoCEB5RawLotpF4gdfJKY+yLEY84gYnoJbgOup6kj9RKoWlDVwTV
         HDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hzs0aRr/2FTo+ufCqPbo8wGeZKPZ+8aya5RUmspvHjU=;
        b=Iq7aU0beKQQIl+oOAJFKUVawVuZpN7atS9RH3tbpMJnWHQQBcAlPKtyUvGzvWxovSK
         eIwE2LJgShk6Kf33DFlUQMcYd0U+ibhpjBOSJo7mT05eGdrKzPwNJBGFOyLJrEzx6m30
         5EyAPUD4BUZqLC0Ih+BEgy4fYE5dOFQc9fd2AFdmUGUOKq6rd8Hfu0hK5867Wd8aMfTL
         vt7jKPz4WEKZYvY9ZBwQ+E8BaLLkTI9ujgH5D1IJy6Iqd1hUWRAmRKd2gMEdL8HLL7tF
         Lmf4wcfgoabaeDpbYUi4x2pkp8tdBAr9Zw7yWQEWx7eAFw19F2y+Om6GNgyuPaGVIphm
         TSAQ==
X-Gm-Message-State: AOAM531ml4zsJoCYiFF3hdX570gVXPuOHDBWc8vtPWVB1U3HqGP5Ij0p
        /Rbw0jqmaSRMNXY+QPRZwnm6MA==
X-Google-Smtp-Source: ABdhPJzfVDCa4aSQXlzkeGAnV9tA76+yAdDViBHh74G8+izOLWUJgMyd1CImwRrpF4qr+kWKF9AGgQ==
X-Received: by 2002:a0c:b752:: with SMTP id q18mr2582310qve.6.1624492147827;
        Wed, 23 Jun 2021 16:49:07 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:07 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/9] staging: rtl8188eu: remove all DBG_88E_LEVEL calls from os_dep/ioctl_linux.c
Date:   Thu, 24 Jun 2021 00:48:54 +0100
Message-Id: <20210623234902.7411-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E_LEVEL calls from os_dep/ioctl_linux.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 3b8386245017..7ab7706cf29c 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -71,7 +71,6 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 
 	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
 
-	DBG_88E_LEVEL(_drv_always_, "assoc success\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -84,7 +83,6 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 	eth_zero_addr(wrqu.ap_addr.sa_data);
 
-	DBG_88E_LEVEL(_drv_always_, "indicate disassoc\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
-- 
2.31.1

