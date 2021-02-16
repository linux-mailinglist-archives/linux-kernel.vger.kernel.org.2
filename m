Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47631D1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBPVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:06:46 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:49670 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhBPVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=snQhRuDOgG3gM9KJXReOSWJ3Vco57iMwrKIhqXErvcw=; b=Nk4HuqqCQtDxGPkxS2fmWA+MMs
        MvIBTbgywgsyOr82Klut18b5fjiFl3od/MJr6GKOu17nmj+9pSuUvca4ZViFwqny7X54aEsueepK4
        EM4xC4kKjX43x1K6nQrbOI5BacIF7LV4CwEDFsMvbQJ3Xqn8ySG23ttKJxJN1yIhVzCA=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lC7Xi-0002Oi-Nf; Tue, 16 Feb 2021 15:06:00 -0600
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
 <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
Message-ID: <27b38347-f71b-5d6c-3190-4c900e864d5d@codeweavers.com>
Date:   Tue, 16 Feb 2021 16:05:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
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
    They were previously checking different files. Signed-off-by: Nicholas Fraser
    <nfraser@codeweavers.com> --- tools/perf/util/symbol.c | 9 --------- 1 file
    changed, 9 deletions(-) 
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

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
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

