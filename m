Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E654940F161
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbhIQEkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244554AbhIQEkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:40:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570FC061574;
        Thu, 16 Sep 2021 21:38:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j66so12235399oih.12;
        Thu, 16 Sep 2021 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7KFTL+p7igjq/k8y7omz9SspL1lbQhjHex875CwaiE=;
        b=LKW5CHMyzwREhUIOqz3m8oCq3NZhHFxWbIpPL9XBmZVx9Ou9fPZaqiemyqc/9gaOMS
         LBkT3RmBD4s7picg9ueYY4f/a8BRwooHlxRIckJniRwTmJ5TU+L5KaxJUOHvcB2G6HiR
         mIbOP5xPWODt93PyPHCTRdyZ64UNbCb+Bj1AWc1CrLuBHh69zKQN98IglfmjDPa/l4C0
         i7CSx5XdvhFEIsywDABFeywp4ygMYCRG9+DatH16lpn7le3R6eGIfi+m+2xPo8u1FxAT
         Dg7t1hP/OY6UxTQHGBTuzyzJaPczfXJzw0kJogfaneclFHAfragCQjPGhTxUw8h1wtAq
         p1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=L7KFTL+p7igjq/k8y7omz9SspL1lbQhjHex875CwaiE=;
        b=3I+dzGC8PDV1SOA9aPa8Gyn+c01yb9P550s8b0eBlfVIburKTF4l+CV7HBaGMfVIVf
         sUPwTboz3a4jfh7lYw3+lnGFkuobvOif098DrpUZqMOu+qCZqEQI7nOt0SmILytF0QFn
         gNtK9MBY0P9kSthF7kulinF810SJdrF9hK0/hcNkc0+SsRsGBQ7Hfn8UtiM3YcUetsSo
         o3EeKDM8tInilMzqyXI1JaIv0ThTEYYBocQfDD7Z62qEQ/F0RwlOo2w1rcXXR8fvT0Hc
         PPtCL7yKfNBdnuJPczhRKa4F/ukhcZxy2AffjZ+r/cPIU+ZvlCamjEVDQbEvnwLhRFxI
         fnmQ==
X-Gm-Message-State: AOAM53273fTpW2N1eYopYKnEZsuXpme8tH9XQCPr7axz38ydRwFB3Lu9
        tefQLMndwWTwiNJ12p6hBjg=
X-Google-Smtp-Source: ABdhPJx3q02M4dQh+noS3x7tSQIkod4nutRDzGdRzbh29WbMFJEOwdUGvQ8qNAY2MAWv1sFeG6cAIw==
X-Received: by 2002:aca:2305:: with SMTP id e5mr11999419oie.36.1631853524141;
        Thu, 16 Sep 2021 21:38:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm1148495oie.20.2021.09.16.21.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:38:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] csky: Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
Date:   Thu, 16 Sep 2021 21:38:36 -0700
Message-Id: <20210917043838.3514789-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917043838.3514789-1-linux@roeck-us.net>
References: <20210917043838.3514789-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling csky:allmodconfig with an upstream C compiler results
in the following error.

csky-linux-gcc: error:
	unrecognized command-line option '-mbacktrace';
	did you mean '-fbacktrace'?

Select ARCH_WANT_FRAME_POINTERS only if gcc supports it to
avoid the error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 9d4d898df76b..58ca3ef02bab 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,7 +8,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
-	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
+	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
 	select CLKSRC_MMIO
-- 
2.33.0

