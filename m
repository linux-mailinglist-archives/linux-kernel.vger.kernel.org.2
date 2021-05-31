Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE439697C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhEaV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhEaV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:59:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D693C061574;
        Mon, 31 May 2021 14:57:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c15so8806762qte.6;
        Mon, 31 May 2021 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//6m+gkIf9xBfynnDQa7ybWxEx7kYjpPTDIZg9UHUI0=;
        b=pk+W0EDPkLOXepYkK4WNQ6BbHmvx8U/bj8yBxqhWJrT1plROzY6BDfv+tMk7KvR/vv
         habZoTBgoTZNVFks73jj0tzbETwjSwvYqO/2fQG3r4nucF8oUWS2uwznnZ9Pg3lpTiIq
         5UK6FJDaKII/Mtk9Yk0KslUxsJLMHx69jViopRFh66vs+vAm2+vwklYi9wZ2yKk1DR1h
         nXWEwLiD9ncR20bBP9uElygzB1De5lGrI6mQoV5OESD8Y64xj1LbmuQpJLZCkqIHESug
         aul/8DxCB6X/Ma+EuIiuL556agf5qf7r1II+oL2y+VJaxcJjYAgeYIYdrgm174YzQVmm
         3qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//6m+gkIf9xBfynnDQa7ybWxEx7kYjpPTDIZg9UHUI0=;
        b=Rpsitm3uUrnKVxxcoPAQHLbkytnkTqFOQ6+YiZ82xoUvY0GLexbLrkhmnijCA1rjX1
         qwtx5a2AbtY0gdVHtmVRpkrMAiWRzoqRSa6QaE+ctrIwMi5rPOY1X5EGFpexUANXv60f
         Kl+WBtpG+e8cupm8aT7gdEcX+99bSGq6aNNMpY04DvUKNRrWZ867N5pWgVvOri3h/rKZ
         mrdco5WM817EJk2LhuVemSTAdgyHXMbnuJmvgE/rbSkPhF9DMfVWEB75rw2ZQhmEdKNu
         IClji14MaFfb49gmrfMbXG9JzkeknUY5si2jn2uD4Cw+PPuhWeHIkGPXsZ+FE8kivxef
         fKdg==
X-Gm-Message-State: AOAM532TKeaUqRbIMtGeTTpmkzGQ8IOZvOS9eF5449anjoRjmJCwaK/5
        vsZ4R9ltgAlUe7dhkUkULpI=
X-Google-Smtp-Source: ABdhPJzpano0aUp2X6mRlhydOwsR510sKS/fuhC5YnAFMl/PjsyZwVCjU+DRCrQ9T1qFXKuaQTrkiA==
X-Received: by 2002:ac8:6890:: with SMTP id m16mr6938520qtq.225.1622498270333;
        Mon, 31 May 2021 14:57:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id 81sm2328646qke.50.2021.05.31.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 14:57:49 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        samuel.thibault@ens-lyon.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: Convert the Speakup guide to rst
Date:   Mon, 31 May 2021 18:57:37 -0300
Message-Id: <20210531215737.8431-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify some parts of the text and add the necessary formatting to leverage
the rst features. Including links, code-blocks, bullet lists, etc.

Also, adds a table of contents at the beginning and a section to the
license.

This change helps integrate this documentation to the rest of the rst
documentation.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---

V2: Rebase the patch to cover the commit cae2181b498fe

