Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0663B281D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhFXHEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhFXHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:04:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:01:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u11so5331675wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EgO67Pnmg9AtuDmDWSJXP2ZOfMDcMUcqSHysYLnU+/U=;
        b=gJYV/iWbi6Wx8eEFq8OSgrasnD58puCGQCn5YgbOXIzBeeJHaqCG7oYBjVLScdUtMX
         FtH69/tggL1etaGvlFVOc6r6jixbplL5s/B4Hc8r+svK67QgOH7wtDm2HG1LFwjWk1gD
         zzyDkIvpZiU79AWZHy3NHdxBpnlwKqewxlXS7rvztRo+KjrYghYon2KnRzCcxkryFHRh
         HZTbgPSouYQKX/44JyCwLBTc4YN4pgldyKI1veIRcF296utlBlFhZA3sJ/8dlS2mXoZd
         YJje2zJC+842HYynNWZ7PcJKQq/kL8L49WjNSiJs1fELNpV0DlqMpqfpvblIxM/yC9NC
         C3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=EgO67Pnmg9AtuDmDWSJXP2ZOfMDcMUcqSHysYLnU+/U=;
        b=ndZnZx5GsyTbAIOdPXyKQrnXRpZ2Gr8PV1lVA1bLZPwLceQL2TWTsPFIqTQZPsUwh1
         c4AVc6YEJlniQmfEZI6i+Bj9mAaE/wPykTDq/d7Ta4qdcABNrCXcXTjyYcAWIiHEXftK
         23WSXiNWHFjRTxd4JGwd2aW3jDFl2YjEd1ZZjPH5OUW7O069z5yX4BzYCppK68kHpFZP
         J31BqQxyu1D+ZdVD5b+3Gl9W1RLwug5LuPQlpbeP2XtxbVDPafDXATmHcYNlD6o5Ajr9
         kwe49BtxQCJP6mh+u0KaBESrHOp07qdMsZyirr5qxlPDjhZFQF3GWi/h3WHzBIULzdvK
         F7HQ==
X-Gm-Message-State: AOAM532c61Cc6OJkPRfYLprlS0jxEzPhT0A8uKJbzN4FLr7Of86rqoxw
        uelpip6gnZVKJLolR+cg5iw=
X-Google-Smtp-Source: ABdhPJz/ULyuvejUZob8G60LhccJej7GwUn+hgclX/JwG+2kWkyfyF7/wKcBas0uTfjUSn+B6lvgww==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr2553481wrs.355.1624518102703;
        Thu, 24 Jun 2021 00:01:42 -0700 (PDT)
Received: from gmail.com (0526E2ED.dsl.pool.telekom.hu. [5.38.226.237])
        by smtp.gmail.com with ESMTPSA id b71sm2064608wmb.2.2021.06.24.00.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:01:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 24 Jun 2021 09:01:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fix
Message-ID: <YNQt1LsJCi2C0Aa5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-24

   # HEAD: 7f049fbdd57f6ea71dc741d903c19c73b2f70950 perf/x86/intel/lbr: Zero the xstate buffer on allocation

An LBR buffer fix for code that probably only worked accidentally.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      perf/x86/intel/lbr: Zero the xstate buffer on allocation


 arch/x86/events/intel/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4409d2cccfda..e8453de7a964 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -731,7 +731,8 @@ void reserve_lbr_buffers(void)
 		if (!kmem_cache || cpuc->lbr_xsave)
 			continue;
 
-		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache,
+							GFP_KERNEL | __GFP_ZERO,
 							cpu_to_node(cpu));
 	}
 }
