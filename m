Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211E03B8A91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF3Wp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhF3WpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:45:25 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A7C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:42:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id D35AE2FD;
        Thu,  1 Jul 2021 00:42:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G7ISy1JTru8z; Thu,  1 Jul 2021 00:42:50 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id EFB4A60;
        Thu,  1 Jul 2021 00:42:49 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1lyiuu-006wxI-OS; Thu, 01 Jul 2021 00:42:48 +0200
Date:   Thu, 1 Jul 2021 00:42:48 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Salah Triki <salah.triki@gmail.com>,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org
Subject: [PATCH] speakup: replace sprintf() by scnprintf()
Message-ID: <20210630224248.2iq6o6krecx4cz5j@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Salah Triki <salah.triki@gmail.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: D35AE2FD
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace sprintf() by scnprintf() in order to avoid buffer overflows.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_soft.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index c3f97c572fb6..19824e7006fe 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -153,18 +153,25 @@ static char *get_initstring(void)
 	static char buf[40];
 	char *cp;
 	struct var_t *var;
+	size_t len;
+	size_t n;
 
 	memset(buf, 0, sizeof(buf));
 	cp = buf;
+	len = sizeof(buf);
+
 	var = synth_soft.vars;
 	while (var->var_id != MAXVARS) {
 		if (var->var_id != CAPS_START && var->var_id != CAPS_STOP &&
-		    var->var_id != PAUSE && var->var_id != DIRECT)
-			cp = cp + sprintf(cp, var->u.n.synth_fmt,
-					  var->u.n.value);
+		    var->var_id != PAUSE && var->var_id != DIRECT) {
+			n = scnprintf(cp, len, var->u.n.synth_fmt,
+				      var->u.n.value);
+			cp = cp + n;
+			len = len - n;
+		}
 		var++;
 	}
-	cp = cp + sprintf(cp, "\n");
+	cp = cp + scnprintf(cp, len, "\n");
 	return buf;
 }
 
-- 
2.25.1
