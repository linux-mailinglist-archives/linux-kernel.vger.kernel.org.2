Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFC43B5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhJZPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbhJZPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:39:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A2C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:36:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so22967521ybh.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ojODAjLfRn1Lf+4i6CRGTfXa2Pbtlhx1DNx7kELm9pE=;
        b=CozQzRWoQnVrztxALVJ1BzDa678ehPrMv8oKOOS8xxgpJsuDHKmPiwdlVPJEhDTD+o
         A7tQpaw1PZikjLMiWhDaGBSCRjb/LhuL21JklXhtEJrHKwb/ra/OtJ3s0mwJtetlL/1D
         8s/0dzuYHhfQZvDNqZVwYuG/oEN+gMsGBn6NAJQaFtOBcbAgSbD9EOiG6JYsIYAzAkXO
         77o24ogRcNw0oNiwlrOEzHY7SwUxwDcETniACjzrM3EDUtCKFA12sIqqqCvl7auraKe1
         6gYK9dtUUXH6gCajY1kKiy3fqYXHrK35HQoe1Cnl7CImi5+LyuF3e/MCFFIxqD/1dPIx
         tqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ojODAjLfRn1Lf+4i6CRGTfXa2Pbtlhx1DNx7kELm9pE=;
        b=m50a8yzUR0w7aLhkrbKnfOjjs3p42nMEjFq783TLMNaROEbSXgL1LYsjBEZ7/Yu34X
         FxDf0bCgtVsdPZdXCPe/o89T4PIPwqRFi/soYOtgJRWhuLRk0RkvY5mBdtAD9KFalxQV
         D4EDS1ixran2gpY4qfeY1NiRFJTY0lQEXiufckUWHX+nag9Hhka9qQHf527husnslewO
         5JGJbsfo3/HtwJLsjT0LByOgIcRIfuXae0eUMhM5H1hREtcwpwpGl6lqK3oswqP6vXSO
         D1Z/kQoBsWEogEay56YoHw2cqb8a2nAe1ItIvY/aVva7V7J09rHBgzHU2id9SkL9GEh+
         Xkgg==
X-Gm-Message-State: AOAM530VcdD55B7fa3m6EuLDUgJjig31j2fxuG6heq5SrhjY6d6vhyol
        14/wXTDu0cRPnosKXtdaa/RZYcFhy712qQ==
X-Google-Smtp-Source: ABdhPJyxj/d0EOrqXaqoO4qUvMk4Qh9ib6ShPlLenahXqtHevjSwpDY5SFjzvcdz2soobWRVGTTRo7hx6ZfvGw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d5d6:b5d1:7203:e1a2])
 (user=dlatypov job=sendgmr) by 2002:a25:3189:: with SMTP id
 x131mr13354941ybx.27.1635262605440; Tue, 26 Oct 2021 08:36:45 -0700 (PDT)
Date:   Tue, 26 Oct 2021 08:36:38 -0700
Message-Id: <20211026153638.3857452-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] Documentation: kunit: remove claims that kunit is a mocking framework
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit does not have any first party support for "mocking".

The original RFC had some, but the code got dropped.
However, the documentation patches never got updated. This fixes that.

https://kunit.dev/mocking.html has a current writeup on the status quo
and will hopefully be eventually folded into the in-kernel
Documentation.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/api/index.rst | 3 +--
 Documentation/dev-tools/kunit/api/test.rst  | 3 +--
 Documentation/dev-tools/kunit/index.rst     | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index b33ad72bcf0b..3006cadcf44a 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -12,5 +12,4 @@ following sections:
 
 Documentation/dev-tools/kunit/api/test.rst
 
- - documents all of the standard testing API excluding mocking
-   or mocking related features.
+ - documents all of the standard testing API
diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
index aaa97f17e5b3..c5eca423e8b6 100644
--- a/Documentation/dev-tools/kunit/api/test.rst
+++ b/Documentation/dev-tools/kunit/api/test.rst
@@ -4,8 +4,7 @@
 Test API
 ========
 
-This file documents all of the standard testing API excluding mocking or mocking
-related features.
+This file documents all of the standard testing API.
 
 .. kernel-doc:: include/kunit/test.h
    :internal:
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index cacb35ec658d..7af7dec83646 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -19,7 +19,7 @@ KUnit - Unit Testing for the Linux Kernel
 What is KUnit?
 ==============
 
-KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+KUnit is a lightweight unit testing framework for the Linux kernel.
 
 KUnit is heavily inspired by JUnit, Python's unittest.mock, and
 Googletest/Googlemock for C++. KUnit provides facilities for defining unit test

base-commit: 2ab5d5e67f7ab2d2ecf67b8855ac65691f4e4b4d
-- 
2.33.0.1079.g6e70778dc9-goog

