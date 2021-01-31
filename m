Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED7309C98
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhAaOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhAaMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:51:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15698C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:50:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so19957452ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eHyxcdRkq1cYMti9nVUicUhH69aVVf5LQFGWJ0sd/ls=;
        b=lnj5kA0/kXNleiS2dTLwg9KK/txJOAaYmpDc/vU1TcrwjlZNBiyI3Hq+rEmmXS/iSf
         /Ydg9TW/k4H6HLxZANFnANadjXqaoJX7uWTLl/4e4OZyMO5woc5E+fwDQtPiFFs+lLno
         020mUWdn5g3nETAzG/jRKn/hhei3fwx5s4zvEOseSlsRsKUMGY1o4EMmUqgNu6eG0ZG/
         ygEVc1IKJzNuBw0HJLROF5huPz5pceZoQxMIwi9bDtmNYNrbt1Uqa52Z7EOSbLRqrtR0
         W3lItFYMhULm9dPnIu8D+jjbtCuhlavYaBQH5tD/UlRJFX0rAxS4MyjtEeeQ+c35OI5g
         4QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eHyxcdRkq1cYMti9nVUicUhH69aVVf5LQFGWJ0sd/ls=;
        b=tmUcmBKB47EG/fI5+USrSBkjlrxIh8erXdfVBNoTv8jVP8jVt4QZLWEq7+LOJ13rBY
         ufKTngo7obtJ5hR0ZKw9nMBvW702zv8vMpmyIwb7pAbN1iUIzfFGEB5YmBrNmJJdp7Lg
         iPAGWfYG2hvQ2lM19yEnLlg71+uG/aScJn6m2g+pq+o1oEJJC7RRIAI3mUQgPvF+DaO8
         lI/BiawSimf+44UdTV+hzQvZNh/8QSuycN94ua5pTdG1cog2nVcmVQz0zlWxtKjPwWUB
         nDIfTGrf/yjCdRrzSZGYMZIWL7Jo1jFaCCrnn9GKpfEIwLmhHoUkOMfWAi0eBGZPSikQ
         vI5w==
X-Gm-Message-State: AOAM532Cz+cDOd4CHbvToMD2C7Tw25Sihzq6CCDmWPqdc7rulunoEGLG
        Gye6V/6J1p6PJWVsimI2igw=
X-Google-Smtp-Source: ABdhPJzwvktPNgAiUqWHn6Vhx5flBjZAJHGe74jXpTZzOk80auNUnuuIRMzLHiftM9290UwaUG+snw==
X-Received: by 2002:a17:906:2e0d:: with SMTP id n13mr12820275eji.554.1612097423877;
        Sun, 31 Jan 2021 04:50:23 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j18sm1317753edj.36.2021.01.31.04.50.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 04:50:23 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop_reg: add PX30 version info
Date:   Sun, 31 Jan 2021 13:50:16 +0100
Message-Id: <20210131125016.10837-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce memory various Rockchip VOP versions share
common reg structures. However more recent added SoCs not
always have to same futures as the old ones.
Add PX30 missing version info, so all VOP version checks
work correct if needed in the future.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 80053d91a..0697057e7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -312,6 +312,7 @@ static const struct vop_win_data px30_vop_big_win_data[] = {
 };
 
 static const struct vop_data px30_vop_big = {
+	.version = VOP_VERSION(2, 6),
 	.intr = &px30_intr,
 	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
@@ -327,6 +328,7 @@ static const struct vop_win_data px30_vop_lit_win_data[] = {
 };
 
 static const struct vop_data px30_vop_lit = {
+	.version = VOP_VERSION(2, 5),
 	.intr = &px30_intr,
 	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
-- 
2.11.0

