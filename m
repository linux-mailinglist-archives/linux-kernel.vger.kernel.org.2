Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F227426764
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhJHKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhJHKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:08:08 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F28C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:06:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so2331973ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuVYyB9vkCMtVNgFTjrACAcYH/UvfKeX4gFCZxEVm+U=;
        b=Z1tGC5DQH7fQHaYzJDeydcdUmbdfb5IXnvuMOI1Ci/y04WJr88m0P5Fi+Xye8zXg4C
         PwQOt1YXE2589zcxSG0zi+qkCS4ctKoxtL8zcFDYZS4LioJpFD4j+0lZpfUf+MV0Exfv
         F5pZ4kzWoyldp+VZ7VgQxmwe9Og16HAIjYgjsNy44FOnV4WuZF2hSYHVpq0p6RQ1+m5S
         MnXd236Gu/O+B/zDcBM8Wpkbxa7y61FPXysjhS8Zz444SghY+xPXk4RSf9lzeTaiHdGZ
         KETz5JBmtRwVie1OWNI9Pi40XHLH6sH7Sy5ZMY6i8Oo7LCqtPF3vA3XABYZsLTdRLt9W
         MtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuVYyB9vkCMtVNgFTjrACAcYH/UvfKeX4gFCZxEVm+U=;
        b=0nOTiVPh+NtZrxn/udON07Luyd6t32yxkhy+EnpqUDKyf5vMj97V+3sr6KpTgitEOs
         tXRc7bJh+Xx43EfZ0F6MupGAWty/8ggkv65Q2kDtF5bvdEFlwZ27VO2iIY1152DsXwGo
         GhAHAJcNKHdrPd3vGPnRloytuR10KgVE6zj8Hw7+8hToM1+NuPAB/6kZZMStnEKoQfL3
         nY+qpI+WadhGu1I30qBFUpJstYkFl63lDvrIzhzaGpDccgTMb6XST+DJcJlEhIEyAood
         Czidf1uy5eazHS0UjxDTCfnI1ixwpYM4Xv0blX6aRkXmEfOqCsm2zk2XwA9b2LI+rzI6
         xwSA==
X-Gm-Message-State: AOAM532L0GKN7jaMZf1t257x6qnBbe189U+es5TQIUH9ky6qAm4+c53l
        kVB5rOePyklrRwBXrOR2aWw=
X-Google-Smtp-Source: ABdhPJx3C8rof9iqeYfYJFZq8iUpNBYpcxZX5evLgm19NaIO14RkF1C5FNOH5VV2/uqP0EQWbgMMnQ==
X-Received: by 2002:a6b:7415:: with SMTP id s21mr6861315iog.168.1633687571991;
        Fri, 08 Oct 2021 03:06:11 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z5sm851122ilh.9.2021.10.08.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:06:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9BA6027C005A;
        Fri,  8 Oct 2021 06:06:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 08 Oct 2021 06:06:09 -0400
X-ME-Sender: <xms:ERhgYV_lwN7NJS_JK4FCTz74ufVTjdscb7Q1FZ-IrLtiXoemd2dfKw>
    <xme:ERhgYZsfv0NENFu4Tm05te0DWDugrLCMMyGdjiPpP1b3RB1rd1CA6FlwQPQMIpEg7
    fSeb2hEBrkOYa652Q>
X-ME-Received: <xmr:ERhgYTAPChPP-n-1l9mOt2MjOxO3rCITBuoR0YF2HFsP1SonUIY3SW3KWta94A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddttddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ERhgYZcDEQodkiUaeUb7iF70BOAVYEhXNVnz_1Cc2YE__XL1hp6PrQ>
    <xmx:ERhgYaP17w9maje-kkUWUpeW6bpLlrioyP1E6aAN2HxzwJewCoBdaw>
    <xmx:ERhgYbmkBq1W4kGq6OpG1Mpq-z95G4m1mIutGJTVH65qAZF6NaU6rw>
    <xmx:ERhgYWBgPkuRunm0sq-Ya_HlGsdkhKubdmm3czhZBQDqOqjG7k7DSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Oct 2021 06:06:09 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 1/2] NOT FOR MERGE: A selftest shows that re-entrance can happen
Date:   Fri,  8 Oct 2021 18:04:53 +0800
Message-Id: <20211008100454.2802393-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211008100454.2802393-1-boqun.feng@gmail.com>
References: <20211008100454.2802393-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-entrance can be confirmed when PREEMPT=y as the racy output below:

[    1.498285] second queue succeeds
[    1.500679] result of i is 1031665
[    1.501069] result of i is 1221348

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/workqueue.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33a6b4a2443d..1418710bffcd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6099,3 +6099,44 @@ void __init workqueue_init(void)
 	wq_online = true;
 	wq_watchdog_init();
 }
+
+struct temp_work {
+	struct work_struct work;
+	int i;
+};
+
+#include <linux/delay.h>
+static void __init work_func(struct work_struct *work)
+{
+	struct temp_work *tmp = (struct temp_work *)work;
+	int p = 0;
+	int q;
+
+	for (p = 0; p < 1000000; p++) {
+		q = READ_ONCE(tmp->i);
+		WRITE_ONCE(tmp->i, q + 1);
+	}
+
+	printk("result of i is %d\n", tmp->i);
+}
+
+static int __init work_reentry(void)
+{
+	struct temp_work tmp;
+
+	tmp.i = 0;
+
+	INIT_WORK_ONSTACK(&tmp.work, work_func);
+
+	queue_work_on(1, system_wq, &tmp.work);
+
+	while (!queue_work_on(2, system_unbound_wq, &tmp.work)) { }
+
+	printk("second queue succeeds\n");
+
+	flush_work(&tmp.work);
+
+	return 0;
+}
+
+late_initcall(work_reentry);
-- 
2.32.0

