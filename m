Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71037F689
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhEMLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhEMLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:15:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:14:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so4473752wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBLLcVkKvatdlWCYFH9IPhSGBPBGIYLDNeKjc9M11Dw=;
        b=IzfJv2l5KSW2kT/7M1SVhhitWUv19aB/0rsbcHRcOtYv045XH7vQrvCBilaONXXxrU
         pbUOEyLQ6E+y5lysTgx1zZfe+loy+NYZ026OxZ72mlLX8423z3EfeMCTDqdWCP1S64dF
         qk2QCBzN7sRPmSO0hU9tnoTj8Et6ywtQNQlkx4EdlyAfGEQLgCZzaq0CsvNwebSdwJgK
         XBYIn/fAthqUTCcSyTiWV598DuJdtue/tT37J5E9/RI+FwkMao0dQyIV/rSnG1hDAUm3
         6q7vEuGjoBdhS4qoTd2GDyesJPwnhrlI8UNEMYqs/uJCIvXrg9GY05SnWsK6FONNjkMg
         bbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBLLcVkKvatdlWCYFH9IPhSGBPBGIYLDNeKjc9M11Dw=;
        b=It+X0r6Ud/jLf4mAIli69lLC2bDQQ1Lh3rn0gmVtW/km+4mo4sZJ7eYmabkLd5ksNf
         Qn7OouVLKKI3r4vXd6/5VvH047nYCb27Wf+1bl7CYRRw+GJyQ8dxlVGyYqyZI8926XYx
         QHzGIdiX1TjEB4Xni8dK+Ih0S9ZHEkhTc4XbmMoLtRUu3Sr85tQax7UxLhWdBiT/+8gQ
         vwDbxO9E/7mEEdYD3nr3uEZQ/gM0VVZ4nUpGlUJrAS0+qf46UzUmjvO2O1DVDjsiJa/+
         jQ2z7U8wPJVL1ycOypaMOgwPs0YYx9lI+GFHkO6iI/cVWxi7Dal3OKyJjUgB0BAFDS8F
         WPZQ==
X-Gm-Message-State: AOAM533z2ZeS+6/LKXzYkDLnRnAx2SjLLIY5u0wCjyprh3SwBmxcwb7v
        /kaF5GfAky+s5Ox9zUg10A9JnQ==
X-Google-Smtp-Source: ABdhPJw+Wz0JWK6yi++BengdQDNdNEhAsvsUbkVxhFFp7HhmOqJjaLj/+pSX8rvXsgGbnpg9j6cwlw==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr3306217wml.84.1620904454328;
        Thu, 13 May 2021 04:14:14 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c5e0:2ff3:baa4:b294])
        by smtp.gmail.com with ESMTPSA id p10sm2207060wmq.14.2021.05.13.04.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:14:13 -0700 (PDT)
Date:   Thu, 13 May 2021 13:14:08 +0200
From:   Marco Elver <elver@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix for "printk: introduce dump_stack_lvl()"
Message-ID: <YJ0KAM0hQev1AmWe@elver.google.com>
References: <202105131720.yP4kfiAi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105131720.yP4kfiAi-lkp@intel.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing dump_stack_lvl() stub if CONFIG_PRINTK=n.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/printk.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index abe274305d79..f589b8b60806 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -270,6 +270,10 @@ static inline void show_regs_print_info(const char *log_lvl)
 {
 }
 
+static inline void dump_stack_lvl(const char *log_lvl)
+{
+}
+
 static inline void dump_stack(void)
 {
 }
-- 
2.31.1.607.g51e8a6a459-goog

