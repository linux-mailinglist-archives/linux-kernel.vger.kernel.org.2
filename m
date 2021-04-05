Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE0354141
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhDEKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhDEKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l13so8118518qtu.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=DLg4XTyaS91e+p/tUT8Qwr0hHxzftha50APdnRZp7XdvsmPRPqkolN8G29DJv30YQZ
         x0lTzdlKdUKy2egZ889l/fNG0sc0WEaFu3S401CeC7p2LXqJDT8sFECd+oAgXjlB0QlT
         /dLW/+R3jtD6Im/5hwqdnmWtM4QOPZSBaGIyOTZDpeVeiPjXA987qYaM7uEl4+MabNT9
         6AsFbhHp2oQGdl4KP+5CfD4L02kAO/JQftKt+iCV8AptuAd7P5r24gyvp9dnCmkI2F59
         BPmGFdpxpV5tOzZ7M4C8ik5gSOPkB21LarvvS2K+5XzapH2kpdVGh8OXSiP+6pxn9f2X
         Ii0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=jA5tQQB/gbHoahEvXTzEKubSGGnAJ9G003yV6kZBqIEJKy012n098o10+jiu1oXotE
         ZW4hM3ELN9mmKEXh0Wek8ibOk3CuDa3VG6BR+mLA2aCfKhP5STS7i9ksiCKnnwNwqZrr
         hbwY1j4kx2KrpdyojcXmO3llRriGbpJeCTuCtXRF5UcVJ7FGRUxbhe8w54gn8ApBAxn5
         iITQg00y+0D+C7ob1W3PFvFmD8wWZlj/+vr+EtPO/7Cy0bTj/0eM3koUFw9wvYk8gYX3
         Zf+03c8GhTkaJxpj8DN4KuR0MIuaCKvXr7Xnrek53ASedPJSwTLmd2hZaqlEeycxmZTT
         gj+w==
X-Gm-Message-State: AOAM532iB5p7XpUV7zqnV8xw75aKpJ9J6trx4dOcjBQ91Dc2BymqN5T7
        DTKoBS9MDnyNv1KmTjNAU8A=
X-Google-Smtp-Source: ABdhPJxCBAtYuCk3svSxxx+iZi46eAbo/PPPezWxJWKH+X6OxpXrPcx6CdahFeLQ/fvq5Q4ctUELQw==
X-Received: by 2002:a05:622a:174f:: with SMTP id l15mr21725984qtk.197.1617619766386;
        Mon, 05 Apr 2021 03:49:26 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:26 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 1/9] w1: ds2438: fixed a coding style issue after return
Date:   Mon,  5 Apr 2021 07:50:01 -0300
Message-Id: <20210405105009.420924-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an if statement and, if the function goes into it, it returns.
So, the next else is not required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..148921fb9702 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -154,11 +154,11 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
 		if ((status & mask) == value)
 			return 0;	/* already set as requested */
-		else {
-			/* changing bit */
-			status ^= mask;
-			perform_write = 1;
-		}
+
+		/* changing bit */
+		status ^= mask;
+		perform_write = 1;
+
 		break;
 	}
 
-- 
2.30.1

