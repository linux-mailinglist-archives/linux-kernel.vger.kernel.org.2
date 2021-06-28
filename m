Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBF3B59EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhF1HpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1HpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:45:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E10C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:42:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i189so21150121ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrHjTh56+CpfcNwqSDKgtu+WM7Qz/2fMTLpPKx03AZQ=;
        b=BpDWuGTeAhiAsfoS69ajg0nbvye6AOVBoXUOLlwlTycbGhImsH2Kk/QB9okIrqz9oH
         sIm5vFBH2BbxWamq91asFJQCUYbiRI6KofdVrshoofqRC1cXhBsUILW9duxTN1BTViej
         5JB3XL9+C4SXdE6vd+chy/DzDMrEqa0yCs6EQHk9D+srLzwYuvRsOvfaYCiUUoSWxPLX
         +7p83JrPF2Rqp7z4t6lNj0o1O3oJ40IwXortRKXmS8iJcM18hJ+1lLYE6xTuI6OwD2FE
         Ek0dV6P9gzgtjgB3AvFEA7kGPz005hXHhw8pCsf2znPxyYnBzwdRmEAr3cW32COy4YaU
         c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrHjTh56+CpfcNwqSDKgtu+WM7Qz/2fMTLpPKx03AZQ=;
        b=Qle63RjyB7WxHzcJAKizms+kN5dLU6DzBYs9kEAwNweQXVq6pemaQbjcrRl6c7FMIY
         iEeogPC2q+LhgjYsHL7iuDZSlMmEld1m7RpgrGVtMGT+DUc1FQQnNed7/e1yy7tWhTTq
         D+VimQ89/z5vqT4RDZJ+EKEVt9RgdKjlZBKSRHCuhGKGvzK5TWXfDqaqI5qP0rmq96+V
         0SZ0Zt5dGNKvnsMI60vK+ryBLbT+StdI7tPFsHU4dx2dVef/ojqI++oZ12ZnRuGweHoV
         mlRQdwQh+hwHtzuY6xdH4gK8GoELBOCb26qoChEPpFB6Dh58DWLYiOFv2vZyBiYpt5BS
         aTKw==
X-Gm-Message-State: AOAM533j0oHPrewQjFyjPOxWL4zTtT47DBKCB60MD1vEYhCQKRwKHXn1
        XwgAShQKE3PulXEX8QuyBInYPcuiKipPlIlP4R0=
X-Google-Smtp-Source: ABdhPJz20DYu/nPrWCKIdP90IceWH2oJzttOkR4GUWcxl28OMDwqdAzU/gkQ9sdpZT5h5YwLlX83A/lDRA/ZxnaS6aI=
X-Received: by 2002:a6b:5906:: with SMTP id n6mr7091819iob.7.1624866154709;
 Mon, 28 Jun 2021 00:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <202106281329.JLKL1c31-lkp@intel.com>
In-Reply-To: <202106281329.JLKL1c31-lkp@intel.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 28 Jun 2021 09:42:17 +0200
Message-ID: <CAOi1vP9NJ3nw9aWxtbzY2CA4WOx+A2kVeOvuiCFX5ZEidWTe5A@mail.gmail.com>
Subject: Re: net/ceph/messenger_v1.c:1204:5: warning: stack frame size (2880)
 exceeds limit (2048) in function 'ceph_con_v1_try_read'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 7:16 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Ilya,
>
> FYI, the error/warning still remains.

We won't be fixing the stack frame size warning here.  Please add it to the
allowlist.

