Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2814390AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhJYIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhJYIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0SKe2bjhvSLrSG4XH/ApB+juNru0m23A7Hu0J3xtAKU=;
        b=PbU6LwVtI2xBcDP4OysZGHfXlTN3qTXQQkwDymSJF5uhf6F1aOQ18WBpZ24gjfSOjGel0a
        0rCkLmLXJL4ul7HQpgYgXYVOU2UCpjEVVL4dyky561YatxS444zxUoFOSxFq1l/51vXrqM
        KsHOp05IyJyPFXSPWYj/03Pbc9cpKXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-S0cnnbxbPKmtxSX45VhYlA-1; Mon, 25 Oct 2021 03:58:05 -0400
X-MC-Unique: S0cnnbxbPKmtxSX45VhYlA-1
Received: by mail-wm1-f69.google.com with SMTP id v18-20020a7bcb52000000b00322fea1d5b7so3610397wmj.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0SKe2bjhvSLrSG4XH/ApB+juNru0m23A7Hu0J3xtAKU=;
        b=4H8xQI8dEhkdtpRgyPOr82dict3gRKhT1dgkuj9fq+W5D12VAhfZFn7p06Zfyx/coz
         LKB2q0GATyPQBBRw3PD3XlFiNHgP/8mLRQaeccl74XZ65TuO/OLucuCukSJMtBVIflWv
         iaSLFDw5UT/WHnlzN5M2Zyz0F1TEFM4UmzdBXTwnI56zbLHeT/rrjXCtj9zU4mqAuOmA
         AlWj9p1ibfTMnlLXd7wBoN4bZAIym787WbbmaSn26bZp37MZRQTGe9E6/VaP9wvbd5rs
         6MD6qANBQRckuZZRf+BgGIutV8/PtXdlFFfhExDTPNVjthJBnxPcn8OJzK5+laQLXZf/
         iqPw==
X-Gm-Message-State: AOAM531Yew/LS3bFo3rOdRM+i9KMPdpVeL2EMTsDCmODv6Ex6AU82CAv
        ByWro/oG19F9ARlH7sIVYnn14Y/I8rbmO6hCn/T336mfjHkHfGTZAWrUN7sYP6zNTkw2cYnsXIH
        DOM1z5eyF4StNkbB5wNvKC0ziQNMxBmYjd17WHK8Iur8yYFqbFpRCPneBhTzxr6e2NienniK0uF
        c=
X-Received: by 2002:a05:600c:2505:: with SMTP id d5mr5484425wma.194.1635148683619;
        Mon, 25 Oct 2021 00:58:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcEaxipbcpXSkrk6igJI58QxDtczsadM2Z+/CN6to52SDebzHifcGYGzU2vkui3i9Ud7FGNQ==
X-Received: by 2002:a05:600c:2505:: with SMTP id d5mr5484388wma.194.1635148683349;
        Mon, 25 Oct 2021 00:58:03 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d1sm15939502wrr.72.2021.10.25.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:58:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] Add a drm.disable_native_drivers command line option
Date:   Mon, 25 Oct 2021 09:57:54 +0200
Message-Id: <20211025075756.3479157-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-series add a drm.disable_native_drivers option that can be used
to prevent native DRM drivers to be probed. That way, the simpledrm driver
won't be removed which can be useful to troubleshoot DRM drivers problems.

Patch #1 is just a small preparatory patch that moves the logic to remove
the conflicting fbdev frame buffer to a helper function.

Patch #2 adds the new kernel command line option and if set, prevents the
drm_aperture_remove_conflicting_framebuffers() function to succeed.

This is a v2 that addresses the issues pointed out by Thomas and Neal.

Best regards,
Javier

Changes in v2:
- Rename command line parameter to drm.disable_native_drivers.
- Return -EBUSY instead of -EINVAL when the function fails.
- Invert the parameter logic and make it false by default.

Javier Martinez Canillas (2):
  drm/aperture: Move conflicting fbdev frame buffer removal to a helper
  drm/aperture: Prevent conflicting framebuffers removal if option is
    set

 drivers/gpu/drm/drm_aperture.c | 54 ++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 12 deletions(-)

-- 
2.31.1

