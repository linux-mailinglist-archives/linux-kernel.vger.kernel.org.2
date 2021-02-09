Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B342315C77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhBJBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhBIXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:49:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EBC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:48:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s18so465674ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLZtFkHMbed+rABy5CfV1sfDkxWh/w6w89VAEQBWMBM=;
        b=Xk52od/vCRkJrNgX2xOUOcqcEZfsjE1G1qm1+cEHAZJ141du77ilkUTMJnuQze3+kp
         gKUG5m7Stw9T8RVxsN4/sruOSsJYDOKE+0q3oCTM70x74K7tXOCiUN1dd5/itmMh0Uz7
         9Jef6DpzmX3bsLMxNhhZFXXos+I+BXGdwOrTtOZMXC607vSFRTA9WwLq1WsMswRgyYB4
         jDHZvBh0xrPewbnxIxtC0a1ixD/gvp3+JaU9buMRMTlYSC2BP9p4F04q/28sRlDxh5Lt
         iRFnrqklipYdwyMryg34VLpBFht3j97CF69mGv7tCc6Z2opoNdfNavQhduFn1yhINZYE
         8B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLZtFkHMbed+rABy5CfV1sfDkxWh/w6w89VAEQBWMBM=;
        b=oIH1U94gq2ZmzvS/29d14naA96tQlZjWjYruCmhg5EITUOINSUsz4nPLAUawkw0RJY
         1KyjCn6Di52U99TkywUS5OX8EpgLm+UlnnT5nCXp2sfBNzIj0nVSLChl3Y9sDzw+9DGi
         sOQ6FloqCLg9ZQmZcV6P5LLMllN60fUsJO/iH6MmwpdRpJYZIild8GC6FDlh6x+hhJ3j
         cH3vbTHjdVrv0eZJdYMD0+IIfCF84jtVV+MHK0QLZgcGMNeVhwwjFho6sjOxEpCUWzHw
         lphPJ2eDUFgYJXUxa4xlACcKI8RwtcGfBo11LtFv8SwkpQFXD+mANa30wsMiEmk8pisO
         9vIQ==
X-Gm-Message-State: AOAM531cPcnwkq2CQ6BxfF800Mz8jjszzSnpuYxQzUHbY6Y275ydrMCb
        MyBQq3WHU4cJcHmB18av4CI=
X-Google-Smtp-Source: ABdhPJzOhLZJW9GPyDZKcQlAB8eHO6X0CxOC29ay/OKYLuVO7/SklISGxX8hQQ49RL96j6DC7Va1dQ==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr178797ljp.97.1612914505429;
        Tue, 09 Feb 2021 15:48:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:48:24 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] drm/radeon/ttm: constify static vm_operations_struct
Date:   Wed, 10 Feb 2021 00:48:16 +0100
Message-Id: <20210209234817.55112-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of radeon_ttm_vm_ops is to assign its address to the
vm_ops field in the vm_area_struct struct. Make it const to allow the
compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index c45e919e03c5..5fc8bae401af 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -835,7 +835,7 @@ static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static struct vm_operations_struct radeon_ttm_vm_ops = {
+static const struct vm_operations_struct radeon_ttm_vm_ops = {
 	.fault = radeon_ttm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-- 
2.30.0

