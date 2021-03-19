Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D76342620
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCSTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:23:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB540C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:23:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q3so4108537qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BYTHl36kn9kfJcf6UwXe3wIty+C7YB3UI4HaqKn0xcA=;
        b=UdFFhQQTfUrDQc6a5z2KU2Jqm8+k8dGKdfeCNIRfkCjaeIKtf4uC29isjm2t8miMYM
         B3LqSV2RuBGkLHIET3hJlrRVdyRQv3XEBNgxEa8m4cXabmDj+voWzeH1ijS065X2IaZh
         c4Yf+95sNcVhPdn5FR01sNZhChMCx45BmBtg3YVaTK/8jzA6jEd/DjS+cgU7gDU9CyyM
         Qbh3Qn3XFahri33vNOAhAazdJNVlgNt/D2NYpSITX4Y+8Bs8wef3Ult90DCYTmvYPxVP
         i92i7Bvh+9+lq8LKg3ygve+23TyGpOneJwSpAFrKCF6hu331kpi3vJx4HFJ+G5kEhbAN
         msWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYTHl36kn9kfJcf6UwXe3wIty+C7YB3UI4HaqKn0xcA=;
        b=Sws73VfLf3ov0WmqILWxEeJOgA/Bx/pk29rN5DVHOVVzCy+IZsQOcoywKn3ShcnDnE
         IkBpRgzBLIJTmxkm5+9QasJXfONQNzEx469BBDMomXwdQlhiwYnsxBS/fMag0Sn91ZE6
         kr0nWoPEqfSj38nYgOsWzMY1XuOvyqNWoCA0t3t8poTZdNY/KomneDbAMSnPmUiAWs8L
         cqRB+joVpUm8EQj0tkpczah09FiRid9DFD7bKMr/4upBwpt931Q0mB4mOynmDunGwdhl
         S2SdExaS1+1nwwtEXGWV2Xn1BXcySRLZ3ORgdtflB5CYaCgh9rUZbLi+YnJBbQNDUtR5
         +2TA==
X-Gm-Message-State: AOAM531air5QTaLvIkFhthNb2DmJK9hlpKlJEV5xJ/CFC0KrdmaW5lWC
        YwlZrOSWIHEUPnkgrMyBBAxPlw==
X-Google-Smtp-Source: ABdhPJxhQNMzILo6apipih+5ZUXIQwvOCZ2L6DQnl/0NQbprHKrXYZo5f0DI0jchWE0QlfrfT5sadg==
X-Received: by 2002:a05:620a:22b7:: with SMTP id p23mr123466qkh.365.1616181809188;
        Fri, 19 Mar 2021 12:23:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id h16sm4362835qto.45.2021.03.19.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:23:28 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com, pmladek@suse.com,
        ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH v3 1/1] kexec: dump kmessage before machine_kexec
Date:   Fri, 19 Mar 2021 15:23:26 -0400
Message-Id: <20210319192326.146000-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319192326.146000-1-pasha.tatashin@soleen.com>
References: <20210319192326.146000-1-pasha.tatashin@soleen.com>
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a0b6780740c8..6ee4a1cf6e8e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
+#include <linux/kmsg_dump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1179,6 +1180,7 @@ int kernel_kexec(void)
 		machine_shutdown();
 	}
 
+	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_kexec(kexec_image);
 
 #ifdef CONFIG_KEXEC_JUMP
-- 
2.25.1

