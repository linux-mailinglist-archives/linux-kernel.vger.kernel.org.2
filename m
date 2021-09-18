Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D941080E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhIRSUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbhIRSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C36C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c21so42710572edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=R9/okF3w/cvvXwXhCyY8qndB/lsT8busgnewl/TA9tqGAFHLC9enUUKSCIO8Pu/MfJ
         n7HQl2nwe4AJ5TxtMfoQmGY4ECM0UWoM/AH1CFPxzm3wV1qAP+BSQsgr/8/Gl9t85Kje
         iVc7Je027vtvkDJJzbSVDaSo2gItp3Mn6QwtV1QsPNhFWDr1WsIXzck6TcL/BEiG9lOe
         CFc3+3lHPFiGDC2/vNLR/aiV9bqvt8erVPGz6OE1ZxPZAIJqn5OiwjK89XpeXAbarZeG
         K0zeYiunIxQZogbk+PpKlXKeV89G9yGshR+8/+YJvcdYyNgJAwyRQYBx8JAq0ZDIlO5r
         ntsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=Lz66a9HBCY33We0qteb5gR5zX19bLn2MHJLYJtjMY8OBO0YDWkKPY+ANskWRof0TMM
         g2RTjIY5YAgRqDqXDA0bPIykiFxiWmb+NLi0Qbeix91Evxl1a+Tt4Zm5RG7he0tHdVUn
         qnkeKHkK1TFldivcSnTzjHqWNM0gEPaY4rJcbPvKQrYlJEe+GvSS3XSHYuOCY7O9Fn2F
         ElZ4v6xzXoYc5TtEkk7zPqKi6q9qxu5/d0Yin7xCL2mzdj1ltO7k80DoDz5m/8U0N4Ch
         d0AjCcebCGl/7NotMgLnu9zge+mrrJ4Vwhpn+cfXeY6gi3Zx6RXg73YWh7jZgv0gDyZD
         7YOA==
X-Gm-Message-State: AOAM530ScDovtwcpwp6ZLv7K0R6zN2+G18gvYaSAIm4yhgjrzZxtbaCy
        SZcuwbTxRQjZyUR2d8aMh+k=
X-Google-Smtp-Source: ABdhPJzmGPxhyTlUJ2EEH0MWMOIsQjv/+XxQJSbLr+RWIJYs+Jswbu9086zgSs1Zfy/7RODgtI+Y2A==
X-Received: by 2002:a17:906:12c8:: with SMTP id l8mr18487242ejb.515.1631989159118;
        Sat, 18 Sep 2021 11:19:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 02/14] staging: r8188eu: remove unused macros from odm_interface.h
Date:   Sat, 18 Sep 2021 20:18:52 +0200
Message-Id: <20210918181904.12000-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

