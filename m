Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A23D814F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhG0VRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhG0VRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D59DC0617B9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:16:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso6729618pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=db8CMs13sEHX1QrEwLyB80i98nPNa1sx0I+0vCyGors=;
        b=GWOY5bNN2CYuRWq0nDk3v8n5cQ2YUiqY5XDlZOPEfI39J/ywTay9f3iHysNx2fWQdy
         zqT86UEKHG+I7P6vcxs8NsLuEZO32JeDh3YEB1VC1clApxF/IgDgUW1mT7APjJS6y9ti
         ibvhpmNjVFtbWbV705O3Ucg2loDxWrMRa+bQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=db8CMs13sEHX1QrEwLyB80i98nPNa1sx0I+0vCyGors=;
        b=E5rwe0LbY9RzAWvpBJPpArygsmP3zdibV1HsU9HwQssoB0u7Dxt+XDQ4p1R32z3h0a
         7K2TxcyRjHyt1WfswxNJN7sR2yyn+cgWB0/bMI1H0KFrzDNAcWd/huBcwrl7LJVQgdSt
         xXtepBpFQYAlw1MYqR2YmAbSFbbWR0LdBe2BYgbWMfnrpIujjhSv43dWYPN4wWuI/o8a
         LmDZUdg7mm8PP7NNPmhB7kKX23FHLBF/CynGZyrx67A5BnDXto8uLyVsEyvlUZ3bCf3Y
         2mZCgQvHhKiW7CbxXgHczNdcQovPcp4jCIjFPb36JVul9bxdVWR1+e+9+eu+a2lTBh5N
         zecQ==
X-Gm-Message-State: AOAM530EK7BVXsTwVCGcRhsryjWsKJjc41LoZGvaslxiokkFYSzGTEvo
        ZtIaarEDza9y3CQjwWXzDbGS+g==
X-Google-Smtp-Source: ABdhPJynuJ3TvAm0Wd5cbNmdXEieC82pehh6dYyZToK5xONKi9T1JAddthF14F/cuU0HoDy1XIjotg==
X-Received: by 2002:a17:90a:d305:: with SMTP id p5mr5977952pju.96.1627420618747;
        Tue, 27 Jul 2021 14:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm5469795pgg.25.2021.07.27.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 23/64] drm/amd/pm: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:14 -0700
Message-Id: <20210727205855.411487-24-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9262; h=from:subject; bh=ELu/4WSY3rbbc3e6mnbh27qh1PLcuIwUnaACOi4RQcY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOFJv5WnR7sn1mtFkKeG0XEr7rFPErTrPNncdI8 nbLR12KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhQAKCRCJcvTf3G3AJsR8D/ 9wZ161Upx2yiLo9WehBNhdepCoZIfK0ycr+o+YhGbFvIGHLX2Z/6CVTnO6oGmJhsrVbt+2nrrheUTv 8j7E+ffPwgNTUcJd8NXpFT9iui/NcLA8Yykf7B68HUXIlmENHMzE7OS29F6gOvqpuAocWp2XWkcFiL otEujZfJsmIdWxZhrOSSm850OaA3vK59G4R6x/nQbmZcTEuIsmnLAoSu6mxNQN8qfCo5+sTSnF3v2R JF91oAQ2cCf5Z2zYOFs/fY6mGfUVCy0oO/l4oZvnjGjWbHkr8bCYaQoMKAFt+gt7iCU/OQTfLYPVa2 62ogAYAXdveR8zzIITEVXrNMgpDA0PITtHEc3kSIq3iBDlCEKukUEznhPLc9L/KjJW4PDa8fphg2Yh Gekz7vZ+GJglawP6/OVsDHYjB+sVivtpueU6OrZQwDrIvls+2tBdhvYA2okrLoYv5QVghtQ5MteFgB QkVkfYyxoLj7VK3aJ9d3T602EK7C0ydm4p600HlPmh4c2j/2hlxA0edgA+/VxOFg8egmS6zr2IfSBD Eq4LZV5dvDAu9vqC6ypQ1LW/66+iw/9YGt0GJiJCY+arODnVFg6+4d9Q4V19RVMN/Hh+K9bnt0M/+J H7XpAuvLYZW1lukZMvCpZapOsvBI4BUSGa3FwriGOeJJSW/+YzrhY/tlrGCA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in structs:
	struct atom_smc_dpm_info_v4_5
	struct atom_smc_dpm_info_v4_6
	struct atom_smc_dpm_info_v4_7
	struct atom_smc_dpm_info_v4_10
	PPTable_t
