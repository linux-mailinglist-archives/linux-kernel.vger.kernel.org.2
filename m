Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632034E635
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhC3LON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhC3LNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so17722536eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2vIA+ebThH30lhNKRyaeYBJucXzfam6bm2BMpFAsMc=;
        b=xpGb5rfaB+ngbubQaf4TTdClr1gH1dNzNgOqp+rvoLrqoE1YwplwH+Mz/ebvljzUmg
         vIV9ZbitrfipdBWFYlOF8YGpbL5TMDzKYLHw3PE8KkgIGjuzKdMuGpSUamgFuIhtYnRS
         6MieEmBTs/u5blPP0V2VTwX58zwn/3yR2zS2aa+NmQdvbLFN+BVev4rnrifEZ+OnxEHY
         meNIjMnJevwYLE8VMOID1i+r4LaE7LZhqUZrDii7d6Xt51Dt9QsJJJurhj4e/ynR47oy
         avedabB9xa8dsuyDUk08uNR9y7jKDfsdQyT+XXMYSBeoCRt9DuZOlrfOJEuUSGQRCg7e
         7QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2vIA+ebThH30lhNKRyaeYBJucXzfam6bm2BMpFAsMc=;
        b=PjaXPqDRWUvvslMaLT66Tq6synUf9n3BAUyK90UqWvfoWpOPtZEzsDW1nX8LzZC/Nv
         xJwR7+JHln0UkeGCL6ZUzrdEl7UWE+RcoSWraU57mOqID4aeghAxoXczm0UOyFw20NPw
         RvnbgQ/knkqvTLLmHPdcu0/BCS5AD2zXT1MhRsM/ERW89GbGdRVZW7gO0x+tFC4nXqO9
         b+ubrPPZPfHQJZdBXD682VioNI5qnSheDlm2uWLhlY/IHuxgIb5JlM3XsSx98aV6Plyh
         MhPrcrNOrJix0D740frjrMejhvLE5rIb3x0ckp/w7vZxqA14ixKcybm8o3yytkTiu/oP
         iaHA==
X-Gm-Message-State: AOAM532iFOZ0EnHba03CMmJWBbj9FcclFaBcYZOH8jCt8rRPjHC1Lxv1
        RHrtDoeTUfuOFt6OH3Zr2UiKlw==
X-Google-Smtp-Source: ABdhPJygNduO+MvOohaFprdsAvDW2BnmdQzaiULyz8PG+nsYgO2O/YySpclSYA1xjmXyq3410smT/w==
X-Received: by 2002:a50:ee18:: with SMTP id g24mr33354796eds.267.1617102826146;
        Tue, 30 Mar 2021 04:13:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 08/10] nvmem: rmem: fix undefined reference to memremap
Date:   Tue, 30 Mar 2021 12:12:39 +0100
Message-Id: <20210330111241.19401-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below error reporte by kernel test robot
rmem.c:(.text+0x14e): undefined reference to memremap
s390x-linux-gnu-ld: rmem.c:(.text+0x1b6): undefined reference to memunmap

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 642ddc699fd1..dd2019006838 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -272,6 +272,7 @@ config SPRD_EFUSE
 
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
+	depends on HAS_IOMEM
 	help
 	  This driver maps reserved memory into an nvmem device. It might be
 	  useful to expose information left by firmware in memory.
-- 
2.21.0

