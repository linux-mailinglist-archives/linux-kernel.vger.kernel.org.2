Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD133EB51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCQIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhCQIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:21:08 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1620C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:21:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n24so7877996qkh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pKHnvJF8GKWqxZYX1hN/UxcWN7XcmcInbyUM1lbcj0=;
        b=TqDnxtX7iDH0paPGGkFHA51US+WQvkQDByiaGjbylpTY2gQqITJEsY75EzXKW+HAdx
         WBayuy0MqmAS5gRJHbD+ytZHHCwp6U7D9h3SMGJfTUyBqksSeyVIaxEshYuDfuiZ4hIA
         Oaa6tMR/o3niG5iXAmMAUSU4yLitE4mm2kTSjd6Ib2ZIQUw+p47cy9cQCLyZmXVwmiIf
         bPv5iNadkfMwmgjljvxyzyRYieGXHPI9n4YceIaksSzh6HZIf7MBMyekJ1qDq/L+9vJP
         nQ9JwFSkGXN5zZV37rNO4PxvRRUYHwqDh9rTboT6N5DY4DfJJiscgMDk1kONHAvnO1oG
         CXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pKHnvJF8GKWqxZYX1hN/UxcWN7XcmcInbyUM1lbcj0=;
        b=eaIEOlIgS5OsdAfagYFXMwKONpRj0nyalU/Oly7XzX2VCbsok1TU8WaNE0FFChTq2l
         iukUr+vbs1hQ/vbka/HzOMTfkAnwWPABetRx/0Q1nSoEMNAjOW2arplIUUiE6QCHmIpU
         8y3ji8T1udA2gYZ9U3zfyGjzFq55oLebtT65vwrYveV3ZPvULwNnIif/5DHnqMyhKjnb
         wvsGt3Ljxx1ujQbMU715iws7QrS4zesyXbfNHPD3CaIkCUgS/a6ymLX9VAf2CtHkAlsc
         FEXqIQEvyf7LOZElwdmhowXAP2WTTOP7K3aB2rtn5/IIJoABJ6+GMDbcgEWQYKTUX3np
         9c6Q==
X-Gm-Message-State: AOAM533NoU2hicsxMyCbdawO0P4b3FkppmLayb4m+umwQn/gBpVhZ0Xf
        3tHW3yvnVSlmOqel9K3TQuc=
X-Google-Smtp-Source: ABdhPJwW5k2v1wp4ueAZtzhESlZaksiEMNAkMs4VK1ezINAJtD2Uq7zGgrB8paQT22yJxl7GjpDNYw==
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr3497320qku.427.1615969268021;
        Wed, 17 Mar 2021 01:21:08 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id g74sm17121063qke.3.2021.03.17.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:21:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     peter.ujfalusi@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] sound: soc: ti: Fix a typo in the file ams-delta.c
Date:   Wed, 17 Mar 2021 13:50:42 +0530
Message-Id: <20210317082042.3670745-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/functonality/functionality/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/ti/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 57feb473a579..31462587f922 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -408,7 +408,7 @@ static struct tty_ldisc_ops cx81801_ops = {

 /*
  * Even if not very useful, the sound card can still work without any of the
- * above functonality activated.  You can still control its audio input/output
+ * above functionality activated.  You can still control its audio input/output
  * constellation and speakerphone gain from userspace by issuing AT commands
  * over the modem port.
  */
--
2.30.2

