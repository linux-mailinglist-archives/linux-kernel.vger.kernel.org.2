Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FBB318D14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBKONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:13:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:32954 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhBKN4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:56:13 -0500
IronPort-SDR: hgw1AAP+l/YG2BrqOOZwQ+I5C/KHfVnfxWvt0LNRjR9l5r5jNP170lLTqn5swT6gn3faDJwRud
 rNcd7Bp1L08g==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161384719"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="gz'50?scan'50,208,50";a="161384719"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:55:49 -0800
IronPort-SDR: x9THu9oCNnp49P4I9j7/Z1WEbLVr1rfB/L79xJ3mgCuKVPE35/4jtykraMpGOKEz9P7I7zu87G
 wiPEFpsQ+R4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="gz'50?scan'50,208,50";a="586945993"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2021 05:55:46 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lACRe-0003p8-1B; Thu, 11 Feb 2021 13:55:46 +0000
Date:   Thu, 11 Feb 2021 21:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202102112134.SH9wtlHn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   9 months ago
config: powerpc-canyonlands_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650b55b707fdfa764e9f2b81314d3eb4216fb962
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
>> arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
    1172 |  unsigned int word, suffix;
         |                     ^~~~~~
   arch/powerpc/lib/sstep.c:1168:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
    1168 |  unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                               ^~
   cc1: all warnings being treated as errors


vim +/suffix +1172 arch/powerpc/lib/sstep.c

  1153	
  1154	/*
  1155	 * Decode an instruction, and return information about it in *op
  1156	 * without changing *regs.
  1157	 * Integer arithmetic and logical instructions, branches, and barrier
  1158	 * instructions can be emulated just using the information in *op.
  1159	 *
  1160	 * Return value is 1 if the instruction can be emulated just by
  1161	 * updating *regs with the information in *op, -1 if we need the
  1162	 * GPRs but *regs doesn't contain the full register set, or 0
  1163	 * otherwise.
  1164	 */
  1165	int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
  1166			  struct ppc_inst instr)
  1167	{
  1168		unsigned int opcode, ra, rb, rc, rd, spr, u;
  1169		unsigned long int imm;
  1170		unsigned long int val, val2;
  1171		unsigned int mb, me, sh;
> 1172		unsigned int word, suffix;
  1173		long ival;
  1174	
  1175		word = ppc_inst_val(instr);
  1176		suffix = ppc_inst_suffix(instr);
  1177	
  1178		op->type = COMPUTE;
  1179	
  1180		opcode = ppc_inst_primary_opcode(instr);
  1181		switch (opcode) {
  1182		case 16:	/* bc */
  1183			op->type = BRANCH;
  1184			imm = (signed short)(word & 0xfffc);
  1185			if ((word & 2) == 0)
  1186				imm += regs->nip;
  1187			op->val = truncate_if_32bit(regs->msr, imm);
  1188			if (word & 1)
  1189				op->type |= SETLK;
  1190			if (branch_taken(word, regs, op))
  1191				op->type |= BRTAKEN;
  1192			return 1;
  1193	#ifdef CONFIG_PPC64
  1194		case 17:	/* sc */
  1195			if ((word & 0xfe2) == 2)
  1196				op->type = SYSCALL;
  1197			else
  1198				op->type = UNKNOWN;
  1199			return 0;
  1200	#endif
  1201		case 18:	/* b */
  1202			op->type = BRANCH | BRTAKEN;
  1203			imm = word & 0x03fffffc;
  1204			if (imm & 0x02000000)
  1205				imm -= 0x04000000;
  1206			if ((word & 2) == 0)
  1207				imm += regs->nip;
  1208			op->val = truncate_if_32bit(regs->msr, imm);
  1209			if (word & 1)
  1210				op->type |= SETLK;
  1211			return 1;
  1212		case 19:
  1213			switch ((word >> 1) & 0x3ff) {
  1214			case 0:		/* mcrf */
  1215				op->type = COMPUTE + SETCC;
  1216				rd = 7 - ((word >> 23) & 0x7);
  1217				ra = 7 - ((word >> 18) & 0x7);
  1218				rd *= 4;
  1219				ra *= 4;
  1220				val = (regs->ccr >> ra) & 0xf;
  1221				op->ccval = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
  1222				return 1;
  1223	
  1224			case 16:	/* bclr */
  1225			case 528:	/* bcctr */
  1226				op->type = BRANCH;
  1227				imm = (word & 0x400)? regs->ctr: regs->link;
  1228				op->val = truncate_if_32bit(regs->msr, imm);
  1229				if (word & 1)
  1230					op->type |= SETLK;
  1231				if (branch_taken(word, regs, op))
  1232					op->type |= BRTAKEN;
  1233				return 1;
  1234	
  1235			case 18:	/* rfid, scary */
  1236				if (regs->msr & MSR_PR)
  1237					goto priv;
  1238				op->type = RFI;
  1239				return 0;
  1240	
  1241			case 150:	/* isync */
  1242				op->type = BARRIER | BARRIER_ISYNC;
  1243				return 1;
  1244	
  1245			case 33:	/* crnor */
  1246			case 129:	/* crandc */
  1247			case 193:	/* crxor */
  1248			case 225:	/* crnand */
  1249			case 257:	/* crand */
  1250			case 289:	/* creqv */
  1251			case 417:	/* crorc */
  1252			case 449:	/* cror */
  1253				op->type = COMPUTE + SETCC;
  1254				ra = (word >> 16) & 0x1f;
  1255				rb = (word >> 11) & 0x1f;
  1256				rd = (word >> 21) & 0x1f;
  1257				ra = (regs->ccr >> (31 - ra)) & 1;
  1258				rb = (regs->ccr >> (31 - rb)) & 1;
  1259				val = (word >> (6 + ra * 2 + rb)) & 1;
  1260				op->ccval = (regs->ccr & ~(1UL << (31 - rd))) |
  1261					(val << (31 - rd));
  1262				return 1;
  1263			}
  1264			break;
  1265		case 31:
  1266			switch ((word >> 1) & 0x3ff) {
  1267			case 598:	/* sync */
  1268				op->type = BARRIER + BARRIER_SYNC;
  1269	#ifdef __powerpc64__
  1270				switch ((word >> 21) & 3) {
  1271				case 1:		/* lwsync */
  1272					op->type = BARRIER + BARRIER_LWSYNC;
  1273					break;
  1274				case 2:		/* ptesync */
  1275					op->type = BARRIER + BARRIER_PTESYNC;
  1276					break;
  1277				}
  1278	#endif
  1279				return 1;
  1280	
  1281			case 854:	/* eieio */
  1282				op->type = BARRIER + BARRIER_EIEIO;
  1283				return 1;
  1284			}
  1285			break;
  1286		}
  1287	
  1288		/* Following cases refer to regs->gpr[], so we need all regs */
  1289		if (!FULL_REGS(regs))
  1290			return -1;
  1291	
  1292		rd = (word >> 21) & 0x1f;
  1293		ra = (word >> 16) & 0x1f;
  1294		rb = (word >> 11) & 0x1f;
  1295		rc = (word >> 6) & 0x1f;
  1296	
  1297		switch (opcode) {
  1298	#ifdef __powerpc64__
  1299		case 2:		/* tdi */
  1300			if (rd & trap_compare(regs->gpr[ra], (short) word))
  1301				goto trap;
  1302			return 1;
  1303	#endif
  1304		case 3:		/* twi */
  1305			if (rd & trap_compare((int)regs->gpr[ra], (short) word))
  1306				goto trap;
  1307			return 1;
  1308	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EeQfGwPcQSOJBaQU--
