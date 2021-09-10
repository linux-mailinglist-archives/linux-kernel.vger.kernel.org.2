Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B750406FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhIJQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:43:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:42:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1915481pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gH9PCnmmRLDSeHx7CODLzybPcjKbfpx0PJGF4nx5AtE=;
        b=VuXBIiHvWZMVYdy+nxX1UYmqvg4eRX4J9JI89Sxxk85LRBH+ZWgCtH92Zsss4ZxfBR
         WdP1UOg07RvH0DbLue3XVYp90uQXz3BLxghXK8mNw2XBVFHbtpeH9ZMDN4yfTwtMjP3f
         HQFQHLwa/QzVIsC5BVRiGm27GSlLhVYNocaFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gH9PCnmmRLDSeHx7CODLzybPcjKbfpx0PJGF4nx5AtE=;
        b=ay4rr4vO4UfPD/sK4G0aj0XiyNQBg71xVTTthZGrMZXvpfaoEcjplbdG+nN55gucmv
         4Oz1EIJ3bJZdyVtn4Q7D7/9VTtn22l4nwAkEoXlCerp1Y6XrHXlWJ1sP7yuAm9FnJ41f
         bWFVkYLe4WHBAa3UAKP2chIRb/el96IRb5Y2b3sbeelKP2zFuqgMOkm3zQfnn4DDFZUO
         NnN7w+PMZruiYneqRj5cY5fRUzcZsTp5c5NIiMDWWBisND1Yoe4UG5OGTTZvHElwTHvK
         HfULIPO03a1eBL+8dE4ZS474xG62ZHGrb/DE8YlMh6EzeT8oQeTl/gd0w6K6TmaDo/Ta
         n/Ng==
X-Gm-Message-State: AOAM530pCyddlUBd+I9e5qb95TnT4GFHIDkfbHs4eUxZsh+U/S3xDl65
        8eVAUG9ccqa2oxdX9C7CT+IbEQ==
X-Google-Smtp-Source: ABdhPJx2cyb/4Eq9vTyyM54/KILnc4gLkPY8JbGxn/eLx2mnuCMq6izXgWwC6JFiVzNKeCEojAaVqA==
X-Received: by 2002:a17:90b:4f8f:: with SMTP id qe15mr10490067pjb.126.1631292132925;
        Fri, 10 Sep 2021 09:42:12 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c133sm5546948pfb.39.2021.09.10.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:42:12 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 0/1] binder: fix freeze race
Date:   Fri, 10 Sep 2021 09:42:09 -0700
Message-Id: <20210910164210.2282716-1-dualli@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

As there isn't an atomic operation to freeze the main thread and binder
interface together, it's possible the main thread initiates a new binder
transaction while the binder interfaces are already frozen. This race issue
will result in failed binder transaction and unexpectedly crash the app.

This patch allows a post-froze rollback mechanism by checking if there's
any new pending binder transaction waiting for response. At the same time,
it treats the response transaction like an oneway transaction so that the
response can successfully reach the frozen process.

Changes in v2:
1. Improve commit msg, adding "Fixes";
2. Adding missing "_ilocked" suffix to binder_txns_pending();
3. Document bit assignment of struct binder_frozen_status_info in binder.h.

Changes in v3:
1. Make function binder_txns_pending() bool;
2. Remove redundant outstanding_txns check in binder_ioctl_freeze;
3. Change local variable txns_pending from int to __u32 for alignment;
4. Clarify uapi backward compatibility in commit msg.

Li Li (1):
  binder: fix freeze race

 drivers/android/binder.c            | 35 ++++++++++++++++++++++++-----
 drivers/android/binder_internal.h   |  2 ++
 include/uapi/linux/android/binder.h |  7 ++++++
 3 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

