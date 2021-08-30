Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80503FB2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhH3I5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhH3I5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:57:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:56:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 2so6481833qtw.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tJ6r11vL2cnm7Uj/Y9K6LPuM0r1YrtPXWYFjXW3QXyE=;
        b=cKoort5H/R+5+MQ6TqihjHTGb5I52GufUHAw6Jyuxo1tjKTb5MNyd5GYDzA19B4Dlu
         +QYd2qwVJpE+W8Jq3xBk/G/dBEcgzdU7bhBS9zIajD/VipJkq6p0HU16hJr4FG3+1R6l
         W83GzNRHWmDh0rh0logRp+KgjMl7uLvwdhKlDD4pkEY2IytQyWxEQ0+oTNfrFUBFjioR
         vTetWnXsy4MwDQrv53pi+UP376ximL72/ZHTYJ5LFI10BYr6RRf5RHLHwJRaKNvXg5Hs
         wKbtXT2Y83Ar3Knzpxnlz+/IOW5VsIXwU8+q9rdj99bnIUsXcgtYlv2SuQmSgKuF4kD7
         +7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tJ6r11vL2cnm7Uj/Y9K6LPuM0r1YrtPXWYFjXW3QXyE=;
        b=JsPH+9igJ2lQISV+UKVo/X8VEDCfqkznUk2DDPLmmnCNz9J2etrZKtchxlO5upi6kR
         HJq72mAdECJofBjWEU68nvseXDDQ9Mz4TFdnweJOdf+b+hLTFnB1GGKzcA0spBNgTYy/
         7cRv2sO5Bb/fUKypn3isNuanGwr/VVOwa6VOLl4/asokazO8jSMI+vOi0EgGGQri/y0d
         YyFicD7gtBVR5IO58yMRMakNEBoJ2YqEh8Li8ueL6UcFRmsTD2az0Fc653FyVeEsslkE
         MULxKv+3WHlQyPQKVrNzt6ytdIAU6Ylsz8oB16wjaduYGxc3QQhtJj7OmyofBQFNc73r
         Bnmg==
X-Gm-Message-State: AOAM532OgJ5aPK5miF7W79zPwHZ6SVM2pSpbD+m/hCWNef/uflPgfjuz
        2uBgOnP1qCpCnpr1BqqX+vbDR8nIO80=
X-Google-Smtp-Source: ABdhPJwWxoEKEjlvEC0qCNKI+hEfbPXI7oIMbM55/Y8EdOlbV1vhBIKlHSSCVy/1wXcCRgm27vrqtg==
X-Received: by 2002:aed:20a2:: with SMTP id 31mr20076182qtb.69.1630313776172;
        Mon, 30 Aug 2021 01:56:16 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id w20sm8044811qtj.72.2021.08.30.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 01:56:15 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 352712B478;
        Mon, 30 Aug 2021 04:56:15 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 2754C6001E5; Mon, 30 Aug 2021 04:56:15 -0400 (EDT)
Date:   Mon, 30 Aug 2021 04:56:15 -0400
From:   nick black <dankamongmen@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, nick black <dankamongmen@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] console: consume APC, DM, DCS
Message-ID: <YSydL0q8iaUfkphg@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

console: consume APC, DM, DCS

The Linux console's VT102 implementation already
consumes OSC ("Operating System Command") sequences,
probably because that's how palette changes are
transmitted. In addition to OSC, there are three other
major clases of ANSI control strings: APC ("Application
Program Command"), PM ("Privacy Message", and DCS
("Device Control String"). They are handled similarly
to OSC in terms of termination.

Source: vt100.net

Add three new enumerated states, one for each of these
types. All three are handled the same way right now--they
simply consume input until terminated. I hope to expand
upon this firmament in the future. Add new predicate
ansi_control_string(), returning true for any of these
states. Replace explicit checks against ESosc with calls
to this function. Transition to these states appropriately
from the escape initiation (ESesc) state.

This was motivated by the following Notcurses bugs:

 https://github.com/dankamongmen/notcurses/issues/2050
 https://github.com/dankamongmen/notcurses/issues/1828
 https://github.com/dankamongmen/notcurses/issues/2069

where standard VT sequences are not consumed by the
Linux console. It's not necessary that the Linux console
*support* these sequences, but it ought *consume* these
well-specified classes of sequences.

Tested by sending a variety of escape sequences to the
console, and verifying that they still worked, or were
now properly consumed. Verified that the escapes were
properly terminated at a generic level. Verified that
the Notcurses tools continued to show expected output on
the Linux console, except now without escape bleedthrough.

Signed-off-by: nick black <dankamongmen@gmail.com>
---
diff --git drivers/tty/vt/vt.c drivers/tty/vt/vt.c
index ef981d3b7bb4..62b77ee3f8d1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2059,7 +2059,7 @@ static void restore_cur(struct vc_data *vc)
 
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
 	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
-	ESpalette, ESosc };
+	ESpalette, ESosc, ESapc, ESpm, ESdcs };
 
 /* console_lock is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
@@ -2133,20 +2133,28 @@ static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
 		vc->vc_translate = set_translate(*charset, vc);
 }
 
+/* is this state an ANSI control string? */
+static bool ansi_control_string(unsigned int state)
+{
+	if (state == ESosc || state == ESapc || state == ESpm || state == ESdcs)
+		return true;
+	return false;
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 {
 	/*
 	 *  Control characters can be used in the _middle_
-	 *  of an escape sequence.
+	 *  of an escape sequence, aside from ANSI control strings.
 	 */
-	if (vc->vc_state == ESosc && c>=8 && c<=13) /* ... except for OSC */
+	if (ansi_control_string(vc->vc_state) && c >= 8 && c <= 13)
 		return;
 	switch (c) {
 	case 0:
 		return;
 	case 7:
-		if (vc->vc_state == ESosc)
+		if (ansi_control_string(vc->vc_state))
 			vc->vc_state = ESnormal;
 		else if (vc->vc_bell_duration)
 			kd_mksound(vc->vc_bell_pitch, vc->vc_bell_duration);
@@ -2207,6 +2215,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		case ']':
 			vc->vc_state = ESnonstd;
 			return;
+		case '_':
+			vc->vc_state = ESapc;
+			return;
+		case '^':
+			vc->vc_state = ESpm;
+			return;
 		case '%':
 			vc->vc_state = ESpercent;
 			return;
@@ -2224,6 +2238,9 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			if (vc->state.x < VC_TABSTOPS_COUNT)
 				set_bit(vc->state.x, vc->vc_tab_stop);
 			return;
+		case 'P':
+			vc->vc_state = ESdcs;
+			return;
 		case 'Z':
 			respond_ID(tty);
 			return;
@@ -2520,8 +2537,14 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		vc_setGx(vc, 1, c);
 		vc->vc_state = ESnormal;
 		return;
+	case ESapc:
+		return;
 	case ESosc:
 		return;
+	case ESpm:
+		return;
+	case ESdcs:
+		return;
 	default:
 		vc->vc_state = ESnormal;
 	}
