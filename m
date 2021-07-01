Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2A3B9134
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhGALe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbhGALe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:34:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10705C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:31:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i20so9487133ejw.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FmtdxOis7coO9k+gaiCcCyUMKsZ9c3EqRvmf6cQ5KiQ=;
        b=aEUSRQBlIDkvvPUTeivottL5W++CYoyqDFLwMSe5MT56ebDlBeu3x7ynw39wqy5ULT
         EVNv9znuUeHmo5uDmv1Q1heHi0L92gP2Gp/oFhE2Yot04q3zjvvjWrN4XrJQWuxBGwkZ
         rhFUirEkLSh6dcXG3lcCdspTYIPK5dZoK1/xDFgRdAS4lpFPmVMpKs4PYX/2P2nlPED2
         Mvkt16/1L8xE57CpSlY0Cgp7PGrA1GavpLeNTbNJTY/sqqMwu5wDVRCHm3zXhH0+PKXI
         lxJbwN7XXVYt5uyPJkmeko6l7LAlcA9HZiLXaGKNnxuCRug2A49vP6KCDghDTYvuoBwY
         dVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=FmtdxOis7coO9k+gaiCcCyUMKsZ9c3EqRvmf6cQ5KiQ=;
        b=kNvT1TdZOlPDVCzd5fTAo1sXgs1cQ8MvzCnbs3qJ9rohkke8p7ARB4ScfcUMzSL0Nd
         w7miQ7WluTg3gDfK/DiqEnGuIERvTOFvtOZi/S+44yIiqheofqS1idtcsFrN8g4LVoac
         LrMCrts6MML9yccut6mbTQTnIZXBhMMmgWKDsIEi0QLwoyZcb5VvhB5VHV+vg3KntN37
         gFLI/s7/UWinZf/pLhNPj9V1IO01vuCNH/66ngKcBFCd24MkfNdz9OaktKt87FIuY9X1
         en8yzmZYWlRn6LBMBMkLAx84GATBSPIc9I+VPI/8IDeknxMQO33QR9HMG3a7mCpkuH1Q
         8Qmg==
X-Gm-Message-State: AOAM5337jHkzbd2ocpKSPuLBmcfHVnRYJh2vM+jvQ+E2Gb19dIKcXihK
        GLSKUAKDzhr6+74l4GMe1bk=
X-Google-Smtp-Source: ABdhPJx6ZJ1sCagV5xjDEPzyITSQZoz9NeOP24JAymNo0yUDjvWu9ajnFb856MjRJv7dWDAQlMz87A==
X-Received: by 2002:a17:906:9e05:: with SMTP id fp5mr32592820ejc.376.1625139114657;
        Thu, 01 Jul 2021 04:31:54 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id hw6sm5390927ejc.37.2021.07.01.04.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:31:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 1 Jul 2021 13:31:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/features: Update the ARCH_HAS_TICK_BROADCAST
 entry
Message-ID: <YN2nqOVHgGDt4Iid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Risc-V gained support recently.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/features/time/arch-tick-broadcast/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 8639fe8315f5..8dcaab070c7b 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -22,7 +22,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
