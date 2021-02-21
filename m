Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D690320A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBUNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBUNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:25:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC4C06178A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:24:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r23so48389059ljh.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Apv9vP6L2bjpyU9CPQaFB9hI3iy52QU4Q6xqwVOlSNA=;
        b=iGxewxx77SiEf7GCNwQHgbwgvBLk17qLwQFm5EhOV+1EWAH7UC6ZQ2RJm5m+mTt//k
         an7zAHScrCNRCBl2yfzg9DU6+0ih3o+tou+u6hZ7lNd2zOwyPehgpxxLRPHPl5g6IS1q
         BRg49+CtlkaL2zypgTfwIGjN6+pJtkmE6sOb2MB2g11EayrbHrobGkgFKGs+7Ywhqi8j
         YOVaJGnoWGyMLnj2wQZEpJA+eLEzaXG+HzNhzU3+6F3iTyZJjizzc/z2isfcONsHM56l
         pUjZ7mI6bpUI/WrizERu27irLLJVf0FyB6Tk6e3pslgF9HOn7QRSk7igXgclVXZSuC+E
         MdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Apv9vP6L2bjpyU9CPQaFB9hI3iy52QU4Q6xqwVOlSNA=;
        b=m6rQ8Tvqx9DN+KGxZ4400flKeSpVOmtb9JcVfBilCSwuYIezPlFC0mzfTSZLyUm9iu
         iA3NaiLkxCGpgWb1kmfxHNVOB91Nkbjlx3QtpoVXyu0gCF6uCtxXZrWaxV74hc2njqXe
         9sZKG25ZAezW5uquLvi9NRzAzK8sqSUD9P3mB+Wg0dAqVS8efe/mH2/8UctCfBu0MoVK
         zhzMjZqzmLorQ0CtxxBUn0AMb/r+Zm6pqAQlZE1R7ane5xDx2mlNrktSt6KTc6REVdxX
         1XIavrR0daFX+nNtY1nHa2ZlYwwPGKjiAIP8/j/gzpwhxXvXUOwnbVEHgDFwy5tEGR0E
         0Jnw==
X-Gm-Message-State: AOAM531ntXwkzJz129fS+A4CK9DxzY8Cio0LMB+NEjG1asTDnV9bNyje
        k/1mSnwKhZgvMzm0z14Po4c=
X-Google-Smtp-Source: ABdhPJxDh0/rAISuZnjVHOquntKXWyj9vpjzAACnhzAGquM0BPf+y+ajcyFALz6Rp4x66POW9JdYLw==
X-Received: by 2002:a2e:b702:: with SMTP id j2mr11174662ljo.300.1613913880503;
        Sun, 21 Feb 2021 05:24:40 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id s10sm1684637ljo.115.2021.02.21.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 05:24:40 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/02] staging: kpc2000: code style: fix line length issue
Date:   Sun, 21 Feb 2021 16:22:46 +0300
Message-Id: <20210221132246.1154-2-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210221132246.1154-1-knv418@gmail.com>
References: <YDJaHNsT9zta2up2@kroah.com>
 <20210221132246.1154-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: line length of 124 exceeds 100 columns

in file kpc2000_i2c.c

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

Additionally some style warnings remain valid here and could be fixed by
another patch.

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>
v3: Splitted patch in two parts, as suggested by Greg KH <gregkh@linuxfoundation.org>
v4: Changed patch subject line, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/kpc2000/kpc2000_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 25bb5c97dd21..68f5ec000365 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -200,7 +200,9 @@ static int i801_check_post(struct kpc_i2c *priv, int status, int timeout)
 		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status)
-			dev_warn(&priv->adapter.dev, "Failed clearing status flags at end of transaction (%02x)\n", status);
+			dev_warn(&priv->adapter.dev,
+				 "Failed clearing status flags at end of transaction (%02x)\n",
+				 status);
 	}
 
 	return result;
-- 
2.30.1

