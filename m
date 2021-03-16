Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334E733D78D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhCPPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhCPPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC61C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e9so7658649wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5twvp7di1yhWCRKXbxIy4y2Nz4VGr9DJXLPrPpJYT8=;
        b=ck8etA8UkrRzOaO3cwSFuFwpGexiYJbFMlQu6gPi6uVG4fSbW2oVRcl6+Be8fh04+F
         tRN/0RP2x+ierKyf+1w9NL7xIKVtqdKJszdqDIyT4o/nvTgzrP5sUGv7X3oYpxmslcp/
         N4TM3qcoep7uf1anEbohdzRkIFFWfQsUqxn2g7e6Iq42+sWzg4rHhYxeMvIMzNOmMxNm
         aVIQIuZHC2Z9qhqFyKbtFhCoWD6Dh+775ogSmJex007bayiEatUgYzMlM0ZxGEfP3Ax+
         oUxD3fuitHhZVCJCli7IfNL0huMqxVvzV8zifC65TzaYsH3FcIg6r7f0dl9MVhVKt4gq
         r9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5twvp7di1yhWCRKXbxIy4y2Nz4VGr9DJXLPrPpJYT8=;
        b=ViZ6pboTCQVOLvb1ycvcctT/wQUnYLvdE4UW7KwdbgwClStzSSwB2JtCPzYpTCODuP
         ZwjPNYK4NESdwQlbfsBdloEPl71tJXKOt2xqLupZb1M2IEMoOujLSwbClHZPG8ZhRf29
         33GVvAuFYCFFA204h6DRGAuncd55E3B8+RVRh/tKy3+NxkwRDi4IxoU0NDJopUvs9gL4
         GtHJGj8MvLvQEjhtLfefly8P3UhBFqwkLMso8zu5PQDD5YCzJOyuetZ5OJRWo1hBO3SP
         NExMfZ9MhPRxQWJZJSFHXC1LdZCIkHkzEyXkRWVUjYZSeU+djidYhOcyKVOlw4Jyv9O3
         PYqA==
X-Gm-Message-State: AOAM533c/Uy7F2I5J0nc9kafB5Bo6uUiTG//7rdF+rocXw9SJqGAuv7U
        fGK+dJflt/fsVC5wmzmBLGk=
X-Google-Smtp-Source: ABdhPJx+PHVGngeMphVO5PueYqhDywxdsDCR9FQ/ohai1tAHdZtTp6ZsMjGRvSIQUx+W0UB4JUTWaA==
X-Received: by 2002:adf:a703:: with SMTP id c3mr5729309wrd.72.1615908724344;
        Tue, 16 Mar 2021 08:32:04 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id i11sm22170605wro.53.2021.03.16.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:32:04 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:32:01 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_USB_VENDOR*
Message-ID: <037983b85ccc2747284c9002a51c28a7290321ea.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_USB_VENDOR family defines

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_conf.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_conf.h b/drivers/staging/rtl8723bs/include/drv_conf.h
index 7fc88b07a25e..9cef9ce589a1 100644
--- a/drivers/staging/rtl8723bs/include/drv_conf.h
+++ b/drivers/staging/rtl8723bs/include/drv_conf.h
@@ -8,16 +8,6 @@
 #define __DRV_CONF_H__
 #include "autoconf.h"
 
-//About USB VENDOR REQ
-#if defined(CONFIG_USB_VENDOR_REQ_BUFFER_PREALLOC) && !defined(CONFIG_USB_VENDOR_REQ_MUTEX)
-	#warning "define CONFIG_USB_VENDOR_REQ_MUTEX for CONFIG_USB_VENDOR_REQ_BUFFER_PREALLOC automatically"
-	#define CONFIG_USB_VENDOR_REQ_MUTEX
-#endif
-#if defined(CONFIG_VENDOR_REQ_RETRY) &&  !defined(CONFIG_USB_VENDOR_REQ_MUTEX)
-	#warning "define CONFIG_USB_VENDOR_REQ_MUTEX for CONFIG_VENDOR_REQ_RETRY automatically"
-	#define CONFIG_USB_VENDOR_REQ_MUTEX
-#endif
-
 #define DYNAMIC_CAMID_ALLOC
 
 #ifndef CONFIG_RTW_HIQ_FILTER
-- 
2.20.1

