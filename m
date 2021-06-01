Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3165739734A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhFAMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhFAMdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:33:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1196C06138A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 05:32:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d4-20020a25b5c40000b02904f8e3c8c6c9so16782340ybg.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v0JmXkpPcwyLfGDXD/UYS9VSnqvDE/X6cwHvlaKvCDo=;
        b=ge7A6t9VrjoPBf2yczWshpuNpcJZv+LVPUatnZpS2YHPIoaKCjHvFlupHnnnhYfJAR
         XvQM/yh73IVnhEcR2oWqVAVDSrjr/74D749Zvw/1LIcroeerCuzqxiZa/x9SACanH4RN
         KPzu+5NiiqQ1f3r8YOM428JJaiFwsygOY9aXhYWJGPEe+LatsxZrxr+KSjXGL/51NulJ
         5Zx6IzzPlFya6Yag8zcGLBVKK1A+dXElnGCr3HgW8dBx6RNgUAzd8DqG7IWbW8fx7ADp
         5Oglr2Vhh4aWvCNg8OTB0vtNKlOIKgKMAqlgeGNkb1Zvkxlg6XO7yrB5eOgjgQOO1rmJ
         SjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v0JmXkpPcwyLfGDXD/UYS9VSnqvDE/X6cwHvlaKvCDo=;
        b=PnG4pF63GPBzur9+NivhLsHDwptk3Azewt6zTTqrfhkB6wQvBZ70NAxJXAFSwXjcbT
         scBoh9L7GToS8pvX7PDAIggtCZhpGq1QkAXvaszLoMjbib02O8rtI8IJTU3gqXG1o52I
         IF8iEiXFoioVfJnUfCjJnvtjlaZrvu5lzVAV9Blqy7BlLBHs5AKMWj0DcIAtvWmzoIZN
         NquhGmQHHuq3FxNZtoe4H7lSoaqabMlHmblEZoSqMuiVHnv0CmTKeqRVyDC3oKBE1f7P
         gB/gOnNsV96CN4jTfoq9lW20RACRfe4VPY++Dn/yZ1/MOgSSCZsLSxsIdpVBjie9SHnW
         VLPA==
X-Gm-Message-State: AOAM532RliUm7AzJlh3D9PpTRgMINfngK2sARIKWvgvXjF33rtiEJnje
        5+EVtILj5GuhdH25iQAjW6pRrIclkX5G
X-Google-Smtp-Source: ABdhPJw70HX3AuFEpGy9CEQ/cqaj7ZnCC+oIoMK07F8aUbNTKbvzWpdIYlW135qYOIx/LmXcSr0Q2YradCx2
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c9e8:9a17:9774:bcd3])
 (user=kyletso job=sendgmr) by 2002:a05:6902:100c:: with SMTP id
 w12mr37901747ybt.122.1622550725722; Tue, 01 Jun 2021 05:32:05 -0700 (PDT)
Date:   Tue,  1 Jun 2021 20:31:48 +0800
In-Reply-To: <20210601123151.3441914-1-kyletso@google.com>
Message-Id: <20210601123151.3441914-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210601123151.3441914-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v3 1/4] usb: typec: tcpm: Correct the responses in SVDM
 Version 2.0 DFP
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In USB PD Spec Rev 3.1 Ver 1.0, section "6.12.5 Applicability of
Structured VDM Commands", DFP is allowed and recommended to respond to
Discovery Identity with ACK. And in section "6.4.4.2.5.1 Commands other
than Attention", NAK should be returned only when receiving Messages
with invalid fields, Messages in wrong situation, or unrecognize
Messages.

Still keep the original design for SVDM Version 1.0 for backward
compatibilities.

Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
changes since v2:
- no change

 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..617f48cdd90c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1575,19 +1575,25 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
-			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
+			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
+				svdm_version = PD_VDO_SVDM_VER(p[0]);
+			}
 
 			tcpm_ams_start(port, DISCOVER_IDENTITY);
-			/* 6.4.4.3.1: Only respond as UFP (device) */
-			if (port->data_role == TYPEC_DEVICE &&
+			/*
+			 * PD2.0 Spec 6.10.3: respond with NAK as DFP (data host)
+			 * PD3.1 Spec 6.4.4.2.5.1: respond with NAK if "invalid field" or
+			 * "wrong configuation" or "Unrecognized"
+			 */
+			if ((port->data_role == TYPEC_DEVICE || svdm_version >= SVDM_VER_2_0) &&
 			    port->nr_snk_vdo) {
 				/*
 				 * Product Type DFP and Connector Type are not defined in SVDM
 				 * version 1.0 and shall be set to zero.
 				 */
-				if (typec_get_negotiated_svdm_version(typec) < SVDM_VER_2_0)
+				if (svdm_version < SVDM_VER_2_0)
 					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
 						      & ~IDH_CONN_MASK;
 				else
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

