Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B930433770F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhCKPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhCKPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:23:22 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72BC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:23:21 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id a11so10782458qtd.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CBt7pgat4lIKN/mkA2QdEz9xzpargXdFeuylxNIQs8w=;
        b=hEIO9fhB0yWlXb2Gnsj2s6dUA4o9RKmlI6QCxOhwqzzebyheEmPmXpk+/Opr4sX8oG
         tGiqV3NscSAE6wQtd5wXJbURNO1Q1UiMgjiXeT4yWgGrLfFwrRwEPE7BNxlQ47K4Am7r
         or0xY563NQCInhK9AWOlzpqgkxpmiD+3YPQzGXZB7hkQESuJvbDU0AZKp4mWoA4A6m0h
         p+6pHLpSipk7tPoP4JY2xGv47f2s33CQOZcTikcR7UCq7WgPLCnzoI7eCzU/A7BvmJ7/
         hK+j5UTAj+Cf1voDoCvOhg/3QOmRl14W6wmNKOfGS/xNtNgg4cB3TpcXkfLj6Sr2em78
         BCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CBt7pgat4lIKN/mkA2QdEz9xzpargXdFeuylxNIQs8w=;
        b=VQR5NEtr9nCVvWlVt/avAQo9ERxT5PwZJ5IRGgC9L/AeMj7ADimHwggpSVodVmxp7R
         qFymO0ir9aiVtdr+iGoPMLJ//BWbG739sftDFUWhQJmUiHChciqAL8uDJLzSY1lzLYAL
         62vXLAZ4wuUJ07kFrWegxWthMY5CCfDfnASv7V6xEaxg9cKCPwGkh+8HPKeuniiELpey
         Zo+R/9lC4RsBThNXFZwGStXyeKRHJUjRP56HmCDMVT8L26sxd74XWkirQbzhcm0rClX8
         fUxlJ0lKBbz8twgfZLln9L52F0wzfyJ5PkBQ+cOwn3M8e6GC8hDkN7qpj1L9FV7AS3T+
         TcCg==
X-Gm-Message-State: AOAM5314PfX/KFvavb2OnLjItW/ne7SdeZSHtG1wF/Awl04nZXTMZsP/
        msI1pG8tuwW7zCxoQHS3tRnVtB9/yuKDjQ==
X-Google-Smtp-Source: ABdhPJyBObNVD1i+YeisGAnEHhH6deWylW9hQFRjxMJHGULF1s5TALLZzBHBrZrty681z/b37iKG7WE/VatCGg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d84c:1a92:8f6c:2d41])
 (user=dlatypov job=sendgmr) by 2002:a0c:b611:: with SMTP id
 f17mr8141360qve.42.1615476200841; Thu, 11 Mar 2021 07:23:20 -0800 (PST)
Date:   Thu, 11 Mar 2021 07:23:12 -0800
Message-Id: <20210311152314.3814916-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v4 0/2] kunit: fail tests on UBSAN errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 by Uriel is here: [1].
Since it's been a while, I've dropped the Reviewed-By's.

It depended on commit 83c4e7a0363b ("KUnit: KASAN Integration") which
hadn't been merged yet, so that caused some kerfuffle with applying them
previously and the series was reverted.

This revives the series but makes the kunit_fail_current_test() function
take a format string and logs the file and line number of the failing
code, addressing Alan Maguire's comments on the previous version.

As a result, the patch that makes UBSAN errors was tweaked slightly to
include an error message.

v2 -> v3:
  Try and fail to make kunit_fail_current_test() work on CONFIG_KUNIT=m
  s/_/__ on the helper func to match others in test.c
v3 -> v4:
  Revert to only enabling kunit_fail_current_test() for CONFIG_KUNIT=y

[1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Uriel Guajardo (2):
  kunit: support failure from dynamic analysis tools
  kunit: ubsan integration

 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 39 +++++++++++++++++++++++++++++++++++----
 lib/ubsan.c              |  3 +++
 3 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h


base-commit: a74e6a014c9d4d4161061f770c9b4f98372ac778
-- 
2.31.0.rc2.261.g7f71774620-goog

