Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1234B798
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhC0OZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhC0OZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C0C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so8360816wro.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgnFip3DBtwY5/YffZniWOU6/oNo0bDCt9nD3ZaDcw8=;
        b=N/SerJUnmwOssDpn8cHt1cNW/VzjqzEzaL0qWGhnyTscKXfzwW1iO/+bUrBMvCDEis
         9eNVFZvfCo4koBNyKsthOCK5Ol0Kjf42fARMerXFaIe70K2ipYHAgtxEX8JjMojpGXUw
         X/FLyWIS3v4Om5ELY5oh7VPomJpf4JQSUoc2wV1pKzSamx7/ngi4Gda/Ak7Fpp5qGLEp
         RqoNQWpnEmkIjCuBquf7mqhfGiXBm2dTp+7++nAbmF+7zKkp60czqhMnjHwHFTRUNelL
         Y3vReWAgNgn+PDB37NNn2ieXhKAgB5laueFe00WmxTjoeaOXHk3xZ59PwpkvViJgrJWn
         MtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgnFip3DBtwY5/YffZniWOU6/oNo0bDCt9nD3ZaDcw8=;
        b=ht/aYnhPPHRbzMsf1Okf2j0dNpxmKxe6NZ4P9a1geRFBC3zR6Kif/GAg7BVP9XqKIS
         PiHfrm7/CYhEA85QmBqeZPV/9LEjBABIiDXSyUm5M/zobleHDiMSabIVTK8F0a3R7xBL
         OGlWqyzVtdpb5O6FxCKJ19U4qZY6EJR5JsWBSldmEKOCiRmhAUuHOq1F2w/Z7Oe6SB2r
         2RH26eI2J1N0BneMda92YJ1qD+x1EenrGDblRHQwAi6RTsNPSpbba4vyTOx+Ot7Gk3tS
         Fbierv6USoSVzlTdeZs8AvIBfDnOOgOYqY++Z4glSsFcjIyLEhNSnSdyzzAjK7p8XnQK
         NYQw==
X-Gm-Message-State: AOAM532VucAxQJJP1NELhEXu9GyS0SCKDNYwjLpkDyf4BEMr/VxFSbck
        ZbIYGH1zSyo9S0Tre7NkCDxEkIxD8oAGmA==
X-Google-Smtp-Source: ABdhPJwbVCXz9CojEvvS3ulbd4ZdZURpoULNhPrBUrBupahyzZA63j4U8KebujTAeonLsoQ7NiV5ng==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr19516280wro.7.1616855101955;
        Sat, 27 Mar 2021 07:25:01 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id i10sm19237587wrs.11.2021.03.27.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 10/20] staging: rtl8723bs: remove unused macro in include/rtw_pwrctrl.h
Date:   Sat, 27 Mar 2021 15:24:09 +0100
Message-Id: <39805614be82f1fd90ee460ffedb8a7beb99dce9.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro reading field ips_mode_req of struct
pwrctrl_priv

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 2d77446e9482..36d9ec82a7dc 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -237,9 +237,6 @@ struct pwrctrl_priv {
 	unsigned long PS_BBRegBackup[PSBBREG_TOTALCNT];
 };
 
-#define rtw_get_ips_mode_req(pwrctl) \
-	(pwrctl)->ips_mode_req
-
 #define rtw_ips_mode_req(pwrctl, ips_mode) \
 	(pwrctl)->ips_mode_req = (ips_mode)
 
-- 
2.20.1

