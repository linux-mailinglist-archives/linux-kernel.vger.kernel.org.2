Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8D33F49C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhCQPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhCQPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:51:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0AC061762;
        Wed, 17 Mar 2021 08:51:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so3507881pjb.0;
        Wed, 17 Mar 2021 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/IqkkkG8gu4Lsp1z4NhPLqO/6BQq1UIwKvK3Ngt8MI=;
        b=XK+xOy7Wj66HJhvvJp5sqfur3XsemX5SmneG9VwO1JaTeYbNp8+PnnNrf2TSWKedEc
         3rqS3G45F9Z6B5ZqfL8hYOkSDoRkzua2gRGcr4id2UrSWP8KDnIqoZg7efusZwWAfJJg
         aH89o+WO9ZQE++Eoiv9uEr1kJS/1uZR3V9iNtDDeoBFs4FwHP8N/cSM5+4ni1JP9PGHB
         YWbK6zWQB5ESXekmaV88yW655U2ZErQYty2IKEqh0ZvIsSqVwEQ+nxlyyDh0VBLuzxIA
         c3nO+yq04EVCXAsrFtK6SWOF+LaZ0T+aVNUTK+Gn+RdMW5jbsQBoB3G7nUPxBhjfHrdL
         GGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/IqkkkG8gu4Lsp1z4NhPLqO/6BQq1UIwKvK3Ngt8MI=;
        b=Ri93z8IXkbhhU1OcXpA9vOsJCHgzChN5S8EpS+HenU4vD1vDSfpAlxgN2xv+f8LZTn
         Rcn71cTzzUHjMNfDjCa4Le/T8Hp9KM6J1uStsLf2ONxT2cHhHUUvm77d4+1kCDmaP8bf
         2wV33EeHFkVOrEOl5pk8/lqe7qG5O6HblbjXPje7l/soVgsZTbF3IWc4jsa20fry3VwV
         dt5TxcDhRDFaJNIKVHvh64Cvml/W9G++3kfslznt2H1EzWweMA9FxxL5UeX6x9pjXWYY
         zKTKxFz5GIbBoC5iY+qN9sgKdsvEHkdo6cNtGZvHzdDOBa+klN0mJbaq28NlpKSkpHjs
         DXtw==
X-Gm-Message-State: AOAM530Uw4r/pWNn42lR9zVuSyQvWalE6KMH+YoI4OORZa5B2cc7ISJv
        c5DnFagkBzQW88BGninka4hnbiulHMSpc2q8
X-Google-Smtp-Source: ABdhPJz8aRKcgs7Dx433lstM3SHUcOLizC+xA7i+aAOzModxhnXq9npxMyKHQtGABS9bQ5T8Scac1w==
X-Received: by 2002:a62:80cf:0:b029:1f3:1959:2e42 with SMTP id j198-20020a6280cf0000b02901f319592e42mr4877037pfd.39.1615995920636;
        Wed, 17 Mar 2021 08:45:20 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id cv3sm3535796pjb.9.2021.03.17.08.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:45:20 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2] ARM: dts: imx6ull: fix ubi filesystem mount failed
Date:   Wed, 17 Mar 2021 23:45:09 +0800
Message-Id: <1615995909-6240-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615995909-6240-1-git-send-email-dillon.minfei@gmail.com>
References: <1615995909-6240-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

For NAND Ecc layout, there is a dependency from old kernel's nand driver
setting and current. if old kernel use 4 bit ecc , we should use 4 bit
in new kernel either. else will run into following error at filesystem
mounting.

So, enable fsl,use-minimum-ecc from device tree, to fix this mismatch

[    9.449265] ubi0: scanning is finished
[    9.463968] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.486940] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.509906] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.532845] ubi0 error: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read 22528 bytes

Fixes: f9ecf10cb88c ("ARM: dts: imx6ull: add MYiR MYS-6ULX SBC")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
v2:
correct commit message according to Fabio Estevam's suggestion.

 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
index ecbb2cc5b9ab..79cc45728cd2 100644
--- a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
+++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
@@ -14,5 +14,6 @@
 };
 
 &gpmi {
+	fsl,use-minimum-ecc;
 	status = "okay";
 };
-- 
1.9.1

