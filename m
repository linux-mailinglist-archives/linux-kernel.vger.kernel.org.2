Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760CF426617
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhJHImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhJHImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:42:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001EC061760
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:40:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n11so5297624plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRvRbT4tItXhsQ6uXiyzLkt0Tljb54gMkNLUaVrvoJY=;
        b=M0BdNLwube5rdmMw1NB+QQh07VnGczGl7xIfx6UBT3Pqv9ndlEODlRtFCgcriyPBfE
         q43R2OC7/N17BUe8skG0387B/xPw10ZgLNdHpwF/vI+IZzIEU6cjR8hBo+uLxTzM0/DY
         f7UubkOaXVPiXdHk9IbEiZAV+wQiSSku8d7WqAudhTGsKwbnlRrxv7+UsboDJz7mB0UZ
         BAaz+AivALfjEfVAyQPh9uIYCXmcGIXYr47+EIG38cuhgExm/oa2PbojOVisWPeUF2FO
         K0VZGtQl/d3aOOk5O5Z+swLDihNmOmDJmN0EHMdWiFG2SId+d5psnP8MaEL5bxVDkD1u
         pvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRvRbT4tItXhsQ6uXiyzLkt0Tljb54gMkNLUaVrvoJY=;
        b=q+ZlnNjgA5G76CXlX9M0F3hCEiL9GRcNmL8a2OWlED+7RFMVVfrRZJaiGm88XZMkbm
         nMyMWfz3t2q9jHR4+Raw8xkKhoAJV5wU+007/UJNv9G1GATqa4eFota2rlBe+lskZypY
         bFstxB1a8h/Y/DGCkJdCDsZhW32dVCiCYMyZhOg0ZyVxJbobGNLH90H+vrH1yS5bbo8o
         GQO3r21aYxUW0zrACwp+Cnemn+8EJKrDk03SJutrwR02UpViVzZzAbA5DRw4ajxKOBkl
         J5A6k/la37vDNc91e4SkCwB3oJsUyo1tKpSPsScy9pvj9L9+9sM8KfFO89iR1WgpKuJM
         U3lg==
X-Gm-Message-State: AOAM533Ft1smt3uS4TIqwD+52cKcSQiBmoYtAgvtyuBBIyUKxo2zDqtb
        qR8m5/2zV71bUcQLaG9Xbe0=
X-Google-Smtp-Source: ABdhPJxxZa8baE+0IBL/I9V5VIuwnDlwG1TW3zGECZ3knLPDIZ63IUI8jwjbtrw9VZz+hESDsUUdTw==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr8303766plw.83.1633682429162;
        Fri, 08 Oct 2021 01:40:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v26sm1880847pfm.175.2021.10.08.01.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:40:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, charlene.liu@amd.com, zhan.liu@amd.com,
        lv.ruyi@zte.com.cn, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/display: remove duplicate include in dcn201_clk_mgr.c
Date:   Fri,  8 Oct 2021 08:40:19 +0000
Message-Id: <20211008084019.502758-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Remove all but the first include of reg_helper.h and core_types.h
from dcn201_clk_mgr.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 46e7efe9a78a..db9950244c7b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -26,8 +26,6 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dcn201_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
-#include "reg_helper.h"
-#include "core_types.h"
 #include "dm_helpers.h"
 #include "dm_services.h"
 
-- 
2.25.1

