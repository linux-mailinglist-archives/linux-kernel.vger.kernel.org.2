Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6704A35ADAC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhDJNde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:33:34 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:51468 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhDJNdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:33:33 -0400
Date:   Sat, 10 Apr 2021 13:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1618061597;
        bh=FCOivwZmKcFsZJuUtmm6XCPlM3OwmFa87q/PxS8jP0I=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=jPqE+zQN6gwQJWXrOp1ifnqqBO+aAVKiyO31SWDKtpJHgcShdbX+WezfD6IGJ4u/r
         mO7bIcH94FgAD94wB+G3P7OZ6SFGgQygjr0JgjDxp5gTx/sUBB5j8S4Ii1mG3eY5im
         QUMWGdMKQ/m0oQA2S0M3eoAxcZQJkPdSUBp3LmVSqlL2b3s2ara8c8QjLy/3cLoN+Y
         yccQK6y2TQ4sUQsS6NjfXXKLjvYTnTgfAfpKrzIBE5eDQr11kHSkUpG15SwaLtHpn3
         fWE9dYxpDg/P/wRX5h91M26/kXv4nbahQYOLFJ4Q3JhMjwlEAQLObkTh0c1TaCBNmh
         LPosP65SpcNzg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove unnecessary goto jumps
Message-ID: <20210410133212.422929-1-hello@bryanbrattlof.com>
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

The next instruction for both 'goto exit' jump statements is to
execute the exit jump instructions regardless. We can safely
remove all jump statements from __init rtw_drv_entry()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index 9fd926e1698f..84ac81d19746 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -517,13 +517,9 @@ static int __init rtw_drv_entry(void)
 =09if (ret !=3D 0) {
 =09=09sdio_drvpriv.drv_registered =3D false;
 =09=09rtw_ndev_notifier_unregister();
-=09=09goto exit;
 =09}
=20
-=09goto exit;
-
-exit:
-=09DBG_871X_LEVEL(_drv_always_, "module init ret =3D%d\n", ret);
+=09DBG_870X_LEVEL(_drv_always_, "module init ret =3D%d\n", ret);
 =09return ret;
 }
=20
--=20
2.27.0


