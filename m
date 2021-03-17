Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F217D33EC81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCQJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCQJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE02C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so617094wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vmhs1GwnoiVlAu7kb1g3Gxa90rFDalixOIK/s/KOHnE=;
        b=DbaKw0VJMPZu4EklwZJbn7HC7mc2LNcUskiTdj1Bmpr9nnc4e8ck82Tf3PTQv11emI
         G7YzPOxZEm8xGfmFa8AAHd7wotLOLG8M+SZkdf/ZbJu16JaIhblAuLvW0fDp7ejclX88
         7zni7JUf0+WWWDSwGrJQnPK94pVCPVAwkZ64EqdpOXx/lBmEv0x1jyNX0Q7h9gx0zBKL
         KHehJsdYnuENu2Vd1ziFe2rvWUydLFz/2d4MkNz7ExahjUxPUh/6r/Q7dlgrLTQft+EV
         Y1vf1BwT6gBuZOkWIfnvotyW243Z/n2frAvHLD885kINTjKEVehs6WZK6xk8UGk0myk2
         WrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vmhs1GwnoiVlAu7kb1g3Gxa90rFDalixOIK/s/KOHnE=;
        b=GeJ6lilew4Sm6t0leonaCS2Q7QZmBMjQzuQODtQisWF6zRztW9jqPeSuZsWlSxHLv0
         G4KPlxmPz8IiPLhBSMPtmwuBUl0hUARnrC3uxdMq2zNWg+lFa17mHeQdqj9dn5i36vf9
         z2nw108oHEdKXZdPcgXQLnMxcdQiKeQtZV7fzAYcHFu5HIFRv9wGdNf4U24x9sG8/E4+
         R7sYK36Xu4KaOwKPxmTLkfMiSzMwAzebpsl+wT534EKbJ1imX+UnYbbSS61spIm1YDDG
         sAeEWAeSgh6vjLgu8UzXs+RJ+UchAmA/Md82T6/p62OPstztuA9KdyscCExbdUYxFy3v
         yTxg==
X-Gm-Message-State: AOAM530w5+dy1rbcAgISBf2oUUPHde+nBwrJSQZrzKZ/2BsOpJV//CHM
        aCwV1tql34E6xO2udGYLVA/95w==
X-Google-Smtp-Source: ABdhPJyn5Dl4t4/JYqiw7Km1fxvkhu2T+51ibkMmREQnsN39vxMUqwkZ3swoJhP1+uD5I+XIqCt72g==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr2729640wmf.96.1615972373507;
        Wed, 17 Mar 2021 02:12:53 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anil Ravindranath <anil_ravindranath@pmc-sierra.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 13/36] scsi: pmcraid: Correct function name pmcraid_show_adapter_id() in header
Date:   Wed, 17 Mar 2021 09:12:07 +0000
Message-Id: <20210317091230.2912389-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pmcraid.c:4079: warning: expecting prototype for pmcraid_show_io_adapter_id(). Prototype was for pmcraid_show_adapter_id() instead

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anil Ravindranath <anil_ravindranath@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index c98e39eb04b24..bffd9a9349e72 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4063,7 +4063,7 @@ static struct device_attribute pmcraid_driver_version_attr = {
 };
 
 /**
- * pmcraid_show_io_adapter_id - Display driver assigned adapter id
+ * pmcraid_show_adapter_id - Display driver assigned adapter id
  * @dev: class device struct
  * @attr: unused
  * @buf: buffer
-- 
2.27.0

