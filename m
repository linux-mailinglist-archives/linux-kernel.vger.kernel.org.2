Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A813C959D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhGOBgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhGOBgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:50 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE55C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bi3-20020a05620a3183b02903b55bbe1ef9so2562541qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q4BHOu/wzrpYqkE7mCMBCj6/ZE93wztWfxyCm7cmFBc=;
        b=W70LOBXjGPw6qkIkmwPRBu9X/rO3vxDEUhYFmK3v7r9Giv42BOe3r6w8KP6RaUZmhU
         HDiV2CKSIKjVwY6QJduve0Hr6z65b2WegIiK6S5zx6seC6AdmyJx0C1yqrm8psZCMHZG
         hQDXqvzhdvmetv6zPO8zFXawoxAyFWVvxcqUrnaRL6Ls69bEYLoi0qffdliEJtKQYrP+
         oJiVzVgZRVLFppHjuz8ZNepjeZG29nQ1DlB1Js3nZbLDNabTEsbjHOSL/aUMKjTneGam
         taR+egNJn3lVJNPpsX+EMc3n7ZB89Ybb6CvKtGR58kGXjZb1weYiDnTzo2ZvoHsh1JNL
         slhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q4BHOu/wzrpYqkE7mCMBCj6/ZE93wztWfxyCm7cmFBc=;
        b=AzRFPDVtNtdcs3gnmadYZJBdturwPrrmUo1phNQmMPu/O7woHxOsTBKRjei0gGy7lZ
         0ocAdefzvJK8fY6697qwEvyixrJAp2OZ6zilCG4iFWDuKNeNZur21DZ/VtfqBpHose4o
         /b3dGG1RjNPSlIB0UGiaL2TR8bgks9Is6z0RfYadNC+Ul+ALKcsDauJi9ZCev84w16SP
         QKKyOuECn9HG7meaNj7XxOaiaWPs3nFv9p3Mab+ngkFRTedbdje5a1RA8FhY/k7pCpMH
         zmfk36oxq8JnExOnubnStYj0AlvuH+OrxQSnp3PQMUGtXgwYi8cCt75Jrf8tAkW9bhUP
         7+1g==
X-Gm-Message-State: AOAM531cBKFH2atDGV5u9/3cQ68Ahh+OiSNpZC3DeFb1zTLWYRecVfXl
        c19FVUrac/TDRmJq6/j5nnzBD7ByUxez
X-Google-Smtp-Source: ABdhPJyUmDFahCxgVA4ss9+o7IBSi9Md8e1si6j9kEE5+qw0mTEqSY8II6I+kFzgOOAxk7OhXz4KHrG3YN9t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:172:: with SMTP id
 y18mr1256939qvs.14.1626312836130; Wed, 14 Jul 2021 18:33:56 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:37 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-2-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 1/7] perf doc: Fix perfman.info build
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change 'make perfman.info' fails as cat-texi.perl is
missing. It also fails as the makeinfo output isn't written into the
appropriate file. Add cat-texi.perl from git. Add missing output file
flag for makeinfo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile      |  2 +-
 tools/perf/Documentation/cat-texi.perl | 46 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/Documentation/cat-texi.perl

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6e54979c2124..859ec1496716 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -331,7 +331,7 @@ $(OUTPUT)perfman.texi: $(MAN_XML) cat-texi.perl
 	mv $@+ $@
 
 $(OUTPUT)perfman.info: $(OUTPUT)perfman.texi
-	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
+	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate -o $@ $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
diff --git a/tools/perf/Documentation/cat-texi.perl b/tools/perf/Documentation/cat-texi.perl
new file mode 100755
index 000000000000..14d2f8341517
--- /dev/null
+++ b/tools/perf/Documentation/cat-texi.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl -w
+
+use strict;
+use warnings;
+
+my @menu = ();
+my $output = $ARGV[0];
+
+open my $tmp, '>', "$output.tmp";
+
+while (<STDIN>) {
+	next if (/^\\input texinfo/../\@node Top/);
+	next if (/^\@bye/ || /^\.ft/);
+	if (s/^\@top (.*)/\@node $1,,,Top/) {
+		push @menu, $1;
+	}
+	s/\(\@pxref\{\[(URLS|REMOTES)\]}\)//;
+	s/\@anchor\{[^{}]*\}//g;
+	print $tmp $_;
+}
+close $tmp;
+
+print '\input texinfo
+@setfilename gitman.info
+@documentencoding UTF-8
+@dircategory Development
+@direntry
+* Git Man Pages: (gitman).  Manual pages for Git revision control system
+@end direntry
+@node Top,,, (dir)
+@top Git Manual Pages
+@documentlanguage en
+@menu
+';
+
+for (@menu) {
+	print "* ${_}::\n";
+}
+print "\@end menu\n";
+open $tmp, '<', "$output.tmp";
+while (<$tmp>) {
+	print;
+}
+close $tmp;
+print "\@bye\n";
+unlink "$output.tmp";
-- 
2.32.0.402.g57bb445576-goog