---
 Documentation/admin-guide/index.rst           |    1 +
 .../{spkguide.txt => spkguide.rst}            | 1026 +++++++++--------
 2 files changed, 574 insertions(+), 453 deletions(-)
 rename Documentation/admin-guide/{spkguide.txt => spkguide.rst} (75%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 423116c4e787..c45121777ecf 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -112,6 +112,7 @@ configure specific aspects of kernel behavior to your liking.
    ras
    rtc
    serial-console
+   spkguide
    svga
    syscall-user-dispatch
    sysrq
diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.rst
similarity index 75%
rename from Documentation/admin-guide/spkguide.txt
rename to Documentation/admin-guide/spkguide.rst
index 977ab3f5a0a8..e254af41a8e9 100644
--- a/Documentation/admin-guide/spkguide.txt
+++ b/Documentation/admin-guide/spkguide.rst
@@ -1,14 +1,20 @@
-
+========================
 The Speakup User's Guide
-For Speakup 3.1.2 and Later
-By Gene Collins
-Updated by others
-Last modified on Mon Sep 27 14:26:31 2010
-Document version 1.3
+========================
+
+| For Speakup 3.1.2 and Later
+| By Gene Collins
+| Updated by others
+| Last modified on Mon Jan 21 17:08:21 2021
+| Document version 1.3
+
 
-Copyright (c) 2005  Gene Collins
-Copyright (c) 2008  Samuel Thibault
-Copyright (c) 2009, 2010  the Speakup Team
+Copyright and License
+=====================
+
+| Copyright (c) 2005  Gene Collins
+| Copyright (c) 2008  Samuel Thibault
+| Copyright (c) 2009, 2010  the Speakup Team
 
 Permission is granted to copy, distribute and/or modify this document
 under the terms of the GNU Free Documentation License, Version 1.2 or
@@ -17,7 +23,40 @@ Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A
 copy of the license is included in the section entitled "GNU Free
 Documentation License".
 
+
+Contents
+========
+
+* `Preface`_.
+
+* `1.  Starting Speakup`_
+* `2.  Basic operation`_
+* `3.  Using the Speakup Help System`_
+* `4.  Keys and Their Assigned Commands`_
+* `5.  The Speakup Sys System`_
+* `6.  Changing Synthesizers`_
+* `7.  Loading modules`_
+* `8.  Using Software Synthesizers`_
+     - `8.1. Espeakup`_
+     - `8.2. Speech Dispatcher`_
+* `9.  Using The DecTalk PC Card`_
+* `10.  Using Cursor Tracking`_
+* `11.  Cut and Paste`_
+* `12.  Changing the Pronunciation of Characters`_
+* `13.  Mapping Keys`_
+* `14.  Internationalizing Speakup`_
+     - `14.1.  Files Under the i18n Subdirectory`_.
+     - `14.2.1.  Loading Your Own Messages`_.
+     - `14.2.2. Choose a language`_.
+     - `14.3.  No Support for Non-Western-European Languages`_.
+* `15.  Using Speakup's Windowing Capability`_
+* `16.  Tools for Controlling Speakup`_
+     - `16.1.  Speakupconf`_.
+     - `16.2.  Talkwith`_
+
+
 Preface
+=======
 
 The purpose of this document is to familiarize users with the user
 interface to Speakup, a Linux Screen Reader.  If you need instructions
@@ -37,7 +76,9 @@ with speech access unaided by a sighted person.  Again, these details
 are beyond the scope of this manual, but the user should be aware of
 them.  See the web site mentioned above for further details.
 
+
 1.  Starting Speakup
+====================
 
 If your system administrator has installed Speakup to work with your
 specific synthesizer by default, then all you need to do to use Speakup
@@ -58,41 +99,43 @@ build and install your own kernel.
 If your kernel has been compiled with Speakup, and has no default
 synthesizer set, or you would like to use a different synthesizer than
 the default one, then you may issue the following command at the boot
-prompt of your boot loader.
+prompt of your boot loader.::
 
-linux speakup.synth=ltlk
+  linux speakup.synth=ltlk
 
 This command would tell Speakup to look for and use a LiteTalk or
 DoubleTalk LT at boot up.  You may replace the ltlk synthesizer keyword
 with the keyword for whatever synthesizer you wish to use.  The
-speakup.synth parameter will accept the following keywords, provided
+``speakup.synth`` parameter will accept the following keywords, provided
 that support for the related synthesizers has been built into the
 kernel.
 
-acntsa -- Accent SA
-acntpc -- Accent PC
-apollo -- Apollo
-audptr -- Audapter
-bns -- Braille 'n Speak
-dectlk -- DecTalk Express (old and new, db9 serial only)
-decext -- DecTalk (old) External
-dtlk -- DoubleTalk PC
-keypc -- Keynote Gold PC
-ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
-spkout -- Speak Out
-txprt -- Transport
-dummy -- Plain text terminal
-
-Note: Speakup does * NOT * support usb connections!  Speakup also does *
-NOT * support the internal Tripletalk!
+| acntsa -- Accent SA
+| acntpc -- Accent PC
+| apollo -- Apollo
+| audptr -- Audapter
+| bns -- Braille 'n Speak
+| dectlk -- DecTalk Express (old and new, db9 serial only)
+| decext -- DecTalk (old) External
+| dtlk -- DoubleTalk PC
+| keypc -- Keynote Gold PC
+| ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
+| spkout -- Speak Out
+| txprt -- Transport
+| dummy -- Plain text terminal
+
+.. note::
+
+   | Speakup does **NOT** support usb connections!
+   | Speakup also does **NOT** support the internal Tripletalk!
 
 Speakup does support two other synthesizers, but because they work in
 conjunction with other software, they must be loaded as modules after
 their related software is loaded, and so are not available at boot up.
 These are as follows:
 
-decpc -- DecTalk PC (not available at boot up)
-soft -- One of several software synthesizers (not available at boot up)
+| decpc -- DecTalk PC (not available at boot up)
+| soft -- One of several software synthesizers (not available at boot up)
 
 See the sections on loading modules and software synthesizers later in
 this manual for further details.  It should be noted here that the
@@ -102,7 +145,9 @@ the boot process, such action must be configured by your system
 administrator.  This will mean that you will hear some, but not all,  of
 the bootup messages.
 
+
 2.  Basic operation
+===================
 
 Once you have booted the system, and if necessary, have supplied the
 proper bootup parameter for your synthesizer, Speakup will begin
@@ -115,10 +160,12 @@ screen using the kernel, and must get their keyboard input through the
 kernel, they are automatically handled properly by Speakup.  There are a
 few exceptions, but we'll come to those later.
 
-Note:  In this guide I will refer to the numeric keypad as the keypad.
-This is done because the speakupmap.map file referred to later in this
-manual uses the term keypad instead of numeric keypad.  Also I'm lazy
-and would rather only type one word.  So keypad it is.  Got it?  Good.
+.. note::
+
+  In this guide I will refer to the numeric keypad as the keypad.
+  This is done because the speakupmap.map file referred to later in this
+  manual uses the term keypad instead of numeric keypad.  Also I'm lazy
+  and would rather only type one word.  So keypad it is.  Got it?  Good.
 
 Most of the Speakup review keys are located on the keypad at the far
 right of the keyboard.  The numlock key should be off, in order for these
@@ -131,9 +178,9 @@ You probably won't want to listen to all the bootup messages every time
 you start your system, though it's a good idea to listen to them at
 least once, just so you'll know what kind of information is available to
 you during the boot process.  You can always review these messages after
-bootup with the command:
+bootup with the command::
 
-dmesg | more
+  dmesg | more
 
 In order to speed the boot process, and to silence the speaking of the
 bootup messages, just press the keypad enter key.  This key is located
@@ -164,19 +211,19 @@ the speech with keypad enter, or use any of the Speakup review keys.
 Here are some basic Speakup review keys, and a short description of what
 they do.
 
-keypad 1 -- read previous character
-keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
-	the current character phonetically)
-keypad 3 -- read next character
-keypad 4 -- read previous word
-keypad 5 -- read current word (press twice rapidly to spell the current word)
-keypad 6 -- read next word
-keypad 7 -- read previous line
-keypad 8 -- read current line (press twice rapidly to hear how much the
-	text on the current line is indented)
-keypad 9 -- read next line
-keypad period -- speak current cursor position and announce current
-	virtual console
+| keypad 1 -- read previous character
+| keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
+	      the current character phonetically)
+| keypad 3 -- read next character
+| keypad 4 -- read previous word
+| keypad 5 -- read current word (press twice rapidly to spell the current word)
+| keypad 6 -- read next word
+| keypad 7 -- read previous line
+| keypad 8 -- read current line (press twice rapidly to hear how much the
+	      text on the current line is indented)
+| keypad 9 -- read next line
+| keypad period -- speak current cursor position and announce current
+		   virtual console
 
 It's also worth noting that the insert key on the keypad is mapped
 as the speakup key.  Instead of pressing and releasing this key, as you
@@ -190,16 +237,18 @@ Speakup will say, "You turned me off.", or "Hey, that's better."  When
 Speakup is turned off, no new text on the screen will be spoken.  You
 can still use the reading controls to review the screen however.
 
+
 3.  Using the Speakup Help System
+=================================
 
 In order to enter the Speakup help system, press and hold the speakup
-key (remember that this is the keypad insert key), and press the f1 key.
+key (remember that this is the keypad insert key), and press the `f1` key.
 You will hear the message:
 
 "Press space to leave help, cursor up or down to scroll, or a letter to
 go to commands in list."
 
-When you press the spacebar to leave the help system, you will hear:
+When you press the `spacebar` to leave the help system, you will hear:
 
 "Leaving help."
 
@@ -222,10 +271,10 @@ in this manual.
 
 You'll also notice that some commands have two keys assigned to them.
 This is because Speakup has a built in set of alternative key bindings
-for laptop users.  The alternate speakup key is the caps lock key.  You
-can press and hold the caps lock key, while pressing an alternate
+for laptop users.  The alternate speakup key is the `caps lock` key.  You
+can press and hold the `caps lock` key, while pressing an alternate
 speakup command key to activate the command.  On most laptops, the
-numeric keypad is defined as the keys in the j k l area of the keyboard.
+numeric keypad is defined as the keys in the `j k l` area of the keyboard.
 
 There is usually a function key which turns this keypad function on and
 off, and some other key which controls the numlock state.  Toggling the
@@ -236,198 +285,205 @@ because Speakup does not know whether it is running on a desktop or
 laptop.  So you may choose which set of Speakup keys to use.  Some
 system administrators may have chosen to compile Speakup for a desktop
 system without this set of alternate key bindings, but these details are
-beyond the scope of this manual.  To use the caps lock for its normal
-purpose, hold the shift key while toggling the caps lock on and off.  We
-should note here, that holding the caps lock key and pressing the z key
-will toggle the alternate j k l keypad on and off.
+beyond the scope of this manual.  To use the `caps lock` for its normal
+purpose, hold the shift key while toggling the `caps lock` on and off.
+
+.. note::
+
+  Holding the `caps lock` key and pressing the `z` key will toggle the
+  alternate `j k l` keypad on and off.
+
 
 4.  Keys and Their Assigned Commands
+====================================
 
 In this section, we'll go through a list of all the speakup keys and
 commands.  You can also get a list of commands and assigned keys from
 the help system.
 
-The following list was taken from the speakupmap.map file.  Key
+The following list was taken from the ``speakupmap.map`` file.  Key
 assignments are on the left of the equal sign, and the associated
 Speakup commands are on the right.  The designation "spk" means to press
-and hold the speakup key, a.k.a. keypad insert, a.k.a. caps lock, while
+and hold the speakup key, a.k.a. keypad insert, a.k.a. `caps lock`, while
 pressing the other specified key.
 
