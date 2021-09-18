Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F36410567
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhIRJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhIRJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so19159076wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=RhH20UWzxUdIHzSqG8Jfv28eEPddJ7RwSKXeLI7pmKbUh40X2/GPBcMxi50TRo9kJg
         +WHVhr6azWhyPluVjp94kCTsdI/bsCMYlnQ39kTZkS0bgYRVBvwfq1jod/yd5jg/l627
         TN6nfcCshsfeTcN3RAuMI1fYzEbliMsLlkW5b08EaVCG0KrYOjHmTjxVg5U5PuF9iy4g
         q20GyTGJ4mFYDyB7aNGiJlojkR2FvnP5Xuj+DV2eV3Whliva55Cwx7aFn0DokOd+miOw
         ab2Y9ofytmN87msYxE2uCr1VyTeHVgVt/00h9Tr8n8iqhvfRcHa68yQgvGmB/6q/mvxQ
         FRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=u6fEPvl1E/8T0l5dJvoGQSvCfLUKKIVu/MvGQyySFKPEzqfY9qlK9j8sNPApr06G8L
         uG+KuEWtpUT7qY8hiBDOgbJG+vy30E+dpNCVfYHX6HR6LI5h755Av+VZh8rx07kOin5I
         KBSTXfFNnbKGnju2+Vg0PEXM6rrxFVaYwRF+kSyvljywYMDIDxntQbGoCUIQ6Gi4X4Oz
         0YY38Kuirci7welwYiKCx5fo7buBLyP2Hn8cSWGby0fpE4A4krYAFh/1vaXsP5kjKgRG
         YjxgDcc075A1zGRHD1enXbZNdSZQavaeLoIM1ELa3QoBYx+m4imC8Z85ay+JFrK3a2cR
         xrNA==
X-Gm-Message-State: AOAM532AvzHMZgCWefwj23YJiIne1eHtVsN7lus0ShfjGn6Dw2yXw6OC
        znwMTo31/U4SuIDgAfOVZRU=
X-Google-Smtp-Source: ABdhPJx2aXH+b0iiDNctevxoA3mk8B1wDHbFhdDNlOG0QToAXKOEJnYRiWT8/HtF8CYvF8M5n10+Tw==
X-Received: by 2002:adf:d1b3:: with SMTP id w19mr17002660wrc.152.1631957106147;
        Sat, 18 Sep 2021 02:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/12] staging: r8188eu: remove unused macros from odm_interface.h
Date:   Sat, 18 Sep 2021 11:24:33 +0200
Message-Id: <20210918092443.8724-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macros from odm_interface.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_interface.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index efc2ca069a3d..d3e46b2a4cea 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,11 +4,6 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-#define _reg_all(_name)			ODM_##_name
-#define _reg_ic(_name, _ic)		ODM_##_name##_ic
-#define _bit_all(_name)			BIT_##_name
-#define _bit_ic(_name, _ic)		BIT_##_name##_ic
-
 #define _reg_11N(_name)			ODM_REG_##_name##_11N
 #define _reg_11AC(_name)		ODM_REG_##_name##_11AC
 #define _bit_11N(_name)			ODM_BIT_##_name##_11N
-- 
2.33.0

