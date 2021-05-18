Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158FC38790E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349332AbhERMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbhERMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:42:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83587C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:41:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j14so8324079wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eI4NCY1wQwQq8OfRG+T0AfeGqGVQTSTyL0bsuhMZB8=;
        b=yu5pawqC8M2REqbBEFuwQZL8cBrGJyxAieUo13G6RU8vAl1SoLrla5oPrYV0mChnkx
         dascTGzxh7OrTU1IeB3GqPqHrA0q662WPAiiJyxfJ80/a67A0K54S78j41h+gualFQD+
         vsJFynoIAGViRx5tkMS8n87BVLJOO8mMR8bAqPXqY+253iD7WNE5EcwpQ3oFVUCf5fma
         +ikjj8YZsqSxvveVO7bSyOnpxfpjIVqfSXK+3BDuRwHmgndy0sDFkg7Y6J+TlAUT2Rv6
         HYTRlHyymmI4qIc0q+9yREz5t62hGCnkPb8pQqffrFDu9HX2R34FeAXz3/udPF4Xmeeq
         dqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eI4NCY1wQwQq8OfRG+T0AfeGqGVQTSTyL0bsuhMZB8=;
        b=hfqWhwcS8U+iNFpG/v/8DHj8rFQxrKjyQyjVWHSjHd6fwTuHdlOOCU0LdYMKykcbce
         V6EDig2O0tAZfds0nOHZOsjG/AjJv6D7gJaZMDPoaMn6bAGzIulQv/GB0xk0TARpXOnL
         IOvwan+PSNVab/6IKTZoIE/+tvndPtqqOlLXG4EoIEuFTX/Oc6mT3cLpL8J53c0tz3bz
         +IzzEW7TQbfP9h33ba93eQR5eLOHnrWVNKBg3Wl8YEfQdHYkgEjpRIkJvJKhBrr3a3lN
         grso2S+sCnePU3G8Ut+k3hKLYHuPIUXdkq6tFt9Jmazqqw8PYwOwkiD82kABZKOOGesS
         rqlA==
X-Gm-Message-State: AOAM533B3OoeFojiUG/mr5eyKs2RQl7ZZLUGannb7zmZ8oFa4E3ZvXZG
        qR222cKQINPnzWGPkNRqgbc9Aw==
X-Google-Smtp-Source: ABdhPJxZX83kJ5tUhAZjMNRQvqz0QsKGh6CTOjOc/hTJv/kQUreJ7t63expdHC0sS5c3Gneo8ypwzQ==
X-Received: by 2002:adf:e781:: with SMTP id n1mr6624991wrm.136.1621341683298;
        Tue, 18 May 2021 05:41:23 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z3sm1677239wrq.42.2021.05.18.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:41:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/5] staging: media: zoran: fix kzalloc style
Date:   Tue, 18 May 2021 12:41:12 +0000
Message-Id: <20210518124113.1823055-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518124113.1823055-1-clabbe@baylibre.com>
References: <20210518124113.1823055-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer kzalloc(sizeof(*prt)...) over kzalloc(sizeof(struct.../

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zr36016.c | 2 +-
 drivers/staging/media/zoran/zr36050.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 82702a13b05f..9b350a885879 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -361,7 +361,7 @@ static int zr36016_setup(struct videocodec *codec)
 		return -ENOSPC;
 	}
 	//mem structure init
-	ptr = kzalloc(sizeof(struct zr36016), GFP_KERNEL);
+	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	codec->data = ptr;
 	if (!ptr)
 		return -ENOMEM;
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index a78862852a47..8bb101fa18bc 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -754,7 +754,7 @@ static int zr36050_setup(struct videocodec *codec)
 		return -ENOSPC;
 	}
 	//mem structure init
-	ptr = kzalloc(sizeof(struct zr36050), GFP_KERNEL);
+	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	codec->data = ptr;
 	if (!ptr)
 		return -ENOMEM;
-- 
2.26.3

