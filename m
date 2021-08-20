Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD53F24C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbhHTCbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhHTCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:31:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:30:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c14so4764390qvs.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dDO8IQFvk3b/3mftGukv998qF+9CC6ozN5n1pzzYZs=;
        b=sVLyX0zGnX0B/0qiwU/lMpR6+oaQfNGa38zRIK/1a1JjZuOtD2wXznePrgEl72xWIC
         FLFqnVjUFRm3ZHMgRs0HAp1+l7uPqM7uD7lJWBEZrTo0aB0v35lhXw6Fl6ql4J9gNDWy
         bs47Lh14ckFZHRPYKMWkHaNhHoQuaHllJ9C3ecA/ihf9mU782yxqQ8GKg/vwIqwHegZu
         MaGRnfEzPaOLiMTXDU2rUnUywXMbhYLMkC9osWwMyyTps7gNsASL9lkv6GB6FK4Emqgl
         vtQ3qdqltlfN1yxD7qhFZ6uUZ1ZTWDgCtbBwFEx7oWcBqNfauUEUI37ogYgmwd1d+koB
         gjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dDO8IQFvk3b/3mftGukv998qF+9CC6ozN5n1pzzYZs=;
        b=aqpvmJqqCl0UFvHuwtXoI4UTIHtqeyCkOgVEKIAoXPwqROT+JmugsYLfR0cyB69xfz
         Pl/DPKWpSPGwxm/oWO756/b1a0HVQhbMIGnqtmhGKDMlbXrdkdGP+eAqoiIyfWCOqw8M
         CN4G2AlvalPaVVmw+c5peM35PJ1wexkriky+fvM3WCuneF69aNrnCj34xo1brmpS98Gc
         GhL3oNofMZVNT3O2oczOrlyyLlqb8Wup4iPGv1nJ9pUf84E5bhIKxcsMEXmyCMx+TL+u
         cSuO0PqaHJFRF5SwS7XVgcnNlbETtwHDKElDKRW6EBtGYFUDXKN7MbiMIQaSm+riV8eu
         MMmw==
X-Gm-Message-State: AOAM530y7rqGNqPea/4IH4HpTKP5q+Zg8FI5wS+EsqNH3VI4bO30nYJ1
        uZlNS4DpuxkiIIDrC723mGg=
X-Google-Smtp-Source: ABdhPJwygHIuWQknl5q+ko6I2ZdUsYuS146OUMf1HEOvb4SZ9mYEsCSR4zWDbZMqZQXhvuK49LuQ9A==
X-Received: by 2002:ad4:5002:: with SMTP id s2mr1096913qvo.10.1629426626139;
        Thu, 19 Aug 2021 19:30:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y13sm2771746qkj.37.2021.08.19.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:30:25 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] firmware/psci: fix application of sizeof to pointer
Date:   Thu, 19 Aug 2021 19:30:16 -0700
Message-Id: <61d3cc7e5cd4a819381fcb22e1853d6f48a0c927.1629212319.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof when applied to a pointer typed expression gives the size of
the pointer.

./drivers/firmware/psci/psci_checker.c:158:41-47: ERROR application of sizeof to pointer

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 9a369a2..116eb46 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -155,7 +155,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
+	cpu_groups = kcalloc(nb_available_cpus, sizeof(*cpu_groups),
 			     GFP_KERNEL);
 	if (!cpu_groups) {
 		free_cpumask_var(tmp);
-- 
1.8.3.1


