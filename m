Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C417424762
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhJFTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhJFTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:48:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB9EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:46:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so4784145yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zeBwNlDoWoc6hewgbBFOSf0IbwrMqp7EIQyS/tILiuA=;
        b=QTqrR48AsqVhuPqy1PxKG1Y5IC8aLCxSncaEgXDbLH9avUoW0EbJle6j7ssOzIruus
         ZwDOiyleOymrMvvlMVCqxnEQT/z5Ys5+kgrzUr+pJxNTbBDDaqkDMHZ4ipFXxwihV8MF
         0unQK1jaxfaUsKxcryhs+xPyrAVmdo3hMMNh7cUrXAqdpX8CPJvtyedrihtXkRH4m6BA
         HWnYBBHqptcPpyOwn76ReutNQ+hLdOznlRqlrDejyolnmXCMfSfeJw2HeYPkDH3SICDF
         ztPNddQ/4BagBb8ROAWtUrC54pgum5IoJmWjbzuYvqhKKETIvrVbRSa60DKvXhDPlLDm
         DH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zeBwNlDoWoc6hewgbBFOSf0IbwrMqp7EIQyS/tILiuA=;
        b=xYWRhssQOF29gUXJOpK7A4T4tGYKspLvoC41bAJuZMFe+v3lbyVjd2pKXpX/Ok3ZnC
         eyxX0+oW49WtyyvlSwQBIe5sGF0tPHUvgiazWGbkqEW7BDNeHOa2HSZsRlMFbxxgTj/R
         P8parasPT3f0EVS482mb7UfAHuzYrKmXDmImmqYoZzCpXRe/jYB99OmIkZh6btmkFDcv
         7EeJo1ZLRfogo+RzfSTHca3nuvM4vl7PXVJ288VGgNI2ezMZkBxK6W8au48Fr7wbGMke
         tTaYlEnEMRM6L8XPpsSa+4eZqBxPFeeZ9BOidE38dtKneHQOet1ZvodEdKrKMlGGCGDJ
         05hQ==
X-Gm-Message-State: AOAM530M2SZjO5QwASAOZkyejhWA22jH5rXLCqTU9HzGsbuRxj0wFnPW
        ZRnXnO4AODZ89zrq+zJI/kTphpLdHQ==
X-Google-Smtp-Source: ABdhPJzKw784oDeJqW2PQeb3pJYAXmSHTh0N8s3rKTBeB5szm8C6rXRdBdEnjZCG2tkvsBw2iC6fL3kXfA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a25:df84:: with SMTP id w126mr30874545ybg.109.1633549574377;
 Wed, 06 Oct 2021 12:46:14 -0700 (PDT)
Date:   Wed,  6 Oct 2021 12:46:07 -0700
Message-Id: <20211006194610.953319-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 0/3] binder: use cred instead of task for security context
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

Todd Kjos (3):
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid
  binder: use euid from cred instead of using task
