Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1C3B361A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhFXSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:52:19 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:39075 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFXSwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:52:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d23 with ME
        id M6pu2500121Fzsu036puNL; Thu, 24 Jun 2021 20:49:56 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Jun 2021 20:49:56 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     clemens@ladisch.de, o-takashi@sakamocchi.jp, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ALSA: firewire-lib: Fix 'amdtp_domain_start()' when no AMDTP_OUT_STREAM stream is found
Date:   Thu, 24 Jun 2021 20:49:36 +0200
Message-Id: <9c9a53a4905984a570ba5672cbab84f2027dedc1.1624560484.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent here is to return an error code if we don't find what we are
looking for in the 'list_for_each_entry()' loop.

's' is not NULL if the list is empty or if we scan the complete list.
Introduce a new 'found' variable to handle such cases.

Fixes: 60dd49298ec5 ("ALSA: firewire-lib: handle several AMDTP streams in callback handler of IRQ target")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
We could test with" if (list_entry_is_head(s, &d->streams, list))"
instead, but I find it much less readable.
---
 sound/firewire/amdtp-stream.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index aad9778d1c4d..9be2260e4ca2 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1943,6 +1943,7 @@ int amdtp_domain_start(struct amdtp_domain *d, unsigned int tx_init_skip_cycles,
 	unsigned int events_per_period = d->events_per_period;
 	unsigned int queue_size;
 	struct amdtp_stream *s;
+	bool found = false;
 	int err;
 
 	if (replay_seq) {
@@ -1955,10 +1956,12 @@ int amdtp_domain_start(struct amdtp_domain *d, unsigned int tx_init_skip_cycles,
 
 	// Select an IT context as IRQ target.
 	list_for_each_entry(s, &d->streams, list) {
-		if (s->direction == AMDTP_OUT_STREAM)
+		if (s->direction == AMDTP_OUT_STREAM) {
+			found = true;
 			break;
+		}
 	}
-	if (!s)
+	if (!found)
 		return -ENXIO;
 	d->irq_target = s;
 
-- 
2.30.2

