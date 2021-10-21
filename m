Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339B436BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJUUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJUUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:25:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6BC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:22:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z20so206592edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T80sY77P49CzqkBALaNy1F1k3Uh9yhdfwkAHlGutXxg=;
        b=mpr8kErdCV7sUm/XbyfJcxCKeOGw4geiYjdZu3EnPqJE6KQDeELPt6Tc71HvT/i0jk
         T9RU8d3GNQJl+gWLhH80+va9tGv1Y2n09/FWB2NBSVtZvo3Uf5kRjkowqByhPp2gyLGZ
         NBIQujgw75vCfARufR+rwueYBVp2dQrHhEBjcfnSS/+RG8l41OYPk20i9nex6eAsTalD
         NnbSFM2THxIymS0T6JqthRcrjBeBQ8y3nZ8UigP/KvGwoZwXEsQ9M+kyJORtZNjMLAuS
         aU0SLNx7238RXLJ+/brcRY7K+yZ57BfQjU/up7m3QNtgvmzKBWFGjcsUL8zIsMhqGyxK
         tQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T80sY77P49CzqkBALaNy1F1k3Uh9yhdfwkAHlGutXxg=;
        b=mHN9DjY2LzH1i2m0KyPVzzt21ZFIru8AG5RopU19jQltG3Yff46fUToCyJhudjg3lb
         8TiTWo0hh4F66xn04XErsz70krIjpGQAUjfUl3FtQk33RQM2EWIqprqFbhV7adYaLytL
         hFlr+p4u/ihDTg1NFYzeMdH4XltE9xZudvPuQZrdg5oy0J0sd2mzqzMkO5/MQjVudzxg
         Dslmrdvz61qOaJ8DapTNTzKru26Q5UZCFRb6gTbYSZhhYymLh5gwbN1job+GyRd7Ajzt
         PGe8F1kGfrV4mzY9FSMyQJB/535wEg2UK8cAe0AHiZxyYX37Kf4Xae/z1mUylsrTM+s+
         OvmQ==
X-Gm-Message-State: AOAM532QN6E9gMioQtIMupurMwwyXRhpYVkzWmIxKkZQf3zEvVefi0Qs
        erAdtsxzkNF+zucdNIjkbsQAog==
X-Google-Smtp-Source: ABdhPJx0+JePp8cicOVplczmBdeekxsIj//rFIruiqx74JXCwnDTP+gqnS0/dJ2NlOl3UVi28xR4nw==
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr9886395ejm.48.1634847777469;
        Thu, 21 Oct 2021 13:22:57 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y22sm3696001edc.76.2021.10.21.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:22:57 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] rtc: s3c: S3C driver improvements
Date:   Thu, 21 Oct 2021 23:22:53 +0300
Message-Id: <20211021202256.28517-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on Exynos850 support (where this driver works fine in its
current state), I've stumbled upon some minor issue. This is the effort
to fix those.

  * [PATCH 1/3]: moves S3C RTC driver to newer API usage
    (no functional changes)
  * [PATCH 2/3]: refactoring/cleanup (no functional changes)
  * [PATCH 3/3]: adds time range, as [PATCH 1/3] made it possible

Changes in v2:
  - Dropped "rtc: s3c: Fix RTC read on first boot" patch
  - Switched the order for [PATCH 2/3] and [PATCH 3/3], so that the
    refactoring patch can stay w/o functional changes w.r.t. previous
    state
  - See also changelist for each particular patch

Sam Protsenko (3):
  rtc: s3c: Remove usage of devm_rtc_device_register()
  rtc: s3c: Extract read/write IO into separate functions
  rtc: s3c: Add time range

 drivers/rtc/rtc-s3c.c | 106 ++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 41 deletions(-)

-- 
2.30.2

