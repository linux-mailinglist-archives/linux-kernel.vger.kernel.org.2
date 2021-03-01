Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505ED327D75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhCALnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhCALnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:43:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 03:42:33 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id f20so17337325ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aINR1+Bo8I3NYfvd42QRmxd/ctoiHE+DLs7UyhEye8=;
        b=QZLP9vxK3ZbWZgNnAzvnYV17aPmqjoFVMg8Tk6qXYO/PoDQ6ZP5XB53vMHARgkH6SZ
         hLPxHN1qV4KdXhY2qt7V7EnHpRMjycr0gSgQqiJvfzapaekG0FBANlf+XZWjhzkK8oY6
         dcsSeaHguHP5veygJTk9i0fJHSa9k2YKa26RtCXJo21HZfAi0ebbknb6+UjD3R2KMwPh
         RRMHmedXCTIFpvwSKNaVLx/LlUeuSWHIUzVxui0d/wFnB/qMXGEOHsVR7XA9BfFF2zks
         QY7IC6EAKQlkyUjWwSIHWX4O8uPtg+DHzP75PjxOtwa5dz0CCQzQb/D1Yy+V71I7JU19
         hBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aINR1+Bo8I3NYfvd42QRmxd/ctoiHE+DLs7UyhEye8=;
        b=PR+LyO4FMRUfaCwk5+mWNwqHNNoV2tHBglzUBlYgdfm2TGtGIMblNukspTTGtuRWSr
         WL6MjbuLds/vNCb1AuD82l02Wmqpmnv95g8mg3jk0AmltR1WhKg5KFrvUZLK16B2+k8Y
         Cj9EYJv1CFGftiSyBu9cPzpsi6HTtFG3e2eggKwDCMnyOYv2bXaEcY65duA/q+gUBoQ9
         Dsn/q7qY6kA0uK3HiwMLDhBsnQEI7Bq5BkYoe2D1c6IvN/gBLto0u8eT01MI4r6kF3sH
         LWCjMdfIXyM7jmYV7z2na2QqlxsVzfF5Br0oGJVR0epr3726K9UQY/jJPU5C0vwAgkCS
         JPeA==
X-Gm-Message-State: AOAM533JCPyU7cQJTFn9CrgAxg+DAXxPaMSoVzQ5Zj2GHzSkBtAZWiRk
        jHjEhcVdfuG7L0CnxqgguUzZBlUw3kQiHWRDOrs1nmjOjIQ=
X-Google-Smtp-Source: ABdhPJw/m2C1y31V4P5T+Cr6woDc7hwbOurh5GESGQvv/F5iePGhJz4jE9J/XgIwMjNMC2G9bxClYajT+wrtiPur1AE=
X-Received: by 2002:a02:6f08:: with SMTP id x8mr15431611jab.69.1614598953257;
 Mon, 01 Mar 2021 03:42:33 -0800 (PST)
MIME-Version: 1.0
References: <202103011657.ttO1k7BO-lkp@intel.com>
In-Reply-To: <202103011657.ttO1k7BO-lkp@intel.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 1 Mar 2021 12:42:24 +0100
Message-ID: <CAOi1vP8nq6fOC+coHdq8w63k5uq8kXHY9zgtxDs0k_aVWY88wQ@mail.gmail.com>
Subject: Re: net/ceph/messenger_v1.c:1204:5: warning: stack frame size of 2944
 bytes in function 'ceph_con_v1_try_read'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 9:36 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Ilya,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
> commit: 2f713615ddd9d805b6c5e79c52e0e11af99d2bf1 libceph: move msgr1 protocol implementation to its own file
> date:   3 months ago

It's fine.  This commit just moved the code which has been this way for
years and never caused any real issues.  Please add it to the allowlist
if possible.

> config: powerpc64-randconfig-r001-20210301 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 5de09ef02e24d234d9fc0cd1c6dfe18a1bb784b0)
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
>    <scratch space>:32:1: note: expanded from here
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
>    <scratch space>:36:1: note: expanded from here
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
>    <scratch space>:40:1: note: expanded from here
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
>    <scratch space>:44:1: note: expanded from here
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
>    <scratch space>:48:1: note: expanded from here
>    __do_outsl
>    ^
>    arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
>    #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
> >> net/ceph/messenger_v1.c:1204:5: warning: stack frame size of 2944 bytes in function 'ceph_con_v1_try_read' [-Wframe-larger-than=]
>    int ceph_con_v1_try_read(struct ceph_connection *con)
>        ^
>    13 warnings generated.
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

Thanks,

                Ilya
