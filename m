Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2331FEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:24:47 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:15204 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:24:44 -0500
Date:   Fri, 19 Feb 2021 18:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613759038;
        bh=INaW8+67y2Qr+AIhL2pM7hrEvl532xeKD+BY3hq66KE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ZeIXOuhZLe2y1vN9M39L7Bs8Vnq3W5g3wQeoAHeKPcVy5k4zNwxfUav5KXrBBHBSN
         UPTAbLBTbY5ni3uOkGp1CDe3o2CnQPXTL/npHxLfhwtIt+bJ91j86J9Jmjh61C4ISF
         32boGRavG0K//mFdcGin2L/kPcaOrQtL5S/O9X+g=
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        d.straghkov@ispras.ru, tiwai@suse.de
From:   Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     Kurt Manucredo <fuzzybritches@protonmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Reply-To: Kurt Manucredo <fuzzybritches@protonmail.com>
Subject: [PATCH v3] staging: rtl8723bs: fix code style comparison warning
Message-ID: <20210219182331.8-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



checkpatch gives the following WARNING:
WARNING: Comparisons should place the constant on the right side of the tes=
t
this patch fixes the coding style warning.

Signed-off-by: Kurt Manucredo <fuzzybritches@protonmail.com>
---

changes since previous version:
- put version chatter below the --- cut off line.

thank you very much for your help Mr. Dan Carpenter.

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_wlan_util.c
index 975f2830e29e..96feced698ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -2146,7 +2146,7 @@ void rtw_get_sec_iv(struct adapter *padapter, u8 *pcu=
r_dot11txpn, u8 *StaAddr)
 =09struct security_priv *psecpriv =3D &padapter->securitypriv;
=20
 =09memset(pcur_dot11txpn, 0, 8);
-=09if (NULL =3D=3D StaAddr)
+=09if (!StaAddr)
 =09=09return;
 =09psta =3D rtw_get_stainfo(&padapter->stapriv, StaAddr);
 =09DBG_871X("%s(): StaAddr: %02x %02x %02x %02x %02x %02x\n",
--=20
2.20.1


