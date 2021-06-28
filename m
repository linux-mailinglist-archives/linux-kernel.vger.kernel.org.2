Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D903B58BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhF1FxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhF1FxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:53:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B576C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:50:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w17so8456978edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3ELu6RuiUNiclS07JxaHoXIOglq+3DaLEhzbqrS+pHo=;
        b=Drwg8qwvcp1ADogVCxHnwobhqYqKeWiggrWpCltmedAnb7hEZ9KjliMB9DuzMhiC40
         BywW/qOP25mplzD6KRdnlwFDoByL7/zuYwfIWc99/1+xeIN52tvDeqa55mxbxTtOk8+v
         RdcVkd/Lj/pcoVTKfKGgnLRLmMZenaUqkPj1P/T7GdNznY+4UaLocmdKDryFugq+Y8re
         v0PGm23hdV+FeReAygM5L2wcaRcVyGQIZzWudJMIBKN784KeMrIqRRpggeU61GZ0TCsn
         j9r11Bi8dewft0d9++uxOZTtP5REwG9uBzJpfJxHY4L1ESBwYo4gtdVZPZ+XMjB62B4Y
         NJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=3ELu6RuiUNiclS07JxaHoXIOglq+3DaLEhzbqrS+pHo=;
        b=pWeuUXMJjlAz1kcliFZ+yCI0Fg/lTjn+0OYUU1G0KJs2XeUAXHxigIu7lAkiEmWldh
         JNoXT8VyYhgArzIIL2lPjuo0mmhQ98Tv+viOWSimmDwiN2Z0ySz4oqYUMqJeUgwjlVR+
         LXUIo6Cqzk1ni5vW7ovjcK2QSFfIwIEyvIK/ddsXzi0GpUvLEps2YrKxPl7MnxB7Y3ie
         luMnuJg9kYPqX9MoOHqXEq0PfNaKu+EWK1gBBpzN3cWrnSiauU9fu3vvI33gMADG9f39
         sST6rspCEIoNrVdCg9j/LFDT66OCGEZEwYvrgCQAO6dSXJCnbQ0ZWnX94xN3xy3TO/eo
         ao0A==
X-Gm-Message-State: AOAM533GtqdyJ0gU5emMxDJ4m6aXPDVNkUviZhJJmPKRSipljkAd39r2
        DiXPjvtlDQI60ApRB7DmqQo=
X-Google-Smtp-Source: ABdhPJy+lk9aibdbSxw03bC3vyRw6Gx65ZUjn1AmU9C9ViWDhUu9PWyKhB9EiEFq8vNgdqcTX1Fc8w==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr27221891edv.217.1624859449954;
        Sun, 27 Jun 2021 22:50:49 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id j19sm8821959edw.43.2021.06.27.22.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:50:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:50:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtools fix for v5.14
Message-ID: <YNljN5OXy1opw86H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-28

   # HEAD: e31694e0a7a709293319475d8001e05e31f2178c objtool: Don't make .altinstructions writable

A single ELF format fix for a section flags mismatch bug that breaks
kernel tooling such as kpatch-build.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Don't make .altinstructions writable


 tools/objtool/arch/x86/decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 523aa4157f80..bc821056aba9 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -684,7 +684,7 @@ static int elf_add_alternative(struct elf *elf,
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_WRITE, size, 0);
+					 SHF_ALLOC, size, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
