Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C19840A3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhINC5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbhINC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:57:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B63C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:56:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v1so7195568plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ifupFMSTcCep9IzPKWCOumJWTmyjfV+oqZJWNKaxyUc=;
        b=MrNAqqOxdBSfb/yyeYBgn6IsQWbPhLA6UArwIqmWSYthjohfn65xqVTNjt94c5cG/x
         hwzYUJ+BOp60jjj0OAH0Ws9+HqU7Xs0ZwgNfY/L2jy3iv5wEv0NaUTpEpKKNWLUKoOyz
         rYV2B1Em7zvN/5cbwXSH//ANXFY0TtMBOo9YMAW2HXHERmqfhK+qtJzcaOYDzPyUf8aw
         ms08PutsOzAg7tEoXk/QmV5aiEp2NB1m+Sm4T3FStgnIMzHXVwGqB4U+ge1R3RzgsPH5
         U5Nx0sPX7dRtIHAPId7IZPMpOrAna5YFz4+q1KBnOXBe1dIKlfd5GDy9dS7A0pVm6vqi
         VhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ifupFMSTcCep9IzPKWCOumJWTmyjfV+oqZJWNKaxyUc=;
        b=xCPqiapMzrb59l/8uv0570K1FOzbzD4sNE6OknsR+6AHpm2oFbJMzrFPhwvPwnJ5mx
         zEXWcajnIt/R9CBqtXRriJQkbpxtg6+2v1EuZTJb6cMpFdnAk6klC6eMc26fzwJGUcuL
         y8kKweD/MxnxNxUZVN28MJwWQgXUGfFnplGyfmaPInQKarmnSeFlkmyPmw8Joc+rVRG1
         FvPgASiuKKTsQkf0ID3YbAXmZc2h2rDn8qHzJoVRRzDDIiTYnOw5FkH4boprkBf00sOz
         APO3doGRJrlIc24ZvApocj4O/P7amt7BLsqtV9VD/08BhqVnBEfO8HM75oo/rAOxQvru
         4CqQ==
X-Gm-Message-State: AOAM532C+C4HQVwZnfFxG9zgEj0FadWuc2PcIssTafOXMIyfvp7pUwQk
        QUslTkxP1QAnpBPx1Znafnxu1g==
X-Google-Smtp-Source: ABdhPJxHTfsFXFxMo4QASlZPU5TovKzdFs4EZ+LLQFcRJpKgTwLTnWqKEeA1pC2yu+vD52N1DQjLuA==
X-Received: by 2002:a17:902:bc8a:b0:13b:78bc:9e18 with SMTP id bb10-20020a170902bc8a00b0013b78bc9e18mr13183205plb.53.1631588161357;
        Mon, 13 Sep 2021 19:56:01 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id r13sm9622654pgl.90.2021.09.13.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 19:56:00 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Add QCM2290 RPM clocks support
Date:   Tue, 14 Sep 2021 10:55:51 +0800
Message-Id: <20210914025554.5686-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds RPM clocks support for QCM2290.

Shawn Guo (3):
  clk: qcom: smd-rpm: Add rate hooks for clk_smd_rpm_branch_ops
  dt-bindings: clk: qcom,rpmcc: Document QCM2290 compatible
  clk: qcom: smd-rpm: Add QCM2290 RPM clock support

 .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +
 drivers/clk/qcom/clk-smd-rpm.c                | 62 +++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmcc.h        |  6 ++
 include/linux/soc/qcom/smd-rpm.h              |  2 +
 4 files changed, 71 insertions(+)

-- 
2.17.1

