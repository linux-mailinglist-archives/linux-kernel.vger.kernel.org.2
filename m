Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD58F3E5462
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhHJHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhHJHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB51C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso4017515pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp9yqcscf7/Q8S71rNb+DklCmCjBfuOZWtoJrdKgq14=;
        b=IAglVf6Pn8I8I9dsDbHjIfeAkSA/yD6E0MfLksr0I3bbp7rSOQLo46sTKTKHyl9KbR
         1/Ax/Ap4XrXSvqSfj4UKWMsMiK2Qlt+w+AwybJt6Afct7yPg8QghYKttCJvCY/xqXvkm
         SkVBZJ83g65LBxLJZxqL82lCxNFSOhBzmTWP+VjWSx6JwYTMIlwFMEqzKCpRoO2ZHeMy
         iLi9J2g4OA/gouk7AIivwb3wNG0F55BWN3FaLUULACXKVzJzbp8T6EZqU2AN3WsvBWuT
         6xKHRzNBm8HKbeykYID8qlR3XXsS6uZSkgeIJMMAyf3R73Ni3U2SsNf7QyhEebDAbH1k
         0nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp9yqcscf7/Q8S71rNb+DklCmCjBfuOZWtoJrdKgq14=;
        b=jg0wc3EkxmJqvCT5CmaA/cUSa4lz7h+p2H5gfv/Ywqsk+F8igHE7reQ0nMpQX4+b3v
         rs2v057CjBqlYox2YVAUXUTPG6frKt03/16Y7HYB4Bkr3jUcVkK/UOwmBGqDbXNqN/6C
         8YaiBYJ+uozZXMrO0BhFE1zOHDeeB7FI+4tDEDTZ9/xLotIp7telvr89Zh0kuSnFXchW
         OLz+jj74YBcNzub23ZnEH1vVNBNPBocemXyTJ25PmXaLwyFgfpFNMIe/QWKm2cjCBLKJ
         f0AkfpczkDGhu8rbcRskMFRPcC6KFcyJiesa5o0c+FA8fewEeBOhtKl+d33vEtz6/cuX
         nVBg==
X-Gm-Message-State: AOAM533a7XVtb85Ktz22IO/Md5UsJByBFDT7oRXnBPji5sxJDbYmPUez
        OWDW0x2t06J1dufTOWaTWPVHzQ==
X-Google-Smtp-Source: ABdhPJxILYrr525KX9FnT9P3v0D4xd0mT7Xu47cl+ZsvaVSJ3lXE+EgGIYbCSv1kqvc+zewvjPYhrA==
X-Received: by 2002:a17:902:b601:b029:12b:d9a:894f with SMTP id b1-20020a170902b601b029012b0d9a894fmr350019pls.63.1628581023914;
        Tue, 10 Aug 2021 00:37:03 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v14sm1734591pjd.35.2021.08.10.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/8] cpufreq: Auto-register with energy model
Date:   Tue, 10 Aug 2021 13:06:47 +0530
Message-Id: <cover.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
with the EM core on their behalf. This allows us to get rid of duplicated code
in the drivers and fix the unregistration part as well, which none of the
drivers have done until now.

This would also make the registration with EM core to happen only after policy
is fully initialized, and the EM core can do other stuff from in there, like
marking frequencies as inefficient (WIP). Though this patchset is useful without
that work being done and should be merged nevertheless.

This doesn't update scmi cpufreq driver for now as it is a special case and need
to be handled differently. Though we can make it work with this if required.

This is build/boot tested by the bot for a couple of boards.

https://gitlab.com/vireshk/pmko/-/pipelines/350674298

--
Viresh

Viresh Kumar (8):
  cpufreq: Auto-register with energy model if asked
  cpufreq: dt: Use auto-registration for energy model
  cpufreq: imx6q: Use auto-registration for energy model
  cpufreq: mediatek: Use auto-registration for energy model
  cpufreq: omap: Use auto-registration for energy model
  cpufreq: qcom-cpufreq-hw: Use auto-registration for energy model
  cpufreq: scpi: Use auto-registration for energy model
  cpufreq: vexpress: Use auto-registration for energy model

 drivers/cpufreq/cpufreq-dt.c           | 5 ++---
 drivers/cpufreq/cpufreq.c              | 9 +++++++++
 drivers/cpufreq/imx6q-cpufreq.c        | 4 ++--
 drivers/cpufreq/mediatek-cpufreq.c     | 5 ++---
 drivers/cpufreq/omap-cpufreq.c         | 4 ++--
 drivers/cpufreq/qcom-cpufreq-hw.c      | 5 ++---
 drivers/cpufreq/scpi-cpufreq.c         | 5 ++---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
 include/linux/cpufreq.h                | 6 ++++++
 9 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.31.1.272.g89b43f80a514

