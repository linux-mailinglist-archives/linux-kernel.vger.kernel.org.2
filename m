Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692A333EE19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCQKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:08:19 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:58238 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCQKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6myTYJ/6oXihRxGonF
        RwbGYMjlu+sduVYchFyN3kgEE=; b=FroKIg9E10IEsfVhExlbkntjUINapaat5x
        KmtHqtGmSyhSMwaMi9YsmULg6/DQO9fypijWXYcwbepEVEtVdNsuAIBWkgUeteP5
        nUJlRSslv5OKz3KgjRSz2qMfVwrVel0aMPPkEaXuIUWj1NtsESyYHOfo0/MZJyZ8
        xi1mrmqeQ=
Received: from localhost.localdomain (unknown [116.162.2.6])
        by smtp8 (Coremail) with SMTP id NORpCgDHqWiyzVFgW2EYFw--.6516S2;
        Wed, 17 Mar 2021 17:36:51 +0800 (CST)
From:   wangyingjie55@126.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     wangyingjie55@126.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date:   Wed, 17 Mar 2021 02:36:39 -0700
Message-Id: <1615973799-16077-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgDHqWiyzVFgW2EYFw--.6516S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFykKr4rJFyxArykKFy5XFb_yoWfKFbEkF
        y7Zr929Fy0krnayr42vr1fu34vyrn29r1kur4jgw13Ar4j9r13GrWkur9Ikrsagr4xZr1D
        urnFqFnxuF15ujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj-J57UUUUU==
X-Originating-IP: [116.162.2.6]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiWBRYp11w5leZjgABs5
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

