Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A13B151B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFWHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:52:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E6C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so3359535pjy.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCWBbioEHtHJzv9+CJcDh4HpVJY4QYX5sGkNG1Q+JpY=;
        b=CycEjqYrALZTqZwmi2GhplKGcGO3AgLKB7KOs55ZnNHyaUZ4yYKGyX9gdEyVGLoHF4
         hbNwESHFpujY6WNiBV6UJ1rFS3jEcpnLloByEQVMCHxZlwHVmLZaOz8q0TJbnkv8zyFn
         ZUb4aAnSP++Ho6TStCr5p9JMvHEhDht2A1ZZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCWBbioEHtHJzv9+CJcDh4HpVJY4QYX5sGkNG1Q+JpY=;
        b=m5+mMMCI9JLsUnwJbMZ2pIA0rEkSmr2xgkuqgVdOV2jRRFf2yjOR7n0hvFoycq0qxU
         E1bV/rm+pgoqoCrfaVsTBSM61Qkbhj6WkwOrYvNAFR+ul0F/qtspQdyJNW0LWeGynse5
         Wu1jDI92Gc2OKnAtDLsmAHRyKqVY7cFAx5fhCZzYEnK48pRrErU/76kSmwirEzjwSdjn
         6ZSdC9Ij1bPL1DW2cnvtYAu3EX5Oll1JpGT6YQf+HuDbgat0bXSn/ljzn4sdjuGYU33M
         Md8/15BxCoSrppbjKk1h6CHcHCaqs4GYJ/cplHGE2K0WrxhSpOwl1uqT/ZbTXsCP87mY
         BVRg==
X-Gm-Message-State: AOAM531xwHjz6a94Pnx9guFePg1/PRhR+Pmx8Sqqq7y0F1QLwXTR9yjN
        mkWnREC2qkrLTh21DQsbeZ69Ng==
X-Google-Smtp-Source: ABdhPJymIdrXB1rmnc/2QWjH6a2YQ+H05IEkm6jQdByEZxAOxIYruKmHKw8lw+lX87It0FMaIBJDqQ==
X-Received: by 2002:a17:90a:4592:: with SMTP id v18mr8181027pjg.132.1624434604167;
        Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:afc8:33fb:90fb:4110])
        by smtp.gmail.com with ESMTPSA id m4sm4352625pjv.41.2021.06.23.00.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 00:50:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 0/2] Two mmc fixes for IDA and KASAN issues
Date:   Wed, 23 Jun 2021 00:50:00 -0700
Message-Id: <20210623075002.1746924-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a followup to a thread I sent a couple months ago[1]. They're only
marginally related to each other, but I have bundled them here into one
series to make it easier to track. Resending to restart the discussion.

Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sujit Kautkar <sujitka@chromium.org>
Cc: Zubin Mithra <zsm@chromium.org>

[1] https://lore.kernel.org/r/20210413003621.1403300-1-swboyd@chromium.org

Stephen Boyd (2):
  mmc: block: Use kref in place of struct mmc_blk_data::usage
  mmc: core: Don't allocate IDA for OF aliases

 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 drivers/mmc/core/host.c  | 20 ++++++++++----------
 2 files changed, 31 insertions(+), 24 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

