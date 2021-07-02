Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E83BA15F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhGBNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhGBNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:42:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q18so18149244lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NoI9BTrBB2j37D3MNXSwVMTEwSv5M2czDJC0Zd1MVQU=;
        b=kIPiqSzOvGOz6+vds3ovZUM/np0UiY4usyIqfkwIruTbbiB7jfsb59JXiQvjBOtPG7
         AzpyvWEpq3Djr5Yw99qCRr57XT9ZMa7NCMpR2FGFZrldljoYSFp1jCpXGut/679U+xF0
         eEkjntEQ7xK5R8sZqdkN6AFpKayx8o8lEqK1u8Y//YLck63gs+iJlwnqBpFvuw5/Btny
         qMFC8MMIAH+2Adr5iOP1x8pPgsjCeeNGzvU/TZ3HZwSdBtavQbNlVJ/N5J6uS0Fe3CBI
         z9WONDRhmmi7gnhicE8IHWCDegzJ80MMxx79kaNUaB482viXRKR/fm6Aj6azJZJ3KIJk
         Xe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NoI9BTrBB2j37D3MNXSwVMTEwSv5M2czDJC0Zd1MVQU=;
        b=TCiXTzmUYzUSKlGf6R3NZtYCwg1fRU+9NmiM1oqNxGJVZJ8hH0U8Pl0iijkxMFCVg2
         +hUbmAO1bIgm8pnHop93Em3DCA5N2fwcXRhpH//9p4DgwqA0E9GzQi4qmuaPFDMDGG99
         L+7twNzxep3dKQfziXaJnBBF2c7QY67Ucz/WcIZv97hQktWgaJpqXVTqWdcaHITwsPaE
         O4T4bmWjwYvruaTWvxcfhFUu7ZZtRdkkWTWmWweQp9rzBQ6MSqZPx/FmdIgO+jB6X6xp
         6kXRvW9XY3im3B2akW+5BIueJDcYQR1YU/o1aBmf5f71YDynw+BlSm0wdG4p9JT3i0Ma
         NmRQ==
X-Gm-Message-State: AOAM531/RefnApTXQKb9CGQMrHnxBZwuLUQ7+miv5nfj+9rh9qLhuY2E
        oZGfzx4fE5DQQG8efEAKaqAxYQ==
X-Google-Smtp-Source: ABdhPJwJOqCe7efbM/lMcm+PNg0kMxyZmH1OrHYVCdAXAbQ8gwaiTDU8d7GiRNDai6Nn/8fCom5gPg==
X-Received: by 2002:ac2:42c1:: with SMTP id n1mr3931436lfl.270.1625233366311;
        Fri, 02 Jul 2021 06:42:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id u5sm277486lfg.268.2021.07.02.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:42:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
Date:   Fri,  2 Jul 2021 15:42:28 +0200
Message-Id: <20210702134229.357717-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __mmc_blk_ioctl_cmd() calls card_busy_detect() to verify that the
card's states moves back into transfer state, the polling with CMD13 is
done without any delays in between the commands being sent.

Rather than fixing card_busy_detect() in this regards, let's instead
convert into using the common mmc_poll_for_busy(), which also helps us to
avoid open-coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1b5576048cdb..0f9044cf3aab 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -599,7 +599,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
 		 */
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
+		err = mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, false,
+					MMC_BUSY_IO);
 	}
 
 	return err;
-- 
2.25.1

