Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4863C3B50
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhGKJZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 05:25:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:43091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhGKJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 05:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625995333;
        bh=WENbbXKHypPbtLkNhlny7Y9SGiMZm5hTSJ7Ipm0gl4w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=d4hCcG9Sa4pJzCJ2sdiW/9T+2W9joSFboPTlA/S+n9x1esx87qImekD0JOjbOs84B
         TdUJ9i6iwJvxeEa+J6TbpZUuzG1Bk+ihyzqqxAPYvqfa42iNz7kPxz5BLmguyAh+L2
         kzVpKYWn7UE4h+ArDWDPn8Xz2BoArUQmyw3Zy+Ak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MpUYu-1lNcU43ckO-00pss9; Sun, 11 Jul 2021 11:22:13 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Len Baker <len.baker@gmx.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        "AMD\ramini" <Reza.Amini@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aric Cyr <aric.cyr@amd.com>, Felipe <Felipe.Clark@amd.com>,
        "Max.Tseng" <Max.Tseng@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix identical code for different branches
Date:   Sun, 11 Jul 2021 11:21:47 +0200
Message-Id: <20210711092147.17689-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/IuBeSovGxms/bS/ManJQVFm2qckWcH9aApxRuNJWFP4LR8z71f
 WqdnptBTNgqgIQLGkKmxGqt4Rs/4rfpdbw4L96o5BE7cYpEi+Arrkw/q7+AGj0QuTyfkoIu
 vuLo9NM6DrL36g8Mj0RVcrdjJj5JgBRpafLqxaDZVrXHx+8+77dBdZbNB5Te7EqbKvKaKuj
 XQ3uwQefHQ8U+xPBXZxDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:27N+sIFYS10=:04DDPkQ0NmrLbqTyHnHIuL
 2IJld4kYpTpObc1hu40Qh4OZYwQ+dQh+M2rRzhB3v4JMktlw+VVDsYuGMaUKuudPshC1u/kWn
 jwdPrN1SxFnVGik3FOWY4wWfuJE1hs5ZUWYc+Uw6tGTXYlsxR6BuAKi+LL04w7VmOWZlRvIyN
 NMI8N6CFi7jpa+o2KsonCdEcWiuD6mmvL6nb074OYofjrGaYbmwJx8o3CScjwDIyKX+jn97A7
 /ltW/xLRiiwFdtnCgnXdEGvrKsIJ372HdPHvQeq6tK7rf0MDmB6HMHk+mk0CpigsiOqCZo7qm
 LnULHVGlxeWpBihAa81FgFfpY7UkrdQWnTOux2Yd0fTsXNk6pj4mN4eBNE0Cs2pcvtaUPs1xa
 rBIt1LK2puPVIoFq+tqg5uMJFmuQ5H2cmt+gQ7gZAkFtDYJQgM1njBwWf9q4wwJgPHbsGFBbw
 PfoVpXl6XBMEiA6oqJL3QqECkDF4xs074lC1y8ZZuuwya8srJYARjB8o4rn1eR8Div0jP2QgT
 00SbLuY0Y6RwrH39tRNj3QUS25WxIP+0Rt6mMMHD2xU77qBMGY69bbe5vQfvffl3092Lmu+5T
 cYpgtXIbrKLOldu0ZBZi/MWKotamRSRlKRyLDH05V9n5knbaFBs7TvZ1UC8vYn4o1DG8F8tro
 DW3huPoT0KhubTa1QzjC/g3xAUQICKh2rxTJrkShsauyPawB5ZYrg/eCndLhr0tKHyDttbzMe
 9eY+Ma07vvfKUWD/DBiQTNtCipxPcofVQ135/pniEleK5AqWFoDy+2DLiVg+2NiMvcfo7cd4k
 i3f6DdFgsR+nV8EecJt7Tx9hSGB3IAzjIlxDyiJ3EYfFY1XuAwByPeX48P6zb0gP8tbQ2+BUs
 qEw70MZyG64ITev4owMwmcW0QQYPLFkwhVbwORQ73DwBk/q1NfMeB+l8eE0NeP6GaiH524yRT
 tCJK+rEvE3GEdQ4//SOcBYGidKfcmAuhQSNzny0TF15Nzzj0pElcMnUSpuZje3Pby06bH25DZ
 LwYbKJ1lMlhaPbJkbquwKANtQDPCEAHzhU9tVqUMEcUjA0jI+UwcOz4Yg+PYP/XuR1B13YC1G
 kWv6iVId9HSHxXA2bN26UtRLhZMCYJqJAvl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ternary expression:

vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABLE ? max_refresh :	max_refresh;

has identical then and else expressions. So, simplify the code.

Addresses-Coverity-ID: 1471122 ("Identical code for different branches")
Fixes: 9bc4162665827 ("drm/amd/display: Implement VSIF V3 extended refresh=
 rate feature")
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/dri=
vers/gpu/drm/amd/display/modules/freesync/freesync.c
index 3f4f44b44e6a..54374c7d309b 100644
=2D-- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -613,9 +613,8 @@ static void build_vrr_infopacket_data_v3(const struct =
mod_vrr_params *vrr,
 			(vrr->state =3D=3D VRR_STATE_INACTIVE) ? min_refresh :
 			max_refresh; // Non-fs case, program nominal range

-	max_programmed =3D (vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED) ? fixed_re=
fresh :
-			(vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABLE) ? max_refresh :
-			max_refresh;// Non-fs case, program nominal range
+	max_programmed =3D (vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED) ?
+		fixed_refresh : max_refresh;

 	/* PB7 =3D FreeSync Minimum refresh rate (Hz) */
 	infopacket->sb[7] =3D min_programmed & 0xFF;
=2D-
2.25.1

