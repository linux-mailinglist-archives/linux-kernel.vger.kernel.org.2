Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585B23FE45B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhIAVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhIAVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:00:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:59:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so614058pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vZaPFR910A+peByQ064AQctC74vcmHflxe3uQT3LOKI=;
        b=kCHoTXp68Dh71TAwR2mPmmz1sLUQC/IyjUrgvToj63qxt1KMR0esatlr3Le/TzH+gw
         kaWVKM7+dNqbjVVYQP/yW+J8OrHEILsbDU7f9upQgoSQG9ii+VGFerLrkF3iVnlVveeX
         6oeMRSknNUSWbXZllnF6jSB8PTw8RlIeTNL0DF7yD0KmQf3tPL5LBy0BtA8PVJsH/70A
         sFDJTeXGcXAOL0vrz11kPmFao9bWwkrV1A4a6WYoAUp9jXZDAi3Ut5wJOgLqPvlAeA9f
         iKtt4H8vJmsVf0KMxBVoHgf66rmqRu5WGvP9uyK+iGhkYvhhU+pxQFFgobz9POhmj0UO
         xLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vZaPFR910A+peByQ064AQctC74vcmHflxe3uQT3LOKI=;
        b=POYlFzyGBnNWhuyGduXMnJcWgComTLm+YCzzxyFS/GVu7NreBujA3kdOQMueo8rLFE
         b/p/qwdPAhfMgcJ2ghtC7KDj8ldyXYmrzo+qwkYvpxNSSxJHUm536FK0ciK7iKkf7MoJ
         qlwnblwhqQjMvvi6nYgL5p8A/qnq55oqhHdm/2Mjr8c09x4qd8IMTR5zIuypQXH0Iu20
         wwwI03ArBTPvz+UmytFYmvOZ/l4KdFF8Qx7hTXU+vYHsuAMqvFm6B+Dh6mKyeRE+aQex
         RmX21JkNHYE97JqwrmVy/dJICqSc+IWSfiO0+oUETFZXKoqyHvpMCEpayZwVM+NIPaDt
         K3+w==
X-Gm-Message-State: AOAM533YJpyKQS4TLw5fdfsBwqQYPNHv9BrjXhiyTatoqvmw5CacvA3p
        t6VymUXCHNhJdz5HrCuuR34DdPa/E8Dza5hwMYk=
X-Google-Smtp-Source: ABdhPJyuHslppk+qr3pxgIfewgC03RDZGAdXMKXIeFOQTyVRaPbg+eTEKkctaDh/p5H/M2ro/gU0zMAuoehpQfyPFTI=
X-Received: by 2002:a17:90a:520c:: with SMTP id v12mr1303547pjh.105.1630529946799;
 Wed, 01 Sep 2021 13:59:06 -0700 (PDT)
MIME-Version: 1.0
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Wed, 1 Sep 2021 22:58:55 +0200
Message-ID: <CAPGkw+zcW+mG2hnvQZqPzeS3T2AobYmZkoPKkqHo-KK3MSKTaA@mail.gmail.com>
Subject: [PATCH] Fix formatting for file "hsdma-mt7621.c" by fixing formatting
 of lines ending with "("
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krish Jain <krishjain02939@gmail.com>

This patch fixes the format of the code. It properly formats lines
that should not end with a '(' as suggested by checkpath.pl.

Signed-off-by: Krish Jain <krishjain02939@gmail.com>

---
 drivers/staging/mt7621-dma/hsdma-mt7621.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/mt7621-dma/hsdma-mt7621.c
b/drivers/staging/mt7621-dma/hsdma-mt7621.c
index b0ed935de7ac..89b72a802800 100644
--- a/drivers/staging/mt7621-dma/hsdma-mt7621.c
+++ b/drivers/staging/mt7621-dma/hsdma-mt7621.c
@@ -162,8 +162,7 @@ struct mtk_hsdam_engine {
  struct mtk_hsdma_chan chan[1];
 };

-static inline struct mtk_hsdam_engine *mtk_hsdma_chan_get_dev(
- struct mtk_hsdma_chan *chan)
+static inline struct mtk_hsdam_engine *mtk_hsdma_chan_get_dev(struct
mtk_hsdma_chan *chan)
 {
  return container_of(chan->vchan.chan.device, struct mtk_hsdam_engine,
  ddev);
@@ -174,8 +173,7 @@ static inline struct mtk_hsdma_chan
*to_mtk_hsdma_chan(struct dma_chan *c)
  return container_of(c, struct mtk_hsdma_chan, vchan.chan);
 }

-static inline struct mtk_hsdma_desc *to_mtk_hsdma_desc(
- struct virt_dma_desc *vdesc)
+static inline struct mtk_hsdma_desc *to_mtk_hsdma_desc(struct
virt_dma_desc *vdesc)
 {
  return container_of(vdesc, struct mtk_hsdma_desc, vdesc);
 }
@@ -457,9 +455,7 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
  spin_unlock_bh(&chan->vchan.lock);
 }

-static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
- struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
- size_t len, unsigned long flags)
+static struct dma_async_tx_descriptor
*mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
dma_addr_t src, size_t len, unsigned long flags)
 {
  struct mtk_hsdma_chan *chan = to_mtk_hsdma_chan(c);
  struct mtk_hsdma_desc *desc;
-- 
2.25.1
