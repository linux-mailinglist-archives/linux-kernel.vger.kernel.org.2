Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB00397031
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhFAJVU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Jun 2021 05:21:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:48013 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhFAJVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:21:19 -0400
IronPort-SDR: Vn8X6ylzgRw0OywKFL7dL6Eh/q96SmHD6pU8tkbJsai968Bf/V0bhX4SBKb/Nw4NRNT8OGy4xM
 e7JE9VA0+15A==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="267386016"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="267386016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 02:19:38 -0700
IronPort-SDR: MRP60Cx5rkw+QlFqxPO0H1pl4Tem49o9plz2f7xwE89uZnAVqM6z75vcxNK2th9PFkTCotEPUt
 eYMXQu2yM9Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="416412930"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2021 02:19:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 02:19:37 -0700
Received: from irsmsx604.ger.corp.intel.com (163.33.146.137) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 02:19:36 -0700
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137]) by
 IRSMSX604.ger.corp.intel.com ([163.33.146.137]) with mapi id 15.01.2242.008;
 Tue, 1 Jun 2021 10:19:35 +0100
From:   "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: RE: [PATCH] drm/i915/selftests: Fix return value check in
 live_breadcrumbs_smoketest()
Thread-Topic: [PATCH] drm/i915/selftests: Fix return value check in
 live_breadcrumbs_smoketest()
Thread-Index: AQHXVEJ+tkVXHh6hkECEwuczk5ho4qr+5blA
Date:   Tue, 1 Jun 2021 09:19:35 +0000
Message-ID: <33c46ef24cd547d0ad21dc106441491a@intel.com>
References: <20210529043327.2772051-1-chengzhihao1@huawei.com>
In-Reply-To: <20210529043327.2772051-1-chengzhihao1@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Don't see this on intel-gfx so I have to reply with top post.]

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko

-----Original Message-----
From: Zhihao Cheng <chengzhihao1@huawei.com> 
Sent: Saturday, May 29, 2021 5:33 AM
To: jani.nikula@linux.intel.com; joonas.lahtinen@linux.intel.com; Vivi, Rodrigo <rodrigo.vivi@intel.com>; airlied@linux.ie; daniel@ffwll.ch; chris@chris-wilson.co.uk; Ursulin, Tvrtko <tvrtko.ursulin@intel.com>
Cc: intel-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; chengzhihao1@huawei.com; yukuai3@huawei.com
Subject: [PATCH] drm/i915/selftests: Fix return value check in live_breadcrumbs_smoketest()

In case of error, the function live_context() returns ERR_PTR() and never returns NULL. The NULL test in the return value check should be replaced with IS_ERR().

Fixes: 52c0fdb25c7c9 ("drm/i915: Replace global breadcrumbs ...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/gpu/drm/i915/selftests/i915_request.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index ee8e753d98ce..eae0abd614cb 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -1592,8 +1592,8 @@ static int live_breadcrumbs_smoketest(void *arg)
 
 	for (n = 0; n < smoke[0].ncontexts; n++) {
 		smoke[0].contexts[n] = live_context(i915, file);
-		if (!smoke[0].contexts[n]) {
-			ret = -ENOMEM;
+		if (IS_ERR(smoke[0].contexts[n])) {
+			ret = PTR_ERR(smoke[0].contexts[n]);
 			goto out_contexts;
 		}
 	}
--
2.25.4

