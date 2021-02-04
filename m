Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C612E31005E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBDWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBDWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:55:35 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73937C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:54:55 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u66so4058424qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=B1fuVHR3Zm74HBXCgPjs+FlgnRSSGT3DuI6nT8/jWe8=;
        b=cWIIGDYLfadnus6i1GGkf2KwFh4vu9RRcUrcxoHW005TGNfOF05BYSyVWTpAI1taZ/
         IBKfitdlWe4XrhwQ1OkhPLhEtbaF6EzuaIdmHeAC6h2I4110mkFQsDBoitEjFDm58gnj
         LURCQmMJIG4QG+9PGufR3KBqqi7xsAsoEpJ5FDK/4WW8Cw3ztqH0jon4YmULEo153Ms7
         C74+0hTFegbWCIbYLQNjcT8zbiAm1AYlVor0423Y85088NY8uMLjSxJTjQU9nI8np95a
         R7iMgjMJv4j4Zk2yJf1pxkVuOYGay9Q3kIVO96FAsQBbXQ9W2pbmsSMPLW70MPtRbdpM
         /MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=B1fuVHR3Zm74HBXCgPjs+FlgnRSSGT3DuI6nT8/jWe8=;
        b=tWA12wuxwvKfV4Gh+cZJx7tJUtmqCpMcP2GU/JUORkedXRRAAoeKXyfBDFXCt92xhM
         +N9VTk31vLrTdBSWbyk4WR3RQgGV+PkuuRoXpZy1JzW4o/QfwsFK0e5fJVnWjUD2/ZX8
         kwibcDUl+jYvDL4ePOJfHucGB5XT2J5UJAz5F91WOq+WCH/ictSN7z4te3hvCmv7xCUB
         biRqQRQ5MxHH8DFoEkEQoxKhpw9ZnjXoyzb3mvTESCwSKakZiDcze6sKZYsbmnaSS6u7
         9542yR8NLOXOxHdfefPHcORopIlvJhL+8lSXHRQCuIgTXmqiPN7vG5NoVUcebm5C9gpI
         fK+Q==
X-Gm-Message-State: AOAM530qR8qOjtbkqVT+GeLUdmiWEtlLLaq5QzA/qCWG1v+FdPnjk8Rs
        ziSZL7nqDPhgu5KdJ2yYXUCd2PDmO38yYg==
X-Google-Smtp-Source: ABdhPJyj4dZTivbA2mv/icChL04lGA9XqXu69pF0p4QFdHKEl7Hqm3M3X2AnOPO2rHfTU9njuG7WL58Ph1Ci4g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:192d:: with SMTP id
 es13mr1841289qvb.9.1612479294611; Thu, 04 Feb 2021 14:54:54 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:54:45 -0800
Message-Id: <20210204225448.1393741-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 0/3] kunit: support running subsets of test suites from kunit.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using `kunit.py run` to run tests, users must populate a
`kunitconfig` file to select the options the tests are hidden behind and
all their dependencies.

The patch [1] to allow specifying a path to kunitconfig promises to make
this nicer as we can have checked in files corresponding to different
sets of tests.

But it's still annoying 
1) when trying to run a subet of tests
2) when you want to run tests that don't have such a pre-existing
kunitconfig and selecting all the necessary options is tricky.

This patch series aims to alleviate both:
1) `kunit.py run 'my-suite-*'`
I.e. use my current kunitconfig, but just run suites that match this glob
2) `kunit.py run --alltests 'my-suite-*'`
I.e. use allyesconfig so I don't have to worry about writing a
kunitconfig at all.

See the first commit message for more details and discussion about
future work.

This patch series also includes a bugfix for a latent bug that can't be
triggered right now but has worse consequences as a result of the
changes needed to plumb in this suite name glob.

[1] https://lore.kernel.org/linux-kselftest/20210201205514.3943096-1-dlatypov@google.com/

---
v1 -> v2:
  Fix free of `suites` subarray in suite_set.
  Found by Dan Carpenter and kernel test robot.
v2 -> v3:
  Add MODULE_PARM_DESC() for kunit.filter_glob.

Daniel Latypov (3):
  kunit: add kunit.filter_glob cmdline option to filter suites
  kunit: tool: add support for filtering suites by glob
  kunit: tool: fix unintentional statefulness in run_kernel()

 lib/kunit/Kconfig                   |  1 +
 lib/kunit/executor.c                | 93 ++++++++++++++++++++++++++---
 tools/testing/kunit/kunit.py        | 21 +++++--
 tools/testing/kunit/kunit_kernel.py |  6 +-
 4 files changed, 106 insertions(+), 15 deletions(-)


base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0.478.g8a0d178c01-goog

