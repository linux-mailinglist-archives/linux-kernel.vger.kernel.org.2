Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2C44806F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhKHNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbhKHNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:47:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BFC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:44:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id t21so15835806plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BbJMl2HZLk1iyOtoDPVlVmqhPv2VnizONosZZ15nm1M=;
        b=e5QPuMkMIlVkkV6Jpcot5D8YZdKHEc7nrFTmZov7A8gaIW/PrieQGAx7p44j+edsYd
         G0LZNZopZb13mb3lhgEzkM0zmj1b3EcYoqo+jeYE7xzloyqPlgZOGjnj0NypXJD0kX6x
         fRZaiN7RBVG8mqSKJbfrLatgyT3Kd5nSxEjJWqkSGFsvTeHdJcydqPVcMGxDJwnZrPIv
         lpnpnE1XXSYWX5OX7vgv36cnaP012W5WniHjVwVmVKvYorqREum9VQ4bc1VyCzMyB6ta
         Ibkq674akVP1oiMgHoj5GDkZ3kXNrkG0kOt9VHVgmdISaPZggHN6Nm/+uyJDZuEPKAys
         EA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BbJMl2HZLk1iyOtoDPVlVmqhPv2VnizONosZZ15nm1M=;
        b=IzyEgkvwAzkNsDHdN8bLobPigRVpXLGcNXPQ2HHY9Qb/Tz8DACEWQ5/0F+EaNGVn8J
         L3Y+HjSaw8t4ZugjtZvbocJkYqkipmNPfI8iwRmf1gjIXVhIxWQKgvDXPgCbl0/6WA82
         XrJDYhnbMXRtopiWHPyguOQ4Q5miIUS1kS4ITXjOQNZFTISeys3eo7U6zsuJiwBDNh6t
         CckYCh7tQN4p3qIlu8IFNS6M4/HKlDHnfELLMPufcuzzLwuu0z5JpH61Gv3nWOzwzPQu
         O/3uD6VpvFli5iOqeqBFTZqz/bM/yXuxRn43301ZRlyAc95xbNO2/83xTLgWUUVCXvLe
         OU7w==
X-Gm-Message-State: AOAM530tSuAa4ANBXsqMQk7iC+wv/9ImZ5Z0ojVrsAM0FGSR6Hrj1XP7
        ydMeCsAyF7zV8etraSffQeGmQw==
X-Google-Smtp-Source: ABdhPJxYcZYcfc+h2yHGVEXR50H8V8F020aV9K3REtKgGY9W4KE3G3G6ykmiYa7BCygZztngLLFlVw==
X-Received: by 2002:a17:90a:6542:: with SMTP id f2mr51118384pjs.159.1636379094991;
        Mon, 08 Nov 2021 05:44:54 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m184sm3693974pga.61.2021.11.08.05.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:44:54 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Add QCM2290 RPM power domain support
Date:   Mon,  8 Nov 2021 21:44:39 +0800
Message-Id: <20211108134442.30051-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a separate cleanup, and the rest two add RPM power
domain support for QCM2290.

Shawn Guo (3):
  soc: qcom: rpmpd: Drop unused res_name from struct rpmpd
  dt-bindings: power: rpmpd: Add QCM2290 support
  soc: qcom: rpmpd: Add QCM2290 support

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/soc/qcom/rpmpd.c                      | 19 ++++++++++++++++++-
 include/dt-bindings/power/qcom-rpmpd.h        | 10 ++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1