-spk key_f9 = punc_level_dec
-spk key_f10 = punc_level_inc
-spk key_f11 = reading_punc_dec
-spk key_f12 = reading_punc_inc
-spk key_1 = vol_dec
-spk key_2 =  vol_inc
-spk key_3 = pitch_dec
-spk key_4 = pitch_inc
-spk key_5 = rate_dec
-spk key_6 = rate_inc
-key_kpasterisk = toggle_cursoring
-spk key_kpasterisk = speakup_goto
-spk key_f1 = speakup_help
-spk key_f2 = set_win
-spk key_f3 = clear_win
-spk key_f4 = enable_win
-spk key_f5 = edit_some
-spk key_f6 = edit_most
-spk key_f7 = edit_delim
-spk key_f8 = edit_repeat
-shift spk key_f9 = edit_exnum
- key_kp7 = say_prev_line
-spk key_kp7 = left_edge
- key_kp8 = say_line
-double  key_kp8 = say_line_indent
-spk key_kp8 = say_from_top
- key_kp9 = say_next_line
-spk  key_kp9 = top_edge
- key_kpminus = speakup_parked
-spk key_kpminus = say_char_num
- key_kp4 = say_prev_word
-spk key_kp4 = say_from_left
- key_kp5 = say_word
-double key_kp5 = spell_word
-spk key_kp5 = spell_phonetic
- key_kp6 = say_next_word
-spk key_kp6 = say_to_right
- key_kpplus = say_screen
-spk key_kpplus = say_win
- key_kp1 = say_prev_char
-spk key_kp1 = right_edge
- key_kp2 = say_char
-spk key_kp2 = say_to_bottom
-double key_kp2 = say_phonetic_char
- key_kp3 = say_next_char
-spk  key_kp3 = bottom_edge
- key_kp0 = spk_key
- key_kpdot = say_position
-spk key_kpdot = say_attributes
-key_kpenter = speakup_quiet
-spk key_kpenter = speakup_off
-key_sysrq = speech_kill
- key_kpslash = speakup_cut
-spk key_kpslash = speakup_paste
-spk key_pageup = say_first_char
-spk key_pagedown = say_last_char
-key_capslock = spk_key
- spk key_z = spk_lock
-key_leftmeta = spk_key
-ctrl spk key_0 = speakup_goto
-spk key_u = say_prev_line
-spk key_i = say_line
-double spk key_i = say_line_indent
-spk key_o = say_next_line
-spk key_minus = speakup_parked
-shift spk key_minus = say_char_num
-spk key_j = say_prev_word
-spk key_k = say_word
-double spk key_k = spell_word
-spk key_l = say_next_word
-spk key_m = say_prev_char
-spk key_comma = say_char
-double spk key_comma = say_phonetic_char
-spk key_dot = say_next_char
-spk key_n = say_position
- ctrl spk key_m = left_edge
- ctrl spk key_y = top_edge
- ctrl spk key_dot = right_edge
-ctrl spk key_p = bottom_edge
-spk key_apostrophe = say_screen
-spk key_h = say_from_left
-spk key_y = say_from_top
-spk key_semicolon = say_to_right
-spk key_p = say_to_bottom
-spk key_slash = say_attributes
- spk key_enter = speakup_quiet
- ctrl  spk key_enter = speakup_off
- spk key_9 = speakup_cut
-spk key_8 = speakup_paste
-shift spk key_m = say_first_char
- ctrl spk key_semicolon = say_last_char
-spk key_r = read_all_doc
+| spk key_f9 = punc_level_dec
+| spk key_f10 = punc_level_inc
+| spk key_f11 = reading_punc_dec
+| spk key_f12 = reading_punc_inc
+| spk key_1 = vol_dec
+| spk key_2 =  vol_inc
+| spk key_3 = pitch_dec
+| spk key_4 = pitch_inc
+| spk key_5 = rate_dec
+| spk key_6 = rate_inc
+| key_kpasterisk = toggle_cursoring
+| spk key_kpasterisk = speakup_goto
+| spk key_f1 = speakup_help
+| spk key_f2 = set_win
+| spk key_f3 = clear_win
+| spk key_f4 = enable_win
+| spk key_f5 = edit_some
+| spk key_f6 = edit_most
+| spk key_f7 = edit_delim
+| spk key_f8 = edit_repeat
+| shift spk key_f9 = edit_exnum
+|  key_kp7 = say_prev_line
+| spk key_kp7 = left_edge
+|  key_kp8 = say_line
+| double  key_kp8 = say_line_indent
+| spk key_kp8 = say_from_top
+|  key_kp9 = say_next_line
+| spk  key_kp9 = top_edge
+|  key_kpminus = speakup_parked
+| spk key_kpminus = say_char_num
+|  key_kp4 = say_prev_word
+| spk key_kp4 = say_from_left
+|  key_kp5 = say_word
+| double key_kp5 = spell_word
+| spk key_kp5 = spell_phonetic
+|  key_kp6 = say_next_word
+| spk key_kp6 = say_to_right
+|  key_kpplus = say_screen
+| spk key_kpplus = say_win
+|  key_kp1 = say_prev_char
+| spk key_kp1 = right_edge
+|  key_kp2 = say_char
+| spk key_kp2 = say_to_bottom
+| double key_kp2 = say_phonetic_char
+|  key_kp3 = say_next_char
+| spk  key_kp3 = bottom_edge
+|  key_kp0 = spk_key
+|  key_kpdot = say_position
+| spk key_kpdot = say_attributes
+| key_kpenter = speakup_quiet
+| spk key_kpenter = speakup_off
+| key_sysrq = speech_kill
+|  key_kpslash = speakup_cut
+| spk key_kpslash = speakup_paste
+| spk key_pageup = say_first_char
+| spk key_pagedown = say_last_char
+| key_capslock = spk_key
+|  spk key_z = spk_lock
+| key_leftmeta = spk_key
+| ctrl spk key_0 = speakup_goto
+| spk key_u = say_prev_line
+| spk key_i = say_line
+| double spk key_i = say_line_indent
+| spk key_o = say_next_line
+| spk key_minus = speakup_parked
+| shift spk key_minus = say_char_num
+| spk key_j = say_prev_word
+| spk key_k = say_word
+| double spk key_k = spell_word
+| spk key_l = say_next_word
+| spk key_m = say_prev_char
+| spk key_comma = say_char
+| double spk key_comma = say_phonetic_char
+| spk key_dot = say_next_char
+| spk key_n = say_position
+|  ctrl spk key_m = left_edge
+|  ctrl spk key_y = top_edge
+|  ctrl spk key_dot = right_edge
+| ctrl spk key_p = bottom_edge
+| spk key_apostrophe = say_screen
+| spk key_h = say_from_left
+| spk key_y = say_from_top
+| spk key_semicolon = say_to_right
+| spk key_p = say_to_bottom
+| spk key_slash = say_attributes
+|  spk key_enter = speakup_quiet
+|  ctrl  spk key_enter = speakup_off
+|  spk key_9 = speakup_cut
+| spk key_8 = speakup_paste
+| shift spk key_m = say_first_char
+|  ctrl spk key_semicolon = say_last_char
+| spk key_r = read_all_doc
+
 
 5.  The Speakup Sys System
+==========================
 
 The Speakup screen reader also creates a speakup subdirectory as a part
 of the sys system.
 
-As a convenience, run as root
+As a convenience, run as root::
 
-ln -s /sys/accessibility/speakup /speakup
+  ln -s /sys/accessibility/speakup /speakup
 
 to directly access speakup parameters from /speakup.
-You can see these entries by typing the command:
+You can see these entries by typing the command::
 
