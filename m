Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC026432394
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhJRQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJRQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:17:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DAC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:15:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s4so2321060ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FMQbaJZ7mwSxi4K8SSY2GosUlzmaZ1Vf1hrlE9a5srE=;
        b=hj6zBjrKAkwJAce3K+hntV5+EPNoro/zva45wgtvOnI3xBLbt9nFgbOXOL2PO1QiU+
         H8aaVeS9n4IHZPLEQoq2p9Ggz5gNDPQzLI/i9RFJUCDFg0N9az9yFhDnswbKYvKEkt0B
         lIHPTNQCITskwmStPFV43TNyvy+7xNLxKVfLmNVlU4YbpRV5cqfhWrDoE3gnAfDGhb0q
         pTHCFmMACaGeiwaAKhwsbpt0g21u6rUbvuIJZoteZp5H6ecq0vn2jev5sByBNAIzTg9j
         BnqdtwqRfvwW8Y7wkB3BKUzqky+uhVJ97KpUBZdY1edhTfjdw+ZWL40pycFwCzzCYqRY
         Kh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FMQbaJZ7mwSxi4K8SSY2GosUlzmaZ1Vf1hrlE9a5srE=;
        b=lIvVc7zVF2ZSsFTVLyFVHoJx8yXnKB6t7E4pZ+UojtapkE/AZ6xtru8WXAVY+YZOVd
         7V72f/91CZzgx0RPovEqKS/2nELliQtsrBwG2P11Bn+QAN1FeuHZ8wnV+OA1BCVm3TqF
         qcCeTPGghthwCICWl4iJWkExG069u0izk2NWQjNPQsp86lSYibvMTk7WKp434q4BY2VL
         UbCP9r/djXoP39dpr3i7gr53NFxyB93j3TWnunJMNu57P6emPeQn3qqnTlkhfCfkVFgr
         nmP3RxkCiOJXRT4hhuzGvGoYlCghNkDGB5ZwmJntpw1jdIK81BmHcF6lFDgPbSRektuM
         mouQ==
X-Gm-Message-State: AOAM5309/K3M60K8l66VD6j0hzbTvaFdTKCa1fPhpYHGJIVQyndZaSDC
        tNc08s2hjn3ulPADFIJQ+s0s6zBxtlGVZY2pDfI=
X-Google-Smtp-Source: ABdhPJxhjAMwYE5s/KO7x9BXonAE7mESh+5PbO5jV3kVt1EW6/A1BQQuAxaHIdyvBLcneiI3xVU8fbuSH1mSWQTIiHs=
X-Received: by 2002:a25:d157:: with SMTP id i84mr30618682ybg.434.1634573704589;
 Mon, 18 Oct 2021 09:15:04 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 18 Oct 2021 18:14:53 +0200
Message-ID: <CAKXUXMyN-9JuK4Cg+5aUPWiL-0wnAJrvD4qZX3O5nCERou_j1w@mail.gmail.com>
Subject: Some potentially uninitialized values in pid_list_refill_irq()
To:     Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Steven,

Commit 8d6e90983ade ("tracing: Create a sparse bitmask for pid
filtering") in linux-next adds the new function pid_list_refill_irq().
For this function, 'make clang-analyzer' reports potentially
uninitialized values for lower and upper under certain branch
conditions, see the full report below.

As far as I understand the analyzer's report and the code at hand:

if lower_count is zero (and upper_count is not), then lower_next is
not assigned (because the while lower_count loop is not entered) and
lower is pointing to an address with an uninitialized value and hence,
the if (lower) conditional reads this uninitialized value.

Analogously for upper_count:

if upper_count is zero (and lower_count is not), then upper_count is
not assigned (because the while upper_count loop is not entered) and
upper is pointing to an address with an uninitialized value and hence,
the if (upper) conditional reads this uninitialized value.

I think this can be resolved by initializing upper and lower to point
to an address carrying a zero; but I really fight understanding the
whole pointer magic, you did :)

Let me know if clang-analyzer found something buggy here or if the
tool and I misunderstood the code; we are certainly interested.


Lukas

---

