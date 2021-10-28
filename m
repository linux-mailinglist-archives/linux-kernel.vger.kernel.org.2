Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4043D978
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhJ1Cuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Cua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:50:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB6C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:48:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o133so4565621pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abncWvOQe59IADgaUJmb1qCqctMDJgXlp15JUS3KD/o=;
        b=fGPyrBip5h+Av/2qPh929SJsKeiJYDFozhfF+YU26iIzBnpH8VzFuWWz0+hAWpS/tK
         vFZpJ16Eva/ZnTAqrVQadPx5gWdsapy3Ofu7JIRbv7tC1O+bhzny15olgSb1hXUQIkvS
         XkSYmvR89A/sqEjkhm1R5SlIVxgifcJZkxaZXuVf4qbrARh1KhYqMY7KO3f3P0WMbWaw
         Da7Lh7OJP44K7Z3FGZra9ieqJ5aeomjfb7jq21sHFPbyfza7DnwtIFAMWdW0DtUqNKuW
         +/L4CmUaIcupaME4BHxa8jtCDH4kLe3DayjmKuXq7JJ2Wu16z5hP5VvEeZhO7gi2s7VO
         K4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abncWvOQe59IADgaUJmb1qCqctMDJgXlp15JUS3KD/o=;
        b=EceobF1innsecTTDTTp141G0GmBLVTrReACVImgcayXe6ivYFIX6QRdxY91OplwzBQ
         INqSHnngrdLy0rrzYnXwn9VIDuMjarluJnSPfP5rCji8JtWv1x/8kSOgSB0QHpjNRDVa
         jKu2axbMZAGX7lPRHGRs4zSuXtf4w18C0Y7urhVEWh+sgIDH+kQ+d4Dk3LMenaf+ZqV5
         Jr6tSnnZqW7qFrhUM+YSHgXt9xWCfQnS9iBTovSeSNhM7GsbyamgajDQZpefNlRrHQPd
         oPhr+h1Yd+3RGjsK+yR7x/p1X8WcqCeIUdlCHAuB6j5lXCxVsrbs2btaWlE1NtB0UPpJ
         LeVw==
X-Gm-Message-State: AOAM5323dcECPYpXcatZyq0JhXSp2NHcCzn60Bni9Hn7L6UZvqMlMS62
        +eVyf7H25clWBFYqdTphyKTvlWH+J1A=
X-Google-Smtp-Source: ABdhPJwJDJnRIFFN8O4iARiVHyodB1HlpOnqM/+ik/cqJklwQ1cNFPCD5PTQsZIkNbAEJPvIivbc3A==
X-Received: by 2002:a63:33cb:: with SMTP id z194mr1219367pgz.380.1635389284386;
        Wed, 27 Oct 2021 19:48:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u4sm5697469pjg.54.2021.10.27.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:48:04 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] genirq: Remove duplicate assignments
Date:   Thu, 28 Oct 2021 02:48:00 +0000
Message-Id: <20211028024800.10659-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable has performed the same assignment twice.

The clang_analyzer complains as follows:

kernel/irq/matrix.c:289:25 warning:

Value stored to 'end' during its initialization is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e..0469f30 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -285,7 +285,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
 {
-	unsigned int bit, cpu, end = m->alloc_end;
+	unsigned int bit, cpu, end;
 	struct cpumap *cm;
 
 	if (cpumask_empty(msk))
-- 
2.15.2


