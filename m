Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170F33C7667
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhGMS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:26:50 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:55492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229478AbhGMS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:26:49 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 212A3181D3CCD;
        Tue, 13 Jul 2021 18:23:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 8DFFC1124F4;
        Tue, 13 Jul 2021 18:23:57 +0000 (UTC)
Message-ID: <6cb78d8885bafa5e203b9a32be86b45e08f12ec2.camel@perches.com>
Subject: trivial script to find unused CONFIG_<FOO> uses in #ifdef blocks
From:   Joe Perches <joe@perches.com>
To:     kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Jul 2021 11:23:55 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8DFFC1124F4
X-Spam-Status: No, score=-2.90
X-Stat-Signature: b7h8m76qpxzgcyngrbqcm1435qu5a5mh
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/DpiOIDDDO1qu6fPcRfsktG5/LD6FxNdc=
X-HE-Tag: 1626200637-79179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel janitorial task could be to remove blocks of code like:

	#ifdef CONFIG_<FOO>
		...
	#endif

where the config <FOO> symbol is not used in any Kconfig file.

Here is a trivial script to find these apparently unused Kconfig entries
that are in #ifdef CONFIG_<FOO> blocks and its current output of -next.

An example removal is: https://lore.kernel.org/lkml/997c0cdbd57752252d87129185a973c7d42e491f.camel@perches.com/T/#u

Be aware that some of the entries below are false positives.

For instance 1:
	CONFIG_X86_X32_ABI which is defined and exported in
	arch/x86/Makefile:export CONFIG_X86_X32_ABI

And it's possible other entries are typos of actual Kconfig symbols.

For instance 2:
	CONFIG_CPU_HAS_FP is likely a typo of CONFIG_CPU_HAS_FPU

	arch/csky/kernel/traps.c:#ifdef CONFIG_CPU_HAS_FPU
	arch/csky/kernel/traps.c:#ifdef CONFIG_CPU_HAS_FPU
	arch/csky/kernel/traps.c:#ifdef CONFIG_CPU_HAS_FP
	arch/csky/kernel/traps.c:#ifdef CONFIG_CPU_HAS_FP

But some of the referenced #ifdef blocks in the kernel source tree
could be completely removed.

Some of these entries are leftovers from code that once was enabled,
others are just entries that were never possible to enable.

$ git grep -P '^\s*#\s*if(?:def\s+|\s+defined\s*\(?\s*)CONFIG_[A-Z0-9_]+' | \
  grep -oh -P '\bCONFIG_[A-Z0-9_]+\b' | \
  sort | sed -e 's/^CONFIG_//' -e 's/_MODULE$//' | uniq | \
  while read config ; do \
    echo CONFIG_$config; \
    git grep -w $config -- '*/Kconfig*' | \
    wc -l; \
  done | \
  grep -B1 '^0'
CONFIG_ACORNSCSI_CONSTANTS
0
--
CONFIG_AS_CFI_VAL_OFFSET
0
--
CONFIG_ASYNC_TX_CHANNEL_SWITCH
0
--
CONFIG_B43_PCMCIA
0
--
CONFIG_BAND_CBAND
0
CONFIG_BAND_LBAND
0
CONFIG_BAND_SBAND
0
CONFIG_BAND_UHF
0
CONFIG_BAND_VHF
0
--
CONFIG_CAAM_QI
0
--
CONFIG_COMET_EARLY_UART_DEBUG
0
--
CONFIG_CPU_H300H
0
--
CONFIG_CPU_HAS_FP
0
--
CONFIG_CPU_SUBTYPE_ST40
0
--
CONFIG_DBX500_PRCMU_QOS_POWER
0
--
CONFIG_DEBUG_LL_SER3
0
--
CONFIG_DEBUG_SHIRQ_FIXME
0
--
CONFIG_DEBUG_ZTE_ZX
0
--
CONFIG_DIO_CONSTANTS
0
--
CONFIG_DRM_AMD_DC_DMUB
0
--
CONFIG_EXTRA_DEBUG_CHECKS
0
--
CONFIG_FSCACHE_OBJECT_LIST
0
--
CONFIG_FSL_DPA_PIRQ_FAST
0
CONFIG_FSL_DPA_PIRQ_SLOW
0
--
CONFIG_FUSION_MAX_FC_SGE
0
--
CONFIG_HP_HOOK_WORKAROUND
0
--
CONFIG_IEEE80211_DEBUG
0
--
CONFIG_IMX_GPT_ICAP
0
--
CONFIG_IPX_INTERN
0
CONFIG_IRDA
0
--
CONFIG_LMC_IGNORE_HARDWARE_HANDSHAKE
0
--
CONFIG_MY_KUNIT_TEST
0
--
CONFIG_NCR53C8XX_PREFETCH
0
--
CONFIG_NET_FUNKINESS
0
--
CONFIG_NILFS_POSIX_ACL
0
CONFIG_NILFS_XATTR
0
--
CONFIG_NOUVEAU_I2C_INTERNAL
0
--
CONFIG_OLPC_XO1_5_SCI
0
--
CONFIG_OPEN_FPU_DZE
0
CONFIG_OPEN_FPU_IDE
0
CONFIG_OPEN_FPU_IOE
0
CONFIG_OPEN_FPU_IXE
0
CONFIG_OPEN_FPU_OFE
0
CONFIG_OPEN_FPU_UFE
0
--
CONFIG_PAGE_SIZE_1MB
0
--
CONFIG_PINCTRL_DB8540
0
--
CONFIG_PM_SUSPEND
0
--
CONFIG_PPC_EARLY_DEBUG_MICROWATT
0
--
CONFIG_PXA_FICP
0
--
CONFIG_SA1100_CT6001
0
--
CONFIG_SBMAC_COALESCE
0
--
CONFIG_SCSI_NCR53C8XX_DISABLE_MPARITY_CHECK
0
CONFIG_SCSI_NCR53C8XX_DISABLE_PARITY_CHECK
0
CONFIG_SCSI_NCR53C8XX_FORCE_SYNC_NEGO
0
CONFIG_SCSI_NCR53C8XX_IARB
0
CONFIG_SCSI_NCR53C8XX_INTEGRITY_CHECK
0
--
CONFIG_SCSI_NCR53C8XX_NO_WORD_TRANSFERS
0
--
CONFIG_SGI_IP35
0
--
CONFIG_SOC_SAMA7
0
--
CONFIG_SOMETHING
0
--
CONFIG_SSB_DEBUG
0
--
CONFIG_STANDARD_DAB
0
CONFIG_STANDARD_DVBT
0
--
CONFIG_SYS_ISDBT
0
--
CONFIG_TASKS_RCU_TRACE
0
--
CONFIG_TUNER_DIB0090_P1B_SUPPORT
0
--
CONFIG_UM
0
--
CONFIG_WD33C93_PIO
0
--
CONFIG_X86_X32_ABI
0