Thanks,

                Ilya

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   62fb9874f5da54fdb243003b386128037319b219
> commit: 2f713615ddd9d805b6c5e79c52e0e11af99d2bf1 libceph: move msgr1 protocol implementation to its own file
> date:   7 months ago
> config: powerpc64-randconfig-r034-20210628 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 59558129276098d62046c8cda92240d292cbfb1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f713615ddd9d805b6c5e79c52e0e11af99d2bf1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2f713615ddd9d805b6c5e79c52e0e11af99d2bf1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    __do_insb
>    ^
>    arch/powerpc/include/asm/io.h:541:56: note: expanded from macro '__do_insb'
>    #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v1.c:8:
>    In file included from include/net/sock.h:38:
>    In file included from include/linux/hardirq.h:10:
>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:246:1: note: expanded from here
>    __do_insw
>    ^
>    arch/powerpc/include/asm/io.h:542:56: note: expanded from macro '__do_insw'
>    #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v1.c:8:
>    In file included from include/net/sock.h:38:
>    In file included from include/linux/hardirq.h:10:
>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:250:1: note: expanded from here
>    __do_insl
>    ^
>    arch/powerpc/include/asm/io.h:543:56: note: expanded from macro '__do_insl'
>    #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                           ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v1.c:8:
>    In file included from include/net/sock.h:38:
>    In file included from include/linux/hardirq.h:10:
>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:254:1: note: expanded from here
>    __do_outsb
>    ^
>    arch/powerpc/include/asm/io.h:544:58: note: expanded from macro '__do_outsb'
>    #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v1.c:8:
>    In file included from include/net/sock.h:38:
>    In file included from include/linux/hardirq.h:10:
>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:4:1: note: expanded from here
>    __do_outsw
>    ^
>    arch/powerpc/include/asm/io.h:545:58: note: expanded from macro '__do_outsw'
>    #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>    In file included from net/ceph/messenger_v1.c:8:
>    In file included from include/net/sock.h:38:
>    In file included from include/linux/hardirq.h:10:
>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/powerpc/include/asm/io.h:604:
>    arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                    __do_##name al;                                 \
>                    ^~~~~~~~~~~~~~
>    <scratch space>:8:1: note: expanded from here
>    __do_outsl
>    ^
>    arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
>    #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
> >> net/ceph/messenger_v1.c:1204:5: warning: stack frame size (2880) exceeds limit (2048) in function 'ceph_con_v1_try_read' [-Wframe-larger-than]
>    int ceph_con_v1_try_read(struct ceph_connection *con)
>        ^
>    14 warnings generated.
>
>
> vim +/ceph_con_v1_try_read +1204 net/ceph/messenger_v1.c
>
>   1200
>   1201  /*
>   1202   * Read what we can from the socket.
>   1203   */
> > 1204  int ceph_con_v1_try_read(struct ceph_connection *con)
>   1205  {
>   1206          int ret = -1;
>   1207
>   1208  more:
>   1209          dout("try_read start %p state %d\n", con, con->state);
>   1210          if (con->state != CEPH_CON_S_V1_BANNER &&
>   1211              con->state != CEPH_CON_S_V1_CONNECT_MSG &&
>   1212              con->state != CEPH_CON_S_OPEN)
>   1213                  return 0;
>   1214
>   1215          BUG_ON(!con->sock);
>   1216
>   1217          dout("try_read tag %d in_base_pos %d\n", (int)con->in_tag,
>   1218               con->in_base_pos);
>   1219
>   1220          if (con->state == CEPH_CON_S_V1_BANNER) {
>   1221                  ret = read_partial_banner(con);
>   1222                  if (ret <= 0)
>   1223                          goto out;
>   1224                  ret = process_banner(con);
>   1225                  if (ret < 0)
>   1226                          goto out;
>   1227
>   1228                  con->state = CEPH_CON_S_V1_CONNECT_MSG;
>   1229
>   1230                  /*
>   1231                   * Received banner is good, exchange connection info.
>   1232                   * Do not reset out_kvec, as sending our banner raced
>   1233                   * with receiving peer banner after connect completed.
>   1234                   */
>   1235                  ret = prepare_write_connect(con);
>   1236                  if (ret < 0)
>   1237                          goto out;
>   1238                  prepare_read_connect(con);
>   1239
>   1240                  /* Send connection info before awaiting response */
>   1241                  goto out;
>   1242          }
>   1243
>   1244          if (con->state == CEPH_CON_S_V1_CONNECT_MSG) {
>   1245                  ret = read_partial_connect(con);
>   1246                  if (ret <= 0)
>   1247                          goto out;
>   1248                  ret = process_connect(con);
>   1249                  if (ret < 0)
>   1250                          goto out;
>   1251                  goto more;
>   1252          }
>   1253
>   1254          WARN_ON(con->state != CEPH_CON_S_OPEN);
>   1255
>   1256          if (con->in_base_pos < 0) {
>   1257                  /*
>   1258                   * skipping + discarding content.
>   1259                   */
>   1260                  ret = ceph_tcp_recvmsg(con->sock, NULL, -con->in_base_pos);
>   1261                  if (ret <= 0)
>   1262                          goto out;
>   1263                  dout("skipped %d / %d bytes\n", ret, -con->in_base_pos);
>   1264                  con->in_base_pos += ret;
>   1265                  if (con->in_base_pos)
>   1266                          goto more;
>   1267          }
>   1268          if (con->in_tag == CEPH_MSGR_TAG_READY) {
>   1269                  /*
>   1270                   * what's next?
>   1271                   */
>   1272                  ret = ceph_tcp_recvmsg(con->sock, &con->in_tag, 1);
>   1273                  if (ret <= 0)
>   1274                          goto out;
>   1275                  dout("try_read got tag %d\n", (int)con->in_tag);
>   1276                  switch (con->in_tag) {
>   1277                  case CEPH_MSGR_TAG_MSG:
>   1278                          prepare_read_message(con);
>   1279                          break;
>   1280                  case CEPH_MSGR_TAG_ACK:
>   1281                          prepare_read_ack(con);
>   1282                          break;
>   1283                  case CEPH_MSGR_TAG_KEEPALIVE2_ACK:
>   1284                          prepare_read_keepalive_ack(con);
>   1285                          break;
>   1286                  case CEPH_MSGR_TAG_CLOSE:
>   1287                          ceph_con_close_socket(con);
>   1288                          con->state = CEPH_CON_S_CLOSED;
>   1289                          goto out;
>   1290                  default:
>   1291                          goto bad_tag;
>   1292                  }
>   1293          }
>   1294          if (con->in_tag == CEPH_MSGR_TAG_MSG) {
>   1295                  ret = read_partial_message(con);
>   1296                  if (ret <= 0) {
>   1297                          switch (ret) {
>   1298                          case -EBADMSG:
>   1299                                  con->error_msg = "bad crc/signature";
>   1300                                  fallthrough;
>   1301                          case -EBADE:
>   1302                                  ret = -EIO;
>   1303                                  break;
>   1304                          case -EIO:
>   1305                                  con->error_msg = "io error";
>   1306                                  break;
>   1307                          }
>   1308                          goto out;
>   1309                  }
>   1310                  if (con->in_tag == CEPH_MSGR_TAG_READY)
>   1311                          goto more;
>   1312                  ceph_con_process_message(con);
>   1313                  if (con->state == CEPH_CON_S_OPEN)
>   1314                          prepare_read_tag(con);
>   1315                  goto more;
>   1316          }
>   1317          if (con->in_tag == CEPH_MSGR_TAG_ACK ||
>   1318              con->in_tag == CEPH_MSGR_TAG_SEQ) {
>   1319                  /*
>   1320                   * the final handshake seq exchange is semantically
>   1321                   * equivalent to an ACK
>   1322                   */
>   1323                  ret = read_partial_ack(con);
>   1324                  if (ret <= 0)
>   1325                          goto out;
>   1326                  process_ack(con);
>   1327                  goto more;
>   1328          }
>   1329          if (con->in_tag == CEPH_MSGR_TAG_KEEPALIVE2_ACK) {
>   1330                  ret = read_keepalive_ack(con);
>   1331                  if (ret <= 0)
>   1332                          goto out;
>   1333                  goto more;
>   1334          }
>   1335
>   1336  out:
>   1337          dout("try_read done on %p ret %d\n", con, ret);
>   1338          return ret;
>   1339
>   1340  bad_tag:
>   1341          pr_err("try_read bad con->in_tag = %d\n", (int)con->in_tag);
>   1342          con->error_msg = "protocol error, garbage tag";
>   1343          ret = -1;
>   1344          goto out;
>   1345  }
>   1346
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
