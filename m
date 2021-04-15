Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBD36056F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhDOJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:16:48 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:55960 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhDOJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1618478179; x=1621070179;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=17z95mcBltXt7s41OWVSnVP4aCtle9ny46vxPgGBZIM=;
        b=JaYYmAq1r6Zem68a14XexEwGuVN+u7tppMXNZQi7KDtQInOlSlkhBzwDNPB6Id17
        AL8T+YTy9UzJQ4ONAaAJBvLzjGXA1mqDCoA637WjY05F+iWwCOQEE7QjjWySCfRw
        6CVjmzgLHCGVitHa+F69TT04vS3SX6aL87pbfmdIaUg=;
X-AuditID: c39127d2-324b870000001c53-3c-60780463c42e
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5D.53.07251.36408706; Thu, 15 Apr 2021 11:16:19 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021041511161871-136032 ;
          Thu, 15 Apr 2021 11:16:18 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 1/3] drm/panel: Add connector_type and bus_format for AUO G104SN02 V2 panel
Date:   Thu, 15 Apr 2021 11:16:14 +0200
Message-Id: <20210415091616.53415-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.04.2021 11:16:18,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.04.2021 11:16:19
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWyRoCBSzeZpSLBYNFjNovecyeZLP5vm8hs
        ceXrezaLy7vmsFms+LmV0eLnrnksDmwee78tYPHYOesuu8f2bw9YPe53H2fyWDLtKpvH501y
        AWxRXDYpqTmZZalF+nYJXBlnF2xjKrjLVtHW/pi9gfEOaxcjJ4eEgInE2f6/7F2MXBxCAtsY
        JZ7vvgjlXGOUWP74JCNIFZuAkcSCaY1MIAkRgQmMEtPufmUCSTAL5EvM7X3BDGILC0RLbL26
        A2wsi4CqxOoljWDNvAI2Ent7ZjFCrJOXmHnpOztEXFDi5MwnLCBDJQSuMEqs3nKSHaJISOL0
        4rPMEAu0JZYtfM08gZFvFpKeWUhSCxiZVjEK5WYmZ6cWZWbrFWRUlqQm66WkbmIEBufhieqX
        djD2zfE4xMjEwXiIUYKDWUmE121KSYIQb0piZVVqUX58UWlOavEhRmkOFiVx3g28JWFCAumJ
        JanZqakFqUUwWSYOTqkGxjDdjA+rm3qCbup+tipjmXbX1fyYeXpvTq6kX1u03bk/0duUJwlf
        3WZ1acLOGY+jEnhsW1+vXGSp8oBXSuy09WoP1ndOaxR3bw44wvJacHHaXEEBV/ciX5m9s6b8
        PN+hqBh4kzNk5furUvF7b99xjjlWuCzp09d7BT59gSv7582+GTexRHvPISWW4oxEQy3mouJE
        AJ27Ix08AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AUO G104SN02 V2 is an LVDS display which supports 6 and 8 bpc PSWG.
Add the corresponding connector type and 8 bpc as default bus=5Fformat.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index 4e2dad314c79..44583d0ed902 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1098,6 +1098,8 @@ static const struct panel=5Fdesc auo=5Fg104sn02 =3D {
 		.width =3D 211,
 		.height =3D 158,
 	},
+	.bus=5Fformat =3D MEDIA=5FBUS=5FFMT=5FRGB888=5F1X7X4=5FSPWG,
+	.connector=5Ftype =3D DRM=5FMODE=5FCONNECTOR=5FLVDS,
 };
=20
 static const struct drm=5Fdisplay=5Fmode auo=5Fg121ean01=5Fmode =3D {
--=20
2.25.1

