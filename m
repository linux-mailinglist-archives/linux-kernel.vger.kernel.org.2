Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E638AF52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhETM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbhETMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F9C068D9A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so17408870wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6F9CIYmlo52QhRnf1Ts6pZU6vEgtJYjHPpUD3uPQUU=;
        b=vEUFHCCrVWzH7F4BQl4AhGMENDWLpmGtMfKvVteygBQJAroSnfx+h0z+b5+0ZoxQT0
         B39wlH6zvjPlWc7qtyRhsAgbzr5c7zzS65JStYdiLgwM3PwIdDHXF/kLnyKE4XHHjUrS
         zr6WqmYEhbdFBqMmG3tWfFA/TRBClvES45lIldgtO3w3TOm5s6llFMFmexdQK8dJLmxw
         sQ82fCl1SrZF8RYBYmaEWnGuN481jtcDTsh9Ak5InVJIiII5muuEUW7Ab/S/3gNxr2+z
         JAFfhHJnnYk0mr7PDdesn4R2axIQNJFRBwv2+Xi2mj9GIdX9pOY35oq+IzRg/TrsCPPm
         Ck0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6F9CIYmlo52QhRnf1Ts6pZU6vEgtJYjHPpUD3uPQUU=;
        b=Uk2b6voYc0c0s3A/dfKlaX5ZMF+hIDfH1awE6Tm7FYn2yjZwYBA9akYvxNaPpVElWK
         7IwZdWrFyZ+Cn1fWswSawrDZ/NHrrNTljyOKcycb25D73llOocWy35jsovOgR+36WKf5
         BTVpp1SsWAZF/ZIOtLAsDBNwJg8aMHvQR+iIdyoubg3y5rvgWLKL7eUGUoGF2c6pJocu
         JYL7r3o78sNe6MjlhzS8lmGeyzMVexrImRj8Top6+CexFL6GEjwVBJd0pVzVkVeCTSSe
         JVCjjzhqKysKh0nPvY99UEUvUHmoOaIcItnwxJkHZvBn6fBqWF6dHrVfMSwC8xF6AZ0w
         ZQNA==
X-Gm-Message-State: AOAM531Mf+SxihzbKHkna/4tpgc87HNNeTYkYdRLukIfNS/arRz1RHn0
        Khuw4Gdj3YI90m3sQrAGTMHdeQ==
X-Google-Smtp-Source: ABdhPJxeksIDSza+G5tR0c5undGw7SpGwFpJkPuxPemkzCDEPvhADILr9voZRFZH/KS/PYN1Y3nDxw==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr3981174wrs.414.1621513156553;
        Thu, 20 May 2021 05:19:16 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>
Subject: [PATCH 07/11] tty: pty: Fix incorrectly named function pty_resize()
Date:   Thu, 20 May 2021 13:19:02 +0100
Message-Id: <20210520121906.3468725-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/pty.c:306: warning: expecting prototype for pty_do_resize(). Prototype was for pty_resize() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 5ada7e9381eb8..a0898925d2e7a 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -282,7 +282,7 @@ static void pty_set_termios(struct tty_struct *tty,
 }
 
 /**
- *	pty_do_resize		-	resize event
+ *	pty_resize		-	resize event
  *	@tty: tty being resized
  *	@ws: window size being set.
  *
-- 
2.31.1

