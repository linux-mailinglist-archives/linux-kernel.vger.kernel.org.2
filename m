Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4291F446901
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhKET3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhKET3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:29:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE47C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:27:09 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k1so10497083ilo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mbanz3Hfm4S/C9DnDL7HTgcmeqSrMpcM5u5NhVQnBuE=;
        b=VHic04TFK5OIOKout+PopC1QvUa9eGR8Ssxz4/epvHw2FIXkzJS5NLtlwsy7QsSXbE
         zQWk3RBt8/qPYKGz0h2DUtvUlXBEjrLJiTq0r6VKMeduj0C/9mHCPw80u9kTOXl88P/g
         LdoQ0TtMvRfJeh0kG/loEQdebfGwEHQC/oe8OFy55izv1tRM0Rv0LggBD/+3yBSzRtl6
         unVZJe4MPeHmWyd+LmmNVNlD8IKt58sDptGkjW5npmHkbX7XmuxUi55HA1fkIljywJWh
         fLLc7DwjnrixOIB97zgHUxPgSXf+zOgAn++chCxwamCO2c7fH6N/g6adxRpmUsu8vhbw
         Dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbanz3Hfm4S/C9DnDL7HTgcmeqSrMpcM5u5NhVQnBuE=;
        b=TNYVhZspIIe+nfd0YQuk5ssS0djNaB/mfuGUBMBPEg8jYJwxXLh+Cdwf0L5VCEMsGx
         ulY1Zzq5heT6jahnFUaNTFNNVcnqNKHwP6D4bB5h7arHrgd5buBfstwMhfUJUiHn11QT
         OuZET3CIu7pOAkRck79vp7gPjFj5iBYq3WrdhDNzGnH9lp0q6P/RHpu96u/qWsZlGw5S
         4zTK94dPVqgQTRsOVEhgh78RslPu2KLzF+D6xgT0Nri3xjQEuWSZJ4vh5YBz3kkf4Md8
         6/rKpOQRQEtUaJ19PUKP+HjUlF6gNm2nT9eZ6MGHxvWfWBCZrOooMX6nxJP4A1HHJijW
         usHg==
X-Gm-Message-State: AOAM533bw9Bop92OwYIjactVs3YO5fNFaeg+givgFEylOxwlnObmKJt7
        qfIOc1RF67SQK58Rb765EoY=
X-Google-Smtp-Source: ABdhPJy5rWjxc5K+tSAKEThodmKiaGWvIID7w4CSCBvuWOIP5mup87Nn2YES3sALcBam10Ce/HM0rA==
X-Received: by 2002:a05:6e02:1561:: with SMTP id k1mr18658520ilu.135.1636140429420;
        Fri, 05 Nov 2021 12:27:09 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l18sm4338617iob.17.2021.11.05.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:27:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v10 02/10] drm: fix doc grammar
Date:   Fri,  5 Nov 2021 13:26:29 -0600
Message-Id: <20211105192637.2370737-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105192637.2370737-1-jim.cromie@gmail.com>
References: <20211105192637.2370737-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allocates and initializes ...

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 0cd95953cdf5..4b29261c4537 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -486,7 +486,7 @@ void *__devm_drm_dev_alloc(struct device *parent,
  * @type: the type of the struct which contains struct &drm_device
  * @member: the name of the &drm_device within @type.
  *
- * This allocates and initialize a new DRM device. No device registration is done.
+ * This allocates and initializes a new DRM device. No device registration is done.
  * Call drm_dev_register() to advertice the device to user space and register it
  * with other core subsystems. This should be done last in the device
  * initialization sequence to make sure userspace can't access an inconsistent
-- 
2.31.1

