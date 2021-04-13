Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE635E10D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbhDMOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhDMOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 12so8818499wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3rpQGWrqKW/s7QbBC9Cbbf9cXI28JVOTOSLh/yBH1M=;
        b=WpsaeFL3u13gWmEF34HRreUTaIqGah8lcSrJv73ie+KZpolrAepFs+uJ3rAJeZtplQ
         ouH5wY3MxIFNLDfU5tyuKACVQ89g34WJ8CUPTGabCvSWam/AcV8ql8071XeEmpiCQt9X
         vN9j22fgrc6LhJmcHPYeSuCeOv+6G3LsejiCseJTKkJ9b+2qBIqnJNyydY5r70GDpQV2
         t/zFMhqpoDIFB8J+vRI88jm4SeguNqqNQlGtTpYiEealhGp9GbrYi3wR6Gmeq7DuELHp
         6fMyThnIQ+wyAFOa7BS+xM8Q4HlJLwdrGe4XPDLNl8/BnOXLS0oENXUS6SbZekb10FLN
         YUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3rpQGWrqKW/s7QbBC9Cbbf9cXI28JVOTOSLh/yBH1M=;
        b=hLT4dh3+s5uBU7Abd4f68Cj09Xh3LaZyskO+chmJ6YvzmmT952YpDr/pI8a+x9CsNb
         KnG9mn5cFRRhhMv91tO8KsfBgpiuxOJqL/YfWIbQPv4BhZqLpfNoxTN03V0dxrAAian8
         turiACi4rz1dMTv1UIg/ZdhiPBMNRUtgNQplKvPSdzSIz/iqzkv9hk3yfdZoGrLnBJPF
         LEfqBiwM309xbqW34v5BYd+WPf+MBsGnqI/cW7qovw4daKywnMyD8yiN66nkkc2FmV/X
         31mH2WDQwd2OCnY1m2o/XjxhmB/9I3X5CQ+NBHOoYahvmLDSpYzjLwl2oq2MY9xqUgia
         AUfA==
X-Gm-Message-State: AOAM531DgicKmQ4hFfe/N2MYANdOY6Wlsfa6eaPEz7ZjUCxAZW4RbWrP
        SvwOtb7XU0RWp2TGrDOmUwadwYB+At32nA==
X-Google-Smtp-Source: ABdhPJyiGwnP7Q9+ErwLtyrlvYnHHdXx5Pnm8vKOiNMHvca4e6/T/Z6AIUR3ZsUeuv9hIKHbm3Sigg==
X-Received: by 2002:a1c:f614:: with SMTP id w20mr226170wmc.70.1618323048095;
        Tue, 13 Apr 2021 07:10:48 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id m17sm10525922wrq.63.2021.04.13.07.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8723bs: remove unnecessary dump_drv_version() usage
Date:   Tue, 13 Apr 2021 16:10:37 +0200
Message-Id: <d1804108cfe86375a3006134a8a2a65daefec9fe.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary dump_drv_version() usage.

This prepares dump_drv_version() for removal and
further DBG_871X_SEL_NL removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index a9a9631dd23c..d5ff22ebbc5c 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -491,7 +491,6 @@ static int __init rtw_drv_entry(void)
 	int ret;
 
 	DBG_871X_LEVEL(_drv_always_, "module init start\n");
-	dump_drv_version(RTW_DBGDUMP);
 #ifdef BTCOEXVERSION
 	DBG_871X_LEVEL(_drv_always_, "rtl8723bs BT-Coex version = %s\n", BTCOEXVERSION);
 #endif /*  BTCOEXVERSION */
-- 
2.20.1

