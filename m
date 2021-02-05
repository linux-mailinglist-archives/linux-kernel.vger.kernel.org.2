Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170A3117EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBFApi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:45:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:48330 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBEKJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:09:25 -0500
IronPort-SDR: Cj0BTdFw0jhwuz59AniiDeixcRYX1Q82qAa1cZoKdujiIvLVIIOnpRp2hMBTfODu6soHP2eCh2
 txT4QKgIXcXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181477237"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="181477237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 02:08:24 -0800
IronPort-SDR: k0v0j5EDq4tjr616unBWgqzJvIgNxAzeNxkteD3a7DbHivpGjBOxzaFKxVsArpFuDY3Q5rRkmo
 ZuVCLEdRm70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="373338823"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2021 02:08:22 -0800
Date:   Fri, 5 Feb 2021 18:08:21 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
Message-ID: <20210205100821.GA71063@shbuild999.sh.intel.com>
References: <202101051834.FGH835Vs-lkp@intel.com>
 <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe and Michael,

On Mon, Jan 18, 2021 at 10:24:08PM +0800, Christophe Leroy wrote:
> 
> 
> Le 05/01/2021 ? 11:58, kernel test robot a 閏rit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> > commit: 8b8319b181fd9d6821703fef1228b4dcde613a16 powerpc/44x: Don't support 440 when CONFIG_PPC_47x is set
> 
> I see no link with that commit. Looks like the problem has been existing for some time.
> It exists on the commit before that one, it exists on v5.9 and it exists on v5.10 with that commit
> reverted.
 
Yes, this seems to be a long-standing issue, and we just double checked
this compile error. 

It happend when compiling arch/powerpc/platforms/44x/fsp2.c, macro
'mfdcr' requirs an instant number as parameter, while is not met by
show_plbopb_regs(). Changing show_plbopb_regs() from function to
a macro fixes the error, as the patch below:

Thanks,
Feng


From 3bcb9638afc873d0e803aea1aad4f77bf1c2f6f6 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 5 Feb 2021 16:08:43 +0800
Subject: [PATCH] powerpc/44x/fsp2: fix a compiling error regarding macro
 'mdfcr'

0day's kbuild test found error:

"
  CC      arch/powerpc/platforms/44x/fsp2.o

  {standard input}:577: Error: unsupported relocation against base
  {standard input}:580: Error: unsupported relocation against base
  {standard input}:583: Error: unsupported relocation against base
"

The reason is macro 'mfdcr' requirs an instant number as parameter,
which is not met by show_plbopb_regs().

Fix it by converting show_plbopb_regs() from function to macro.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/powerpc/platforms/44x/fsp2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index b299e43..4732669 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -66,15 +66,15 @@ static void l2regs(void)
 	pr_err("LOG5:     0x%08x\n", mfl2(L2LOG5));
 }
 
-static void show_plbopb_regs(u32 base, int num)
-{
-	pr_err("\nPLBOPB Bridge %d:\n", num);
-	pr_err("GESR0: 0x%08x\n", mfdcr(base + PLB4OPB_GESR0));
-	pr_err("GESR1: 0x%08x\n", mfdcr(base + PLB4OPB_GESR1));
-	pr_err("GESR2: 0x%08x\n", mfdcr(base + PLB4OPB_GESR2));
-	pr_err("GEARU: 0x%08x\n", mfdcr(base + PLB4OPB_GEARU));
-	pr_err("GEAR:  0x%08x\n", mfdcr(base + PLB4OPB_GEAR));
-}
+#define show_plbopb_regs(base, num) \
+	{ \
+		pr_err("\nPLBOPB Bridge %d:\n", num); \
+		pr_err("GESR0: 0x%08x\n", mfdcr(base + PLB4OPB_GESR0)); \
+		pr_err("GESR1: 0x%08x\n", mfdcr(base + PLB4OPB_GESR1)); \
+		pr_err("GESR2: 0x%08x\n", mfdcr(base + PLB4OPB_GESR2)); \
+		pr_err("GEARU: 0x%08x\n", mfdcr(base + PLB4OPB_GEARU)); \
+		pr_err("GEAR:  0x%08x\n", mfdcr(base + PLB4OPB_GEAR)); \
+	}
 
 static irqreturn_t bus_err_handler(int irq, void *data)
 {
-- 
2.7.4




> > date:   5 weeks ago
> > config: powerpc-randconfig-p002-20210105 (attached as .config)
> > compiler: powerpc-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b8319b181fd9d6821703fef1228b4dcde613a16
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 8b8319b181fd9d6821703fef1228b4dcde613a16
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >     {standard input}: Assembler messages:
> >>> {standard input}:577: Error: unsupported relocation against base
> >     {standard input}:580: Error: unsupported relocation against base
> >     {standard input}:583: Error: unsupported relocation against base
> >     {standard input}:586: Error: unsupported relocation against base
> >     {standard input}:589: Error: unsupported relocation against base
> >     {standard input}:592: Error: unsupported relocation against base
> >     {standard input}:595: Error: unsupported relocation against base
> >     {standard input}:598: Error: unsupported relocation against base
> >     {standard input}:601: Error: unsupported relocation against base
> >     {standard input}:604: Error: unsupported relocation against base
> >     {standard input}:607: Error: unsupported relocation against base
> >     {standard input}:610: Error: unsupported relocation against base
> >     {standard input}:613: Error: unsupported relocation against base
> >     {standard input}:616: Error: unsupported relocation against base
> >     {standard input}:619: Error: unsupported relocation against base
> >     {standard input}:622: Error: unsupported relocation against base
> >     {standard input}:625: Error: unsupported relocation against base
> >     {standard input}:628: Error: unsupported relocation against base
> >     {standard input}:631: Error: unsupported relocation against base
> >     {standard input}:634: Error: unsupported relocation against base
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> 
