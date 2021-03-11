Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181F4337CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCKSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:46:34 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E95C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:46:33 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 16so153689pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+gqARGgjAQnr55mFUijIK03G998er1GFZ5SCixV4R80=;
        b=QtlHbXolb8SN9mg3v2/7JBl319h23rtwHwXdGsaDMWaf4Pl0+qPGV9H+YG7vVhibvi
         DStAjNqHEd0C5VT9tV5TRubtqms+1Wy3/fo7dgOkzA618+2MI7Z4WBTDqho+/ZtEFYao
         eOpXwJZkHmub3MJNdJVKrIcyc4TaPKjOeGgqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+gqARGgjAQnr55mFUijIK03G998er1GFZ5SCixV4R80=;
        b=nHlXsHJirfy3RZPxBSMFptVvmw9AT7VfjGA8WzpmJ9Zr1b6NVJfg+vnaqlIcz+n4m1
         XxDPJx7t6ZBGsHe5IV7lelBNLxfgqUvgKPrpnYlW5b+x7YiS/PwUjyXqgaoqZlGETyKb
         6c9BZkJZ3TVrK4VDj3ccQWXff2SiHPRoC0G6QhVaocHo7tzFmzWVLAID7z8wSETkheDW
         +sqYidZnCRflHrWMiEkqfOR1OL/ZX3vW3+ZBAH809czq07xNli+m0nJGbmZyO/fWQ7dK
         VLe23LwsmNKl5RDpj7TS5+EEeARVwPQeZnHUp0MQ1PkB5KX0E0HyMC7i/jmUSDp9hIyS
         Szug==
X-Gm-Message-State: AOAM532ENu1Nq9bn3vMDYIb/FB7YISskBTwF0JsEM7Frf0jbgxfVStX0
        v8aizlQCb+A2LjskQ/jd+c24UA==
X-Google-Smtp-Source: ABdhPJwlBziDT3FhaXdYvPF6eDa8YqqHFIjIoTjx6XhgMxeOgn8cwk1uh/tks7FBVkr1hkxgkwzlMw==
X-Received: by 2002:a63:4d56:: with SMTP id n22mr8404937pgl.277.1615488393373;
        Thu, 11 Mar 2021 10:46:33 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id z2sm3108398pfq.198.2021.03.11.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:46:32 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 0/3] Binder: Enable App Freezing Capability
Date:   Thu, 11 Mar 2021 10:46:26 -0800
Message-Id: <20210311184629.589725-1-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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

Changes in v2: avoid panic by using pr_warn for unexpected cases.

Marco Ballesio (3):
  binder: BINDER_FREEZE ioctl
  binder: use EINTR for interrupted wait for work
  binder: BINDER_GET_FROZEN_INFO ioctl

 drivers/android/binder.c            | 200 ++++++++++++++++++++++++++--
 drivers/android/binder_internal.h   |  18 +++
 include/uapi/linux/android/binder.h |  20 +++
 3 files changed, 226 insertions(+), 12 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

