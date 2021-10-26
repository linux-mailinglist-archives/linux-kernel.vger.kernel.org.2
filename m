Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FEF43B422
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhJZOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbhJZObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE018C061767;
        Tue, 26 Oct 2021 07:29:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso3366676wmc.1;
        Tue, 26 Oct 2021 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xo1zrjSRYbJ4QRig0x/mjc9C5ydPD0Xhp7aCDTMxECE=;
        b=LN9eW3M7OORDiMYG9/AkErP59g507J9M22wZRTBOFqakmGLylp570aaNW1qrXUnVo6
         vBqLUP/zncna5mxrAtm0V8csr8trzZP8HE0gs/76YvVv9p3yC8m6NXKI/IQ1gwAXvh3x
         FTzAB+kd4VhZQg1hAXn7u4XZqhewUbFLZcLTQBbc2sFwW297kipxpQfag6dUz+Bu0GDS
         aTH3zLmhAmcZxChF6YRImrk1C0XFb3D2sbnQYQ7xMan6WHn2uzjFaIbwqEbH2QxrkJi1
         AvTbypRicNbnFNvqdqpyRhRG19gN3HcLaGfNl8fffog9mccf9adMOWZ8NxZF4dfhsmh1
         MWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xo1zrjSRYbJ4QRig0x/mjc9C5ydPD0Xhp7aCDTMxECE=;
        b=OcdTW3j25dNINy9zFCkh15Y8V1FGD0pDZ7bl/YGfqn1dsTUPzfMMoYjIyiRAKtPZfF
         XxcSyLRPkX4vcOBka+kTnqmV5lcF00M5gl3DA6Qf8WvkK0JTqikkTpAmcONzeYHpifWC
         Y5lVn85sJ1F9W05BQ6UdNzYlqXz82vpBX8VspXsr2uNwq7AkERZltyFSNdwAdhI6N8oi
         LSpBJjOQvzOWj/a3rU7GN+Mm6fdQ74aRhQ4f+bUMWaXUWU/1LsazDkv7coT+5ResUdVJ
         LEErHwgnclhIWTRvtMPCyGyBva8dM8/VsYRr8YqakyFu7CVCJFQE9DBhd2khhlj/8ON6
         bIww==
X-Gm-Message-State: AOAM5327vsG4Z6KhJcItda5yOH1hPJhS5MEQPXf43f006uFT6BGPj9qf
        Lx1OSp4TgzJtY+u8hsDKKio=
X-Google-Smtp-Source: ABdhPJwr4dIlKKmff6r3qi/obpI8HDtpj/9EtYMTB/IRHbcTZDRtIFoobWMMAgMAN/EOCUfDc1Rcaw==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr26936154wmk.99.1635258568357;
        Tue, 26 Oct 2021 07:29:28 -0700 (PDT)
Received: from localhost.localdomain (i5C74E3E5.versanet.de. [92.116.227.229])
        by smtp.gmail.com with ESMTPSA id f18sm18745717wrg.3.2021.10.26.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:29:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 3/4] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Tue, 26 Oct 2021 16:19:01 +0200
Message-Id: <20211026141902.4865-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
References: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
refers to the non-existing file intel,kmb_display.yaml in
./Documentation/devicetree/bindings/display/.

Commit 5a76b1ed73b9 ("dt-bindings: display: Add support for Intel KeemBay
Display") originating from the same patch series however adds the file
intel,keembay-display.yaml in that directory instead.

So, refer to intel,keembay-display.yaml in the INTEL KEEM BAY DRM DRIVER
section instead.

Fixes: ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7d85dda8736..88cc726c36c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9624,7 +9624,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.26.2

