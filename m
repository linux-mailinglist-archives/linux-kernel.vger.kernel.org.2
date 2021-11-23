Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE61E459FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhKWKCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:02:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhKWKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637661581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z4SVdriUsPLrl4wZFTKmXBFzP4Q4i5HhaOV+C11ofG8=;
        b=jWinhcHgKjTlV4FpbnnVXnFvwUTkElroCzJcGOV9unex8iAZGCvaoH3L9Myp37CnYK4Hfj
        0bh1HUTM0Qvz1DW+yNyrGxEJ4IVhz1BPyMWM3XdLbP6WMfOUR22pXoFQo0diHTvvQ2394H
        ymCIJJTBVWuboeBX673oVGro+Vnu0bQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-420-PaYYzc32OiecQr5wgMZxaw-1; Tue, 23 Nov 2021 04:59:38 -0500
X-MC-Unique: PaYYzc32OiecQr5wgMZxaw-1
Received: by mail-wr1-f70.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so3625072wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4SVdriUsPLrl4wZFTKmXBFzP4Q4i5HhaOV+C11ofG8=;
        b=eRs17QgsT14o9/4rpgwGVV66I7rufr24d6pRcktresvkfP9Pe6Iy+mlvj0qZAmeDkt
         HWU+fwIaqtI+ClupHUjjGX4rQgC+26m82tTfjBAcTsDOTSlmyRs1sOZvUMfMqv36frAi
         DkgcJ5Ff+sZ1fMQnCp8vY1UbSsj0mAzGJGegYPdVu/Ly7nap3BxT6gjH53Z1LnfcNsq5
         cNOt30JFsXr3u0Qeub0zDgRkaFejAOXC+WDFXSOyT7IYVRPZXlsrMyS6hSxA0Hd+lFWI
         G9PTUtzQBK1wygc0p1V1HeVZm5PDXgqI/6SwNYsOBYh7Js6Xr80gJ1rcRjrV8ESjy+BJ
         h1GQ==
X-Gm-Message-State: AOAM5330SEFwKBqTiImg9EZgV5ZHJFxmhYa49R9dEwNiRg7tcqxdzPQD
        VL4XM7qprLc8AI69IQUpmrZgcJ3DJlWI1eLIJPh1b/77t/5lBuODq+zf5NzW24oYTSKo2d0mcKZ
        0QAYfy8utCybjq52fsqCJSExJ
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5500302wrr.314.1637661575003;
        Tue, 23 Nov 2021 01:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWOu0SWv8Jr5Pwq4WJKrbjdn4sATqjzvbSSS5Cj48IhMI88GC2pqQ7BCmzHUQyaOhiFVTe5g==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5500274wrr.314.1637661574780;
        Tue, 23 Nov 2021 01:59:34 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id bd18sm538888wmb.43.2021.11.23.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 01:59:34 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, juri.lelli@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH RT] arm64: Allow selecting KVM and PREEMPT_RT
Date:   Tue, 23 Nov 2021 10:59:28 +0100
Message-Id: <20211123095928.21525-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
function") all arm64 exit paths are properly equipped to handle the
POSIX timers' task work.

And with a68773bd32d9 ("arm64: Select POSIX_CPU_TIMERS_TASK_WORK") we
now handle the timers in thread context.

This allows for KVM and PREEMPT_RT to coexist, so update Kconfig to
reflect that.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

I guess this could be squashed into 19614b91cc83 ("ARM64: Allow to
enable RT")

Note: I did test this on an Ampere Mt. Jade based machine.

 arch/arm64/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bd4acc2be02..260866cf53c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,7 +89,7 @@ config ARM64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
@@ -216,7 +216,6 @@ config ARM64
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
-	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
-- 
2.33.1

