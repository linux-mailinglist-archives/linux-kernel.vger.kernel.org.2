Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC87429B96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhJLCoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhJLCop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:44:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150DC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:42:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so12502547plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUZNyx5htxff71EbFmVuD0Yu7VSVm0ACLRwonRHrL/w=;
        b=Df/J8h/IIPisq4+P9vX5ewRdfszwPAcb43WAL9TKMuVTDPfs9TjcMtNUcL5tKh2+Ab
         w+ot9MdWlwlZ8bl31kRRKIaOOCiZX2yfgjhFWAvexC9BROX+f+sgzi2KVbTm9b0cRf0C
         YKXug5a7y31fbXO9scy5Q7iEnR9du8uE5V3c0zZ9paK5OJtYrARuCwSEu6h5uYyuOvTy
         PNpidtIXN3vVIxeY40R1CrPSeqBt7K6v0ZzfX0K2EG4G9hwn6+IsV8SExRZs+04e2k5O
         d2dDgbkfFxbolCQmYeGfxmBvtdnpknpSVQNikQ2sB/LJIUD+HOyD91/5l1jA2nL9ixjs
         4HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUZNyx5htxff71EbFmVuD0Yu7VSVm0ACLRwonRHrL/w=;
        b=SS/+Tv7tm7cn6mPf4WMgP4BhWytPdX8HBtEsxUIBuN67QT4bkb9dMkraT7UEJuOq0y
         eHN3kaKOOerdWz8nauyllIvtY6vXY/ZTE395UM9tAkIQNRXnGsF9SMCI0nPvdAE7Kuv7
         KmRNkHEWV47Da7FOM25/4d9qFZiXXcj3dtMTzufa3IIIlTx0svIzekt1WsQ01CUnt/pB
         mMKpRmfVFVliOVL4iaJYNBdRHZUyLSq9Js16KVQL9fuFLL131B6mdK+wGihbezZ4pxVB
         P36ss9F++vC7pkoyHR9eI6lXbMwtPdw82moF2YPl3PFpl+VuWEFnnSf3NDrmUYeq1vy6
         oLQA==
X-Gm-Message-State: AOAM533YI7XGWxBFDil9niqj/k9LUQlJsC+0DZAYuNX0Et9pQUHiqtoR
        e/0BPu3tSFKXWL7Bb8qYOUo=
X-Google-Smtp-Source: ABdhPJzrEQCz2pZBzEJpwd1StOnnDm/6LEplQpSJ2fk/hJfrP18Wsz/HOEJAI/Tn9U3pZQyp0JxN1Q==
X-Received: by 2002:a17:902:7781:b0:13d:c9fe:6184 with SMTP id o1-20020a170902778100b0013dc9fe6184mr27600948pll.25.1634006564036;
        Mon, 11 Oct 2021 19:42:44 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id k7sm9056075pfk.59.2021.10.11.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 19:42:43 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     mark.rutland@arm.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Yang <davidcomponentone@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH psci_checker] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 10:42:29 +0800
Message-Id: <20211012024229.180058-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./drivers/firmware/psci/psci_checker.c:158:41-47:
ERROR: application of sizeof to pointer"
Using the "sizeof(cpumask_var_t)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 9a369a2eda71..13161c93283f 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -155,7 +155,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
+	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpumask_var_t),
 			     GFP_KERNEL);
 	if (!cpu_groups) {
 		free_cpumask_var(tmp);
-- 
2.30.2

