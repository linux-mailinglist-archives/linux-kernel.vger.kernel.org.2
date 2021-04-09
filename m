Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23E3591C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhDIB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:58:54 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:44088 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6myTYJ/6oXihRxGonF
        RwbGYMjlu+sduVYchFyN3kgEE=; b=lVV9+qH2cvtcwzftgpjy0OFDmU8X4IcPAV
        jmiTDormglV8wUc5vMlkm298Kr2w8AUwd6BC3vvrRZWc62SQml5zxwbghLHDgvM5
        I9Clx0AKwNOXQcjMWXD6hI0Kr8bcHeH/f3C4fW9kAWsK5aQLWKdqQvCl3EiaPWa6
        cnOgjP66E=
Received: from localhost.localdomain (unknown [116.162.2.189])
        by smtp8 (Coremail) with SMTP id NORpCgCX06PFtG9gAtgdHQ--.10140S2;
        Fri, 09 Apr 2021 09:58:31 +0800 (CST)
From:   wangyingjie55@126.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org
Cc:     wangyingjie55@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date:   Thu,  8 Apr 2021 18:58:26 -0700
Message-Id: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgCX06PFtG9gAtgdHQ--.10140S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFykKr4rJFyxArykKFy5XFb_yoWfKFbEkF
        y7Zr929Fy0krnayr42vr1fu34vyrn29r1kur4jgw13Ar4j9r13GrWkur9Ikrsagr4xZr1D
        urnFqFnxuF15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeVnQUUUUUU==
X-Originating-IP: [116.162.2.189]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiGAdvp1pEC2HqHgAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe(), 'nd_dax' is allocated by nd_dax_alloc().
nd_dax_alloc() may fail and return NULL, so we should better check
it's return value to avoid a NULL pointer dereference
a bit later in the code.

Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/nvdimm/dax_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..b1426ac03f01 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 
 	nvdimm_bus_lock(&ndns->dev);
 	nd_dax = nd_dax_alloc(nd_region);
+	if (!nd_dax)
+		return -ENOMEM;
 	nd_pfn = &nd_dax->nd_pfn;
 	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
 	nvdimm_bus_unlock(&ndns->dev);
-- 
2.7.4

