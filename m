Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99435D7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbhDMGRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbhDMGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:17:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC595C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:16:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u11so4266519pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x7446NtR3WrUK7lZOpB0ZQa1HZIldwT03KZq9iUDE98=;
        b=SOGMFnPaoupCgj6Afpg4ua02pvNKMiSZ9Q24aKfeiIFfCDjC8c89HVs0kBZmTGXv6n
         NY51QOY+tI2ruJX9SQr0rt7tO5hprMydiZpM/v4wyfQGJjoJHo3tPsEXimwEDmJapv4l
         qvAmABZrBFSyfK+ex2mRUdV6+DvFf0Nw2cM6Ot+jxlug1bDoxHC3NtNfqYzAyITen0Wj
         DSiqvEhaaZqO0e6QjD9tb/G4avm+vfHEPZa2Dn5FWN437TGvfmi3EkWyU/xYSlFQY9mQ
         0CJqvZ0rpKqegLZCRmQ8HMbuK6yjmjwkA280UN3WfJkBakh/lJ77Mh2d/xfRN6u9BskC
         V4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x7446NtR3WrUK7lZOpB0ZQa1HZIldwT03KZq9iUDE98=;
        b=sCusn3JDblXbg6kZMo4wvd5FBfxWr8bqfoj3Rc5VavOysGUipvUfRI9tRq52HLc6Jb
         X/BTrDwbtkGOJN6dI16pmusFidR2XNr6BgPkaOcXQbdVTDosibQpIM6yJwUnLybNPf0h
         89y9/s2diRgjpuLjaYRncUSP/6+mf+3jD3Zf3S6ir29VPy+NN/I28k2FtukClMOHQgDY
         CeZWG7mJwIif3SSibZ6LngN+hUzxxXxOJbQ8sHmlF4eoH/FhkyVw+zowe1g+cQHzEkvW
         rTR19BPouYQ8sxgkhPHRCtWChed8gAoNgvvQ/fWaSbJK4mscoB5X/T3uVsD74AjTDa/g
         Fr7w==
X-Gm-Message-State: AOAM533bJ9906UnmtQLPVkDC4TOl0qIpAfXL9Idql96A8ZAuf+pVnxoE
        3bYvLRKUxFfjpSJ2r8f9vg+Rjj8nRygoRJTz
X-Google-Smtp-Source: ABdhPJyPRqWcqylZhisiAQ9I9DTAHDPypMdkXXnO+87p2T2WVx1bSTlwBnVfLSjiODI/yWwBdondwg==
X-Received: by 2002:a17:90a:4290:: with SMTP id p16mr3177934pjg.120.1618294609483;
        Mon, 12 Apr 2021 23:16:49 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x69sm11371973pfd.161.2021.04.12.23.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 23:16:49 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] irq: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Tue, 13 Apr 2021 14:16:18 +0800
Message-Id: <20210413061618.4999-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
  kernel/irq/manage.c:2199:8-28: ERROR: Threaded IRQ with no primary
handler requested without IRQF_ONESHOT.

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356543d9..222816750048 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2197,7 +2197,7 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 
 	if (irq_settings_is_nested_thread(desc)) {
 		ret = request_threaded_irq(irq, NULL, handler,
-					   flags, name, dev_id);
+					   flags | IRQF_ONESHOT, name, dev_id);
 		return !ret ? IRQC_IS_NESTED : ret;
 	}
 
-- 
2.17.1

