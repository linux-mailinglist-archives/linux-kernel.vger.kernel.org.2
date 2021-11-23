Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E44459E99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhKWIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:55:42 -0500
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:45418 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232385AbhKWIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:55:40 -0500
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6ED59180FA623;
        Tue, 23 Nov 2021 08:52:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 4EDB62000513;
        Tue, 23 Nov 2021 08:52:30 +0000 (UTC)
Message-ID: <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 23 Nov 2021 00:52:30 -0800
In-Reply-To: <20211123005528.GA550759@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
         <20211123005528.GA550759@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 496o9wecre354eosxah9tteecrm9b7yc
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4EDB62000513
X-Spam-Status: No, score=-1.87
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/XIT3tSsM1oxrqIB4tZmnKcw99lz8EyrU=
X-HE-Tag: 1637657550-671117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-22 at 18:55 -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 23, 2021 at 07:51:33AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   136057256686de39cc3a07c2e39ef6bc43003ff6
> > commit: dee2b702bcf067d7b6b62c18bdd060ff0810a800 kconfig: Add support for -Wimplicit-fallthrough
> > date:   8 days ago
> > config: mips-randconfig-r016-20211116 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dee2b702bcf067d7b6b62c18bdd060ff0810a800
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout dee2b702bcf067d7b6b62c18bdd060ff0810a800
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> >                    case CPU_CAVIUM_OCTEON:
> >                    ^
> >    arch/mips/mm/tlbex.c:2243:3: note: insert 'break;' to avoid fall-through
> >                    case CPU_CAVIUM_OCTEON:
> >                    ^
> >                    break; 
> 
> I already have a patch for this here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-linus/kspp&id=cd3ed04e7fc365e4e581333c3ff69c8da6ca0e8b

I think that's very odd looking code because of the braces.
And the fallthrough that you propose is odd as well.

Perhaps this would be better:
---
 arch/mips/mm/tlbex.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b131e6a773832..a873e343d3dc9 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2236,15 +2236,14 @@ static void build_r4000_tlb_load_handler(void)
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
-		default:
-			if (cpu_has_mips_r2_exec_hazard) {
-				uasm_i_ehb(&p);
-
 		case CPU_CAVIUM_OCTEON:
 		case CPU_CAVIUM_OCTEON_PLUS:
 		case CPU_CAVIUM_OCTEON2:
-				break;
-			}
+			break;
+		default:
+			if (cpu_has_mips_r2_exec_hazard)
+				uasm_i_ehb(&p);
+			break;
 		}
 
 		/* Examine  entrylo 0 or 1 based on ptr. */

