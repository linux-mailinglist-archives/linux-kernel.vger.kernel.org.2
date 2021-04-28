Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0B36D73C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhD1M12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhD1M11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:27:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93614C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so62792401wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9vJ8MVP6j87QpSAeKDLXQXVxBj32ZGZbJSSBO9KR4k=;
        b=U9f8f1sMIE1pphhlzVUVKvVnrpByG1WlCslO+nr7TxtyVGECQdHCGsftxi8PJsWqcx
         u4rHcfo3PlxDAzCb038jecFAXiMEw8AvZv/xigLejkM4ucxeNJkSTbHCELjFm77FLGcS
         g4VM9U6t24JQyPq2V7kV737Rs8+Mse5R2oUFNfZghUoiQpKq1JZdHCT4Qta5vUgUKIOM
         PLnJc9RiCXrtHjmr2A8xJtwk4Bk3OkDcrDIyFME0K5QIhpMilUYsTviLuwHB4u71E18x
         mAopOWsc4OZ7OsC0BZutcg0ctRrSmzuLnWTAdUs7VNU2BmbCEwG19q+NVDnQAekZ8RxY
         ZJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9vJ8MVP6j87QpSAeKDLXQXVxBj32ZGZbJSSBO9KR4k=;
        b=DGBxrr85mxfhJpdhjbbkv9S9KlXqRZOfrYAiZegPexu5e8KY5TChrQYexaKHouZPUd
         qXX5hBJpRx6/Mt78s02oCKq/m/JDvPLTF/7MLAi/S+MxADkG+4ByLWOlsT7eoBqr0d5c
         lBKYKcYESOeUy6PuQTCxet4kPDN9UDIyuUIWRi0zCH2BA+uE8E5mKaN6zW7vkzukpTvC
         CxJGt4pdfovxcnPZOKU+RY3e0cn57M/ZbaMOOfzZgcYjv2Z4/T1YdcJSr3vVVY1MvJYg
         2w1yX8UKKWphQDrj4J1seuutV58T5qr6ddgfjwCeRxAOe3CJlgPAV6ElmyguQSQ1g95H
         g6Bw==
X-Gm-Message-State: AOAM531mtDmnqgyGBXSRzDNDbI5bf7xWZoTwVyr0rzHhdmF/zoJpjP/q
        gxkSl7l5YoAZ3YbIzMSorS1QtNul3qAxg21q
X-Google-Smtp-Source: ABdhPJyCLWhozrwOIpUv2gOjcCW05z9TPA1l9lMzWJazYXUKxSajxGK6YCT2I749kzuUnsrxcHw4nQ==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr35564902wrd.126.1619612801356;
        Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 6sm7872021wmg.9.2021.04.28.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/2] ASoC: Revert clk_hw_get_clk() cleanup
Date:   Wed, 28 Apr 2021 14:26:30 +0200
Message-Id: <20210428122632.46244-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is problem with clk_hw_get_hw(). Using it pins the clock provider to
itself, making it impossible to remove the related module.

Revert the two commits using this function until this gets sorted out.

Jerome Brunet (2):
  ASoC: stm32: do not request a new clock consummer reference
  ASoC: da7219: do not request a new clock consummer reference

 sound/soc/codecs/da7219.c     | 5 +----
 sound/soc/stm/stm32_sai_sub.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.31.1

