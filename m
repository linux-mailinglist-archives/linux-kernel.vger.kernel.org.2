Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5569E3F3CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhHUXz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:55:59 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:47653 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:55:58 -0400
Date:   Sat, 21 Aug 2021 23:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629590117;
        bh=XynyHm48qxpiEu1n5TctT5wC6O1IqPXoy0obJpg/WPI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=NLQ/gA5qWK5723aKXeieZZDCo01NYml/PnBLTpzqH98r2Cl/u36PW0wTZVEBiAL+a
         wEnInF9rVaXtLNdKDmoKRkJj3Rqiu1FEWDhn8JBr/PaYoGQFiP0zSEg81rK/mRmYYH
         4DqeDMQgl1g3K9xXIxd8sifZz8NGsfx+hWh3YHK+s0FW+FntVuk05qSvbKPusCzYG/
         8ku8WwyAQ183H2fKLDnQw7cG/AUAPqE+usubmHZiFH7N/7+mVnQ2FjV76KQ60tJkg6
         z0ch/0WtPNiUCXBr4ogPnQ0PxpfHugKwKxI0Ru6bKxIghrGL+Qw4cQ12cijeO2Bk0X
         Oc9QPSwrnMONA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 1/6] staging: rtl8723bs: remove sdio_write_mem()
Message-ID: <20210821235456.2502681-1-hello@bryanbrattlof.com>
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

The sdio_write_mem() function is unused in the driver. We can remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 11 -----------
 drivers/staging/rtl8723bs/include/rtw_io.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index a545832a468e..b784a390c8e1 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -356,16 +356,6 @@ static void sdio_read_mem(
 =09sdio_readN(intfhdl, addr, cnt, rmem);
 }

-static void sdio_write_mem(
-=09struct intf_hdl *intfhdl,
-=09u32 addr,
-=09u32 cnt,
-=09u8 *wmem
-)
-{
-=09sdio_writeN(intfhdl, addr, cnt, wmem);
-}
-
 /*
  * Description:
  *Read from RX FIFO
@@ -474,7 +464,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_write16 =3D &sdio_write16;
 =09ops->_write32 =3D &sdio_write32;
 =09ops->_writeN =3D &sdio_writeN;
-=09ops->_write_mem =3D &sdio_write_mem;
 =09ops->_write_port =3D &sdio_write_port;
 }

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index e98083a07a66..87f36b7e880f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -91,7 +91,6 @@ struct _io_ops {
 =09=09int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);

 =09=09void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *=
pmem);
-=09=09void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 =
*pmem);

 =09=09void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);

--
2.30.2


