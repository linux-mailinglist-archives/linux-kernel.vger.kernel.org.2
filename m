Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E30447DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhKHKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238567AbhKHKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:10 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A3421EC0502;
        Mon,  8 Nov 2021 11:12:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dV4yMzKrI1TbB2ks8ruZkP157t7OTN1nFaA3SUb88SQ=;
        b=GNk0oPHTCiJ2Ie3P0UiFdIsZ0u5vyavaxiCWHbuBT8UA06ECOLORBvzPbrc1iS77ZiuzNh
        QfQfGfVRD7sdOVsI0KmFOU/olLRTH2GnuqOFK+wkoBNLms9AI1VH9nTd76n+hoMsBF0pXh
        59/iPfW6ZACUDcSOFrHkV1A4em4teRo=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org
Subject: [PATCH v0 23/42] ASoC: soc-jack: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:38 +0100
Message-Id: <20211108101157.15189-24-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/soc-jack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index d798765d168c..0875f5022066 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -181,7 +181,8 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_add_pins);
 void snd_soc_jack_notifier_register(struct snd_soc_jack *jack,
 				    struct notifier_block *nb)
 {
-	blocking_notifier_chain_register(&jack->notifier, nb);
+	if (blocking_notifier_chain_register(&jack->notifier, nb))
+		pr_warn("Jack status notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_notifier_register);
 
-- 
2.29.2

