Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFA453CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhKPXTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:19:08 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34675 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhKPXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637104569; x=1668640569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yeFteD/GOh/C5MWeZrfpyg/JwJax0tb03uOPlANsVrg=;
  b=iPnfb3g+XOwK36j8Foifq+meQxCjctsAERmPeIAZySS8GpEHzWvkyZCO
   Y1p1zhcy9WDPUv2qQWEMnNHCmujWxoEiMYJ1gpgkSTZ7a7AJbqGSBWJq9
   YN1uOCyQVYuGd0+d2cKXHNkCBLMN6x0TSzcxK2n3S9kTDvLi3ejhNXUn5
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Nov 2021 15:16:08 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:16:08 -0800
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 16 Nov 2021 15:16:08 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robdclark@gmail.com>
CC:     <sean@poorly.run>, <robin.murphy@arm.com>, <maz@kernel.org>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [RFC 2/2]  drm/msm/gem: Make use of the system cache
Date:   Tue, 16 Nov 2021 15:16:00 -0800
Message-ID: <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of writing to WC cmdstream buffers that go all the way to the main
memory, let's use the system cache to improve the performance.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 104fdfc14027..921a1c24721e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -214,7 +214,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
 static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
 {
 	if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-		return pgprot_writecombine(prot);
+		return pgprot_syscached(prot);
 	return prot;
 }
 
