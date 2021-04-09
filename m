Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04313592DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhDIDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhDIDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:15:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749FC061760;
        Thu,  8 Apr 2021 20:14:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g15so4555059qkl.4;
        Thu, 08 Apr 2021 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=F+k6Tm7w2WgimbEOzaCfJsaWGHpsmmwEdl4O1kvsXGMQeNKNh66qaSFc6/lF2oHjXf
         6iVkDtgXezl36AefZGXsU3c6ivkjURknA6b/K3b5jiYuIb+IFkUbPMqw7jiaao7BkFqE
         seI2nio4Q05SkimK1cUNuS5sXvgYGU78H04nNYb7JoyZCI0mRIbcz216Wjo7iSpfGfiI
         PePGTnr3bNC9g+Os7CW7O9S97w0P091eNvv7eNqlYaxGd0nNt4cGdMRn6/T8jZgeqaAT
         Rpn58z19cSSyxJNnHGyr2DhyPLQZys5psSEkaBuRgvjs6kUZCvV+NuyF46HRwum0vUu2
         SULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=qqFuN1Y6i+6V4oKMfEVwO+63Ctp/5KJtzozDD2MLebhBPWyWdwrcj/+0B2EGTYFQiA
         c9KVn/jP74fhuGaY7UjXzxU4ygul8EymGiJ4HUQkd4mhqBZm+1YoxjS2zs4boReCkXh+
         vEyHKkNaKBdTOC15+l90dqzO7GWcHNC0pbVEsXV/JNx/n5cXPPxcp8is+PfC7NEagjPZ
         EX1A1oV41R15B7eRRUN6ZTy29buadLr7ziXcAokkqqJBz6T8I9hY/jyuG5KgBUcc9Juf
         xKR0x5KdcP3sjZsQ8zkEE/E1Q2JqRRX6Vky7huq4L7WTqt3DDtGwCuK9yQAjTW0liZ05
         bfwA==
X-Gm-Message-State: AOAM531dhFcjjJBnYX+zApIbXeYQV7tXg2aBUvZN9BxSpdH8yM8yFwUg
        nKKaDOrfd/nS3c2AmSXg17M=
X-Google-Smtp-Source: ABdhPJwZU8FkTLhbGPM8CuL/Oz8M9THDfu0lriwGXPCDGU36jr4BylcGo9dDSOep4Ft0EFLY86VgdQ==
X-Received: by 2002:a37:5f04:: with SMTP id t4mr11607962qkb.440.1617938088979;
        Thu, 08 Apr 2021 20:14:48 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:48 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 1/6] w1: ds2438: fixed a coding style issue
Date:   Fri,  9 Apr 2021 00:15:28 -0300
Message-Id: <20210409031533.442123-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409031533.442123-1-sampaio.ime@gmail.com>
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

