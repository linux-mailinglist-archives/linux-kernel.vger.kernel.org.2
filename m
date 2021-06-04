Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815239C15E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhFDUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDUfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:35:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE8C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 13:33:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q10so10640908qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=MlTBKidQyHo/iudNRHQBYNyS5NXewQpCbPeNYyMvaMg=;
        b=DW6ijiYHDNyQLpF0t6/qCOumEQ16A0epv6YQ77X8CzKQ7yMANg3RdZoYSbWgzNBFeC
         cnO9Ye5O+9SFKxxx+BjZMS43UwHrmdmZ9IUb22rV3zFmVaFtvQ6RDrYZ6H+J1vfWJx5k
         nXDsjaRkYLdT50Mpq5H/iJtTGy72Dl8GYUXUMgcV2jmRJsVyuWYWi6uwwXmIRRh+moiJ
         NMng52iEQpz7ATjURC0jP7pMlkszHz6Q7JMPKaZKsG6Hi4eZP68QHCC2uy2jhj7pXewV
         7pjbvoALbklLcyrwWAgFmh/x5knS17J3d25LYp+ClhBmJhZtI/XDvZedFEwn1CTYoWlb
         84Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=MlTBKidQyHo/iudNRHQBYNyS5NXewQpCbPeNYyMvaMg=;
        b=qYZf+mKoluNNUP/WYc3atPnSTWRzn5jiGrj3yT0LAwfN8x/gPIetOb659a1W+ziirt
         Wsu0YyHheROB9iBcgZQoN66vd7abWMTZvxzjYfOygSoxXM7mo0gCJInuiBNMPqvdkxP1
         n0XAyhMM7u9OKmtdhjOf5UI+u4pkEP3kG4//z0fHSuHPe6Z1bjclG0qDAGdbaYNc87ST
         t+b3Wgb5m/6dUHOIPU1u91KFotNHZFgbe2ZQsh/MUvV25TX7H423G1UfKWrF8odZGfuu
         obeh1CmRChK4vHX7QL+a0s0T1/ZHD3pFqXvGB8jx2xpXUFJ/M5Fy2m0OFs2avjc10ULf
         ge2w==
X-Gm-Message-State: AOAM532eTkIoiMXrRj23uZvPcyOX/0tcTezR9vW7/aD/bUUqVqj8nNnM
        +Vh2rjP3JX2jXHw3LPmNNEzvkg==
X-Google-Smtp-Source: ABdhPJzTFU/XiVvGZk+dyAt2khreqsQd3BqydaIl20gYpk2Z23bK6lpBl5FC/vgYDJM5tYwQH79MRA==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr5995516qkl.45.1622838811230;
        Fri, 04 Jun 2021 13:33:31 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id p19sm4541856qki.119.2021.06.04.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:33:30 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: x86 - weird cross-compile build problem with try-run next-20210602
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 04 Jun 2021 16:33:30 -0400
Message-ID: <454425.1622838810@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I built a gcc 11.1 cross-compiler targeting x86_64, and builds
were throwing an error message:

Makefile:149: CONFIG_X86_X32 enabled but no binutils support

so I added some debugging to arch/x86/Makefile:

ifdef CONFIG_X86_X32
        x32_ld_ok := $(call try-run,\
                        /bin/echo -e '1: .quad 1b' | \ 
                        $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" - && \
                        $(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMP.o" && \
                        $(LD) -m elf32_x86_64 "$$TMP.o" -o "$$TMP",y,n)
 $(warning x32_ld_ok is +$(x32_ld_ok)+ with CC=$(CC) $(KBUILD_AFLAGS) OBJ=$(OBJCOPY) LD=$(LD) )
        ifeq ($(x32_ld_ok),y)
                CONFIG_X86_X32_ABI := y

and that throws:

arch/x86/Makefile:143: x32_ld_ok is ++ with CC=x86_64-unknown-linux-gnu-gcc -D__ASSEMBLY__ -fno-PIE -m64 OBJ=x86_64-unknown-linux-gnu-objcopy LD=x86_64-unknown-linux-gnu-ld 

Anybody have a clue why $(x32_ld_ok)  is null rather than 'y' or 'n'?

(It's totally possible that my cross-compiler is broken, but I still don't see how
try-run would return null rather than 'n' in that case...  I built a shell script that did the
test and that ended with $? == 0, but had a warning msg:

+ /bin/echo -e '1: .quad 1b'
+ x86_64-unknown-linux-gnu-gcc -D__ASSEMBLY__ -fno-PIE -m64 -c -x assembler -o /tmp/z97 -
+ x86_64-unknown-linux-gnu-objcopy -O elf32-x86-64 /tmp/z97 /tmp/z99.o
+ x86_64-unknown-linux-gnu-ld -m elf32_x86_64 /tmp/z99.o -o /tmp/z98
x86_64-unknown-linux-gnu-ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
echo $?
+ echo 0
0



