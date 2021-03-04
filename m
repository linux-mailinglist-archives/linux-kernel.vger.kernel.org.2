Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7532CAE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhCDDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:36:33 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:14910 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232471AbhCDDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:36:17 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 22:36:17 EST
IronPort-SDR: cS6DJAJiPOYPyyRVpN1JsVVqxLuRZI4j6lzHpOZQ6p2h6UpzbphD+REx8BxVb06DE3ZQKT+so/
 sAxoxqZKey+QtFH9mX6NS/vgDeBGI0qi7XcJl9+/LDwob+K/wPOkyzQSZIja+Hx8Vr/aTyJcQH
 CbqxnWVl0S77yNAws9nsEt6IrCCsnY0uh9PKoZhSr/8EtsdFRdX6tfBmVNmp4o97Y5PVfbq1LR
 dwkilg6K6s2bGDS/gwhxAJoJhrD00d5fX3kFUSraTa7ldluW4ERCKTsBERWMilTyuusShDQLnE
 s68=
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="9553632"
X-IronPort-AV: E=Sophos;i="5.81,221,1610377200"; 
   d="scan'208";a="9553632"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2021 12:26:25 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A52CF21EC07
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:24 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EC9E29BB02
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:23 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id D50B84007EDA9;
        Thu,  4 Mar 2021 12:26:23 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Date:   Thu,  4 Mar 2021 12:26:08 +0900
Message-Id: <20210304032610.3112996-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
References: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>

Add the lexical definition of event name so that the numbers are recognizable.

A64FX defines an event name that starts with a number.
 - 0inst_commit
 - 1inst_commit
 - 2inst_commit
 - 3inst_commit
 - 4inst_commit

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Acked-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/parse-events.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 0b36285a9435..33f627187415 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -205,7 +205,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-- 
2.25.1

