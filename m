Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1A405FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349056AbhIIXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhIIXWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:22:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:21:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w8so86102pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rm+3UVIcZMThytS7gkgrDUkDqlZpQLMy/t2rhbmsclM=;
        b=btXHzvGxsEYzkhXLQTIS6OND1WAn42LjfqjjoQGrQJr9bkF734+K+O+QhHwkBA+tSy
         nNumVDAeooEObqdfbCcEyCi971v3gpgUHhgCRmmhCS8QQReIVrTWrG5ioyOtIGKDgElC
         T7T3g7sFMxAZp+goWz4cmDS7dxYk64kakL8dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rm+3UVIcZMThytS7gkgrDUkDqlZpQLMy/t2rhbmsclM=;
        b=VaKDtwyg1ufMfYGEnb+Wyr7SRR4ZwJG3EkX1AjUfohLNj2uYXTZth6qHW/BsyUs/4K
         DSSJN8fDBfsIXGzwxtvGcPVYhIRtjo9iRh2fXt4lxkv05qdbQibRs5H38dfFGpux19Mo
         g16rFroIGZvju4abLzx3QGHPSMrFKIax9s9e8RTF4cRh6XaUfLjzwEdt8zFKCoa3o7RI
         chXlBPLn62g/pLFwDj1Alf2YpO6pu6urwotRGkOJKi/XrhsabD+64s/8NpbLMiyXdN85
         P3Dzad2VFizKHV98NjXwwbW49JOvKkd/RqJ0daoUM8783qpiTELOY57rcHp10dnAc14S
         oPFg==
X-Gm-Message-State: AOAM530d2LMU8TJLJ+R7K3aNLZF2oTjT6tTpiWoRyMSijkj+f5f5Ryyo
        apqyCz3qX9nyMLlUkOKmHk+ImA==
X-Google-Smtp-Source: ABdhPJyrj/jKsrBMRxLWEVvk/hB3cyNWALHhYtLDaeTxK+SdCxLZ2SFTQlnH9e6/+nIxcAWGSpgRyQ==
X-Received: by 2002:a63:b046:: with SMTP id z6mr4845857pgo.106.1631229705177;
        Thu, 09 Sep 2021 16:21:45 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id f16sm3178210pja.38.2021.09.09.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:21:44 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1 0/1] binder: fix freeze race
Date:   Thu,  9 Sep 2021 16:21:40 -0700
Message-Id: <20210909232141.2489691-1-dualli@chromium.org>
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

Li Li (1):
  binder: fix freeze race

 drivers/android/binder.c          | 32 +++++++++++++++++++++++++++----
 drivers/android/binder_internal.h |  2 ++
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

