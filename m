Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2813FA1A4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhH0W7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhH0W7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:59:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E10C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:58:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso737697qkc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GZHnj3E2iDvREWy+Xx+rZN4g2ibNoBnA7xrbQSSkUpQ=;
        b=Ipr9sUKvRrPwBplFtKFiksRe+d689PFtXWc/Ur0tK0j9TaPCWRldqoTsZgTOf7eRdQ
         Fk3SAWF0exxDZo6OU5+uO/oIPv8KrjQFY/5i+VnMqfIjRHSQA1Ad3BSH1Iqd2NLUpR+u
         T1G7gYqLhIGcKSvRvo0kNTWMGN1mLcBiX9y/P/9nDw3eOwjt7nI1dmBGBZNitT2sm5G4
         UM0v/rUJFws0K04jm3JpdET4jlniWVuyKjdnCdkPHnJlS7tOW8IrlK2dUZBT2LF52doa
         AInHmiscxdtXgN50u9c3rNBXlMjmcMdYHSS1NA2HsOunffqHikGFbgpBfumRGcLdWLMG
         ndag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GZHnj3E2iDvREWy+Xx+rZN4g2ibNoBnA7xrbQSSkUpQ=;
        b=ZxD7kbfobp8nHdLFeCVvKJitu9fKJiFq662hMPgccQNQoKxhfai7Ex+eZNPTuIL4jp
         ubTMdVraZBO7VNz8W2Bcga9BSdxqGJH5NpKGIWX/enm2is4Ogh6Vj5Mmw8/AEmkvQioA
         huXf2RPBRWdN1d8tnROxV1DR+ggERNg2hGe/dJddT4T7yVFJEhvh0ry0pXKpdJ4GM8KI
         G7cEEMFS4b/pcI+8wlsiJX1HEV51fem5GpG710YzydScowTqa+WFgKGT2517bZuC8lrl
         N4ngLKjbRdDf0jAXPFyneBUgfA+BG2W1CKF1EcrJUCLcwBOW+XynigVoIhHahowM2X1L
         u6lA==
X-Gm-Message-State: AOAM532zlRVf19ybwEIvyJRG/gDcjgaFREqRGH+ZjWKAmbb3lL/mZfQZ
        7RwdgfuhBg7TtjyFlsIjZy7vTGDQ4g==
X-Google-Smtp-Source: ABdhPJyPQXrAmKDniGpm1UBQMb14WCydWu0slGzRxOkyyHh40TZsVGLOyER1nvp3TEx+NesyazTbsvENEA==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a0c:ab51:: with SMTP id i17mr12144736qvb.62.1630105097700;
 Fri, 27 Aug 2021 15:58:17 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:58:10 +0000
Message-Id: <20210827225812.3247919-1-rmoar@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 0/2] selftests: tool: update format of kselftest TAP results
 to improve compatibility with KTAP
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, keescook@chromium.org, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches updates the format of kselftest TAP results to improve
compatibility with the proposed KTAP specification
(https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

Three changes:
- Change from "# " to "  " for indentation of nested tests
- Add subtest header line at start of tests with subtests. Line format
is "# Subtest: [name of test]".
- Remove TAP header in nested tests

Standardizing TAP results would not only allow for clearer documentation and ease of reading but by standardizing the format across different testing frameworks, we could also share the use of tools.

As an example:

This is a truncated version of TAP results from the kselftest ptrace with the new format changes:

TAP version 13
1..1
# selftests: ptrace: get_syscall_info
  # Subtest: selftests: ptrace: get_syscall_info
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           global.get_syscall_info ...
  #            OK  global.get_syscall_info
  ok 1 global.get_syscall_info
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info

With the new patch to update the KUnit parser to improve compatibility with the proposed KTAP specification, (https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/) the above TAP results would be parsed as the following:

[20:46:09] ============================================================
[20:46:09] ===== selftests: ptrace: get_syscall_info (1 subtest) ======
[20:46:09] [PASSED] global.get_syscall_info
[20:46:09] ======= [PASSED] selftests: ptrace: get_syscall_info =======
[20:46:09] ============================================================
[20:46:09] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0

Thus, the kunit parser could become a useful tool for kselftest users.

Rae Moar (2):
  selftests: tool: Add subtest header line and change indentation format
    in TAP results
  Revert "selftests: Remove KSFT_TAP_LEVEL"

 tools/testing/selftests/Makefile            | 6 ++++++
 tools/testing/selftests/kselftest/prefix.pl | 2 +-
 tools/testing/selftests/kselftest/runner.sh | 7 ++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

