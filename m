Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A837970A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhEJSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:30:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:43407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232214AbhEJSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:30:12 -0400
IronPort-SDR: lC4pJk3AjIIxompp/rj9kDMt28++d2NxIfnk7YtS6t6wH5PPIKvfB7+gRxmDwhnMk/af7cHJW3
 4H2g4Fljxr7w==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197275442"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="gz'50?scan'50,208,50";a="197275442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 11:29:07 -0700
IronPort-SDR: gbAY2BRYhzI3zKLMWwpUKS1Im34Sr0Zv9fiSHyaVnfRILpcFBdItMywIZbXOIMD5OCmO3h+x+K
 5SuQZTEb1wLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="gz'50?scan'50,208,50";a="541316746"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2021 11:29:04 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgAeO-0000Jy-55; Mon, 10 May 2021 18:29:04 +0000
Date:   Tue, 11 May 2021 02:27:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202105110252.nVQyXZxV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6efb943b8616ec53a5e444193dccf1af9ad627b5
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   12 months ago
config: powerpc-mpc866_ads_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650b55b707fdfa764e9f2b81314d3eb4216fb962
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=powerpc 

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

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--
