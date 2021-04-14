Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBA35ED6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349287AbhDNGot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhDNGo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44126C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hk1NTwNqDLrF140nhEQHxgdsBtTmfCtpzPBKPaQ1eV4=; b=dYNLqKfkOPMZWMLXwNCW/ZMYu4
        cNEV1YNX77WkIC4E+qenv+7zsgKgZt5hrY/Xi8lccXqc33RM4GYGbSa8yvpoo6pkNg+h67vkwTvCg
        rxTYNWcQKwCsXMrDmuuH9FFd7cuZtrmvIoG5k7gZkZOnorr4IsXBWx/gfLL59ZMRRTzDTll2p90oQ
        Ia+L+OxMOfwSNkulVPrRrGbwW9383I2P+vCl/9I78v48/sZVxfgYzUAc/qstFmNKEzPUW4ugfteoI
        sjYw3JW/YpxY0hClqw8akszK3Du4wYrTp4QXA2W2jEUuW45apzDcS/IO7qLl7agG2Ytqb8IrcI9ne
        8/TPaqsg==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZFq-00BiGB-5O; Wed, 14 Apr 2021 06:44:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] um: stub_32.h: move 'inline' before 'void' to fix W=1 warning
Date:   Tue, 13 Apr 2021 23:43:50 -0700
Message-Id: <20210414064350.3923-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414064350.3923-1-rdunlap@infradead.org>
References: <20210414064350.3923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the expected ordering of function modifier keywords.

arch/x86/um/shared/sysdep/stub_32.h:80:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static void inline remap_stack_and_trap(void)
 ^~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/x86/um/shared/sysdep/stub_32.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210413.orig/arch/x86/um/shared/sysdep/stub_32.h
+++ linux-next-20210413/arch/x86/um/shared/sysdep/stub_32.h
@@ -77,7 +77,7 @@ static inline void trap_myself(void)
 	__asm("int3");
 }
 
-static void inline remap_stack_and_trap(void)
+static inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
