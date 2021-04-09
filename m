Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC635A7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhDIUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:13:32 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:11681 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhDIUNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:13:31 -0400
Date:   Fri, 09 Apr 2021 20:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1617999196;
        bh=EqzbmR+DJhqb9z9zKSGWyGT6bMFjSUyRnTL5U0wQp9E=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=EvtnezQZaulaWFJFWk6fCh3jklQ8Gbz7xTns7P5j1XDm5MXZf2it1XFBvFprcUEAB
         NyHRsa/486AHbrzLBlU9bHfYmNwG3w6VXl0qp2+BtzhWeNa8b/wqI5FyqHxNEbdCOo
         0A+a5e3hElFrUbBoLFzjDn0fPg2qTOexB2pd5MS+SqiJx78ON2dRJhB9akW1SjwDuX
         /OYHmfahUKE3wPcFm0p8brzN8vRZNFtZHOyVoL5tJlu5W/d6L5izNWkPBKP6T5/YAj
         D/EKjHFBgHUNCkPOxnDetQadoC5L2lE5BeoI3Xm4HU4QMAv+reiUBatnJb0n10TH6X
         EN6juZP+jb4YQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove redundant initialization
Message-ID: <20210409201235.407671-1-hello@bryanbrattlof.com>
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

The variable ret is being initialized as 0 and is never used until
it's updated by sdio_register_driver()

This removes the redundant initialization of ret

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index 5de4c70aab6a..9fd926e1698f 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -503,7 +503,7 @@ static int rtw_sdio_resume(struct device *dev)
=20
 static int __init rtw_drv_entry(void)
 {
-=09int ret =3D 0;
+=09int ret;
=20
 =09DBG_871X_LEVEL(_drv_always_, "module init start\n");
 =09dump_drv_version(RTW_DBGDUMP);
--=20
2.27.0


