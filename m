Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BB3E03CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbhHDPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:01:35 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:23745 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhHDPBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:01:32 -0400
Date:   Wed, 04 Aug 2021 15:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1628089275;
        bh=Uxwz3jXRe7LOguIMwMuWtaEHnBl60v6KEdbcFAjb0Vw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=I5k+d4qR1w3jO8skGL8TN61R3kwXhfhc0z/d2binXyel9BZecYSfHOLH8nbV34NGd
         HEjx7sEnV/NHXAUTf0aHYholQuIK39Iqs4CKRVuiVnwJkr+fRPQvnjbD5Hh7gLLdYB
         ZMM5Fi5B2eK/TTLZPb0e8M+93xPC8jbozsHOOqujuD8a7O//eBo+OMlEQeWzZ6TeQ+
         I/Xuf1EcpL9wvr5tPdrUUBqF5rBihSJ1LyJ4j2/YjUK7Qf69NIT4IyuiYr0p4HBs6B
         jBqALspjjLV5bBUYi3wW9Ib9QVbWbz5g4+nCbB13PKyDGsB5kNENinkwsvasDkAx5o
         xeziI2AXvC3jA==
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


