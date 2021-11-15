Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8B451A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351201AbhKOXfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245583AbhKOTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:20:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3359E63568;
        Mon, 15 Nov 2021 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637001444;
        bh=QuAHEIBx/bpVeC2FkUGBqxUxdDNi7NOtet59OMG3eDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDrDXISNpVVxBkMVNTNuGNq8EYBIPc/eJmgTuZhQ0LDsWPT1nsnro/XtlpL9Mehvo
         NsJ+6Kvt/MSw/QXAIYxR8D87joCMJgHA1H+EnVx9dsbu3VoRdNfPMrOSY5f8PEySyy
         BpYaRr5/JY9vLsviWa1OjpTyPyyZ4tvqtGtupjaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Zhu <James.Zhu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 192/917] drm/amdgpu: move iommu_resume before ip init/resume
Date:   Mon, 15 Nov 2021 17:54:47 +0100
Message-Id: <20211115165435.301392847@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Zhu <James.Zhu@amd.com>

[ Upstream commit 9cec53c18a3170c7e5673c414da56aeecee94832 ]

Separate iommu_resume from kfd_resume, and move it before
other amdgpu ip init/resume.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=211277
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b8d9004fb1635..5b88c873c8a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2394,6 +2394,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
-- 
2.33.0



