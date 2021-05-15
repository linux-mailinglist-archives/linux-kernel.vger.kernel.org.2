Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971003816AD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhEOH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhEOH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:59:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049DAC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:58:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 10so1388891pfl.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4GpRKqq0Hh8VXNoCmefE6hvFF64AcDKdWMSle7oESs=;
        b=Ssvka/b0GJcG9jPrn2r9Wwt/ENY3htXN1EGBow03T9l47EW+lNGy82T02tiFKoY/1I
         iuGRAP8qBD2VRPZIjyu1j8N9XHRjGx/aVzMexoeghgHShKZ87FVLoemWZx8nkrfGd5ei
         XtLT6qv3DkDBB+LoPytJdw5Rwv8kisDgXxtC85LBd7lDELrjKKnlBCKBazeoHJXHILUt
         04f57/N8K/31FPCDt8Q9jWmhwIkAMKPEDvlljld0Ta8i4VN0NWNcLBZL/H85aztFxKkB
         arXIUSxwwvoTn9+HC6pw2nl6yMObN2BoPDaOv7I1m4cL44MAb1OWL8NQjZNtNvVz+sZS
         cbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4GpRKqq0Hh8VXNoCmefE6hvFF64AcDKdWMSle7oESs=;
        b=qH6yKfFKuWZmxfji2XruTB3InVshCkHW86DwdFOu37mf1RMqpZm2iipavmkgA2RmhV
         gTjAayGvGDb/8usThkXV5dKeTdLSscPfY6gEAgVVmtkgmlpqj89CVBkq3Pj12Vb6yK51
         zuFtMqbaKgS0Ze8p/EKmSQfdaZ6jC4D8vgkacYhA2ufbeSSpRyRw/4dXBE6nPqKdVOmI
         xpvQkEPf1Z7CAtDTqSe/YuPreGviqNIPhnRiisJ8tgrM0chmgRrDsIfmciAg/3Lfdt52
         ycT9xtfEIGRyQoiWYWgpelr3K6x2uCHZGTehNHPIC859Xua23ze+MSxTP/w1q8kAm9ZZ
         cfpA==
X-Gm-Message-State: AOAM532jS7Pex7oYpdb+bG8+sUkaRju28Gepb0k1yPEVNkD4xjmfkwNu
        HW5smz2L0lFn+oxw9O65QYSRLNZycjs=
X-Google-Smtp-Source: ABdhPJxCSeNcHpbwVJefc0+GfVXBi+dCmEwmGQUuiSxdmxwFU6Ojxt1xPilU9mRxJHaerEHIELupNw==
X-Received: by 2002:a05:6a00:84f:b029:2be:3b80:e9eb with SMTP id q15-20020a056a00084fb02902be3b80e9ebmr30751843pfk.39.1621065495984;
        Sat, 15 May 2021 00:58:15 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id l18sm10350717pjq.33.2021.05.15.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:58:15 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH] openrisc: Define memory barrier mb
Date:   Sat, 15 May 2021 16:58:08 +0900
Message-Id: <20210515075810.163206-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This came up in the discussion of the requirements of qspinlock on an
architecture.  OpenRISC uses qspinlock, but it was noticed that the
memmory barrier was not defined.

Peter defined it in the mail thread writing:

    As near as I can tell this should do. The arch spec only lists
    this one instruction and the text makes it sound like a completion
    barrier.

This is correct so applying this patch.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
[shorne@gmail.com:Turned the mail into a patch]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
I just applied the patch posted by Peter in the mail as is hence it is labeled
from peter.  This also required me to set the Signed-off-by to Peter.

If there is any issue with that let me know.  I tested this out on my single
processor setup and it all works fine, it will take me some time to get my SMP
setup up and running again to test the other patches, but I figured I would send
this patch first.

Also, I got delayed because I had to rebuild my main workstation after a
hardware failure.

 arch/openrisc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/openrisc/include/asm/barrier.h

diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
new file mode 100644
index 000000000000..7538294721be
--- /dev/null
+++ b/arch/openrisc/include/asm/barrier.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#define mb() asm volatile ("l.msync" ::: "memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASM_BARRIER_H */
-- 
2.31.1

