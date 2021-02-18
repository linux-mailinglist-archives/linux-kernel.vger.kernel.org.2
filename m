Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9231F0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBRUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:03:12 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:22924 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBRTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:51:19 -0500
Date:   Thu, 18 Feb 2021 19:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613677832;
        bh=5ggeVjRn5F1Ls1DzZNiFFb/uh50A5QU8V2mtMiRuhrk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=uel7JH/5FamK4gB7wE0K3UgWUBRBVLbWLP6id9k+riaKejAs3hfjYY28xkpCxQ4Sk
         3kuRHGn+054v1DbDARkFc3BZ2IHkb6fenJkDP7rGf3yeVyVuCnDWZE8J2k8uouoPz6
         qZmY407E8vVHS461XGEvQlqnR9Tv4SxHLcXYiz60=
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        d.straghkov@ispras.ru, tiwai@suse.de
From:   Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kurt Manucredo <fuzzybritches@protonmail.com>
Reply-To: Kurt Manucredo <fuzzybritches@protonmail.com>
Subject: [PATCH] staging: rtl8723bs: make if-statement checkpatch.pl conform
Message-ID: <20210218194830.8-1-fuzzybritches@protonmail.com>
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

The preferred coding style is:
=09if (!StaAddr)
=09return;

thank you mr. dan carpenter

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


