Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E561B31EE30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhBRSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:23:33 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:49051 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhBRPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:55:37 -0500
Date:   Thu, 18 Feb 2021 15:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613663683;
        bh=OwDtZtFMadZiig+h6XKqgkc1XKr1EH2J9L/7rIWs+9s=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=U4Lck1nBMb8sjSSRj2OPeNx0oxXT4J2rpOkJUCDoV0kJJU6YtvIQR+vD4HP+Rss+Y
         Y6PeFupfHjiYfbopLFCMh/cACMu1oAIkibdObQYqC9NNLfkOHV7Sw6h7tHQja3rNDN
         xyyGoH281UCypt1H5g6bUzb4xrECWsqCtGKWbyq8=
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     Kurt Manucredo <fuzzybritches@protonmail.com>
Reply-To: Kurt Manucredo <fuzzybritches@protonmail.com>
Subject: [PATCH] fix comparisons - put constant on right side- eudyptula challenge 10
Message-ID: <20210218155422.7-2-fuzzybritches@protonmail.com>
In-Reply-To: <20210218155422.7-1-fuzzybritches@protonmail.com>
References: <20210218155422.7-1-fuzzybritches@protonmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/stagi=
ng/rtl8723bs/core/rtw_wlan_util.c
index 975f2830e29e..089c6ec19373 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -2146,7 +2146,7 @@ void rtw_get_sec_iv(struct adapter *padapter, u8 *pcu=
r_dot11txpn, u8 *StaAddr)
 =09struct security_priv *psecpriv =3D &padapter->securitypriv;
=20
 =09memset(pcur_dot11txpn, 0, 8);
-=09if (NULL =3D=3D StaAddr)
+=09if (StaAddr =3D=3D NULL)
 =09=09return;
 =09psta =3D rtw_get_stainfo(&padapter->stapriv, StaAddr);
 =09DBG_871X("%s(): StaAddr: %02x %02x %02x %02x %02x %02x\n",
--=20
2.20.1


