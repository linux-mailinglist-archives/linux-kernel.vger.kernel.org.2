Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9341933CA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhCOXvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:51:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:61148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhCOXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:50:53 -0400
IronPort-SDR: HMTw4ilzibnTbyAxeuLaVCezWofFlR0Vtk6ad2lClNYbT8ZgDHR/nQyue0EL2m1MP5jNLJ0X1g
 Ypfzdckspvdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253187087"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253187087"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:50:53 -0700
IronPort-SDR: gZFRjNQgE7vgSC4AlrnVGiNoBzPzD3Ce1KtV4vNT7hcQfCiY0bMT1bjvKh2YTSqOC9t+MqGE5r
 gWQIZWwcEyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="378673300"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2021 16:50:51 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLwz4-0000he-Uc; Mon, 15 Mar 2021 23:50:50 +0000
Date:   Tue, 16 Mar 2021 07:50:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:x86/cpu 2/3] arch/x86/kernel/alternative.c:96:10: warning:
 Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds.
Message-ID: <202103160701.3uXlWiWM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
head:   301cddc21a157a3072d789a3097857202e550a24
commit: a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6 [2/3] x86: Remove dynamic NOP selection
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds. [pointerOutOfBounds]
    x86nops + 1 + 2 + 3 + 4,
            ^
   arch/x86/kernel/alternative.c:97:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+15' is out of bounds. [pointerOutOfBounds]
    x86nops + 1 + 2 + 3 + 4 + 5,
            ^
   arch/x86/kernel/alternative.c:98:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+21' is out of bounds. [pointerOutOfBounds]
    x86nops + 1 + 2 + 3 + 4 + 5 + 6,
            ^
   arch/x86/kernel/alternative.c:99:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+28' is out of bounds. [pointerOutOfBounds]
    x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
            ^
>> arch/x86/kernel/ftrace.c:304:7: warning: union member 'ftrace_op_code_union::code' is never used. [unusedStructMember]
    char code[OP_REF_SIZE];
         ^

vim +96 arch/x86/kernel/alternative.c

    88	
    89	const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
    90	{
    91		NULL,
    92		x86nops,
    93		x86nops + 1,
    94		x86nops + 1 + 2,
    95		x86nops + 1 + 2 + 3,
  > 96		x86nops + 1 + 2 + 3 + 4,
    97		x86nops + 1 + 2 + 3 + 4 + 5,
    98		x86nops + 1 + 2 + 3 + 4 + 5 + 6,
    99		x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
   100	};
   101	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
