Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47533A5A41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 21:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFMUBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:01:19 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 12:59:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id CBAC5222;
        Sun, 13 Jun 2021 21:59:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EDEJtg76cm0w; Sun, 13 Jun 2021 21:59:11 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 301D34F;
        Sun, 13 Jun 2021 21:59:11 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1lsWGE-004hMP-1D; Sun, 13 Jun 2021 21:59:10 +0200
Date:   Sun, 13 Jun 2021 21:59:09 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Trevor Astrope <astrope@tabbweb.com>
Subject: [speakup] Separate out translations for bright colors names
Message-ID: <20210613195909.n7ssor6iqeo3pcno@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, Trevor Astrope <astrope@tabbweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: CBAC5222
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code was assuming that bright color names can be forged by just
prepending the "bright" word to the color name. But some langages may rather
append it, or require completely different names ("grey" is actually already an
example).

From: Trevor Astrope <astrope@tabbweb.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux/drivers/accessibility/speakup/i18n.c
===================================================================
--- linux.orig/drivers/accessibility/speakup/i18n.c
+++ linux/drivers/accessibility/speakup/i18n.c
@@ -90,6 +90,13 @@ static char *speakup_default_msgs[MSG_LA
 	[MSG_COLOR_YELLOW] = "yellow",
 	[MSG_COLOR_WHITE] = "white",
 	[MSG_COLOR_GREY] = "grey",
+	[MSG_COLOR_BRIGHTBLUE] "bright blue",
+	[MSG_COLOR_BRIGHTGREEN] "bright green",
+	[MSG_COLOR_BRIGHTCYAN] "bright cyan",
+	[MSG_COLOR_BRIGHTRED] "bright red",
+	[MSG_COLOR_BRIGHTMAGENTA] "bright magenta",
+	[MSG_COLOR_BRIGHTYELLOW] "bright yellow",
+	[MSG_COLOR_BRIGHTWHITE] "bright white",
 
 	/* Names of key states. */
 	[MSG_STATE_DOUBLE] = "double",
Index: linux/drivers/accessibility/speakup/i18n.h
===================================================================
--- linux.orig/drivers/accessibility/speakup/i18n.h
+++ linux/drivers/accessibility/speakup/i18n.h
@@ -99,7 +99,14 @@ enum msg_index_t {
 	MSG_COLOR_YELLOW,
 	MSG_COLOR_WHITE,
 	MSG_COLOR_GREY,
-	MSG_COLORS_END = MSG_COLOR_GREY,
+	MSG_COLOR_BRIGHTBLUE,
+	MSG_COLOR_BRIGHTGREEN,
+	MSG_COLOR_BRIGHTCYAN,
+	MSG_COLOR_BRIGHTRED,
+	MSG_COLOR_BRIGHTMAGENTA,
+	MSG_COLOR_BRIGHTYELLOW,
+	MSG_COLOR_BRIGHTWHITE,
+	MSG_COLORS_END = MSG_COLOR_BRIGHTWHITE,
 
 	MSG_STATES_START,
 	MSG_STATE_DOUBLE = MSG_STATES_START,
Index: linux/drivers/accessibility/speakup/main.c
===================================================================
--- linux.orig/drivers/accessibility/speakup/main.c
+++ linux/drivers/accessibility/speakup/main.c
@@ -389,10 +389,6 @@ static void say_attributes(struct vc_dat
 	int fg = spk_attr & 0x0f;
 	int bg = spk_attr >> 4;
 
-	if (fg > 8) {
-		synth_printf("%s ", spk_msg_get(MSG_BRIGHT));
-		fg -= 8;
-	}
 	synth_printf("%s", spk_msg_get(MSG_COLORS_START + fg));
 	if (bg > 7) {
 		synth_printf(" %s ", spk_msg_get(MSG_ON_BLINKING));
