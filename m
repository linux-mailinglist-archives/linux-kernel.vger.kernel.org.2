Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF16331FD32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBSQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBSQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:37:03 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09042C061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:36:21 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a22so23142587ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8gjkSXbyN+GwM8OVf0FOHVFNyFJ51dH9JSVHbOdelQ=;
        b=XJ1BlLOnpjEK9L1nPSVKong5qJF/14qvE7jBAD/vtPPETVCDCzjupANifjpL1Lhtqi
         LQJ3NcwUOXjPHWyHlvAuOpie4bueXx/Bl1lz4WhqfypwlcDTEYEdm9e3ebWcIpXBv9wY
         YgaDyyY3R8TrDcCeoYKQqpign40NoavYvkYltE0LHIq+pKJiZnJWhoaAWLeBJGlhJCnf
         KaESBoT0fBY3SZhmP3/pmubGj5zkKu/DtPzqjYqsgGToWgNVY/gTMczeMrKtyljSrvS1
         JI54qkXr6+KiXPG59lVdLE7RNo09/GOhmA3qiXrXzCZ+leElylz479FsKDHtAvYz8iJU
         CSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8gjkSXbyN+GwM8OVf0FOHVFNyFJ51dH9JSVHbOdelQ=;
        b=G56J5U2Hk7QCWdublYd9USyNbfhZ+CJkmF7WL3hA5iHmMv9Ha9hcZoCPdimD7LRj2M
         KTVpLh+rpHxuhBB4z+vt/fFunB04lwAPR+0PVTS5xUXRIXMIazA5kYUCE78i360eLN84
         GgjVbPLoi5tGEcEhBU7Kuhj0GIIQpTFpBXVpWwKjRvr8Ob396NPqMeycptaTCzkIH+Bo
         qX8RudAagYWvCVy0Q/xFlIJFr4/r+Edoh4dogsn/FMNvRE/SksGPwwIAojkbU00cYR89
         xzmpFvTXbKVrOre37mraqMHaHTI/2saZzcy75r+t4kRY54KqtcTZar8Z0AqLLIFL332S
         zVbw==
X-Gm-Message-State: AOAM532s0y05ZSoxoyg3/GcAcKhd+n769YnssSnvNiBtRWO2ASy55aS3
        HzxDod8+zTKewWCGwn3xI3U=
X-Google-Smtp-Source: ABdhPJxzK9YLgeZDUqoYrZKiABKGnpRnbNOzSr4yR06BgBUXtxzRU94rnc0LPmnK9w/QMoyO7+qWrQ==
X-Received: by 2002:a19:7d7:: with SMTP id 206mr5904459lfh.135.1613752579546;
        Fri, 19 Feb 2021 08:36:19 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id n14sm970877lfi.219.2021.02.19.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:36:19 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/02] staging: kpc2000: code style: fix alignment issues
Date:   Fri, 19 Feb 2021 19:34:20 +0300
Message-Id: <20210219163420.24930-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YC92OIgh6HTEexu4@kroah.com>
References: <YC92OIgh6HTEexu4@kroah.com>
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

