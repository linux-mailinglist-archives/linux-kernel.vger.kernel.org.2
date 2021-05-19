Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7E389610
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhESTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:02:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1259 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhESTCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:02:51 -0400
IronPort-SDR: gwZ2t32Winn6iXWo0I11KXHVp66O5DCYKBv71i6Bs3kC/QQn/jbnn6kMnRpuuvJKiCwYpw+Fuw
 QnLNq6lDSmSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286582795"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="gz'50?scan'50,208,50";a="286582795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:01:31 -0700
IronPort-SDR: SsCueatk7WcUa36W82nYeGqWZxEiXDlIk+sqeN0mEtou3rkBoyqvmRR/CjCOpO6Mr7z0rGg3Su
 vSjv7dMWtrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="gz'50?scan'50,208,50";a="473626434"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2021 12:01:28 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljRRg-0000Dg-4V; Wed, 19 May 2021 19:01:28 +0000
Date:   Thu, 20 May 2021 03:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202105200314.TS5zUUYA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   1 year ago
config: powerpc-klondike_defconfig (attached as .config)
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

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
C5+bAAA=

--Kj7319i9nmIyA2yE--
