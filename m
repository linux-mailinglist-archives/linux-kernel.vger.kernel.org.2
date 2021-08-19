Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598543F1232
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhHSEJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:09:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:09:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m21so5690961qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:dkim-signature:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Orh999XT8d2Kln1fT02eFQ3PZPZed2LISzwhjSssmZo=;
        b=ZXLmWAhgC0rBSgJBLc7SKcSjdsvTHDzrJyA2L01jyQpLC7iLORIqlq4uSjHeg94Ddq
         bsw4Vx6HJiz+7ppRS/K5dUfGmeilF0LkHT6iyEmASRyQjzFOAQuodu9YLXO4TiytM6Jy
         SGCRE6wlvlP+4vVqt7/ypLqfye1YJFFbkEseOEKDlBzANjntmIzj7xkOKJ1FiIeKHrcR
         sH9JyGeMcjd2Uhs73DHBdgTaotiU86j9PktNL/ElSnO1OS4rKOgAZYpW3QnRtJYRJEiR
         kr6IqMYTP4l1sHJ8oj/gOv2RgrdcglRBNyv66gsAERmd+k1A2qTrpLH6bBTvF5/Uv7vy
         wMGw==
X-Gm-Message-State: AOAM533Vt+8eomhffwBdWoWQNr0D4FY5G8aomLuqzPvj1xYleC0a/RYL
        FECUuobeJYLh+pOt2kBosbRU2jqdPXg=
X-Google-Smtp-Source: ABdhPJyZDTWnTWoh/oZhk/M0WYcmejRgBqJK4IuBwRC7ZcsqCAYco6pfGoDcaQtmGt3XarFdpL7vMA==
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr1826768qkl.433.1629346145722;
        Wed, 18 Aug 2021 21:09:05 -0700 (PDT)
Received: from vps.qemfd.net ([2600:3c02::f03c:91ff:fe93:b216])
        by smtp.gmail.com with ESMTPSA id k186sm1075155qkd.47.2021.08.18.21.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 21:09:05 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id E49F12B98A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:09:04 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id D97536002B4; Thu, 19 Aug 2021 00:09:04 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on schwarzgerat.orthanc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Original-To: dank@localhost
Received: from schwarzgerat.orthanc (localhost [IPv6:::1])
        by schwarzgerat.orthanc (Postfix) with ESMTP id 8D2B9600244
        for <dank@localhost>; Wed, 18 Aug 2021 23:49:19 -0400 (EDT)
