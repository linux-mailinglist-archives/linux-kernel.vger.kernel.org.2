Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E1E38AF77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhETNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbhETNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815EBC0438C3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:26:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2578415wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=boUfBdDppdi68CWZ1DuaCR1tP+CexdjRgBwZYDLgxuk=;
        b=ssdv0Tx9lb1GaIEaow+ywpGUqZgPHsker8xNMonpVNkOgs9C8FEMMXBQvyEWHIqSR6
         /K5soqinL9uS9cnbJ0rnXLrBYW9alw/ojwOdNLyAd+0eL2wO+xyKjiZfj9llnalWMbxM
         Fb3KTEDviozsbGFY2ST1Q+jKu7GjXYUK/GE7K2ZBmBBe5ABwUaT6F/oFdnb6yEImFFUA
         E+gHzBl3qz9rhuXXSc06wUVJrQFNEhoiFMdHgT1f+wwUpx3VSLNTR3zUMZZMP0vUvpES
         GZPZ/HOTx4sfw7PWd0YPty6y98CGC0gSpV0DNB6KGgEL6IP2HbSUvgAPYqRrPSczTyQo
         GGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=boUfBdDppdi68CWZ1DuaCR1tP+CexdjRgBwZYDLgxuk=;
        b=Uo2nCDjwjdtzMiCKUrWrW9ULwjImWjyqf0Zh4yc6kut/oiFGmiHPksltj5edizwFEL
         hhvtMDxKsSIWAtyCs5WRVfdrIqYkjpR9o1GZXU5Gi7iWd88li7euM8QqFuzY+CjAlMmb
         eAhsCyLr6WE7gKnU6jnZAd16jCH2D/K9ciTVDZ8p9AsU54k/nU+maWUnTSv3NadwMKxZ
         XdXpdsb4LODOuJm/TeYJJbBSaemOVHJJK1HvnMuoihYjgCFfQODdhBJwETyfNHwfirIO
         xFgkRhO6g5rHk1HqzdipxqRtfkCaCsHOyRq+TLGevJLDcMxA3nYFxxJqU68qIBczsbyp
         bmAw==
X-Gm-Message-State: AOAM5303TxwTWRcopGzeF4KEZ0re8sgzU3G0QLsNGfbbtUA2JzBHkWK1
        3Vm+q/+7OvJOpOlfpr5ReIa5NzcPOS0MPw==
X-Google-Smtp-Source: ABdhPJwGts8gvvtcP9OeWw3+uLLEfsxjAGahlDu9SP0IgtGCPxDXFmrMx5YDrodHIB8xv1yh51Qtkg==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr3726450wmf.53.1621513583141;
        Thu, 20 May 2021 05:26:23 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r5sm3001817wrw.96.2021.05.20.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:26:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 1/2] staging: rtl8723bs: core: rtw_mlme_ext: 'evt_seq' is only used if CHECK_EVENT_SEQ is set
Date:   Thu, 20 May 2021 13:26:19 +0100
Message-Id: <20210520122620.3470450-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘mlme_evt_hdl’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6004:5: warning: variable ‘evt_seq’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9fc612fb736f8..80e5c29852b8a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6009,7 +6009,7 @@ static struct fwevent wlanevents[] = {
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	u8 evt_code, evt_seq;
+	u8 evt_code, __maybe_unused evt_seq;
 	u16 evt_sz;
 	uint	*peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
-- 
2.31.1

