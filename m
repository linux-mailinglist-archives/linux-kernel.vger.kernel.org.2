Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E441334BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhCJWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:52:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso8066173pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xceL2rrz5muxxXaFpXKbAe7z2y2J/Hz3q5dv+FSBpyg=;
        b=hS8aIW+Yt/OFEMTo4xIu6Tvk1YCBuq127Ex1VhmNXR+TaOpmB5tCs5UGwsvuzoexHQ
         UWuClhqUrTHb5mNaZlox6Ht8wZgpW98eIB4wBE3IrObOif/XbeGoI3m2aFa5ukFWiLtm
         swDj+r0/8dIhdku09dEqShdqYG/ScIzLPLqug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xceL2rrz5muxxXaFpXKbAe7z2y2J/Hz3q5dv+FSBpyg=;
        b=HMlga+LMwQs+BFqVOyzVlgb9MhaI4CBnRnv6Eoech1EdXUoZf0vB9XqYNXkeAvQWzO
         H/YgqYVVXsL7Iqur/nSTLipBa9nxl5TtXsOgCtps+pRvmo3KQOYHJvQL2P1EhyBtrCrt
         Z5S/sSEW3erMe7yPEObEW5K/Lmm8nEwONa7fIkbH/gILrX3apxVlsrHsswsMPUrN6XyS
         MtDAgee2XHBqlPartC4w9tV0DUEgFb6sgustcJC7JZfptCfPsK8euMt8K0qM1W8SFvem
         TR+K2LYECwFsnZbbwUdyOvWyCdiQsgcf0PHmkW/7SERnx7V10W19nPY2jNgflezE2ax7
         hd1Q==
X-Gm-Message-State: AOAM531t15+99z7eT2vxvMYV5M2M4eG6lTWeqp2B6fePxiCUecGEWMm1
        CvZJIY7LdrXaA1JU9vY7AGRn5Q==
X-Google-Smtp-Source: ABdhPJztd6S7CLxtE4/aHpkKlretTOkcV598udASVtD7x6Jq37Ei7re5BnZbxujJLo5zhHf4dyKQBA==
X-Received: by 2002:a17:90b:e18:: with SMTP id ge24mr5804981pjb.199.1615416773769;
        Wed, 10 Mar 2021 14:52:53 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t22sm353384pjo.45.2021.03.10.14.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:52:53 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1 0/3] Binder: Enable App Freezing Capability
Date:   Wed, 10 Mar 2021 14:52:48 -0800
Message-Id: <20210310225251.2577580-1-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc1.246.gcd05c9c855-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

To improve the user experience when switching between recently used
applications, the background applications which are not currently needed
are cached in the memory. Normally, a well designed application will not
consume valuable CPU resources in the background. However, it's possible
some applications are not able or willing to behave as expected, wasting
energy even after being cached.

It is a good idea to freeze those applications when they're only being
kept alive for the sake of faster startup and energy saving. These kernel
patches will provide the necessary infrastructure for user space framework
to freeze and thaw a cached process, check the current freezing status and
correctly deal with outstanding binder transactions to frozen processes.

Marco Ballesio (3):
  binder: BINDER_FREEZE ioctl
  binder: use EINTR for interrupted wait for work
  binder: BINDER_GET_FROZEN_INFO ioctl

 drivers/android/binder.c            | 196 ++++++++++++++++++++++++++--
 drivers/android/binder_internal.h   |  18 +++
 include/uapi/linux/android/binder.h |  20 +++
 3 files changed, 222 insertions(+), 12 deletions(-)

-- 
2.31.0.rc1.246.gcd05c9c855-goog

