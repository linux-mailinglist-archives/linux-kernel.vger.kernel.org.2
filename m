Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6753952BF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhE3Tc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhE3TcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622403045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Inh1PHt5dbAJobqxzcE50u+vc7DrQ4HYKLzWRGMOmVg=;
        b=SmVRbDIR9y12SMWwFELCePcum1bMAgXrHDJuCOfG6rCI0x3GIS90Cyppg4RzRl7oqreM+h
        Vmkxakkvjt2fV8LpOv6FGCQRhsdgpM6NP3aVpHEpHWwxjex9Igma3rsNM/cbO24gLmhcgu
        LiiYiEf89pk2xHFGfTstw6KiPUbA2Qo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-D1iY4jUZPSek7aGSEcfg7A-1; Sun, 30 May 2021 15:30:43 -0400
X-MC-Unique: D1iY4jUZPSek7aGSEcfg7A-1
Received: by mail-ot1-f69.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso5530728otf.15
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 12:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Inh1PHt5dbAJobqxzcE50u+vc7DrQ4HYKLzWRGMOmVg=;
        b=COuNJ0F8cDRtiZp6GaVCNTe60DlZuHA+VCUylaGe6Naa4xyL10mES19caZ7L0G/EDd
         +dT/CeyXa+i7Yk3wNkzDwDluSpo1AapkxALUQwUljnXuRy6x2CbCIooSpvS6JayhGOKr
         L+Dw8g6Ru6JmVg0lVfzyB3wKzfiMKkWp2E4t35XcsliTBLywRQ5JqUTgqCkVCBZdrkMl
         K9HgOo5mtfTLlmP4Wg20LzHVshtcDSD9y6V4E2nNoc3/uZQuGw48KZlhqyyi9yZ30sBG
         faThm8rBLHI0uDFX++Xhxbu6ruzuz16R18LIE0CzFemA8RKj8J+x5ARAnFLWKfs6epbo
         +UKA==
X-Gm-Message-State: AOAM533HS51J65Y/3brTLCW/vvP/chb3c4yTq1F/f3Yu9Yd6myY3p/Zv
        3kYmiSmIJzNB+3RoPpOa80xheaP0zD13X6dM994QuwQ9VPIyiQTQer0fOGSAhQQUptcV29Jb0ad
        Tn1CmKykk5kUcclTGqT6Qviz9
X-Received: by 2002:aca:3644:: with SMTP id d65mr14752372oia.122.1622403043251;
        Sun, 30 May 2021 12:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaj7wrzzarPpLxINr8zkTybNbVcEKx8OicqDyLmSERfbyOYxwb8oVl9tNLDX4YJb44GilUVQ==
X-Received: by 2002:aca:3644:: with SMTP id d65mr14752369oia.122.1622403043145;
        Sun, 30 May 2021 12:30:43 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x9sm2581732oto.79.2021.05.30.12.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 12:30:42 -0700 (PDT)
From:   trix@redhat.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/fair: cleanup master/slave usage in wake_wide()
Date:   Sun, 30 May 2021 12:30:39 -0700
Message-Id: <20210530193039.2556526-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

From Documentation/process/coding-style section for
inclusive terminology, make these variable name changes in
wake_wide()

master -> primary
slave -> secondary

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..ade9f065c690 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5754,13 +5754,13 @@ static void record_wakee(struct task_struct *p)
  */
 static int wake_wide(struct task_struct *p)
 {
-	unsigned int master = current->wakee_flips;
-	unsigned int slave = p->wakee_flips;
+	unsigned int primary = current->wakee_flips;
+	unsigned int secondary = p->wakee_flips;
 	int factor = __this_cpu_read(sd_llc_size);
 
-	if (master < slave)
-		swap(master, slave);
-	if (slave < factor || master < slave * factor)
+	if (primary < secondary)
+		swap(primary, secondary);
+	if (secondary < factor || primary < secondary * factor)
 		return 0;
 	return 1;
 }
-- 
2.26.3

