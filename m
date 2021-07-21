Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1F43D1A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhGUWRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhGUWRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DAC061575;
        Wed, 21 Jul 2021 15:58:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso2832357pjg.2;
        Wed, 21 Jul 2021 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+cw8jPKXOiLEa8xLIapnrWViV6uOdeXoR2kv/HJ+P4=;
        b=VRBvrLyPXjMyq3NNrJQwTJURKLsMF8t0YRTrSWL6yQN1jSABP6q93x8SQe2av92ULJ
         VSfSjPhdOH5YW9AZGtoVxa3cHqv0/h3JmZGFDf+Cj3h77I12yJdi2mtZB40nEzOTJvBI
         4lVwxol7KpHfbNb6hydwWlcwX8vpD+VfG4GQF8mjbmIwAzPyrvjaLNGwQSlcS91NBq2C
         0j0QQQIwC3PuavDyX4LZxTSESQ18FdzVhd0g8jJbowt56ZrjAy4u20KrEKA1uTfhpgU3
         oqOfO5dTo9AaGpbqHSeYHzif5DLfctdi1dYJ+A5Wt2LvXVzTaIkhcXkycBwCHfJAXBsJ
         irzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+cw8jPKXOiLEa8xLIapnrWViV6uOdeXoR2kv/HJ+P4=;
        b=MPoo9AEGg8S83ddOXCfm4HmrPf46IlTAjGORpnuNZFPlINkq7q6ZufQXsYT6Y5K/sz
         nan+akZQ/8tOFU1aqZNmtGXogASKQjonQgElP80ODb1/kcGlXMddcRjmDwGlhLOVj5np
         L/qlXtvU1u+EWVZVuFCzx5IEQxf6IuNbC4yXPSCpyPoSt2sfOL/XEr8GBRcBw/ZvQ8G2
         jk7JHETBeUGrXUXDb+PXBlzJcs0ovsbUOqhjqR9BlDuuFSXONx4naVF7/WET4Vkk3YLb
         n04Pg6pZEvl3TRaF2trsibk3289LmNQOp11UX5cJ9aR0zB+kmY9AJ592GbJ4Lzq5H3yG
         wRjA==
X-Gm-Message-State: AOAM531MMyMuS1FwYg7qzHKB48aWEmyJq2pQVdMqcpqxcJWrROGN+Vxa
        z0DmESs80lcfQlwpRcH6gGs=
X-Google-Smtp-Source: ABdhPJzZ2meSHXcHLCrxCKJTDtFDZPoFt1PJZKrk+VuwwKbkysgL+Ew63rFKJD8fXct84slvxapayA==
X-Received: by 2002:a62:7bd1:0:b029:336:ea94:6650 with SMTP id w200-20020a627bd10000b0290336ea946650mr29732985pfc.48.1626908299626;
        Wed, 21 Jul 2021 15:58:19 -0700 (PDT)
Received: from localhost.localdomain ([69.181.71.195])
        by smtp.gmail.com with ESMTPSA id x10sm29097765pfd.175.2021.07.21.15.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:19 -0700 (PDT)
From:   Ping Bao <pingbao@gmail.com>
X-Google-Original-From: Ping Bao <ping.a.bao@intel.com>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Ping Bao <ping.a.bao@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:INTEL HID EVENT DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/x86: intel-hid: add Alder Lake ACPI device ID
Date:   Wed, 21 Jul 2021 15:56:15 -0700
Message-Id: <20210721225615.20575-1-ping.a.bao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alder Lake has a new ACPI ID for Intel HID event filter device.

Signed-off-by: Ping Bao <ping.a.bao@intel.com>
---
 drivers/platform/x86/intel-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 078648a9201b..e5fbe017f8e1 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -25,6 +25,7 @@ static const struct acpi_device_id intel_hid_ids[] = {
 	{"INT33D5", 0},
 	{"INTC1051", 0},
 	{"INTC1054", 0},
+	{"INTC1070", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
-- 
2.25.1

