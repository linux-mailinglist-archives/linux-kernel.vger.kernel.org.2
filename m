Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D407045
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhIJRKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhIJRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:10:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:08:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so2108043pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=B5iiLmE5FXHcZegth7oLZCJEBlGPVnWDmA2kWHACRG8=;
        b=IjdtDybncnekNPtX337peSYJCc/XuhzJ4QVULAOCDA6Ue6TMp0BUsnKurLgpgdkJXL
         flAK7bnnND6k82hc/k8aIhRlGwAzE9FVeGcNbrE85IqptBDN5ksZiULtRFLpFxYg6KVf
         HhD2KRFXw37XOzI7HVBD8TV32Q9QuwozuMuqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B5iiLmE5FXHcZegth7oLZCJEBlGPVnWDmA2kWHACRG8=;
        b=mgzwYAdNqQ1C1YxBuDmGmGhE6G8zBQ+dzJORLe6vjS7K5CMolbbXz7pAPVLbAIAg76
         QwC8UPcDB9SIRqYvA3wPZyn4wD51hl4aHgxo3QLxzCoLQXA5WQ1S3DROcZom4MWR/hGP
         bNBB3oZWLKc8rjXCqnv6+n529Uhprro3SiA9p65uiFa+W6VGQQPAw58JzQIKNUIf/Adk
         r9ZTbHldWxHY953IvtWmJ+OQzOWvypAWhLHWGu4EXma66j0+uLxqEZsVZ7oQy79FQVQ5
         S93s02S/lBxmyDGKSq1NpeuD0bU1k78CreiHaW0xyMd4p26XI8aCh0rLeG/1RkiBbQ3R
         MTEg==
X-Gm-Message-State: AOAM533M/YxEgkQUtZ9ITBcBeioGMErlf6+Nmw9xvtKEpJxPRKPhEhzj
        m06hnwfaIM1CaJM323ZcnZZyBA==
X-Google-Smtp-Source: ABdhPJwOi9L95KyhMJnZwz/r9oTIf4s+16FwXOIiNr8FiH2bV81tc2RPeOc9JNer/FCTFdfpbSQKrA==
X-Received: by 2002:a62:ee12:0:b0:412:444e:f5ff with SMTP id e18-20020a62ee12000000b00412444ef5ffmr9184673pfi.82.1631293728894;
        Fri, 10 Sep 2021 10:08:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o10sm5493935pjo.47.2021.09.10.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:08:48 -0700 (PDT)
Date:   Fri, 10 Sep 2021 10:08:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL v3] overflow updates for v5.15-rc1-take3
Message-ID: <202109101001.E0C1BB5C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these overflow updates for v5.15-rc1 (take3). I confirmed
with more build testing over-night that there was another false positive
hiding in yet another combination under GCC 8, so I've added an additional
patch on top of take2 to cover those issues as well.

Current GCC build test matrix is:

Config targets:
	defconfig
	allmodconfig
	allyesconfig
Architectures:
	x86_64
	i386
	arm64
	arm
Compilers:
	gcc-7 (Ubuntu 7.5.0-6ubuntu4) 7.5.0
	gcc-8 (Ubuntu 8.4.0-7ubuntu3) 8.4.0
	gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
	gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0
	gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
	gcc (Ubuntu 11.2.0-3ubuntu1) 11.2.0
	gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1)

Thanks!

-Kees

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.15-rc1-take3

for you to fetch changes up to 76a839366b84f17c7452192c6982f797a8a9ac69:

  fortify: Lower verbosity on compile-time test failures (2021-09-10 00:06:17 -0700)

----------------------------------------------------------------
overflow updates for v5.15-rc1 (take3)

The end goal of the current buffer overflow detection work[0] is to gain
full compile-time and run-time coverage of all detectable buffer overflows
seen via array indexing or memcpy(), memmove(), and memset(). The str*()
family of functions already have full coverage.

While much of the work for these changes have been on-going for many
releases (i.e. 0-element and 1-element array replacements, as well as
avoiding false positives and fixing discovered overflows[1]), this series
contains the foundational elements of several related buffer overflow
detection improvements by providing new common helpers and FORTIFY_SOURCE
changes needed to gain the introspection needed for compiler visibility
into array sizes. Also included are a handful of already Acked instances
using the helpers (or related clean-ups), with many more waiting at the
ready to be taken via subsystem-specific trees[2]. The new helpers are:

- struct_group() for gaining struct member range introspection.
- memset_after() and memset_startat() for clearing to the end of structures.
- DECLARE_FLEX_ARRAY() for using flex arrays in unions or alone in structs.

Also included is the beginning of the refactoring of FORTIFY_SOURCE to
support memcpy() introspection, fix missing and regressed coverage under
GCC, and to prepare to fix the currently broken Clang support. Finishing
this work is part of the larger series[0], but depends on all the false
positives and buffer overflow bug fixes to have landed already and those
that depend on this series to land.

