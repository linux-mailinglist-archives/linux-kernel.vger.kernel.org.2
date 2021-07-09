Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564B13C26D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhGIPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:32:25 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59138
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232345AbhGIPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:32:23 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1DEBB404A1;
        Fri,  9 Jul 2021 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1625844579;
        bh=xe5I//6AkaPs41liKKGn0Rijuw2VMft/GmwfbTDfTB4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=gvlHziTOkfNokIk4C7ZzIf+ycYDnRmq+TVn0amcF7qMr42pkhAvLx9yG/Y95QVYoJ
         BzNxeWDIXG9vO7GtjUEnN5bF7lYIRlwCRWm/aJ45tS/NDhRnFNkobJFLRhT740h8K9
         aY0FASt7wBhIz7C60NS1hDkrX3cFQqbucicYWy69MYfImR9Wp9H63REh2lJ6/TpuVI
         1RgvpvrzOVTybmig9KzI82PyDaM7yh1Bm1m5WgDbG2MbHWDokAPfkaJ5Mb9RzgN+t4
         nIlKS8QActTeAg/wO/R5rZhNaM7IGDTp4qB7REgfAeeOQzQnxxSP6wV8LZUpF3/YK0
         3gklXvJCl7upA==
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132: remove redundant initialization of variable status
Date:   Fri,  9 Jul 2021 16:29:38 +0100
Message-Id: <20210709152938.460763-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is being initialized with a value that is never
read, the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b66e7bdbf483..50ca72ee586e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2270,7 +2270,7 @@ static int dspio_send_scp_message(struct hda_codec *codec,
 				  unsigned int *bytes_returned)
 {
 	struct ca0132_spec *spec = codec->spec;
-	int status = -1;
+	int status;
 	unsigned int scp_send_size = 0;
 	unsigned int total_size;
 	bool waiting_for_resp = false;
-- 
2.31.1

