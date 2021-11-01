Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D47441E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhKAQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhKAQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:38:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F3C061203
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:35:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a4d4a00b001a678eed8abso3005453pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SCRAvsOMFLCOtMRqridMd+pUJg4eaJJXLUPOc9Zcjck=;
        b=YypE6qZTK7pQnEI/15Tf0vBsdyyU8ZYDsTb7GiwCVCMBKNErr4VGlH8A3xIl74Fc/6
         9EHBVjv0BYXoirLNjtX1j0DzFHGtncrr/sbIzF24qcPTrkGZukZskjH/PMOzPm4kN32U
         bskBcdnCSq1wgff+lKemUw8csn8q6L2KN2i5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SCRAvsOMFLCOtMRqridMd+pUJg4eaJJXLUPOc9Zcjck=;
        b=Tq3LjzAa8RTnrD8hb/ybdB5YXslbVZFXfvkprznEJob9PbzhMGM0UUurh0PvYU26t7
         KL+18cqXk3DRanxdnUKm4lxdTqspIJxx48v9clQfLwKQ9K/U0pUXrxriUAI/W3wGJz0J
         MJXyiP/bDcfXT0qrspsypMZRA/VJ+fVQcMaCkOC58r/f9RIRhAQrp2yZ3aJKh3gT7d7B
         hNDriXW89MU4pfbIQKFik8xyws0BKBeiZ9Drf91sHcpTkIfhcQAMlxX86OMONS6iHGFw
         Dj8CyzzO6AutM92YO2Z0l4IZBdnByNXWBuf74xJ8I5fikRmAgIrLMmh192tlMjcw4F9W
         0axQ==
X-Gm-Message-State: AOAM531tR1DZOxRias5pJi3b5E8g4tBJay21jOGyVbki7Q49htUAfF+g
        Qo1VuCpqeauHkQ2c97CAOwQ4pGPOfLdyMQ==
X-Google-Smtp-Source: ABdhPJxEsb3MxfsTET/ppm51ghlr59sEqWKvMLXGsalsUIDeaaKgR7qng5g7Rrw47USh8kfe51lbmQ==
X-Received: by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id ay11-20020a1709028b8b00b0013de91ca1b9mr26389099plb.60.1635784548133;
        Mon, 01 Nov 2021 09:35:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11sm5407469pfe.3.2021.11.01.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:35:47 -0700 (PDT)
Date:   Mon, 1 Nov 2021 09:35:46 -0700
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
Subject: [GIT PULL] overflow updates for v5.16-rc1
Message-ID: <202111010927.AFA4C0D15@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these overflow detection updates for v5.16-rc1. These
have been in -next for (more than) the entire past development
cycle. 1 trivial conflict recently emerged in the treewide flex
array patch vs the wireless tree, which was resolved by sfr here:
https://lore.kernel.org/linux-next/20211028192934.01520d7e@canb.auug.org.au/
Extensive details about the series are in the tag below.

Thanks!

-Kees

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.16-rc1

for you to fetch changes up to 95cadae320be46583078690ac89ffe63c95cc9d2:

  fortify: strlen: Avoid shadowing previous locals (2021-10-25 15:34:41 -0700)

----------------------------------------------------------------
overflow updates for v5.16-rc1

The end goal of the current buffer overflow detection work[0] is to gain
full compile-time and run-time coverage of all detectable buffer overflows
seen via array indexing or memcpy(), memmove(), and memset(). The str*()
family of functions already have full coverage.

While much of the work for these changes have been on-going for many
releases (i.e. 0-element and 1-element array replacements, as well as
avoiding false positives and fixing discovered overflows[1]), this series
contains the foundational elements of several related buffer overflow
detection improvements by providing new common helpers and FORTIFY_SOURCE
changes needed to gain the introspection required for compiler visibility
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
functions respectively. The compile time tests have found a legitimate
(though corner-case) bug[6] already.

Please note that the appearance of "panic" and "BUG" in the
FORTIFY_SOURCE refactoring are the result of relocating existing code,
and no new use of those code-paths are expected nor desired.

Finally, there are two tree-wide conversions for 0-element arrays and
flexible array unions to gain sane compiler introspection coverage that
result in no known object code differences.

After this series (and the changes that have now landed via netdev
and usb), we are very close to finally being able to build with
-Warray-bounds and -Wzero-length-bounds. However, due corner cases in
GCC[3] and Clang[4], I have not included the last two patches that turn
on these options, as I don't want to introduce any known warnings to
the build. Hopefully these can be solved soon.

[0] https://lore.kernel.org/lkml/20210818060533.3569517-1-keescook@chromium.org/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=FORTIFY_SOURCE
[2] https://lore.kernel.org/lkml/202108220107.3E26FE6C9C@keescook/
[3] https://lore.kernel.org/lkml/3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net/
[4] https://bugs.llvm.org/show_bug.cgi?id=51682
[5] https://lore.kernel.org/lkml/202109051257.29B29745C0@keescook/
[6] https://lore.kernel.org/lkml/20211020200039.170424-1-keescook@chromium.org/

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
      compiler-gcc.h: Define __SANITIZE_ADDRESS__ under hwaddress sanitizer

Qian Cai (1):
      fortify: strlen: Avoid shadowing previous locals

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
 drivers/staging/r8188eu/include/ieee80211.h       |   6 +-
 drivers/staging/rtl8712/ieee80211.h               |   4 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     |   6 +-
 fs/btrfs/root-tree.c                              |   6 +-
 fs/hpfs/hpfs.h                                    |   8 +-
 include/linux/compiler-gcc.h                      |  10 +-
 include/linux/compiler_types.h                    |   5 -
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
 76 files changed, 1160 insertions(+), 446 deletions(-)
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