-ls -1 /speakup/*
+  ls -1 /speakup/*
 
 If you issue the above ls command, you will get back something like
-this:
-
-/speakup/attrib_bleep
-/speakup/bell_pos
-/speakup/bleep_time
-/speakup/bleeps
-/speakup/cursor_time
-/speakup/delimiters
-/speakup/ex_num
-/speakup/key_echo
-/speakup/keymap
-/speakup/no_interrupt
-/speakup/punc_all
-/speakup/punc_level
-/speakup/punc_most
-/speakup/punc_some
-/speakup/reading_punc
-/speakup/repeats
-/speakup/say_control
-/speakup/say_word_ctl
-/speakup/silent
-/speakup/spell_delay
-/speakup/synth
-/speakup/synth_direct
-/speakup/version
-
-/speakup/i18n:
-announcements
-characters
-chartab
-colors
-ctl_keys
-formatted
-function_names
-key_names
-states
-
-/speakup/soft:
-caps_start
-caps_stop
-delay_time
-direct
-freq
-full_time
-jiffy_delta
-pitch
-inflection
-punct
-rate
-tone
-trigger_time
-voice
-vol
-
-Notice the two subdirectories of /speakup: /speakup/i18n and
-/speakup/soft.
-The i18n subdirectory is described in a later section.
-The files under /speakup/soft represent settings that are specific to the
+this::
+
+  /speakup/attrib_bleep
+  /speakup/bell_pos
+  /speakup/bleep_time
+  /speakup/bleeps
+  /speakup/cursor_time
+  /speakup/delimiters
+  /speakup/ex_num
+  /speakup/key_echo
+  /speakup/keymap
+  /speakup/no_interrupt
+  /speakup/punc_all
+  /speakup/punc_level
+  /speakup/punc_most
+  /speakup/punc_some
+  /speakup/reading_punc
+  /speakup/repeats
+  /speakup/say_control
+  /speakup/say_word_ctl
+  /speakup/silent
+  /speakup/spell_delay
+  /speakup/synth
+  /speakup/synth_direct
+  /speakup/version
+
+  /speakup/i18n:
+  announcements
+  characters
+  chartab
+  colors
+  ctl_keys
+  formatted
+  function_names
+  key_names
+  states
+
+  /speakup/soft:
+  caps_start
+  caps_stop
+  delay_time
+  direct
+  freq
+  full_time
+  jiffy_delta
+  pitch
+  inflection
+  punct
+  rate
+  tone
+  trigger_time
+  voice
+  vol
+
+Notice the two subdirectories of ``/speakup``: ``/speakup/i18n`` and
+``/speakup/soft``.
+The `i18n` subdirectory is described in a later section.
+The files under ``/speakup/soft`` represent settings that are specific to the
 driver for the software synthesizer.  If you use the LiteTalk, your
-synthesizer-specific settings would be found in /speakup/ltlk.  In other words,
-a subdirectory named /speakup/KWD is created to hold parameters specific
+synthesizer-specific settings would be found in ``/speakup/ltlk``.  In other words,
+a subdirectory named ``/speakup/KWD`` is created to hold parameters specific
 to the device whose keyword is KWD.
 These parameters include volume, rate, pitch, and others.
 
 In addition to using the Speakup hot keys to change such things as
 volume, pitch, and rate, you can also echo values to the appropriate
-entry in the /speakup directory.  This is very useful, since it
+entry in the ``/speakup`` directory.  This is very useful, since it
 lets you control Speakup parameters from within a script.  How you
 would write such scripts is somewhat beyond the scope of this manual,
 but I will include a couple of simple examples here to give you a
@@ -438,44 +494,48 @@ level and the reading punctuation level at the same time.  For
 simplicity, we'll call them punc0, punc1, punc2, and punc3.  The scripts
 might look something like this:
 
-#!/bin/bash
-# punc0
-# set punc and reading punc levels to 0
-echo 0 >/speakup/punc_level
-echo 0 >/speakup/reading_punc
-echo Punctuation level set to 0.
-
-#!/bin/bash
-# punc1
-# set punc and reading punc levels to 1
-echo 1 >/speakup/punc_level
-echo 1 >/speakup/reading_punc
-echo Punctuation level set to 1.
-
-#!/bin/bash
-# punc2
-# set punc and reading punc levels to 2
-echo 2 >/speakup/punc_level
-echo 2 >/speakup/reading_punc
-echo Punctuation level set to 2.
-
-#!/bin/bash
-# punc3
-# set punc and reading punc levels to 3
-echo 3 >/speakup/punc_level
-echo 3 >/speakup/reading_punc
-echo Punctuation level set to 3.
+.. code-block:: shell
+
+  #!/bin/bash
+  # punc0
+  # set punc and reading punc levels to 0
+  echo 0 >/speakup/punc_level
+  echo 0 >/speakup/reading_punc
+  echo Punctuation level set to 0.
+
+  #!/bin/bash
+  # punc1
+  # set punc and reading punc levels to 1
+  echo 1 >/speakup/punc_level
+  echo 1 >/speakup/reading_punc
+  echo Punctuation level set to 1.
+
+  #!/bin/bash
+  # punc2
+  # set punc and reading punc levels to 2
+  echo 2 >/speakup/punc_level
+  echo 2 >/speakup/reading_punc
+  echo Punctuation level set to 2.
+
+  #!/bin/bash
+  # punc3
+  # set punc and reading punc levels to 3
+  echo 3 >/speakup/punc_level
+  echo 3 >/speakup/reading_punc
+  echo Punctuation level set to 3.
 
 If you were to store these four small scripts in a directory in your
-path, perhaps /usr/local/bin, and set the permissions to 755 with the
-chmod command, then you could change the default reading punc and
+path, perhaps ``/usr/local/bin``, and set the permissions to 755 with the
+``chmod`` command, then you could change the default reading punc and
 punctuation levels at the same time by issuing just one command.  For
 example, if you were to execute the punc3 command at your shell prompt,
 then the reading punc and punc level would both get set to 3.
 
-I should note that the above scripts were written to work with bash, but
-regardless of which shell you use, you should be able to do something
-similar.
+.. note::
+
+  The above scripts were written to work with bash, but
+  regardless of which shell you use, you should be able to do something
+  similar.
 
 The Speakup sys system also has another interesting use.  You can echo
 Speakup parameters into the sys system in a script during system
@@ -489,29 +549,29 @@ system.  There are even some parameters that are read only, and cannot
 be written to at all.  For example, the version entry in the Speakup
 sys system is read only.  This is because there is no reason for a user
 to tamper with the version number which is reported by Speakup.  Doing
-an ls -l on /speakup/version will return this:
+an ``ls -l`` on ``/speakup/version`` will return this::
 
--r--r--r--    1 root     root            0 Mar 21 13:46 /speakup/version
+  -r--r--r--    1 root     root            0 Mar 21 13:46 /speakup/version
 
 As you can see, the version entry in the Speakup sys system is read
 only, is owned by root, and belongs to the root group.  Doing a cat of
-/speakup/version will display the Speakup version number, like
-this:
+``/speakup/version`` will display the Speakup version number, like
+this::
 
-cat /speakup/version
-Speakup v-2.00 CVS: Thu Oct 21 10:38:21 EDT 2004
-synth dtlk version 1.1
+  cat /speakup/version
+  Speakup v-2.00 CVS: Thu Oct 21 10:38:21 EDT 2004
+  synth dtlk version 1.1
 
 The display shows the Speakup version number, along with the version
 number of the driver for the current synthesizer.
 
 Looking at entries in the Speakup sys system can be useful in many
 ways.  For example, you might wish to know what level your volume is set
-at.  You could type:
+at.  You could type::
 
-cat /speakup/KWD/vol
-# Replace KWD with the keyword for your synthesizer, E.G., ltlk for LiteTalk.
-5
+  cat /speakup/KWD/vol
+  # Replace KWD with the keyword for your synthesizer, E.G., ltlk for LiteTalk.
+  5
 
 The number five which comes back is the level at which the synthesizer
 volume is set at.
@@ -524,12 +584,14 @@ Vol for controlling volume, pitch for pitch, inflection for pitch range, rate
 for controlling speaking rate, etc.  If you find one you aren't sure about, you
 can post a query on the Speakup list.
 
+
 6.  Changing Synthesizers
+=========================
 
 It is possible to change to a different synthesizer while speakup is
 running.  In other words, it is not necessary to reboot the system
 in order to use a different synthesizer.  You can simply echo the
-synthesizer keyword to the /speakup/synth sys entry.
+synthesizer keyword to the ``/speakup/synth`` sys entry.
 Depending on your situation, you may wish to echo none to the synth
 sys entry, to disable speech while one synthesizer is disconnected and
 a second one is connected in its place.  Then echo the keyword for the
@@ -537,7 +599,9 @@ new synthesizer into the synth sys entry in order to start speech
 with the newly connected synthesizer.  See the list of synthesizer
 keywords in section 1 to find the keyword which matches your synth.
 
+
 7.  Loading modules
+===================
 
 As mentioned earlier, Speakup can either be completely compiled into the
 kernel, with the exception of the help module, or it can be compiled as
@@ -555,51 +619,55 @@ modprobe command to load Speakup.  You do this by loading the module for
 the synthesizer driver you wish to use.  The driver modules are all
 named speakup_<keyword>, where <keyword> is the keyword for the
 synthesizer you want.  So, in order to load the driver for the DecTalk
-Express, you would type the following command:
+Express, you would type the following command::
 
-modprobe speakup_dectlk
+  modprobe speakup_dectlk
 
 Issuing this command would load the DecTalk Express driver and all other
 related Speakup modules necessary to get Speakup up and running.
 
 To completely unload Speakup, again presuming that it is entirely built
-as modules, you would give the command:
+as modules, you would give the command::
 
-modprobe -r speakup_dectlk
+  modprobe -r speakup_dectlk
 
 The above command assumes you were running a DecTalk Express.  If you
 were using a different synth, then you would substitute its keyword in
-place of dectlk.
+place of `dectlk`.
 
 If you have multiple drivers loaded, you need to unload all of them, in
 order to completely unload Speakup.
 For example, if you have loaded both the dectlk and ltlk drivers, use the
-command:
-modprobe -r speakup_dectlk speakup_ltlk
+command::
+
+  modprobe -r speakup_dectlk speakup_ltlk
 
 You cannot unload the driver for software synthesizers when a user-space
-daemon is using /dev/softsynth.  First, kill the daemon.  Next, remove
-the driver with the command:
-modprobe -r speakup_soft
+daemon is using ``/dev/softsynth``.  First, kill the daemon.  Next, remove
+the driver with the command::
+
+  modprobe -r speakup_soft
 
 Now, suppose we have a situation where the main Speakup component
 is built into the kernel, and some or all of the drivers are built as
 modules.  Since the main part of Speakup is compiled into the kernel, a
 partial Speakup sys system has been created which we can take advantage
 of by simply echoing the synthesizer keyword into the
-/speakup/synth sys entry.  This will cause the kernel to
+``/speakup/synth`` sys entry.  This will cause the kernel to
 automatically load the appropriate driver module, and start Speakup
 talking.  To switch to another synth, just echo a new keyword to the
 synth sys entry.  For example, to load the DoubleTalk LT driver,
-you would type:
+you would type::
 
-echo ltlk >/speakup/synth
+  echo ltlk >/speakup/synth
 
-You can use the modprobe -r command to unload driver modules, regardless
+You can use the ``modprobe -r`` command to unload driver modules, regardless
 of whether the main part of Speakup has been built into the kernel or
 not.
 
+
 8.  Using Software Synthesizers
+===============================
 
 Using a software synthesizer requires that some other software be
 installed and running on your system.  For this reason, software
@@ -607,34 +675,36 @@ synthesizers are not available for use at bootup, or during a system
 installation process.
 There are two freely-available solutions for software speech: Espeakup and
 Speech Dispatcher.
-These are described in subsections 8.1 and 8.2, respectively.
+These are described in subsections `8.1. Espeakup`_ and
+`8.2. Speech Dispatcher`_, respectively.
 
-During the rest of this section, we assume that speakup_soft is either
+During the rest of this section, we assume that `speakup_soft` is either
 built in to your kernel, or loaded as a module.
 
 If your system does not have udev installed , before you can use a
-software synthesizer, you must have created the /dev/softsynth device.
-If you have not already done so, issue the following commands as root:
+software synthesizer, you must have created the ``/dev/softsynth`` device.
+If you have not already done so, issue the following commands as root::
 
-cd /dev
-mknod softsynth c 10 26
+  cd /dev
+  mknod softsynth c 10 26
 
-While we are at it, we might just as well create the /dev/synth device,
+While we are at it, we might just as well create the ``/dev/synth`` device,
 which can be used to let user space programs send information to your
-synthesizer.  To create /dev/synth, change to the /dev directory, and
-issue the following command as root:
+synthesizer.  To create ``/dev/synth``, change to the ``/dev`` directory, and
+issue the following command as root::
 
-mknod synth c 10 25
+  mknod synth c 10 25
 
 of both.
 
 8.1. Espeakup
+-------------
 
 Espeakup is a connector between Speakup and the eSpeak software synthesizer.
 Espeakup may already be available as a package for your distribution
 of Linux.  If it is not packaged, you need to install it manually.
-You can find it in the contrib/ subdirectory of the Speakup sources.
-The filename is espeakup-$VERSION.tar.bz2, where $VERSION
+You can find it in the ``contrib/`` subdirectory of the Speakup sources.
+The filename is ``espeakup-$VERSION.tar.bz2``, where ``$VERSION``
 depends on the current release of Espeakup.  The Speakup 3.1.2 source
 ships with version 0.71 of Espeakup.
 The README file included with the Espeakup sources describes the process
@@ -643,31 +713,37 @@ of manual installation.
 Assuming that Espeakup is installed, either by the user or by the distributor,
 follow these steps to use it.
 
-Tell Speakup to use the "soft driver:
-echo soft > /speakup/synth
+Tell Speakup to use the "soft driver::
+
+  echo soft > /speakup/synth
 
 Finally, start the espeakup program.  There are two ways to do it.
 Both require root privileges.
 
 If Espeakup was installed as a package for your Linux distribution,
 you probably have a distribution-specific script that controls the operation
-of the daemon.  Look for a file named espeakup under /etc/init.d or
-/etc/rc.d.  Execute the following command with root privileges:
-/etc/init.d/espeakup start
-Replace init.d with rc.d, if your distribution uses scripts located under
-/etc/rc.d.
+of the daemon.  Look for a file named espeakup under ``/etc/init.d`` or
+``/etc/rc.d``.  Execute the following command with root privileges::
+
+  /etc/init.d/espeakup start
+
+Replace ``init.d`` with ``rc.d``, if your distribution uses scripts located
+under ``/etc/rc.d``.
 Your distribution will also have a procedure for starting daemons at
 boot-time, so it is possible to have software speech as soon as user-space
 daemons are started by the bootup scripts.
 These procedures are not described in this document.
 
-If you built Espeakup manually, the "make install" step placed the binary
-under /usr/bin.
-Run the following command as root:
-/usr/bin/espeakup
+If you built Espeakup manually, the ``make install`` step placed the binary
+under ``/usr/bin``.
+Run the following command as root::
+
+  /usr/bin/espeakup
+
 Espeakup should start speaking.
 
 8.2. Speech Dispatcher
+----------------------
 
 For this option, you must have a package called
 Speech Dispatcher running on your system, and it must be configured to
@@ -692,53 +768,57 @@ compiled and installed speechd-up, you are almost ready to begin using
 your software synthesizer.
 
 Now you can begin using your software synthesizer.  In order to do so,
-echo the soft keyword to the synth sys entry like this:
+echo the soft keyword to the synth sys entry like this::
 
-echo soft >/speakup/synth
+  echo soft >/speakup/synth
 
-Next run the speechd_up command like this:
+Next run the speechd_up command like this::
 
-speechd_up &
+  speechd_up &
 
 Your synth should now start talking, and you should be able to adjust
 the pitch, rate, etc.
 
+
 9.  Using The DecTalk PC Card
+=============================
 
 The DecTalk PC card is an ISA card that is inserted into one of the ISA
 slots in your computer.  It requires that the DecTalk PC software be
 installed on your computer, and that the software be loaded onto the
 Dectalk PC card before it can be used.
 
-You can get the dec_pc.tgz file from the linux-speakup.org site.  The
-dec_pc.tgz file is in the ~ftp/pub/linux/speakup directory.
+You can get the ``dec_pc.tgz`` file from the linux-speakup.org site.  The
+``dec_pc.tgz`` file is in the ``~ftp/pub/linux/speakup`` directory.
 
-After you have downloaded the dec_pc.tgz file, untar it in your home
-directory, and read the Readme file in the newly created dec_pc
+After you have downloaded the ``dec_pc.tgz`` file, untar it in your home
+directory, and read the Readme file in the newly created ``dec_pc``
 directory.
 
-The easiest way to get the software working is to copy the entire dec_pc
-directory into /user/local/lib.  To do this, su to root in your home
-directory, and issue the command:
+The easiest way to get the software working is to copy the entire ``dec_pc``
+directory into ``/user/local/lib``.  To do this, su to root in your home
+directory, and issue the command::
 
-cp dec_pc /usr/local/lib
+  cp dec_pc /usr/local/lib
 
 You will need to copy the dtload command from the dec_pc directory to a
-directory in your path.  Either /usr/bin or /usr/local/bin is a good
-choice.
+directory in your path. Either ``/usr/bin`` or ``/usr/local/bin`` is a
+good choice.
 
 You can now run the dtload command in order to load the DecTalk PC
-software onto the card.  After you have done this, echo the decpc
-keyword to the synth entry in the sys system like this:
+software onto the card.  After you have done this, ``echo`` the decpc
+keyword to the synth entry in the sys system like this::
 
-echo decpc >/speakup/synth
+  echo decpc >/speakup/synth
 
 Your DecTalk PC should start talking, and then you can adjust the pitch,
 rate, volume, voice, etc.  The voice entry in the Speakup sys system
 will accept a number from 0 through 7 for the DecTalk PC synthesizer,
 which will give you access to some of the DecTalk voices.
 
+
 10.  Using Cursor Tracking
+==========================
 
 In Speakup version 2.0 and later, cursor tracking is turned on by
 default.  This means that when you are using an editor, Speakup will
@@ -781,8 +861,8 @@ Speakup speaks both your shell prompt and the current entry from the
 command history.  You may not want to hear the prompt repeated
 each time you move, so you can silence it by specifying a window.  Find
 the last line of text on the screen.  Clear the current window by pressing
-the key combination speakup f3.  Use the review cursor to find the first
-character that follows your shell prompt.  Press speakup + f2 twice, to
+the key combination speakup `f3`.  Use the review cursor to find the first
+character that follows your shell prompt.  Press speakup + `f2` twice, to
 define a one-line window.  The boundaries of the window are the
 character following the shell prompt and the end of the line.  Now, cycle
 through the cursor tracking modes using keypad asterisk, until Speakup
@@ -794,7 +874,9 @@ lynx web browser.  You definitely want to turn cursor tracking off when
 you are using the alsamixer application.  Otherwise, you won't be able
 to hear your mixer settings while you are using the arrow keys.
 
+
 11.  Cut and Paste
+==================
 
 One of Speakup's more useful features is the ability to cut and paste
 text on the screen.  This means that you can capture information from a
@@ -847,9 +929,11 @@ cut, mark it with the keypad slash key, then position the reading cursor
 at the bottom right corner of the region to be cut, and cut it with the
 keypad slash key.
 
+
 12.  Changing the Pronunciation of Characters
+=============================================
 
-Through the /speakup/i18n/characters sys entry, Speakup gives you the
+Through the ``/speakup/i18n/characters`` sys entry, Speakup gives you the
 ability to change how Speakup pronounces a given character.  You could,
 for example, change how some punctuation characters are spoken.  You can
 even change how Speakup will pronounce certain letters.
@@ -859,19 +943,19 @@ character.  The author of Speakup, Kirk Reiser, is Canadian, and thus
 believes that the z should be pronounced zed.  If you are an American,
 you might wish to use the zee pronunciation instead of zed.  You can
 change the pronunciation of both the upper and lower case z with the
-following two commands:
+following two commands::
 
-echo 90 zee >/speakup/characters
-echo 122 zee >/speakup/characters
+  echo 90 zee >/speakup/characters
+  echo 122 zee >/speakup/characters
 
 Let's examine the parts of the two previous commands.  They are issued
 at the shell prompt, and could be placed in a startup script.
 
 The word echo tells the shell that you want to have it display the
 string of characters that follow the word echo.  If you were to just
-type:
+type::
 
-echo hello.
+  echo hello.
 
 You would get the word hello printed on your screen as soon as you
 pressed the enter key.  In this case, we are echoing strings that we
@@ -883,22 +967,24 @@ values for the upper and lower case z, the characters we wish to change.
 The string zee is the pronunciation that we want Speakup to use for the
 upper and lower case z.
 
-The > symbol redirects the output of the echo command to a file, just
+The ``>`` symbol redirects the output of the echo command to a file, just
 like in DOS, or at the Windows command prompt.
 
-And finally, /speakup/i18n/characters is the file entry in the sys system
+And finally, ``/speakup/i18n/characters`` is the file entry in the sys system
 where we want the output to be directed.  Speakup looks at the numeric
 value of the character we want to change, and inserts the pronunciation
 string into an internal table.
 
-You can look at the whole table with the following command:
+You can look at the whole table with the following command::
 
-cat /speakup/i18n/characters
+  cat /speakup/i18n/characters
 
 Speakup will then print out the entire character pronunciation table.  I
 won't display it here, but leave you to look at it at your convenience.
 
+
 13.  Mapping Keys
+=================
 
 Speakup has the capability of allowing you to assign or "map" keys to
 internal Speakup commands.  This section necessarily assumes you have a
@@ -908,15 +994,15 @@ manual.  For this information, visit the Speakup web site at
 http://linux-speakup.org/.  The reason you'll need the kernel source
 tree patched with Speakup is that the genmap utility you'll need for
 processing keymaps is in the
-/usr/src/linux-<version_number>/drivers/char/speakup directory.  The
-<version_number> in the above directory path is the version number of
+``/usr/src/linux-<version_number>/drivers/char/speakup`` directory.  The
+``<version_number>`` in the above directory path is the version number of
 the Linux source tree you are working with.
 
 So ok, you've gone off and gotten your kernel source tree, and patched
 and configured it.  Now you can start manipulating keymaps.
 
 You can either use the
-/usr/src/linux-<version_number>/drivers/char/speakup/speakupmap.map file
+``/usr/src/linux-<version_number>/drivers/char/speakup/speakupmap.map`` file
 included with the Speakup source, or you can cut and paste the copy in
 section 4 into a separate file.  If you use the one in the Speakup
 source tree, make sure you make a backup of it before you start making
@@ -924,48 +1010,52 @@ changes.  You have been warned!
 
 Suppose that you want to swap the key assignments for the Speakup
 say_last_char and the Speakup say_first_char commands.  The
-speakupmap.map lists the key mappings for these two commands as follows:
+speakupmap.map lists the key mappings for these two commands as follows::
 
-spk key_pageup = say_first_char
-spk key_pagedown = say_last_char
+  spk key_pageup = say_first_char
+  spk key_pagedown = say_last_char
 
 You can edit your copy of the speakupmap.map file and swap the command
-names on the right side of the = (equals) sign.  You did make a backup,
-right?  The new keymap lines would look like this:
+names on the right side of the ``=`` (equals) sign.  You did make a backup,
+right?  The new keymap lines would look like this::
 
-spk key_pageup = say_last_char
-spk key_pagedown = say_first_char
+  spk key_pageup = say_last_char
+  spk key_pagedown = say_first_char
 
 After you edit your copy of the speakupmap.map file, save it under a new
 file name, perhaps newmap.map.  Then exit your editor and return to the
 shell prompt.
 
 You are now ready to load your keymap with your swapped key assignments.
- Assuming that you saved your new keymap as the file newmap.map, you
-would load your keymap into the sys system like this:
+Assuming that you saved your new keymap as the file newmap.map, you
+would load your keymap into the sys system like this::
 
-/usr/src/linux-<version_number>/drivers/char/speakup/genmap newmap.map
->/speakup/keymap
+  /usr/src/linux-<version_number>/drivers/char/speakup/genmap newmap.map >/speakup/keymap
 
-Remember to substitute your kernel version number for the
-<version_number> in the above command.  Also note that although the
-above command wrapped onto two lines in this document, you should type
-it all on one line.
+
+.. note::
+
+  Remember to substitute your kernel version number for the
+  ``<version_number>`` in the above command.
 
 Your say first and say last characters should now be swapped.  Pressing
 speakup pagedown should read you the first non-whitespace character on
 the line your reading cursor is in, and pressing speakup pageup should
 read you the last character on the line your reading cursor is in.
 
-You should note that these new mappings will only stay in effect until
-you reboot, or until you load another keymap.
+.. note::
+
+  These new mappings will only stay in effect until you reboot,
+  or until you load another keymap.
 
 One final warning.  If you try to load a partial map, you will quickly
 find that all the mappings you didn't include in your file got deleted
 from the working map.  Be extremely careful, and always make a backup!
 You have been warned!
 
+
 14.  Internationalizing Speakup
+===============================
 
 Speakup indicates various conditions to the user by speaking messages.
 For instance, when you move to the left edge of the screen with the
@@ -974,101 +1064,108 @@ Prior to version 3.1.0 of Speakup, all of these messages were in English,
 and they could not be changed.  If you used a non-English synthesizer,
 you still heard English messages, such as "left" and "cursoring on."
 In version 3.1.0 or higher, one may load translations for the various
-messages via the /sys filesystem.
+messages via the ``/sys`` filesystem.
 
-The directory /speakup/i18n contains several collections of messages.
+The directory ``/speakup/i18n`` contains several collections of messages.
 Each group of messages is stored in its own file.
 The following section lists all of these files, along with a brief description
 of each.
 
 14.1.  Files Under the i18n Subdirectory
+----------------------------------------
+
+announcements
+  This file contains various general announcements, most of which cannot
+  be categorized.  You will find messages such as "You killed Speakup",
+  "I'm alive", "leaving help", "parked", "unparked", and others.
+  You will also find the names of the screen edges and cursor tracking modes
+  here.
 
-* announcements:
-This file contains various general announcements, most of which cannot
-be categorized.  You will find messages such as "You killed Speakup",
-"I'm alive", "leaving help", "parked", "unparked", and others.
-You will also find the names of the screen edges and cursor tracking modes
-here.
-
-* characters:
-See section 12 for a description of this file.
-
-* chartab:
-See section 12.  Unlike the rest of the files in the i18n subdirectory,
-this one does not contain messages to be spoken.
-
-* colors:
-When you use the "say attributes" function, Speakup says the name of the
-foreground and background colors.  These names come from the i18n/colors
-file.
-
-* ctl_keys:
-Here, you will find names of control keys.  These are used with Speakup's
-say_control feature.
-
-* formatted:
-This group of messages contains embedded formatting codes, to specify
-the type and width of displayed data.  If you change these, you must
-preserve all of the formatting codes, and they must appear in the order
-used by the default messages.
-
-* function_names:
-Here, you will find a list of names for Speakup functions.  These are used
-by the help system.  For example, suppose that you have activated help mode,
-and you pressed keypad 3.  Speakup says:
-"keypad 3 is character, say next."
-The message "character, say next" names a Speakup function, and it
-comes from this function_names file.
-
-* key_names:
-Again, key_names is used by Speakup's help system.  In the previous
-example, Speakup said that you pressed "keypad 3."
-This name came from the key_names file.
-
-* states:
-This file contains names for key states.
-Again, these are part of the help system.  For instance, if you had pressed
-speakup + keypad 3, you would hear:
-"speakup keypad 3 is go to bottom edge."
-The speakup key is depressed, so the name of the key state is speakup.
-This part of the message comes from the states collection.
-
-14.2.  Changing language
-
-14.2.1. Loading Your Own Messages
+characters
+  See `12.  Changing the Pronunciation of Characters`_ for a description
+  of this file.
+
+chartab
+  See `12.  Changing the Pronunciation of Characters`_.  Unlike the rest
+  of the files in the i18n subdirectory, this one does not contain messages
+  to be spoken.
+
+colors
+  When you use the "say attributes" function, Speakup says the name of the
+  foreground and background colors.  These names come from the i18n/colors
+  file.
+
+ctl_keys
+  Here, you will find names of control keys.  These are used with Speakup's
+  say_control feature.
+
+formatted
+  This group of messages contains embedded formatting codes, to specify
+  the type and width of displayed data.  If you change these, you must
+  preserve all of the formatting codes, and they must appear in the order
+  used by the default messages.
+
+function_names
+  Here, you will find a list of names for Speakup functions.  These are used
+  by the help system.  For example, suppose that you have activated help mode,
+  and you pressed keypad 3.  Speakup says:
+  "keypad 3 is character, say next."
+  The message "character, say next" names a Speakup function, and it
+  comes from this function_names file.
+
+key_names
+  Again, key_names is used by Speakup's help system.  In the previous
+  example, Speakup said that you pressed "keypad 3."
+  This name came from the key_names file.
+
+states
+  This file contains names for key states.
+  Again, these are part of the help system.  For instance, if you had pressed
+  speakup + keypad 3, you would hear:
+  "speakup keypad 3 is go to bottom edge."
+  The speakup key is depressed, so the name of the key state is speakup.
+  This part of the message comes from the states collection.
+
+14.2.1.  Loading Your Own Messages
+----------------------------------
 
 The files under the i18n subdirectory all follow the same format.
 They consist of lines, with one message per line.
 Each message is represented by a number, followed by the text of the message.
 The number is the position of the message in the given collection.
-For example, if you view the file /speakup/i18n/colors, you will see the
-following list:
-
-0	black
-1	blue
-2	green
-3	cyan
-4	red
-5	magenta
-6	yellow
-7	white
-8	grey
+For example, if you view the file ``/speakup/i18n/colors``, you will see the
+following list::
+
+  0 - black
+  1 - blue
+  2 - green
+  3 - cyan
+  4 - red
+  5 - magenta
+  6 - yellow
+  7 - white
+  8 - grey
 
 You can change one message, or you can change a whole group.
 To load a whole collection of messages from a new source, simply use
-the cp command:
-cp ~/my_colors /speakup/i18n/colors
+the cp command::
+
+  cp ~/my_colors /speakup/i18n/colors
+
 You can change an individual message with the echo command,
 as shown in the following example.
 
 The Spanish name for the color blue is azul.
 Looking at the colors file, we see that the name "blue" is at position 1
-within the colors group.  Let's change blue to azul:
-echo '1 azul' > /speakup/i18n/colors
+within the colors group.  Let's change blue to azul::
+
+  echo '1 azul' > /speakup/i18n/colors
+
 The next time that Speakup says message 1 from the colors group, it will
 say "azul", rather than "blue."
 
 14.2.2. Choose a language
+-------------------------
 
 In the future, translations into various languages will be made available,
 and most users will just load the files necessary for their language. So far,
@@ -1078,11 +1175,11 @@ French is only available after you are logged in.
 
 Canadian English is the default language. To toggle another language,
 download the source of Speakup and untar it in your home directory. The
-following command should let you do this:
+following command should let you do this::
 
-tar xvjf speakup-<version>.tar.bz2
+  tar xvjf speakup-<version>.tar.bz2
 
-where <version> is the version number of the application.
+where ``<version>`` is the version number of the application.
 
 Next, change to the newly created directory, then into the tools/ directory, and
 run the script speakup_setlocale. You are asked the language that you want to
@@ -1098,38 +1195,41 @@ You will have to repeat these steps for any change of locale, i.e. if you wish
 change the speakup's language or charset (iso-8859-15 ou UTF-8).
 
 If you wish store the settings, note that at your next login, you will need to
-do:
+do::
 
-speakup load
+  speakup load
 
 Alternatively, you can add the above line to your file
-~/.bashrc or ~/.bash_profile.
+``~/.bashrc`` or ``~/.bash_profile``.
 
 If your system administrator ran himself the script, all the users will be able
 to change from English to the language choosed by root and do directly
-speakupconf load (or add this to the ~/.bashrc or
-~/.bash_profile file). If there are several languages to handle, the
+speakupconf load (or add this to the ``~/.bashrc`` or
+``~/.bash_profile`` file). If there are several languages to handle, the
 administrator (or every user) will have to run the first steps until speakupconf
 save, choosing the appropriate language, in every user's home directory. Every
 user will then be able to do speakupconf load, Speakup will load his own settings.
 
 14.3.  No Support for Non-Western-European Languages
+----------------------------------------------------
 
 As of the current release, Speakup only supports Western European languages.
 Support for the extended characters used by languages outside of the Western
 European family of languages is a work in progress.
 
+
 15.  Using Speakup's Windowing Capability
+=========================================
 
 Speakup has the capability of defining and manipulating windows on the
 screen.  Speakup uses the term "Window", to mean a user defined area of
 the screen.  The key strokes for defining and manipulating Speakup
-windows are as follows:
+windows are as follows::
 
-speakup + f2 -- Set the bounds of the window.
-Speakup + f3 -- clear the current window definition.
-speakup + f4 -- Toggle window silence on and off.
-speakup + keypad plus -- Say the currently defined window.
+  speakup + f2 -- Set the bounds of the window.
+  Speakup + f3 -- clear the current window definition.
+  speakup + f4 -- Toggle window silence on and off.
+  speakup + keypad plus -- Say the currently defined window.
 
 These capabilities are useful for tracking a certain part of the screen
 without rereading the whole screen, or for silencing a part of the
@@ -1141,55 +1241,64 @@ windows automatically defined for specific applications.
 
 In order to define a window, use the review keys to move your reading
 cursor to the beginning of the area you want to define.  Then press
-speakup + f2.  Speakup will tell you that the window starts at the
+speakup + `f2`.  Speakup will tell you that the window starts at the
 indicated row and column position.  Then move the reading cursor to the
-end of the area to be defined as a window, and press speakup + f2 again.
- If there is more than one line in the window, Speakup will tell you
+end of the area to be defined as a window, and press speakup + `f2` again.
+If there is more than one line in the window, Speakup will tell you
 that the window ends at the indicated row and column position.  If there
 is only one line in the window, then Speakup will tell you that the
 window is the specified line on the screen.  If you are only defining a
-one line window, you can just press speakup + f2 twice after placing the
+one line window, you can just press speakup + `f2` twice after placing the
 reading cursor on the line you want to define as a window.  It is not
 necessary to position the reading cursor at the end of the line in order
 to define the whole line as a window.
 
+
 16.  Tools for Controlling Speakup
+==================================
 
 The speakup distribution includes extra tools (in the tools directory)
 which were written to make speakup easier to use.  This section will
 briefly describe the use of these tools.
 
 16.1.  Speakupconf
+------------------
 
 speakupconf began life as a contribution from Steve Holmes, a member of
 the speakup community.  We would like to thank him for his work on the
 early versions of this project.
 
 This script may be installed as part of your linux distribution, but if
-it isn't, the recommended places to put it are /usr/local/bin or
-/usr/bin.  This script can be run by any user, so it does not require
+it isn't, the recommended places to put it are ``/usr/local/bin`` or
+``/usr/bin``.  This script can be run by any user, so it does not require
 root privileges.
 
 Speakupconf allows you to save and load your Speakup settings.  It works
-by reading and writing the /sys files described above.
+by reading and writing the ``/sys`` files described above.
 
 The directory that speakupconf uses to store your settings depends on
 whether it is run from the root account.  If you execute speakupconf as
-root, it uses the directory /etc/speakup.  Otherwise, it uses the directory
-~/.speakup, where ~ is your home directory.
+root, it uses the directory ``/etc/speakup``.  Otherwise, it uses the directory
+``~/.speakup``, where ``~`` is your home directory.
 Anyone who needs to use Speakup from your console can load his own custom
 settings with this script.
 
 speakupconf takes one required argument: load or save.
-Use the command
-speakupconf save
-to save your Speakup settings, and
-speakupconf load
+Use the command::
+
+  speakupconf save
+
+to save your Speakup settings, and::
+
+  speakupconf load
+
 to load them into Speakup.
+
 A second argument may be specified to use an alternate directory to
 load or save the speakup parameters.
 
 16.2.  Talkwith
+---------------
 
 Charles Hallenbeck, another member of the speakup community, wrote the
 initial versions of this script, and we would also like to thank him for
@@ -1197,7 +1306,7 @@ his work on it.
 
 This script needs root privileges to run, so if it is not installed as
 part of your linux distribution, the recommended places to install it
-are /usr/local/sbin or /usr/sbin.
+are ``/usr/local/sbin`` or ``/usr/sbin``.
 
 Talkwith allows you to switch synthesizers on the fly.  It takes a synthesizer
 name as an argument.  For instance,
@@ -1208,25 +1317,36 @@ use.  There are two possible choices:
 spd and espeakup.  spd is an abbreviation for speechd-up.
 If you wish to use espeakup for software synthesis, give the command
 talkwith soft espeakup
-To use speechd-up, type:
-talkwith soft spd
+To use speechd-up, type::
+
+  talkwith soft spd
+
 Any arguments that follow the name of the daemon are passed to the daemon
-when it is invoked.  For instance:
-talkwith espeakup --default-voice=fr
+when it is invoked.  For instance::
+
+  talkwith espeakup --default-voice=fr
+
 causes espeakup to use the French voice.
-Note that talkwith must always be executed with root privileges.
+
+.. note::
+
+  Talkwith must always be executed with root privileges.
 
 Talkwith does not attempt to load your settings after the new
 synthesizer is activated.  You can use speakupconf to load your settings
 if desired.
 
+
+Document License
+================
+
                 GNU Free Documentation License
                   Version 1.2, November 2002
 
 
- Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
+Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
+Everyone is permitted to copy and distribute verbatim copies
+of this license document, but changing it is not allowed.
 
 
 0. PREAMBLE
-- 
2.20.1

