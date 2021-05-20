Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7D389C59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhETEKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETEKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:10:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 21:09:18 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f9so20979920ybo.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6QIg+HGlA05hGXLpgdj8SC7kH5ffoKTkXzO6Yddm3Q=;
        b=sKWxnOfIqOAEZUi/QUshFqoO+T3dhoNsFQGveHOKhqstV/WnKO6jnlaF4DBOS2Whm5
         eK/OjRn3JFLhxrOWrDOYf8Y4lGWj0UkVDRef6Rv2xXy6z3LAanAOl0ttRA7ANcLDPFai
         B4Z6vmcN3FVQF+xnF9jCQQh7JCVg7Xk5dApGkLvqxRF2TMkm3hY7ajaKvmiW5BRTVz2A
         PWVEaZqv90D4pkcVJtc/yjF/+Z5LuWOzdA6PL4DmnAaW8rc7wfRONzGZiDclB3pao6fR
         DtY/DyecQVH9VnIazTRk5tXwPQxbqW0+xpQatQcyKmw6OLvRCcGrdEPFHkTWRmvT/D7U
         5L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6QIg+HGlA05hGXLpgdj8SC7kH5ffoKTkXzO6Yddm3Q=;
        b=U42x2F2jb/dS3BoCiO2f83OhaSBnCTr6U6x3lTtcrxhlfFwihm62Wrrjv8dJwgmgaN
         swUI+tWBZt9fGDu6x3guwazaZyaMRrMIGW81jMoLCw2ZYkLYSRYjZFLMSJmdQJkGAtRp
         vzoTsGlvDZaTdVw68Kc26G5ZFlB9FPQzG9d1JXhzLHsakpXlSTP1LiXnTsSQssM5xyIv
         dqPS+J50pHS5qlbOtG1rHemYuqqYhx792oDgAgGPxM35Syd0eRAGdZ7a/Zn/AWvVlgnf
         u9SeJVGlstpx+Wwzp4LsDNDCg+nQTxEDFxgaEYFqmm0KA97TrGRfvCr/F3OsTy3Isoif
         Z84A==
X-Gm-Message-State: AOAM533OwHhjwtF/YaXTl3vtjfUMTQbfKHcR8qf/AaEvz9qxkBH0gqlh
        feeWGnGF16xq+Rvz6o4hH4InojUfXCgzPCbcIo0=
X-Google-Smtp-Source: ABdhPJyfdtTj2Nu+kLFcG5AO5ylfW18wqOa0nNEL8VSkLTJbIrobBr7o6iGYvCtpCgVMAzLUnNcwJZ/uoDd5REUP3gE=
X-Received: by 2002:a25:204:: with SMTP id 4mr4468671ybc.342.1621483757730;
 Wed, 19 May 2021 21:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <202105200314.TS5zUUYA-lkp@intel.com>
