Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37BC352148
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhDAVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDAVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:04:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC6C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:04:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so3728329pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS1LPIsezpCfocYIASL2NtIlww+sNkf6cjcT4RJnaow=;
        b=fwh3+pD5yDTbAvFnHw+DPPjbmI6jhKr1a2h5FwBZuCtmYefNWziRgemcSVNnPTJ0He
         zcu31whNStsYbAhTrWIP+L/bdiMzcTF+Fp/8dS1f0TDFWHohIIFonTjAXwGAXbjwa+HJ
         I7zvP/F3lnV1dJLOPH43Y3Pm6QqyBlydZzfp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS1LPIsezpCfocYIASL2NtIlww+sNkf6cjcT4RJnaow=;
        b=VGJ661MbSxojnOheCAtMJ9SkJw8TkBCqFASjlRg/xhIwR51wZJ8R0bb+G0H1yOvXpc
         9FKls4uavMN32PxjFf5Ddyqm8ZM7U89MNNyQF1aVcMAvtPLR9J3jdH47RCrosv3EVx73
         hHz+tmp+G7QVBEOpZBW3B4lMPuBbUexg0Iy+5l4jb7pH3ElGVSZ2LjVEYvZ9xLy8MCM0
         7OA1jyaQvgdXCpIvSevP6yLUSEiTp+UhwWOyYu1MN73HPDaDC9Op+TiT7+Qli741CR8N
         3TfmNPcWp/38VoWOfifBb4hMioupdGtTDKkpwE19zZuHdYZkLjlcWjhS93ySbweymibN
         CENw==
X-Gm-Message-State: AOAM5310DaeLDD2dB6c8jGQ1WT5GHAMzMq3liT2dejDwW4I/331HJdka
        k2AaFNyNc1pvGcq9Z56fOqrYUQ==
X-Google-Smtp-Source: ABdhPJzkuyTHdQb/knNIIqB3C0DeN2XN+Vg4Xtzz3s7QdKB2fG8O1l+f1uvrtei5Q2dfF394h9dijw==
X-Received: by 2002:a17:90a:174c:: with SMTP id 12mr10470133pjm.40.1617311085643;
        Thu, 01 Apr 2021 14:04:45 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:208f:468e:f20:f4a])
        by smtp.gmail.com with ESMTPSA id j3sm6177873pfi.74.2021.04.01.14.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:04:45 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: google: Enable s0ix logging by default
Date:   Thu,  1 Apr 2021 14:04:36 -0700
Message-Id: <20210401140430.1.Ie141e6044d9b0d5aba72cb08857fdb43660c54d3@changeid>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many moons ago, support was added to the SMI handlers to log s0ix entry
and exit. Early iterations of firmware on Apollo Lake correctly returned
"unsupported" for this new command they did not recognize, but
unfortunately also contained a quirk where this command would cause them
to power down rather than resume from s0ix.

Fixes for this quirk were pushed out long ago, so all APL devices still
in the field should have updated firmware. As such, we no longer need to
have the s0ix_logging_enable be opt-in, where every new platform has to
add this to their kernel commandline parameters. Change it to be on by
default.

In theory we could remove the parameter altogether: updated versions of
Chrome OS containing a kernel with this change would also be coupled
with firmware that behaves properly with these commands. Eventually we
should probably do that. For now, convert this to an opt-out parameter
so there's an emergency valve for people who are deliberately running
old firmware, or as an escape hatch in case of unforeseen regressions.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/firmware/google/gsmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 3d77f26c1e8c93..bb6e77ee3898c1 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -136,12 +136,16 @@ MODULE_PARM_DESC(spincount,
 	"The number of loop iterations to use when using the spin handshake.");
 
 /*
- * Platforms might not support S0ix logging in their GSMI handlers. In order to
- * avoid any side-effects of generating an SMI for S0ix logging, use the S0ix
- * related GSMI commands only for those platforms that explicitly enable this
- * option.
+ * Some older platforms with Apollo Lake chipsets do not support S0ix logging
+ * in their GSMI handlers, and behaved poorly when resuming via power button
+ * press if the logging was attempted. Updated firmware with proper behavior
+ * has long since shipped, removing the need for this opt-in parameter. It
+ * now exists as an opt-out parameter for folks defiantly running old
+ * firmware, or unforeseen circumstances. After the change from opt-in to
+ * opt-out has baked sufficiently, this parameter should probably be removed
+ * entirely.
  */
-static bool s0ix_logging_enable;
+static bool s0ix_logging_enable = true;
 module_param(s0ix_logging_enable, bool, 0600);
 
 static struct gsmi_buf *gsmi_buf_alloc(void)
-- 
2.29.2

