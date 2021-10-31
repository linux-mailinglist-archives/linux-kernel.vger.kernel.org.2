Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE7440EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhJaOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJaOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 10:45:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i5so9963175pla.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6H6287i+DjjUNpGz7HtTUgvvz9yWh2H4PyJ0+2Kvp8=;
        b=JFvI1eirbYasDAIAIp8fku73Jw6qMRBAXMhCiczj+SU/pApF2A/9NGYK9qO3Jyy0r6
         CSnMbSKysddKsrUjqwHANCVT7NM2g5yUxNgkvexXDAMk+c5bcdFcMXvTg77xcqXxUZQp
         SyJmceLnjX6oiEj41re2YFmlL65fczMZsRAZPzVLp64Vuiup5lEiL8HLIg549UsHqrXB
         1A8Kl8LltRstO9E61Aaq66qw2BNJByCDhE0Zfh/DhWNttGgIesgkMd2pMslmKi3oTRv1
         dM0PEVCHrjFYBJRBQiuYPNJBcDtS7/r8hgBjQyfp93w1akCPG26IaQxIcFEk+I1BHr1J
         aPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6H6287i+DjjUNpGz7HtTUgvvz9yWh2H4PyJ0+2Kvp8=;
        b=X41GfmmfpH2fK5G7/i3O6he64I8DkGr7SkLjhyyEL1Q8njmaCAAdNjwcfF5kwirTyo
         0NcMBmfCO3wZCQlAD0ZAbrLVzsLQrvpusubAv/5F7dSEsgDEBXh4R66tBu0KcuCBCl1A
         1ZExcCtA7SmF9P1AwVAoMW/1ukBRgfzvjp3WgLY9h38SS2NUNOjb1vT6B6H7LeN+hS0J
         65YgboMH1vYbRkoPK0y7rZE6IqT6VAkqT1GwSKthlmvaeMe56EOhBPvZkGR65yE/0GmS
         1pQmVmRcgKuXWHFbsNPFDxOhfdwLELmXQlNpa2YMSrOzcgiQMJD7Nvko5JFg50TYsBpC
         Nelg==
X-Gm-Message-State: AOAM533eXyzraEclCQEUPbOpl4fDTD3+Lw5SVrCuUjeAt953JrpGsGs+
        eB3SgZ8mJqMa77EF7YR40AVkYQ==
X-Google-Smtp-Source: ABdhPJwUaHa6ScAVFIXNXWD1AbYqv3PQT7nyR/b1A0TaxK+NB2OJxON3WMOzXqJThSnI/Kv4h2YRAg==
X-Received: by 2002:a17:90b:4a50:: with SMTP id lb16mr2652865pjb.37.1635691354787;
        Sun, 31 Oct 2021 07:42:34 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id k1sm10937185pjj.54.2021.10.31.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:42:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] coresight: etm: Correct (virtual) contextID tracing for namespace
Date:   Sun, 31 Oct 2021 22:42:10 +0800
Message-Id: <20211031144214.237879-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a profiling program runs in a non-root PID namespace, if CoreSight
driver enables contextID tracing, it can lead to mismatching issue
between the context ID in hardware trace data and the allocated PID in
the non-root namespace.

CoreSight driver has tried to address this issue for the contextID
related interfaces under sysfs, but it misses other parts: it doesn't
prevent user to set VMID (virtual contextID) for kernel runs in EL2 with
VHE, and furthermore, it misses to handle the perf mode when the
profiling tool (e.g. perf) doesn't run in root PID namespace.

For this reason, this patch series is to correct contextID tracing for
non-root namespace.

Patch 01 is to use spinlock to protect reading virtual context ID
comparator.

Patch 02 corrects the virtual contextID tracing for non-root PID
namespace.

Patch 03/04 are used to fix the contextID tracing for perf mode.

I only verified this patch series on Juno board in the root PID
namespace and confirmed the patches don't introduce any regression for
root PID namespace.


Leo Yan (4):
  coresight: etm4x: Add lock for reading virtual context ID comparator
  coresight: etm4x: Don't use virtual contextID for non-root PID
    namespace
  coresight: etm4x: Don't trace contextID for non-root namespace in perf
    mode
  coresight: etm3x: Don't trace contextID for non-root namespace in perf
    mode

 .../coresight/coresight-etm3x-core.c          |  4 +++
 .../coresight/coresight-etm4x-core.c          | 10 +++++--
 .../coresight/coresight-etm4x-sysfs.c         | 30 +++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.25.1

