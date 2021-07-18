Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F265A3CC8C2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhGRLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 07:35:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:53757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhGRLfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 07:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626607941;
        bh=LA49RbtvFLlDFLYkYUJ7wqBn32o6JA4TKOxnCiR8riU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IAKSAeYIZzeXzWstR3EfVZWhw6zooTgiSU9m0+sNX8mzlZb9qHpjtK5AALuo8ntSa
         jIlXNEdR2Y+dyB1/ky8+Euv4WfJ02jlDyhek9l96o5lxmHjFXYFyC3n7jmaaK1MsG4
         26BRJYRGxl9GG+luMbiyCOnUvQbFuPebdvfMaIX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MVN6t-1leW0I0EwZ-00SR95; Sun, 18 Jul 2021 13:32:21 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Lee Jones <lee.jones@linaro.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Dmitrii Wolf <dev.dragon@bk.ru>,
        Iain Craig <coldcity@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8192u: Remove all strcpy() uses in favor of strscpy()
Date:   Sun, 18 Jul 2021 13:32:07 +0200
Message-Id: <20210718113207.10045-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dBu3Bugp12qVQZxAg91AEm7ns7kPEURACegd5+ybpLZTG5IEete
 1hFixhvOFQbOuaUw6Sugs3ePMYwswpVgXY3J2Vq3qQixiDbGKTlk6tuxMvzRpfBmu6lNxva
 /M+/jHjl+kA3Lx7EbQgFDy8PPz+04nRmmdRZmctJjLbOWvXO3Uux0vLYRuI6AGKC2hnEKg6
 CQyXXPLPyzSBEExUp1NFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1yA/OMqDmt8=:hi9aDlDkPdyH1IELgu0gO1
 YC4XGCi+SEN9yOsPaVC3mmHBBK9YALdsf7+qXoa5/kD9mjDRakj/bC6j0jGdwSdYwdYI9O33e
 v87UnkynYZP7bdq9ZnzyiObVogRuOeS12BuwyvveNsF69cDK0Ans8d+ZwchjnXXBR8r12utdt
 /a14X+xmWxK7pTMo2iswVAPKSD64f8MRdpu6dGtQbFxoMVEtdlXoYw/Pq/qxfT7opFi5VP6zi
 2Sk6EhIn5ffXNEL7zp7EodU1JVdw9B5gYlCDLGKarloe3st79nyzLUbJji2yIgFvXxb0c8vyL
 7DevtH4MUiEGnmsUnqmiWAMveGYIjqEfYgljOkcw2kIA9eKhJwFnLM5AEnWl81ValnDhE4Gl3
 /fLRd61Puf+h+u9bck4aFeOlF9YibQHnyczFgoxu+QO/gsbwWZvThH8cdYzBUtP2HQNSa0Xxa
 N6MXRWZr6xP7KYFoeGDFbifx/90t1pwrH/tCXCk2QjePyQ1F4y6Yhi7JEN5cj80CthqrBAsht
 vi590xX7Uz/P026tIJ41dmHXbiSynjuUYd00iXSDHUu3GVf0wAlCqPsshiXwisZeZTCOoCBBT
 Y8x85bWx3L7g9l58P1BbC2IW6jVmR/f38TGCrExgC+Nd7C4BtI4IJzvyHCCVTiemPTpaP4e4+
 ku+y4qDjRyn5JC1Kj3SpqVOseDhtgL/JAz5WGRLr8fVpsTdpg6O1UhyAhFl5ykv+WgZn9iVxV
 N5fIz7pK0DQhnvZjr8ODeEFqhPhEg3+IgVXNSCHCLUeZ69ZnZrhJXjSu0G4bHIskGzMOwU/x8
 zLniHdvIje2fJZbS+C3X9a3We4gkGHc0OQ3AmxvotnXn61USXf/u1woD/dq/AJcJNXU7xFg4c
 S5DA4Wo+wnftnSeLmY+yWcJNRwrRwCzSVDWYT1Y+UqqDQwZXYLbmDivf2X3+RhK9mEb4GSj2V
 aj5Ef+DmYMxw4lDkXMi+PMHmMz4Y8W5JoeoM9m3UGKCxe3kIit82Bo1oE/GdrVeDRZT8MQvrf
 DwTsMsR4d/mia76xXdp3mRsy/O4zvTzlaj7i0cQUcAlpVAACwoOABWco8xaVIm1RD7Md2Gqyq
 1gfa/N4D3TO5B7EHADjnvgtAaacH1anxvXl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/driv=
ers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index ab885353f668..1a193f900779 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2226,7 +2226,8 @@ static void ieee80211_start_ibss_wq(struct work_stru=
ct *work)
 	mutex_lock(&ieee->wx_mutex);

 	if (ieee->current_network.ssid_len =3D=3D 0) {
-		strcpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID);
+		strscpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID,
+			sizeof(ieee->current_network.ssid));
 		ieee->current_network.ssid_len =3D strlen(IEEE80211_DEFAULT_TX_ESSID);
 		ieee->ssid_set =3D 1;
 	}
=2D-
2.25.1

