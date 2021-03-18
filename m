Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23A3340A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhCRQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhCRQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:21:49 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B1C06174A;
        Thu, 18 Mar 2021 09:21:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l13so4477963qtu.9;
        Thu, 18 Mar 2021 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=niDtTWOYXUYFGcJaJ5bNloNgVTsHS/48zJQic+B6298=;
        b=O0NaSZHRa4oaubxXOXvR9ECkxXl3VsMSA0baqxLoTGwGgsa/aLGUAQLHtQYHh8BOZw
         zFKWaxQleLrz07PBZJ/9yih3IAy2ALOPncpwe19kc05rGRYXQna+rkq1qLRVyVeg27AZ
         quKgV3sk4k1tTttpHeuKbHGlDvIuAbEaj6ILNA+Eh4vHRlimSw97z94okOLrOQC07s/k
         SNy+GzoSyFZiUnSEILfMBo9P/aqXVTWqrBduYo2MYh4slHzw1uBXEfOJ4Wfiw7E4aUhz
         EUGgHNX5+EDDB6IIImjb/06guSWlDyPBzdshIwYmkATVceWKy4Xk3me/YF/kHAVba+2Q
         MNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niDtTWOYXUYFGcJaJ5bNloNgVTsHS/48zJQic+B6298=;
        b=VPl+3/20lwHLwXc/C7eGo1U59WxHRXdAR3v+zpF9sotq/EGv0JUG6PhDwbrPsJJW3W
         mmpFc/HXbaruLbGlSXFj8zwJKVvD9OYNl0oTXhAQqn+omTTr5AzaRpiY+oaswntA/eCU
         fVpNogRkiRUu0A4bxffdBQhoScrZ40BoC3Y4EyGn1Jc0ZFyMVZk1Q5+q2JAwAduy4tSy
         5iT/aHWBAhGikQ2o+ejvPqRkjYv0uux5Ey2Eci79E1tne/G0N3pj3EVicYSKj/0W6vKB
         YY5I6+XlDFNlb2JyffXJ8yUXMZ0McGHxtK1k+JhODNuidVzLH6f+LEFJD24IjMlyQ4Uz
         D1qA==
X-Gm-Message-State: AOAM5309z+Sa6pVSMYulZzzVwuIAs1rRMqQAij4k0hH28CmWj/cJ2tOY
        nJhjiz4qEbREMufOybPovTs=
X-Google-Smtp-Source: ABdhPJzTha0DV0tfylmIffQqEUphcaa5p7aBYZdPtzeGQwZJ58NlMGqCmHPcIlmuYu+h0pOkE3xohw==
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr4476911qtf.234.1616084508963;
        Thu, 18 Mar 2021 09:21:48 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:d4e9:423a:4aca:b208])
        by smtp.googlemail.com with ESMTPSA id d14sm2230722qkg.33.2021.03.18.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:21:48 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH v4 1/2] crypto: qat - don't release uninitialized resources
Date:   Thu, 18 Mar 2021 12:21:04 -0400
Message-Id: <20210318162105.378239-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YFN6hlz/L7erLO0H@silpixa00400314>
References: <YFN6hlz/L7erLO0H@silpixa00400314>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adf_vf_isr_resource_alloc() is not unwinding correctly when error
happens and it tris to release uninitialized resources.
To fix this, only release initialized resources.

[    1.792845] Trying to free already-free IRQ 11
[    1.793091] WARNING: CPU: 0 PID: 182 at kernel/irq/manage.c:1821 free_irq+0x202/0x380
[    1.801340] Call Trace:
[    1.801477]  adf_vf_isr_resource_free+0x32/0xb0 [intel_qat]
[    1.801785]  adf_vf_isr_resource_alloc+0x14d/0x150 [intel_qat]
[    1.802105]  adf_dev_init+0xba/0x140 [intel_qat]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Fixes: dd0f368398ea ("crypto: qat - Add qat dh895xcc VF driver")
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_vf_isr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index 38d316a42ba6..888388acb6bd 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -261,17 +261,26 @@ int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev)
 		goto err_out;
 
 	if (adf_setup_pf2vf_bh(accel_dev))
-		goto err_out;
+		goto err_disable_msi;
 
 	if (adf_setup_bh(accel_dev))
-		goto err_out;
+		goto err_cleanup_pf2vf_bh;
 
 	if (adf_request_msi_irq(accel_dev))
-		goto err_out;
+		goto err_cleanup_bh;
 
 	return 0;
+
+err_cleanup_bh:
+	adf_cleanup_bh(accel_dev);
+
+err_cleanup_pf2vf_bh:
+	adf_cleanup_pf2vf_bh(accel_dev);
+
+err_disable_msi:
+	adf_disable_msi(accel_dev);
+
 err_out:
-	adf_vf_isr_resource_free(accel_dev);
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(adf_vf_isr_resource_alloc);
-- 
2.25.1

