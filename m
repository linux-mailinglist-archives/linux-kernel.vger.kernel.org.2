Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C4319508
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBKVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBKVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:20:11 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:19:31 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m17so7229414ioy.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB6v6pbCC+I6JT323RU029Yd3JsPDnbpV7qCSoFQ1kQ=;
        b=AfIRC4jOO5KlWymSu64kVimfhxKW0ltHwd6xEcx5VpiXDmEWvGakFOKxivio64uGvF
         XWbz+9TBCb3+91J0PhRZcbBHxfT/U2kly77jm+E6hR5cQKet+w7oaqKdvJkAGvE40JO5
         pUskql0uFCbtvNDTzIreDDUNEzfGAJYxD1aKasCAncTF84PP/9XzOxi4nUaUJqSuT7nO
         0PZHZWhohHg4HPzSUJxFnAnC7zmxRFeKKzU219b0RYnOXDWO1IvEIRkKn/1J+3LNMJSW
         kLA2gFoRAoce71GAGd3g6R3gCg0dbMnXmTw8u8RL0tJTTO/3chUrEmz+ySIPAQcjbQEr
         +LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB6v6pbCC+I6JT323RU029Yd3JsPDnbpV7qCSoFQ1kQ=;
        b=ZISZQM5schvLoVw8ISgBPdeONzZ5Q/FpkvJKpLXyvXzeftXYU9Xxx3KukHf8QRqkEd
         Y0YP+IVTfAJJFLGVVcjVWHLO5CXEqDelWz9EZYYEmfCjoKTTsHzopGxutvwNjsFa4VMB
         TX1/k4RU1H46ZMOBefiEpEUhql7h9VkhrV/mcQWXkmv0mlr0Mf+QA+DQIH9Z5tNAGIU6
         9B5oknOr6VWt/kw2nbzcvo/lkk9b9w2VeDbQvt4IG9PV4MNU2YdU7jbrhp/SsCMYvnux
         jOKetq913P91ozZEWxe2V+vdtcF1gUrunPvA5/ggssHEZ23ZDmvbKimwR4j8GLzGwruz
         SFzA==
X-Gm-Message-State: AOAM531K9ZEP4V9gq3k5aS1r8OBTUDnfHWKp2wy1bzzBvU50GFgQqv4i
        Ismaf3je7RKDiSwhph6DDcfrrg==
X-Google-Smtp-Source: ABdhPJwi3JLFfw9DgRHW4GqtvU07zEK91/g7NJwX8KRPbQKzJbXmnMcCXMaffAay8e/+nzJlCWq47A==
X-Received: by 2002:a5d:9586:: with SMTP id a6mr7288796ioo.83.1613078370494;
        Thu, 11 Feb 2021 13:19:30 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j10sm3155718ilc.50.2021.02.11.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 13:19:29 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/5] net: ipa: some more cleanup
Date:   Thu, 11 Feb 2021 15:19:22 -0600
Message-Id: <20210211211927.28061-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of this series has been rebased onto the current state of
net-next/master.  In addition, copyrights have been updated on files
touched.

The original introduction is below.

					-Alex

This is another fairly innocuous set of cleanup patches.

The first was motivated by a bug found that would affect IPA v4.5.
It maintain a new GSI address pointer; one is the "raw" (original
mapped) address, and the other will have been adjusted if necessary
for use on newer platforms.

The second just quiets some unnecessary noise during early probe.

The third fixes some errors that show up when IPA_VALIDATION is
enabled.

The last two just create helper functions to improve readability.

					-Alex

Alex Elder (5):
  net: ipa: use a separate pointer for adjusted GSI memory
  net: ipa: don't report EPROBE_DEFER error
  net: ipa: fix register write command validation
  net: ipa: introduce ipa_table_hash_support()
  net: ipa: introduce gsi_channel_initialized()

 drivers/net/ipa/gsi.c       | 50 +++++++++++++++++++------------------
 drivers/net/ipa/gsi.h       |  5 ++--
 drivers/net/ipa/gsi_reg.h   | 21 ++++++++++------
 drivers/net/ipa/ipa_clock.c | 12 ++++++---
 drivers/net/ipa/ipa_cmd.c   | 32 ++++++++++++++++++------
 drivers/net/ipa/ipa_table.c | 16 ++++++------
 drivers/net/ipa/ipa_table.h |  8 +++++-
 7 files changed, 90 insertions(+), 54 deletions(-)

-- 
2.20.1

