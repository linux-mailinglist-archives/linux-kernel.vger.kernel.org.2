Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF03575C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbhDGUT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:19:57 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:39270 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhDGUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:19:55 -0400
Date:   Wed, 07 Apr 2021 20:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1617826783;
        bh=N5u/5mpF1KkCivfiF1HXZz0czS+7PjkwEteSFk6MDk8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=gU7WZgA1UTEqFhyu2Heyhxfn4IW/ho79aa31slYOMjUsvblRtxvjLYQCnmKVtZ7dR
         BgBMT6DpyXw9za/S4HIcWfISTsgPyMSBd3fo6PvFGQKUWG8GWNV3PH1ZYYjRK1a0zj
         R1wm8xGazcj+yJBSB5hYUgudcevkjn0HO/M9jKHb24YTXyQe1PY9IzavUItizR17is
         Djc8R5e/rHlTzbjiBdfPfZjG9W8nN/HbSH7UBHMxGRA5kM78Esq4N56nfmcGoOj649
         Xy6Llor4mx+BhqR4X6ByavLpAwGsyjgQ0tcqtTqDo9jwc4ME1JW9uc9ZznnANwqUal
         GFxQiQppXB1uQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove extra indent
Message-ID: <20210407201842.80074-1-hello@bryanbrattlof.com>
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

There is an extra tab in the conditional statement. This removes it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8=
723bs/core/rtw_ap.c
index bee4f83a6db7..c64d7b2fba0c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1098,7 +1098,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u=
8 *pbuf,  int len)
 =09=09}
=20
 =09=09if ((p =3D=3D NULL) || (ie_len =3D=3D 0))
-=09=09=09=09break;
+=09=09=09break;
 =09}
=20
 =09/* wmm */
--=20
2.27.0


