Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B4454DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhKQTf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:35:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbhKQTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:35:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38EAE2114D;
        Wed, 17 Nov 2021 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637177572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FF7UCsojzx3IaFcpe06QskS6C/FUMgVa9wc/j/zbQpI=;
        b=wFh+tS38p135YLWS+v9cM8nb3RACUC+QIMgsWQ3zv3tl5+Qo0YipkVWqOFEUV6x1f3q6ug
        CG8IQDvpFPpK8Grl4253ezKmzJmHqqRrSnYtcdvRyVSyyIeRXHm4GfV1DCsbwbFKKuAbrG
        3zYYbKrlnBMAFAtagFc8LW+nJkVi8LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637177572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FF7UCsojzx3IaFcpe06QskS6C/FUMgVa9wc/j/zbQpI=;
        b=4nNnpszVTKbNOhb2TehHMDxIVLnmC5IJs3YAIgWkedIRDZAFUNZWGAf/s9brtdUQfzvSwn
        hf1O3Nx6bZ3Cj/Ag==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 26EC9A3B85;
        Wed, 17 Nov 2021 19:32:52 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
Date:   Wed, 17 Nov 2021 20:32:44 +0100
Message-Id: <20211117193244.31162-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FORTIFY_SOURCE is set, memcpy() checks the potential
buffer overflow and panics.  The code in sofcpga bootstrapping
contains the memcpy() calls are mistakenly translated as the shorter
size, hence it triggers a panic as if it were overflowing.

This patch adds the __NO_FORTIFY define for avoiding the
false-positive crash.

Buglink: https://bugzilla.suse.com/show_bug.cgi?id=1192473
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

I took an easier path for now, as the attempt with a foced cast
failed.  If there is a better way to handle, let me know, I'd happily
resubmit.  Thanks!

 arch/arm/mach-socfpga/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index fbb80b883e5d..d46b1af96a8a 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -5,6 +5,9 @@
  * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
  * Copyright (C) 2012 Altera Corporation
  */
+
+#define __NO_FORTIFY /* need to avoid the crash with memcpy() calls */
+
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
-- 
2.26.2

