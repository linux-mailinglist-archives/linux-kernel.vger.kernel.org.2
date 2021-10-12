Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E70429B55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJLCPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhJLCPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:15:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19323C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:13:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso10457274yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TzGZuIVvG0WBjf3dhQtHQdnhtYMq6t/GNubEDrLZqk0=;
        b=FGOL3/Rs+7GDgSYX42yCOZdHES2qq+ZGBE2m9wPboAONL7lZ6M4lXiQVcNIo8V0gt0
         AYjDdn3zAm6VoLgfL/JAoEbc0SAP9Yska7zjA2L3SbcHnlA3U5LDT8HA+JM0Fr3iF3c6
         v0nLnpwsc267zWoENWQcJ52QCXYA7MzFfCrVokD5UBQh1MCMZKXFuJ9Em7prRigI8wD7
         iRwQ3r5fx9J7GmZUIzYu8wtbuJGz5p5Dv8AgxhbIooHq6PL4ZfCwRA63DNO7iXu1kLP5
         XLfec1n/dEzAS+3nYuDzcP0N7ffkN4N9vHUGl/cquTnewMVTig9ZiEONgODmOmIkTQzG
         VJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TzGZuIVvG0WBjf3dhQtHQdnhtYMq6t/GNubEDrLZqk0=;
        b=dDP/O5KqGOgnJiJHXnUHDFEEd7N7c3J2mn4booldd2APu/Kog1TS1wU2Uf4E20Iiu7
         zXqWNhBFgLD0Zh1VuW1Cm5ZaTxQpjaWDIvoV3Ez9SEi67mcSIyGK2W52L6jzp/tAhlSy
         1ZjBPRquZa2OeYire9amdcT7YuRMWu2tbSZogJXOq6mL0Rb2new0dgAnSCVBiNSCFvcx
         dYAknaWGf6WZZQ7Iygs0eySm6FXh3qj8Qo4irYRpSzQ4CAGPx5vQ2ALmMEsNBYme6EnX
         zG/PU4HPF0uFQ3Qj7YTDeR7E5og+0rj9VTf1vTg62rcfY/6eWFdxcrPmcVINRcsNwGsq
         xBRw==
X-Gm-Message-State: AOAM533cOOGcgTanF3mu4STgg3bJ7DILSU9a6823TCfkD5VMZtgJNYeJ
        KGhkFS/Z8HLbi8yqcLKgZm6ic4olac+l
X-Google-Smtp-Source: ABdhPJxLus/BQPrw8yI26ckJbJG5n8t9B1v+YMF5thTZR3nZkX7h3FCC2lZx6KFlj+QW31ucj8sFZzFB711V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2ad2:cb91:6fbd:a6f2])
 (user=irogers job=sendgmr) by 2002:a25:7e46:: with SMTP id
 z67mr24305133ybc.166.1634004810320; Mon, 11 Oct 2021 19:13:30 -0700 (PDT)
Date:   Mon, 11 Oct 2021 19:13:21 -0700
In-Reply-To: <20211012021321.291635-1-irogers@google.com>
Message-Id: <20211012021321.291635-2-irogers@google.com>
Mime-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 2/2] perf clang: Fixes for more recent LLVM/clang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters to two functions and the location of a variable have
changed in more recent LLVM/clang releases.

Remove the unneecessary -fmessage-length and -ferror-limit flags, the
former causes failures like:

58: builtin clang support                                           :
58.1: builtin clang compile C source to IR                          :
--- start ---
test child forked, pid 279307
error: unknown argument: '-fmessage-length'
1 error generated.
test child finished with -1

Tested with LLVM 6, 8, 9, 10 and 11.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/c++/clang.cpp | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index c8885dfa3667..df7b18fb6b6e 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -43,8 +43,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 		"-cc1",
 		"-triple", "bpf-pc-linux",
 		"-fsyntax-only",
-		"-ferror-limit", "19",
-		"-fmessage-length", "127",
 		"-O2",
 		"-nostdsysteminc",
 		"-nobuiltininc",
@@ -55,7 +53,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 		"-x", "c"};
 
 	CCArgs.append(CFlags.begin(), CFlags.end());
-	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs);
+	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
+#if CLANG_VERSION_MAJOR >= 11
+                                                        ,/*BinaryName=*/nullptr
+#endif
+                                                        );
 
 	FrontendOptions& Opts = CI->getFrontendOpts();
 	Opts.Inputs.clear();
@@ -151,13 +153,16 @@ getBPFObjectFromModule(llvm::Module *Module)
 
 	legacy::PassManager PM;
 	bool NotAdded;
-#if CLANG_VERSION_MAJOR < 7
-	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
-						      TargetMachine::CGFT_ObjectFile);
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
+#if CLANG_VERSION_MAJOR >= 7
+                                                      , /*DwoOut=*/nullptr
+#endif
+#if CLANG_VERSION_MAJOR < 10
+                                                      , TargetMachine::CGFT_ObjectFile
 #else
-	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
-						      TargetMachine::CGFT_ObjectFile);
+                                                      , llvm::CGFT_ObjectFile
 #endif
+                                                      );
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
 		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
-- 
2.33.0.882.g93a45727a2-goog

