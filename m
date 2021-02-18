Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE631EEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhBRSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:47:54 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:39313 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhBRQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:34:00 -0500
Date:   Thu, 18 Feb 2021 16:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613665996;
        bh=Xmnm25F8dJtzGykuyOII2OVkiSzMXlVCWeP0bkrqxBQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=TqLoqE2RZew5co5AF2tHpaZ018klI3mwIBQ5srfuK37W3zT0oo4WfBy3dBCK3MavL
         AXdUw/NZZeirXv4r7beTDYDNJJbjpSOXUN7bjoWuwqPpEwPxUHL0t9gV5LuERiTA0Q
         RbioLWjVbikyuV7F4RM0ZY8onHxGdVQPI6ERa0AI=
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        d.straghkov@ispras.ru, tiwai@suse.de
From:   Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kurt Manucredo <fuzzybritches@protonmail.com>
Reply-To: Kurt Manucredo <fuzzybritches@protonmail.com>
Subject: [PATCH] Staging: rtl8723bs: code-style fix
Message-ID: <20210218163204.7-1-fuzzybritches@protonmail.com>
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

Signed-off-by: Kurt Manucredo <fuzzybritches@protonmail.com>
---

Checkpatch complains the constant needs to be on the right side of the
comparison. The preferred way is:=20

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_wlan_util.c
index 089c6ec19373..96feced698ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -2146,7 +2146,7 @@ void rtw_get_sec_iv(struct adapter *padapter, u8 *pcu=
r_dot11txpn, u8 *StaAddr)
 =09struct security_priv *psecpriv =3D &padapter->securitypriv;
=20
 =09memset(pcur_dot11txpn, 0, 8);
-=09if (StaAddr =3D=3D NULL)
+=09if (!StaAddr)
 =09=09return;
 =09psta =3D rtw_get_stainfo(&padapter->stapriv, StaAddr);
 =09DBG_871X("%s(): StaAddr: %02x %02x %02x %02x %02x %02x\n",
--=20
2.20.1


