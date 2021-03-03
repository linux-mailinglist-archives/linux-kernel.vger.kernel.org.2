Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3129C32C3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhCCX7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:64541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387900AbhCCTe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:34:56 -0500
IronPort-SDR: sAZowOPpn62acVfXDqmuFv1M6yBcgHMX3ODfgWXTrDKx6JEUOrk3nqc9UkbsGBfcQ80TUzLBjU
 pI4NbHd17VZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251313573"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="251313573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:31:24 -0800
IronPort-SDR: JdqELqlo6WgW8hJaDeXFuxAtytEUIf0wPNXq7TVNCnYF3TEJauK8zVfMynOwFrjgYXnQjLG/Ni
 9k78Gza4Nn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="436087692"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2021 11:30:28 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHXCL-0001hD-Cy; Wed, 03 Mar 2021 19:30:17 +0000
Date:   Thu, 4 Mar 2021 03:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202103040359.PWeXYbFU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f69d02e37a85645aa90d18cacfff36dba370f797
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   10 months ago
config: powerpc-lite5200b_defconfig (attached as .config)
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

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ULqiPOdGVAagqQZgUnWvrg5wOOY/MkyQDvvPAAA=

--Qxx1br4bt0+wmkIi--
