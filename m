Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BEC3B2B80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFXJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFXJjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:39:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F93F6112D;
        Thu, 24 Jun 2021 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624527442;
        bh=jsDGWCDLGzsT5JajHINSRUN4a5PAlDEfxYxcZcF0zwc=;
        h=Date:From:To:cc:Subject:From;
        b=c+n4Z8J6IQEwAaZ8RLOv9H70UhqOOySZvE/UUJXn7kvhpk2LlmphaTGRSBn+V6baK
         snTcWvrvis4/i1FPQCRkJhp2Q6Z3TbzrBDg9JQu9/3hKdCB7HsJRoWKHQjH15Hqemc
         QWJBtixZgc8LZ79IYbVqc3oZ0U4qKV9SYHrh3LT0K0x2ezzxE0sZkwPiB1J6kqmWoe
         3sP5mwvG5jXMpo/hZgVAzn6nzXik8CVUDUngDFwilbGJ3RWAGebd8546ePeao7/trz
         1Ulwch2aBG1sW5z2QpJuDbVja9En1jpfkwtanDnh7HkQN9pXv+y2qHvwM7vE4dqy5M
         Z28VgiAaUo4BA==
Date:   Thu, 24 Jun 2021 11:37:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>
cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH] drm/amdgpu: Avoid printing of stack contents on firmware
 load error
Message-ID: <nycvar.YFH.7.76.2106241135440.18969@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

In case when psp_init_asd_microcode() fails to load ASD microcode file, 
psp_v12_0_init_microcode() tries to print the firmware filename that 
failed to load before bailing out.

This is wrong because:

- the firmware filename it would want it print is an incorrect one as
  psp_init_asd_microcode() and psp_v12_0_init_microcode() are loading
  different filenames
- it tries to print fw_name, but that's not yet been initialized by that
  time, so it prints random stack contents, e.g.

    amdgpu 0000:04:00.0: Direct firmware load for amdgpu/renoir_asd.bin failed with error -2
    amdgpu 0000:04:00.0: amdgpu: fail to initialize asd microcode
    amdgpu 0000:04:00.0: amdgpu: psp v12.0: Failed to load firmware "\xfeTO\x8e\xff\xff"

Fix that by bailing out immediately, instead of priting the bogus error 
message.

Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index c4828bd3264b..5b21e22ad4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -67,7 +67,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 
 	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
-		goto out;
+		return err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
 	err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
-- 
2.12.3


-- 
Jiri Kosina
SUSE Labs

