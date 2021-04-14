Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAE35FA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352974AbhDNSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352532AbhDNSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC02C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v6so31526719ejo.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbAXazZwEPOa8QMUmxDI/WPc1uOvEQup3qCoBf+KKJs=;
        b=vPyh8mTPY9H0tHSkG1qu7FQQnOhKO7ZGdFNVM6cXvOG3v+QBzxkYVq4uNlFaJJT39h
         PDHK25ayBZqQebu44Bw+3RlbbTnrpzr7ym4a8gUmp/WTqgjnLFUeZvYecvoUep5O2REz
         fmDF6P459U0zuQ2UaV0QlKn/UXquzzFtjLYER0tKbaQvY6r0ZLOL5Ke1wtrFDD7fjc6i
         GA0lngqy0Q0+4sMCqNchlrgBRvI4XPpDKp+LQqp7dkTP8OCs5892hLN2y6B1ljOELYQ8
         MMUVSZXKVRERRn7XG7uSAxKYVSahrDnbeWuxmjUzSYFHo3ovVtYClk6IIn8ELzN7bd32
         T+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbAXazZwEPOa8QMUmxDI/WPc1uOvEQup3qCoBf+KKJs=;
        b=eheObN5y4kQinY+LchdxNqSw9lAteZmb7jf8ayRKilHbyL6b7jZsKThHt5H1OUNGSD
         WTcN/9AMC6wp68i6IE0ijSi0VkbyUxPe5FYq0haiK6Efwrvy/0EjyvUAanKGwvyIfrHe
         J0EOvl4sHia5b+xhXf5DBhvKUQ92q1mWJbq05w3Jr4m4mEzwBu8wWeMTJ7ja6t+k927Z
         cYb8hg+NUB/z0nEw4+pskWvJWMnwQq65LgPsLlXqbl+06X8VDDJ0XSGEu/DZa6gfCOlc
         HHNz50k/ODtSSNmoM184KTG//drVKYa7Nb/YAPBy7BV5kX3u5CaiyboUwzu6HBMUQpNV
         zZvg==
X-Gm-Message-State: AOAM531Lg4f69KRZ37Kjhp0wYh3xfE3f4P3K+bsBnrJLfbZyzfHw914j
        nsx1V1lUJAmBgpTr3YZVyKxk8m4QDfsoSg==
X-Google-Smtp-Source: ABdhPJzvkH3wkCA+A+Omoi/ffhJEH7y4cAUic+rqXF1Xb4VMZJWQIeS3ESYCgk5iPfHRzLzOqmD9WQ==
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr142839ejc.123.1618423942690;
        Wed, 14 Apr 2021 11:12:22 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 46/57] staging: rtl8723bs: hal: sdio_ops: Mark used 'err' as __maybe_unused and remove another
Date:   Wed, 14 Apr 2021 19:11:18 +0100
Message-Id: <20210414181129.1628598-47-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'err' is only used if debug is enabled.

Also remove 4 year old TODO.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/hal/sdio_ops.c: In function ‘sdio_read32’:
 drivers/staging/rtl8723bs/hal/sdio_ops.c:170:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/hal/sdio_ops.c: In function ‘sdio_read_mem’:
 drivers/staging/rtl8723bs/hal/sdio_ops.c:381:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 701f1abbd0f07..51d72262d11e4 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -160,7 +160,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 	u32 ftaddr;
 	u8 shift;
 	u32 val;
-	s32 err;
+	s32 __maybe_unused err;
 	__le32 le_tmp;
 
 	adapter = intfhdl->padapter;
@@ -360,10 +360,7 @@ static void sdio_read_mem(
 	u8 *rmem
 )
 {
-	s32 err;
-
-	err = sdio_readN(intfhdl, addr, cnt, rmem);
-	/* TODO: Report error is err not zero */
+	sdio_readN(intfhdl, addr, cnt, rmem);
 }
 
 static void sdio_write_mem(
-- 
2.27.0

