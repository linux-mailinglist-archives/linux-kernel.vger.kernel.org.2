Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE536FD06
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3O6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhD3O6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4497C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so105700257ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=PphH2/8H+P5cJwJ14m73i6+FlL9/uCpid2PmcjUMBcJPbe/QW09FtekQJqCqMgVn5s
         fRDy4tQLC0MQJzdPL2wEZW5wePq1uhJmC3GJuHJvp0eig36ZFXOnES9kZg/uAUkUINvh
         oO06EBMwT1Tz3kXksTZUj5/rUTNHwsfSH22Jm+rmsY5QbEJkB2cXMp9FkcB4ubO2qs4G
         /V9+DvTvD2bG8SRrMgPPgVLcurwoOf0iFu5XrDN2uifHtEaL/ZI5ccdpDZnmpXAzNhxJ
         tZQVWnwJ47BsODUd8PJq6T0D6rAjJ9mJqrCEQ/LhrCXIOVbaa14EfvUYygr5zg4SEZLk
         h0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=he22i/2e9BHlOBE8y2/tdgGagmId++Bf1KTQCMIkQ0rWYq6sCyBoqSzcQEtDmTWol+
         c//qrPcXRr8lTbcj/aYu4u+4AUfr2mAkJRMjI7nXYMF2ENhczOKvB0XTZsymMRPuO/ms
         RCqsxv47b691nE390R39uC3KLfmA7yexvB09Ekzq9pE8kd0MS/D1FnIubrxk0v9so6eE
         8vpORvRpu4RAz4g5Bscwe6YLmmznnwdSAgMBBxgrASS1TolkfCE+wC/xzJxtJYLd2vQf
         pzkMKRdSVzNCD2nKSFd2dd5rBeca2IQuav8Po4k4vSsYp3wIpb8jm9SEO30H6kXW9u/q
         C5ww==
X-Gm-Message-State: AOAM530MeLbejqeUk4jqD3hD3x8G513du361xbAoK8lK1j6r7H50zk8T
        gE+qSfK+vsAObkkddWbEvRA2AdyvdnE=
X-Google-Smtp-Source: ABdhPJx1mZfvolsLdk0xnF8EG8Nh2WG0bKiyCqdf0SW3r3uiK38G2R9XnBNPSC/xL73KWYtkasaz9g==
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr4634207ejm.130.1619794648021;
        Fri, 30 Apr 2021 07:57:28 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id dk13sm1560764edb.34.2021.04.30.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/43] staging: rtl8723bs: remove unused ODM_dbg_enter
Date:   Fri, 30 Apr 2021 16:56:35 +0200
Message-Id: <b52f307265b7662bc6a02eac56dec92b3613a58c.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_enter macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index cd68c583699a..7c9a87fb8e51 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,7 +97,6 @@
 
 #if DBG
 #else
-#define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #endif
 
-- 
2.20.1

