Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9254D3AC55B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhFRH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:56:21 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:28524 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhFRH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:56:19 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 03:56:19 EDT
DKIM-Signature: a=rsa-sha256;
        b=DBC+1xK7d8R6tFyM0VHdG9HLnjV6G3pvnOEZbPgJc6pQ+QJ9gjFHgp1SL/1RaUI4O+ichR0pXfygZgL3e012qA9g+gZE3ylZ81Nls/bbe7jQo0nNNb5j0tRx+GZPelEX006AsGUw0Fvjsv/ow2IAYZGGkSWZu2oxvxAJ5LNcFFw=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=kkbFumgv8OhyX4fIXHw3ZvzYgE9XzT1qiGKrOM6lV1o=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id AC678800139;
        Fri, 18 Jun 2021 15:46:59 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        zhouchuangao <zhouchuangao@vivo.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/nvdimm: Use kobj_to_dev() API
Date:   Fri, 18 Jun 2021 00:46:50 -0700
Message-Id: <1624002415-5439-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkhKGFYeGRoYQk1PT0pNHUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N1E6Pyo*Ij8SCUMQGU4tHSFC
        NzlPChBVSlVKTUlPS0tJT0lLSUhIVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpDSks3Bg++
X-HM-Tid: 0a7a1e165ca5b03akuuuac678800139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 tools/testing/nvdimm/test/ndtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915..004a36f 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -782,7 +782,7 @@ static DEVICE_ATTR_RO(format1);
 static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
 					struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
 
-- 
2.7.4

