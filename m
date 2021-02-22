Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178F8321B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBVPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhBVPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:14:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC3C061356
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so7812386wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkOt0yrBVyRKH79yBKw6bfM0jQaRrACpcMjpjEsTbCk=;
        b=XovTNWHwTCos9xzXipmutbAdCB13MpWujMUaUW7i4hXpx6rYXFXRPIZ8/iNIwrIi2R
         IbP55z5TmCskc2vHnE7UiDvlds9Z4mcKkR0XlN2D3QfmOmA+nY0FgXuDfsvASdnr3ug3
         czItvGV4svJ/yme+wrTkvACH9L18hK0r1/zHtY+6xV+8xbuoGUGOBpls8YgfkWLuxWBa
         91YJKDhrgBm2P2OxXOxoUunNoOsDqTJcdQI2B7Chr/RrYqxeCm3jBUh0z5PE43xzj+Fs
         tWiylFYaUFkWZvLYXuEpybk/gQzm7sudrmZpNp3/2HLP7goAXFs5HwUHuZEsY0S7zSKy
         ZGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkOt0yrBVyRKH79yBKw6bfM0jQaRrACpcMjpjEsTbCk=;
        b=RmDMWEe7ztG6FV/PBG2vZQNoBLxEDiCvaBz0sUSbWEWqO3DoQlVvwYwJx5xvfcMB8U
         SbbdtIodC1diXGzV0GQp9WwmeJqH8JBqcnNZRZ7wVuLps9MFoFAmPG4/lp6kjvLt2gLU
         v/hneWbcdj7NPFL0TAy5eaf3TB29qSUwqq2n2MTbLdrh8uorH5/7qKXtBlA3wSyjSPzH
         jvhqfY9sad9VniF+V867OOsIOI9IKQxDWlrxySlN4iDA2EkrQQz/SHoLb/j9RLGxRIQL
         Qu20yZrihEdGj7cZGGyVsr1Eqsw44RKUigaFv+os+4DtacXo1AOqTEfaI8Fj+JBKeDll
         29Bw==
X-Gm-Message-State: AOAM530TygQz6Qkc3w+BcT0BkPjxOPRkfkgBSvAnqimqk3gjSWZhWKiq
        xaZBrj9v6jIn2h1jf+lqOxF8u5JdLtvYS1u8v4s=
X-Google-Smtp-Source: ABdhPJzqndAalbnZM20kjoLXRdtC8IozfrJChCqLGB5rdddPCSw4ZQcEBtySznNjVccHSoocrtBBLg==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr1010025wrc.122.1614006773420;
        Mon, 22 Feb 2021 07:12:53 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id y5sm12788081wrh.38.2021.02.22.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:52 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] m68k/atari: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:20 +0100
Message-Id: <20210222151231.22572-10-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/m68k/emu/natfeat.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index 71b78ecee75c..fbb3454d3c6a 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -41,10 +41,10 @@ long nf_get_id(const char *feature_name)
 {
 	/* feature_name may be in vmalloc()ed memory, so make a copy */
 	char name_copy[32];
-	size_t n;
+	ssize_t n;
 
-	n = strlcpy(name_copy, feature_name, sizeof(name_copy));
-	if (n >= sizeof(name_copy))
+	n = strscpy(name_copy, feature_name, sizeof(name_copy));
+	if (n == -E2BIG)
 		return 0;
 
 	return nf_get_id_phys(virt_to_phys(name_copy));

