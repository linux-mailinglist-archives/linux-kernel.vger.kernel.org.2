Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19032BE8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385805AbhCCRcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447356AbhCCNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB69C0698C3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e10so23496902wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWfSkLsOFqMqwFajDViY0GDy36kEao+sHnvIWX+OuUc=;
        b=mzLCVvzT8ZvO420Azr5mfjX30PlXUIrvbQHxMtN4US7RxeQlR04wUoXvV46MOWj67E
         TWBlNF4/fpmvc9jBPbo8VUcZihj5NbZNatn1o4r/fSJ+yH4/3bVrwGGDdLvQ3qZiVJh2
         SkXaBry/0wkXurG3AA4Ii8agUSDhJfuQLrC0Fijehb/xyKuNWqT2fuZGhON2EEEwzyNf
         saNBVVglJJvtHS4T1+IJlUj26Hbale91MzMi3i9Y3teiy9iiWr0/Slz1czb37udJnR/E
         7n7Q1YnI5xP0NRV/cB7DCp6C/uWjoNIIh7DO9fX7nE3KgwNNfcgC7mm34lRPE0XyViv4
         o1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWfSkLsOFqMqwFajDViY0GDy36kEao+sHnvIWX+OuUc=;
        b=G4KGK1Eanra5w63S+FewErk2b6bevOxk8jrYK2df2ejohUz4EyeAZVvyHWGecP2UzQ
         hpX3OjzymBIy4FPFaySzVYwvtmowWoOPV4xmB/Zq6yd6UDj7wkPGL0qdvfrE9wnULKw8
         WRCfk/ZOcvf83LWccpzhY5sMWRbbfZFng+e8a4rlTbcorrLn7GO7zJ25STgE9Gr/DFga
         3RD5Cj7mkeuaLrt7aYqqdVYjvxLmLcAWHYk9orHeHpO1GF5011lFcefgW1tWYKAt/G59
         y1q5wgETeN9uZ/6Ka1IzwlWsoyXw9p/Guhzl3088QCUeyiRqrk2YCKIfWbvNz6st+MsN
         nhaw==
X-Gm-Message-State: AOAM531wZPApvPhdnV3jjp3O4t1+wcmQcAqkEM00MTNojYSCPAepHdpv
        JuwZw+w+cVMH+2+PXT8v1/OuTw==
X-Google-Smtp-Source: ABdhPJxsWGUQqx0lYnqLB5s/MsxjPNI/91pZrxh/sj18e4bbCtcGtgCnCi4+SM9FZvcs2lKnc2i7PA==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr27793282wrx.243.1614779058227;
        Wed, 03 Mar 2021 05:44:18 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 42/53] drm/vmwgfx/vmwgfx_cmdbuf_res: Remove unused variable 'ret'
Date:   Wed,  3 Mar 2021 13:43:08 +0000
Message-Id: <20210303134319.3160762-43-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c: In function ‘vmw_cmdbuf_res_revert’:
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:162:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-40-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 92509fbf2fd1d..b262d61d839d5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -159,7 +159,6 @@ void vmw_cmdbuf_res_commit(struct list_head *list)
 void vmw_cmdbuf_res_revert(struct list_head *list)
 {
 	struct vmw_cmdbuf_res *entry, *next;
-	int ret;
 
 	list_for_each_entry_safe(entry, next, list, head) {
 		switch (entry->state) {
@@ -167,8 +166,7 @@ void vmw_cmdbuf_res_revert(struct list_head *list)
 			vmw_cmdbuf_res_free(entry->man, entry);
 			break;
 		case VMW_CMDBUF_RES_DEL:
-			ret = drm_ht_insert_item(&entry->man->resources,
-						 &entry->hash);
+			drm_ht_insert_item(&entry->man->resources, &entry->hash);
 			list_del(&entry->head);
 			list_add_tail(&entry->head, &entry->man->list);
 			entry->state = VMW_CMDBUF_RES_COMMITTED;
-- 
2.27.0

