Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651836F684
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhD3HpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhD3HpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B486C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so103857088ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=L50J7FYAXOKUKvuxOn2WDZKeul4PqLsiA1ZhPThBBudnDfrwPs8lQG5HN//48JNGSI
         8cDUojKu8+O1EIOSmss6l27mwOy4UXyhrIDh/D7m2fdoDPD2x4rcAAci605YMbCMvJNi
         wVqUPGfA3xPBQbrVWzPl956+GpD400HJQndV+l8j31fUpFPFuO/eW9puMRQjES4BemQc
         vNkoVSSgpTg33+q3UJgYiXGKcs+ShnsbzHQHt/gbJnxWtBMLYjYBUKyiVwgUbck5yVtL
         j2nncLxXnHbpPhUcfdy2G4j53u1Iq0Z/cc9Ki8KDQwWtrm2t9exJxQKu1j3JlWqPd5SH
         URxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=C6UCiwaqC8KOaz99ITKyxY2kdcoe72QZo3ujrY0W7klqoUIXQ+ON9Dbyre0geoMN6V
         Jlau8GwVspLoani4DkvG04mdBGn+18Xd7STGiUuJO3Ai7gB/ko8+WD6USx5rtQgY25KL
         yvEO59qfU7qc3Jum/xrfSek8dk2WFln0+AQXNgRm8HdDo4iJpAXOygOqOl67WonQkV4H
         9BSm3txTHYst1HFyVOTtHajY3Wq7aQK84EAWJvY25oKd/RUJZomuipUXBWnGoN/TNfS7
         q6Or3xwMzRoqA5hJyPolMxhmH1XEKoAf6kZpVYVUIGjYmC1QgmQs5RJYnZzNPX9R9qEd
         tZcg==
X-Gm-Message-State: AOAM531HYKez/5vluEOV3bu6O/D8OOmb7DuBIr9Yw6ZlYEBgHlLe6gUg
        jAC6RLy23WFO0/vBgv7U9VtmvrT/2Akg6w==
X-Google-Smtp-Source: ABdhPJyoc9uFg0dL6wVxCz1ihfiMfLcB6kvKSJAz6b2opFw5RF994oCTuGFYD8Ys2hRskp2ohsow7A==
X-Received: by 2002:a17:906:27c3:: with SMTP id k3mr2764521ejc.519.1619768653051;
        Fri, 30 Apr 2021 00:44:13 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id b8sm1452823ejc.29.2021.04.30.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/43] staging: rtl8723bs: remove undefined function prototypes
Date:   Fri, 30 Apr 2021 09:43:23 +0200
Message-Id: <3ee9b7a6998bcce9bfe702aa86639e093b4a5e45.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove undefined function prototypes.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
index 7a5bc00c3682..de69d5ea6ffd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
@@ -8,14 +8,4 @@
 #ifndef	__ODMPATHDIV_H__
 #define    __ODMPATHDIV_H__
 
-void
-odm_PathDiversityInit(
-	void *pDM_VOID
-	);
-
-void
-odm_PathDiversity(
-	void *pDM_VOID
-	);
-
  #endif		 /* ifndef  __ODMPATHDIV_H__ */
-- 
2.20.1

