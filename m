Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AED33EE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCQKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhCQKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:09:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA11C06174A;
        Wed, 17 Mar 2021 03:09:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q9so1076457qvm.6;
        Wed, 17 Mar 2021 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VDJYRlDO5LH/DCrDo0YeGF2d0vdBASCM6MaReKqK50=;
        b=g3hb7f5l45vzqS56JuVCvtBcF0rvd+njYw17q+WQYjk1h7iLv6FEXzhzdAIS37wJbb
         RgfjIRNWGWl8i9ipZgiJpsiuAedCU48323IHK09ZCD2/Kenhn7cmoFrZU2sO7dI+CLrM
         mA3kBSPLKGYl63UOd+oJYJAIQcEhPIPHyk+CyzJjITEGU+zR0AQAoaFom/tJmP324HGo
         2MTlQxz/985R9rg/RksRu8YEZ9nG1WND4AscQj0B4nilDiJJLtSt+DTz/fYDFTTAsasr
         00bSU2ct0E5PdZeWSg5fHyD7X/yH7+xKRqAEXorjJD+fud4ILpNjp4tixPRZc5Jz4/t7
         Vs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VDJYRlDO5LH/DCrDo0YeGF2d0vdBASCM6MaReKqK50=;
        b=nAQ2/YNg58/09x49xtdbbJjuBwrrrjXv8idaVCPpRR5GbCnKOuCzf2xmFg70ckBv06
         3ELc7gQgcfF5Naeen+BZ41LUrSVfn55Nxzcl6Vqchv2qnDDyTsWRWuY8+MEtvYSxKtDq
         SR1Y83Ul69lEfSpEHKNY6CYsU3zaSKJ6m1UBLupekNAnzdWyqBos+0PUW9hhgPig0ryg
         4eEboliO2qHJVrf2fGrrT802wD+AyNypYKoH27JTDaX8vXyGia8eCqB4IMdwSGsFf12r
         hAUxh+eAqLPDCBPiMnOce1TT13HwnyzB00yvgcIlk9WFKmnJGeIqUdFAlFmedghw33IW
         w+7Q==
X-Gm-Message-State: AOAM532LClQoq5aGOTBR4FrGdZsov7+ChjfmwcZd7MU7y28epYY2RryW
        OdB1kQRS7GEkULog9sZLBz4=
X-Google-Smtp-Source: ABdhPJyWeb9GtWjaFYS7TNqDVph5ukB9x61rk98v6qnntbKqtnQ9oG9MWKOkn2ZUimgyYKb79bzfrg==
X-Received: by 2002:a0c:f946:: with SMTP id i6mr4565757qvo.40.1615975740168;
        Wed, 17 Mar 2021 03:09:00 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id i9sm17702054qko.69.2021.03.17.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:08:59 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] devicetree: bindings: clock: Minor typo fix in the file armada3700-tbg-clock.txt
Date:   Wed, 17 Mar 2021 15:38:40 +0530
Message-Id: <20210317100840.2449462-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/provde/provide/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 .../devicetree/bindings/clock/armada3700-tbg-clock.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
index 0ba1d83ff363..ed1df32c577a 100644
--- a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
+++ b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
@@ -1,6 +1,6 @@
 * Time Base Generator Clock bindings for Marvell Armada 37xx SoCs

-Marvell Armada 37xx SoCs provde Time Base Generator clocks which are
+Marvell Armada 37xx SoCs provide Time Base Generator clocks which are
 used as parent clocks for the peripheral clocks.

 The TBG clock consumer should specify the desired clock by having the
--
2.30.2

