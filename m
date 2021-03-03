Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB932BFDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580325AbhCCSds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233592AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AyP7XyWOerV6bQP5NUQox0rNDwSmxoyRKouf6vnaFy4=;
        b=T8qJwPwXovxTyGRFYqdEooZtrmZnOA45PSrCyUWbB/AAgVjRy3cFIAQyBft46KuOZYAOhn
        kDqYUmEcTU9uxSLzcxiRR3VNF4lnUTiAf7KWQtqdfQmnP44RGGmJk5tihtWX318cKhd7ee
        n8CgBvlhnvqUt+AQjN0yde3JpHVSqWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-0JWEZyvdNS6-8nvtkDVN1g-1; Wed, 03 Mar 2021 12:09:37 -0500
X-MC-Unique: 0JWEZyvdNS6-8nvtkDVN1g-1
Received: by mail-wr1-f70.google.com with SMTP id b15so11346163wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyP7XyWOerV6bQP5NUQox0rNDwSmxoyRKouf6vnaFy4=;
        b=WKvrikQ3fmVFJNqda/WYrkWoK8PzqbYvdjE9PxfTSrksWcdjwYEB23Okm3/3ffD2w5
         NuyfQktfjEB/gEBahSFptCHl7Ifqjojd3zEUubh5ElYMAjgkExhyPNXZ5gsSDWqL2uz/
         dh0KgbQA0oe+6CmX65IG8aD93NbHMAgHMlvoySmIoOrm1puTHcGbbx5GHekR+ClOPrOH
         cDiOTe7i8ibTUFK2DiaGIw7LsVvYxcNE0ZQhU1x8gFYg3k3ZfZNISVSK4rUgY75NC/Fl
         NmKnYi/KHUhJdDlrhqJEwbigZso3xnLuFytUm4umn61VCjVk996I6gUEl65B2rW+Tvtt
         4CNg==
X-Gm-Message-State: AOAM5311eAS9brGopQ2NiCxeMKq0U3CAVmQXrw+tpXQ6wx4wCuG7Jw5w
        oMy1rNDcti1KLVgQPqvPvjDVJv//5/xo/6jJOOtiy3465XZuPelpBa1MWxE47MUyuFO7ZhWPlT0
        s0iO5++XYAwHP8Cxn4jgFZjNjXp7+9iThbm9cwNaC2rhlceVot3HrMWgzuHenwjZ59Q3dC8vABO
        Vu
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr47005wmg.90.1614791375013;
        Wed, 03 Mar 2021 09:09:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNVbYdS11FS37BObPTFWeOE7ivO33aOuZ+b/Rql41/bTfHxHQFbqZa/vdari+l7+Fe6dP5IQ==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr46985wmg.90.1614791374797;
        Wed, 03 Mar 2021 09:09:34 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:34 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 00/13] objtool: add base support for arm64
Date:   Wed,  3 Mar 2021 18:09:19 +0100
Message-Id: <20210303170932.1838634-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables objtool to start doing stack validation on arm64
kernel builds. It relies on the previous series I sent, refactoring
the arm64 decoder [1].

First, the aarch64 instruction decoder needed to be made available
to code under tools/. This is done in a similar manner to x86
instruction decoded. One limitation I encountered there is that most
of aarch64 instruction decoder is __kprobe annotated. To bypass that
it remove the kprobe include and had to add an empty __kprobe
definition, but I'd welcome a proper solution to that.

Then instruction semantics are progressively added so objtool can track
the stack state through the execution flow.
There are a few things that needed consideration:
- Generation of constants within executable sections, these either
  caused objtool to fail decoding or to wrongly decode constants
  as jumps or other instructions affecting execution flow and
  causing confusion. To solve this, tracking locations referenced
  by instructions using literals was needed.
- Jump tables from switch statements in aarch64 don't have enough
  information to link branches with the branch instruction leading to
  them. Following suggestions, I've dropped the previously used GCC
  plugin and instead disabled the generation of jump tables by the
  compiler. I've not noticed performance deterioration nor concerning
  Image size increase after doing so. This approach has the benefit of
  working for both GCC and clang.

With those changes, there are still some errors when building with objtool. A
number of cleanups/annotations are needed on the arm64, as well as
handling SYM_DATA objects in objtool.

Those changes can be found on top of this branch here:
git clone https://github.com/julien-thierry/linux.git -b objtoolxarm64-latest

Changes since v1[2]:
- Drop gcc plugin in favor of -fno-jump-tables
- miscelaneous fixes and cleanups

[1] https://lkml.org/lkml/2021/1/20/791
[2] https://lkml.org/lkml/2021/1/20/923

Thanks,

Julien

-->

Julien Thierry (12):
  tools: Add some generic functions and headers
  tools: arm64: Make aarch64 instruction decoder available to tools
  tools: bug: Remove duplicate definition
  objtool: arm64: Add base definition for arm64 backend
  objtool: arm64: Decode add/sub instructions
  objtool: arm64: Decode jump and call related instructions
  objtool: arm64: Decode other system instructions
  objtool: arm64: Decode load/store instructions
  objtool: arm64: Decode LDR instructions
  objtool: arm64: Accept padding in code sections
  objtool: arm64: Handle supported relocations in alternatives
  objtool: arm64: Ignore replacement section for alternative callback

Raphael Gault (1):
  objtool: arm64: Enable stack validation for arm64

 arch/arm64/Kconfig                            |    1 +
 arch/arm64/Makefile                           |    4 +
 tools/arch/arm64/include/asm/insn.h           |  565 +++++++
 tools/arch/arm64/lib/insn.c                   | 1456 +++++++++++++++++
 tools/include/asm-generic/bitops/__ffs.h      |   11 +
 tools/include/linux/bug.h                     |    6 +-
 tools/include/linux/kernel.h                  |   21 +
 tools/include/linux/printk.h                  |   40 +
 tools/objtool/Makefile                        |    5 +
 tools/objtool/arch/arm64/Build                |    8 +
 tools/objtool/arch/arm64/decode.c             |  502 ++++++
 .../arch/arm64/include/arch/cfi_regs.h        |   14 +
 tools/objtool/arch/arm64/include/arch/elf.h   |    6 +
 .../arch/arm64/include/arch/endianness.h      |    9 +
 .../objtool/arch/arm64/include/arch/special.h |   21 +
 tools/objtool/arch/arm64/special.c            |   37 +
 tools/objtool/arch/x86/decode.c               |    5 +
 tools/objtool/check.c                         |    6 +
 tools/objtool/include/objtool/arch.h          |    3 +
 tools/objtool/sync-check.sh                   |    5 +
 20 files changed, 2720 insertions(+), 5 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/insn.h
 create mode 100644 tools/arch/arm64/lib/insn.c
 create mode 100644 tools/include/linux/printk.h
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

--
2.25.4