./kernel/trace/pid_list.c:377:6: warning: Branch condition evaluates
to a garbage value [clang-analyzer-core.uninitialized.Branch]
        if (upper) {
            ^~~~~
./kernel/trace/pid_list.c:334:36: note: Left side of '&&' is false
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:61: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                   ^
./kernel/trace/pid_list.c:334:36: note: Taking false branch
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
        ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                    ^
./include/linux/compiler_types.h:329:2: note: expanded from macro
'compiletime_assert'
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        ^
./include/linux/compiler_types.h:317:2: note: expanded from macro
'_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:309:3: note: expanded from macro
'__compiletime_assert'
                if (!(condition))                                       \
                ^
./kernel/trace/pid_list.c:334:36: note: Loop condition is false.  Exiting loop
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
        ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                    ^
./include/linux/compiler_types.h:329:2: note: expanded from macro
'compiletime_assert'
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        ^
./include/linux/compiler_types.h:317:2: note: expanded from macro
'_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:307:2: note: expanded from macro
'__compiletime_assert'
        do {                                                            \
        ^
./kernel/trace/pid_list.c:336:2: note: 'upper' declared without an initial value
        union upper_chunk *upper;
        ^~~~~~~~~~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:351:6: note: Assuming 'upper_count' is > 0
        if (upper_count <= 0 && lower_count <= 0)
            ^~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:351:23: note: Left side of '&&' is false
        if (upper_count <= 0 && lower_count <= 0)
                             ^
./kernel/trace/pid_list.c:354:2: note: Loop condition is true.
Entering loop body
        while (upper_count-- > 0) {
        ^
./kernel/trace/pid_list.c:358:7: note: Assuming 'chunk' is null
                if (!chunk)
                    ^~~~~~
./kernel/trace/pid_list.c:358:3: note: Taking true branch
                if (!chunk)
                ^
./kernel/trace/pid_list.c:359:4: note:  Execution continues on line 365
                        break;
                        ^
./kernel/trace/pid_list.c:365:9: note: Assuming the condition is false
        while (lower_count-- > 0) {
               ^~~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:365:2: note: Loop condition is false.
Execution continues on line 376
        while (lower_count-- > 0) {
        ^
./kernel/trace/pid_list.c:377:6: note: Branch condition evaluates to a
garbage value
        if (upper) {
            ^~~~~

./kernel/trace/pid_list.c:382:6: warning: Branch condition evaluates
to a garbage value [clang-analyzer-core.uninitialized.Branch]
        if (lower) {
            ^~~~~
./kernel/trace/pid_list.c:334:36: note: Left side of '&&' is false
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:61: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                   ^
./kernel/trace/pid_list.c:334:36: note: Taking false branch
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
        ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                    ^
./include/linux/compiler_types.h:329:2: note: expanded from macro
'compiletime_assert'
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        ^
./include/linux/compiler_types.h:317:2: note: expanded from macro
'_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:309:3: note: expanded from macro
'__compiletime_assert'
                if (!(condition))                                       \
                ^
./kernel/trace/pid_list.c:334:36: note: Loop condition is false.  Exiting loop
        struct trace_pid_list *pid_list = container_of(iwork, struct
trace_pid_list,
                                          ^
./include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
        BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
        ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                    ^
./include/linux/compiler_types.h:329:2: note: expanded from macro
'compiletime_assert'
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        ^
./include/linux/compiler_types.h:317:2: note: expanded from macro
'_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:307:2: note: expanded from macro
'__compiletime_assert'
        do {                                                            \
        ^
./kernel/trace/pid_list.c:337:2: note: 'lower' declared without an initial value
        union lower_chunk *lower;
        ^~~~~~~~~~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:351:6: note: Assuming 'upper_count' is > 0
        if (upper_count <= 0 && lower_count <= 0)
            ^~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:351:23: note: Left side of '&&' is false
        if (upper_count <= 0 && lower_count <= 0)
                             ^
./kernel/trace/pid_list.c:354:2: note: Loop condition is true.
Entering loop body
        while (upper_count-- > 0) {
        ^
./kernel/trace/pid_list.c:358:7: note: Assuming 'chunk' is non-null
                if (!chunk)
                    ^~~~~~
./kernel/trace/pid_list.c:358:3: note: Taking false branch
                if (!chunk)
                ^
./kernel/trace/pid_list.c:354:9: note: Assuming the condition is false
        while (upper_count-- > 0) {
               ^~~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:354:2: note: Loop condition is false.
Execution continues on line 365
        while (upper_count-- > 0) {
        ^
./kernel/trace/pid_list.c:365:9: note: Assuming the condition is false
        while (lower_count-- > 0) {
               ^~~~~~~~~~~~~~~~~
./kernel/trace/pid_list.c:365:2: note: Loop condition is false.
Execution continues on line 376
        while (lower_count-- > 0) {
        ^
./kernel/trace/pid_list.c:377:6: note: 'upper' is non-null
        if (upper) {
            ^~~~~
./kernel/trace/pid_list.c:377:2: note: Taking true branch
        if (upper) {
        ^
./kernel/trace/pid_list.c:382:6: note: Branch condition evaluates to a
garbage value
        if (lower) {
            ^~~~~
