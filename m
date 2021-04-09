Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFF359289
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDIDJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhDIDJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237EC061760;
        Thu,  8 Apr 2021 20:09:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id i19so3196780qtv.7;
        Thu, 08 Apr 2021 20:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=Nk6+BDnrKOgPxsKcwGKY1VraBigfES4G5UXhsKZCuvJamXETMwEWG+FarHyzlOGwlq
         19x557oBadykQw+RCFB6ZSgbfuXY85ub60JV5gWQRESPrran2SU3GkRKj3DcQUuIOiTZ
         fb9p1nbWhQSGdZhGaLxvVly+qHmJyJHVBV9UbGjDY+5/JIkSRpYPvGWuwaTKsUjuxvzV
         xxhYxptQO9nqKMgp8lGeeHkJ+9EKWQuecEzbpYusXJ+w2YK3OFdqtXZnc2S8qI+vwk2F
         gltXX8NkaiIenyXi3i/Nz8qZ/Lex94pdj34HRDXPQYqE1mYieLfdBmwM0EvQ1FE02MjC
         hJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=haDuXEFmAI06gjM9BWabilv+WE3Gw//rgZ/E4tTyY0RenMHfrriasXAa3fQ6LBVYhH
         Z6s0QSTUKJkxw/UCFQJyBIJwPrTJbZBKjQ+dwYaWLgdT5xJF4zHjVfPpUkucWV4RzEni
         fO9NHPXtNNYcNZy7YDRQ0NU6syUAnjy7Bv77FQseUn2+pXeVcKTsOMOOxle3mWyRm8hU
         WoZjVtA5hTFomvePV/UR0Y1nKf/kfvoITzahL/KDgBUEHHdZUFIFNmjZTm7JvBIyo/3A
         sTvijThsAGj0Fs0tJeSkfMzvZzhr0YOs3fl+0sf4o9I59EgBWxHumso3uB0fS88NC3hw
         dAZw==
X-Gm-Message-State: AOAM5307y1tOOCkZ6v0qzN6hvdc/AbP306tC6tzzuMVJfVZ/LODYR34N
        1a39bYWgSpVYiqbkfb00XJQ=
X-Google-Smtp-Source: ABdhPJyVkaelSgsMTHoa9PzTPLHpywVCMJZYgV8nf/3u423lgaBymmNLiNDRNLlYcI2S9kZLLNo5jw==
X-Received: by 2002:ac8:6e85:: with SMTP id c5mr10347181qtv.299.1617937739462;
        Thu, 08 Apr 2021 20:08:59 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id c5sm925408qkl.21.2021.04.08.20.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:08:59 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v5 1/6] w1: ds2438: fixed a coding style issue
Date:   Fri,  9 Apr 2021 00:09:37 -0300
Message-Id: <20210409030942.441830-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409030942.441830-1-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210409030942.441830-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an if statement and, if the function goes into it, it returns. So,
the next else is not required.

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

