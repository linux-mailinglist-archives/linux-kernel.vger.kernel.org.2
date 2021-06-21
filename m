Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13BC3AEC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:11:50 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62570 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1624288171; x=1626880171;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OU7kfza9aIdJQlYUII4Qo+cg2Fm8sVxRR++Rp+/eQcU=;
        b=f5bCdZdU2z6TKLghami4YuTH41ZLmgsG+JoeP9YSCvpXzpK/EK1wgGl/NjW/CYf1
        0KdLuJ+93tGWMbuXYBmY5AgBBTtaUrKwJThljbGjDlCeOUQm1FwYuyDNbLH9OKKI
        FDM5/s2z5ePxYViGmQeg0BndNdQYt0H0qFAvM6bh/f4=;
X-AuditID: c39127d2-a9fbd70000001c5e-ab-60d0abababce
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 36.77.07262.BABA0D06; Mon, 21 Jun 2021 17:09:31 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021062117093143-1007634 ;
          Mon, 21 Jun 2021 17:09:31 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RESEND PATCH 3/3] drm/panel: Add bus_format and bus_flags for EDT ETM0430G0DH6
Date:   Mon, 21 Jun 2021 17:09:30 +0200
Message-Id: <20210621150930.86617-3-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621150930.86617-1-s.riedmueller@phytec.de>
References: <20210621150930.86617-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 21.06.2021 17:09:31,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 21.06.2021 17:09:31
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWyRoCBS3f16gsJBsuf61r0njvJZPF/20Rm
        iytf37NZdE5cwm5xedccNosVP7cyWvzcNY/Fgd1j77cFLB47Z91l95jdMZPVY/u3B6we97uP
        M3ksmXaVzePzJrkA9igum5TUnMyy1CJ9uwSujJ4dkQXb2SoeNCg0MB5m7WLk5JAQMJHYOmES
        YxcjF4eQwDZGiak71jJBONcZJa786mcDqWITMJJYMK0RLCEiMIFRovHAbCaQBLNAuUT70lNg
        trBAhMTqJ0vBbBYBVYmlvW0sXYwcHLwCNhI3eu0htslLzLz0nR3E5hSwlXj7dCeYLQRUMm3h
        D7BWXgFBiZMzn7CA7JIQuMIo8fbmeWaIZiGJ04vPMkPs1ZZYtvA18wRGgVlIemYhSS1gZFrF
        KJSbmZydWpSZrVeQUVmSmqyXkrqJERjahyeqX9rB2DfH4xAjEwfjIUYJDmYlEd6bKRcShHhT
        EiurUovy44tKc1KLDzFKc7AoifNu4C0JExJITyxJzU5NLUgtgskycXBKNTDG/4so9Z74yiDW
        IaxRSbHRPXnVs2yNwFVv9iYtPOm+52Cq9ZyNi9Y6Fkq1ruu7euXX20UznNvfRHx+qN/sM2OJ
        z97ir2utr026VbC6V9BBylP/7Mdalgc3SoI+S8/4yPhV17aSfeLN2buvfjg6Z3pK/vXTaQa3
        172s4/sk+P/wb+mM92siVn7zV2Ipzkg01GIuKk4EALVYWwRbAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add corresponding bus=5Fformat and bus=5Fflags for the EDT ETM0430G0DH6
display.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index 109dc8c85947..34a24cd6f2c8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1940,6 +1940,8 @@ static const struct panel=5Fdesc edt=5Fetm0430g0dh6 =
=3D {
 		.width =3D 95,
 		.height =3D 54,
 	},
+	.bus=5Fformat =3D MEDIA=5FBUS=5FFMT=5FRGB666=5F1X18,
+	.bus=5Fflags =3D DRM=5FBUS=5FFLAG=5FDE=5FHIGH | DRM=5FBUS=5FFLAG=5FPIXDAT=
A=5FSAMPLE=5FPOSEDGE,
 	.connector=5Ftype =3D DRM=5FMODE=5FCONNECTOR=5FDPI,
 };
=20
--=20
2.25.1

