Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3C42A5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhJLNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236917AbhJLNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634045620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MT+WGN85virsYnfaWkabBnlRhl4BVNJstj9q0qW4GvU=;
        b=WAkNm9RAMsl8kADHC/Ll7LYL9tWPVXZe5AUDQnY+ajQYiOmfNg7aFP2NQDUXI2l+dbMF8c
        JTNlePdols522arFbvuWgM4us9iHkre/Kq7tFBizanbuSIF+ESXsRfd6cOY6J79fowDyii
        MYrnJUoWwVKtA7WZfiR1zf8B9ZCCXHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-FiVAVNxRO56vw46IWMgbKw-1; Tue, 12 Oct 2021 09:33:38 -0400
X-MC-Unique: FiVAVNxRO56vw46IWMgbKw-1
Received: by mail-wr1-f70.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so15563387wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MT+WGN85virsYnfaWkabBnlRhl4BVNJstj9q0qW4GvU=;
        b=OoVFHkx5Rr0BTg0tgGREI4Wr2M4Bn5Be40vQkm1puk+t+dzFhoxyRhNN/wY1nECswj
         qESS8/MaAShs4wmyW9l0XsacdcL4/5aTm+tezLnTmv15wiYE86Z0erj440GXNJ3YUzjd
         RhqEDrJh0yGIh0VIJlVIaK6QsLXmle/p6psX+fHJYG4c9+0w05IQWa+QBV2BoMfpvjsB
         3hReFGh/5ijW0hI1A0VMgF1rTrk5LD82Nrn8nMh6GzX98AhgNMEEv1hw8ezymxzv4CNK
         Oqs8NVZzI6su18zfHqv6vb04ra1vSv3yY9KCkEUyk44kJZ+1aaPKs4/PP1+4Z3ZHumIH
         7eMw==
X-Gm-Message-State: AOAM532vMxv+7D2ciGGq7f+XrrZMkqSCoIricYSqqvqGO8C7IFhMOtbh
        9iGsewv5gMXXPN2uOGq2GR4rovrfpfuTHsFbcMr6WSCiNEwfWkUYQz1QXdo13Bo+s1Pd+Gfpp2w
        Ok8Nq0PYqK1EKRkCqyOqc2aVqFOYxgKf2dlB5FROhJ+oL3B0bLuY580M+oxwSM0JpnPpxmpGo7Q
        s=
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr5550816wmq.79.1634045616612;
        Tue, 12 Oct 2021 06:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhDxKhOlvfo/706pxslzpu1FHeBx94YPhwo2SnElkp9WJha5oN/R8hfR1LOXibQ33TMS0vwQ==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr5550783wmq.79.1634045616303;
        Tue, 12 Oct 2021 06:33:36 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id q204sm2656305wme.10.2021.10.12.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:33:35 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau/mmu/gp100: remove unused variable
Date:   Tue, 12 Oct 2021 15:33:34 +0200
Message-Id: <20211012133334.1737918-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a compilation issue introduced because I forgot to test with WERROR
enabled.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: DRI <dri-devel@lists.freedesktop.org>
Cc: nouveau@lists.freedesktop.org
Fixes: 404046cf4805 ("drm/nouveau/mmu/gp100-: drop unneeded assignment in the if condition.")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index 2b21f43069aa..17899fc95b2d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -488,7 +488,7 @@ gp100_vmm_fault_cancel(struct nvkm_vmm *vmm, void *argv, u32 argc)
 		struct gp100_vmm_fault_cancel_v0 v0;
 	} *args = argv;
 	int ret = -ENOSYS;
-	u32 inst, aper;
+	u32 aper;
 
 	if ((ret = nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false)))
 		return ret;
-- 
2.31.1