As part of the FORTIFY_SOURCE refactoring, a set of both a compile-time
and run-time tests are added for FORTIFY_SOURCE and the mem*()-family
functions respectively. (Now with the LANG=C grep mismatch[5] fixed from
PR take 1). Please note that the appearance of "panic" and "BUG" in the
FORTIFY_SOURCE refactoring are the result of relocating existing code,
and no new use of those code-paths are expected nor desired.

Finally, there are two tree-wide conversions for 0-element arrays and
flexible array unions to gain sane compiler introspection coverage that
result in no known object code differences.

After this series (and the changes that have now landed via netdev
and usb), we are so very close to finally being able to build with
-Warray-bounds and -Wzero-length-bounds. However, due two recently found
corner cases in GCC[3] and Clang[4], I have not included the last two
patches that turn on these options, as I don't want to introduce any known
warnings to the build. I am expecting to solve them before rc2, though,
so hopefully there will be a small follow-up to this series before then.

[0] https://lore.kernel.org/lkml/20210818060533.3569517-1-keescook@chromium.org/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=FORTIFY_SOURCE
[2] https://lore.kernel.org/lkml/202108220107.3E26FE6C9C@keescook/
[3] https://lore.kernel.org/lkml/3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net/
[4] https://bugs.llvm.org/show_bug.cgi?id=51682
[5] https://lore.kernel.org/lkml/202109051257.29B29745C0@keescook/

