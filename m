Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8A430BBA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbhJQT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:28:31 -0400
Received: from mx-out.tlen.pl ([193.222.135.158]:38792 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344499AbhJQT2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:28:30 -0400
Received: (wp-smtpd smtp.tlen.pl 16948 invoked from network); 17 Oct 2021 21:26:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1634498777; bh=K4x9QhXuKOZkWxOZ1tfZPtZ3zxAXUZxqrJhTrhSSoaM=;
          h=From:To:Cc:Subject;
          b=XqGREuta1s0qalf2wmlNmSmRBkx9QEkpQGw1pBKAKrOUnhGwfQLLIqrZmh/jxW4Ug
           bTFGlybuXKKd5dI4ZpN57/oKiaLMWpfvpwKsThSytV1q21BGNRIhyWylSQNtvac4Aa
           8JT4UIgqgyIC7gOxfNOpgdpgFZcSDpGfFLTnmchs=
Received: from aaet142.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.123.142])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 17 Oct 2021 21:26:17 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH RESEND v2] x86: warn on native_io_delay() before DMI scan
Date:   Sun, 17 Oct 2021 21:25:58 +0200
Message-Id: <20211017192558.266809-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 14a9d553ccf097e6b09d7531a967c5c6
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [AQO0]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing to IO port 0x80 in native_io_delay() causes system lockups on
some laptops. This is handled by io_delay_init(), which scans DMI info
and changes io_delay_type on these laptops.

Therefore, calling native_io_delay() / outb_p() / inb_p() / etc. before
io_delay_init() may cause problems there and may constitute a kernel
bug. Warn if this happens.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---

v2: make io_delay_dmi_scanned static

 arch/x86/kernel/io_delay.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/io_delay.c b/arch/x86/kernel/io_delay.c
index fdb6506ceaaa..d6deca551a5c 100644
--- a/arch/x86/kernel/io_delay.c
+++ b/arch/x86/kernel/io_delay.c
@@ -29,6 +29,7 @@
 #endif
 
 int io_delay_type __read_mostly = DEFAULT_IO_DELAY_TYPE;
+static int io_delay_dmi_scanned __read_mostly;
 
 static int __initdata io_delay_override;
 
@@ -37,6 +38,8 @@ static int __initdata io_delay_override;
  */
 void native_io_delay(void)
 {
+	WARN_ON_ONCE(!io_delay_dmi_scanned);
+
 	switch (io_delay_type) {
 	default:
 	case IO_DELAY_TYPE_0X80:
@@ -123,6 +126,8 @@ void __init io_delay_init(void)
 {
 	if (!io_delay_override)
 		dmi_check_system(io_delay_0xed_port_dmi_table);
+
+	io_delay_dmi_scanned = 1;
 }
 
 static int __init io_delay_param(char *s)
-- 
2.25.1

