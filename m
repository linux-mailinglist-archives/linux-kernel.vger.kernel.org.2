Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20182398604
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhFBKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhFBKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:14:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DFC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:12:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn21so1926540ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slzS5YZjZxl565Kd+2lXyghUenj3OYVJLEop1Uqbr+w=;
        b=oMkbusaI+atgT4iQ2MrSJwQ489dT1MD7I9rbptbNlBVQ4o7cpLIC8AbaY03ZmzXVn5
         zjzJe0XDnJrD3JD1soMrauHuOgjOiGXCY4DT2AxDWW7u9QhPXPi+G1P6g32mv0uB4yxV
         JudFNjxWyxpJp/1dXd7E/4a4RvAkyNMNQUgDLbRpSJqcf9U86YcxmFqK32cUAKGdzSLn
         Mx0UabYcvmpB3DtRjLuKWkUUoTddVzZrSaRxoGowFvqbUyGGta99sltyMw5A99aA+Yib
         kdaoJI5ffUZiPSvuacnfrl0d0sC2kzzWe11Qxmew+60F8dWNurpM3UbISlpdrbWV4HyX
         KAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slzS5YZjZxl565Kd+2lXyghUenj3OYVJLEop1Uqbr+w=;
        b=LNkD10BZznA4p2p9qiWOicTyni198UvQou67tOzSY3OY6xc3NGXBK7FzhoCtwRtYjO
         YA/k6tamRp88KkvKxfSISHPYiTxAp7fmUp8Acrx9wuDCbxA7xc52ViEO0Ok7r4gKCwJx
         DWGKnCDJT6Uz8AF8TX/pnmPub047jzVwR17GcSjivB38fTaZly5ln+ebHC9XTxMgDX7Q
         U5OCQQmH6QkIMAaq0NjE8dLX3aokPqGnj1zlBdIz1z9j8IfaXlNdRpBvzLz+aSkrz++v
         JAEPcx8jEyCSfo79DkQRaDROkawgEpf5pKOu5yftmbC9/zEU5aSGi4CvqyegdXAxB8yh
         uR+Q==
X-Gm-Message-State: AOAM532aOrIwnhHNi6eWkhrf3qUU0sgoFvKYKgm/1FJxQqLD2xTag+AU
        jaDL+uTaUwjFS4GhlSy/35rMQw==
X-Google-Smtp-Source: ABdhPJyLUiGKrkXuEIpXMj03EEh0a0syVDYqqtQUysi0GWfDCtQYSve4ntEt1YwOshobDqSD8KBEug==
X-Received: by 2002:a2e:b0e4:: with SMTP id h4mr13970498ljl.463.1622628749599;
        Wed, 02 Jun 2021 03:12:29 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y35sm1948938lfa.122.2021.06.02.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:12:28 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PM: domains: Avoid boilerplate code for DVFS in subsystem/drivers
Date:   Wed,  2 Jun 2021 12:12:12 +0200
Message-Id: <20210602101215.78094-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various discussions on LKML have pointed out that many subsystem/drivers for
devices that may be attached to a genpd and which manages DVFS/OPP though the
genpd performance states, would need very similar updates.

More precisely, they would likely have to call dev_pm_opp_set_rate|opp() to
drop and restore OPPs (which propagates upwards into performance states votes
in genpd), every time their devices should enter/exit a low power state, via
their device PM callbacks.

Rather than having to add the boilerplate code for these things into the
subsystems/drivers, this series implements the logic internally into genpd.

Concerns have been raised about this approach, mostly by myself, around that it
limits flexibility. On the other hand, it starts to look like more and more
people are requesting this to be manged internally in genpd, for good reasons.
So, I think it's worth to give this a try.

In the long run, if it turns out that the flexibility was indeed needed, we can
always deal with that as special cases on top.

Test and reviews are of course greatly appreciated!

Kind regards
Ulf Hansson

Ulf Hansson (3):
  PM: domains: Split code in dev_pm_genpd_set_performance_state()
  PM: domains: Drop/restore performance state votes for devices at
    runtime PM
  PM: domains: Drop/restore performance state votes for devices at
    system PM

 drivers/base/power/domain.c | 66 +++++++++++++++++++++++++++++--------
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 54 insertions(+), 14 deletions(-)

-- 
2.25.1

