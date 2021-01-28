Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AF307D58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhA1SEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhA1SCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:02:36 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC1C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:01:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id CAFE322;
        Thu, 28 Jan 2021 19:01:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ydfynqHz_-Kg; Thu, 28 Jan 2021 19:01:19 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id E029735A;
        Thu, 28 Jan 2021 19:01:18 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l5BbZ-007knB-C8; Thu, 28 Jan 2021 19:01:17 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     libc-alpha@sourceware.org, gregkh@linuxfoundation.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH 2/2] speakup: Make dectlk flush timeout configurable
Date:   Thu, 28 Jan 2021 19:01:16 +0100
Message-Id: <20210128180116.1848120-3-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128180116.1848120-1-samuel.thibault@ens-lyon.org>
References: <20210128180116.1848120-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: CAFE322
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the serial port or cable got faulty, we may not be getting
acknowledgements any more. The driver then currently waits for 4s to
avoid jamming the device. This makes this delay configurable.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Documentation/ABI/stable/sysfs-driver-speakup  |  7 +++++++
 drivers/accessibility/speakup/speakup_dectlk.c | 11 ++++++++++-
 drivers/accessibility/speakup/spk_types.h      |  3 ++-
 drivers/accessibility/speakup/synth.c          |  3 +++
 drivers/accessibility/speakup/varhandlers.c    |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-speakup b/Documentation/ABI/stable/sysfs-driver-speakup
index 47f5c8a..dc2a6ba 100644
--- a/Documentation/ABI/stable/sysfs-driver-speakup
+++ b/Documentation/ABI/stable/sysfs-driver-speakup
@@ -312,6 +312,13 @@ Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the frequency of the speech synthesizer. Range is
 		0-9.
 
+What:		/sys/accessibility/speakup/<synth-name>/flush_time
+KernelVersion:	5.12
+Contact:	speakup@linux-speakup.org
+Description:	Gets or sets the timeout to wait for the synthesizer flush to
+		complete. This can be used when the cable gets faulty and flush
+		notifications are getting lost.
+
 What:		/sys/accessibility/speakup/<synth-name>/full_time
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index d75de36..580ec79 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -78,6 +78,8 @@ static struct kobj_attribute direct_attribute =
 	__ATTR(direct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute full_time_attribute =
 	__ATTR(full_time, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute flush_time_attribute =
+	__ATTR(flush_time, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute jiffy_delta_attribute =
 	__ATTR(jiffy_delta, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute trigger_time_attribute =
@@ -99,6 +101,7 @@ static struct attribute *synth_attrs[] = {
 	&delay_time_attribute.attr,
 	&direct_attribute.attr,
 	&full_time_attribute.attr,
+	&flush_time_attribute.attr,
 	&jiffy_delta_attribute.attr,
 	&trigger_time_attribute.attr,
 	NULL,	/* need to NULL terminate the list of attributes */
@@ -118,6 +121,7 @@ static struct spk_synth synth_dectlk = {
 	.trigger = 50,
 	.jiffies = 50,
 	.full = 40000,
+	.flush_time = 4000,
 	.dev_name = SYNTH_DEFAULT_DEV,
 	.startup = SYNTH_START,
 	.checkval = SYNTH_CHECK,
@@ -200,18 +204,23 @@ static void do_catch_up(struct spk_synth *synth)
 	static u_char last = '\0';
 	unsigned long flags;
 	unsigned long jiff_max;
-	unsigned long timeout = msecs_to_jiffies(4000);
+	unsigned long timeout;
 	DEFINE_WAIT(wait);
 	struct var_t *jiffy_delta;
 	struct var_t *delay_time;
+	struct var_t *flush_time;
 	int jiffy_delta_val;
 	int delay_time_val;
+	int timeout_val;
 
 	jiffy_delta = spk_get_var(JIFFY);
 	delay_time = spk_get_var(DELAY);
+	flush_time = spk_get_var(FLUSH);
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	jiffy_delta_val = jiffy_delta->u.n.value;
+	timeout_val = flush_time->u.n.value;
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+	timeout = msecs_to_jiffies(timeout_val);
 	jiff_max = jiffies + jiffy_delta_val;
 
 	while (!kthread_should_stop()) {
diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
index 7789f5d..6a96ad9 100644
--- a/drivers/accessibility/speakup/spk_types.h
+++ b/drivers/accessibility/speakup/spk_types.h
@@ -48,7 +48,7 @@ enum var_id_t {
 	ATTRIB_BLEEP, BLEEPS,
 	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
 	DIRECT, PAUSE,
-	CAPS_START, CAPS_STOP, CHARTAB, INFLECTION,
+	CAPS_START, CAPS_STOP, CHARTAB, INFLECTION, FLUSH,
 	MAXVARS
 };
 
@@ -178,6 +178,7 @@ struct spk_synth {
 	int trigger;
 	int jiffies;
 	int full;
+	int flush_time;
 	int ser;
 	char *dev_name;
 	short flags;
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index 6c14b68..2b86996 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -348,6 +348,7 @@ struct var_t synth_time_vars[] = {
 	{ TRIGGER, .u.n = {NULL, 20, 10, 2000, 0, 0, NULL } },
 	{ JIFFY, .u.n = {NULL, 50, 20, 200, 0, 0, NULL } },
 	{ FULL, .u.n = {NULL, 400, 200, 60000, 0, 0, NULL } },
+	{ FLUSH, .u.n = {NULL, 4000, 100, 4000, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -408,6 +409,8 @@ static int do_synth_init(struct spk_synth *in_synth)
 		synth_time_vars[2].u.n.default_val = synth->jiffies;
 	synth_time_vars[3].u.n.value =
 		synth_time_vars[3].u.n.default_val = synth->full;
+	synth_time_vars[4].u.n.value =
+		synth_time_vars[4].u.n.default_val = synth->flush_time;
 	synth_printf("%s", synth->init);
 	for (var = synth->vars;
 		(var->var_id >= 0) && (var->var_id < MAXVARS); var++)
diff --git a/drivers/accessibility/speakup/varhandlers.c b/drivers/accessibility/speakup/varhandlers.c
index d7f6bec..067c0da 100644
--- a/drivers/accessibility/speakup/varhandlers.c
+++ b/drivers/accessibility/speakup/varhandlers.c
@@ -23,6 +23,7 @@ static struct st_var_header var_headers[] = {
 	{ "trigger_time", TRIGGER, VAR_TIME, NULL, NULL },
 	{ "jiffy_delta", JIFFY, VAR_TIME, NULL, NULL },
 	{ "full_time", FULL, VAR_TIME, NULL, NULL },
+	{ "flush_time", FLUSH, VAR_TIME, NULL, NULL },
 	{ "spell_delay", SPELL_DELAY, VAR_NUM, &spk_spell_delay, NULL },
 	{ "bleeps", BLEEPS, VAR_NUM, &spk_bleeps, NULL },
 	{ "attrib_bleep", ATTRIB_BLEEP, VAR_NUM, &spk_attrib_bleep, NULL },
-- 
2.20.1

