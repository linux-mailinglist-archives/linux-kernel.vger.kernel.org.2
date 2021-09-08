Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA7403C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351993AbhIHPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbhIHPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:15:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:14:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bd1so3505660oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8RSwNwX2H7BMlWVX1HWC1Xt2wrMksmjj16F2PcLcEg=;
        b=Z1gW/oZtZQFtFKNSJHhUWQSIn6dBnyhARlCqTGZBpD7r/85AF1CRGztwgSY0+NSunj
         Se2lROcgK2PeOVNsXbw71YwGjLS1KMTL3N1YsTq3ntdbAci69CiBeipunMmJa02bZPsM
         BXy3lQ4jzirLl8sxs/ZepPCzoCSSctatX23fZy47rcaBTXd7qKTG+dbN7ZxirsstT/kN
         zNbF0kNbrO4P2zkBhDVSHoriNXsaFNSyxQpv4jo0YPf83PhT42RIhcp6pl9NDXOwAWFy
         cnhhlkb9v4vQ11tlvGQopb/pXMgwK+iS5umpTK3li58/NW5q03ovtjHpYBJSxoQm6vz0
         ERgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L8RSwNwX2H7BMlWVX1HWC1Xt2wrMksmjj16F2PcLcEg=;
        b=dZO/B0/Jsof2gzdEa4S95oDGP/sFx3cSGozGARw4GGPZxD01MvjoDZYr5MLtU+uXd3
         uFgZ5j6E9keA61QvOTpLM5Zj2JVG9PtVxorNLVii7Udt4ZGgsBraFJyJ70Fc8Wx1SEBa
         Y+RUtu6adGYfNVpuCDYKdliF0yxgUEUn7R62PCLVY+livpG8bB1J3USYc9yqu1aiE3do
         hexgAtTyCqLcnGlAAsEh6iLnl+fz4sy3Wy0pBapEesNOjdjA90E0ht2COWF73yoJwaVU
         wuNhSHha7Rcqs2/UbK4lWnjwByse3+zFzWmMn1kWKCsTsSW76NOnr+b3BGHG4t61LvOx
         hTDw==
X-Gm-Message-State: AOAM5325woklQDndq7kErbp+WIaD3BAxk459dhP0Q25c/FBh/PgIPdgc
        9zmJn/2OHeGtaNYLLEyZy5c=
X-Google-Smtp-Source: ABdhPJyPY5ifjqnKJF+2A/YFgFXWI2WX2wtcPMEtS2qVdF+DTTNZ3e9/ZIb7i7DRmd9cS1e/srgDiw==
X-Received: by 2002:aca:1717:: with SMTP id j23mr2647663oii.43.1631114050326;
        Wed, 08 Sep 2021 08:14:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm486192otd.79.2021.09.08.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:14:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] trace/osnoise: Do not use 'main' as variable name
Date:   Wed,  8 Sep 2021 08:14:07 -0700
Message-Id: <20210908151407.217052-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 11.x may get a hiccup when encountering 'main' as variable name.

kernel/trace/trace_osnoise.c: In function 'start_kthread':
kernel/trace/trace_osnoise.c:1515:8: error: 'main' is usually a function

Use a different variable name to silence it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 65b08b8e5bf8..7a4c73b4fdcf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1512,20 +1512,20 @@ static void stop_per_cpu_kthreads(void)
 static int start_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
-	void *main = osnoise_main;
+	void *func = osnoise_main;
 	char comm[24];
 
 #ifdef CONFIG_TIMERLAT_TRACER
 	if (osnoise_data.timerlat_tracer) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
-		main = timerlat_main;
+		func = timerlat_main;
 	} else {
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 #else
 	snprintf(comm, 24, "osnoise/%d", cpu);
 #endif
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(func, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-- 
2.33.0

