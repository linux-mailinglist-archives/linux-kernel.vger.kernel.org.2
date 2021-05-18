Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44665387FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbhERScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:32:16 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:61228 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbhERScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:32:15 -0400
Date:   Tue, 18 May 2021 18:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362656;
        bh=Ft22HqYo2AThkyB2+K8CaEUK18hcuOzcoh/D1tvmuQo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hDWDVmfrJi2LD2VH3Hoe124WOoVWexVg6XhUinhIpGx8KTIKtycJIvURF9GjCMDbB
         e3uxGIFhhNSMHebNFWwjx/v0Gb+vKwRlZCy/n9TTnS3+uds4/3JJm6AnkgM9yx9efA
         O+BwFwyvY027H7oFCWPJk3afVy0V7Ph8rkB13V/0XQ+dn5q8ayHPveKafP+hbQ1zHX
         W0jgDhMDEjgZvl+Col7gUBPSMQMWMsmtEv0tgtUevGruutL0Vd6wAe0v6BYmOYM8Vl
         6a1E4LQHOgi15YVmKfA7L0DEDsONDzKXTR0YGnOeRGoW/rL8KZM3kqmFCWeHr4XBuW
         pwGGQRZDt09/Q==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 8/8] staging: rtl8723bs: remove _rtw_sd_f0_read8()
Message-ID: <5f025724ea7149e6ff11f94352b3321833f9bcaf.1621361919.git-series.hello@bryanbrattlof.com>
In-Reply-To: <cover.7975aa58aadc20eae4102c8c0fe0e0d0ecb0a9fa.1621361919.git-series.hello@bryanbrattlof.com>
References: <cover.7975aa58aadc20eae4102c8c0fe0e0d0ecb0a9fa.1621361919.git-series.hello@bryanbrattlof.com>
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

Both the _rtw_sd_f0_read8() function and the rtw_sd_f0_read8()
redefinition are used anywhere in the driver and can be removed.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 19 -------------------
 drivers/staging/rtl8723bs/include/rtw_io.h |  4 ----
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 6de549e90999..856e23398c03 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -116,25 +116,6 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32=
 val)
 =09return RTW_STATUS_CODE(ret);
 }

-u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr)
-{
-=09u8 r_val =3D 0x00;
-=09struct io_priv *pio_priv =3D &adapter->iopriv;
-=09struct intf_hdl *pintfhdl =3D &(pio_priv->intf);
-=09u8 (*_sd_f0_read8)(struct intf_hdl *pintfhdl, u32 addr);
-
-=09_sd_f0_read8 =3D pintfhdl->io_ops._sd_f0_read8;
-
-=09if (_sd_f0_read8)
-=09=09r_val =3D _sd_f0_read8(pintfhdl, addr);
-=09else
-=09=09netdev_warn(adapter->pnetdev,
-=09=09=09    FUNC_ADPT_FMT " _sd_f0_read8 callback is NULL\n",
-=09=09=09    FUNC_ADPT_ARG(adapter));
-
-=09return r_val;
-}
-
 u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 =09u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pm=
em);
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 48e1352ac48a..ab3c5ffe011b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -178,12 +178,8 @@ extern int rtw_write8(struct adapter *adapter, u32 add=
r, u8 val);
 extern int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);

-extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr);
-
 extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *=
pmem);

-#define rtw_sd_f0_read8(adapter, addr) _rtw_sd_f0_read8((adapter), (addr))
-
 extern void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);

 /* ioreq */
--
git-series 0.9.1

