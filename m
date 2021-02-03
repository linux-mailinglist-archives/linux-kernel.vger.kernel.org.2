Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACF30DE25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhBCP3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhBCP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:29:40 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6228C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:29:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e7so22709776ile.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFGkmubElQbvS/g2GSPy9v7b44R4KWqw63/+bUTYWwc=;
        b=vwFyv31SLu+Th9DI8gNwry5OUnx1yJ8iJPomo7p/vd9dxRm/9t+HeOU7V1V3HbvWn/
         T7SCzM38hLyb9Fnm4LZFBCAjx0CuECf2KrJ9Vi8O1T+EOB3uG93Rzj9/5EoM+ZYYUF4o
         UI3f6agieWa8xhzhOrKzHSb/kKrWzNl37rQ3ROqDLtN6ZNBhaVXbzYbeG4tAmD8bYpMb
         RDHDfBxBoNQmwNqG1olJL6Hq7Uwtms/0kMjS4ZatL9JqJ0dkHCByrk450fn+NeLE7HzO
         kT+qJsP+8dze+Iim/+5LtU/7tE9JXuDwPUU7e6cDeyA55+lDpDMGRJAqNuEF42cQl+Iz
         qH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFGkmubElQbvS/g2GSPy9v7b44R4KWqw63/+bUTYWwc=;
        b=ljcqr8v+uFynYDEM/QOrafnmoXTHauYdRuC9+pap78P6l5jq6s4Z7rwE0CzXBRedko
         L+N0y3olEh2w/uvwM7WJ0ofQR2/OxDb16/3ALlSt99FYS9CML45SsbDLeLtXtINEPkXJ
         e0EWvfYuclTwf4Lpc3sZ18luL+iP/BT6DCKvPAtVyNNZAzBdQYJf9kKyq0p1xvYMNreM
         XH2UC2gmMSALVeGCnBTPOXysE2Us/BP8TRqG7h9sEpJC7GObB0WrPmNB3OF0CP02h7jW
         a/Ghe2Lwrnpf0VMsppSntcJuMgYYwsdTKslvQW+1iNa/67MiflY7vcHvI0f1ndtujQFX
         I6cw==
X-Gm-Message-State: AOAM530njtuCiY7MFo2r+gNv13jxrwxuNiX8OZh5LRbNgU7jh0kwBi28
        mKCjjnV9G9Ax14wfS9bwvfXnVg==
X-Google-Smtp-Source: ABdhPJyNY9YTSnuUVAMo3vtHnjJKgDVWqab01mnJdaxoowISS1GNaiduHmJCONq6DGUNS1iuDvBTNA==
X-Received: by 2002:a92:9510:: with SMTP id y16mr3139414ilh.26.1612366140103;
        Wed, 03 Feb 2021 07:29:00 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a15sm1119774ilb.11.2021.02.03.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:28:59 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: a mix of small improvements
Date:   Wed,  3 Feb 2021 09:28:48 -0600
Message-Id: <20210203152855.11866-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a sort of unrelated set of code cleanups.

The first two are things I wanted to do in a series that updated
some NAPI code recently.  I didn't want to change things in a way
that affected existing testing so I set these aside for later
(i.e., now).

The third makes a change to event ring handling that's similar to
what was done a while back for channels.  There's little benefit to
cacheing the current state of an event ring, so with this we'll just
fetch the state from hardware whenever we need it.

The fourth patch removes the definitions of two unused symbols.

The fifth replaces a count that is always 0 or 1 with a Boolean.

The sixth removes a build-time validation check that doesn't really
provide benefit.

And the last one fixes a problem (in two spots) that could cause a
build-time check to fail "bogusly".

					-Alex

Alex Elder (7):
  net: ipa: restructure a few functions
  net: ipa: synchronize NAPI only for suspend
  net: ipa: do not cache event ring state
  net: ipa: remove two unused register definitions
  net: ipa: use a Boolean rather than count when replenishing
  net: ipa: get rid of status size constraint
  net: ipa: avoid field overflow

 drivers/net/ipa/gsi.c          | 94 ++++++++++++++++++----------------
 drivers/net/ipa/gsi.h          |  1 -
 drivers/net/ipa/gsi_reg.h      | 10 ----
 drivers/net/ipa/ipa_endpoint.c | 38 +++++++-------
 drivers/net/ipa/ipa_reg.h      | 22 +++++---
 5 files changed, 84 insertions(+), 81 deletions(-)

-- 
2.20.1

