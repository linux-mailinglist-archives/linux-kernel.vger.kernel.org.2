Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF9424B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbhJGAs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhJGAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:48:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E6C061755
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 17:46:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso5798118yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RiNo10qigaewXNskXWDjf8RGesyfVGXCVVY+c8mvumk=;
        b=s9RM15/OlUmOcNzsadQlUngC5XCaFRvZDrvfpjpvjqc/Khpftz2AcowOqC++yIXKVX
         TbIowssKA+A1UTSXFVb6NNrpOCYjeZKB4DYG08HgyUn84iBIugHKvVpIY5/3IhQPH56g
         FeyZHf2B3CnS2uFxt/c/+CQrNtD28AY72artX5WoAZy4uoxz4FMFQCBhzLTkHEWEfvSQ
         pVJHFl2wSjwbX422PVf+sLxVugd5HFL6dxUdeJmOKMl11pFoivbdB4autoVk2iRo3cfC
         ccwCnvzY4faO5Pwpo3Bcql9HnMyQHBhqxNjqpPcEirGmjKeMMXX9KnpRKCq4tFKOrIrz
         Yilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RiNo10qigaewXNskXWDjf8RGesyfVGXCVVY+c8mvumk=;
        b=x7Stw5IyICaex6XLLTYF0AImaIC+30pY9ZAsuGynCSPzS/Uen8UuRNk6e965veYul5
         y7OlhHSJSBMyXs7NPfIuDv5GGuy9o20ibEwTLLDbIEaybdhVnYDnLgzgZGyzf6Vo1f4a
         52dw4Ic33Z5SqsiRNAq84R/fdmHs4YzWyEL9OnCC3WC5SXr+09bDY9eSfwOX2a9sR2R4
         BYQZmkeJLcrJtkhen8D9YOq641UqwLMc0DZoXdAygClxZI3pu2hw4Aw4B4O0XkwQjGaB
         Ios8NCcjDuLKW4FS3Yd3Qasl19T6JsYYWaVyIsSv7gYGHpn6zZ7u8DQK6JhMxjjnBVdi
         aHGw==
X-Gm-Message-State: AOAM533/HX+oZXDYBVMvBnH9IFm8OFc1UN6GgCfPBaN3VDO6aO8IlWkZ
        PfIEp0WkTi+pcgbHOJf3vEzrg3L2jw==
X-Google-Smtp-Source: ABdhPJxv2Ot34RxVC2xJ0cMsLDuUENvC7xNWUpRNm7n8iUeJR1ye6f3+WgWQS4WtMn+OZXXvuRQNZAs1AA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a25:a525:: with SMTP id h34mr1545139ybi.168.1633567592745;
 Wed, 06 Oct 2021 17:46:32 -0700 (PDT)
Date:   Wed,  6 Oct 2021 17:46:26 -0700
Message-Id: <20211007004629.1113572-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 0/3] binder: use cred instead of task for security context
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the possible use of an incorrect security context
when checking selinux permissions, getting a security ID, or lookup
up the euid.

The previous behavior was to save the group_leader 'struct task_struct'
in binder_open() and using that to obtain security IDs or euids.

This has been shown to be unreliable, so this series instead saves the
'struct cred' of the task that called binder_open(). This cred is used
for these lookups instead of the task.

v1 and v2 of this series were a single patch "binder: use euid from"
cred instead of using task". During review, Stephen Smalley identified
two more related issues so the corresponding patches were added to
the series.

v3:
- add 2 patches to fix getsecid and euid

v4:
- fix minor checkpatch issues
- fix build-break for !CONFIG_SECURITY

Todd Kjos (3):
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid
  binder: use euid from cred instead of using task

 drivers/android/binder.c          | 14 ++++++++------
 drivers/android/binder_internal.h |  4 ++++
 include/linux/lsm_hook_defs.h     | 14 +++++++-------
 include/linux/lsm_hooks.h         | 14 +++++++-------
 include/linux/security.h          | 28 ++++++++++++++--------------
 security/security.c               | 14 +++++++-------
 security/selinux/hooks.c          | 48 +++++++++++++-----------------------------------
 7 files changed, 60 insertions(+), 76 deletions(-)
