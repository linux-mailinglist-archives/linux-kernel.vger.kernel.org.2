Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98C33EBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhCQIlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:40:47 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:40:47 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n24so7914295qkh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkIO1ophXfMyeh4d+PPEJ9rXU0ylbu5LZ+tcsLb8QWg=;
        b=mRflAYIGknibqUY5PaRJTg0Y+NjE0jBnyX8UQLzbIl8ylBy2wbOUB6NMYDXcL14EjO
         EEm7nx7mPKVYE/ThjQ64szIeeVLo/tomXCrf03bGz+6L60tKIp9q5j0I/zCl72t3L5j3
         rnwqKx/XWXhTck5Gcxbz5l1f/FD7RRZp/4+VIa1C2MeyMmYp6XDZnd6bBImvtagDwbBK
         7J6aAvZFYeOhbeG9BA6/yxqmnJCIF5SaW/31V7kO6hWm4ipp7/j5k20sn6j8kAepm5nN
         a0D4b2DZ+sOgkOKbFd6Dqk7g5g87rE9/tcUqvxk4oh7jpkdc6E4jblXJmnjUINLjXhlD
         JT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkIO1ophXfMyeh4d+PPEJ9rXU0ylbu5LZ+tcsLb8QWg=;
        b=OU1jIwMFMWo3BQuZWGsryfWL9krTi/PLZ+YGR4MDuy1nzkRO/hfOSMt11QEKh++Mfb
         QRFiGcYMuSwNNjNseyIvMpak6QDuErdxVUf8RIzQaTKZ9oPNZZVDSnfKR3vD6FyhGD5N
         Dtq9AnOE5CGPueArgb32Q6YSZDhtte2kgbtSDoEC12658GXxcdItZvJ+LlEngL5vkP8w
         29VwN/iY7iE/Yj4B/5QYCZM3Vh2Xxb8uo0HPGShqWZ8e1y2RoOFSqVuhr8d+/sfjvlV6
         Eoj3EQoP/F/I3ZkL2K7F+JMymLXuXqrtRFkROjqhQpY/R4KegIkmfErm5MTQC1LEMRmE
         yAMg==
X-Gm-Message-State: AOAM5338bmP9RFPvBqb3rbYRUFTaegkyyBn/Hc8Cui+ni0g7ZXhjx6JP
        yKXI+Iopg1Y0GCiQ67FchB8=
X-Google-Smtp-Source: ABdhPJzArTYVNgtfsopde5JblLOXOxQEBtMyRja8UBGoqG8Gyn4rjEwkXB2RuaQhoqPE2GAMx71ZyA==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr3399499qke.143.1615970446915;
        Wed, 17 Mar 2021 01:40:46 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id c125sm17342562qke.117.2021.03.17.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:40:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file pseudo_lock.c
Date:   Wed, 17 Mar 2021 14:10:16 +0530
Message-Id: <20210317084016.3787380-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/derefence/dereference/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index e916646adc69..43990a882b36 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		 * If the thread does not get on the CPU for whatever
 		 * reason and the process which sets up the region is
 		 * interrupted then this will leave the thread in runnable
-		 * state and once it gets on the CPU it will derefence
+		 * state and once it gets on the CPU it will dereference
 		 * the cleared, but not freed, plr struct resulting in an
 		 * empty pseudo-locking loop.
 		 */
--
2.30.2

