Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5D320B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBUPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:32:19 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42166 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBUPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:32:16 -0500
Received: by mail-pf1-f169.google.com with SMTP id w18so5006099pfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJwLUK5Y+uvXnv0u3F+27KKfrXN2CvtQs9gB7otpFhU=;
        b=YuPvvUUEWDmXhalPk4I1qyT7DMi0yANQrxgIM9QDUA+gYUrN0RMkVC8zlOAoCwNfD3
         mLQSH+8NdOzrK+//GVjWTnjcpLz1Ne+fb9H8rQ1pY+5j0rvpLz/ij4todettH52ZuRmo
         ZuJcYxXTrHc4TeC8nUnswJ7PnQAIJ984BswPE428NwEO80PzG+VVl++WN5UjwSdJdtmR
         8296GuB/pdcsPB6l5ZVwSarvIwAeXYxFfxVKZkSfogFngAVUKopjbl7jVuOqbpgVO71y
         FwBfUrCmKeccCs7ZrebtVglMtmXs9G3Wkrm6vxm6o2B8sCwLhF9S6YvDfNSBoiXmVzm9
         t3DA==
X-Gm-Message-State: AOAM53030hjyGqek0T4hPw0AyZhiUMEUjU2kDpSmmLctWtdFpG7aTWoP
        RDY8Y+EabQub6KVoZzNXFP4=
X-Google-Smtp-Source: ABdhPJyQfbpOGU2Lj4gfozHmRXJXahPKqV0HmUcLyQ7TPdrdAgEIhm6NIf+EIkFg7eE53tA9XWyOBA==
X-Received: by 2002:a65:5c44:: with SMTP id v4mr16063998pgr.362.1613921494284;
        Sun, 21 Feb 2021 07:31:34 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id b22sm75647pfo.23.2021.02.21.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 07:31:33 -0800 (PST)
Date:   Sun, 21 Feb 2021 21:01:28 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: wimax/i2400m: convert __le32 type to host
 byte-order
Message-ID: <87f93e091f736cb422f1d557fa5a2ac752f057a8.1613921277.git.mail@karthek.com>
References: <cover.1613921277.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613921277.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse type warning by converting __le32 types
to host byte-order types before comparison

Signed-off-by: karthik alapati <mail@karthek.com>
---
 drivers/staging/wimax/i2400m/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
index 92ea5c101..f09de1810 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -511,7 +511,7 @@ ssize_t __i2400m_bm_ack_verify(struct i2400m *i2400m, int opcode,
 			opcode, i2400m_brh_get_response(ack));
 		goto error_ack_failed;
 	}
-	if (ack_size < ack->data_size + sizeof(*ack)) {
+	if (ack_size < le32_to_cpu(ack->data_size) + sizeof(*ack)) {
 		dev_err(dev, "boot-mode cmd %d: SW BUG "
 			"driver provided only %zu bytes for %zu bytes "
 			"of data\n", opcode, ack_size,
-- 
2.30.1

