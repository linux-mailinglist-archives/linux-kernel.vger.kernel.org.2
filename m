Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09931736B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhBJWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBJWeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:34:04 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD1C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:33:24 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n201so3672288iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc0cKAaWwDGgmfaTk/UgFMkJLA66GM85PZScS2V+gQk=;
        b=AsV/JDL0H+XSIovRmupF23EzOLT3l99uwlVTF0UQ4Fk77n72M2Abjgp5pzhFYearBC
         2Q5/6+VZecf2ijlsEKAL95qAF9tYy5FqWvpPr/beakdWoBGTyGx5g1X249wmeJeYoEtt
         nF5SSN8Z+esyomp+A/ke39U2cn2yyDB5l0IsjTgQSSGC/7alKQ+OvmQEndEFEIml2ef6
         zKD0sqGafAUzU4PAr87nRV+NbBpm+VebuhxsWMWmTfe7YTavIl/cX+0Us91L7BASA4qw
         ftUwpt5CaV/69iywQDBAHE8DnGZx0LO/d1IT+lYBkotAoQ18OZFrsyYaivea7Ww8y8Mu
         ZjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc0cKAaWwDGgmfaTk/UgFMkJLA66GM85PZScS2V+gQk=;
        b=PWV4ZWU21OWGWvmqiGIekXQwV/suDoC00hkJ6zMXK3NMJdLEwy/OywgRyPrKOjurz4
         WP/IspbIGCqAjQQWxMEaEBG6MnNDGxhn2ESx0qWDv5rlgp/1baIoeh3TT5AG7MpleGFJ
         O6NdnX76/cBNtx6QUG2be6DXttFf7FFkyTh4lDPovnjPcMrIqdnHRWTmFLtbafhFCube
         5Eg3y1GYAjcnKP6BV/YjU+QsvYZdoVoRdYdw5+LBvlnRgPlot/B0HVPAVIqZ1adqqWHV
         vRvTay+LrNoV7vaDyg8gobZqttg7jYf7zuP877julP7XrMXyGQ5NhHhJMvaQXOfH+rbH
         xBZw==
X-Gm-Message-State: AOAM533tiAiO1To84k4wEI2gEMb1UdHtNUVkqN6vuFbsfceOSSJKnBkM
        nItZc9J0pnWgNAdDM5rbtpjaCNy3jqk7+g==
X-Google-Smtp-Source: ABdhPJwh/5mrknwGHGZd8XUrNCYgFjovnKFPoWo7Sa1TkpqUbuF+OUcHK9xRM3w9N2Ozm7c9Lzbs3A==
X-Received: by 2002:a6b:5404:: with SMTP id i4mr2685666iob.62.1612996403568;
        Wed, 10 Feb 2021 14:33:23 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e23sm1484525ioc.34.2021.02.10.14.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:33:23 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: some more cleanup
Date:   Wed, 10 Feb 2021 16:33:15 -0600
Message-Id: <20210210223320.11269-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 drivers/net/ipa/gsi.c       | 48 +++++++++++++++++++------------------
 drivers/net/ipa/gsi.h       |  3 ++-
 drivers/net/ipa/gsi_reg.h   | 19 +++++++++------
 drivers/net/ipa/ipa_clock.c | 10 +++++---
 drivers/net/ipa/ipa_cmd.c   | 30 +++++++++++++++++------
 drivers/net/ipa/ipa_table.c | 14 ++++++-----
 drivers/net/ipa/ipa_table.h |  6 +++++
 7 files changed, 83 insertions(+), 47 deletions(-)

-- 
2.20.1

