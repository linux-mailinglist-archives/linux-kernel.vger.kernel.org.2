Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992D315C12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhBJBTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhBIWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:28 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F95C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:14:56 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 22so183334qty.14
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tHzagjGXNPuISlrYDgBoG4oBntJ3U4L6LA9+/1TvcMM=;
        b=eCF1+XPVXmXXaI4fnLU1x7QL8R6qK2JNMWmlE2E62fRh1zTbhVtYHZj08JTzIqJ4PK
         8iUfuF7ufpcCB7JhZSyh3JYJ8Djz95SyqrVAMqVWmIe0mz6ki+oSRh9ZxSBwUGPd4wOI
         vzYq4ne15W5p0HA/9KS9h+YZF/J500SeX5+ulB2qPLksWvD2TyL5bl3zw1aFvyyWn2MS
         3nRj4rhMIR/2JsmcbOKFxTemUEXojiox9b1ciw3AWuVRyBeXeYy2B+Lb99xZGooS5rzO
         TwIlexBz0HelhQc60To56Q3eGlteuA6urOlfaBtWG+J5C10UWpCra+6nuFlarR7BKyDP
         eB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tHzagjGXNPuISlrYDgBoG4oBntJ3U4L6LA9+/1TvcMM=;
        b=lmL2vPC3AjybY9+2p1fJ3WRV3Zx/qB5u5BJq8C43uhZlp3mOU1QXSwhmm/smpD+CGW
         gUol6bkzH8lszEy1yOQf3SX9CLbLT+vbDwVoJfl4kUOXeFFg7G1ROUX0Uk4buwMGKYes
         jcwS3KhlbAcZVWLcWmkSZTKMb0JyYNkHabxPPLYRWyzL0DtUQOOpWovV68Y+wpUBwuWM
         jMx6Wh73Nt0/xdr+BD8lItloCTtFPXx8nNSsbtFUwQDHvLCQmlb4CrncqHfIYKX1hV/O
         MZ0jbYap6LsCXfvW9X3EKRG1UfmiPjpxL5zjfERx+THV2huzhNIVwbT+PcY6wPzZShx9
         xm4w==
X-Gm-Message-State: AOAM532TBk2H+k77izyppxV9PsJGksI0E44P/wbDvni9C8sNWQmLcPr4
        BgIOmLjyT8fF7usjkzJ2BgohGAFuP8HEog==
X-Google-Smtp-Source: ABdhPJxJ4VTOHMNM5P/K4n8751sRWqretvq2TSUKAFdhSNAerNSAqTaGPw0DXxQkdni7LFsqvrIJS9WrxYAu3Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7dd9:967f:92f4:2aae])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:1ca:: with SMTP id
 c10mr13380525qvt.44.1612908895933; Tue, 09 Feb 2021 14:14:55 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:14:41 -0800
Message-Id: <20210209221443.78812-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 0/2] kunit: fail tests on UBSAN errors
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
  Fix kunit_fail_current_test() so it works w/ CONFIG_KUNIT=m
  s/_/__ on the helper func to match others in test.c

[1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Uriel Guajardo (2):
  kunit: support failure from dynamic analysis tools
  kunit: ubsan integration

 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
 lib/ubsan.c              |  3 +++
 3 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h


base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
-- 
2.30.0.478.g8a0d178c01-goog

