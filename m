Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88974092BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbhIMOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:15:17 -0400
Received: from mail-4317.protonmail.ch ([185.70.43.17]:61191 "EHLO
        mail-4317.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbhIMOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:11:42 -0400
Date:   Mon, 13 Sep 2021 14:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1631542223;
        bh=oss/E+70MRl03TJMdN6Zz+nYBuwtt0h53qYO3R5VcFY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=F3Mnwnp8wndAEJvgLSGbhDOzblYKVeMkvV/pCXEpTJo5WleYqSo4yJsb+mFXfmOGw
         f3fkWSrMlfKY7cOo26q4NXQl08bt6IEX2IkbL8zYmHkHZalH9BVAcIqnvjboNr9nxr
         LWBVnMbSBiN3su8fAT2vSUeEKG09SepOk1sWfmISN4b+7s99ngBpkCLJ92LhkeZluD
         4AcW7caR2mShxoDU7y4TUMGLZmxBqPyAdBu/LHMRFuNLs3GWx5X6bx4SlJNfYaxs8d
         qF4CJ0PP/DructOuu3Ur96oCShgaUl5MyvzS44Izxj0/6te9UZEtwTnFZF6rTiePHX
         rD5x+Bu5gwunw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: define wowlan_stub only when CONFIG_PM is enabled
Message-ID: <20210913140937.1490133-1-hello@bryanbrattlof.com>
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

The wake-on-lan stub is needed only when the device power management
functionality is enabled in the kernel. Conditionally define
wowlan_stub to avoid potential unused object warnings.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/st=
aging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 34da8a569709..f4a9b4b7c97e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -47,6 +47,7 @@ static const u32 rtw_cipher_suites[] =3D {
  * Moreover wowlan has to be enabled via a the nl80211_set_wowlan callback=
.
  * (from user space, e.g. iw phy0 wowlan enable)
  */
+#if defined(CONFIG_PM)
 static const struct wiphy_wowlan_support wowlan_stub =3D {
 =09.flags =3D WIPHY_WOWLAN_ANY,
 =09.n_patterns =3D 0,
@@ -54,6 +55,7 @@ static const struct wiphy_wowlan_support wowlan_stub =3D =
{
 =09.pattern_min_len =3D 0,
 =09.max_pkt_offset =3D 0,
 };
+#endif

 static struct ieee80211_rate rtw_rates[] =3D {
 =09RATETAB_ENT(10,  0x1,   0),
--
2.30.2


