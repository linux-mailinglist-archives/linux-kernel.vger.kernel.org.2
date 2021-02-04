Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5556A30F1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhBDLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhBDLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D9C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so2974097wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gipN5H3JyGASQHPNrRrSjgiDn340aoFup6C6RtL10J0=;
        b=GKy/jC8shsYQTi1fR/pF2UkgIqyPlcGlKnclGVNETMvnhowrPblVoiWk9+LeYYs4GB
         FnvtDOLIKwsK18ocX1wEomU3+YEoTsftzO9t2enDt+PEDbMPycojH/YY232kQI8eSCzH
         WJvqLeq4R8g3gwm90IDdLJFNmOZzvrupdg+aOR7y62B3QuLaLXvOsLCAzJ3kAk/KWyp6
         Ud0Fq8XkYD5POx903d6zOCpxXfmvL/qmA0RKA7CFDEQHBIWe5gbw1xBJBfIqc3aZA+AV
         1OQlwb4xkg76BKtnz/TeqfDFqMup1clJouQ5xTEzHSEKBZgdGJeAUjxj5IiflkzRnJh1
         JqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gipN5H3JyGASQHPNrRrSjgiDn340aoFup6C6RtL10J0=;
        b=fjNbXzjWAucJymHjupZBxnIjx0py9FrZUc5x8rTb3UCsebPAaSCS4ORFbnGYDSiHoV
         wi+Nt3qnFRl+5asi77/OhcRSJX4un057x5x8SHFwzamgWVJruEqT2QtsXQ/d7du4qZtS
         9ZBi7NPgGFgqCEoWTtUR+5f9u6eabuBEIe81cHDaMsW/gzmz/uz2GdgflZLyhCwsmcW+
         MMYOhWOxY1Hb8Uelm+cvV00yxIvSjDZDhI4/x63KGH5M5pX8VvogVrITVoOlWc76XbV6
         wilKRjR0CjwSi21fFdGYDQYz0c80SHUkoY6RWYBbUKHKBj64no1/9oDGd+tDYarfmJJc
         E74Q==
X-Gm-Message-State: AOAM532np/tw+Av8d9jbBeNG4lhFihJdTEfeCKdmEf6+/60mStrnlvGI
        TxRT5SDDhqT99Yn4eM1raf2pbYA3hB0wqQ==
X-Google-Smtp-Source: ABdhPJx2hwmcLvyC+zMd2izO+NVfPDts/lbQ2wAdZhz0mk7pgq1qVNsO8X5x4bj0aL8tddGnhFUBeA==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr8570035wrq.226.1612437006136;
        Thu, 04 Feb 2021 03:10:06 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Takashi Iwai <tiwai@suse.de>, linux-crypto@vger.kernel.org
Subject: [PATCH 02/20] crypto: bcm: util: Repair a couple of documentation formatting issues
Date:   Thu,  4 Feb 2021 11:09:42 +0000
Message-Id: <20210204111000.2800436-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/bcm/util.c:136: warning: Function parameter or member 'from_nents' not described in 'spu_msg_sg_add'
 drivers/crypto/bcm/util.c:136: warning: Function parameter or member 'length' not described in 'spu_msg_sg_add'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/bcm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/bcm/util.c b/drivers/crypto/bcm/util.c
index c4669a96eaecf..d5d9cabea55aa 100644
--- a/drivers/crypto/bcm/util.c
+++ b/drivers/crypto/bcm/util.c
@@ -119,8 +119,8 @@ int spu_sg_count(struct scatterlist *sg_list, unsigned int skip, int nbytes)
  * @from_skip:   number of bytes to skip in from_sg. Non-zero when previous
  *		 request included part of the buffer in entry in from_sg.
  *		 Assumes from_skip < from_sg->length.
- * @from_nents   number of entries in from_sg
- * @length       number of bytes to copy. may reach this limit before exhausting
+ * @from_nents:  number of entries in from_sg
+ * @length:      number of bytes to copy. may reach this limit before exhausting
  *		 from_sg.
  *
  * Copies the entries themselves, not the data in the entries. Assumes to_sg has
-- 
2.25.1

