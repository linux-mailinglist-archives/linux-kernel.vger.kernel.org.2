Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020763C3657
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGJT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhGJT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625945118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LnDl7vEy8DRwEDscYNvauDRb1U9Zec3Q4Y4HbwhyGnA=;
        b=AojzioM2S2aSyc8k24CPtWodF1xxB+wC4aRVABhBfOAKYzc65TkOYh145iPBu0q7hOc1xA
        n641xSNJK+D8wgI4+ph8aiySmvLuJIsXJUE4QGhsLEjYU4vQF09G04hg1V7u0+zW52rdoX
        gEpFHzZ8SyWpJZ3Frh4MGHV2rZzSzy4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-pooCoKQoOcmY5HG5EM-L6A-1; Sat, 10 Jul 2021 15:25:17 -0400
X-MC-Unique: pooCoKQoOcmY5HG5EM-L6A-1
Received: by mail-qv1-f69.google.com with SMTP id f16-20020ad442d00000b029028c5121bf35so9732467qvr.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 12:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnDl7vEy8DRwEDscYNvauDRb1U9Zec3Q4Y4HbwhyGnA=;
        b=q+9tXG+MyPxPzvK7ux2n2x9yzXlagDhjwMV7jSmmwcdz8teA00TRrycAoJLgVgIMUD
         9jXRGVxVXLbCe6zLgqx+AyVvdpyB8H63qMfK2BtGw8j94ArFh0espe+CHcRM+fdsJdMh
         aSEWSxSGaODTMK5M7Wu9SmHa74ngI50JzVq609cv6JzzX8dvkYyKHsrwsiT0wiZGXjl3
         AO+NjIbCpdDwOamzBnpC71lRsDpGPMx7/+My2ALmzhyx0A0DKMF8CsnpCWLEVbHNeNo8
         l276nLNNTzNg6KQgHIt0LvuCf3HfS6MaTCFE9KN0dqoCW6kB9V2Hadz5GQgKIv+hq/4N
         jAtQ==
X-Gm-Message-State: AOAM532IGufC3ev2PWk5cVtdOGBaJa8obOvUQep2pS6SFoZENz+2MN/F
        bQT3lwV2KDz8jD/a782WOKR5lmMLVEKiPYQki9+PLiX/Pd77b7q+weZOrAvJUch3bhnk1lrZuxd
        T1JO/ZvtqbiXie5ZFKUo+YWZy
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr2891544qvc.39.1625945116762;
        Sat, 10 Jul 2021 12:25:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxYcCSToJ0KRXoArAbf3tl+YdfIwjD/DR7TQeEoGVa52A90pFvsy5rt3SdXFR7KHuCHas7ow==
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr2891521qvc.39.1625945116537;
        Sat, 10 Jul 2021 12:25:16 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x15sm4213370qkm.66.2021.07.10.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:25:16 -0700 (PDT)
Date:   Sat, 10 Jul 2021 12:25:14 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH 2/2] objtool: Ignore unwind hints for ignored functions
Message-ID: <20210710192514.ghvksi3ozhez4lvb@treble>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399996966.506599.810050095040575221.stgit@devnote2>
 <YOK8pzp8B2V+1EaU@gmail.com>
 <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
 <20210710104104.3a270168811ac38420093276@kernel.org>
 <20210710190143.lrcsyal2ggubv43v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210710190143.lrcsyal2ggubv43v@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a function is ignored, also ignore its hints.  This is useful for the
case where the function ignore is conditional on frame pointers, e.g.
STACK_FRAME_NON_STANDARD_FP().

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..67cbdcfcabae 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2909,7 +2909,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	}
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
-		if (insn->hint && !insn->visited) {
+		if (insn->hint && !insn->visited && !insn->ignore) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
-- 
2.31.1

