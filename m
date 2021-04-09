Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA7135A536
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhDISHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhDISHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:07:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE01C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:07:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b17so5445746ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzYhbHDbJACxfQq/p73lkP2izDMGTV4nDvidn5vV/gc=;
        b=E5KeQiTmWpDeH3nc7r+zWnFXvICVq1Lc3YuajJzxd6kXfZhexynUuvcmWOSB3nL2Fx
         BnjZUWxXJAiIVXR6+ievFLkhB97yoFjgjR47TyB4oe+1nz8Pd6EArWNskfLpF7XuVigO
         yloJ2/+oD8BAFmAJAMd8xwPEiRvZxgSVwCMqcuEnpPpTvCzPGUiCxzZmCDtFHy3NZ+ue
         2fs8uRDcE+Or1yXzMzR7HKRzkIxhVinuY87TaLdjMsJuZw68lOB66mHpXuJFw9af1kVN
         FPj7/qEieBAdjMZyaAOXdZd54hiU6yUbxdyMtBAQXslC/cJRV4+znZP/8vdGr51siFHy
         d0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzYhbHDbJACxfQq/p73lkP2izDMGTV4nDvidn5vV/gc=;
        b=MEiFC0JDpIL7n6VQwESr1RNB04RxjWJ06vWRMRvghOueXEdFo8xCtt11dfcFWq6zC/
         +6qhekvSbb2YokpEbeLSVVrzktamYh9PR60VMj8R0gG3kXKVvqboZ/R5KwY2M73JWJoz
         QvTiZYh/CbxM3VUXZovVrPWpCFScSO1OGEGTbektVR0Tg2cXFEROgNjtD6sY9L1n5bsF
         nLnmpi8dELhJezjQvZM8M85qI5HV2lWDL4Wixk3q9cOk5E7NgwenZdItlnuqCEh05t7A
         fUvBO7kYD3bdroG5EW1q1R5yyCQwmlPgSnOB8Uq+SQn1wYMhiynLuUpmJctYZTaJ3zy0
         EswQ==
X-Gm-Message-State: AOAM53262LBWWyxV9mxskS06zzzV9bpDrvSjUc251JReOcWq3BRJhKaZ
        Apfl4uXlZbUSX/80TrB5Vrs4AA==
X-Google-Smtp-Source: ABdhPJzDc+IsXvnjRUG7vjRO2VoDZ5qMF1tyZSATFX2SB/ccRRlaZU3wiKpCg6oVU8CNdkW6r7f0mQ==
X-Received: by 2002:a05:6e02:1c42:: with SMTP id d2mr1341630ilg.287.1617991645720;
        Fri, 09 Apr 2021 11:07:25 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g12sm1412786ile.71.2021.04.09.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:07:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: a few small fixes
Date:   Fri,  9 Apr 2021 13:07:15 -0500
Message-Id: <20210409180722.1176868-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements some minor bug fixes or improvements.

The first patch removes an apparently unnecessary restriction, which
results in an error on a 32-bit ARM build.

The second makes a definition used for SDM845 match what is used in
the downstream code.

The third just ensures two netdev pointers are only non-null when
valid.

The fourth simplifies a little code, knowing that a called function
never returns an error.

The fifth and sixth just remove some empty/place holder functions.

And the last patch fixes a comment, makes a function private, and
removes an unnecessary double-negation of a Boolean variable.  This
patch produces a warning from checkpatch, indicating that a pair of
parentheses is unnecessary.  I agree with that advice, but it
conflicts with a suggestion from the compiler.  I left the "problem"
in place to avoid the compiler warning.

					-Alex


Alex Elder (7):
  net: ipa: relax pool entry size requirement
  net: ipa: update sequence type for modem TX endpoint
  net: ipa: only set endpoint netdev pointer when in use
  net: ipa: ipa_stop() does not return an error
  net: ipa: get rid of empty IPA functions
  net: ipa: get rid of empty GSI functions
  net: ipa: three small fixes

 drivers/net/ipa/gsi.c             | 54 ++++---------------------------
 drivers/net/ipa/gsi_trans.c       |  4 +--
 drivers/net/ipa/ipa_data-v3.5.1.c |  1 +
 drivers/net/ipa/ipa_endpoint.c    |  6 ++--
 drivers/net/ipa/ipa_endpoint.h    |  2 --
 drivers/net/ipa/ipa_main.c        | 29 ++++++-----------
 drivers/net/ipa/ipa_mem.c         |  9 ++----
 drivers/net/ipa/ipa_mem.h         |  5 ++-
 drivers/net/ipa/ipa_modem.c       | 34 ++++++++-----------
 drivers/net/ipa/ipa_resource.c    |  8 +----
 drivers/net/ipa/ipa_resource.h    |  8 ++---
 drivers/net/ipa/ipa_table.c       | 26 ++-------------
 drivers/net/ipa/ipa_table.h       | 16 +++------
 13 files changed, 49 insertions(+), 153 deletions(-)

-- 
2.27.0

