Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7E41770A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbhIXOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:49:46 -0400
Received: from mout.web.de ([212.227.15.3]:54515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhIXOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632494881;
        bh=BzlUt9Xoxf80BIN5jJgcV7RyKPyglvJA26rX64Gy8AY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TxtoO8zAxYLvTaDlISzulZfUT10zN0elorBXW+icGQvnYHxisv9vOV2AqREvk8NBI
         9X0F6GxpNhX8FAMSlVNB2twUMMbnw+MfuEIu+kVl2SbFh0hbDbB/0wz5xu5+XQrw+2
         knfFqXj3VuBu6d5VM3Rv6fXHrZuT3wfze9iMAAY0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from michael-LIFEBOOK-E751.fritz.box ([94.134.119.126]) by
 smtp.web.de (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6V2p-1mnfzu0l0V-00yUPN; Fri, 24 Sep 2021 16:48:01 +0200
From:   Michael Estner <michaelestner@web.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     michaelestner@web.de, Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove blank lines and whitespaces
Date:   Fri, 24 Sep 2021 16:47:41 +0200
Message-Id: <20210924144750.6020-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaLzsh9OHcYP5E4RKRwkDx295xrdUB93/YjatXKYnKQuMdIYAqC
 zqp24oZqMz1yQ2Mu3nDzQPXZJn8GjNZgBicPXLNfJLmLd2dxcKpqdpoDvjrhf0n0DOUCsps
 qs5OEX1poS2s2Byo0FFaFH+UCc1W+BrZKMfVlKP4EXV7Expy7xSIYuFRXtnqd5F6Nbv5+M8
 iiyhKTNEGGBcQOitlmIiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uj7yb3oyG6s=:Fli+c8cgpf9zJ9vHAzyM5j
 VYCEvEfuyLTyNnR7r8CvGKmdZTMF7aE3+uSuQZ+80/oOpRX0t0nlVZbOEAFSpEgIm6IrbCgJ8
 XMLO85BdPE1XLQ3PKJP99hx0kypzoi7HLtcmAU/7bjIupnn7NFMZLAg0gVLLSk4wF74ABhSmA
 zt7c6oMyLIlff8clMVXF5m4j12a3AvML7kyLtywD7h3qY5T4lL9G+D29Kx4nYCx4edh3AvTa3
 f5hi7ELTziMimh8h6kzWRU4a4CLk4UE5fx/85kxPUvwNcEN+4XWgeRN/mKuurDtwFmmsezZdH
 8/k7c6NPLI6KX/ki9Wd+KJ93WmOr/Ifbo3DXQTdMe4ZRnjnxMfWCYNCKJ88s2zNGAjVg7pYgs
 rnZtprfddSxcdFZaXAQvwF34oGBOCFD29U6l5o26vYizc6cHO20VTBoGjbyNLLTS68C6h5vrV
 IgKriehpOb8C3Ye5g14DAVx5Yr/gBd0msRFYR4EZOG480b7z31wZhUTGM2D5p77UV2UWaYt5P
 4XiK51KwojRsqxGdeR+i++MsjBDo5Dship9jqtzugORjSTFQoymuY4BsWBLzYTcg0RD9YA19q
 kL3fEUCxxmDkSixGvjCr7hf9KW8HliFjWVpu3nI+hjadg9a9k5Rs/rVqdlZtxEtu4NvdSLTs+
 hL4nYs3RiIhjYFgZsVnk5QtrjXKd83zBVm8+GC26Nmh4oPQ6+y7JZn6h6C/U2PkFfLJQPxAtE
 dBS0UYvqKu3Zv9ENFpGOfL5yNdHTd3jSbdWHziqRaGZFz2VBmoXmxlu23nnp5iKMKgYTszT1e
 dghk4pHf0NH9A4Yefa5BxCaoj5utSSjALxZ0FKFegxWGRqP8X2DFHcilmRpxi/qnYwrmWLx22
 AFAnqHPb8xqwomiihFzSzPttxQ8P686SIhw7/hgoVO6P5uusbx9cg8IbHCFkw4h36ojW8SVgx
 HPjc+ZdEnPN5BRZ7wTSEATPYVFlrjGDdy44XvkjacBkCr7u7Jz47zoFEUfxAhlDwhPWCFUK5J
 dXgWlYd4vVx+fl4xv4aq8NekZuXycWQ3Y1oC+K1IHI0EUKVaEQV5PR0hFWvCyZ/jwrGMOkCkg
 9SFpBihIrVfKQM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed blank lines and whitespaces to clean up code.

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 drivers/staging/r8188eu/core/rtw_io.c | 65 ++++++++++-----------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188=
eu/core/rtw_io.c
index cde0205816b1..4abbd551db81 100644
=2D-- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -2,25 +2,25 @@
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */

 /*
-
-The purpose of rtw_io.c
-
-a. provides the API
-
-b. provides the protocol engine
-
-c. provides the software interface between caller and the hardware interf=
ace
-
-Compiler Flag Option:
-
-USB:
-   a. USE_ASYNC_IRP: Both sync/async operations are provided.
-
-Only sync read/rtw_write_mem operations are provided.
-
-jackson@realtek.com.tw
-
-*/
+ *
+ * The purpose of rtw_io.c
+ *
+ * a. provides the API
+ *
+ * b. provides the protocol engine
+ *
+ * c. provides the software interface between caller and the hardware int=
erface
+ *
+ * Compiler Flag Option:
+ *
+ * USB:
+ *    a. USE_ASYNC_IRP: Both sync/async operations are provided.
+ *
+ * Only sync read/rtw_write_mem operations are provided.
+ *
+ * jackson@realtek.com.tw
+ *
+ */

 #define _RTW_IO_C_
 #include "../include/osdep_service.h"
@@ -41,7 +41,6 @@ u8 _rtw_read8(struct adapter *adapter, u32 addr)
 	struct	intf_hdl *pintfhdl =3D &pio_priv->intf;
 	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);

-
 	_read8 =3D pintfhdl->io_ops._read8;
 	r_val =3D _read8(pintfhdl, addr);

@@ -87,7 +86,6 @@ int _rtw_write8(struct adapter *adapter, u32 addr, u8 va=
l)

 	ret =3D _write8(pintfhdl, addr, val);

-
 	return RTW_STATUS_CODE(ret);
 }

