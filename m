Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8BB30B39C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBAXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBAXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:33:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:32:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s18so21808784ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGoePu8SYK3dsFlNBtrK6/AyOhXZmXpZea5crVNJ3MI=;
        b=QOoU0+kAmzZhAWWJ9J00tUV1Woi1oqN+EdIw0tzfNyrlXrUsWqV9BwLZMTUeO9Ahbn
         jDe2vFWKBGo3T4xiJWeOMS3fxq+aK2D0qZBP/gJKWPwfOpuQ2cBgpwxIrSvXy9n2Hgc/
         WlNddZPZ6EkMZptZcKl3f7qV6LOCBi7CRbyo6RBfGhqYc/AqhVra37YMFH2paHFmxa6Q
         8vgmhnAAC3faxenfHtCnAuAg8mR/u74QDHVOG65Va7mla5HcNo+ikb1xQl7tNd/AAFJK
         e7jAYv47zTIpchbuRvxmAryvZw/wSjdf6HU4C5FE369h5Ro0OSebkFMUcvVUe+jMc0VL
         GfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGoePu8SYK3dsFlNBtrK6/AyOhXZmXpZea5crVNJ3MI=;
        b=sPUplT6/KdthMmjSC1RYEE/LXwZr0gpFm4FJYM50K+eD+G0jYE5Sq5+jY3we/n5a9o
         X1uD9f86NMO2oxYpcC1Vy8O52LhYrcwM8AIaHTvYeLSFsKxtu3d5Us7nnqN5g2o3Gb6I
         ba3Whs46w3PhOleXBVba/cH6eqKPC3yt1j8clxznJNIjoltvjtOORnsoqRRV35Kuyaya
         yGEa/ZDFG6JGjanqo7r3lKocthGYP1i/vT2dTHhOjK9Q4OG3mOTFQjCwWEK7z3jsVFK0
         MO+ZRvxThD0EUr4Ch5htnI/bXoBannswBbtHuIx6DGoE7t7reA1bcAIodfJfrFxhdhrE
         345w==
X-Gm-Message-State: AOAM532t9Pb+LZi99/30GynGkkTnKRmqqtOOKPZjNWMdB4ZWEGvh3UkV
        6s1pykv8P/pDnnyhVENmgtk=
X-Google-Smtp-Source: ABdhPJxiRU5zVO1A4PuxhEA0piBhwx4/MZhcNGC4m4QjNFIy6m8/3U6lEvMR2ArUKALXT28J/XwImA==
X-Received: by 2002:a05:651c:1301:: with SMTP id u1mr11426780lja.463.1612222377595;
        Mon, 01 Feb 2021 15:32:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id q13sm3108633lfk.307.2021.02.01.15.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:32:56 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] mm/swap_state: Constify static struct attribute_group
Date:   Tue,  2 Feb 2021 00:32:54 +0100
Message-Id: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of swap_attr_group is to pass its address to
sysfs_create_group() which takes a pointer to const attribute_group.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index d0d417efeecc..3cdee7b11da9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -901,7 +901,7 @@ static struct attribute *swap_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group swap_attr_group = {
+static const struct attribute_group swap_attr_group = {
 	.attrs = swap_attrs,
 };
 
-- 
2.30.0

