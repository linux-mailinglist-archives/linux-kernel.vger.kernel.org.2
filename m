Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A43F9C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbhH0QPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:15:11 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:64591 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245421AbhH0QPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:15:10 -0400
Date:   Fri, 27 Aug 2021 16:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630080859;
        bh=u9TG8D1sXOpxCV7cWsT5xz5t+ZPbr7+gevnOxBRbilw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=LeMdBPVjB9dBkBTGBgx2LEmAy5NDFpKSl4aYo8Wn/6gIOag8zdNpZd/2LGxFGj7sY
         jtn9whkcFBSIJ9zDYeooGo1V1tbfYaCTDmnBqtYDZTyikZPSMnB0+oA4AOJZCO1S4F
         8jzMF7Jw01L3iRalR0UIkqAE/IP37YRmxDNG71SXrU6rmaIvc7H7arWtrf83gCXYar
         pn70YT5r6fGnbrTNa/adRI2c+d5Lp5z9Rkbr1Xw3rILNOeVnhLwgfpjYX2FqZcmbOp
         sBUutr9R5Ysa1q6/Afq2cx4IW/Q1reEU7cQ8ESXRlT2Uw5iQKOsY6xVuIV0UiLOyK3
         8So5LxT2Bkt4g==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 4/5] staging: rtl8723bs: remove unused definitions from rtw_io.h
Message-ID: <31e5ca3d846dc638c75d36c6f6b1259d7b225f9f.1630080164.git.hello@bryanbrattlof.com>
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

There are a few unused definitions inside rtw_io.h We can remove them.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/include/rtw_io.h | 91 ----------------------
 1 file changed, 91 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 43102f65bddd..fa0cedadaa79 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -72,9 +72,7 @@

 #define _INTF_ASYNC_=09BIT(0)=09/* support async io */

-struct intf_priv;
 struct intf_hdl;
-struct io_queue;

 struct _io_ops {
 =09=09u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
@@ -85,33 +83,8 @@ struct _io_ops {
 =09=09int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 =09=09int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);

-=09=09int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-=09=09int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
-=09=09int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-
-=09=09void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
-
-=09=09u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
-
 =09=09u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *=
pmem);
 =09=09u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 =
*pmem);
-
-=09=09u32 (*_write_scsi)(struct intf_hdl *pintfhdl, u32 cnt, u8 *pmem);
-
-=09=09void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
-=09=09void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
-};
-
-struct io_req {
-=09struct list_head=09list;
-=09u32 addr;
-=09volatile u32 val;
-=09u32 command;
-=09u32 status;
-=09u8 *pbuf;
-
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt);
-=09u8 *cnxt;
 };

 struct=09intf_hdl {
@@ -132,16 +105,6 @@ Below is the data structure used by _io_handler

 */

-struct io_queue {
-=09spinlock_t=09lock;
-=09struct list_head=09free_ioreqs;
-=09struct list_head=09=09pending;=09=09/* The io_req list that will be ser=
ved in the single protocol read/write. */
-=09struct list_head=09=09processing;
-=09u8 *free_ioreqs_buf; /*  4-byte aligned */
-=09u8 *pallocated_free_ioreqs_buf;
-=09struct=09intf_hdl=09intf;
-};
-
 struct io_priv {

 =09struct adapter *padapter;
@@ -150,20 +113,6 @@ struct io_priv {

 };

-extern uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue)=
;
-extern void sync_ioreq_enqueue(struct io_req *preq, struct io_queue *ioque=
ue);
-extern uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioq=
ueue);
-
-
-extern uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
-extern struct io_req *alloc_ioreq(struct io_queue *pio_q);
-
-extern uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
-extern void unregister_intf_hdl(struct intf_hdl *pintfhdl);
-
-extern void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u=
8 *pmem);
-extern void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, =
u8 *pmem);
-
 extern u8 rtw_read8(struct adapter *adapter, u32 addr);
 extern u16 rtw_read16(struct adapter *adapter, u32 addr);
 extern u32 rtw_read32(struct adapter *adapter, u32 addr);
@@ -174,46 +123,6 @@ extern int rtw_write32(struct adapter *adapter, u32 ad=
dr, u32 val);

 extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *=
pmem);

-extern void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
-
-/* ioreq */
-extern void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
-extern void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
-extern void ioreq_read32(struct adapter *adapter, u32 addr, u32 *pval);
-extern void ioreq_write8(struct adapter *adapter, u32 addr, u8 val);
-extern void ioreq_write16(struct adapter *adapter, u32 addr, u16 val);
-extern void ioreq_write32(struct adapter *adapter, u32 addr, u32 val);
-
-
-extern uint async_read8(struct adapter *adapter, u32 addr, u8 *pbuff,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-extern uint async_read16(struct adapter *adapter, u32 addr,  u8 *pbuff,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-extern uint async_read32(struct adapter *adapter, u32 addr,  u8 *pbuff,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-
-extern void async_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);
-extern void async_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8=
 *pmem);
-
-extern void async_write8(struct adapter *adapter, u32 addr, u8 val,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-extern void async_write16(struct adapter *adapter, u32 addr, u16 val,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-extern void async_write32(struct adapter *adapter, u32 addr, u32 val,
-=09void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_=
req, u8 *cnxt), u8 *cnxt);
-
-extern void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8=
 *pmem);
-extern void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u=
8 *pmem);
-
-
 int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct=
 adapter *padapter, struct _io_ops *pops));

-
-extern uint alloc_io_queue(struct adapter *adapter);
-extern void free_io_queue(struct adapter *adapter);
-extern void async_bus_io(struct io_queue *pio_q);
-extern void bus_sync_io(struct io_queue *pio_q);
-extern u32 _ioreq2rwmem(struct io_queue *pio_q);
-extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);
-
 #endif=09/* _RTL8711_IO_H_ */
--
2.30.2


