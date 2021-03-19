Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B254342422
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCSSJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:09:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:60302 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCSSJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:09:22 -0400
IronPort-SDR: JlGbvcnuzHMCc70MpJXNtnvPU4b53InddUmTjAbSh5MoLWxblnzs00K1VgBOS6qi+SLByJn5eo
 8yEmxeGJtWJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="189979323"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="gz'50?scan'50,208,50";a="189979323"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:09:21 -0700
IronPort-SDR: +m1fxcYo4WbJLPrCyG2ymTAfOc0sA8AjEvZtNSYFHI33YcCUVXpq3yTdS6UPoZoOjBEEvpD00i
 s488BTjEJ4qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="gz'50?scan'50,208,50";a="380250730"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2021 11:09:19 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNJYk-0001yF-R9; Fri, 19 Mar 2021 18:09:18 +0000
Date:   Sat, 20 Mar 2021 02:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202103200230.2vnc40bR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b12a62a4e3ed4ae99c715034f557eb391d6b196
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   10 months ago
config: powerpc-allnoconfig (attached as .config)
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

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--YiEDa0DAkWCtVeE4--
