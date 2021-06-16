Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE25C3A941C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFPHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:36:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:39009 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhFPHgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:36:45 -0400
IronPort-SDR: jvL9yZBZw1f4h0qeMohrcD//W/mLv4TsKP/yUBKbziNrv39fRaW5HcVh0fI6cc+mShegL2yPHG
 4LPHC3j+FwPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203109435"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="203109435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 00:34:40 -0700
IronPort-SDR: tju26XTtT5CtSiJa+42+6hw9m/hu3AjlCFfT8dthm9xR7YXfatXk2vYbm04LaUuF5xQNWhDGwk
 ZjnaFeczxSqA==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="484782709"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 00:34:35 -0700
Date:   Wed, 16 Jun 2021 15:34:32 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [powerpc:next-test 113/124] arch/powerpc/kernel/interrupt_64.S:
 asm/head-64.h is included more than once.
Message-ID: <20210616073432.GX237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
head:   103bf32b0d2dd8b8a4d3d9ebdded5ba4e8263e6a
commit: 5592c877d21b6ca201aafca349663c5a41f134f0 [113/124] powerpc/64: move interrupt return asm to interrupt_64.S
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/interrupt_64.S: asm/head-64.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
