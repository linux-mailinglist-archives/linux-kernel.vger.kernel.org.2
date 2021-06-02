Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA76398D0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFBOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:08 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:45581 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFBOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:02 -0400
Received: by mail-wm1-f53.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1803228wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHanPGk1uQOVUKO22D7xcyQQ9/A6KPvFy4YVhuM9AVY=;
        b=weSv2bllCF3e1ehlxVmp/Vvyzjp3E0FY5fNrrrpD3iURB5k45Pm9TcA8+Js6WKxf9x
         GBOz3TS5syfRjralVfYe6JUyG4b+LJpNVkDMHsCTnZljPC/qsrTJ0zxNpBYRoSPEBmKp
         M+2ltZkccnBPhUHs4STlukcGb6tbBJLnlox2mb5rCUdn+x7DmFYRXrAZvkZAkSNxXvGK
         r5zgx29duwCL6x9FTP5DkBZJYxX7cwxdb8yKSXv/z3LKd4xcIyyfY2deucptM8t8Z9oH
         SI60mk5cLgN0+nk56E9pB0KMNPyWgJlApL/Gf3Rdi1rhs84sWsjxUXNj1YSfwC48Vi3E
         bE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHanPGk1uQOVUKO22D7xcyQQ9/A6KPvFy4YVhuM9AVY=;
        b=e/iMMnlDwFd6h05K9zv+FD/J8OpohvMTniyUi6pRx91IPmMVdIoDxQvQE0NqlAsyNc
         ZKFyxbQWZqi8oR/3x9recBN3e4gIoIL7JbXbv13rdeHSVHPfY6qdyE45uet1L6qbKDgb
         jy5OU2EaZgTZUMBfmkep6hQPYbbNxQaJPGkdq+4t2hwomffN9XEeseprD8MiSjijxq6M
         kVQ0pEv9SxpXQ9jLKbgcP1td2GReUFk2oHTSvCJVWeB54kWkdpgxARDYC5SLURpOoZxt
         osrIPokArShrGPdrLpyCHykFsxMMp6GSs8GQ0S8AtLICznSoWzNa54H/3YFn9U2xPgpE
         Itgw==
X-Gm-Message-State: AOAM533mVFyXhL7J9DWB+UY65X7AdK34j07lhdXrMOdpsO5OfuJRezfE
        1FqoStodp7PvIe3btzxKrEPNzA==
X-Google-Smtp-Source: ABdhPJxN9ta9qy0R5f/5vOwNfZet9pXrYS0G+jE+L4Zlx+LNSFezFCkj20cY+A42n9v7q6yu3KHE2Q==
X-Received: by 2002:a1c:1f4a:: with SMTP id f71mr5593727wmf.146.1622644398348;
        Wed, 02 Jun 2021 07:33:18 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 08/26] drm/sti/sti_hqvdp: Fix incorrectly named function 'sti_hqvdp_vtg_cb()'
Date:   Wed,  2 Jun 2021 15:32:42 +0100
Message-Id: <20210602143300.2330146-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hqvdp.c:796: warning: expecting prototype for sti_vdp_vtg_cb(). Prototype was for sti_hqvdp_vtg_cb() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hqvdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index edbb99f53de19..d09b08995b12a 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -782,7 +782,7 @@ static void sti_hqvdp_disable(struct sti_hqvdp *hqvdp)
 }
 
 /**
- * sti_vdp_vtg_cb
+ * sti_hqvdp_vtg_cb
  * @nb: notifier block
  * @evt: event message
  * @data: private data
-- 
2.31.1

