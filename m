Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656ED3F418C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhHVUoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:44:08 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:58646 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHVUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:44:03 -0400
Date:   Sun, 22 Aug 2021 20:43:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629665000;
        bh=XynyHm48qxpiEu1n5TctT5wC6O1IqPXoy0obJpg/WPI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=m3t8qWnzve7woRzaiYYnEqLR+LfSdfLnxidTPTDnsyBt/9PR869B/ML/ii3W//tMq
         d4Yxc7am+NMKO+5oF6tNlwo5li3k2n5Lvej282KJnqmwZ+2b9eU4l9SQnEN+6FR4LV
         9QY8Tlt27kRAPHk6i1BCl9zWiTZ2xcZ3DLnh/8RTRODwCyOWyxtWXDrsmNl76uCyGK
         0jDRduGwbliEk57XcyVTBz5b/tyTILliK3ywfiuh4x+38kfOh8HXX2jC/fDm9PbaLt
         r8BTC4FVHUtM8yJH3e0gBoxo1KdF5r8dwHYxAp9GiGBvpih8ArmsIZFkxDyNk/DtII
         JyMt7ShH+8ZIw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2 1/5] staging: rtl8723bs: remove sdio_write_mem()
Message-ID: <20210822204212.2832397-2-hello@bryanbrattlof.com>
In-Reply-To: <20210822204212.2832397-1-hello@bryanbrattlof.com>
References: <20210822204212.2832397-1-hello@bryanbrattlof.com>
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


