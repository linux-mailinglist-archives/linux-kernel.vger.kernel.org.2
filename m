Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212233D22F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhGVLLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:11:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34568 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhGVLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:11:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 788071FF03;
        Thu, 22 Jul 2021 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626954702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBgN2J1JHNvtg8ki+S6zhAqVVORKz+BHkhKDPGGQs2M=;
        b=BsmbrtiPzgRZ/EcioZyTluiYZE3+GI1zcZxERNztahQ4B8XEERSYU7smUKT4Q6dCKZVRM+
        yakOzNp3pqQj3wKmoGa62nMbdtzdbE9H0GkpAJVxIU9u4JUbZVrjtj7f5v3p1UcIoFaZ5Y
        VrWShh8t88um/57T1YDokZzSZfBGs+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626954702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBgN2J1JHNvtg8ki+S6zhAqVVORKz+BHkhKDPGGQs2M=;
        b=3WMc1EBuPtDbrB61bo1cz7dMSkrLlgF2HD8HbPFRk8v33ZP5eZrekg6q9Mc6letjnQcXdc
        1m/JwxuQXVV6DqCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3AC8CA3B85;
        Thu, 22 Jul 2021 11:51:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] v253_init: eliminate pointer to string
Date:   Thu, 22 Jul 2021 13:51:41 +0200
Message-Id: <20210722115141.516-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722115141.516-1-jslaby@suse.cz>
References: <20210722115141.516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have an extra pointer to a string (v253_init).
Convert it to an array.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/cx20442.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 65c6b92d7b5f..13258f3ca9aa 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -206,7 +206,7 @@ static int cx20442_write(struct snd_soc_component *component, unsigned int reg,
  */
 
 /* Modem init: echo off, digital speaker off, quiet off, voice mode */
-static const char *v253_init = "ate0m0q0+fclass=8\r";
+static const char v253_init[] = "ate0m0q0+fclass=8\r";
 
 /* Line discipline .open() */
 static int v253_open(struct tty_struct *tty)
-- 
2.32.0

