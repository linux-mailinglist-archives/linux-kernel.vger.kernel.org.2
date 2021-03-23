Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C46345531
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCWB7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:59:08 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:56898 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCWB6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:58:36 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 9DDE8400208;
        Tue, 23 Mar 2021 09:58:33 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] arch/powerpc/kernel: Duplicate include asm/interrupt.h
Date:   Mon, 22 Mar 2021 18:57:25 -0700
Message-Id: <1616464656-59372-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEseQh9ISUNKSk9KVkpNSk1PTU9MSk9KS0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6Eww*KD8PEjpJEDQ8FjMI
        Nz5PFClVSlVKTUpNT01PTEpPQkxJVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpDTE43Bg++
X-HM-Tid: 0a785cce185fd991kuws9dde8400208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/interrupt.h is repeatedly in the file interrupt.c.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 arch/powerpc/kernel/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c475a22..6deaccc 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -9,7 +9,6 @@
 #include <asm/cputime.h>
 #include <asm/interrupt.h>
 #include <asm/hw_irq.h>
-#include <asm/interrupt.h>
 #include <asm/kprobes.h>
 #include <asm/paca.h>
 #include <asm/ptrace.h>
-- 
2.7.4

