Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C235339B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCMDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 22:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCMDlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 22:41:18 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9BCC061574;
        Fri, 12 Mar 2021 19:41:17 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p21so17093996pgl.12;
        Fri, 12 Mar 2021 19:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=hZAc/P9lVDwEuLdchgvOWQUpCDDfjKHCr/i1rQtJgnQ=;
        b=WPiMI+YwDhwV3gbg9LhZ/BMF8AqtGY23VQDotn+5TMPbIaqA1vQbRTFpBkEK1oGI7Y
         wEbPMsPB7O7qJcgxP0nqBic4bPBSMPZdMELxxEKP72vDtovFc68LduI5xSZW+cg3FHlI
         J2CCcLh3FiMiWW+ZGVz7RBVHt9w5ZAyVXuo75G3sUL0T2ziH30bYCDxn2Rys70g/R8Z/
         TUsanaB0d5G7LH7aahzvfWVeXd+cv7WB2w61OVGo6YRVKO2tr3EeL/FZ2uUJJhEqnJ69
         ccqwR5RrdR8PSw8A0mwOJxH8dHpbJtW/gh2kAOr1Gaj0NAWUp38v1codDCNHYurnckql
         iFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=hZAc/P9lVDwEuLdchgvOWQUpCDDfjKHCr/i1rQtJgnQ=;
        b=bPzIKhWpsIUw3eltmQ6f10HujcT3lqIfaMlLr0tJ+DLeEwP7cffToMv+d01SLSYMGF
         uyBA7ZK3ByXVWwD4xwd6mmkJs1xR5caoLBp2b5i3cnf1iwm7dhx8LdOyVzj8wv4e2Xob
         vhQ93ODMQIRjb+wd5VQCr47pVVFyt0eWS/agoCva1z/17cQlRoR4FVD2QoxpA0wh2LgL
         yUbloq4f/etRN6pIHq8+8jLioL8oCvXuNPq+9vHI/GOpnFLdwfqI9MU44zU0oYgunhh0
         Q380cese9xu9JKIcMgDSYZ41JblirAE/bfhtazEUZKjALJaqvsZLLi+bdsvNT3hLaQqP
         5v5w==
X-Gm-Message-State: AOAM5314LgK+umD3gN+f6+MuU6eiysxYmVLHH5H7tGSSyQvzSNJ/fHWm
        xNrFYsKjqWBVQLsHpqzHeXcE+ZYPiMMdew==
X-Google-Smtp-Source: ABdhPJzCASMGYCWc3KRX93SEyI78Eqrnh9XrnwkcaGmkTzzA90jyODKcCF1goIhbVBUXPwP44U9Htg==
X-Received: by 2002:a65:4508:: with SMTP id n8mr14071593pgq.294.1615606877047;
        Fri, 12 Mar 2021 19:41:17 -0800 (PST)
Received: from pallavi ([223.186.24.218])
        by smtp.gmail.com with ESMTPSA id 202sm6626308pfu.46.2021.03.12.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 19:41:16 -0800 (PST)
Date:   Sat, 13 Mar 2021 09:11:12 +0530
From:   Pallavi Prabhu <rpallaviprabhu@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: clk.c: Fixed statics initialized to 0
Message-ID: <20210313034112.eqa7zxtes2ruklqj@pallavi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninitialized static variable from 0, as statics get auto-initialized to 0 during execution.
Signed-off-by: Pallavi Prabhu <rpallaviprabhu@gmail.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5052541a0986..763ad2c960bd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2931,7 +2931,7 @@ EXPORT_SYMBOL_GPL(clk_is_match);
 #include <linux/debugfs.h>
 
 static struct dentry *rootdir;
-static int inited = 0;
+static int inited;
 static DEFINE_MUTEX(clk_debug_lock);
 static HLIST_HEAD(clk_debug_list);
 
-- 
2.25.1