so the grouped members can be referenced together. This will allow
memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end of
the first member.

"pahole" shows no size nor member offset changes to any structs.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/include/atomfirmware.h           |  9 ++++++++-
 .../gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h    |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h  |  3 ++-
 .../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h   |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c      | 12 ++++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   |  6 +++---
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3811e58dd857..694dee9d2691 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2081,6 +2081,7 @@ struct atom_smc_dpm_info_v4_5
 {
   struct   atom_common_table_header  table_header;
     // SECTION: BOARD PARAMETERS
+  struct_group(dpm_info,
     // I2C Control
   struct smudpm_i2c_controller_config_v2  I2cControllers[8];
 
@@ -2159,7 +2160,7 @@ struct atom_smc_dpm_info_v4_5
   uint32_t MvddRatio; // This is used for MVDD Vid workaround. It has 16 fractional bits (Q16.16)
   
   uint32_t     BoardReserved[9];
-
+  );
 };
 
 struct atom_smc_dpm_info_v4_6
@@ -2168,6 +2169,7 @@ struct atom_smc_dpm_info_v4_6
   // section: board parameters
   uint32_t     i2c_padding[3];   // old i2c control are moved to new area
 
+  struct_group(dpm_info,
   uint16_t     maxvoltagestepgfx; // in mv(q2) max voltage step that smu will request. multiple steps are taken if voltage change exceeds this value.
   uint16_t     maxvoltagestepsoc; // in mv(q2) max voltage step that smu will request. multiple steps are taken if voltage change exceeds this value.
 
@@ -2246,12 +2248,14 @@ struct atom_smc_dpm_info_v4_6
 
   // reserved
   uint32_t   boardreserved[10];
+  );
 };
 
 struct atom_smc_dpm_info_v4_7
 {
   struct   atom_common_table_header  table_header;
     // SECTION: BOARD PARAMETERS
+  struct_group(dpm_info,
     // I2C Control
   struct smudpm_i2c_controller_config_v2  I2cControllers[8];
 
@@ -2348,6 +2352,7 @@ struct atom_smc_dpm_info_v4_7
   uint8_t      Padding8_Psi2;
 
   uint32_t     BoardReserved[5];
+  );
 };
 
 struct smudpm_i2c_controller_config_v3
@@ -2478,6 +2483,7 @@ struct atom_smc_dpm_info_v4_10
   struct   atom_common_table_header  table_header;
 
   // SECTION: BOARD PARAMETERS
