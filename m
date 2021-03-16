Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4833CACB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCPBRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCPBQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:16:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:16:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x21so6408971pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SfsrsMXLSqXOTLzBAkO12gaj/evRfWmTw9CDzEhlbc=;
        b=NRQ+OAE+VEiai1Uv40gDDF/yHm4Ndb7UxOHbsQ9LdX1VJ8lrLXlCxrY3TrheGB3FOi
         Vfc2FrDn/9st9oqYWoUkOA+eUdwXFVGndqmR3x3Ob0ei7ej8zi4AvAHsd6qU8sd/OQgH
         nvDUlA5QRDTq9Koxhoq0TA46CkXHWdiWaavEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SfsrsMXLSqXOTLzBAkO12gaj/evRfWmTw9CDzEhlbc=;
        b=gJPD8CM7MYBfJYv8a4E9EFLpa8OecKESrGfLCnkX+kCuPGNuCx0WI7DOtu1Ezi0Ah3
         MIq+iY9enxLAGx+GvYubIP0FGVsJj4G4/3HYkCL8twhyZzZGieiPoits7LmpiN64DePv
         aSW+UAep9SNu8O9Lqee6Fa/3JtczpF8hUN1rU6JC9xJ5B07xjag0Q4Va/r9RLlUHqtpw
         VFtaKtyHYZ/Hd+4JmsLm+Hz0W5QPfWtwxSNSDFZVHPKH9f0KYdpQ3Xn9nOP188WDKMR5
         XEapoFXvUQLphYj+4boN3XOl6LRDlPOoBWtcCMGGOf3ZnZFUOjBStnR0xLHJp5Vh2diy
         ZVgA==
X-Gm-Message-State: AOAM532TXqpLGb+6MfeDGeNA2fNSZfcPr2BP8E713m4gRShrtd1vhkmd
        xIyE/Hbjl62i2i085qiSWz0cYw==
X-Google-Smtp-Source: ABdhPJyy1mqVV9hxHes7oFUnZLcSEQeYmey0yEBwXV5iaPXNfhgzkzriNgX4M+s8ZPL28iOThsZeog==
X-Received: by 2002:a63:c343:: with SMTP id e3mr1655564pgd.8.1615857393156;
        Mon, 15 Mar 2021 18:16:33 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 186sm15773381pfb.143.2021.03.15.18.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:16:32 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 0/3] Binder: Enable App Freezing Capability
Date:   Mon, 15 Mar 2021 18:16:27 -0700
Message-Id: <20210316011630.1121213-1-dualli@chromium.org>
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
Changes in v3: improved errcode logic in binder_proc_transaction().

Marco Ballesio (3):
  binder: BINDER_FREEZE ioctl
  binder: use EINTR for interrupted wait for work
  binder: BINDER_GET_FROZEN_INFO ioctl

 drivers/android/binder.c            | 198 ++++++++++++++++++++++++++--
 drivers/android/binder_internal.h   |  18 +++
 include/uapi/linux/android/binder.h |  20 +++
 3 files changed, 224 insertions(+), 12 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

