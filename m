Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC7352713
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhDBHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:47:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhDBHr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:47:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D78DDABED;
        Fri,  2 Apr 2021 07:47:55 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Fix invalid access to ACPI _DSM objects
Date:   Fri,  2 Apr 2021 09:47:49 +0200
Message-Id: <20210402074749.25957-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_dsm_platform_mux_info() tries to parse the ACPI package data
from _DSM for the debug information, but it assumes the fixed format
without checking what values are stored in the elements actually.
When an unexpected value is returned from BIOS, it may lead to GPF or
NULL dereference, as reported recently.

Add the checks of the contents in the returned values and skip the
values for invalid cases.

BugLink: http://bugzilla.opensuse.org/show_bug.cgi?id=1184074
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/display/intel_acpi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index e21fb14d5e07..492ebc0a8257 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -84,6 +84,11 @@ static void intel_dsm_platform_mux_info(acpi_handle dhandle)
 		return;
 	}
 
+	if (!pkg->package.count) {
+		DRM_DEBUG_DRIVER("no connection in _DSM\n");
+		return;
+	}
+
 	connector_count = &pkg->package.elements[0];
 	DRM_DEBUG_DRIVER("MUX info connectors: %lld\n",
 		  (unsigned long long)connector_count->integer.value);
@@ -91,6 +96,13 @@ static void intel_dsm_platform_mux_info(acpi_handle dhandle)
 		union acpi_object *obj = &pkg->package.elements[i];
 		union acpi_object *connector_id = &obj->package.elements[0];
 		union acpi_object *info = &obj->package.elements[1];
+
+		if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2 ||
+		    info->type != ACPI_TYPE_BUFFER || info->buffer.length < 4) {
+			DRM_DEBUG_DRIVER("Invalid object for MUX #%d\n", i);
+			continue;
+		}
+
 		DRM_DEBUG_DRIVER("Connector id: 0x%016llx\n",
 			  (unsigned long long)connector_id->integer.value);
 		DRM_DEBUG_DRIVER("  port id: %s\n",
-- 
2.26.2

