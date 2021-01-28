Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DB307D57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhA1SD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhA1SCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:02:36 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B8C061794
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:01:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 3FE9735A;
        Thu, 28 Jan 2021 19:01:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CGO3thmYvTPY; Thu, 28 Jan 2021 19:01:19 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 071D3372;
        Thu, 28 Jan 2021 19:01:18 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l5BbZ-007kn9-BO; Thu, 28 Jan 2021 19:01:17 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     libc-alpha@sourceware.org, gregkh@linuxfoundation.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH 1/2] speakup ABI: Advertise synth parameters for all synths
Date:   Thu, 28 Jan 2021 19:01:15 +0100
Message-Id: <20210128180116.1848120-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128180116.1848120-1-samuel.thibault@ens-lyon.org>
References: <20210128180116.1848120-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: 3FE9735A
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
         FROM_EQ_ENVFROM(0.00)[];
         BAYES_HAM(-0.00)[11.54%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters were advertised for the "soft" synth, but they are
available for all synths.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Documentation/ABI/stable/sysfs-driver-speakup | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-speakup b/Documentation/ABI/stable/sysfs-driver-speakup
index 792f58b..47f5c8a 100644
--- a/Documentation/ABI/stable/sysfs-driver-speakup
+++ b/Documentation/ABI/stable/sysfs-driver-speakup
@@ -273,7 +273,7 @@ Description:	In `/sys/accessibility/speakup` is a directory corresponding to
 		Below is a description of values and  parameters for soft
 		synthesizer, which is currently the most commonly used.
 
-What:		/sys/accessibility/speakup/soft/caps_start
+What:		/sys/accessibility/speakup/<synth-name>/caps_start
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	This is the string that is sent to the synthesizer to cause it
@@ -281,7 +281,7 @@ Description:	This is the string that is sent to the synthesizer to cause it
 		and most others, this causes the pitch of the voice to rise
 		above the currently set pitch.
 
-What:		/sys/accessibility/speakup/soft/caps_stop
+What:		/sys/accessibility/speakup/<synth-name>/caps_stop
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	This is the string sent to the synthesizer to cause it to stop
@@ -290,12 +290,12 @@ Description:	This is the string sent to the synthesizer to cause it to stop
 		down to the
 		currently set pitch.
 
-What:		/sys/accessibility/speakup/soft/delay_time
+What:		/sys/accessibility/speakup/<synth-name>/delay_time
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	TODO:
 
-What:		/sys/accessibility/speakup/soft/direct
+What:		/sys/accessibility/speakup/<synth-name>/direct
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Controls if punctuation is spoken by speakup, or by the
@@ -306,36 +306,36 @@ Description:	Controls if punctuation is spoken by speakup, or by the
 		than". Zero lets speakup speak the punctuation. One lets the
 		synthesizer itself speak punctuation.
 
-What:		/sys/accessibility/speakup/soft/freq
+What:		/sys/accessibility/speakup/<synth-name>/freq
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the frequency of the speech synthesizer. Range is
 		0-9.
 
-What:		/sys/accessibility/speakup/soft/full_time
+What:		/sys/accessibility/speakup/<synth-name>/full_time
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	TODO:
 
-What:		/sys/accessibility/speakup/soft/jiffy_delta
+What:		/sys/accessibility/speakup/<synth-name>/jiffy_delta
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	This controls how many jiffys the kernel gives to the
 		synthesizer. Setting this too high can make a system unstable,
 		or even crash it.
 
-What:		/sys/accessibility/speakup/soft/pitch
+What:		/sys/accessibility/speakup/<synth-name>/pitch
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the pitch of the synthesizer. The range is 0-9.
 
-What:		/sys/accessibility/speakup/soft/inflection
+What:		/sys/accessibility/speakup/<synth-name>/inflection
 KernelVersion:	5.8
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the inflection of the synthesizer, i.e. the pitch
 		range. The range is 0-9.
 
-What:		/sys/accessibility/speakup/soft/punct
+What:		/sys/accessibility/speakup/<synth-name>/punct
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the amount of punctuation spoken by the
@@ -343,13 +343,13 @@ Description:	Gets or sets the amount of punctuation spoken by the
 		TODO: How is this related to speakup's punc_level, or
 		reading_punc.
 
-What:		/sys/accessibility/speakup/soft/rate
+What:		/sys/accessibility/speakup/<synth-name>/rate
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the rate of the synthesizer. Range is from zero
 		slowest, to nine fastest.
 
-What:		/sys/accessibility/speakup/soft/tone
+What:		/sys/accessibility/speakup/<synth-name>/tone
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the tone of the speech synthesizer. The range for
@@ -357,12 +357,12 @@ Description:	Gets or sets the tone of the speech synthesizer. The range for
 		difference if using espeak and the espeakup connector.
 		TODO: does espeakup support different tonalities?
 
-What:		/sys/accessibility/speakup/soft/trigger_time
+What:		/sys/accessibility/speakup/<synth-name>/trigger_time
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	TODO:
 
-What:		/sys/accessibility/speakup/soft/voice
+What:		/sys/accessibility/speakup/<synth-name>/voice
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the voice used by the synthesizer if the
@@ -371,7 +371,7 @@ Description:	Gets or sets the voice used by the synthesizer if the
 		voices, this parameter will not set the voice when the espeakup
 		connector is used  between speakup and espeak.
 
-What:		/sys/accessibility/speakup/soft/vol
+What:		/sys/accessibility/speakup/<synth-name>/vol
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the volume of the speech synthesizer. Range is 0-9,
-- 
2.20.1

