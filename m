Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E926F3201A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBSXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:15:28 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B26C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 15:15:03 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id h38so1650608ooi.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 15:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FokzymhQLiyG9lWtimk6QhqigfPpSjreUpNCE9+O32k=;
        b=cSrWn5Z4ZzSVM6OOht5m5nb0EGf6LWC5pS1Bj2PMUNb65V/kRb6WZG5nc/2oetHbT+
         JRJWpwH9g6mEJ2NQbo4aCayaK+0sNY9y6TtphL0j3MOhbbfuEwFdG3FWZmrNKUOLuw9X
         B3m+KKUKzU+zH0vcZH6eHItmixlxg+Pkzk0jzCcVbJ3KdqF/CMWIc++V1KSU6vf7bMO5
         MOdCWeyQ5jN2lWTwbM08uDDEO0DFx5EcUFyO7SlOzJTjCk7zLjL0N95U6CI3YMKREoBX
         wEZbyXjS1UUSP1y5wdtxM+TCxGh3Uu+2Ub9Efj3wjXpakYkSZq8jMCjjXXEWZOGRG+ei
         rq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FokzymhQLiyG9lWtimk6QhqigfPpSjreUpNCE9+O32k=;
        b=RwrL4Q+i0FzhFC8zgZr9RrmKhl17A/Y4ocB6featby7wH5/FyT4XXLnG7Mw4ZN8mOJ
         xsVIJYq69NeDowWJdwUystCDvbNRCQlOetWpFu/dzWS5z/fYVHMvblfzZ4dXcxi3YDcd
         hqXo7o4woK2h4kazwHOYyph0tDelInxWRAsL3R6cZnYBwN7HzCwXfXb1jj5+ITxyrz7E
         3ye6N/UzDmm3JrYQFJP6T5uAOYEB/bGqlfV2czyf2a7FWq4JABFsbVGzLyPbc+soJO7U
         lIa3+SXqKQWG/0JxNmt9TTmZai52XDJsxbDlyx7CgAj5L2WrBqOz9wixl96ucajbY6HQ
         H4kA==
X-Gm-Message-State: AOAM532udHtmdXAu0pgdR1SbrsmShPhE7sf1AOqPtaa5K8fYImvdDq0U
        i0HMijFu0L0PjTPfk9oWLu5l2PRCduAsjOtr
X-Google-Smtp-Source: ABdhPJx4UhnGK92AFwLqDi6ieNtkEaXF+yBN6kVA5iNPerBPgS70bvnHHJTeWWAaTAx7yJpXyjD25A==
X-Received: by 2002:a4a:be01:: with SMTP id l1mr3889892oop.89.1613776502420;
        Fri, 19 Feb 2021 15:15:02 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id f29sm2012467ook.7.2021.02.19.15.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:15:02 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] Staging: rtl8192e: fix kconfig dependency on CRYPTO
Date:   Fri, 19 Feb 2021 18:14:57 -0500
Message-ID: <8483722.hVsnvgcxvV@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1a3f343027d7f5a6475a019aa20be89795b8c8e0
Author: Julian Braha <julianbraha@gmail.com>
Date:   Fri Feb 19 17:02:24 2021 -0500

    staging: rtl8192e: fix kconfig dependency on CRYPTO
    
    When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled,
    Kbuild gives the following warning:
    
    WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
      Depends on [n]: CRYPTO [=n]
      Selected by [m]:
      - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
    
    WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
      Depends on [n]: CRYPTO [=n]
      Selected by [m]:
      - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
      - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]
    
    This is because RTLLIB_CRYPTO_TKIP selects CRYPTO_MICHAEL_MIC and CRYPTO_LIB_ARC4,
    without depending on or selecting CRYPTO, despite those config options
    being subordinate to CRYPTO.
    
    Signed-off-by: Julian Braha <julianbraha@gmail.com>

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 03fcc23516fd..6e7d84ac06f5 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -26,6 +26,7 @@ config RTLLIB_CRYPTO_CCMP
 config RTLLIB_CRYPTO_TKIP
        tristate "Support for rtllib TKIP crypto"
        depends on RTLLIB
+      select CRYPTO
        select CRYPTO_LIB_ARC4
        select CRYPTO_MICHAEL_MIC
        default y


