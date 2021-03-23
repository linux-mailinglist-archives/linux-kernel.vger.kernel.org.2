Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435C1345638
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCWD0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCWD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:26:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43EC061756;
        Mon, 22 Mar 2021 20:26:36 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F4GxP55GZz9sVS; Tue, 23 Mar 2021 14:26:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616469993;
        bh=luoYRjEruzGoNTMcHDnAhPGA47xA6Ulc15Avqfk01J8=;
        h=From:To:Cc:Subject:Date:From;
        b=oQGAnmzY0HjM+Q4yXaMXQfsk3RC4ZPFin2EgXr95lgxi+wrLjPn97PQYJbpu8Ab9Y
         tg345G0Tbhd8heplfvrlZoC34djGfgfZXCw53n2Vg2DjM9d8a/FtyOyNMSVMlYiQG5
         2SKfOJLZMtom/ud90FpGnOs4mXOD+ERmvw87XAbkmsJfhOA7AD7RNS80Cxhoj9Pnkh
         WJU7WG9H/Bcj8vMn+yzd7X1QK9mhdmW9HMLcp50E74FLvdnZ39pdc9yHP0FAVP0HDY
         G+X7TbwVRwG86aq+G4yn+9SztyysL4rEk5xM4jjE1HJb0VkKE2ksD2eeM+/9wwAGqA
         5/U162KNPhlug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rust-for-linux@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Rust for Linux for ppc64le
Date:   Tue, 23 Mar 2021 14:26:20 +1100
Message-Id: <20210323032624.1039422-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a first attempt at getting the kernel Rust support building on powerpc.

It's powerpc64le only for now, as that's what I can easily test given the
distros I have installed. Though powerpc and powerpc64 are also Tier 2 platforms
so in theory should work. Supporting those would require something more
complicated than just pointing rustc at arch/$(ARCH)/rust/target.json.

This is based on 832575d934a2 from the Rust-for-Linux tree. Anything newer gives
me errors about symbol name lengths. I figured I'd send this anyway, as it seems
like those errors are probably not powerpc specific.

I'm not sure that all the values in target.json are correct, or required (or if
any are missing), but what I have there seems to work. Would be happy for
someone to scrutinise it though.

Example output:

  # uname -r
  5.12.0-rc3-47689-ge4e12dd7cb75
  # uname -m
  ppc64le
  # modprobe rust_example
   Rust Example (init)
   Am I built-in? false
   Parameters:
     my_bool:    true
     my_i32:     42
     my_str:     default str val
     my_usize:   42
     my_array:   [0, 1]
   Value: 10
   Value: 10
   Large array has length: 514
   modprobe (1589) used greatest stack depth: 6800 bytes left
  # modprobe rust_example_2
   [2] Rust Example (init)
   [2] Am I built-in? false
   [2] Parameters:
   [2]   my_bool:    true
   [2]   my_i32:     42
   [2]   my_str:     default str val
   [2]   my_usize:   42
   [2]   my_array:   [0, 1]
   Large array has length: 1028
   modprobe (1593) used greatest stack depth: 3680 bytes left
  # modprobe rust_example_3
   [3] Rust Example (init)
   [3] Am I built-in? false
   [3] Parameters:
   [3]   my_bool:    true
   [3]   my_i32:     42
   [3]   my_str:     default str val
   [3]   my_usize:   42
   [3]   my_array:   [0, 1]
   Large array has length: 1028
  # modprobe rust_example_4
   [4] Rust Example (init)
   [4] Am I built-in? false
   [4] Parameters:
   [4]   my_bool:    true
   [4]   my_i32:     42
   [4]   my_str:     default str val
   [4]   my_usize:   42
   [4]   my_array:   [0, 1]
   Large array has length: 1028

cheers


Michael Ellerman (4):
  rust: Export symbols in initialized data section
  rust: Add powerpc64 as a 64-bit target_arch in c_types.rs
  powerpc/rust: Add target.json for ppc64le
  rust: Enable for ppc64le

 arch/powerpc/rust/target.json | 30 ++++++++++++++++++++++++++++++
 init/Kconfig                  |  2 +-
 rust/Makefile                 |  2 +-
 rust/kernel/c_types.rs        |  2 +-
 4 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/rust/target.json


base-commit: 832575d934a2bc5e2fd0aa881d8e6b64bf062fd2
-- 
2.25.1

