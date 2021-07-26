Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A03D65E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGZQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhGZQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:59:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:40:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l126so12865819ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vibDd1ZtmcJJ8CZRfex6KJyuRRDjWadOPJekQLM4f94=;
        b=iNFNKkkNtC/iB8qo6UJAAwmjVeGa7yMXuqaoLbNb3QbmLmDoY5Ktz3tGdBtn/368rZ
         neWGXw1baU56lh8xfWzP71w38kZSIngKSaC1JFxc1UX2pxbllSN/79rsrpL72+1cXnCX
         MCbJoCf4tREYGdU2l52GJixqei1yEivt9Z/pq2o9EYOa++64kCURxQj51UGqdFo9RhTs
         s5Rp82QSqZ5o5aN9OmjVqbj5SQDatkcPwlUN+1woV2BbYKWj4ONULZ0AAKjvzWesN6Li
         5lou1bFIE9Skmu/w51L3jUzoDQziROBXrgKzhfANjxq/RhY+2y5IAVIWMd2Zd9MBskri
         qzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vibDd1ZtmcJJ8CZRfex6KJyuRRDjWadOPJekQLM4f94=;
        b=fjciB+8K6Po+NjS89tFznXvDkwC1dXtVAu2y4DRUqSzsILjbfeUJqX57iMc+wQWI5i
         FagajjL9mgUh8qNST7PzxHAMM7c36wtTxwNf0ElxWGp3wbrjQZYSNaxslFV3KbbDB8d8
         Fh/WNZBkqxPDGQ5C7JTz1JYDhUbBtLp+AvYBdMUb7KASMnJf3D62NoFGo2Kcj02/byac
         5cfRVpLAprm8koNfVcOU1JMtZ3bk9rRU40vJ0zErW0UEyJcK2CPlo4oUmoOzAOW5Xgj0
         BxqlqEXu71qo17fa+uAJwDD3vk5E6z4suKOLUX0ULbSvgBP/9ndJQv8mkhyhMJBPNj1w
         4cOA==
X-Gm-Message-State: AOAM531p9L2HicixmoqgFtWVdw6aHEeqMt/Xy+h32eA8eMpUGhzkXj0l
        bTrmNGGTP6+UtFf/yk4luT6ZAQ==
X-Google-Smtp-Source: ABdhPJymFm+GPWr6Pa/ZdLlskZYnKViV4V5iWZbBXr61SmCciFfAO47JZDFIAUt/InV7dAAiuiZpcw==
X-Received: by 2002:a05:6638:264e:: with SMTP id n14mr17521329jat.71.1627321213817;
        Mon, 26 Jul 2021 10:40:13 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l4sm202721ilh.41.2021.07.26.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:40:13 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     leon@kernel.org, bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: kill IPA_VALIDATION
Date:   Mon, 26 Jul 2021 12:40:06 -0500
Message-Id: <20210726174010.396765-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago I proposed cleaning up some code that validates
certain things conditionally, arguing that doing so once is enough,
thus doing so always should not be necessary.
  https://lore.kernel.org/netdev/20210320141729.1956732-1-elder@linaro.org/
Leon Romanovsky felt strongly that this was a mistake, and in the
end I agreed to change my plans.

This series finally completes what I said I would do about this,
ultimately eliminating the IPA_VALIDATION symbol and conditional
code entirely.

The first patch both extends and simplifies some validation done for
IPA immediate commands, and performs those tests unconditionally.

The second patch fixes a bug that wasn't normally exposed because of
the conditional compilation (a reason Leon was right about this).
It makes filter and routing table validation occur unconditionally.

The third eliminates the remaining conditionally-defined code and
removes the line in the Makefile used to enable validation.

And the fourth removes all comments containing ipa_assert()
statements, replacing most of them with WARN_ON() calls.

					-Alex

Alex Elder (4):
  net: ipa: fix ipa_cmd_table_valid()
  net: ipa: always validate filter and route tables
  net: ipa: kill the remaining conditional validation code
  net: ipa: use WARN_ON() rather than assertions

 drivers/net/ipa/Makefile        |  3 --
 drivers/net/ipa/gsi.c           |  2 --
 drivers/net/ipa/gsi_trans.c     | 34 +++++++++++-----------
 drivers/net/ipa/ipa_cmd.c       | 51 +++++++++++++++++++--------------
 drivers/net/ipa/ipa_cmd.h       | 22 +-------------
 drivers/net/ipa/ipa_endpoint.c  | 26 ++++++++++-------
 drivers/net/ipa/ipa_interrupt.c |  8 ++++--
 drivers/net/ipa/ipa_main.c      |  7 +----
 drivers/net/ipa/ipa_reg.h       | 12 ++++----
 drivers/net/ipa/ipa_resource.c  |  3 +-
 drivers/net/ipa/ipa_table.c     | 40 ++++++++++++--------------
 drivers/net/ipa/ipa_table.h     | 16 -----------
 12 files changed, 96 insertions(+), 128 deletions(-)

-- 
2.27.0

