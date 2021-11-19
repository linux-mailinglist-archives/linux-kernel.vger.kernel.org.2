Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6D45714A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhKSPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhKSPC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:02:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6FA61AA7;
        Fri, 19 Nov 2021 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637333997;
        bh=GshKi1N2lMhxm6kjrgjRizd8dlh/k0FDm8ct+O56+Mo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SyDOjgWX643f1kpu4+N5rWcIolMR2Thne/5krFtrjvLEC4UKLei+XrenmTqaneevi
         zy4BO2WJO/A4fvtxy5pXcOR15wIpJSOA0oGuZrfUL+prywJcFlX6mb5rcxfAxLXJh7
         GUsFN7GfuwHDq4iNcXSkeZlb7ORIyFduXZzzUZ+VHqmMOHdTzyO34EcGQw6y/QPw/p
         IE7jRvYbrmxaf20TZL38CfeLg8deM/eVPasWzgcjylyEVPLiN2OUUJ6mx+hC7lsjrT
         ppLLoThEiDeS9n4CM1WbY5C/dAqOxfulPQnOMDZGSJuqlkRPI2rnARbkEaq/BKjIpq
         NK6lRe4tUosdg==
Date:   Fri, 19 Nov 2021 15:59:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     kernel test robot <lkp@intel.com>
cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-nintendo.c:196:45: error: unused variable
 'joycon_rumble_frequencies'
In-Reply-To: <202111141514.s63tieIl-lkp@intel.com>
Message-ID: <nycvar.YFH.7.76.2111191559350.16505@cbobk.fhfr.pm>
References: <202111141514.s63tieIl-lkp@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2021, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c8c109546a19613d323a319d0c921cb1f317e629
> commit: daf11ca2b9f45a1ac6f90af5a61ee4db915110b1 HID: nintendo: fix -Werror build
> date:   13 days ago
> config: i386-buildonly-randconfig-r003-20211114 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dddeeafb529e769cde87bd29ef6271ac6bfa5c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/hid/hid-nintendo.c:196:45: error: unused variable 'joycon_rumble_frequencies' [-Werror,-Wunused-const-variable]
>    static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
>                                                ^
> >> drivers/hid/hid-nintendo.c:254:44: error: unused variable 'joycon_rumble_amplitudes' [-Werror,-Wunused-const-variable]
>    static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
>                                               ^
> >> drivers/hid/hid-nintendo.c:400:18: error: unused variable 'JC_RUMBLE_DFLT_LOW_FREQ' [-Werror,-Wunused-const-variable]
>    static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
>                     ^
> >> drivers/hid/hid-nintendo.c:401:18: error: unused variable 'JC_RUMBLE_DFLT_HIGH_FREQ' [-Werror,-Wunused-const-variable]
>    static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
>                     ^
> >> drivers/hid/hid-nintendo.c:403:29: error: unused variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' [-Werror,-Wunused-const-variable]
>    static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
>                                ^
>    5 errors generated.

From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: nintendo: eliminate dead datastructures in !CONFIG_NINTENDO_FF case

The rumbling-related identifiers are never used in !CONFIG_NINTENDO_FF
case, so let's hide them in order to avoid unused warnings.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-nintendo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 7e1d1127493e..b6a9a0f3966e 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -189,6 +189,7 @@ struct joycon_rumble_amp_data {
 	u16 amp;
 };
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
 /*
  * These tables are from
  * https://github.com/dekuNukem/Nintendo_Switch_Reverse_Engineering/blob/master/rumble_data_table.md
@@ -289,6 +290,10 @@ static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
 	{ 0xc2, 0x8070,  940 }, { 0xc4, 0x0071,  960 }, { 0xc6, 0x8071,  981 },
 	{ 0xc8, 0x0072, joycon_max_rumble_amp }
 };
+static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
+static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
+#endif /* IS_ENABLED(CONFIG_NINTENDO_FF) */
+static const u16 JC_RUMBLE_PERIOD_MS = 50;
 
 /* States for controller state machine */
 enum joycon_ctlr_state {
@@ -397,9 +402,6 @@ struct joycon_input_report {
 #define JC_RUMBLE_DATA_SIZE	8
 #define JC_RUMBLE_QUEUE_SIZE	8
 
-static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
-static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
-static const u16 JC_RUMBLE_PERIOD_MS = 50;
 static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
 
 static const char * const joycon_player_led_names[] = {
-- 
2.12.3


-- 
Jiri Kosina
SUSE Labs

