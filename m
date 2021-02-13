Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66031AC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBMOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBMOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 09:42:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:42:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c6so3267925ede.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t2hD8XWbXgiIhH0tTQ3l0lSYwAQ2IrFpZZ7rZL9ddzI=;
        b=gPoVzMrKYWT5P5FUqvfXPmaj0PBivmyTERUcOC7JAdB7h7imXiUcpDbp+SdBWUJ1v6
         tudDvNum7GFpntleOaMS7JJdJCBQuAbG1IiAz802RJPoRd+U8VnDgJOna8RQbGDho83Y
         JgmzRYPCVrj31KmvV9v3KH14TVNWZ2/iZ7rlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t2hD8XWbXgiIhH0tTQ3l0lSYwAQ2IrFpZZ7rZL9ddzI=;
        b=cZoNSXZ0Wjfekoh0/W8xvtccxmBlzS77UkxXYY+7wCYIKFtlXW2AK0nIACsYixx6ME
         YBhK6SLE2YymU+R/CLidYDjte0HFCnDZp9UogUjKDyzHSvlmFSjWvl5oEBpqkqWUzA7K
         tVFs4CG4ofzu+MasyH8eKinxhyPH0OMVcMhO6nr+1DTim4tdjno20r1rm1J5rrGE7nRM
         4xTaJxR4JqRlgVAgEYwwz2DnzfO/7Y9J2R3YPMBjU9Jjdal/v6DntGZmU41Oh/uGmycs
         xyUIbkGAWF4hsAlnu6TvYb6mvhHmaYeCjaoCbvLmSHwdK8G99CFEmGxm9cv2LWsKjF/c
         7crA==
X-Gm-Message-State: AOAM531XqLwC7U/d7LsM+Q3JBEzgq0V59aUYwqXEUIALlpm7cy1YiVzO
        k7nq9QuB9q/dUDTAl8Z3IjnYrw==
X-Google-Smtp-Source: ABdhPJx87atO1GIGclLv+Qu3xvblIn601mASInOfSHXv5ZNhB3yHoexm8N7nIDNV5aKjU/0zdkqN/g==
X-Received: by 2002:a05:6402:38d:: with SMTP id o13mr7928059edv.155.1613227320169;
        Sat, 13 Feb 2021 06:42:00 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id c1sm7843073eja.81.2021.02.13.06.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 06:41:59 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:41:59 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-ia64@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] ia64: Depend on non-static printk for cmpxchg debug
Message-ID: <YCflN5zTvo5mxvKY@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With !CONFIG_PRINTK, printk() is static in the header, but ia64's
cmpxchg.h with CONFIG_IA64_DEBUG_CMPXCHG doesn't take this into account
before trying to use it as extern, resulting in a compiler error:

    ./include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
    219 | int printk(const char *s, ...)
	|     ^~~~~~
    ./arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
    142 |   extern int printk(const char *fmt, ...);  \
	|              ^~~~~~

Make CONFIG_IA64_DEBUG_CMPXCHG dependent on CONFIG_PRINTK to avoid this.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/Kconfig.debug b/arch/ia64/Kconfig.debug
index 40ca23bd228d..2ce008e2d164 100644
--- a/arch/ia64/Kconfig.debug
+++ b/arch/ia64/Kconfig.debug
@@ -39,7 +39,7 @@ config DISABLE_VHPT
 
 config IA64_DEBUG_CMPXCHG
 	bool "Turn on compare-and-exchange bug checking (slow!)"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  Selecting this option turns on bug checking for the IA-64
 	  compare-and-exchange instructions.  This is slow!  Itaniums
-- 
2.30.1

