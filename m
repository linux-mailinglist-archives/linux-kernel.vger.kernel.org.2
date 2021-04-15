Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01DA360570
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhDOJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:16:50 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:55960 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhDOJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1618478180; x=1621070180;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tte0Rh052e0z9AFEgquZJNa0elDAoXdTbOtgA+HK81k=;
        b=DXKmbmG9nTQedVnP38rToqDTcUDAYTwZdrwp3+LZ8VJ9YN8fKVvJtdZPbzlVdGae
        2p6gQe4sperhFXRSIS6IwIhlG2o7IFgBnU/rQcwtKEX1B1Rmgfseq7qTy+d+2XEI
        j5pIXNK3uiDcSqaz2uWscCuIs8o/DWc/AeLgR7SyPA4=;
X-AuditID: c39127d2-324b870000001c53-3f-607804649830
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1E.53.07251.46408706; Thu, 15 Apr 2021 11:16:20 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021041511162033-136034 ;
          Thu, 15 Apr 2021 11:16:20 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 2/3] drm/panel: Add connector_type for some EDT displays
Date:   Thu, 15 Apr 2021 11:16:15 +0200
Message-Id: <20210415091616.53415-2-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415091616.53415-1-s.riedmueller@phytec.de>
References: <20210415091616.53415-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.04.2021 11:16:20,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.04.2021 11:16:20
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWyRoCBSzeFpSLB4OYfdYvecyeZLP5vm8hs
        ceXrezaLy7vmsFms+LmV0eLnrnksDmwee78tYPHYOesuu8f2bw9YPe53H2fyWDLtKpvH501y
        AWxRXDYpqTmZZalF+nYJXBlLZpxiKTjLWbHwzTv2BsZpHF2MnBwSAiYS11YvZupi5OIQEtjG
        KPH6/F9mCOcao0RHy0pGkCo2ASOJBdMawapEBCYwSky7+5UJJMEskC8xt/cFM4gtLOAhMXnW
        NnYQm0VAVWLSwYlsIDavgI3E0tcTGCHWyUvMvPQdrIZTwFai7c1asLgQUM2/iXuZIeoFJU7O
        fMICskxC4AqjxJt9b6CahSROLz7LDLFYW2LZwtfMExgFZiHpmYUktYCRaRWjUG5mcnZqUWa2
        XkFGZUlqsl5K6iZGYDAfnqh+aQdj3xyPQ4xMHIyHGCU4mJVEeN2mlCQI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES593AWxImJJCeWJKanZpakFoEk2Xi4JRqYFyVNft8de9Hrqq5B64I3HVmUpi6
        9fQJcbZ3bv8/yt1mVmyb+WTHqmWGGi7nZz14c9eaxT2+pDI2Ia3ulPgt26nbpnrPunNyB3vh
        NO1cqxcpO/ZncSzZ/imz4OK+vA/f2i+aOqya1arY1faS0WyfXKn6mvf1inFzZqovdLq1+bgL
        q8GRWUwnelyVWIozEg21mIuKEwHGHdKHVAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The connector=5Ftype for following two EDT displays is missing:
 - EDT ETM0430G0DH6
 - EDT ETM0700G0BDH6

Both are parallel displays thus add the corresponding connector=5Ftype.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index 44583d0ed902..723c09a82c4c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1900,6 +1900,7 @@ static const struct panel=5Fdesc edt=5Fetm0430g0dh6 =
=3D {
 		.width =3D 95,
 		.height =3D 54,
 	},
+	.connector=5Ftype =3D DRM=5FMODE=5FCONNECTOR=5FDPI,
 };
=20
 static const struct drm=5Fdisplay=5Fmode edt=5Fet057090dhu=5Fmode =3D {
@@ -1964,6 +1965,7 @@ static const struct panel=5Fdesc edt=5Fetm0700g0bdh6 =
=3D {
 	},
 	.bus=5Fformat =3D MEDIA=5FBUS=5FFMT=5FRGB666=5F1X18,
 	.bus=5Fflags =3D DRM=5FBUS=5FFLAG=5FDE=5FHIGH | DRM=5FBUS=5FFLAG=5FPIXDAT=
A=5FDRIVE=5FPOSEDGE,
+	.connector=5Ftype =3D DRM=5FMODE=5FCONNECTOR=5FDPI,
 };
=20
 static const struct display=5Ftiming evervision=5Fvgg804821=5Ftiming =3D {
--=20
2.25.1

