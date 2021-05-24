Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8668538FA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEYGM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhEYGMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k5so16203249pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
        b=MmLzG7y59sZYQcrjYGcKmhKp1oMwcv0fCumRzjkE1uwG/p86vc9uhUENNmqwR/CfQ3
         D7IO2cPpgHW1TkJhrqdNrxIdrDJzQwaBab+NGUXsdhoLFYgFpCcuf8qfmZshMb00O1ee
         w9A3YLJlBcb05tvqnAqhqonMvCA7hnKHcVJQygTuYmUeepQ/6hBZz7pWCcylt+M74PlF
         5hTFDQkSCfV5S/Ggt+eeHQz/lPOcsKVVr/gib3qXTAP8+12Mp0xfwLZX1ZBZsNTi3mxp
         BqaJWZ/+K2yM/ih1cT5xXbG+uLZjWJmcDu3oGbCi9HG5mHECIJLUAwe0QmFeiD50kv0F
         X/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
        b=MvcJTYsp1FGfjewoGOtxaeZhMnYjS1Bem/AWVr3HgA4Wl8SJ3UGc1sFr0Zcs9nr3UV
         YRa9YhoMN7acE8iSfr/4SsC5ynP03vcP0MP4T5xk05ega8bq+b+otP8h83jzNSOUGmky
         28JhMZld4vlHu2Ib66Qbb3oJcIUlt4m1WKQKjvTUjAVG6mbOWiIKzjs9Esm4+Gf0VImw
         E7fM+DMHRzkVR+B9DlQ5fCtFu0GsHB2IA5YweiMDeRlNE0q5FbgBt92iQ/pTVQLoQk+m
         dxpquSLC+hVeR20xoBa6gkYR8SngIXYnhurc5qMKFzXxK5vLMHZIWlqESncxsTmqdGm5
         5yAQ==
X-Gm-Message-State: AOAM531TfvHDHnMit9bMP6BisQ7WAnIh2OFWinYciXFBfq89hMWz6M8b
        EjP1ViziFCpqqzusOeOOE3g=
X-Google-Smtp-Source: ABdhPJwhyiOGqXzf3w88EuYECEbaunS2WVlc/eoo6GTlGCCWykLxa+XEes3OwdZf7Yd4M1K2xV69ww==
X-Received: by 2002:a17:902:f2c2:b029:f0:d72f:4f97 with SMTP id h2-20020a170902f2c2b02900f0d72f4f97mr28829418plc.65.1621923079634;
        Mon, 24 May 2021 23:11:19 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:19 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Mon, 24 May 2021 15:41:59 -0700
Message-Id: <20210524224159.32807-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Do not use flush-queue on virtualized environments, where the NpCache
capability of the IOMMU is set. This is required to reduce
virtualization overheads.

This change follows a similar change to Intel's VT-d and a detailed
explanation as for the rationale is described in commit 29b32839725f
("iommu/vt-d: Do not use flush-queue when caching-mode is on").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..ba3b76ed776d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_warn_once("IOMMU batching is disabled due to virtualization");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

