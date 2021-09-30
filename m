Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD941E2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbhI3Ugz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 16:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348030AbhI3Ugy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 16:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633034111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ddey/K9wpIxOBXbjiNaGsj4E/caV13pJbiNDITnKjiA=;
        b=e4OAA5JjI6EP9NHCMtB+fHluoRFxi/DOJnQTht1kdWyMN6m+y+VGK2T4COUJ2etKj7gPtM
        /XAGSRbaEJ5LN9UVhvTaZjIYmN4D88ydrvhlpg5o84sK3BxIph/pfwxmYsVhms5aQAnt+u
        U0CpcDnhuypMr1ge2cS+z3WGs+sOvFc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-xQa_G_MWMaaRSKuyUWWRMA-1; Thu, 30 Sep 2021 16:35:09 -0400
X-MC-Unique: xQa_G_MWMaaRSKuyUWWRMA-1
Received: by mail-ot1-f71.google.com with SMTP id m12-20020a0568301e6c00b005469f1a7d70so5112285otr.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ddey/K9wpIxOBXbjiNaGsj4E/caV13pJbiNDITnKjiA=;
        b=41sSZUICLDmEWhCtzO0I9gtddKqIah8U6QweRsnlNoO0KV8RehZhlA4Zs2UNnE6EC7
         qv9KLsUVw66ig2UDm9JewGZd+axGk4+4c6sTAD52MyjfIBxdZkv9mSRU+uzfoKUctNJF
         dz5NFj7So5Joaar8jvKC8oPfrQQ7iMJAHsV9w9LQ0A+Nyi0TR4npBDm7DSIo6RE4RqjJ
         +yVNLLUugZAfa+R4irSoKD41LMD4LpCniD7wPgRNPp/u2hnpgaKkfBW2a6ukcSRxlkRy
         pzl9AmyZXRd9UErPaOCnN/xwWt4YIkadgbrVh/DowsvHiOpO0eRgvZ9B47qYk1MI33P+
         4i8w==
X-Gm-Message-State: AOAM5329b62d/awtIyx07biJJakzW3czpArYanNPNdQNx7E/4ZR00UjZ
        3CI79EIh0jJTv5SJSnwAlEES6Uq6G91cYsrIhFvftOtjo/NQBiFNjQsUG6dYZogFDWtXD3VkIkK
        A+VHM0Ey+cwBQkQbgAFPBWxzE
X-Received: by 2002:a9d:eac:: with SMTP id 41mr6915150otj.38.1633034108767;
        Thu, 30 Sep 2021 13:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHDY1UmnahWM3r/K2pa4cUoccqfVEBvB3ig9Y7Mb2SIBYYFlvI2J1A9NKArgCzNIpdaObCPg==
X-Received: by 2002:a9d:eac:: with SMTP id 41mr6915131otj.38.1633034108556;
        Thu, 30 Sep 2021 13:35:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a23sm769273otp.44.2021.09.30.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 13:35:07 -0700 (PDT)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: match the signatures of the real and stub kgd2kfd_probe()
Date:   Thu, 30 Sep 2021 13:34:58 -0700
Message-Id: <20210930203458.441556-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When CONFIG_HSA_AMD=n this there is this error
amdgpu_amdkfd.c:75:56: error: incompatible type for
  argument 2 of ‘kgd2kfd_probe’
   75 |  adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev, vf);

amdgpu_amdkfd.h:349:17: note: declared here
  349 | struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
  struct pci_dev *pdev,

The signature of the stub kgd2kfd_probe() does not match the real one.
So change the stub to match.

Fixes: 920f37e6a3fc ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 38d883dffc20..69de31754907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -346,8 +346,7 @@ static inline void kgd2kfd_exit(void)
 }
 
 static inline
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-					unsigned int asic_type, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 {
 	return NULL;
 }
-- 
2.26.3

