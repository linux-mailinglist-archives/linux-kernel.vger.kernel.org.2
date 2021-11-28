Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65404607A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358481AbhK1Qkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:40:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358557AbhK1Qij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:38:39 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638117322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=y5DlAw5YhOVaK5VzZnJ3n0hgyQh2ZS1Mor+t0574Z7U=;
        b=ELCZ2rx1vInZwPFgR6y6NcEQCNM2tM/D5DPypiKVg2/7AMMS8z7zxvfcof2jXqOofbr+KZ
        PitFgM1LcV2KUZZpwCAyE8l9qp9tGqZlgIIRI8P5C4CCbUq9EMmFQr2Mq/OWSt9O4lFImd
        iw8lxv/YFqr5EwxBv/OhPBo/A7RTgqPZmZDrI/qzu1klMTJwoBPF4WJgqSqVVC2WS3Vj3V
        SJKOI84jAoCUqATjJp10ZT6XDR7tmv/L42fQt0PeVefwgJu7+h/zUZi4/uTKnMKlGr0W5z
        ajeYIkvoCxWrLmD2lKN2k4rIfwlqfUfYbtlm5WRVOJNWgWlumRMKCoSABOwOIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638117322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=y5DlAw5YhOVaK5VzZnJ3n0hgyQh2ZS1Mor+t0574Z7U=;
        b=ACdPSZ1O8IQcW9+aXoaCyRKeHDUyG20Po2d52FbNjWHa7Jn9E5GpS+0ZVMLwXlWdOEbZhe
        HmMd7PXg2K06w3Bw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.16-rc3
References: <163811728418.767205.14544746031342483043.tglx@xen13>
Message-ID: <163811728858.767205.8050385026777394335.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 Nov 2021 17:35:21 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-=
11-28

up to:  c0f2077baa41: x86/boot: Mark prepare_command_line() __init


A single fix for a missing __init annotation of prepare_command_line().

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/boot: Mark prepare_command_line() __init


 arch/x86/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be738ae7..6a190c7f4d71 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,7 +742,7 @@ dump_kernel_offset(struct notifier_block *self, unsigned =
long v, void *p)
 	return 0;
 }
=20
-static char *prepare_command_line(void)
+static char * __init prepare_command_line(void)
 {
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE

