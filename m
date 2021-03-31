Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2B34FD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhCaJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhCaJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B31C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt15so29044582ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNq63xydxKvI5xFGmqp0pc9swVuTSAsAgkYAFaeO+Es=;
        b=BaflAGtKksJ4Wkm0WJlgrPoFz/hQ1+qjj/X7RumaHBxS9X8qh1u+ImzDbFo1rn20xp
         Q8UyQCeYdA7KsRUiIGXVuagqJ7OeTgjB3z4WSPv7hZGMCgm1Q0cX4m3X3ppapDX+10/C
         c8a8Y6vt3YInO4TLB9ZU/mp1DvwZAGkWB42v1d/X+PPvyUykRyZaZSbYww2uoItTQMgV
         V2bgtcdPxeEx57uNIOh94tBcgwtCSlL2RVhgWrcuFNVMfLryoJrl+VPhtbnIWLnLSFvI
         4C3+TJbl8btOkat6aRK4YNlU2SVRQq0+Fw+owUW2rX5jHQQLtKsb1rwzw6ZLjvOzg0Ec
         NKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNq63xydxKvI5xFGmqp0pc9swVuTSAsAgkYAFaeO+Es=;
        b=tDJ9XqqucQCPVQuTf7cUvSUMbHinifO+tVKoQ/Zq2in59UE8bgdokoeXfwg6mU8rJK
         llTmZnLqzokLEXD3hBc0mMfzwNgxhdHPyZ156sQ5I+tj6xE+2/IejlMrchjC0JU0undg
         0UEheSney2Wl8rwzL0A5dlrJ8jX5YQXp5ZjgTwsjqiCnGYvOX+JPm2/7tmHg1sPr0lrD
         5UZwjrpxy2fSKZTWXGTDZQTqmv4PreVBvFHR85sxFKw4dSlKDrOBo6Fvm2TzsrWrTVxy
         TKy9T94E8/hIpEubRtn8OiZCuk10WNaWJylbKXz0mIthN1/mYIgOlBhsB15WK9lKdA3e
         eXHA==
X-Gm-Message-State: AOAM532bqSIk1NyQfTGITOhpmmKVyx4YtIH0feqDoalcxriMvJj932Cr
        YbNAzmiHZBXlIaw4WF49pHQ=
X-Google-Smtp-Source: ABdhPJzfDLgX7sZ9tk7tl/vYS/k9r5MmjnBH8KOqL7epRhxuQKFW5dv9guO7BqYpj35NNZfkNI8cEQ==
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr2498112ejj.103.1617183668752;
        Wed, 31 Mar 2021 02:41:08 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id c15sm831516ejm.52.2021.03.31.02.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 30/40] staging: rtl8723bs: remove commented RT_TRACE calls in os_dep/ioctl_linux.c
Date:   Wed, 31 Mar 2021 11:39:58 +0200
Message-Id: <b46df7766fe0a1a8c5cf8367181e5539e7e4fcf4.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE calls in os_dep/ioctl_linux.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 354441e6a667..aee4932162a9 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4231,7 +4231,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct iw_point *dwrq = (struct iw_point *)awrq;
 
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, ("+rtw_wx_set_priv\n")); */
 	if (dwrq->length == 0)
 		return -EFAULT;
 
@@ -4245,11 +4244,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -EFAULT;
 	}
 
-
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, */
-	/* 	 ("rtw_wx_set_priv: %s req =%s\n", */
-	/* 	  dev->name, ext)); */
-
 	#ifdef DEBUG_RTW_WX_SET_PRIV
 	ext_dbg = vmalloc(len);
 	if (!ext_dbg) {
-- 
2.20.1

