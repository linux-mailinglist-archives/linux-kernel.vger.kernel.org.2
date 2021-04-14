Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82E35ED6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbhDNGos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348131AbhDNGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8H+EJ4mGt+B3VfDqn87L4ckdBLQjNt24eNYrYrDdYqM=; b=SzkGU00apWx8Q14rKjxM5fNxGl
        0tSr1zqTW22WvnT5OvJ+qJU+Cb5rHvxXqEOXJDLymlL84DnydJCTkAO+YVv7ijK4PLLVzHVB5X/es
        n8+NcJXGurZScswO8ZMoQ0NWJqV24ikW3V56par9+jB6ZMeY7zrfstogOiqfswrZlTlJbWAzcxNEI
        iQ6KbzzqXl3JWd6GZqk507YLKFDYrtaMhjBcSEaJxBu3P7FKk7dZ4tIMCABfCjB9GTNsIpmCTeVj+
        nOiD0uvVF/7RO9KAvO/OT+VnKB7SiH6lMGL64LacZKB0wcSix7OvUaAjLAWPEQvo8ccK47DxASdM9
        RIKeDBvQ==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZFn-00BiGB-Ch; Wed, 14 Apr 2021 06:43:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 2/3] um: elf.h: fix W=1 warning for empty body in 'do' statement
Date:   Tue, 13 Apr 2021 23:43:49 -0700
Message-Id: <20210414064350.3923-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414064350.3923-1-rdunlap@infradead.org>
References: <20210414064350.3923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common kernel style to eliminate a warning:

./arch/x86/um/asm/elf.h:215:32: warning: suggest braces around empty body in ‘do’ statement [-Wempty-body]
 #define SET_PERSONALITY(ex) do ; while(0)
                                ^

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/x86/um/asm/elf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210413.orig/arch/x86/um/asm/elf.h
+++ linux-next-20210413/arch/x86/um/asm/elf.h
@@ -212,6 +212,6 @@ extern int elf_core_copy_fpregs(struct t
 extern long elf_aux_hwcap;
 #define ELF_HWCAP (elf_aux_hwcap)
 
-#define SET_PERSONALITY(ex) do ; while(0)
+#define SET_PERSONALITY(ex) do {} while(0)
 
 #endif
