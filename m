Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168833B2DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhFXLWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhFXLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40412613C5;
        Thu, 24 Jun 2021 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624533624;
        bh=yeBxxI9RxIG1SBqoCQkOp8CWXVUmYQbT3KrhCdThdUQ=;
        h=Date:From:To:cc:Subject:From;
        b=h/uUXhqyme6NlwDRYS288PXCjbfgX3cO68nvhdbShTtcWiUCCFVN/lpxUTNwaT6Ng
         Co+4182vvnP77I/IlfJZ6NjSZ2eamUoa3E8ymWMJ48XG5VzmPhppOlNSO3U5daWq6/
         cmNoJp5UixUE4C1nhdTB1Li4yaf67syfRxE1fz1gUPjDR3tybyc7VTn1AHiEbpdad5
         Ca1ArlpbK875RpjhW+HaDyzuVVpUT9Pe9bFEF9DLGjGvPgx8xF67PrwNXJ1cq1GKgs
         ViBHsz8iDe1bOUepqReha5pnu8MO5nQ7IL8uAeGYK9SJjMmq5vQEPMV1tAwiqyBpvB
         fDDhfVaY6xwmw==
Date:   Thu, 24 Jun 2021 13:20:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>
cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH] drm/amdgpu: Fix resource leak on probe error path
Message-ID: <nycvar.YFH.7.76.2106241319430.18969@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

This reverts commit 4192f7b5768912ceda82be2f83c87ea7181f9980.

It is not true (as stated in the reverted commit changelog) that we never 
unmap the BAR on failure; it actually does happen properly on 
amdgpu_driver_load_kms() -> amdgpu_driver_unload_kms() -> 
amdgpu_device_fini() error path.

What's worse, this commit actually completely breaks resource freeing on 
probe failure (like e.g. failure to load microcode), as 
amdgpu_driver_unload_kms() notices adev->rmmio being NULL and bails too 
early, leaving all the resources that'd normally be freed in 
amdgpu_acpi_fini() and amdgpu_device_fini() still hanging around, leading 
to all sorts of oopses when someone tries to, for example, access the 
sysfs and procfs resources which are still around while the driver is 
gone.

Fixes: 4192f7b57689 ("drm/amdgpu: unmap register bar on device init failure")
Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57ec108b5972..0f1c0e17a587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3414,13 +3414,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		goto failed_unmap;
+		return r;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		goto failed_unmap;
+		return r;
 
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
@@ -3646,10 +3646,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
-failed_unmap:
-	iounmap(adev->rmmio);
-	adev->rmmio = NULL;
-
 	return r;
 }
 
-- 
2.12.3