X-Original-To: dank@qemfd.net
Received: from 192.168.128.1 [192.168.128.1]
        by schwarzgerat.orthanc with IMAP (fetchmail-6.4.21)
        for <dank@localhost> (single-drop); Wed, 18 Aug 2021 23:49:19 -0400 (EDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by vps.qemfd.net (Postfix) with ESMTPS id 031E82B98A
        for <dank@qemfd.net>; Wed, 18 Aug 2021 23:49:19 -0400 (EDT)
Received: by mail-ed1-f51.google.com with SMTP id r19so6560031eds.13
        for <dank@qemfd.net>; Wed, 18 Aug 2021 20:49:18 -0700 (PDT)
X-Received: by 2002:a05:6402:649:: with SMTP id u9mr13707839edx.224.1629344957596;
        Wed, 18 Aug 2021 20:49:17 -0700 (PDT)
X-Forwarded-To: dank@qemfd.net
X-Forwarded-For: dankamongmen@gmail.com dank@qemfd.net
Received: by 2002:a54:2747:0:0:0:0:0 with SMTP id t7csp454443ecq;
        Wed, 18 Aug 2021 20:49:16 -0700 (PDT)
X-Received: by 2002:a05:6214:88b:: with SMTP id cz11mr12556747qvb.29.1629344956242;
        Wed, 18 Aug 2021 20:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1629344956; cv=none;
        d=google.com; s=arc-20160816;
        b=qVWNcWIaXDlEIcsS4UNfLnYRfBZi5+S0e9zGufmlsUhH2sqQtJ8vPY7+K9h6Nwh/vp
         8b7xBLNHQKVpqMh3f7e27zW8JJnzVNxkDphPk1+U2FJa2X7Fy4uxusxVkyv6k9DIqQrF
         pkjDB8J7xdrNxTc1gPZUrCrWCxAmmlGzj6t5h9SrBMerYT9qd6KnC/FOEYOaJ2hwDUpH
         +i9tmcrY1fQjImB1uDVRTUt6XrVDnmDaFsWMpZoXID/829AO9n2kH0WKHViFCpIvep37
         hKGn3E60L+vHw5aNFoRv0T9z2EF+VMvQdqj917ljsGr11B/TI/VaIZkFsoDz7kPLZx0P
         tXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature;
        bh=Orh999XT8d2Kln1fT02eFQ3PZPZed2LISzwhjSssmZo=;
        b=eGfAbqh5TMKBOYx5hxUS6q5jzjb9jd87Qm/xGpmU2tg2OwW2xhKGH7yFbugyiMt/wh
         oSaljBtCupV/LjYkq0VMeQRqU4YFI7Sjt33HuyaTuaPMqVCGoa2dJH0+ZyWSFlawi/6z
         nLUKotpIdo86GBC0JHj+Htm8VmMz2YHfYoljcD9eA+v5k/9FI4ZiI0k4JD+hqFbNsfho
         WjFSWPmK64T88vNBOmIYnTEzfMaFyWB2rM/iFiIWsyfRRSm9eMZksrxd+vFzWt7lB8om
         LAVe+yUKNTOIcnObuR0DiNU52h7T6VaJYkZtwNa5JiPTI8ysVFatdqIN+Ma1+jUaaPBu
         POHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux.com header.s=krs header.b=fHZEHGms;
       spf=pass (google.com: domain of bounce+7373bc.f44a6-dankamongmen=gmail.com@linux.com designates 166.78.68.68 as permitted sender) smtp.mailfrom="bounce+7373bc.f44a6-dankamongmen=gmail.com@linux.com";
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: from m68-68.mailgun.net (m68-68.mailgun.net. [166.78.68.68])
        by mx.google.com with UTF8SMTPS id v17si1426622qta.3.2021.08.18.20.49.15
        for <dankamongmen@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:49:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of bounce+7373bc.f44a6-dankamongmen=gmail.com@linux.com designates 166.78.68.68 as permitted sender) client-ip=166.78.68.68;
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=linux.com; q=dns/txt; s=krs;
 t=1629344956; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From;
 bh=Orh999XT8d2Kln1fT02eFQ3PZPZed2LISzwhjSssmZo=; b=fHZEHGmsZzsMeh6M99QuTRLYPsxkKW1gGFocckw5V+oTPaB0Rs1A2sYVx66kxGzZYKZzZKqI
 +BqiAQh8KOQ2qk1qETy53bgQDR+vYlCfBoqAaEOwr49mEMKF29x0JsMw1zKI5EXCpaQF9P39
 VLSkxSJrbwMj++uUe019O8FPlC4=
X-Mailgun-Sending-Ip: 166.78.68.68
X-Mailgun-Incoming: Yes
X-Envelope-From: <dank@schwarzgerat.orthanc>
Received: from vps.qemfd.net (vps.qemfd.net [173.230.130.29])
 by mxa.mailgun.org with ESMTP id 611dd4b8.7fad4c4b6340-api-n13;
 Thu, 19 Aug 2021 03:49:12 -0000 (UTC)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 4A4FC2B98A;
        Wed, 18 Aug 2021 23:49:11 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 4313D6002B4; Wed, 18 Aug 2021 23:49:11 -0400 (EDT)
From:   nick black <dankamongmen@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     nick black <nickblack@linux.com>
Subject: [PATCH] console: consume APC, DM, DCS
Date:   Wed, 18 Aug 2021 23:48:06 -0400
Message-Id: <20210819034805.33328-1-dankamongmen@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: nick black <nickblack@linux.com>

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

Signed-off-by: Nick Black <nickblack@linux.com>
---
 drivers/tty/vt/vt.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git drivers/tty/vt/vt.c drivers/tty/vt/vt.c
index ef981d3b7bb4..62b77ee3f8d1 100644
--- drivers/tty/vt/vt.c
+++ drivers/tty/vt/vt.c
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
+static bool ansi_control_string(unsigned state)
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
+	if (ansi_control_string(vc->vc_state) && c>=8 && c<=13)
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
-- 
2.33.0
