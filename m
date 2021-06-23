Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C83B1A47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhFWMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFWMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:37:06 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:48 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso556663wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mhqk3bJ8TzwOEMfK4Y0G6olPPNPdwc+Y9vj5xjXTf70=;
        b=c2Z+7d1552P121A3rXuQWByk137vnSoac10fCzUkTj44JRx3UtwsmkxXH+fe8QWhW+
         9ADtyfL19DYX8TtHbnblIhyYelSaofuND7+9qIl87UREh3pQeEeBE88eF2zcKz7L8B9b
         /RfUK9LfelkrpSzp/ObAJ9tNim44lg1a0/RC092ZrKbsJdTFivYcAe0MbadDI2kqRrpC
         QmwjqyjrNgH/UeJfekHQIbafIjHED52zOohCjlTT9w1xc6vcFVTPqn2efInglxBZbi2f
         7b5D2zrEacroADcgYFEkTyDzGlAn245o79+DulAyDYyJdKmGM8eKeKKolsI4QqEYVvXO
         geHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mhqk3bJ8TzwOEMfK4Y0G6olPPNPdwc+Y9vj5xjXTf70=;
        b=pHYSYH20bQw16fpAkrbWINMivXJUj5Noa8T35VcX4l0NEcT3ST2rCYyacSoZ7o3lKe
         FrGNizsxxVle8Pb0kstln78YDDxALf6mta+zNRIZY0vMaW9V99RI9XHhyXw8A02uBKDX
         xEJf35xc/9EUf5TKWJSmf0CjkrJqoExhA1LXMAuzzcmXSdPzUnNWGjxrvRmxcmq48Ogd
         TJf8/PXdcOhik47piJSnTOgBm3shCr/t3CPeBANDU3IzZv8gtvjBkJrFFruDaOW4siAQ
         w4jUUpq9waxCqPukild5u7b2AmzRUkXHiWZJjEfDxsbmh0q/PPiZU6Y0bVQPl3nbMvyQ
         XBYA==
X-Gm-Message-State: AOAM530lelMDlzpYCpmkFQKjXnR175gaKf9Ss/JFL9DhkNYybnRvb9DE
        qiudU8U1wNId2QKwTEbIeHE1y0ksewEG
X-Google-Smtp-Source: ABdhPJx8KfieE+NfCDEln9nDGN6Xjuci5VinmNyEOsdfRf4O3q3Rf38aX/UCIpcpJdN7AgHeGizwII92SG+T
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:7219:: with SMTP id
 n25mr10394477wmc.3.1624451685037; Wed, 23 Jun 2021 05:34:45 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:34:38 +0000
Message-Id: <20210623123441.592348-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 0/3] sched: A few uclamp fixes and tweaks
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the v3 of a series previously posted here:

  https://lore.kernel.org/r/20210610151306.1789549-1-qperret@google.com

The first two patches are fixes that probably make sense on their own.
The 3rd patch introduces a new RLIMIT for uclamp, which can be used to
prevent userspace tasks from messing with their own uclamp requests.

Thanks!
Quentin

Quentin Perret (3):
  sched: Fix UCLAMP_FLAG_IDLE setting
  sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
  sched: Introduce RLIMIT_UCLAMP

 fs/proc/base.c                      |  1 +
 include/asm-generic/resource.h      |  1 +
 include/uapi/asm-generic/resource.h |  3 +-
 kernel/sched/core.c                 | 72 ++++++++++++++++++++++-------
 4 files changed, 59 insertions(+), 18 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

