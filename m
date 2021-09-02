Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C723FEBED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhIBKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhIBKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:17:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35863C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:16:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j12so2536365ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5j+z2knFswIqtccUbslQnxBqrHmJjvXWyROy1vaNLY=;
        b=cA+CBG3rurJRoW2S1KmfZTf65dlOyf8SsSNkCCO6BQdGCDmdLJPksR/VAUxfUnJ23y
         ++6fJoIM7ayNUzKvGXwaLW038dNT/co454H1IzpnT+gUq7o+gjbQIstb+IN5r9Cf92Af
         14ygAfmtHrLlxJm4LssqXPSwRyM7nGYH4kfk9g6eYp+O/SNyCHvEdvJNn+Z9gikf3CAD
         KixYaSbFzbYQkEsLP/cg1T/fPArKYwzbvIP0Yl03zlnOxVg3h8wDNfUrlYvb6V69C1I4
         NEqyCr0/YrG6uTtKEKy/CLYfIA1ryjLGABq4m93uPWVU+L5MraOqQm0EkV6QfPxfEP1R
         lUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5j+z2knFswIqtccUbslQnxBqrHmJjvXWyROy1vaNLY=;
        b=ZGy/gBebyQuB5FPs4fbklD1h7FGAOG7AM/gJpBdku/4JsIaL1h7C3Ntc3zTeG1YyBr
         JO6UnrrK3yyP0zHRKIxQK0968E99Hs+kJdL8v5cqzmzOhFimeIFZZzEKMFpGBEJACMm9
         oGpB+SVONJuLD+P8vtdUtxsQCf9XG/HEHfWE0+OOMU1aXJlSFiLiVVbAgIeuRDwW/N4/
         aH/dLduD3YQ3GNMJFHve8J/GE3IJB+2iWVgUsNa0guCBQNy2zvKyrUCGleAxCBTVdj77
         eHFwi4dmpmFQHiI/LDMM/R0ZjHEk70KVkp8ex9M9FGnVzWCGKnvuczV/OrAEj9eusN+z
         KO2w==
X-Gm-Message-State: AOAM530C92BbLxPV/Bx/Drie6C2XKQFh+yxuZMEDwL7ydgbJQC9I7Y1O
        +3BmIqVUmyqyByWrzlT0Q01eDw==
X-Google-Smtp-Source: ABdhPJwheBZMFrP5A7mLjFTz3IjQwGKnLn0NLB5gWuxOzhoTx3dlXdGpSKZ+qEOUyAwHWWdJODGkCw==
X-Received: by 2002:a2e:7603:: with SMTP id r3mr1878065ljc.98.1630577797471;
        Thu, 02 Sep 2021 03:16:37 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM: domains: Improvements for performance states in genpd
Date:   Thu,  2 Sep 2021 12:16:31 +0200
Message-Id: <20210902101634.827187-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to improve how genpd manages performance states votes while
device are becoming attached/detached to it. More details are available in the
commit messages for each patch.

Ulf Hansson (3):
  PM: domains: Drop the performance state vote for a device at detach
  PM: domains: Restructure some code in __genpd_dev_pm_attach()
  PM: domains: Add a ->dev_get_performance_state() callback to genpd

 drivers/base/power/domain.c | 26 +++++++++++++++++---------
 include/linux/pm_domain.h   |  3 ++-
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.1