----------------------------------------------------------------
Kees Cook (29):
      scsi: ibmvscsi: Avoid multi-field memset() overflow by aiming at srp
      powerpc: Split memset() to avoid multi-field overflow
      stddef: Fix kerndoc for sizeof_field() and offsetofend()
      stddef: Introduce struct_group() helper macro
      cxl/core: Replace unions with struct_group()
      bnxt_en: Use struct_group_attr() for memcpy() region
      iommu/amd: Use struct_group() for memcpy() region
      drm/mga/mga_ioc32: Use struct_group() for memcpy() region
      HID: cp2112: Use struct_group() for memcpy() region
      HID: roccat: Use struct_group() to zero kone_mouse_event
      can: flexcan: Use struct_group() to zero struct flexcan_regs regions
      cm4000_cs: Use struct_group() to zero struct cm4000_dev region
      compiler_types.h: Remove __compiletime_object_size()
      lib/string: Move helper functions out of string.c
      fortify: Move remaining fortify helpers into fortify-string.h
      fortify: Explicitly disable Clang support
      fortify: Fix dropped strcpy() compile-time write overflow check
      fortify: Prepare to improve strnlen() and strlen() warnings
      fortify: Allow strlen() and strnlen() to pass compile-time known lengths
      fortify: Add compile-time FORTIFY_SOURCE tests
      lib: Introduce CONFIG_MEMCPY_KUNIT_TEST
      string.h: Introduce memset_after() for wiping trailing members/padding
      xfrm: Use memset_after() to clear padding
      string.h: Introduce memset_startat() for wiping trailing members and padding
      btrfs: Use memset_startat() to clear end of struct
      stddef: Introduce DECLARE_FLEX_ARRAY() helper
      treewide: Replace open-coded flex arrays in unions
      treewide: Replace 0-element memcpy() destinations with flexible arrays
      fortify: Lower verbosity on compile-time test failures

 MAINTAINERS                                       |   9 +
 arch/arm/boot/compressed/string.c                 |   1 +
 arch/s390/lib/string.c                            |   3 +
 arch/x86/boot/compressed/misc.h                   |   2 +
 arch/x86/boot/compressed/pgtable_64.c             |   2 +
 arch/x86/lib/string_32.c                          |   1 +
 drivers/char/pcmcia/cm4000_cs.c                   |   9 +-
 drivers/crypto/chelsio/chcr_crypto.h              |  14 +-
 drivers/cxl/cxl.h                                 |  61 ++---
 drivers/gpu/drm/mga/mga_ioc32.c                   |  27 +-
 drivers/hid/hid-cp2112.c                          |  14 +-
 drivers/hid/hid-roccat-kone.c                     |   2 +-
 drivers/hid/hid-roccat-kone.h                     |  12 +-
 drivers/iommu/amd/init.c                          |   9 +-
 drivers/macintosh/smu.c                           |   3 +-
 drivers/net/can/flexcan.c                         |  68 ++---
 drivers/net/can/usb/etas_es58x/es581_4.h          |   2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.h         |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c     |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h     |  14 +-
 drivers/net/wireless/ath/ath10k/bmi.h             |  10 +-
 drivers/net/wireless/ath/ath10k/htt.h             |   7 +-
 drivers/net/wireless/intel/iwlegacy/commands.h    |   6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h    |  12 +-
 drivers/scsi/aic94xx/aic94xx_sds.c                |   6 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c                  |   3 +-
 drivers/scsi/qla4xxx/ql4_def.h                    |   4 +-
 drivers/staging/rtl8188eu/include/ieee80211.h     |   6 +-
 drivers/staging/rtl8712/ieee80211.h               |   4 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     |   6 +-
 fs/btrfs/root-tree.c                              |   6 +-
 fs/hpfs/hpfs.h                                    |   8 +-
 include/linux/compiler-gcc.h                      |   2 -
 include/linux/compiler_types.h                    |   4 -
 include/linux/filter.h                            |   6 +-
 include/linux/fortify-string.h                    |  77 ++++--
 include/linux/ieee80211.h                         |  30 +--
 include/linux/stddef.h                            |  65 ++++-
 include/linux/string.h                            |  44 +++-
 include/linux/thread_info.h                       |   2 +-
 include/scsi/sas.h                                |  12 +-
 include/uapi/drm/mga_drm.h                        |  22 +-
 include/uapi/linux/dlm_device.h                   |   4 +-
 include/uapi/linux/stddef.h                       |  37 +++
 include/uapi/rdma/rdma_user_rxe.h                 |   4 +-
 include/uapi/sound/asoc.h                         |   4 +-
 lib/.gitignore                                    |   2 +
 lib/Kconfig.debug                                 |  11 +
 lib/Makefile                                      |  34 +++
 lib/memcpy_kunit.c                                | 289 ++++++++++++++++++++++
 lib/string.c                                      | 210 +---------------
 lib/string_helpers.c                              | 195 +++++++++++++++
 lib/test_fortify/read_overflow-memchr.c           |   5 +
 lib/test_fortify/read_overflow-memchr_inv.c       |   5 +
 lib/test_fortify/read_overflow-memcmp.c           |   5 +
 lib/test_fortify/read_overflow-memscan.c          |   5 +
 lib/test_fortify/read_overflow2-memcmp.c          |   5 +
 lib/test_fortify/read_overflow2-memcpy.c          |   5 +
 lib/test_fortify/read_overflow2-memmove.c         |   5 +
 lib/test_fortify/test_fortify.h                   |  35 +++
 lib/test_fortify/write_overflow-memcpy.c          |   5 +
 lib/test_fortify/write_overflow-memmove.c         |   5 +
 lib/test_fortify/write_overflow-memset.c          |   5 +
 lib/test_fortify/write_overflow-strcpy-lit.c      |   5 +
 lib/test_fortify/write_overflow-strcpy.c          |   5 +
 lib/test_fortify/write_overflow-strlcpy-src.c     |   5 +
 lib/test_fortify/write_overflow-strlcpy.c         |   5 +
 lib/test_fortify/write_overflow-strncpy-src.c     |   5 +
 lib/test_fortify/write_overflow-strncpy.c         |   5 +
 lib/test_fortify/write_overflow-strscpy.c         |   5 +
 net/xfrm/xfrm_policy.c                            |   4 +-
 net/xfrm/xfrm_user.c                              |   2 +-
 scripts/kernel-doc                                |   9 +
 scripts/test_fortify.sh                           |  62 +++++
 security/Kconfig                                  |   3 +
 76 files changed, 1152 insertions(+), 445 deletions(-)
 create mode 100644 lib/memcpy_kunit.c
 create mode 100644 lib/test_fortify/read_overflow-memchr.c
 create mode 100644 lib/test_fortify/read_overflow-memchr_inv.c
 create mode 100644 lib/test_fortify/read_overflow-memcmp.c
 create mode 100644 lib/test_fortify/read_overflow-memscan.c
 create mode 100644 lib/test_fortify/read_overflow2-memcmp.c
 create mode 100644 lib/test_fortify/read_overflow2-memcpy.c
 create mode 100644 lib/test_fortify/read_overflow2-memmove.c
 create mode 100644 lib/test_fortify/test_fortify.h
 create mode 100644 lib/test_fortify/write_overflow-memcpy.c
 create mode 100644 lib/test_fortify/write_overflow-memmove.c
 create mode 100644 lib/test_fortify/write_overflow-memset.c
 create mode 100644 lib/test_fortify/write_overflow-strcpy-lit.c
 create mode 100644 lib/test_fortify/write_overflow-strcpy.c
 create mode 100644 lib/test_fortify/write_overflow-strlcpy-src.c
 create mode 100644 lib/test_fortify/write_overflow-strlcpy.c
 create mode 100644 lib/test_fortify/write_overflow-strncpy-src.c
 create mode 100644 lib/test_fortify/write_overflow-strncpy.c
 create mode 100644 lib/test_fortify/write_overflow-strscpy.c
 create mode 100644 scripts/test_fortify.sh

-- 
Kees Cook
