Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA65F30A623
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhBALFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:05:35 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:14598 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhBALF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:05:27 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 06:05:26 EST
IronPort-SDR: G/4mpg4QFRLP4DqdzIBci0LoCQNeUkr+Sqp0r32+q9PlyfmcUfI6C4O/kuYrdD+5DoCo9vJdwR
 5X2jxQIvhSR/DhSLTCdk2Kx2rohPq2/j9HLbmot6RY2tny8e9/RDOM2nmKFUv2pw8Xjk1sazom
 0fHh2lgDjBRqdDXF4ECTWs9w88WC+MPYnRvh5TTgt5Uk9TQ5iL9zpEcmQFZ4IsUT2UHLKoMhsk
 TP4t8DjuIwXdKasIdE0QjflDRZj+NboNqagabgIWtQj8CxvBrdtuN1w8EGqpYb1WzbzfWH08fb
 ZQQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="5517066"
X-IronPort-AV: E=Sophos;i="5.79,392,1602514800"; 
   d="scan'208";a="5517066"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Feb 2021 19:55:01 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C37AE0381
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:55:01 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 695E96E017
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:55:00 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id B12194357; Mon,  1 Feb 2021 19:48:46 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, nakamura.shun@fujitsu.com,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v3 3/4] perf tools: Fix lexical definition of event name
Date:   Mon,  1 Feb 2021 19:48:21 +0900
Message-Id: <20210201104822.3230543-4-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201104822.3230543-1-nakamura.shun@jp.fujitsu.com>
References: <20210201104822.3230543-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the lexical definition of event name so that the numbers are recognizable.

A64FX defines an event name that starts with a number.
 - 0inst_commit
 - 1inst_commit
 - 2inst_commit
 - 3inst_commit
 - 4inst_commit

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/perf/util/parse-events.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097..e6bbbd0 100644
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
1.8.3.1