+  struct_group(dpm_info,
   // Telemetry Settings
   uint16_t GfxMaxCurrent; // in Amps
   uint8_t   GfxOffset;     // in Amps
@@ -2524,6 +2530,7 @@ struct atom_smc_dpm_info_v4_10
   uint16_t spare5;
 
   uint32_t reserved[16];
+  );
 };
 
 /* 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
index 43d43d6addc0..8093a98800c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
@@ -643,6 +643,7 @@ typedef struct {
   // SECTION: BOARD PARAMETERS
 
   // SVI2 Board Parameters
+  struct_group(v4_6,
   uint16_t     MaxVoltageStepGfx; // In mV(Q2) Max voltage step that SMU will request. Multiple steps are taken if voltage change exceeds this value.
   uint16_t     MaxVoltageStepSoc; // In mV(Q2) Max voltage step that SMU will request. Multiple steps are taken if voltage change exceeds this value.
 
@@ -728,10 +729,10 @@ typedef struct {
   uint32_t     BoardVoltageCoeffB;    // decode by /1000
 
   uint32_t     BoardReserved[7];
+  );
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8]; // SMU internal use
-
 } PPTable_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
index 04752ade1016..0b4e6e907e95 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
@@ -725,6 +725,7 @@ typedef struct {
   uint32_t     Reserved[8];
 
   // SECTION: BOARD PARAMETERS
+  struct_group(v4,
   // I2C Control
   I2cControllerConfig_t  I2cControllers[NUM_I2C_CONTROLLERS];     
 
@@ -809,10 +810,10 @@ typedef struct {
   uint8_t      Padding8_Loadline;
 
   uint32_t     BoardReserved[8];
+  );
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8]; // SMU internal use
-
 } PPTable_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
index a017983ff1fa..5056d3728da8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
@@ -390,6 +390,7 @@ typedef struct {
   uint32_t spare3[14];
 
   // SECTION: BOARD PARAMETERS
+  struct_group(v4_10,
   // Telemetry Settings
   uint16_t GfxMaxCurrent; // in Amps
   int8_t   GfxOffset;     // in Amps
@@ -444,7 +445,7 @@ typedef struct {
 
   //reserved
   uint32_t reserved[14];
-
+  );
 } PPTable_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6ec8492f71f5..19951399cb33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -463,11 +463,11 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 			smc_dpm_table->table_header.format_revision,
 			smc_dpm_table->table_header.content_revision);
 
+	BUILD_BUG_ON(sizeof(smc_pptable->v4_6) != sizeof(smc_dpm_table->dpm_info));
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 6))
-		memcpy(&smc_pptable->MaxVoltageStepGfx,
-		       &smc_dpm_table->maxvoltagestepgfx,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_6, maxvoltagestepgfx));
+		memcpy(&smc_pptable->v4_6, &smc_dpm_table->dpm_info,
+		       sizeof(smc_dpm_table->dpm_info));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59ea59acfb00..cb6665fbe319 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,16 +431,20 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 
 	switch (smc_dpm_table->table_header.content_revision) {
 	case 5: /* nv10 and nv14 */
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+		BUILD_BUG_ON(sizeof(smc_pptable->v4) !=
+			     sizeof(smc_dpm_table->dpm_info));
+		memcpy(&smc_pptable->v4, &smc_dpm_table->dpm_info,
+		       sizeof(smc_dpm_table->dpm_info));
 		break;
 	case 7: /* nv12 */
 		ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
 					      (uint8_t **)&smc_dpm_table_v4_7);
 		if (ret)
 			return ret;
-		memcpy(smc_pptable->I2cControllers, smc_dpm_table_v4_7->I2cControllers,
-			sizeof(*smc_dpm_table_v4_7) - sizeof(smc_dpm_table_v4_7->table_header));
+		BUILD_BUG_ON(sizeof(smc_pptable->v4) !=
+			     sizeof(smc_dpm_table_v4_7->dpm_info));
+		memcpy(&smc_pptable->v4, &smc_dpm_table_v4_7->dpm_info,
+		       sizeof(smc_dpm_table_v4_7->dpm_info));
 		break;
 	default:
 		dev_err(smu->adev->dev, "smc_dpm_info with unsupported content revision %d!\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 856eeaf293b8..c0645302fa50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -407,11 +407,11 @@ static int aldebaran_append_powerplay_table(struct smu_context *smu)
 			smc_dpm_table->table_header.format_revision,
 			smc_dpm_table->table_header.content_revision);
 
+	BUILD_BUG_ON(sizeof(smc_pptable->v4_10) != sizeof(smc_dpm_table->dpm_info));
 	if ((smc_dpm_table->table_header.format_revision == 4) &&
 	    (smc_dpm_table->table_header.content_revision == 10))
-		memcpy(&smc_pptable->GfxMaxCurrent,
-		       &smc_dpm_table->GfxMaxCurrent,
-		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_10, GfxMaxCurrent));
+		memcpy(&smc_pptable->v4_10, &smc_dpm_table->dpm_info,
+		       sizeof(smc_dpm_table->dpm_info));
 	return 0;
 }
 
-- 
2.30.2

