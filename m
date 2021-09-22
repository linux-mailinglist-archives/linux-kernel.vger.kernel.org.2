Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0F415102
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbhIVUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbhIVUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B1C0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i23so10502160wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E93OQWyEHg9H2K50AEqcZaCXK+BXZHFSzWYopoW3wW0=;
        b=piXj9hzWyjsLam9T89Ot5AUgueWh5IIcGDQ/KIDAkhm/Gp9zwM91hm0TZi+RJxGr+0
         YZMaC3PZyTkWJl3WxIwtBNxtVIhbfg1TOSzcVb+/7rrxQQ/AgWB+/piGUCwE8Ce5O84h
         NxE88Wf8XtVZBxBaKW27ea8ShuZcFfI5ZopW8Ltz7GdjSxBgLW92cOEI+CPc/EA0roW7
         r2GZ7rd26rjV6kzHNRMZLZHwovpr8e+Lf8x5ZOhomC2gqPA9pWAKNW6ySwZI3TEkclgz
         a0d5z1xAz/mZ53grvxyu2rZVKisxi+1gXcS3lQHUq0GPs1FotB+3Gqgg4dmWp5St2CTx
         947w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E93OQWyEHg9H2K50AEqcZaCXK+BXZHFSzWYopoW3wW0=;
        b=klVzqssu/ClVH+ywi7TrDSOEpwJ7F2hqtdnqS55OlfS48EwypBQ+VpsnwiUyyM8dEw
         S0aCh4AKqaFCC8qX2x+Ey5/CCGa0sQ2k+jh7zVhPFecYjfgJWwAzAWEXbqflReXOo60r
         x0qHHx0ClyEmn8AnihhbkmKlRlfKBbui/p5m9sLAAhz0u8uFPXyMqqXGuaYfTjo4YfYW
         l88L0yNqf020rEY0P6K8ABtxqNQhYo9L1YhiqWI5SS4oOL9XB2k0s6vpeP4NqWvkU8DZ
         pl+fHpGIGcIRaeMzZ3lbq2wmv4KbYf8bfJI/+zRzQ8y/qRoKBMpfxh6Axjy7f5VhZviX
         aCTw==
X-Gm-Message-State: AOAM533HwGE3WeidY0mo6C1vlah0jxcluBiwfXH6GzpZOY/hHvn6ls/F
        UeRWXIH8pOfs28txZa5u+ak=
X-Google-Smtp-Source: ABdhPJz7vHWTzNxXUIK31VyFinzzJ2kozUww9uS3Wd9C++Z0GmUu8K68+BlN6Nu9qJFRocsbtUKLcA==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr848370wmj.33.1632341141783;
        Wed, 22 Sep 2021 13:05:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/47] staging: r8188eu: remove build_deauth_p2p_ie()
Date:   Wed, 22 Sep 2021 22:03:49 +0200
Message-Id: <20210922200420.9693-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function build_deauth_p2p_ie() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c    | 7 -------
 drivers/staging/r8188eu/include/rtw_p2p.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index f942f8f9e3f6..dbcf8bd24e6a 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -733,13 +733,6 @@ u32 build_assoc_resp_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf, u8 status
 	return len;
 }
 
-u32 build_deauth_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf)
-{
-	u32 len = 0;
-
-	return len;
-}
-
 u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint len)
 {
 	u8 *p;
diff --git a/drivers/staging/r8188eu/include/rtw_p2p.h b/drivers/staging/r8188eu/include/rtw_p2p.h
index 92b9bfe3ea0b..b91322a1fe10 100644
--- a/drivers/staging/r8188eu/include/rtw_p2p.h
+++ b/drivers/staging/r8188eu/include/rtw_p2p.h
@@ -13,7 +13,6 @@ u32 build_prov_disc_request_p2p_ie(struct wifidirect_info *pwdinfo,
 				   u8 *pdev_raddr);
 u32 build_assoc_resp_p2p_ie(struct wifidirect_info *pwdinfo,
 			    u8 *pbuf, u8 status_code);
-u32 build_deauth_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf);
 u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo,
 			     u8 *pframe, uint len);
 u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo,
-- 
2.33.0

