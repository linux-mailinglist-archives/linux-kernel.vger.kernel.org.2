Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8840EDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbhIPXVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:21:32 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:39093 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhIPXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:21:31 -0400
Date:   Thu, 16 Sep 2021 23:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1631834408;
        bh=btARelUQPT4cjrnEGxvCmdDj9feimw+Sy10otRGwtn4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=VswdL7y9sXYKOdMdAQ+8//jLNH7gNdL1rgX16+ZQ8s6d/B1c8x/LIi0WdSV0sXgNH
         9g/zsiTylQ8eEiQ8BcvetdzQpAilsEtYofEIwWbZ+N6GBtm1yUrAsJ9kEWogGZUYK0
         pxSA2JjWjBBZALniGXQJp49QFZViZJhNtRC81cQJ1d2Qie0fxxEHq1lPt0yGxwFElO
         DSwUG5QKGzKl/CpRMgAKU1SKVxVxJ+H60uXvLBfZO21mlaky/GUoHJK/ZwVHGGB4m+
         1khEnc151v1zV0LIihs2m0hO/N2+rTjZ8eZDIRGeCChc+J/KL60ImYi75kUThka6tc
         RPbfgpwYo86BA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2] staging: rtl8723bs: ignore unused wiphy_wowlan object warnings
Message-ID: <20210916231928.2021584-1-hello@bryanbrattlof.com>
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

The wake-on-wlan stub is unused when the device power management
functionality is disabled in the kernel, creating a warning when
building the driver.

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:50:42: warning: =E2=80=
=98wowlan_stub=E2=80=99 defined but not used [-Wunused-const-variable=3D]

Add the __maybe_unused annotation to silence this warning.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
Changes from v1:
 - Use the __maybe_unused annotation instead of #ifdef

 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/st=
aging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 34da8a569709..0868f56e2979 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -47,7 +47,7 @@ static const u32 rtw_cipher_suites[] =3D {
  * Moreover wowlan has to be enabled via a the nl80211_set_wowlan callback=
.
  * (from user space, e.g. iw phy0 wowlan enable)
  */
-static const struct wiphy_wowlan_support wowlan_stub =3D {
+static __maybe_unused const struct wiphy_wowlan_support wowlan_stub =3D {
 =09.flags =3D WIPHY_WOWLAN_ANY,
 =09.n_patterns =3D 0,
 =09.pattern_max_len =3D 0,
--
2.30.2


