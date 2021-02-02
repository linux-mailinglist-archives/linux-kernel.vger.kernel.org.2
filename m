Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96530BEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhBBNC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:02:26 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:51416 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232135AbhBBNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:02:16 -0500
IronPort-SDR: U6Ri7Ujp9e3e87yZ+AWUrTQqEjBx9Yi0qQ3Vj2mQM2Rk5FHSvGjfSVyuOrDrXD9ywfCcRJCXE8
 2J3AqDG+yORUsdZ5aNSqK6FLdL60ME+29Ne418mcAUKgWueBIZyywkKGNt37B8XVHrQJgDcJfL
 nbzI4DJ0JMXMx50dsllVZkP2h25SVj9HQaTFIOA5XkL3sHRJOnddZAP2o4H1JQzI0TcQik1Icd
 6qyi44F24Jzhv0imhjViukqVzPwuOTQTjXZ4ltHAIwroaN+8RzhH2iyJ2U/z1v3qCwPiLpg31W
 wLQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="5700947"
X-IronPort-AV: E=Sophos;i="5.79,395,1602514800"; 
   d="scan'208";a="5700947"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Feb 2021 21:58:00 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 34435147F8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:58 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CE449B632
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:57 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id F27F61086; Tue,  2 Feb 2021 21:51:40 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v5 3/4] perf tools: Fix lexical definition of event name
Date:   Tue,  2 Feb 2021 21:51:39 +0900
Message-Id: <20210202125140.1785583-4-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
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

