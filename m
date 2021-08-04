Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16AF3E03C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhHDO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:58:52 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42936 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:58:50 -0400
Date:   Wed, 04 Aug 2021 14:57:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1628089083;
        bh=Uxwz3jXRe7LOguIMwMuWtaEHnBl60v6KEdbcFAjb0Vw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=JZdqBTXFEr+E0i8+mJSx6VAiWbpKgMwKvDBH5f6Dq0Ca7C4GtqZXLQyiaVjWYwApY
         UcbTnfcvfbU2WQ8nL0fb6dVoggWiZjZapmKDSUaucyuOj1R29SNk+vhJuAoPkrSCgs
         XmV1CZ1+ZFhTFACCwUoTJXMQC1dtVwOMg4B3YuWPGHdBL6DsK4akB3HCZfkFNzsybo
         oVsO69ZFandu2opM+FdMuxSnScek3wSpkUQP6qqfPeymhtoZiUa0FJY2pwqafXwTDY
         dT0cxmxfMUD1MuD1gc2CWpa+JLMYFsZ/yC11TPR3t/QFAU0qtvA9b1OkVWDfIxl+g1
         r38TCnjxOGxcQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove unused BT structures
Message-ID: <20210804144812.715695-1-hello@bryanbrattlof.com>
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

remove static BT debugging structures no longer in use.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 6 ------
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/stag=
ing/rtl8723bs/hal/HalBtc8723b1Ant.c
index 242c14959176..b3d7f50fac4c 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -13,12 +13,6 @@ static struct coex_dm_8723b_1ant *pCoexDm =3D &GLCoexDm8=
723b1Ant;
 static struct coex_sta_8723b_1ant GLCoexSta8723b1Ant;
 static struct coex_sta_8723b_1ant *pCoexSta =3D &GLCoexSta8723b1Ant;

-static const char *const GLBtInfoSrc8723b1Ant[] =3D {
-=09"BT Info[wifi fw]",
-=09"BT Info[bt rsp]",
-=09"BT Info[bt auto report]",
-};
-
 /*  local function proto type if needed */
 /*  local function start with halbtc8723b1ant_ */
 static u8 halbtc8723b1ant_BtRssiState(
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/stag=
ing/rtl8723bs/hal/HalBtc8723b2Ant.c
index 3e36a7dc72a6..c1c7b5cc17a7 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -20,12 +20,6 @@ static struct coex_dm_8723b_2ant *pCoexDm =3D &GLCoexDm8=
723b2Ant;
 static struct coex_sta_8723b_2ant GLCoexSta8723b2Ant;
 static struct coex_sta_8723b_2ant *pCoexSta =3D &GLCoexSta8723b2Ant;

-static const char *const GLBtInfoSrc8723b2Ant[] =3D {
-=09"BT Info[wifi fw]",
-=09"BT Info[bt rsp]",
-=09"BT Info[bt auto report]",
-};
-
 /*  local function start with halbtc8723b2ant_ */
 static u8 halbtc8723b2ant_BtRssiState(
 =09u8 levelNum, u8 rssiThresh, u8 rssiThresh1
--
2.30.2


