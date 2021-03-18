Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837B43403AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCRKlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhCRKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:41:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BEC061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z2so4948861wrl.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yMyTx/PpExLvmIr8KOOoFx0Kjtq3v/0W3wLq2/Ei0c=;
        b=LWbXmDN3q+yD7+Q955ekFxtm0xCrculnsCqRaoaJ0kzLDZCRQjA0lTbP4IRdre01sE
         prSEqoK6g7fj92lXouxAtmctw+TmODnQapL+d+g8FTgAL/B89pWQ/7t6rhYgvxC2nj1T
         MmbrY+NiBnqDRqGOVxspdnfBSZa+yiSw++DSzOqUn+pcUTKRY5eMTfoR8TZcLI2MpgJp
         tDuwKqU3v2i5UPUjtu2YVEv2L8TQsbY9AJylLYhGYGILkLea5DsoS+rvrmN//tvX9eN/
         PcYS8SL4BWXCUoo/Lg7r2zPIcSFbWXJ9nMZO/f5mXroke/BHjowSFyR0zrGWYrST1Jji
         P/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yMyTx/PpExLvmIr8KOOoFx0Kjtq3v/0W3wLq2/Ei0c=;
        b=eUvOWau5Msgw7dcEo44N6mh54RFOhy/WA7gimNiStqH6sLsZCmTVpTfemErragfgAR
         IFDKArhZNvISTvfUnldPytAc8pG6+aW+KvW88PXkPnNHp9Xqdgquq+xGVZTK2CkEq9PP
         wLejAMgbMnVLqe8Hxf+j84V4UIaXRoogXwbGKJ41bFQGRGckJxbmqcfX0po7xVh9Ou7d
         DrLWzA6lQjrCU2FFL/S3n0a2Xf3Bwq/uLhz210hOBVXtWYWCJanFSRJjWxDeL8X/8aIQ
         BKdKAi/jhjinEicXI6eZoFt4aCA3HTUezZPKtIu7/2nzXH0LbUrm0x63O8OB7Ga/ByXk
         2bRg==
X-Gm-Message-State: AOAM530pc+PTHJ0qPxIs4hJt1jWKyEuO9kuAvfIA0PC7tjdPpDzkyERw
        1R6Er+3CtCsR8KgU/W8dj1xpnA==
X-Google-Smtp-Source: ABdhPJwwDKrMDYyQi6OEXvXPYtdXQ7+sEYKtvGl0FhUt2Pow5rxP+eWZK74XejGe429hox7g47UkaQ==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr9051990wru.82.1616064049654;
        Thu, 18 Mar 2021 03:40:49 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 06/10] of: address: Provide descriptions for 'of_address_to_resource's params
Date:   Thu, 18 Mar 2021 10:40:32 +0000
Message-Id: <20210318104036.3175910-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/address.c:868: warning: Function parameter or member 'dev' not described in 'of_address_to_resource'
 drivers/of/address.c:868: warning: Function parameter or member 'index' not described in 'of_address_to_resource'
 drivers/of/address.c:868: warning: Function parameter or member 'r' not described in 'of_address_to_resource'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/address.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3fe..7de41abe7153f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -857,6 +857,9 @@ static int __of_address_to_resource(struct device_node *dev,
 
 /**
  * of_address_to_resource - Translate device tree address and return as resource
+ * @dev:	Caller's Device Node
+ * @index:	Index into the array
+ * @r:		Pointer to resource array
  *
  * Note that if your address is a PIO address, the conversion will fail if
  * the physical address can't be internally converted to an IO token with
-- 
2.27.0

