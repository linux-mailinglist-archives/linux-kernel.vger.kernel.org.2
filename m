Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04876310B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBENI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhBENBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:01:32 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288AC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:00:32 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id l27so6675893qki.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBV1D6Ulmmeg0XD410dqPaIFfUR1ad9jwk0fJwumF/4=;
        b=UYtLnPaRPURQD2DV0MRGsjizexD0di8ASLpoteP2KvUtIa3WtJkzw+uDkUpdlNI+kq
         +X7UpeuknA84xI9v6BUp87wROVah7IGgRlHubZk+wnFfTpzeuxiOHyKIcKsriAt1uGFH
         X4nkvLhYNqllZGeFXQReMtjWS6/L7gQMXhiQv1hKdgnLmZQLK3gjfv8V6QYbmkssXMfW
         4MPf+vSDbkkhsG2lFij1yoIc0/7G7xHu1Qpvv/aesnC1S6l2lrcDL2gjqW4PADahL2tg
         WoBmA0kZARzwHjKyEgMMqlgLkPlihCRv9RKlQjswMZMIrXRz/qMWTXIRBrCT47kSlqjb
         71dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBV1D6Ulmmeg0XD410dqPaIFfUR1ad9jwk0fJwumF/4=;
        b=RKOJo4kv2/HPe7DR+rYvpaKMUsYaxmYt8MbQK9yWgfaw1M02dzUxlYNMQG6BFITXf+
         D/i/bd5IuKd3lHgwRKxbOAIma/pj8vu0hiGDwruTYTUiFG8i5Q9jIlySK0oZp33auLYk
         1ph+F3olliUtfI4VP0LWOQw/vWpACDigUdQJOkYogRPhh77rflSv3pNqUMTsPkoXwFFX
         kKI2gDwIk++m3qtrZLOY9lE92b9Oq2QL8YNwKVl6w1qtcmZgfk3Gny6bkj9SOuxf/Ctv
         16u2J9VSLi0YitSjt1wsf2ZO8HyQoLk9XQPLo6IGbDouJggfq0O3JAcBltk3+pkISfuK
         q79g==
X-Gm-Message-State: AOAM531c2Ud6FKaC8qvR3dMpuzoEyAAPbrzCS62qKusuB3irH5cgxDQu
        4hRd04ERxL1hCxfkO7CUXkM=
X-Google-Smtp-Source: ABdhPJxrie2UTeqqCE3Vg2D6+dzvEjZzeCzQ3MZFPzh0FksJ4UhzYpjj+t7cqcWPQCb8/suSjM8GHQ==
X-Received: by 2002:a37:8cd:: with SMTP id 196mr3940194qki.434.1612530032227;
        Fri, 05 Feb 2021 05:00:32 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id 17sm9481367qtu.23.2021.02.05.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:00:31 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: gpu: drm: nouveau: Change not good word with a good one in the file init.c
Date:   Fri,  5 Feb 2021 18:30:17 +0530
Message-Id: <20210205130017.1429442-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/fucking/messing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index 9de74f41dcd2..bc2a55a82171 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
 {
 	/* This appears to be the behaviour of the VBIOS parser, and *is*
 	 * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
-	 * avoid fucking up the memory controller (somehow) by reading it
+	 * avoid messing up the memory controller (somehow) by reading it
 	 * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
 	 *
 	 * Preserving the non-caching behaviour on earlier chipsets just
--
2.30.0

