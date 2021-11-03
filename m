Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110ED444028
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhKCKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231705AbhKCKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAekVU7ygZ6b2ymPi8+sZp5ys7JhQaKOrq6g3ORAulg=;
        b=VvAXHlfu+OGpbblWi1UdIcSI2ygJBIoJve11fw4n3pjWMy0TQmL8kttZ/5G9hjZrFAuwqH
        oB1MgpU3C+CVVmWkJtMKFx0UETCrV32ADP1/KQnCdILi0dRFJAfDWY59HcKg1ERiVC/DoL
        cCrhaHfczEMdORd2iLQO58BoZ4u28Yg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-UelAenIyPnGdj34McINvXg-1; Wed, 03 Nov 2021 06:48:24 -0400
X-MC-Unique: UelAenIyPnGdj34McINvXg-1
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so874874wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAekVU7ygZ6b2ymPi8+sZp5ys7JhQaKOrq6g3ORAulg=;
        b=Jl8CfjxQqWwuu1TukOGWVD9sHgFdtyuu1OMduDtwzn9BtMpd6fkAtk0Od2+kjEiScE
         +rTw04Apv7XbtgUhFg6zuJeK4WGBbyTKYvkidvXfTfM731uQhaKvpJTNae0gD0/y8vRX
         1UHazxQ9kL8G9eY7Xf3NLV+88aMGakDBq+kEwbEoNyYAMnZErtqrqBpnPL0uj37h1+RQ
         ioJDpTr/aPhDS91XAcBkqA3P+okjQ3IZCFXJEqDect5pt0k7kAxtgVXFkEgF7DgHBW7T
         EgrrbNgRbiwxxLizbkWWNlPweVqyIn9LkDg1CJfrLgIAbw2sFMDOMQFIrktqCLpK7C7t
         HV9g==
X-Gm-Message-State: AOAM531IDbdELWWq23F14BqiD72Ksc/QQN5TXSLBUntEBmx2/SJqrWbn
        Pa2ZSWioYxcCDTKrl02e3JFaOh0cQtK1OW2Be4KvS+PVdvWtz40voIbkEp2iZ6DSZqaBikd58PK
        xz8EYRXpy49E58X6R9wrwV/X3Aie91Mq/tRvTw+kZk067k2ut8yYGRR47BacVbzSE5vWS/q+Pj9
        I=
X-Received: by 2002:a1c:f405:: with SMTP id z5mr14210550wma.72.1635936502702;
        Wed, 03 Nov 2021 03:48:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSgoZVDmwwXjjfnKBboLawygXClHgOkcfxVUB/AFFTxYyiFW9GyZkBeR+eDVCSWPLd4fDzdw==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr14210525wma.72.1635936502511;
        Wed, 03 Nov 2021 03:48:22 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f15sm1651555wmg.30.2021.11.03.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:48:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 1/5] drm/i915: Fix comment about modeset parameters
Date:   Wed,  3 Nov 2021 11:48:08 +0100
Message-Id: <20211103104812.1022936-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103104812.1022936-1-javierm@redhat.com>
References: <20211103104812.1022936-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment mentions that the KMS is enabled by default unless either the
i915.modeset module parameter or vga_text_mode_force boot option are used.

But the latter does not exist and instead the nomodeset option was meant.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/i915/i915_module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git drivers/gpu/drm/i915/i915_module.c drivers/gpu/drm/i915/i915_module.c
index ab2295dd4500..c7507266aa83 100644
--- drivers/gpu/drm/i915/i915_module.c
+++ drivers/gpu/drm/i915/i915_module.c
@@ -24,8 +24,8 @@ static int i915_check_nomodeset(void)
 
 	/*
 	 * Enable KMS by default, unless explicitly overriden by
-	 * either the i915.modeset prarameter or by the
-	 * vga_text_mode_force boot option.
+	 * either the i915.modeset parameter or by the
+	 * nomodeset boot option.
 	 */
 
 	if (i915_modparams.modeset == 0)
-- 
2.33.1