In-Reply-To: <202105200314.TS5zUUYA-lkp@intel.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Thu, 20 May 2021 14:09:06 +1000
Message-ID: <CACzsE9q99HXR=pGBJXVnSF-CxHXRijAzdqKKBo8gX2HiJLgmsQ@mail.gmail.com>
Subject: Re: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set
 but not used
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 5:01 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jordan,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727
> commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
> date:   1 year ago
> config: powerpc-klondike_defconfig (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650b55b707fdfa764e9f2b81314d3eb4216fb962
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/lib/sstep.c: In function 'analyse_instr':
> >> arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
>     1172 |  unsigned int word, suffix;
Yeah, we should only need suffix if we have prefixed instructions.
>          |                     ^~~~~~
>    arch/powerpc/lib/sstep.c:1168:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
>     1168 |  unsigned int opcode, ra, rb, rc, rd, spr, u;
>          |                               ^~
>    cc1: all warnings being treated as errors
>
>
> vim +/suffix +1172 arch/powerpc/lib/sstep.c
>
>   1153
>   1154  /*
>   1155   * Decode an instruction, and return information about it in *op
>   1156   * without changing *regs.
>   1157   * Integer arithmetic and logical instructions, branches, and barrier
>   1158   * instructions can be emulated just using the information in *op.
>   1159   *
>   1160   * Return value is 1 if the instruction can be emulated just by
>   1161   * updating *regs with the information in *op, -1 if we need the
>   1162   * GPRs but *regs doesn't contain the full register set, or 0
>   1163   * otherwise.
>   1164   */
>   1165  int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   1166                    struct ppc_inst instr)
>   1167  {
>   1168          unsigned int opcode, ra, rb, rc, rd, spr, u;
>   1169          unsigned long int imm;
>   1170          unsigned long int val, val2;
>   1171          unsigned int mb, me, sh;
> > 1172          unsigned int word, suffix;
>   1173          long ival;
>   1174
>   1175          word = ppc_inst_val(instr);
>   1176          suffix = ppc_inst_suffix(instr);
>   1177
>   1178          op->type = COMPUTE;
>   1179
>   1180          opcode = ppc_inst_primary_opcode(instr);
>   1181          switch (opcode) {
>   1182          case 16:        /* bc */
>   1183                  op->type = BRANCH;
>   1184                  imm = (signed short)(word & 0xfffc);
>   1185                  if ((word & 2) == 0)
>   1186                          imm += regs->nip;
>   1187                  op->val = truncate_if_32bit(regs->msr, imm);
>   1188                  if (word & 1)
>   1189                          op->type |= SETLK;
>   1190                  if (branch_taken(word, regs, op))
>   1191                          op->type |= BRTAKEN;
>   1192                  return 1;
>   1193  #ifdef CONFIG_PPC64
>   1194          case 17:        /* sc */
>   1195                  if ((word & 0xfe2) == 2)
>   1196                          op->type = SYSCALL;
>   1197                  else
>   1198                          op->type = UNKNOWN;
>   1199                  return 0;
>   1200  #endif
>   1201          case 18:        /* b */
>   1202                  op->type = BRANCH | BRTAKEN;
>   1203                  imm = word & 0x03fffffc;
>   1204                  if (imm & 0x02000000)
>   1205                          imm -= 0x04000000;
>   1206                  if ((word & 2) == 0)
>   1207                          imm += regs->nip;
>   1208                  op->val = truncate_if_32bit(regs->msr, imm);
>   1209                  if (word & 1)
>   1210                          op->type |= SETLK;
>   1211                  return 1;
>   1212          case 19:
>   1213                  switch ((word >> 1) & 0x3ff) {
>   1214                  case 0:         /* mcrf */
>   1215                          op->type = COMPUTE + SETCC;
>   1216                          rd = 7 - ((word >> 23) & 0x7);
>   1217                          ra = 7 - ((word >> 18) & 0x7);
>   1218                          rd *= 4;
>   1219                          ra *= 4;
>   1220                          val = (regs->ccr >> ra) & 0xf;
>   1221                          op->ccval = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
>   1222                          return 1;
>   1223
>   1224                  case 16:        /* bclr */
>   1225                  case 528:       /* bcctr */
>   1226                          op->type = BRANCH;
>   1227                          imm = (word & 0x400)? regs->ctr: regs->link;
>   1228                          op->val = truncate_if_32bit(regs->msr, imm);
>   1229                          if (word & 1)
>   1230                                  op->type |= SETLK;
>   1231                          if (branch_taken(word, regs, op))
>   1232                                  op->type |= BRTAKEN;
>   1233                          return 1;
>   1234
>   1235                  case 18:        /* rfid, scary */
>   1236                          if (regs->msr & MSR_PR)
>   1237                                  goto priv;
>   1238                          op->type = RFI;
>   1239                          return 0;
>   1240
>   1241                  case 150:       /* isync */
>   1242                          op->type = BARRIER | BARRIER_ISYNC;
>   1243                          return 1;
>   1244
>   1245                  case 33:        /* crnor */
>   1246                  case 129:       /* crandc */
>   1247                  case 193:       /* crxor */
>   1248                  case 225:       /* crnand */
>   1249                  case 257:       /* crand */
>   1250                  case 289:       /* creqv */
>   1251                  case 417:       /* crorc */
>   1252                  case 449:       /* cror */
>   1253                          op->type = COMPUTE + SETCC;
>   1254                          ra = (word >> 16) & 0x1f;
>   1255                          rb = (word >> 11) & 0x1f;
>   1256                          rd = (word >> 21) & 0x1f;
>   1257                          ra = (regs->ccr >> (31 - ra)) & 1;
>   1258                          rb = (regs->ccr >> (31 - rb)) & 1;
>   1259                          val = (word >> (6 + ra * 2 + rb)) & 1;
>   1260                          op->ccval = (regs->ccr & ~(1UL << (31 - rd))) |
>   1261                                  (val << (31 - rd));
>   1262                          return 1;
>   1263                  }
>   1264                  break;
>   1265          case 31:
>   1266                  switch ((word >> 1) & 0x3ff) {
>   1267                  case 598:       /* sync */
>   1268                          op->type = BARRIER + BARRIER_SYNC;
>   1269  #ifdef __powerpc64__
>   1270                          switch ((word >> 21) & 3) {
>   1271                          case 1:         /* lwsync */
>   1272                                  op->type = BARRIER + BARRIER_LWSYNC;
>   1273                                  break;
>   1274                          case 2:         /* ptesync */
>   1275                                  op->type = BARRIER + BARRIER_PTESYNC;
>   1276                                  break;
>   1277                          }
>   1278  #endif
>   1279                          return 1;
>   1280
>   1281                  case 854:       /* eieio */
>   1282                          op->type = BARRIER + BARRIER_EIEIO;
>   1283                          return 1;
>   1284                  }
>   1285                  break;
>   1286          }
>   1287
>   1288          /* Following cases refer to regs->gpr[], so we need all regs */
>   1289          if (!FULL_REGS(regs))
>   1290                  return -1;
>   1291
>   1292          rd = (word >> 21) & 0x1f;
>   1293          ra = (word >> 16) & 0x1f;
>   1294          rb = (word >> 11) & 0x1f;
>   1295          rc = (word >> 6) & 0x1f;
>   1296
>   1297          switch (opcode) {
>   1298  #ifdef __powerpc64__
>   1299          case 2:         /* tdi */
>   1300                  if (rd & trap_compare(regs->gpr[ra], (short) word))
>   1301                          goto trap;
>   1302                  return 1;
>   1303  #endif
>   1304          case 3:         /* twi */
>   1305                  if (rd & trap_compare((int)regs->gpr[ra], (short) word))
>   1306                          goto trap;
>   1307                  return 1;
>   1308
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
