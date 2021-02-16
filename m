Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159231D1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBPUiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:38:22 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:46264 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhBPUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tKQ2pWJwqZVLEuwEbyo5pWr2TNaoG+vSytCCe2na47s=; b=wcIbEerzaB3RtTVKYIsuaD5M8Z
        oZ5Fu64A7QEMBzSiigqCPH5WZ8HDBXL/zJ/K9lEZhg1IV7uDURe5Gac68Mfl3ZRdC8IKifp7xEF0C
        Db98YClhb8hJlZB4H+ahC8Prn+8ZvMFaVqbpEtLauxu7xOYx5HJWkdm5ZHoI9ppmd/+w=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lC76B-0001rg-Qy; Tue, 16 Feb 2021 14:37:34 -0600
Subject: [PATCH 1/2] perf report: Remove redundant libbfd checks
From:   Nicholas Fraser <nfraser@codeweavers.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
Message-ID: <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
Date:   Tue, 16 Feb 2021 15:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.5
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  This removes the redundant checks bfd_check_format() and bfd_target_elf_flavour.
    They were previously checking different files. --- tools/perf/util/symbol.c
    | 9 --------- 1 file changed, 9 deletions(- [...] 
 Content analysis details:   (-40.5 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 AWL                    AWL: Adjusted score from AWL reputation of From: address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the redundant checks bfd_check_format() and
bfd_target_elf_flavour. They were previously checking different files.
---
 tools/perf/util/symbol.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 492c873713cc..08f6f57c84fd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1586,15 +1586,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	if (section)
 		dso->text_offset = section->vma - section->filepos;
 
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
-			  debugfile);
-		goto out_close;
-	}
-
-	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
-		goto out_close;
-
 	symbols_size = bfd_get_symtab_upper_bound(abfd);
 	if (symbols_size == 0) {
 		bfd_close(abfd);
-- 
2.30.1
