Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1E3E83A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHJT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHJT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:27:29 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8AEC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u7so176352ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sACdsDyDQsF4yV+XkTB5JJNrhLHQe5xnvwvES9nsAV4=;
        b=wvgoQqvLEvW82Em5I64QcTOdjmrmncOcgqsxT1p7oqQ2uHkKHTFqet7M2MLzmmnRpV
         QmLAajHimETprqe/kHTqxzgQFmWwqu6T8Qk/+2dOpEEaxMUHQTS34FYN1ee5c+7SHp/v
         5IkCwNJz+ZK3CuDbPh7nGdN+uihg2GV5OpC+X7PdJM4TTs3fnUccuOVXA9UYJlP5YnQT
         6nKijHQQBoGZ0pdeVEeVk6RdwN1WfC/f42+CiCNgTflDRww31xDtTu8Q6NvhRXXL7REa
         w3YGIOu0E5Wb2I50MweGiBG9oh9pM1iL4aBeC4Uvib+4gNFSw0pLWSV8oqy4ZP64mKeO
         sdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sACdsDyDQsF4yV+XkTB5JJNrhLHQe5xnvwvES9nsAV4=;
        b=ndH1KrwUBai/iCadNBexrmTiko/7qE2AsKCB9CvE37MJQoNA/srFoFl0pGX7TkS8oR
         uZ4v8kP07CwIzEiLoRW/YWyzTtRGSUDfOxuaXPzhRX7hKL7KyrE7kUNkts2f8MNalmdp
         d72Agvbe4ru2fNSMNZpiPNCfl4gW2iDYRPNHFk/FExxO45elidzHqNd5zlDn+mF004sF
         Qt5Bi6Ehnq5U7rFutl858NPB5U23ltvygGnXCNrSUQeq/mA8WTjeKqs+EaaPpxUvR2P1
         NZOVOc/JRT6q3CIqb+KrSCHpi0Flt+6P4hnC6spqP74LEPKECDhqxNzMkZMc6pVMwQLB
         v7yQ==
X-Gm-Message-State: AOAM533g4CgKgAm1/yH3S/R/dHxEyy+bY5i3Md6oDP6ttxj0lbLwhKip
        XDFsZMy88HPR48z5yNsXOU7Vww==
X-Google-Smtp-Source: ABdhPJzHjWzV7Xx6Ap9v7F7ay9mxep4UjReaCxW31U7PdzcI24t3JarrHyv2/gHKX/8dBbi3JGauyg==
X-Received: by 2002:a92:6e12:: with SMTP id j18mr671211ilc.243.1628623626983;
        Tue, 10 Aug 2021 12:27:06 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c5sm3025356ioz.25.2021.08.10.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:27:06 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: use runtime PM reference counting
Date:   Tue, 10 Aug 2021 14:26:57 -0500
Message-Id: <20210810192704.2476461-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does further rework of the IPA clock code so that we
rely on some of the core runtime power management code (including
its referencing counting) instead.

The first patch makes ipa_clock_get() act like pm_runtime_get_sync().

The second patch makes system suspend occur regardless of the
current reference count value, which is again more like how the
runtime PM core code behaves.

The third patch creates functions to encapsulate all hardware
suspend and resume activity.  The fourth uses those functions as
the ->runtime_suspend and ->runtime_resume power callbacks.  With
that in place, ipa_clock_get() and ipa_clock_put() are changed to
use runtime PM get and put functions when needed.

The fifth patch eliminates an extra clock reference previously used
to control system suspend.  The sixth eliminates the "IPA clock"
reference count and mutex.

The final patch replaces the one call to ipa_clock_get_additional()
with a call to pm_runtime_get_if_active(), making the former
unnecessary.

					-Alec

Alex Elder (7):
  net: ipa: have ipa_clock_get() return a value
  net: ipa: disable clock in suspend
  net: ipa: resume in ipa_clock_get()
  net: ipa: use runtime PM core
  net: ipa: get rid of extra clock reference
  net: ipa: kill IPA clock reference count
  net: ipa: kill ipa_clock_get_additional()

 drivers/net/ipa/ipa_clock.c     | 165 +++++++++++---------------------
 drivers/net/ipa/ipa_clock.h     |  18 ++--
 drivers/net/ipa/ipa_interrupt.c |   9 +-
 drivers/net/ipa/ipa_main.c      |  35 +++----
 drivers/net/ipa/ipa_modem.c     |  15 ++-
 drivers/net/ipa/ipa_smp2p.c     |  33 ++++---
 drivers/net/ipa/ipa_uc.c        |  12 ++-
 7 files changed, 121 insertions(+), 166 deletions(-)

-- 
2.27.0

