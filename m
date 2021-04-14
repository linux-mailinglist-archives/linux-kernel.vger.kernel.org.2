Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17E35FA88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbhDNSNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbhDNSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B24C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bx20so23681233edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6SQ1ybYGNpR6i4fr50V/uxRLezTq7QfUcLspczsFwM=;
        b=BPh/W2h09sfAbzXDVjDliOibJ6rwIUqN0B5SFn3EJIdLmX9uqG61r+XJvhMBSOPU5s
         G8zFb8m4CYmpINkN7bCqrdMuACfx2YZ/75NhJLW8abHHj4xUyci8tRJgTs6YIlYBOzbr
         h8SADpWUxODr78OE8z0OhPklEPvO4CszUPcpGxgkc0EZ7L4pE1AZPd2QYvWASJeubV7V
         zFcd5GirlLTP2z4oEHd93p2ZeDqy+1QQG6MwGldW72yuj6nCi7krvbVaomyIx0XwcVW1
         pwldw8u0DFZMtQMYQVnzQRRWlOad0BGlCna7sDpQOyG8aoOlfGGH+AreVfYsjXOUnai3
         QBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6SQ1ybYGNpR6i4fr50V/uxRLezTq7QfUcLspczsFwM=;
        b=ZoCVnPTqZyLDUiu7gDyyAoW6DNZbIW2z70nZ+mB7+qYSYOHn8D8qzpRWo38E09Q+x4
         a/yXKaSShpt12oBCVR8N5cGNZbRmin8Dj2+skMVpMX0iNgRq0PJIi5Z/T2E16D2/rRpI
         P375hyOnq9woJgmL2OCPzTt1rHBeNITVQZ3c7PBfCqKUznH+ClO11lYes01EjEJl3g9P
         s6r/iLO57N/ardYKIE+9sojhBlix+61U8u0bVt/457oJi6p0TriZUf6HnYeZbDK0P9AZ
         w9/pU52482HfM+hsy4z845o5FxWW8xKPZEsG+5896RVqijQPRo61MuXoPkgnSx8Hy1fl
         plIQ==
X-Gm-Message-State: AOAM53017yljoXo9w5b6MBK1WfWiBBBQ85wnemV48ZoO9QxEYkXmDJVN
        odh5z0y0anBCIHA4zWbhWp9Kog==
X-Google-Smtp-Source: ABdhPJygVibirgTJ1RiC2e4eJvM3HIYbtUFSnBlMnCCBZgdSfZVytcFRS5B/KEwIJ79Blm7CyncBqQ==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr204936edu.108.1618423923032;
        Wed, 14 Apr 2021 11:12:03 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 27/57] staging: vt6655: upc: Suppress set but not used warning in macro
Date:   Wed, 14 Apr 2021 19:10:59 +0100
Message-Id: <20210414181129.1628598-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is used in the function using the macro.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/vt6655/upc.h:45:16: warning: variable ‘byData’ set but not used [-Wunused-but-set-variable]

Cc: Forest Bond <forest@alittletooquiet.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/vt6655/upc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index e086ec6e77f73..8608693ae9c3e 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -42,7 +42,7 @@
 
 #define PCAvDelayByIO(uDelayUnit)				\
 do {								\
-	unsigned char byData;					\
+	unsigned char __maybe_unused byData;			\
 	unsigned long ii;					\
 								\
 	if (uDelayUnit <= 50) {					\
-- 
2.27.0

