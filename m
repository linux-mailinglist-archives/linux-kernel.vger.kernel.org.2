Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B479400464
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbhICR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbhICR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:57:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445FC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:56:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j2so16840pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QK06svqw7DyH5jd4WQQegPSwOLABf8o6RovqCiYy1aI=;
        b=dyjdkFN8x1vzuDusjhxQ/tFQK+7RCR7OJad7+OfnrUmNvLhABMLnwmSNIZucbD7tio
         02+MHWXWXUNTzGv/O/ZWOId4PI4GbSxQ2SzE58Z6R5wsnncABp6vzjSZxImmw332XvGr
         1eFM+yf/ris/umM8kyRGyjMNYO5i+/xzZ5yjAmEPcUh6L49suDk2hBjswtm8ivo6N94f
         CUfMQKBUiPCUQroNnEJ0ZvE64i+Nd1KNYLxhZcPQtgFo0hiczaHAwQ00dV7Lh938qTlx
         TSyRiKX7f8Pf8OFWRDP1eCEWJunEPdFjkWS3cfbEBnfkog6X13IL2vtBykU6FH4bdQ0h
         WYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QK06svqw7DyH5jd4WQQegPSwOLABf8o6RovqCiYy1aI=;
        b=kmLeRKQukv5ovMge5KgCSN19ibJEO8Z3HmjCiw8NCpOJxFWp1z5EEYsks4QO5XQR6h
         zMeJfA2uAzC+LrAEld3EbykiDWswS2i09bwU0Sw4Gi50XwBkPlg+q38Ln9mCIE/Yhh/V
         QcAkQO+0PpPPayb8sNY44I27mEuMJp5y0ujI6hZC4fmWVTqYUpXXqsacev34oQEuEw4T
         Vij3QzvGNYEhVBzVhkHsmxYIZz2dH73Nto7wrTYv83wlRLRBkEYQ5uvOtz5c6A/jyjwg
         joTpXn95M2q+WnPBpUmfW27+OZJR/xoL0HddXhEhQ8sMzUImOWCaMz7rMuSZRvBDa/1H
         Pu0w==
X-Gm-Message-State: AOAM532yxsenab3nRiokL1qP0Mhj43VcTbepOYWoRZ/ZR/pR3QWgudNo
        3k76sQxwZSeS5xOlmNxLYkE=
X-Google-Smtp-Source: ABdhPJys+QMDqxVdjzFYs2Zgfj7zs+kqB8fZEIuxNUtjCmKBE3BqN+x24Q2Qmt+1lAwMnlBZr8lrmg==
X-Received: by 2002:a17:90a:4a8e:: with SMTP id f14mr66326pjh.169.1630691783204;
        Fri, 03 Sep 2021 10:56:23 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id v9sm26605pga.82.2021.09.03.10.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:56:22 -0700 (PDT)
Date:   Fri, 3 Sep 2021 23:26:17 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc and
 memcpy
Message-ID: <YTJhwQstKPUYRwN+@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 81d4255d1785..495fadd2b8c8 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	}

 	if (ielen) {
-		buf = kzalloc(ielen, GFP_KERNEL);
+		buf = kmemdup(pie, ielen, GFP_KERNEL);
 		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
 		}

-		memcpy(buf, pie, ielen);
-
 		/* dump */
 		{
 			int i;
--
2.32.0

