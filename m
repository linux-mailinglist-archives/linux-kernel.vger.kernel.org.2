Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2035FA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352859AbhDNSPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbhDNSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D03C061342
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 18so24855981edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1YjEpXb5pyhEqn1H8gVpEY9zSbJ+dhKUe7WW0XkU7E=;
        b=B2xmAA292lvyfZHhU6Qn7erzOx6uQ1DvLmuKM+wetkeXidq8sNT8UW3KeK7x8iXZGz
         +Mpgop5FQsR+Nk2n0JJgaSN/nK/FRbsuBwRnglS/oInp8dv2K2yYR6+pq3Ozmqxegc4c
         1HGjy8dIhqtUXK29pJFIBvCT2EbuHFkHHA+mYNfrTHOlE6UttzksDeBsAhfdY7Nzb1+8
         F1ALM6VH4IgeJ5sMAjZNkRN9sfJJF5m099uJgHDZLr8qKKA12W5VGsvddyIq+75eZpuD
         Os9CFBFT1Cb4DET7scTZDwBV/jjapMqo7IjFTcSHoj4ePhmV7VXFi+RhpTBk+smsqqIO
         qAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1YjEpXb5pyhEqn1H8gVpEY9zSbJ+dhKUe7WW0XkU7E=;
        b=KhtZ0UQfxU9tWsImBRv/HjLjKIDfohVW6KzohQpjsEjH7ZaCTc0R9IV4Soph4k7fZq
         odqtDW3Iv4xkIVnsSgYb+OiNlAf8Zdc9SYb3rtYmkULbQGrzJ77OWkI0JGyyQNJ3GbVL
         lNneHAIpU+athHsiuiX0dCQxQ2lGTZktmfLUW3aLpPrGJ/9zycegFe4bMBRVhF9L73Yx
         eqQUno5aMefwZC8Uj+ePBL0IZlpkeWeP0RpsceVjW6qoCVLTIM6teURBjGrfROpLoT7G
         /JX7xy+j4KUZTQwZGUcO/MyDm8vQJROMib8+FBZJ4ZE5i5uXBSV1FUX+h7phCcFcQpG2
         p8ZA==
X-Gm-Message-State: AOAM533t3S11f9Bli9aeHaI/P8GdfkFqte+W0Kh3a/Qnl0Ks1KPSswrN
        EOaXWG6ULmtnwcdGuKHAN90bng==
X-Google-Smtp-Source: ABdhPJxyPu+e9MSDumWXIW5gx3I2JvjpzFLCDuEt9gQVlBs5LMfGaRQE3PCF6IH+B/uWzFqdOhlgbw==
X-Received: by 2002:a05:6402:40d5:: with SMTP id z21mr228692edb.20.1618423947175;
        Wed, 14 Apr 2021 11:12:27 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Spencer E. Olson" <olsonse@umich.edu>,
        linux-staging@lists.linux.dev
Subject: [PATCH 50/57] staging: comedi: drivers: ni_routes: Demote non-conforming kernel-doc headers
Date:   Wed, 14 Apr 2021 19:11:22 +0100
Message-Id: <20210414181129.1628598-51-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/ni_routes.c:249: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/staging/comedi/drivers/ni_routes.c:398: warning: Function parameter or member 'routes' not described in 'ni_route_set_has_source'
 drivers/staging/comedi/drivers/ni_routes.c:398: warning: Function parameter or member 'source' not described in 'ni_route_set_has_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'src_sel_reg_value' not described in 'ni_find_route_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'dest' not described in 'ni_find_route_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'tables' not described in 'ni_find_route_source'

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/comedi/drivers/ni_routes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/staging/comedi/drivers/ni_routes.c
index 1f2aa3b239a0d..f0f8cd424b309 100644
--- a/drivers/staging/comedi/drivers/ni_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routes.c
@@ -245,7 +245,7 @@ unsigned int ni_get_valid_routes(const struct ni_route_tables *tables,
 }
 EXPORT_SYMBOL_GPL(ni_get_valid_routes);
 
-/**
+/*
  * List of NI global signal names that, as destinations, are only routeable
  * indirectly through the *_arg elements of the comedi_cmd structure.
  */
@@ -387,7 +387,7 @@ ni_find_route_set(const int destination,
 }
 EXPORT_SYMBOL_GPL(ni_find_route_set);
 
-/**
+/*
  * ni_route_set_has_source() - Determines whether the given source is in
  *			       included given route_set.
  *
@@ -506,7 +506,7 @@ s8 ni_route_to_register(const int src, const int dest,
 }
 EXPORT_SYMBOL_GPL(ni_route_to_register);
 
-/**
+/*
  * ni_find_route_source() - Finds the signal source corresponding to a signal
  *			    route (src-->dest) of the specified routing register
  *			    value and the specified route destination on the
-- 
2.27.0

