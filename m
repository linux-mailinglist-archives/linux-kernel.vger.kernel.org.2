Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C53E44BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhHIL0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhHILZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:25:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b190-20020a3767c70000b02903ca0967b842so10727166qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pk34E2M+ZiZK0Nfsu3ClbxlgUD+rETQhezjkayYFVhg=;
        b=OEtXS1kmnL/zNY30uElQkaXnDwYbsbh4IgsfXYc60coZ420GiYZcJ9cyv8vB9cyOAD
         yLCjh3Ibk6TmFwAec1FAFgY7ZtrMJIY66xQ9WPFbAORKfgJt0/bv59HQZRueDTiwejXD
         1FqsNrQO8wizlSc5BIKEpbmYyBvkrMXQ7EcOcsy6omPn81JuxoxcHnZJEID9YbGdkWjX
         E8Hf2OVDPg4wTMTyijXs0UPQyZDrF8JaHsfPoT1929ZqBzfDbNsDb56N8bHqAEyf4wY1
         eMrqKNEQ6EO8SaeTtoLbHTSJvAcWPE2OUgcS2G6SM6XYchPGVdvHh04lv2TgmjDuXhRx
         6HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pk34E2M+ZiZK0Nfsu3ClbxlgUD+rETQhezjkayYFVhg=;
        b=tLRI1Rc+Lh9IriQyycuwFOxC6fA27Q03yu26msKYK0XlJxyFdireQdBfCYZtnNDxBx
         3Edoij4Ct2EjAjSKX+i79DKu6nZKG95xawJqJ0gXzguV8nd2aPUYDtWzN8qOURbh7icB
         yq3754qHxUKBrx/NYd+CHXrciAv6BLPTdJM7HpA9NPW8fPgh46n9sUdk9wkdKZvpw38S
         QSCztLgKYihLXHkF2b2NkTJpG5SXbd+h6xqBVPiixrQN/qUi/DSRcDjubRNdmJ1VRoPc
         czAwhrW4jBGg5eRRblqR4xlq7Xo3AJWQEFIcZJNeSDpmfKCLGx3J3Z9p6RdrnUbIqyeD
         ya8Q==
X-Gm-Message-State: AOAM5335HQuazSs4DG4sty1m7r8zCZDa36veRLEdQ0jWYnJiftckWVkr
        pUgYIKMc3zO1MnV0a1L3tzSdpg5y5g==
X-Google-Smtp-Source: ABdhPJzLjFPfRJ5nvNQNQDfmZjxQlk/sGfhZE2WKRFGavXxhnhE0ZT80QEL5Wv0Y0md0LRSuoi7A6crhEw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a05:6214:76d:: with SMTP id
 f13mr22832309qvz.53.1628508335890; Mon, 09 Aug 2021 04:25:35 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:08 +0200
Message-Id: <20210809112516.682816-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 0/8] kcsan: Cleanups and fix reporting for scoped accesses
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains several test fixes and cleanups, as well as fixing
reporting for scoped accesses.

Thus far, scoped accesses' stack traces could point anywhere in the
scope, and can be quite confusing when searching for the relevant access
scope several stack frames down. This is fixed by using the original
instruction pointer of the location where the scoped access was set up.

There are more changes coming that depend on the fixed reporting, but it
made more sense to detach the changes in this series as they are useful
on their own and only touch core KCSAN code.

Marco Elver (8):
  kcsan: test: Defer kcsan_test_init() after kunit initialization
  kcsan: test: Use kunit_skip() to skip tests
  kcsan: test: Fix flaky test case
  kcsan: Add ability to pass instruction pointer of access to reporting
  kcsan: Save instruction pointer for scoped accesses
  kcsan: Start stack trace with explicit location if provided
  kcsan: Support reporting scoped read-write access type
  kcsan: Move ctx to start of argument list

 include/linux/kcsan-checks.h |  3 ++
 kernel/kcsan/core.c          | 75 ++++++++++++++++++++---------------
 kernel/kcsan/kcsan.h         |  8 ++--
 kernel/kcsan/kcsan_test.c    | 62 +++++++++++++++++++----------
 kernel/kcsan/report.c        | 77 ++++++++++++++++++++++++++++++------
 5 files changed, 156 insertions(+), 69 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

