Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E1353962
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhDDSVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhDDSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 14:21:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F924C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=q8pnsRJDvDKqpJCP8WecrNri19bEFB2pQG0otL5iCsY=; b=V2BR8zA4tVTQ3v+6pCT9UVlUO2
        CNMkhl2e4hy0LIdiKnQkybwsVRixtqMxh18ayNXWXmn+oBiN/d7viVpSxDDXK+phYqvAXL/fiH64B
        kzp+runpT05BcxkZAVKcqpv7AKcNBkt57c0qHm4Ft+6EVAHvNKMPQkOJAI5bfIIL43HTMmdosGK67
        7IeSFSMCX2aXa7UMAv746rIqEoCZOFP6JlwQ7MoA/WSSGoYNQ3pURC4qIBvQEZHftpxs9KIERVYjS
        6naM3KIUH6+TUM9rEqwAxNzIne9eJ6gXJzZgtgpDl5eLcueWwq6ePS+ZClVOLmMK+9jVo1I4ja4yA
        PxgEZOGA==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lT7Mk-00G5wC-UC; Sun, 04 Apr 2021 18:20:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: add 2 missing libs to fix various build errors
Date:   Sun,  4 Apr 2021 11:20:44 -0700
Message-Id: <20210404182044.9918-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix many build errors (at least 18 build error reports) for uml on i386
by adding 2 more library object files. All missing symbols are
either cmpxchg8b_emu or atomic*386.

Here are a few examples of the build errors that are eliminated:

   /usr/bin/ld: core.c:(.text+0xd83): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: core.c:(.text+0x2bb2): undefined reference to `atomic64_add_386'
   /usr/bin/ld: core.c:(.text+0x2c5d): undefined reference to `atomic64_xchg_386'
   syscall.c:(.text+0x2f49): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x2f54): undefined reference to `atomic64_set_386'
   syscall.c:(.text+0x33a4): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x33ac): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
   inet_timewait_sock.c:(.text+0x3d1): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_timewait_sock.c:(.text+0x3dd): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
   inet_connection_sock.c:(.text+0x1d74): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_connection_sock.c:(.text+0x1d80): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
   tcp_input.c:(.text+0xa345): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/mac80211/wpa.o: in function `ieee80211_crypto_tkip_encrypt':
   wpa.c:(.text+0x739): undefined reference to `atomic64_inc_return_386'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: kbuild-all@lists.01.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
---
My UML on i386 build environment is br0ken so this is not tested other
than to see that the .o files are built as expected.
If someone can test/verify it, please respond. Thanks.

 arch/x86/um/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- lnx-512-rc5.orig/arch/x86/um/Makefile
+++ lnx-512-rc5/arch/x86/um/Makefile
@@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
+subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
 subarch-y += ../kernel/sys_ia32.o
 
 else
