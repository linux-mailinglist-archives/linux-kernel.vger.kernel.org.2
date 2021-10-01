Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6D41E62D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbhJADSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 23:18:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:23853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhJADSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 23:18:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212598295"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="212598295"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 20:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="709396766"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Sep 2021 20:16:45 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mW92S-0000jv-R1; Fri, 01 Oct 2021 03:16:44 +0000
Date:   Fri, 01 Oct 2021 11:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/cast-function] BUILD SUCCESS WITH WARNING
 ffea83dd8823401f3922276d36aca35c3e99d7f3
Message-ID: <61567d78.lXtffKDQGLSoIraW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/cast-function
branch HEAD: ffea83dd8823401f3922276d36aca35c3e99d7f3  Makefile: Enable -Wcast-function-type

Warning reports:

https://lore.kernel.org/llvm/202109302140.3dPl9ABV-lkp@intel.com

Warning in current branch:

drivers/firewire/core-cdev.c:985:8: warning: cast from 'void (*)(struct fw_iso_context *, dma_addr_t, void *)' (aka 'void (*)(struct fw_iso_context *, unsigned int, void *)') to 'fw_iso_callback_t' (aka 'void (*)(struct fw_iso_context *, unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/hashtab.c:671:26: warning: cast from 'void *(*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12470:16: warning: cast from 'unsigned int (*)(const void *, const struct bpf_insn *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12951:17: warning: cast from 'void *(*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12955:17: warning: cast from 'int (*)(struct bpf_map *, void *, void *, u64)' (aka 'int (*)(struct bpf_map *, void *, void *, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12959:17: warning: cast from 'int (*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12963:17: warning: cast from 'int (*)(struct bpf_map *, void *, u64)' (aka 'int (*)(struct bpf_map *, void *, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12975:17: warning: cast from 'int (*)(struct bpf_map *, u32, u64)' (aka 'int (*)(struct bpf_map *, unsigned int, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]

possible Warning in current branch (please contact us if interested):

drivers/firewire/core-cdev.c:985:8: warning: cast from 'void (*)(struct fw_iso_context *, dma_addr_t, void *)' (aka 'void (*)(struct fw_iso_context *, unsigned long long, void *)') to 'fw_iso_callback_t' (aka 'void (*)(struct fw_iso_context *, unsigned int, unsigned long, void *, void *)') converts to incompatible function type [-Wcast-function-type]
kernel/trace/ftrace.c:174:10: warning: cast from 'void (*)(unsigned long, unsigned long)' to 'ftrace_func_t' (aka 'void (*)(unsigned long, unsigned long, struct ftrace_ops *, struct ftrace_regs *)') converts to incompatible function type [-Wcast-function-type]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-c002-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-a011-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-a012-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-a013-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-a014-20210930
|   |-- drivers-firewire-core-cdev.c:warning:cast-from-void-(-)(struct-fw_iso_context-dma_addr_t-void-)-(aka-void-(-)(struct-fw_iso_context-unsigned-int-void-)-)-to-fw_iso_callback_t-(aka-void-(-)(struct-fw_i
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-a015-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- i386-randconfig-r016-20210930
|   |-- drivers-firewire-core-cdev.c:warning:cast-from-void-(-)(struct-fw_iso_context-dma_addr_t-void-)-(aka-void-(-)(struct-fw_iso_context-unsigned-int-void-)-)-to-fw_iso_callback_t-(aka-void-(-)(struct-fw_i
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- x86_64-randconfig-a011-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- x86_64-randconfig-a013-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- x86_64-randconfig-a014-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- x86_64-randconfig-a016-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- x86_64-randconfig-c007-20210930
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   |-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|   `-- kernel-trace-ftrace.c:warning:cast-from-void-(-)(unsigned-long-unsigned-long)-to-ftrace_func_t-(aka-void-(-)(unsigned-long-unsigned-long-struct-ftrace_ops-struct-ftrace_regs-)-)-converts-to-incompatib
|-- x86_64-randconfig-r012-20210930
|   `-- drivers-firewire-core-cdev.c:warning:cast-from-void-(-)(struct-fw_iso_context-dma_addr_t-void-)-(aka-void-(-)(struct-fw_iso_context-unsigned-long-long-void-)-)-to-fw_iso_callback_t-(aka-void-(-)(struc
`-- x86_64-randconfig-r012-20211001
    `-- kernel-trace-ftrace.c:warning:cast-from-void-(-)(unsigned-long-unsigned-long)-to-ftrace_func_t-(aka-void-(-)(unsigned-long-unsigned-long-struct-ftrace_ops-struct-ftrace_regs-)-)-converts-to-incompatib

elapsed time: 1036m

configs tested: 176
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210930
powerpc              randconfig-c003-20210930
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
csky                             alldefconfig
mips                        workpad_defconfig
arc                        vdk_hs38_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
x86_64                              defconfig
mips                        vocore2_defconfig
arm                        spear3xx_defconfig
arc                              allyesconfig
powerpc                    amigaone_defconfig
sparc                       sparc64_defconfig
mips                            gpr_defconfig
sh                           se7721_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
powerpc                       eiger_defconfig
powerpc                          allmodconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
sh                               alldefconfig
mips                           mtx1_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
ia64                          tiger_defconfig
powerpc                    ge_imp3a_defconfig
arm                          gemini_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
arm                       netwinder_defconfig
powerpc                     tqm8541_defconfig
powerpc                      mgcoge_defconfig
mips                          rm200_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                       imx_v4_v5_defconfig
arm                           corgi_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig
powerpc                     stx_gp3_defconfig
sh                          sdk7786_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
arm                         bcm2835_defconfig
arm                            lart_defconfig
sparc64                             defconfig
arm                          ep93xx_defconfig
arm                           tegra_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    klondike_defconfig
powerpc                     taishan_defconfig
mips                        nlm_xlr_defconfig
arm                        oxnas_v6_defconfig
openrisc                            defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
arm                        multi_v7_defconfig
riscv                            alldefconfig
mips                          malta_defconfig
m68k                         amcore_defconfig
riscv                          rv32_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
powerpc                     mpc512x_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
s390                          debug_defconfig
arm                            qcom_defconfig
sh                   secureedge5410_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
powerpc                         ps3_defconfig
arc                          axs101_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
xtensa                    xip_kc705_defconfig
arc                         haps_hs_defconfig
arm                   milbeaut_m10v_defconfig
arc                           tb10x_defconfig
arm                  randconfig-c002-20210930
x86_64               randconfig-c001-20210930
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20210930
x86_64               randconfig-a001-20210930
x86_64               randconfig-a002-20210930
x86_64               randconfig-a005-20210930
x86_64               randconfig-a006-20210930
x86_64               randconfig-a003-20210930
i386                 randconfig-a003-20210930
i386                 randconfig-a001-20210930
i386                 randconfig-a004-20210930
i386                 randconfig-a002-20210930
i386                 randconfig-a006-20210930
i386                 randconfig-a005-20210930
arc                  randconfig-r043-20210930
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-c001-20210930
arm                  randconfig-c002-20210930
powerpc              randconfig-c003-20210930
mips                 randconfig-c004-20210930
s390                 randconfig-c005-20210930
riscv                randconfig-c006-20210930
x86_64               randconfig-c007-20210930
x86_64               randconfig-a015-20210930
x86_64               randconfig-a011-20210930
x86_64               randconfig-a012-20210930
x86_64               randconfig-a013-20210930
x86_64               randconfig-a016-20210930
x86_64               randconfig-a014-20210930
i386                 randconfig-a014-20210930
i386                 randconfig-a013-20210930
i386                 randconfig-a011-20210930
i386                 randconfig-a015-20210930
i386                 randconfig-a016-20210930
i386                 randconfig-a012-20210930
riscv                randconfig-r042-20210930
hexagon              randconfig-r041-20210930
s390                 randconfig-r044-20210930
hexagon              randconfig-r045-20210930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
