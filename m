Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8FC3F9C38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbhH0QOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:14:16 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:39735 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245515AbhH0QOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:14:15 -0400
Date:   Fri, 27 Aug 2021 16:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630080805;
        bh=XynyHm48qxpiEu1n5TctT5wC6O1IqPXoy0obJpg/WPI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PbLDuRZqzF4bkdE8D02d0I3s/CoPv5uLdsJSYL7tWrDgvHOugxLgnxsw3rQNVb0LF
         paIb5OiI+En/KWIaHJMNGe7L6oVBJPL1VNNIc/Q7BDExY/FVbxG8HHh9yxW1dvA61j
         Z5s9v3RDU6s3btK3S08BHcXkf2dkjwesihvYDeuW5MVd182e/u5DsX60wS/IuNFOoW
         ClcuxpzoU46j8ha3wpU5nWDpXCX3+Kj0L49e0Z5qhUfWrUPirSfIie2JAO9xzVBnDK
         c15lf/bDD28fcEouT4fbLWQe7EVWCqiKkZrT0m1HqKhTDmpJd6hxaHoYh9/FdcZw/c
         5XbvZ0Pb4UUyA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 1/5] staging: rtl8723bs: remove sdio_write_mem()
Message-ID: <39bc74b0303bb31cef0ac44b9ae2b2aa7abbe645.1630080164.git.hello@bryanbrattlof.com>
In-Reply-To: <cover.1630080164.git.hello@bryanbrattlof.com>
References: <cover.1630080164.git.hello@bryanbrattlof.com>
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


