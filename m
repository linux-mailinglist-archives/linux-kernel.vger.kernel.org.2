Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA533EC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCQJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCQJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77111C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4986207wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUcUbYzVq4WAbYCHC6A4U/IWUbOjJbgRMpmZlOoFPaU=;
        b=qSOrLft8oGs6hVSsCNmwZZTMED/qFbTW9EEw6QlFA09kUTI6BcJSa3donspZaTB2pI
         amz9oxFTpQ422j9x6M6PFn1eJDxKD29Y6EJd9jOuVD3T9vhuu9nn28QJJtJQK/5AZ6AH
         OG4LR0YoM4fpF6IzoyCmXsBHLOhf1RQgaeTD6cibhWx+XomtwVuDJ9S/ZNwRK1b93eq9
         m7QyE7x+orCiUZQXGRX/xULU9vT0jCmB2iOM3oSVWA3AtaWwpSyGt5E1t2eD30eM9h0w
         0UY1CVO8Rwf5QZn6LjG9C4ySTXoasW47tR4zp2iHUTQjMzFWzXMffLZ+c14xmz9YHTac
         UjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUcUbYzVq4WAbYCHC6A4U/IWUbOjJbgRMpmZlOoFPaU=;
        b=tJuGt02eKuECwlKXgrThedowg1eH0UqgJ9P53CIFEll5s2yOfXosTdzk0o6gMwWiDG
         tgDYKgevZNSboqSKkeEm4xNLTtQC7RnlyxCYXF8vkxX+AkhlEHb1Y1UZvDlRXqhvigGA
         VoxZ1LXdxPnYNWttWZldosbFbjSFjYYK4Y+r8t0ptR73IIbOXk+aqqMyRL1cAYja6VlB
         PpZclhP8mpATbL9Y9gkeg7SOWGo09E/qaPsthlcNry7IgKrXrUwBf00dVxIRjhGCWBYl
         ys9Pl3LTCHZ6Cge+6dck2DMZpUY6ElgMYhk9SDgIio1nLojwSdbR/OZnAi95SscJlQsR
         TxlA==
X-Gm-Message-State: AOAM5328duotU8UYQPCa+LpyhJloi0szIbKPxMIfHrTL/n8yqOQL1Aw8
        u3PC5UnuX6qCCBO1pAozvw4Hzw==
X-Google-Smtp-Source: ABdhPJxTLCXw7Of2OV/8m9UKxF4p99Sy2ikd/ONYtccHhh1kz7XgJ8hxg7z/qgCghEcNy2cIEKGu4w==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr2766758wma.170.1615972290211;
        Wed, 17 Mar 2021 02:11:30 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        gotom@debian.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/8] scsi: nsp32: Supply __printf(x, y) formatting for nsp32_message()
Date:   Wed, 17 Mar 2021 09:11:19 +0000
Message-Id: <20210317091125.2910058-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/nsp32.c: In function ‘nsp32_message’:
 drivers/scsi/nsp32.c:318:2: warning: function ‘nsp32_message’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: GOTO Masanori <gotom@debian.or.jp>
Cc: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: gotom@debian.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/nsp32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index e44b1a0f67099..d5aa96f05bce4 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -309,6 +309,7 @@ static struct scsi_host_template nsp32_template = {
 
 #define NSP32_DEBUG_BUF_LEN		100
 
+__printf(4, 5)
 static void nsp32_message(const char *func, int line, char *type, char *fmt, ...)
 {
 	va_list args;
-- 
2.27.0

