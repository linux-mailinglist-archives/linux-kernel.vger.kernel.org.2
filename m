Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1E338B44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhCLLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhCLLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:09:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CBDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:09:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l11so4569753wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvwdVooEhL1UHLjF9fJJHmRKq3X0NEaOuxkxsIXRcL0=;
        b=ZU/RXORBTEmPN+MuEjxLxYId14OaO3lgdjNHiyjDVQsdw/lmsZ94Yok4/MH5Unh2L8
         5L7KZxhMxSqYANxvLALuwxLhj/vtMRM4xONYfIhoJLSg3Yz2Vo/7NcvnRgeI8GfNG9Kx
         c99h7KkdqflEg7LKwi9rBHTfTaSA14BNAJkE7BxgPYT9asP54im4qJPT8G6X2LYsUZKO
         gxMeet3YcSS4O8AlDkuWyFmwSg4uHjlgw1OSbS5UW7GdCTe5IUw20xQYnY7so2I40Sss
         b71tYF0jJwLJcJMG1PQ7UAR2UvHbO+ppxSLhl3qJAzRDzF5VPI12/LC+owgNIp59Cdr/
         nBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvwdVooEhL1UHLjF9fJJHmRKq3X0NEaOuxkxsIXRcL0=;
        b=mW/C93PhKfwEZ1oxypQXCIPm5ShuWv2bZRr5y7uWP2eGUXFRntUKan8A5vjdV/9NU+
         MuFbzwAIY9S7Yvq8/lkC0V9gWtdCmnZ/rjPp7MuIonx/aUPdxhTMJ/uQ6FOdkxDS59ln
         pSlqvHV9wAV3+Kxw4bMxsntUdAJS9nG8klX7HLh5FQUcc78PWo2LXeYZR2/ZvOfSaSb/
         2wtpTfZZa8aXGLmtd4kPxkV5zlqr9pzIsdNjrPu0CPrZNASih/ktjMunVNIdjxDpgxQi
         cTkWJqC5FUXgz0alAUCdLpTEIIp1Za0J413qM0I4lQe2tLs6rs5Pe35SVlvIbmQZwbQ0
         BYIA==
X-Gm-Message-State: AOAM5304cJVxfvD7UNZdMHD5w+1hsoYZ/2KXWqfvIaqHQ06U1NNWgLXn
        IHpfjUG5+fTNx0bTZwlETNVtZg==
X-Google-Smtp-Source: ABdhPJwbDaKFp5e5X0V/bXRF8AiYHu0FEYzo16BK/BKoEPMy/ZL6g02phJIi2GgcTBu0ot/o633wpA==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr13441880wrj.391.1615547353347;
        Fri, 12 Mar 2021 03:09:13 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id b65sm1833255wmh.4.2021.03.12.03.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:09:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Suligoi <f.suligoi@asem.it>,
        IDT-support-1588@lm.renesas.com, Jakub Kicinski <kuba@kernel.org>,
        LAPIS SEMICONDUCTOR <tshimizu818@gmail.com>,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH 0/4] Rid W=1 warnings from PTP
Date:   Fri, 12 Mar 2021 11:09:06 +0000
Message-Id: <20210312110910.2221265-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (4):
  ptp_pch: Remove unused function 'pch_ch_control_read()'
  ptp_pch: Move 'pch_*()' prototypes to shared header
  ptp: ptp_clockmatrix: Demote non-kernel-doc header to standard comment
  ptp: ptp_p: Demote non-conformant kernel-doc headers and supply a
    param description

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe.h   |  9 --------
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  |  1 +
 drivers/ptp/ptp_clockmatrix.c                 |  4 ++--
 drivers/ptp/ptp_pch.c                         | 21 ++++++------------
 include/linux/ptp_pch.h                       | 22 +++++++++++++++++++
 5 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/ptp_pch.h

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Flavio Suligoi <f.suligoi@asem.it>
Cc: IDT-support-1588@lm.renesas.com
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: LAPIS SEMICONDUCTOR <tshimizu818@gmail.com>
Cc: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com> (maintainer:PTP HARDWARE CLOCK SUPPORT)
-- 
2.27.0

