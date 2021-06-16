Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C488B3A8F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFPDrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:47:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08951C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2896415pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqYGlhIQk5yRXpBC3o0HV4QsHhx13VCShZ/FBwBh16U=;
        b=wOOLBu1owGaeoOnk0EqeXvQu/ISL3+RpPT4WmD1eaiaHjZA3WJhUdvPLzY7nhrB7n/
         5vi/ZOVGUpHJj4zttHxvLMJM03IesJXpDUAtElwIKZNyyeiG45KCZsu10w5fQobacAZH
         fg+93LAIzS8qwYwC8QkQKQf7oEjyo1LDBLilqNqksHc3UQsxWzPajTilBH2gPTbVSnTl
         rpHzyOTuoEhHE2hhGhAkNa6Hyepu8+gDvEgG81QdE+2FKQgqs6Vb6vNHBOy1kqIDxKeX
         6z+RWun6fclvCE6tJx7pHrkiR/R2CbaZhPFIoxe35GTeCc/XuzD25Px22yGBDJWPEG1J
         ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqYGlhIQk5yRXpBC3o0HV4QsHhx13VCShZ/FBwBh16U=;
        b=AnInqK7C3wtyP2rJy1NRRZ0oss8Y+UHDQEmX/Yrxrx9d1Tdz5JmpiWi1/3x8sr1Gg4
         QBgxe1Z1efKQ3cwW5My20joxbAIKmTJIM3fX0EUpRW8SdFktAUuSLZfsf1arkg2MCFky
         muiSyWzYUrO7U5y9zN67vlWi5DuHvAcbX53EhRks40tYfwdpjO+Z6YQm4FAhG6jxoosy
         xtoHx+yTZhMbS+JL4LSRxcghZbo/oL6EzadviVn8IebIYqKeD3C0Cw80B1YSUyQAwwii
         lo+834Es08Gy7PNOX6QZzz/0Nlp6GEONs3bTZ/h0qrsAwaBVNQd06FTKPRkHnWYyEZmM
         38lw==
X-Gm-Message-State: AOAM532zYMtW4d8kd2R12uXvTsnJeBIUS86kns5m3lQDwaSTLJ3EH+/U
        BvH9mpQiCW0tcdg2J/k1iDsg2wE7qyCVshlm
X-Google-Smtp-Source: ABdhPJz8VEQ2aZMTMmpFocqTt+3Ma2RRajK22vwePHVpHAydhNpB/opPpucv3i/fBn/KJV5lQi+twg==
X-Received: by 2002:a17:90a:ce87:: with SMTP id g7mr8513135pju.189.1623815107488;
        Tue, 15 Jun 2021 20:45:07 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id s4sm528925pjn.31.2021.06.15.20.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 20:45:06 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: sy7636a: Add terminating entry for platform_device_id table
Date:   Wed, 16 Jun 2021 11:44:56 +0800
Message-Id: <20210616034458.3499522-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sy7636a-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index c384c2b6ac46..54ab1be1001e 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -110,6 +110,7 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 
 static const struct platform_device_id sy7636a_regulator_id_table[] = {
 	{ "sy7636a-regulator", },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
 
-- 
2.25.1

