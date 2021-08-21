Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2494E3F3CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhHUX40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:56:26 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:37384 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:56:26 -0400
Date:   Sat, 21 Aug 2021 23:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629590143;
        bh=gXCBmejyL0AxreKWxIYZe8NroSccI+2risFB9ccUXkM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Ie6BZX3e+zoxv4J9jscq9TQMOgfnaoyttESYYUohyJxAwEr4jMqyfNdWVRd6gjEZv
         4kVo8OxIIEHnKbbJOPaUJoh21Ncubafq1ffwZwmj0k+UXCHtnTP+a83lSjJR66p2ld
         etf2MGkRAbewtxgCIiW6lJYm7pNsdeUJhM9n1ptfxoDVcc3q2wB7DpQACc+jQwfJcd
         X+VJXZlmSs9ZVav1FQkm5gzz4kvYLIrQThG5ljzuSHCsnzckEJ5Awga6Eapnph5j4B
         H+ZSY+r64TLiJLo/OecZf1A3F2d6e2DJGkVVeAtD1QoTFEXpAcj7S9U1wUOeTKV08D
         MRzpDkjTOdbdw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 3/6] staging: rtl8723bs: remove sdio_read_mem()
Message-ID: <20210821235456.2502681-3-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdio_read_mem() function is unused. We can remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 11 -----------
 drivers/staging/rtl8723bs/include/rtw_io.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 6bd662928ab6..019ace4b8564 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -299,16 +299,6 @@ static s32 sdio_write32(struct intf_hdl *intfhdl, u32 =
addr, u32 val)
 =09return err;
 }

-static void sdio_read_mem(
-=09struct intf_hdl *intfhdl,
-=09u32 addr,
-=09u32 cnt,
-=09u8 *rmem
-)
-{
-=09sdio_readN(intfhdl, addr, cnt, rmem);
-}
-
 /*
  * Description:
  *Read from RX FIFO
@@ -410,7 +400,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_read8 =3D &sdio_read8;
 =09ops->_read16 =3D &sdio_read16;
 =09ops->_read32 =3D &sdio_read32;
-=09ops->_read_mem =3D &sdio_read_mem;
 =09ops->_read_port =3D &sdio_read_port;

 =09ops->_write8 =3D &sdio_write8;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 0753e20cfaa2..43102f65bddd 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -89,8 +89,6 @@ struct _io_ops {
 =09=09int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 =09=09int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);

-=09=09void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *=
pmem);
-
 =09=09void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);

 =09=09u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
--
2.30.2


