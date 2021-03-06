Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2032F997
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhCFLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCFLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:34 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D267DC061761
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 03:05:33 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso559868pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfHAOMbxC7MTHsWF8p12oIJD2meb9c1IkmlruG2cLk=;
        b=oQa2f93ojNFEENAzbWjskJgLPWUPepttHtbGGmAwtO+Mmd9qiVp29+g71zchN3IzoT
         JgFje6XxxcNzBJsGddkMpFcn5qrF3b2z2pbWQtdWHkvPxVvOlclTniWBtp2qbnB+caSD
         u22+jTSAjVpBEVSF6Pot9qtJ+TUhFXsrY7cfQ16d/DoH8Bk1t+qfd6KvH8NmLUJD02lm
         du6tldtT/NLHyDuYYwItnYjY9XSX2ob/DXvb4ZsaRdFmD3kuWqv5jDQpk0bRmJUFsIDi
         StN3Ms570K/eyPgfxJTsZ2qacM4bzt6bNv3IP9sQhRcg+xl7InD2U8ubYPGf4F1i4dMz
         X/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfHAOMbxC7MTHsWF8p12oIJD2meb9c1IkmlruG2cLk=;
        b=fEWxWApyiT7hVIa9MhTOWkbZ3mMLbyZUB2QrVgLzvsypedX7f1zoBziVqlwLXki05+
         hvAKMlOy+WJI+k/4JvS/DO/Vkna/XunjCQdZTUVEo+ujaFHViJlVpFi9Pyblwcr396be
         e77XZf5qt+RcfDLJ+4Tx+h/3wqy6E+gObhHOO1J4UkwW9xH6RINC1+rs8dGB8L0LZhnd
         yGiMDq1tnAHaqFNGzXRiUh0DygcYnbGYuyF0+VzDjbk9xbEfGkZ7ufWX4xkcU+ZUuu/C
         BZK+8TTHhqxSnmZoyVyKPuFbsKYisulSkDLoHi9X5PoK9DVdnNPuK+qNmor9ap7BqdpH
         F2hw==
X-Gm-Message-State: AOAM530OWPorZPFAlnlyLXBoN4gN1+j143XGFZkinFU0SjyBWJFxchdH
        MqJ80sLaXTkU2AeQ6RyC2Ss=
X-Google-Smtp-Source: ABdhPJzlIglq+eDAuFl63+agzj8j0YbnG/skFpE8O2PcgFt5z7j4HeTRpvNWTvfpl+R7RJoBUKc8yA==
X-Received: by 2002:a17:90a:400f:: with SMTP id u15mr14728424pjc.80.1615028733480;
        Sat, 06 Mar 2021 03:05:33 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id d16sm4903743pjd.25.2021.03.06.03.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:33 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     sunpeng.li@amd.com
Cc:     harry.wentland@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        aurabindo.pillai@amd.com, sung.lee@amd.com,
        Rodrigo.Siqueira@amd.com, Tony.Cheng@amd.com,
        Dmytro.Laktyushkin@amd.com, wyatt.wood@amd.com,
        isabel.zhang@amd.com, aric.cyr@amd.com, Anthony.Koo@amd.com,
        Krunoslav.Kovac@amd.com, zhang.yunkai@zte.com.cn,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove duplicate include in dcn21 and gpio
Date:   Sat,  6 Mar 2021 03:05:25 -0800
Message-Id: <20210306110525.216316-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'dce110_resource.h' included in 'dcn21_resource.c' is duplicated.
'hw_gpio.h' included in 'hw_factory_dce110.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c         | 1 -
 .../gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c    | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 072f8c880924..8a6a965751e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -61,7 +61,6 @@
 #include "dcn21/dcn21_dccg.h"
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
-#include "dce110/dce110_resource.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "dcn20/dcn20_dwb.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
index 66e4841f41e4..ca335ea60412 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
@@ -48,10 +48,6 @@
 #define REGI(reg_name, block, id)\
 	mm ## block ## id ## _ ## reg_name
 
-#include "../hw_gpio.h"
-#include "../hw_ddc.h"
-#include "../hw_hpd.h"
-
 #include "reg_helper.h"
 #include "../hpd_regs.h"
 
-- 
2.25.1

