Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6726838AF51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbhETM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbhETMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29565C068D99
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so17429456wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJARt32ZQiETH9hR4IAuZRuz7sl0B3/aEJ08ELK7AnM=;
        b=hc9xNRkKHJX11+p3/IMzx8mKdj7z881LtfU5FzRyVKytQ+uEq39QOLi4QZYWWTdGx8
         ZkW/2WB3HIcbZWsYXyUBqKbmTKOMezDZzFnkZIx1wUQ2qC4fQLp+qmJb6JRG/UEsJ3go
         OVSsiRUdnos9LRp8VF9ZsTuCDOH5vjDIsbJH9hQXw1XGmDLb/mjHokxZ96D+pCjoy0GW
         DnaeO2zqLJIJGce79KchPaikU+h3rY+flaRR/+fc/RHi/xLPHxIKUWNUYrF1nHcaIodW
         veN/t6LDOhnxhVp3kQYyJ0upEv7uPcrRxVsJE5ApA7PbnoqIEAj+XZsqOWe4o3ieaD2v
         0b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJARt32ZQiETH9hR4IAuZRuz7sl0B3/aEJ08ELK7AnM=;
        b=RLsYMVpDEBPuftG8BV5WpakMATvvZsQgas1Qz0JKwHNSHcREf2RBPI3jIl0h+c3dJp
         08OrSpOkRW1dGwACHQjEE2Ix5emal8SLLX3loAuOpM3dP+J47SZigLLgs/WFgk76hXXj
         aZs/RIKWiViX9eXCFwOuflf0hO7K8xs70Hs71fi/AGIS824W7C4vaXF33f+Q4Hp5N5eZ
         uG8SWuGN3wrfEUVGLbe0c+eLRkEetvw9nTzCylGXDCCIf0IkJALeddnkdjUSrfM2syA9
         iFddJ+QpEF79kBEW6GGehLH4pEXlCZVkbGy/jnLnPGKyGsMbOj6b3MjfqcqArfDukGXP
         OCdg==
X-Gm-Message-State: AOAM532RkRMXSzCqs4AbZRil21SIMzamG/gxQsxXQHXS9O6Pc34Wn/Ms
        5zNT6KVGUHY5XQQwiGXd5iZ0Oal0NdCXfg==
X-Google-Smtp-Source: ABdhPJxarmHwD/c26PB+v97pgBjcaCb/OCiMWALW0r0eHRrEaYyiJgdO7yo7Wd/BPmfo6dd5HQqr/A==
X-Received: by 2002:a5d:498c:: with SMTP id r12mr4018201wrq.31.1621513155789;
        Thu, 20 May 2021 05:19:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 06/11] tty: tty_jobctrl: Fix 2 incorrectly documented functions
Date:   Thu, 20 May 2021 13:19:01 +0100
Message-Id: <20210520121906.3468725-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_jobctrl.c:33: warning: expecting prototype for tty_check_change(). Prototype was for __tty_check_change() instead
 drivers/tty/tty_jobctrl.c:97: warning: expecting prototype for proc_set_tty(). Prototype was for __proc_set_tty() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_jobctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 6119b5e486108..80b86a7992b50 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -20,7 +20,7 @@ static int is_ignored(int sig)
 }
 
 /**
- *	tty_check_change	-	check for POSIX terminal changes
+ *	__tty_check_change	-	check for POSIX terminal changes
  *	@tty: tty to check
  *	@sig: signal to send
  *
@@ -85,7 +85,7 @@ void proc_clear_tty(struct task_struct *p)
 }
 
 /**
- * proc_set_tty -  set the controlling terminal
+ * __proc_set_tty -  set the controlling terminal
  *	@tty: tty structure
  *
  * Only callable by the session leader and only if it does not already have
-- 
2.31.1

