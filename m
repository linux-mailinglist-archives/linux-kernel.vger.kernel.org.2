Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB0305276
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhA0DTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbhAZUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:42:11 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC2C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:41:29 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id a12so7438172qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TGJOvrZ6YusGx8SwYbSkGMVaG0czCOWmDVEX/tk9GM8=;
        b=bM/dc333woJ3FiR1xU/5IBWcQjK8xgcJ6YoZeR/tlw9Up1cgV9yMiOCmFmf5SBdSbr
         hEPBGJv1E60RBteCxCvdCaDeJzMdfMMH29/no0z6Ps21q8QQzNDFBgPvhCNCR/D2fbb2
         E5+PuoOkCjvWeQ4leNyIM2QzaMXIwt/tjBpzuUaGlfY5A996WXTIo88q8AL9mJXSWlJh
         50YfqAVzw64ygkhpAavhCJm3RSX0LDDd+tI8b5Dw/YFDCYsTv7j+jfLZrwrb7C0lk1sN
         NOQTFFK9W01VWTsUag9Kx1S0aVv0u7FSALXDuXiwrxPoK9BUR4LI8gdOm9Sfko6v7T1D
         fvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGJOvrZ6YusGx8SwYbSkGMVaG0czCOWmDVEX/tk9GM8=;
        b=emCi3u+s58sVB6klKVdT3xyz+iIFv1fRXugmzQ0g2Iqb1o0QlAuUG2AMVrC55vFRgV
         et9ZCWZ8rA9WyxYrYi5fI3uVlQ8UqlruhGPtaYUpoaXo8oLu86mqt7+vKF1fBblyEfqC
         A7pLVr30sxi6FdiDCvvNE1bJKXrgcoKuQwDHmE+E+NHAgnWjSNgtaHWpc4d6vNTi8+ps
         +P0JRDFP/PpwkW+R2CRTYNGAfqb436LBLj05hDhgXWNKvLKZgcqE9n91tIEV4GVm/1Sz
         lYMTseuWWS9EYRm2P0a89wbnnbjxVT8rAkC3agrm6LJfSXo14UVeFBRm54s4w0+hWJUf
         dr7Q==
X-Gm-Message-State: AOAM531ukiRE55oeSO1my+P4UwUr8wqfCs092iZ829ksZY0abvVhF6/j
        DwaFjwvZwgcKF/yEMlB0H11xklDcujegC0VF
X-Google-Smtp-Source: ABdhPJyb0PeFCrhX89qPm++fWrrAoqDmmUw9W0ZqSslo0+E0CEcEs2o6d72tI9D4b3+vJ0o8LGZWWg==
X-Received: by 2002:a37:9101:: with SMTP id t1mr7544156qkd.357.1611693689121;
        Tue, 26 Jan 2021 12:41:29 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 203sm15228216qkd.81.2021.01.26.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:41:28 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com, pmladek@suse.com,
        ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
Date:   Tue, 26 Jan 2021 15:41:25 -0500
Message-Id: <20210126204125.313820-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126204125.313820-1-pasha.tatashin@soleen.com>
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
machine_restart(), machine_halt(), machine_power_off(), the only one that
is missing is  machine_kexec().

The dmesg output that it contains can be used to study the shutdown
performance of both kernel and systemd during kexec reboot.

Here is example of dmesg data collected after kexec:

root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
...
<6>[   70.914592] psci: CPU3 killed (polled 0 ms)
<5>[   70.915705] CPU4: shutdown
<6>[   70.916643] psci: CPU4 killed (polled 4 ms)
<5>[   70.917715] CPU5: shutdown
<6>[   70.918725] psci: CPU5 killed (polled 0 ms)
<5>[   70.919704] CPU6: shutdown
<6>[   70.920726] psci: CPU6 killed (polled 4 ms)
<5>[   70.921642] CPU7: shutdown
<6>[   70.922650] psci: CPU7 killed (polled 0 ms)

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4f8efc278aa7..e253c8b59145 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
+#include <linux/kmsg_dump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1180,6 +1181,7 @@ int kernel_kexec(void)
 		machine_shutdown();
 	}
 
+	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_kexec(kexec_image);
 
 #ifdef CONFIG_KEXEC_JUMP
-- 
2.25.1

