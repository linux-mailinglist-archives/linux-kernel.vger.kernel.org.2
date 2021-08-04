Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE543E0449
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhHDPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbhHDPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:44 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78409C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:30 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h18so2039041ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8h55U4qoehATygi5+Ft5WQ5HVz6ZG81uzdeR4iTjOU=;
        b=op3v78XipVbN95/CiqQKf2+Y7ayrCj86rUrh6192Jtd9L5xZ9yTwK1UBBNiGqBxs5l
         4INi6y+6wskh7LvQZJ3GWLgMZz1lhqkNuVsrM92zvFzs9aq4tpcjQbtjw+Hdy6VwnAsx
         Vy0czEdkvMf2kHRYcvA941ueDl75RGSLIpzpq7lQJfVr8i5Dgsv9nIEsvmTkcxixBilH
         Pb9L0aZmYVmTVJw64XnsQp10WZHR4QtUdVD+NtZScOexcvMqYVqTY0ipauBsBI66DUbR
         qQ9ugn7WUqrxGx25ESTaRy8j1L6W4IdErRnZScIAt1xGcBw4vr/OKJs6XNrWGFUY2KEC
         BwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8h55U4qoehATygi5+Ft5WQ5HVz6ZG81uzdeR4iTjOU=;
        b=UR8/JseY6t9teUNr11tKhqMDB/ArTd4IFcQ3hyhAVfccO+eu7SI/2wZILuZWyCcJsx
         tzMjt5UZMC07PVPqieHE/na6QEI73LtCJ/U/VhzVU7y09fEZ/ajlgLTOwvNjPXU68MCy
         U57M/7xupnlNvhgKU+Swucxbwmbh4ty5LfKT/MafO9/gaXkXn/ThTJ9669e15pw/V52u
         5EPV6lMkjM3UadVw0P5wwx/VCL/LYXaTH6te/9ZvvUEFcgphhEL5wSOQJGuhRC70/teW
         wcCe6LyIN6v9d57+ePCdq0uZEDRu9cP5pIKM/PZPIr2gmtfIDqxAhyc0sYh85v5nOEhB
         zndA==
X-Gm-Message-State: AOAM531qL0gE4ZjveiLQy9UauoYKCI6yhocqzBZLxeEBAATqnxufqR0k
        eKwxsJeLQay884zCdIadD8a71w==
X-Google-Smtp-Source: ABdhPJyX3Ru1fYMxPgfSiamCOnSpdCn7xGH1QHstchFqfWKBX3Mz6kbiGRro7DUpaUku1gyD/ReenA==
X-Received: by 2002:a92:da0d:: with SMTP id z13mr106772ilm.95.1628091389859;
        Wed, 04 Aug 2021 08:36:29 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: more work toward runtime PM
Date:   Wed,  4 Aug 2021 10:36:20 -0500
Message-Id: <20210804153626.1549001-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches in this series are basically bug fixes, but in
practice I don't think we've seen the problems they might cause.

The third patch moves clock and interconnect related error messages
around a bit, reporting better information and doing so in the
functions where they are enabled or disabled (rather than those
functions' callers).

The last three patches move power-related code into "ipa_clock.c",
as a step toward generalizing the purpose of that source file.

					-Alex

Alex Elder (6):
  net: ipa: don't suspend/resume modem if not up
  net: ipa: reorder netdev pointer assignments
  net: ipa: improve IPA clock error messages
  net: ipa: move IPA power operations to ipa_clock.c
  net: ipa: move ipa_suspend_handler()
  net: ipa: move IPA flags field

 drivers/net/ipa/ipa.h       |  12 ---
 drivers/net/ipa/ipa_clock.c | 147 +++++++++++++++++++++++++++++++-----
 drivers/net/ipa/ipa_clock.h |  15 ++++
 drivers/net/ipa/ipa_main.c  |  97 ++----------------------
 drivers/net/ipa/ipa_modem.c |  30 +++++---
 5 files changed, 172 insertions(+), 129 deletions(-)

-- 
2.27.0

