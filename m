Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FB401FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbhIFSzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbhIFSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82883C0613D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc21so15074609ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=SLYoF45iT9ysDQ4MAC6jMfYqP4mdYmwXYtYuf/+S7RPNq6xtmqAkl/eEmp1DxNOR+s
         R1VU46s/RXz6t7m9OHhuC+eZpJ4zrPdP5Wm2+k2AK1UCQ8IAYOvWy003CEWLZi1g9bry
         +V4iGYhYAhacP9D3TtNPIvXQig2cgS3MAK76aJqBy2R+0a2mAvcpaLSy7D8CZOuaCQFa
         Tco0FMecb2r8gd9m7j9FPNFX+9tWgpP4PNZqQVZdV8iLl7tWqlxUu3km6ys4x6Xi51em
         5TISQrydyYB5oI6tN2khR4sgE7RMVlvUOv5uK7MJdQa22Pj3K1uuc36XStLJsXgBsxWi
         B13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=nt7wAG/jrBkVlMgVryOEyut6CW71RB5NVx622k4+EYPQW/eBDNNwsXHv71lQv2a47h
         W3h1FG686iLm/critPrzYPfnXUiXmeFN07mRUKjsMFwkhrmERHqmTmeIJV4zd3n4v23f
         3kEmjxxJXc/m+rpeIWidR2ns9UacNF3h02+uwobLzFuE2VArmNdJOLMbZMhAv63gHYtb
         5ipr+3jTLcb2MMMADkNTU/7KmG2PPSYmAbDJiDyS/LzS9f/yVh+ICqpdNPInYqWY48O6
         +dijNXF6zgQFbBw/AlEcAeqMozucR/cnnvklb3WpNQgvFQVbUOsVKqLj9Jsrqvp5j94R
         Teyg==
X-Gm-Message-State: AOAM532Qx7lBaPkCWOLgox7Qq5ZXTVGDTUMpYUDiprPAXHKJkvWtsp1P
        ZBh2XsPIijyoVPa5qMNaYqLpeV3ZE54ekg==
X-Google-Smtp-Source: ABdhPJymwJz3ufK2fcjPmNJkoieZPDpRmFGsEc2irfHTwkJV6HAdHx4KyLDS4JRq8UkEWCdTbyzvxg==
X-Received: by 2002:a17:907:92c:: with SMTP id au12mr14799225ejc.523.1630954451382;
        Mon, 06 Sep 2021 11:54:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 12/40] staging: r8188eu: remove unused enum hal_intf_ps_func
Date:   Mon,  6 Sep 2021 20:52:59 +0200
Message-Id: <20210906185327.10326-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAL_USB_SELECT_SUSPEND and HAL_MAX_ID are both unused,
so enum hal_intf_ps_func can be removed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/hal_intf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index eab0b8576c92..3bf0d18e2ba8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -121,11 +121,6 @@ enum hal_odm_variable {
 	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
-enum hal_intf_ps_func {
-	HAL_USB_SELECT_SUSPEND,
-	HAL_MAX_ID,
-};
-
 typedef s32 (*c2h_id_filter)(u8 id);
 
 struct hal_ops {
-- 
2.33.0

