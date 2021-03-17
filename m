Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5631133EC70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCQJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhCQJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so1008654wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLJQSgQWxXN2wb6bBodFmEtoRfcnDqNqbqxISmqUROc=;
        b=aCK53FD1MvQhxDy9E5GlZ3fBCIB/5MJUl00lIdAFNFGX5slTA0hfmWWpQHXjPl5PYO
         Y3BeKR3dVg52uUnnUIY0wMhNntV0xmlQCOGFhxVPNUoZXDY22BML7bRnmGveD2UyEckb
         cnSZbwS+zC0aIilCAa8xL5mPJptbcts9RIjOBV+SE2PQRjbtCEx07IOjgCzWR9fnQu0Q
         dIgn17RFwXMMYfuyYelYCpSwBGxsPZuqjZyusCVkVw2Y+7eeik0G0LQr/d5uFrQN6n1s
         636247jJTOF80YvNmqvdE7itXQNisLSmsT7MNCmTIQ/D3wQUQ92YKBjPgUhmHXXGq6RP
         fO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLJQSgQWxXN2wb6bBodFmEtoRfcnDqNqbqxISmqUROc=;
        b=GF54ezJNmmir9hTe94m66QwxLf9bu6NFVGpLSmSkJpAla5ICZKWWeBstYfG4B4L6AQ
         dLpSpuuvQ4xFnZatu+18EonuycPhViM0oWv72hT8sbbgq1PX/HMOHu7QIAuXKYHSg8gH
         1s6O97Z26cl07/dvaT7qynFkprpVJE9xPAvcUvcFSsoRDRm/ScPJ8EIqCFVVdx0U0shK
         L9lLMvgxGkdY2y4B04lOdCcXYGAlFUWgDbO1aOl79JU3CVKhobzUFcE/xdgVFLoVEdGi
         BclEnsjBcDG1qo+RRK1PaiiTBjrqScOFmDOt+X+pTeLV5MyzHixVSse1Q9OufAOAg5ko
         HEdA==
X-Gm-Message-State: AOAM5306WcbJVmuIKupzjsBhMS6zZzKfq5HAZoh4q3Vq1Y7kGsaq03iL
        ImdFKN6FM71qxCMa6dNZhrUPag==
X-Google-Smtp-Source: ABdhPJzeb8pknJeI+uRC3ImYBONXlIC7hhj6T2DxZwl/mgDXu0RbgwQZHDABPcaneOsnJ2GEl+DljA==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr3207702wrg.180.1615972365666;
        Wed, 17 Mar 2021 02:12:45 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Drew Eckhardt <drew@colorado.edu>,
        Eric Youngdale <eric@andante.org>,
        Jirka Hanika <geo@ff.cuni.cz>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Torben Mathiasen <tmm@image.dk>,
        Alex Davis <letmein@erols.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Badari Pulavarty <pbadari@us.ibm.com>, willy@debian.org,
        Kurt Garloff <garloff@suse.de>, linux-scsi@vger.kernel.org
Subject: [PATCH 06/36] scsi: sd: Fix function name in header
Date:   Wed, 17 Mar 2021 09:12:00 +0000
Message-Id: <20210317091230.2912389-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/sd.c:1537: warning: expecting prototype for sd_ioctl(). Prototype was for sd_ioctl_common() instead

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Drew Eckhardt <drew@colorado.edu>
Cc: Eric Youngdale <eric@andante.org>
Cc: Jirka Hanika <geo@ff.cuni.cz>
Cc: Richard Gooch <rgooch@atnf.csiro.au>
Cc: Torben Mathiasen <tmm@image.dk>
Cc: Alex Davis <letmein@erols.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>
Cc: willy@debian.org
Cc: Kurt Garloff <garloff@suse.de>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ed0b1bb99f083..91c34ee972c79 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1519,7 +1519,7 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 /**
- *	sd_ioctl - process an ioctl
+ *	sd_ioctl_common - process an ioctl
  *	@bdev: target block device
  *	@mode: FMODE_* mask
  *	@cmd: ioctl command number
-- 
2.27.0

