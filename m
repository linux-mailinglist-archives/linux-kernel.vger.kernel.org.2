Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBD391205
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEZIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEZIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t206so201283wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFQkF96uoOmXNTrSzR/ePqfUTd4xGlWbaxlJsr2MtKE=;
        b=qRa7GnzgtRsbbqhHHWYhyOJb7EzvL93QWpm8nMErca1eTzaI6Fn1l3vM8G76a5mgfV
         lXfkz2Wje3plnFz5c+KoboopWeWCKyK8DNgWiJhKjfJjAU6lBJL1Ktqpo00WodYPXL0G
         ++unosXXb0bmd0CSRlhE7W6atBSbg/8y2TKiWD9zXDxOWnpDraXmhVIBPWOvc+x8exOb
         2Gqw3b+QMoVnwKixgpo6yPk65j8n/dmYQVu9qloFdZRxwuISCrDYfdWOogfyZZIO1ri1
         m8Kq6+7mVlxv9fs1/BegpQ5XHoQvz+eVj4CZ+HgGfUTa3D4ROSKLWSqnl+Mg9sZfLcvr
         wHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFQkF96uoOmXNTrSzR/ePqfUTd4xGlWbaxlJsr2MtKE=;
        b=ZeEALQ7oqgX4N7pG328gYTeIINyNBojLtvseNdbtyeOwzqZ5n0ggQAlzYOtcAM9Sjw
         +rCprv38fZJyK23LcDYdQW15+eemKxnGAsIlDy7ZqbEqK/8btYaVCQbF2x2stKHg1Yeq
         I95hdoypQpjHRSomAix04T3auAMvYbctO/AlQBJqlFbiyCxn0chZ/Igayrmupn8ntxg+
         UFvWLpRxrTGtsOs6Sy2uRfgaFPkbhiEysVmB+fmh+9ttElm7xT2UjLsGMfB4uIck9yoY
         8wUJt4dyEGHQW5PSZRqrN36iAlIft5FtZ2I52HH62jDRVr+ZI9N26KwvN5phV6U5Gf+z
         2J5w==
X-Gm-Message-State: AOAM533Yjyqsztzoa0Yg9owk3xxdgU2Fgu/osS15/MnC1NNhgLv7umJO
        hceWHMte4HMNutuGyiQ8in1r6w==
X-Google-Smtp-Source: ABdhPJxtwkGLYcP8g4KXQFrvzGdggp08dNZVHy2beCfSD6XlUI6n1nItuRS5a5ADDA+29miNl+hK1w==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr2108584wmg.81.1622016646984;
        Wed, 26 May 2021 01:10:46 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 01/10] bus: fsl-mc: mc-io: Supply function names for 'fsl_create_mc_io()' and 'fsl_destroy_mc_io()'
Date:   Wed, 26 May 2021 09:10:29 +0100
Message-Id: <20210526081038.544942-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/mc-io.c:53: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/bus/fsl-mc/mc-io.c:126: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/mc-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 305015486b91c..9af6b05b89d6f 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -50,7 +50,7 @@ static void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io)
 }
 
 /**
- * Creates an MC I/O object
+ * fsl_create_mc_io() - Creates an MC I/O object
  *
  * @dev: device to be associated with the MC I/O object
  * @mc_portal_phys_addr: physical address of the MC portal to use
@@ -123,7 +123,7 @@ int __must_check fsl_create_mc_io(struct device *dev,
 }
 
 /**
- * Destroys an MC I/O object
+ * fsl_destroy_mc_io() - Destroys an MC I/O object
  *
  * @mc_io: MC I/O object to destroy
  */
-- 
2.31.1

