Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FC3E2E00
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbhHFP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:56:08 -0400
Received: from pout.email.it ([77.93.251.230]:60134 "EHLO pout.email.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243362AbhHFP4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:56:07 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2021 11:56:07 EDT
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id 00322CD171;
        Fri,  6 Aug 2021 17:45:45 +0200 (CEST)
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sdb3HtwtrqsH; Fri,  6 Aug 2021 17:45:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id C970FCD178;
        Fri,  6 Aug 2021 17:45:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at ir-mtaout02.email.it
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id USRKzVX4vKTy; Fri,  6 Aug 2021 17:45:43 +0200 (CEST)
Received: from ir-zstore42.email.it (unknown [192.168.25.42])
        by pout.email.it (Postfix) with ESMTP id 76745CD173;
        Fri,  6 Aug 2021 17:45:43 +0200 (CEST)
Date:   Fri, 6 Aug 2021 17:45:43 +0200 (CEST)
From:   blinkin@email.it
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it>
Subject: Bug report for kernel v4.15-rc8+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.146.250.201]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_4059)
Thread-Index: NENq8cTB1VaI53n8f06VZiCziLFHzA==
Thread-Topic: Bug report for kernel v4.15-rc8+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think I found a bug in kernel 4.15-rc8+. Git bisect tells me that the incriminating commit is https://github.com/openSUSE/kernel/commit/a0c9259dc4e1923a98356967ce8b732da1979df8.

The bug doesn't seem widespread and it may be affecting only my hardware (Asuspro P2530UJ laptop).
I also found a workaround (boot kernel parameters combination) thanks to your comments on this (seemingly unrelated) bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=208097

I'm not sure where and how to report it, the kernel I used for the tests is built from the opensuse tree but it looks like an upstream bug.
Can you give me pointers on how to proceed from here? I can provide informations about the symptoms, the hardware config and the workaround but I know nothing about CPU/IRQ management in the linux kernel.

Thanks for your time
