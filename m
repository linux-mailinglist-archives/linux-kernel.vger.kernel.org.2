Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDF3D4AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGYAjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 20:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGYAjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 20:39:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFE3C061757
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 18:19:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id m11so4469307qtx.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oNvp3EMT776UNg0e/cq8UZr4kbEn0tuaztssW5/QDiM=;
        b=MTR7om8AmG/nZyqR7FnqFZ1mA7uDwv0FmQFUi7bS2UM/FjDhLJpQmJp6la1+LQWopS
         XZUQB6iGmLbY1eLfzOAqkW+LA8tpt2PnB8hUE/uuKQphfjmGmWgBNkBtHGtb0UlmVdbB
         /dAn5NCZitt4ArwVxCFnrYtVbD1y8hPfWp1OjDTlN63e0ZOrtf724CWfwHt1CfO8BbwO
         JlPloAeKqkCtLNiKkmzQ+itC+mO8WaNWc9xISRoxorIOzaTq2c1pl7OwGtbZhDD6bY/J
         ULmWucfp/HGhbZOHH4f808QjBaWq+m7x7pQyxlIRGnpdYVNSbXD37RwAXGyaXbE/Ho68
         6bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oNvp3EMT776UNg0e/cq8UZr4kbEn0tuaztssW5/QDiM=;
        b=bXiF3Pmy8Jlfw/WSxplB8dZLQMGButQCp5SDJXFi15SIgvstrYGT1MbB+UaCdSH5ER
         pUA1fBF8dHMbOmHvLHniI9mPBvPRH0ekPbphuELAU0A1/XxkLWAa10M5ISTgRLd3M6nJ
         PNDNqiKTLR8BRqvnWfU8k5JE1zVg9ionXfeDZ8GZ3uLMKT7AW3wmzgXVLucDi+fYw038
         vtBp/QWRDk08ADkyf3qO7K0UZZ0r/RTscy+HyMYIokvOdgSGRvy1sW1J3uNc5zN5IA5L
         bxwgABxCftvv48SM1EitIKjtmW1zPvoSirCWvNMDFJiDVHUFTf9y4iYJn8lp5rU6k487
         0+zg==
X-Gm-Message-State: AOAM533qXBsMkeuCFv/iMBQ2gNrJBwHie/CQn9XkmjezcpWqNyzR0Gm0
        1XJvoPiZaus4aTn7mizghChgKIZGtAch+waoD1s=
X-Google-Smtp-Source: ABdhPJyzUw1jc+bdHbLl3Qmnt+mBanCkJWiWDVbw6rmjVWeaEosvP76i1vBUIzbCkC7A5i2/02TQa1d2HHFRZecVZ/s=
X-Received: by 2002:ac8:43ca:: with SMTP id w10mr9765436qtn.286.1627175972758;
 Sat, 24 Jul 2021 18:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 25 Jul 2021 09:19:06 +0800
Message-ID: <CAGWkznFKg_ONZvkBJUpON=fWwH+rgktCbNOD4rApuiN78D5f9Q@mail.gmail.com>
Subject: [Resend PATCH] driver: zram: fix wrong counting on pages_store
To:     Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] driver: zram: fix wrong counting on pages_store
Date: Tue, 20 Jul 2021 14:47:38 +0800
Message-Id: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It makes the statistic confused when counting pages_store in during writeback.
pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
responsible for writeback things.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/zram/zram_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deec..6bdaa9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
  zram_set_flag(zram, index, ZRAM_WB);
  zram_set_element(zram, index, blk_idx);
  blk_idx = 0;
- atomic64_inc(&zram->stats.pages_stored);
  spin_lock(&zram->wb_limit_lock);
  if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
  zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-- 
1.9.1
