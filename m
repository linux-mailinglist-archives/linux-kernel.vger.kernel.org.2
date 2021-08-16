Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A543ED31F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhHPLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhHPLfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:35:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBFCC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:35:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso27084089pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uTWDBNi6gTv/e5E0tvAcisNF+AyHlVmsBNOwg6nhosY=;
        b=uiJ+O46LF9jTBxwtfXWMff33cOA8Ou1xpCH0ZVK+7dXjEgjcJgHspSjXykP/2bYEk3
         8CvEI7yJK7uJQt1d0xW4Lv/CgqsT4Uh6VVjwSLV9Ux/liECea6NzQYGNLIurqx0rYv0H
         LtW5z41qVvSPG/gq5p2LQklYCM84sHmjWQuAWXCSQzZIPJ2XBmWsqftnIS7Sd5rSNrzH
         1PrR8dXoEn6XY4trxBdPXl/1DjWe5XIDEY98vJnsO/l65arpeTRoaBWdU1J0IVs9kjQU
         stqU0hpBDbBhvDBy2WhsulDGbw5x7zke3HfjUSoYuwvm7njhzdJrlUMDIFVGeKGaexxk
         1l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uTWDBNi6gTv/e5E0tvAcisNF+AyHlVmsBNOwg6nhosY=;
        b=seIthzx8v5dEAHmAXJwrsZ9Z7ZG4Oj/ui1Xjz7hnv3LpkvMFKuXX/R3KHvh/8DW9sw
         /HJ9sVzRPdtCorNxhoUJAxPdS9tw2lEO98BT94YcDjoYuJJyBnkY5oghK7eXdMI0XNUP
         Hd6DWgZGNvN2PrhNcI4eOX545nAYy9OmHstV/XivpwIglm1y7kNJ1hiDWnpshTGiWptS
         sdm9CTBk0QhSH/7m7DwzN7GeYrneIYOiO7h/nGOLyDNArhAXu/t1Axd5tQSJbeEKBZON
         hCqzSWVDuSxDiENXfw/8m+oeRn2CZ65zIgn+xvh12xBwqQzQ1xBwlqoOeg43Nn+COJLM
         XasQ==
X-Gm-Message-State: AOAM532KNKFN1P0s4kqd864BZ7jQ+eXOW/9IUbGHMBd6a3ss3p9w8qpP
        FV2czIfVYu70ZNl0W+6cruI=
X-Google-Smtp-Source: ABdhPJzwO6blgdz0F18gt6MsWwZVdFCucyeH3BBL9qX8uGuPL/I7OdXuyzBIis+56p29NRMkXFFIQA==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr16901957pjn.9.1629113705802;
        Mon, 16 Aug 2021 04:35:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l126sm13677088pgl.14.2021.08.16.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:35:05 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] module: remove duplicate include in interrupt.c
Date:   Mon, 16 Aug 2021 04:34:53 -0700
Message-Id: <20210816113453.126939-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

'asm/interrupt.h' included in 'interrupt.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/powerpc/kernel/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 21bbd615ca41..8a936515e4e4 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -10,7 +10,6 @@
 #include <asm/cputime.h>
 #include <asm/interrupt.h>
 #include <asm/hw_irq.h>
-#include <asm/interrupt.h>
 #include <asm/kprobes.h>
 #include <asm/paca.h>
 #include <asm/ptrace.h>
-- 
2.25.1

