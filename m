Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2942D36ED1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhD2PJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbhD2PJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:09:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31708C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:08:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so2644693pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GgXjPCns+v+eTZAmZafN0sCl2pErz4or/Z5oduKbOjM=;
        b=NOB7NTePrT66Rm9kLn0amKEGyBEPyg8zzxAqifAtZtkD4aZYV58gYuqmp9WytOdFDV
         scMvNF4k+BsBz5Q9Ww1c3wfh3MRfln13ka6MsVrR6fsuuUNoOxRFA/UhwwYT39G3PuG3
         GAoF8SIIcUX1Gom+cT0grvMFxHAZ18mHOW5YrGEj4fQNcQEd+B5YJcHozhl0IKqqd5ek
         zJQdMr41fpuy+qV3Y9zSMX/p3y419ZGiHxw8AZrtbY3LQRgGKK6PPJnc3lb+EGl07ozl
         OLSv5ojaqQBu5F88jkgSRBPVWl7tlKiF5ZS5kIlj4bz1oav/zce+R3eRczcHVxGZlQNF
         MlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GgXjPCns+v+eTZAmZafN0sCl2pErz4or/Z5oduKbOjM=;
        b=V2LqMYKTPrH7pkebLxnbMBsHd0SpzYXBFMZ8iX38q2fLAXAIUzs9e21AyJ1zHTS2kM
         ZAS1/rKthQpkK81ReDvf+qqUeNckv3ZFq4ght1AUngwnT6a8vQZc1XJbL6ofq6cCBMxe
         Xre7U9J8TaiQflb+dokBU4jq2MgArLPtXuA8wTZlScY5gYLKU/7TdiM+a9gRTsuX949U
         RRrxoLHeHuEqccQVMO+4Njlt9A74dm0bvwwzInjUT+hSehWIdLSXBYhn6PILh+zxcxBu
         VXZftGzs/1DLhey8SKKFhWjKHNLkQ/sHgB0ODOLILbSpuKuN74un2a6F5IQqMW6JotMY
         sBpA==
X-Gm-Message-State: AOAM5322534/QwMgT/6qrr7n+OIv0QiLkJvj6KIXzPk8nqYPCOB1X4wx
        Ihdk0sh0zCy4Li+O8Kh92jM=
X-Google-Smtp-Source: ABdhPJzcYVTJIuTNAaStQGXkeKJ+uhEePxuz3QpkB7hBzFgUkPgetxIb2Qo8N30n0hWwJOIcUJLEyA==
X-Received: by 2002:a17:90a:788d:: with SMTP id x13mr7891362pjk.140.1619708911670;
        Thu, 29 Apr 2021 08:08:31 -0700 (PDT)
Received: from localhost ([157.45.131.193])
        by smtp.gmail.com with ESMTPSA id m12sm204486pgn.24.2021.04.29.08.08.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 08:08:30 -0700 (PDT)
Date:   Thu, 29 Apr 2021 20:38:21 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: nvdimm: region_devs.c: Add tabs instead of space
Message-ID: <20210429150821.a23qgknksyqk6ajy@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space has been replaced with a tab as mentioned in Lindent
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/nvdimm/region_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..e8a8fe3fc5a4 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1089,7 +1089,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	if (!nd_region->lane)
 		goto err_percpu;
 
-        for (i = 0; i < nr_cpu_ids; i++) {
+	for (i = 0; i < nr_cpu_ids; i++) {
 		struct nd_percpu_lane *ndl;
 
 		ndl = per_cpu_ptr(nd_region->lane, i);
-- 
2.17.1

