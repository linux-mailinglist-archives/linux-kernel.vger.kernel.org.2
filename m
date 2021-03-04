Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8632CA72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCDCZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhCDCY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:24:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA1C061574;
        Wed,  3 Mar 2021 18:24:18 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id a4so17850989pgc.11;
        Wed, 03 Mar 2021 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uG0v75x7x/65LuUOs5/L5fUxuUODG3V+57vO+zTLZ8o=;
        b=sMQZ+zysGqbPcuIyrh5lKr7zFPD1hhJHew5ECFlsRAQAUPnHk0rMMZa9WQNezWlveW
         AiRmSRH5l2eAEBUK++OipmgdAr92JMfBeo6EdxrkMUgpJ2isNmWW8AipahZyrbIXuYMJ
         fRS9j1HSgDzzBTX3IPfqw/gu6KriAnvV3ZEScN09fXJKRHONQj3r7JgCgYtqgayo/dST
         xqvy5E8+TdnYaBgZDnQ2+R3iDjpUhpbUW2Tt6rOquvSJOaL/M58tRUoMEmGWBeqn+SLx
         bYNoWE1Z2TcI87Hp8pYgsLKLr2am8THsZVf4MhbvSMJ/Auho0EF2O6VopFzm4xucf9/x
         uT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uG0v75x7x/65LuUOs5/L5fUxuUODG3V+57vO+zTLZ8o=;
        b=ft8eNAuCqKsmGZRHH4LQg5foXPZDmK3TF5KT2o3r76kzamqpO7qswYd77PYThwHBqY
         bmXFp9ACnifO5TTXvqFnwuuA0bvTifs8m4ok31L6veDDZc46E0FrB74FWFUeWDebtVBT
         1qsFvQbVGqRa767vy9767yE3KspxS+ArZJFJ/6E3d2rJ0wbXWQqYRuCfYOtDiuC6xO/C
         X3Wno7X/3myjbuY4mjzGpAWb0umP1A1qxKygaqgaecMrvQRnuLXNA8v2sIpEWIFgbJX5
         xRdHayipjlnXIueFuAje3kATEfa94OW498i5Iil82UlMpas6ojcfqvCQE0asUgk8CTra
         B+EA==
X-Gm-Message-State: AOAM530UcQLEQPCb3K91fasvGd69GYXTQRHccvlITXGJZmLIN3GbKDQs
        RiOC+Q2HspJ8GGYj+rZoYso=
X-Google-Smtp-Source: ABdhPJz9U4fPGGTcrk/7KnFoTfUdxn+c03dvqRKjSREYCh3K2Tm+drLBPh3uaWWYrWiPJj1u86XHZg==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr1717191pga.45.1614824658027;
        Wed, 03 Mar 2021 18:24:18 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id k3sm5682542pgq.21.2021.03.03.18.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:24:17 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     oleg@redhat.com
Cc:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] arch/parisc/kernel: remove duplicate include in ptrace
Date:   Wed,  3 Mar 2021 18:24:10 -0800
Message-Id: <20210304022410.186848-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/compat.h' included in 'arch/parisc/kernel/ptrace.c' is duplicated.
It is also included in the 24th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/parisc/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 2127974982df..918faa95740c 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -567,7 +567,6 @@ static const struct user_regset_view user_parisc_native_view = {
 };
 
 #ifdef CONFIG_64BIT
-#include <linux/compat.h>
 
 static int gpr32_get(struct task_struct *target,
 		     const struct user_regset *regset,
-- 
2.25.1

