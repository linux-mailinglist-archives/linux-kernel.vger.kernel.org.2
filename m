Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B658C319BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBLJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:12:24 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:49043 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBLJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:12:19 -0500
IronPort-SDR: B4wxmL05dlY7PWB466LuwI2+yTOeXH6kWJ7ozVCVPhnPV0KAm5YZw4iHEZqxLqCI/tYKaJ9/tU
 xTpNhcr0MxKMSEvSobDy0rSjrcsIUNNXMh3Kc3n7+LPRmpHEWCkh2D3CSNdmWJT0xn0v6lTYbk
 fJRbBhkt4Dnn/30S42rZcB8QDPNdlEggta7VeUHT56VEd0bAJ3ct6OYrIzF64mYcvGgfX7Wevb
 S0FO1EPDLwUfGEc9+1DzY9AKqDt+5QabyQrXmOB0T8dAkzybdjMiwQiPTG3XcRaokTIlRliXHo
 zfU=
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="7081773"
X-IronPort-AV: E=Sophos;i="5.81,173,1610377200"; 
   d="scan'208";a="7081773"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 12 Feb 2021 18:10:00 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E784AEC7E5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 18:09:59 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 090A29B62C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 18:09:59 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 0924382A; Fri, 12 Feb 2021 18:03:19 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v6 2/3] perf tools: Add lexical definition of event name
Date:   Fri, 12 Feb 2021 18:03:17 +0900
Message-Id: <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the lexical definition of event name so that the numbers are recognizable.

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

