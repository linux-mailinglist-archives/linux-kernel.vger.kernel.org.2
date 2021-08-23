Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46453F4C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhHWONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhHWOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:12:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41351C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n12so26379998edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVGnF32J36jAb+yNsrrim+zcEmES2WYDnRtfWUi5SnM=;
        b=su/MH1x29CKzVEZ69e8y3lFvbyyB/PPeYZKiWV+JY7cAfY/if85aJRX34s2g91hgKI
         KZIgjWCZNzVqofBwp+ZEwHG4ZiKaUHi7raPu+HtZ/psUtvJRQMSi/NUqEQd6EqEwLeZE
         pzKpp5n6p26gbcfY8+ShyNWbr2z8gSrmrZmjzxwO2ube7AwLrBxMX0Lu6ZDpd2IRus30
         4cvaUWt1ym66svLSNEjW1ozXAw2zIGRyf/5uYsIO7RYyotnrlQpgnqjjQz6Pg4NGvIde
         VlTMygswu15jaACsRS/cFgQYObsslLuguK8D11uzOsuUfKo8aij6ciUz5Ppmc+PXICdC
         Cl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVGnF32J36jAb+yNsrrim+zcEmES2WYDnRtfWUi5SnM=;
        b=iKQp7OfVpB1HNAciLdvGdZiiuKPXQ6/QcFjOUHa04L/uBs747MqBbkQSR0eFrz0SEA
         z6XJSX7xZj+NT5DXR1hC1YOwjJv0R2IxMVqIQQJaXn8nGHkvKK6w8kiogxUJGDs0YRay
         DwOzcfCj7DZ5C16iiPrUhOy+O7XoK7IXV02YKCqNwT18GWbFuhsgF1cLl0ay02K/jU9y
         frwecCos10C2d+6DYGldBWmj9Y491LqwivkjL8Wafntl5GsipxgXzcY069yxmXMsJNbr
         8KcPuYV57Nk+XwdaHcgTpYLrpy+1DBGkNpLLhKefbQsOAR1O+HY8/7bpQ9yYjfxxoo5X
         FLtQ==
X-Gm-Message-State: AOAM5308yKUNis2NxBBf2SmQMapSkhKQSYQq35sAoy9v8McR6rHibpyt
        koGPg4B3BLlvGsyKjPy2WJv8QgUN9qQ=
X-Google-Smtp-Source: ABdhPJyaQ00KOzTiQH852ZSx3EJRB5NNQuB9CYjA2JIVGZX2mzqN9v5hoyCdhUj7kYt96fCd1rsIWg==
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr37338999edq.113.1629727930764;
        Mon, 23 Aug 2021 07:12:10 -0700 (PDT)
Received: from agape ([5.171.81.132])
        by smtp.gmail.com with ESMTPSA id k12sm6833018edq.59.2021.08.23.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:12:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8723bs: fix logical continuation issue
Date:   Mon, 23 Aug 2021 16:12:01 +0200
Message-Id: <5d4e7ab18005e69e8cc162619149d6fa93568875.1629727333.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1629727333.git.fabioaiuto83@gmail.com>
References: <cover.1629727333.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch issue:

CHECK: Logical continuations should be on the previous line
52: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:389:
+	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_
+		|| padapter->securitypriv.dot11PrivacyAlgrthm
					== _TKIP_WTMIC_

CHECK: Logical continuations should be on the previous line
53: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:390:
+		|| padapter->securitypriv.dot11PrivacyAlgrthm
					== _TKIP_WTMIC_
+		|| padapter->securitypriv.dot11PrivacyAlgrthm
					== _AES_)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 5067c2417351..733c6b93eb8f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -385,9 +385,9 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	}
 
 	/* TKIP and AES disallow multicast packets until installing group key */
-	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_
-		|| padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_
-		|| padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
+	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_ ||
+		padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_ ||
+		padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
 		/* WPS open need to enable multicast */
 		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
 		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
-- 
2.20.1

