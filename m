Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE63FD63A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhIAJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbhIAJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:13:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C60C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 02:12:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v123so1512204pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2Xus3Gy0mJ3a1u6RNwyvEN4uw8eYtNFGPcMxDGXN9M=;
        b=Bx6byuMPel9lHgsPbKf4KC5IjOhTYoo8YCfeX/ez4d1rmD9UGdz5wF5AkmIciKt0XV
         LJIyRnIdG0PkTA4WsK4Zmba5qXZGVY47KnsG55X7ee56SjuOk85MJZSPe1y2ajUQpzqN
         WBzuLsp48KPPopeS/SAECPr5YENYEmS6Zb+KlXPQloZchS/9YllT2y9bO688pHMBusxe
         EkJhsF4zBjEhaMexQUoIDFYv9M3TrCxiwlv2b4/woERAMO7Bgdivm/lmWTlhvekv03nM
         34MEvb+inO6DZErkDUmx5Ry7w903eRzTHjknfgZzNOdEs4NA+jiEZDcWBsNVXOFF8NR2
         EMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2Xus3Gy0mJ3a1u6RNwyvEN4uw8eYtNFGPcMxDGXN9M=;
        b=Aq+zKQ12r7A6znZVGcdPHTRCCdoyUNdNZ/IeUpB06TkyqQru04srXUx0VMeVL0rgIQ
         jgRkpwKqH0JlI7TG343+bn7LnUp7h9QejrWKqxYK7p1mJPy9QnBzTQIGTQXqPemYb673
         CF8HMH2bkr40Kl1XOHy+cw8uQMQlKlznRsep1sFm39AY44O7FnpdfYP/90Zs8t1tFp0+
         OsFOSvPRWzn+EKCZk5+3KllR09insBsPyKoDVRqIQGFuQwmbknMjhQy97jsDrb3IfEZr
         SrC2BZQfiSiOw3+lVwBwmTdyEygkxwGveFh+dlEE/cCGJ4IjTb1IywTZ+fa+eqsqEsh/
         4Iqw==
X-Gm-Message-State: AOAM530roQ1pBt3aLOO8fhWJDdG7VUj0weMqjHWSIyQX/VVmb/wavIBQ
        5FRAe71U9sEVSFUZ/xXDW00Aeg==
X-Google-Smtp-Source: ABdhPJxGJPhjggihqO4HCv4MWi4qvUBWkSQDZ8pmiBmqwZfdTqXF134RIxSAesKIsvtKNWMITqTvfg==
X-Received: by 2002:a05:6a00:140e:b029:38b:c129:9f2f with SMTP id l14-20020a056a00140eb029038bc1299f2fmr32314916pfu.75.1630487527427;
        Wed, 01 Sep 2021 02:12:07 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id u24sm21816388pfm.27.2021.09.01.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 02:12:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cpufreq: Remove ready() callback
Date:   Wed,  1 Sep 2021 14:41:54 +0530
Message-Id: <cover.1630487322.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last few users of the ready() callback and get rid of it.

Viresh Kumar (3):
  cpufreq: acpi: Remove acpi_cpufreq_cpu_ready()
  cpufreq: sh: Remove sh_cpufreq_cpu_ready()
  cpufreq: Remove ready() callback

 Documentation/cpu-freq/cpu-drivers.rst             |  3 ---
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |  2 --
 drivers/cpufreq/acpi-cpufreq.c                     | 14 +++-----------
 drivers/cpufreq/cpufreq.c                          |  4 ----
 drivers/cpufreq/sh-cpufreq.c                       | 11 -----------
 include/linux/cpufreq.h                            |  3 ---
 6 files changed, 3 insertions(+), 34 deletions(-)

-- 
2.31.1.272.g89b43f80a514

