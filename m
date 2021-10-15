Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EA42ECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhJOI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJOI7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:59:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D49C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:57:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k26so7825885pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7osiKSw9Rr9FSpWxBZjoEXBfkVKC4DnAUrGcrAk7w20=;
        b=LFXHVrWswQfBeugPoUybvSdx6WFF/HZAsAMab+/Asi+P9JXdbefyDBPBxxUUNM0ldO
         +EJqp1EpOK7o8x4bGhN5iZ+9aNN4nX0tvaBR+ipa7U0FPG9LG9yPyIOvTzjFNS8wr+Ny
         9Y4dnaTY93ZB9wMHP4k4TJQX23j0hJqSo9Rgglbac2/1HUwPDohwjtrYLkkE/azlpDH2
         0nppxYb/hT+ptygeBeFshKeIOUzRFyTcov0NY92hsRmdCiilsO0S6LSmmHh7Zo8EKwKo
         S3LkzOsGg9TTe1wt00ifxi7mGGH4GLLNbrP+UP7adVi1J3fBBqB+5LDQN1dNKjcpp82R
         5sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7osiKSw9Rr9FSpWxBZjoEXBfkVKC4DnAUrGcrAk7w20=;
        b=CXEPVNlGh0+VqOSsiox84ROF6eZ58iTopkySB1HnggwmUH26PBgfGm/HU7m07Y75wn
         NLoEqr4YEU6GaD8mfHg0comPHCuIoFVzHWUG91RDzn+Y39RabCOOxJLWv+0z9KyKKxm/
         jc/copuZChk4L96cxN87eSVOVIDxUXYxfGZNzjFmqpE5NlligAR0fdRuQ+1xUGBcSUPH
         iMJ19lU97X10eb4V9Xz8KVKzYRv8PLCFznOQl6pY7fdF/C3zuOKIsPfraTOw7BMA4FjD
         MbgB7l8idYhZXYrGVNanuiCxNCmNfrss1qdRpOFQVP8pe603/iOsmZof7xpcMwN7QE21
         kkkg==
X-Gm-Message-State: AOAM533Uuvk8Sgk2vrpxqb57YMDMXRdPGeTkNQk4sGVZd4lCMWIOdDKy
        v0D7SyfDqMbA9w4S4AcQ4HJQfg==
X-Google-Smtp-Source: ABdhPJwcixoOuO8EYgFO01NJC4B568QDFc0NYxsv6+HfWecRkNtmWlPqJgezeSL+etUPt1zqIV9cGA==
X-Received: by 2002:a05:6a00:a96:b0:44d:a0d5:411f with SMTP id b22-20020a056a000a9600b0044da0d5411fmr26678pfl.65.1634288250665;
        Fri, 15 Oct 2021 01:57:30 -0700 (PDT)
Received: from integral.. ([182.2.71.75])
        by smtp.gmail.com with ESMTPSA id 23sm11081495pjc.37.2021.10.15.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:57:30 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Fri, 15 Oct 2021 15:57:01 +0700
Message-Id: <6sZ9qpcJvtqCksJQVaiZyA-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org>
References: <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a code to test.

Compile with:
  gcc -O3 -ggdb3 -nostdlib -o test test.c

Technical explanation:
The System V ABI mandates the %rsp must be 16-byte aligned before
performing a function call, but the current nolibc.h violates it.

This %rsp alignment violation makes the callee can't align its stack
properly. Note that the callee may have a situation where it requires
vector aligned move. For example, `movaps` with memory operand w.r.t.
xmm registers, it requires the src/dst address be 16-byte aligned.

Since the callee can't align its stack properly, it will segfault when
executing `movaps`. The following C code is the reproducer and test
to ensure the bug really exists and this patch fixes it.

```
/* SPDX-License-Identifier: LGPL-2.1 OR MIT */

/*
 * Bug reproducer and test for Willy's nolibc (x86-64) by Ammar.
 *
 * Compile with:
 *  gcc -O3 -ggdb3 -nostdlib -o test test.c
 */

#include "tools/include/nolibc/nolibc.h"

static void dump_argv(int argc, char *argv[])
{
	int i;
	const char str[] = "\nDumping argv...\n";

	write(1, str, strlen(str));
	for (i = 0; i < argc; i++) {
		write(1, argv[i], strlen(argv[i]));
		write(1, "\n", 1);
	}
}

static void dump_envp(char *envp[])
{
	int i = 0;
	const char str[] = "\nDumping envp...\n";

	write(1, str, strlen(str));
	while (envp[i] != NULL) {
		write(1, envp[i], strlen(envp[i]));
		write(1, "\n", 1);
		i++;
	}
}

#define read_barrier(PTR) __asm__ volatile(""::"r"(PTR):"memory")

__attribute__((__target__("sse2")))
static void test_sse_move_aligned(void)
{
	int i;
	int arr[32] __attribute__((__aligned__(16)));

	/*
	 * The assignment inside this loop is very likely
	 * performed with aligned move, thus if we don't
	 * align the %rsp properly, it will fault!
	 *
	 * If we fault due to misaligned here, then there
	 * must be a caller below us that violates SysV
	 * ABI w.r.t. to %rsp alignment before func call.
	 */
	for (i = 0; i < 32; i++)
		arr[i] = 1;

	read_barrier(arr);
}

int main(int argc, char *argv[], char *envp[])
{
	dump_argv(argc, argv);
	dump_envp(envp);
	test_sse_move_aligned();
	return 0;
}
```

-- 
Ammar Faizi