@@ -102,9 +100,9 @@ int _rtw_write16(struct adapter *adapter, u32 addr, u1=
6 val)

 	ret =3D _write16(pintfhdl, addr, val);

-
 	return RTW_STATUS_CODE(ret);
 }
+
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *pio_priv =3D &adapter->iopriv;
@@ -116,7 +114,6 @@ int _rtw_write32(struct adapter *adapter, u32 addr, u3=
2 val)

 	ret =3D _write32(pintfhdl, addr, val);

-
 	return RTW_STATUS_CODE(ret);
 }

@@ -131,9 +128,9 @@ int _rtw_writeN(struct adapter *adapter, u32 addr, u32=
 length, u8 *pdata)

 	ret =3D _writeN(pintfhdl, addr, length, pdata);

-
 	return RTW_STATUS_CODE(ret);
 }
+
 int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv =3D &adapter->iopriv;
@@ -145,7 +142,6 @@ int _rtw_write8_async(struct adapter *adapter, u32 add=
r, u8 val)

 	ret =3D _write8_async(pintfhdl, addr, val);

-
 	return RTW_STATUS_CODE(ret);
 }

@@ -181,12 +177,11 @@ void _rtw_read_mem(struct adapter *adapter, u32 addr=
, u32 cnt, u8 *pmem)
 	struct io_priv *pio_priv =3D &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl =3D &pio_priv->intf;

-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-	     return;
+		return;
+
 	_read_mem =3D pintfhdl->io_ops._read_mem;
 	_read_mem(pintfhdl, addr, cnt, pmem);
-
 }

 void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
@@ -195,13 +190,9 @@ void _rtw_write_mem(struct adapter *adapter, u32 addr=
, u32 cnt, u8 *pmem)
 	struct io_priv *pio_priv =3D &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl =3D &pio_priv->intf;

-
-
 	_write_mem =3D pintfhdl->io_ops._write_mem;

 	_write_mem(pintfhdl, addr, cnt, pmem);
-
-
 }

 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
@@ -210,16 +201,12 @@ void _rtw_read_port(struct adapter *adapter, u32 add=
r, u32 cnt, u8 *pmem)
 	struct io_priv *pio_priv =3D &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl =3D &pio_priv->intf;

-
-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-	     return;
+		return;

 	_read_port =3D pintfhdl->io_ops._read_port;

 	_read_port(pintfhdl, addr, cnt, pmem);
-
-
 }

 void _rtw_read_port_cancel(struct adapter *adapter)
@@ -241,14 +228,10 @@ u32 _rtw_write_port(struct adapter *adapter, u32 add=
r, u32 cnt, u8 *pmem)
 	struct	intf_hdl		*pintfhdl =3D &pio_priv->intf;
 	u32 ret =3D _SUCCESS;

-
-
 	_write_port =3D pintfhdl->io_ops._write_port;

 	ret =3D _write_port(pintfhdl, addr, cnt, pmem);

-
-
 	return ret;
 }

=2D-
2.25.1

