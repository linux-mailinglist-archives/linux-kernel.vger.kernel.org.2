Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6333EDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCQKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:04:00 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:43828 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCQKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:03:38 -0400
X-Greylist: delayed 1823 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 06:03:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7fLA8
        kcYxRJcVDBSuxgpwdomNhiK47IKlY7AxaYmZnw=; b=boyhAiveS/FGR1K4DYCET
        OJy/+vSPS9aTFQIruOFGuy85qOvceWj/MnmADCMNdwwcSe5s8waO7/Q6QXhuG6go
        ALWXN5q5KLhEQlnkXHNqXsjq3dk8756U/1f6NQisKgO7XeO+rD3pezwt02wX6pvU
        c3IZqmvMEx8hGF1t3NZAVA=
Received: from localhost.localdomain (unknown [116.162.2.6])
        by smtp8 (Coremail) with SMTP id NORpCgBHSz_LzFFgkSgYFw--.18768S2;
        Wed, 17 Mar 2021 17:32:59 +0800 (CST)
From:   wangyingjie55@126.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     wangyingjie55@126.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date:   Wed, 17 Mar 2021 02:32:37 -0700
Message-Id: <1615973557-15889-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBHSz_LzFFgkSgYFw--.18768S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU49YFUUUUU
X-Originating-IP: [116.162.2.6]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiHQxYp1pEC+cFvAAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe()， 'nd_dax' is allocated by nd_dax_alloc().
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

