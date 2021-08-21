Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E223F3CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHUX4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:56:54 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:38764 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUX4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:56:53 -0400
Date:   Sat, 21 Aug 2021 23:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629590172;
        bh=CnGDwMCmb3wl+up2ny2MnsRvSz1XHCXVpk2rgvjWGyc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=NIdzkbR5sHFp9aMLXGURYmVlcIXlhE1sDYj9xr7fTIlO0EpoFcb6lXO+WRWidfJLX
         fDFhSU55Y4oNWJ0j2l3RnZ5KAw/NKvoQjTDjqJfC3O731Ws0rApsa1as0mSM84tKBU
         sDy3fuZdLdoj0bYN7/E0tvJXY7sHQ0KF5SmkAAAW5zM5GM8OQRSWL4juSZqP+NYBRm
         8G1XDUGrTvJlrjGKHPdNx7zQaV4EW0H2NZOSuDbTKNSbbzyt9i4gdrFeg89aLGPkdB
         31MOieeUHoQBm7prQZPYYQzqtMF8QDQQKZXiH4y3e3rxID2LXJFsV9ItwIkBgInej7
         nGFdVM69WeSmA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 6/6] staging: rtl8723bs: remove _read_port from _io_ops structure
Message-ID: <20210821235456.2502681-6-hello@bryanbrattlof.com>
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

The function pointer, '_read_port' inside _io_ops is unused.
We can remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 1 -
 drivers/staging/rtl8723bs/include/rtw_io.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 928fa109565e..768a4e553c77 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -355,7 +355,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_read8 =3D &sdio_read8;
 =09ops->_read16 =3D &sdio_read16;
 =09ops->_read32 =3D &sdio_read32;
-=09ops->_read_port =3D &sdio_read_port;

 =09ops->_write8 =3D &sdio_write8;
 =09ops->_write16 =3D &sdio_write16;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index fa0cedadaa79..4e0a9f71ce1f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -83,7 +83,6 @@ struct _io_ops {
 =09=09int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 =09=09int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);

-=09=09u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *=
pmem);
 =09=09u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 =
*pmem);
 };

--
2.30.2


