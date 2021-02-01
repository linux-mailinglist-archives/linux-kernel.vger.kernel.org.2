Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955430A68A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBAL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:29:33 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:44022 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhBAL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:29:25 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 06:29:24 EST
IronPort-SDR: 0AtuqnlDTmVhVvmJZjnXc0yq2ELuaX8Yej3lI3Pexble4RPp5V86mvsuNwrlSTwlLI29++0yfE
 Lb5nBb03LEccmZJhmfnFEuIgqb5eq9fK6tSCPoedVqwccGyrQ4/26HdiJKnOeoJRCD30F/2bU3
 3KkhVoWPhime/3yC3bV3dc+tNhcbgUDPx6RDflIsN1cwkxi+HxPDOp4RmtZULLat3y1ruJ6vYr
 gaFL+3bB1rnL1tVR9hoDx1W6WIeeM8zog98dQq23q5PvQ4LRKRnR1qP2s2HkV/u4n35LJCoFCS
 2eU=
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="5520778"
X-IronPort-AV: E=Sophos;i="5.79,392,1602514800"; 
   d="scan'208";a="5520778"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Feb 2021 20:19:29 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 58168EC7AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:27 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 646F656F8F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:26 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 907955045; Mon,  1 Feb 2021 20:13:12 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nakamura.shun@fujitsu.com,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
Date:   Mon,  1 Feb 2021 20:13:09 +0900
Message-Id: <20210201111310.3231469-4-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
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

