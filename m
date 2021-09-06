Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D63401F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbhIFS0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbhIFS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DAC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j13so10485512edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=BmddaGugaU1xVoVsKmmDZU9ArzsbPtCO2WAEr9pbxBSWIKx7xi92dRTfpGv8gSz+Rc
         K5lUDzTGcD8de3FpKt0VtN7gG/7g3/hjl5Eni6dtVpiCpNIvdeQNpnKGqyIzy+58TR0r
         fCscbbenvuMhdXHG1cIx9irEwdMHazjC7Z37NMQRF3meer2J0+mZlGI3HFCCFYGrPPBd
         GDMh4c7dEuo90E8SY0XIo9kmu6nYF8mCkN/A89fkSq3anCcjRXbPJKE2kSvlqS/mboVY
         bWoHHeF0bf7SbmB54qDY1d92WeDNwcJN1ZThThGlVUGJm7GQPw8aNECwzNgzjdjLtoa7
         u56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=hBB93nC8j7oozopWEnz7mKoTo/8G9yrZ43oTcy1yENi0Lqbz1WwkhqOomhslzqFvyF
         zyKXPP+I45OMcImEDpKhsQvxJXFePHXpSTURg39WhLObnqeMbM+IdhtonNNU2r9E3ctA
         Ynd1+KIRvwAX3qoek8EZEMaHP3Lmkj0g+hI9YuVoA/D+8p5HW0E6SvO0iauCbTJKqBRw
         M+2LQzposP5iIGOL/7+KTk1J/V9v0xcKdcNudhDrfEpFqBZZtG9nVMCs6jF0H5RfboCn
         dbAfBRVt4qosBVBF8t8EmUeKEpMk87jvG7i1v3kxWGgkmWcUnjxGcr4RJGpg/lODZzRi
         NHmw==
X-Gm-Message-State: AOAM530sLNEVgcjKuK74TLCAhM4Pr7mFOQMLEszI2X4pZi/kbSf4/Fl0
        /t/Q/jEsnmXn8IlqyImGa3MQcf7AMeOUfw==
X-Google-Smtp-Source: ABdhPJyqeZF68fRvL3JczaJYLdIlqSScB0fSQgrppMPeYPqv78zgvrOhEzWDjvLKw+SdmkpXLGx9ng==
X-Received: by 2002:a50:8dcd:: with SMTP id s13mr14504666edh.383.1630952710251;
        Mon, 06 Sep 2021 11:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/40] staging: r8188eu: remove unused enum hal_intf_ps_func
Date:   Mon,  6 Sep 2021 20:24:10 +0200
Message-Id: <20210906182438.5417-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
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

