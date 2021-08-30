Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB063FBDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhH3VNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234509AbhH3VNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC1F260F12;
        Mon, 30 Aug 2021 21:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630357956;
        bh=YrP4QWnjK4YR+/nxa4JkFJROV+YrCrmUhd7Yrmz5SOk=;
        h=Date:From:To:Cc:Subject:From;
        b=rMiPMhiFHCV8mWRklW8TonxJ8LIIaAH7hfr0kn7d+V1TM2GsCdkUS9MAeb4Kk0x3N
         Gsvq9OEeJSNYiDVuTwr59qqXVTXueDxxi29G/jm0EBPbBDttUgb4vPHz+s+mVhvysk
         KgBgkqlQGmTXGEIyOX+4oLGFLXjNEpVqjiL2SVSzfZ6ih1ukMihRnuBh/VLM6FMhTH
         //fniMIdcyWSW1TMec4pTCQr6eT9LgJ/1FzgOPCfWhEGQRNB+cJin0DBM6yRU+RbV6
         8vAnxGtdQmML9xWDKZ/W4QhzZ22nHZR8FBp5mkGK88aFcs5EvHdwwzgrYQVcOusi5R
         0aetTdVIEdtUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB9FF4007E; Mon, 30 Aug 2021 18:12:32 -0300 (-03)
Date:   Mon, 30 Aug 2021 18:12:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add --sysroot when building dlfilters on cross build
 environments
Message-ID: <YS1JwIMTNNWcbGdT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

	I had to add this cset to fix the build/link on cross build
environments with a sysroot, like Android, EXTRA_CFLAGS is where it will
get the needed --sysroot=/opt/android-ndk-r12b//platforms/android-24/arch-arm, please ack.

- Arnaldo

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 24623599113df215..e04313c4d8409a94 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -785,10 +785,10 @@ endif
 
 $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
 	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
-	$(QUIET_CC)$(CC) -c -Iinclude -o $@ -fpic $<
+	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
 
 $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
-	$(QUIET_LINK)$(CC) -shared -o $@ $<
+	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
 
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
