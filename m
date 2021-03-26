Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07C34AB64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:22:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CAFC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:22:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt15so8954311ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0JHGv3ho6BSohKh3PoMnQZqn5hVwFUbvNhQ/6Recs=;
        b=dYpkQAe18RGiYJlTmxxSgDsrCg6gvQUV6TdAWeLFgqn0EUXNJMq2RZbvndVWYIhWfL
         j4f8ZPECSqALeiF03UREb9YDxqJlFAtaZHIll3LyINbqXRaO08A3RUADlY2X9lAKpyNa
         KZv7bHMkPQaB6kM2Oh+twy4ZbYfK8qbe32HLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0JHGv3ho6BSohKh3PoMnQZqn5hVwFUbvNhQ/6Recs=;
        b=Vhtp/WREtMIQza4J8lLqYEZKYFp7gNdgf1TBWhvLX/slkCSExam8SlAI1nw8J1mpdS
         REi/7ceQ85TZ14IOjtX5vQWRTAXg0boLGYMFTnqommbBsgCShe1UfrFVcXVJSpfz1WVs
         ppHHzjN6wBV0+o9x2u9a82eII/HTPZBP1pdLzsqZ46HZejhbQ7Bl4GfNC4IPXzX1XObM
         88TAFwfK+iRlBoAnAQTTOPd4CaD9eVqBJ8RHwnPLPllJfZ7irxsmNnoA+m+Nu+bzEa8m
         cCmpDOWBha3lgBRBkROwB/zvBzQpDi8yD+/uPDvQfgvDRLWVG0qFHWROf31DOjkXcDcD
         meZg==
X-Gm-Message-State: AOAM531EWXizt5oyU96bui2FKoO+CPr61DEszXVQjYHCEdP8QptLxcA+
        63bbhQx3jSW8gcJaCXzDgSEfGg==
X-Google-Smtp-Source: ABdhPJyAJR3guB/wT0+lzW8xqgVDCKt8iB6TLrjazfM8CCam3EqkyHsK5Kp8aNQYL7a1P50p211AiQ==
X-Received: by 2002:a17:907:d1b:: with SMTP id gn27mr15852406ejc.227.1616772177256;
        Fri, 26 Mar 2021 08:22:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id d19sm4392293edr.45.2021.03.26.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:22:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: remove stray nul byte in apb_log_enable_read output
Date:   Fri, 26 Mar 2021 16:22:54 +0100
Message-Id: <20210326152254.733066-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including a nul byte in the otherwise human-readable ascii output
from this debugfs file is probably not intended.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/greybus/es2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 48ad154df3a7..86a7fbc7fe13 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -1171,7 +1171,7 @@ static ssize_t apb_log_enable_read(struct file *f, char __user *buf,
 	char tmp_buf[3];
 
 	sprintf(tmp_buf, "%d\n", enable);
-	return simple_read_from_buffer(buf, count, ppos, tmp_buf, 3);
+	return simple_read_from_buffer(buf, count, ppos, tmp_buf, 2);
 }
 
 static ssize_t apb_log_enable_write(struct file *f, const char __user *buf,
-- 
2.29.2

