Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC24F3AD0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhFRREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFRRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:03:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:45 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a11so2218495ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J97xGdoeJ/5GC12SOPK5ESidN5KNkQ3VRXSijQXay5g=;
        b=A6Qe9R3P5J3pZ56qAdc2OUlemiodwJ3Im2lYSVSNVlQATiF1xJIcr+1YrGv0kbHUQB
         XIy0u2TY2FXaZXqj2bicKGeLv7DnXyoa0huRT+AjQC+ELO/pjrAlcbQ2V11eqjVmxMye
         sxmvXX54vmvWEPivMb2JPzNlLv6cJfcv/YgIN+i1kLNWgkt7GrahPIoDoL3V2drekird
         7RbNoesfXbw1YuVioQyvvYmgOf05iUp+pvvtRQTDosZ/6PpKbBsdq1uVVsttgG9GEmow
         5emjePybBd9Kp82aDmWlzCpPacLYtPJatVAvO9OrRwy0MDl6kf2K7nwbLMhlevphKlkR
         7cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J97xGdoeJ/5GC12SOPK5ESidN5KNkQ3VRXSijQXay5g=;
        b=t+rPhtXUEDY9/J9EkXPikYERc5BS1bW7V8SMU3zXSDRjmRBf+If6PCIzrkzIKj5CnI
         QaidldleJtC5vZ6vgXAPK7vDZ4R1ST6O41Ct1ZKbZ98o/aJTEdFRMZUMXuV6/Zpawo8p
         clD3M1UKnGy69W1s+CEkCJs03GrSc9SwpLO0abHSmy3LJOKQJhW2SKOUP2xCeHGvNOJI
         hsdYSO+eMfxyKTDEalKfL/zCxrxMMfNMZ5ADrBlTzpM7ibFVaCBwoQd1tG6fKUxPpWH1
         mSHedOsZWzJuTA8IfKCJe+Hj7OaWegnkAQy54Qe7r66OGYdvf69cIYM4j2cWBlxwmDav
         pVpA==
X-Gm-Message-State: AOAM530REL8ZJ8sMQFw4UwcMXYLG8aiRX1JxWIl7z1CoCTrNScUYRltT
        AlOQOIGoCENceUWqqxYcBsQ=
X-Google-Smtp-Source: ABdhPJx/g2TTbImBHdGj8y/jlOkWCn8RbKxUGkfAmHUXoanJrcudP78VE/a/VpwS+AYoxNB5Lu6BTQ==
X-Received: by 2002:a92:6d0b:: with SMTP id i11mr7997010ilc.160.1624035704799;
        Fri, 18 Jun 2021 10:01:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v1sm1390941ilo.81.2021.06.18.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:01:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 78E7627C005A;
        Fri, 18 Jun 2021 13:01:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Jun 2021 13:01:43 -0400
X-ME-Sender: <xms:d9HMYFM4RVsAkSVHdNPBY3MZT3CsKGU1vNPLnXcId-ANY2iEotq3JQ>
    <xme:d9HMYH-pjTu9xiRfZyxE6esnGuHCCrJth-pwK8_VQHOou-GkszseW2hZoYRFeJ5oC
    bNEweXSc7n7ln1nVw>
X-ME-Received: <xmr:d9HMYESdDfyYpKcnFtMDzCEoAfosu5NwHigptfFzfiS20ryJDfDZaojElIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:d9HMYBt6qsQldHdyxiD0G_TdpQsSvcm5r72mO-jypB1HBJNBOWCQiQ>
    <xmx:d9HMYNcDch1WZkSkmoNv9evmPTGReg5dPGNYej9J_zjWscjiYouwTg>
    <xmx:d9HMYN1oGXZTBEzstrErjeuLim72iXF19rgWl4TFxKRiH62sd4dVlA>
    <xmx:d9HMYGHAVr-h6_y769-vc7gClfZMpU3OjILuZR89a6Cbt3XYW3hjlg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 13:01:42 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/4] locking/lockdep: Remove the unnecessary trace saving
Date:   Sat, 19 Jun 2021 01:01:08 +0800
Message-Id: <20210618170110.3699115-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618170110.3699115-1-boqun.feng@gmail.com>
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In print_bad_irq_dependency(), save_trace() is called to set the ->trace
for @prev_root as the current call trace, however @prev_root corresponds
to the the held lock, which may not be acquired in current call trace,
therefore it's wrong to use save_trace() to set ->trace of @prev_root.
Moreover, with our adjustment of printing backwards dependency path, the
->trace of @prev_root is unncessary, so remove it.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3b32cd9cdfd0..74d084a398be 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2550,9 +2550,6 @@ print_bad_irq_dependency(struct task_struct *curr,
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
-	prev_root->trace = save_trace();
-	if (!prev_root->trace)
-		return;
 	print_shortest_lock_dependencies_backwards(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
-- 
2.30.2

