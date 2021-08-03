Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313A33DEF88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhHCOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbhHCOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:01:19 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EBC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:01:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so24372740iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/DHKWIP8rWNGLSAcP/V8hiWErKdNVmxV1ktr6ph0IY=;
        b=SxavRXCU4BdTr92avY1C++0gB3PNx8cunSCef21gbaL+U0dQPSNJGuNZeXKnt/RIuO
         0lBNLvKE3iPbPB+Nzz0nn2WHB72HPTuWRTCpvxooQT4p5a3aNxRc+zwkgca4iFymVsTf
         tO55OH0qnh34wtaasrySCr++sOr8ZrXyJE1M7lSDOFK6K6EOCQPMpVwNqkS33KQKIIGF
         s5rc2knAEqOPhEkaLQRHwUqqgQmWW97TkU7JHmh0SUtPH+/qZQwQuZoxCIKAv0QppCF6
         6dBSU+8Ra8Vir1KOH4Duq6jQbgw5kuVZQbJpIlF4NmWt8CwMyfWgqePTsdNMgCjzo4bJ
         dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/DHKWIP8rWNGLSAcP/V8hiWErKdNVmxV1ktr6ph0IY=;
        b=InVPRinJGw0m+jsqLn2x32vFmKIeD6C4V4MZ60j+aFdq+lxFpTCfGKpI6CI5n1UPQt
         KBpeQ4b8xDGExbliAa8XUa47F3D0LivikmRBWK8Wq2zeb1r1UudnGcu5EYXsrkQGX67P
         5qiDv5pVsZQB+IiRk3bhDmMuT4gM4Vpt82cHRJYEmumu1hLkGZ/o8tTCfpPLDj8SlYTA
         cNVRYuQtsNseVdoX+wkO9eLROf0/dU0CUoXk5ti8/WDMxayrctmBKSvRZ0Fe/AaSF7y2
         /mntKzxprGfwHMT0iikjOv7LS10rueJwHw3Ag+dw57o155Yn9IXfuvgKUWlMILyB9qxx
         ZkWg==
X-Gm-Message-State: AOAM530KMM/ADNqCb0kDk3zZD0+bsmlO2hx5i1Km/MvlcapzdPdDcQz6
        c/1U6mUqv7/VaUA7J+tNe1eJbA==
X-Google-Smtp-Source: ABdhPJzcZE5I5+fZfgli3z+04kaI0/+RDoeCqyiKoxscA++9qncW8AmsRqgADFQqBfSENZN8jHHzFw==
X-Received: by 2002:a5d:9617:: with SMTP id w23mr430474iol.115.1627999267722;
        Tue, 03 Aug 2021 07:01:07 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w7sm9456798iox.1.2021.08.03.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 07:01:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: prepare GSI interrupts for runtime PM
Date:   Tue,  3 Aug 2021 09:00:57 -0500
Message-Id: <20210803140103.1012697-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch in this series arranges for GSI interrupts to be
disabled when the IPA hardware is suspended.  This ensures the clock
is always operational when a GSI interrupt fires.  Leading up to
that are patches that rearrange the code a bit to allow this to
be done.

The first two patches aren't *directly* related.  They remove some
flag arguments to some GSI suspend/resume related functions, using
the version field now present in the GSI structure.

					-Alex

Alex Elder (6):
  net: ipa: use gsi->version for channel suspend/resume
  net: ipa: move version check for channel suspend/resume
  net: ipa: move some GSI setup functions
  net: ipa: have gsi_irq_setup() return an error code
  net: ipa: move gsi_irq_init() code into setup
  net: ipa: disable GSI interrupts while suspended

 drivers/net/ipa/gsi.c          | 239 ++++++++++++++++++---------------
 drivers/net/ipa/gsi.h          |  31 ++++-
 drivers/net/ipa/ipa_endpoint.c |  14 +-
 drivers/net/ipa/ipa_main.c     |   5 +-
 4 files changed, 166 insertions(+), 123 deletions(-)

-- 
2.27.0

