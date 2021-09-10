Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67BC40663A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhIJDya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 23:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhIJDy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:54:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C75C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 20:53:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f129so651159pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfdJOdOmsM6ToKNr90Fz5QjBqkh8c3AhWara0/FyVrc=;
        b=fFiMA6rNAn3DK+D8F8K5AGuQsh8OXmf/pcD6zbkp5mglBmTxNAZY5XTzlStz/C5Klj
         InwhaTNXfs38p26gFLnNG6ipD2zh3GpoIC0zMZoX2sO//gbmLW/lH/D5bxa/f95/5vWL
         0VhWXfkEn4D4n0AU5dD73U+TXgaDGy4DLCMRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfdJOdOmsM6ToKNr90Fz5QjBqkh8c3AhWara0/FyVrc=;
        b=v6QTUhddUC71KsboDzHHrUrxfmCjOgrYjivEFyUhJeedjUaCrUwX395s1eHpT835w3
         tQC6LNqzvyXIbIT+VOjrPRoPMZbeo5qD0qWKoOtLN3AKB0X+HleOzE73sjDTUYYR0xrL
         w4ygR/ta2JjbyBCrQWHTPQCFnPxjpUbxacPVbbCfJt/yJw1g/9evv25LJ1Xmvhv6dqmc
         T+VdJwf72sV6HykAxkN0Pt8t6astRtvWD2DjzoWYqdpWoo6uOp1KJ6olXprwWKnU+x5L
         DBNipnQ4eTjLRqQ4mjfbjjAZ9LTbDmsotiWWZtwsW56t54zobZ2lc5tP2uro9peX/1l9
         bhoQ==
X-Gm-Message-State: AOAM533C3Qx7IC0+FTmiReA73/oPwzsLeT2edsVnrrlZsvbnp1Ueidhe
        0Pf/YHon+O+0qqFvzD/njlE7LQ==
X-Google-Smtp-Source: ABdhPJwUFOCOLN/I82PFf5+B3ZACQyefEKICYotjcoCUljFE/kT2iHCg0iiVM4yhIFlmKsZ+IJtYxw==
X-Received: by 2002:a63:f749:: with SMTP id f9mr5495088pgk.77.1631245998476;
        Thu, 09 Sep 2021 20:53:18 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id u8sm3374344pfk.212.2021.09.09.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 20:53:18 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 0/1] binder: fix freeze race
Date:   Thu,  9 Sep 2021 20:53:15 -0700
Message-Id: <20210910035316.2873554-1-dualli@chromium.org>
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
1. Improve commit msg, adding "Fixes"
2. Adding missing "_ilocked" suffix to binder_txns_pending()
3. Document bit assignment of struct binder_frozen_status_info in binder.h

Li Li (1):
  binder: fix freeze race

 drivers/android/binder.c            | 34 +++++++++++++++++++++++++----
 drivers/android/binder_internal.h   |  2 ++
 include/uapi/linux/android/binder.h |  7 ++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

