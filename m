Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9B3B4C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFZDmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhFZDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:42:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE4C061787
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a14so6907514oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+yRh3o2fR8ULHnX/eXkypnyKypP1p2EL65xxi60niY=;
        b=Rt8sgU5hfyQvgRvwQa0i7zVsb3mwvph3NtvYDAXKzfwdYbL6MiRsYNng7sghDhJsdJ
         GcekdU7HwwukpJyR5nm76bBqeOtEfEcnAO4odLmz+0WSGLJCRw15+pDLWLnBPT2cU9JV
         zb34pQtWUya96Q66rJx4pMMV0GhCJkqbfl/SLd1sqmdF+fNR3OcR1qUh+a3MaMYJxAgO
         JJJOpa5twdF0ZuU0EwADmgegetONPFaPk/CVzJOwPr0V5JOk2bmUTmpoTGWvFDAH/KpZ
         hQYfoSPSL7Qv0F7FNVrv1U5VskjR+X7BGH3f+/koXW34tEEaWMdYPkq1gPp8STB1sQxg
         8BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+yRh3o2fR8ULHnX/eXkypnyKypP1p2EL65xxi60niY=;
        b=UAAX+Gpw//MyzFx75b8JnX7rK6ZXLg/huyyQnk0qqlM+GTVcaPi/SBk/MgsfiaO+m6
         D9bcJgO2tvmYK9dS7l/tSoTGyPLgXASUlSw8sy3EfW5nND1Y1ySOSMNG5qoWq1CH1VrW
         yHSGQhwabP4Pi69D6BhDFIiw2UI25MdkwzAbiDTmais2X6EDOazQlvdQlYv5C5bGvEFT
         zO+mmaEvU0vFh/nj12dvXp3W4nxi8TwCoBUBpiOjOv5SL8f3MHlutcby5BNDZykiKwiM
         Mixqs0ycndU1AbYsenPIjVK9yRM4rI7iEGPlzDzrSy7cO9ho5FA491QU6zeH6Q4sVVGh
         1lyQ==
X-Gm-Message-State: AOAM531c81LKDM9RX5/N+eePJAWg+/7XW9ePK9rFVmRYOfUCSksG34Pb
        A91QyRhGcFPmuKS5/trSEF6XIyPYb7J/OA==
X-Google-Smtp-Source: ABdhPJzTxTjPyZCnL4rBp1DWNEOBOdxsWMoGchMrVnvmWX8rz+pl17p82yHJDwbqo5VntfYN8kFAfw==
X-Received: by 2002:aca:1e07:: with SMTP id m7mr10330508oic.28.1624678826766;
        Fri, 25 Jun 2021 20:40:26 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k26sm1174817ook.0.2021.06.25.20.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:40:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     joe@perches.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/3] checkpatch: tweak extern in C warning
Date:   Fri, 25 Jun 2021 21:40:15 -0600
Message-Id: <20210626034016.170306-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626034016.170306-1-jim.cromie@gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extern-in-C rule has one important exception: the symbol is
defined in/by the linker script.  By convention, these almost always
contain: _start, _stop, _end.  Suppress the warning on such symbols.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4fe9fab20009..a8dfba53b593 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6910,7 +6910,8 @@ sub process {
 		    $stat =~ /^.\s*extern\s+/)
 		{
 			WARN("AVOID_EXTERNS",
-			     "externs should be avoided in .c files\n" .  $herecurr);
+			     "externs should be avoided in .c files\n($stat)\n" .  $herecurr)
+			    unless $stat =~ /_start|_stop|_end/;
 		}
 
 # check for function declarations that have arguments without identifier names
-- 
2.31.1

