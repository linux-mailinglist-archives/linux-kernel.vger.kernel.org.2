Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1F39A3E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhFCPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhFCPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:04:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F90C06174A;
        Thu,  3 Jun 2021 08:02:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w9so3298002qvi.13;
        Thu, 03 Jun 2021 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=PTICGFhu1GQKfMtrG6PgDSnV6IDAtt/ZZVdVtMyLbx0=;
        b=h6JKSzzOrHQNR+slWsGPxcNagvD5ZsO/H2YKOasPdoi7LET7Mu1G8m96nhgdlS2wwu
         FNU/JkK5poF/jwjDRNf4MbQmWrIEnxf6CLtQJmy/CkjqkJLQAJaBipSo/csPOhUyVn0D
         hIpeAmCPbyR2HPy/vODH34LH77Afx6raiTn0oBywRgYCX6UZGFkNAPKnrkHbfBHuoDIQ
         8ZJdyVCxodxE76309sULyJmePCn4EVmcyf0jbT/+cKsMH96cvUy4Q3Y+JWa16AqVhSmP
         wbtdFewEuyeXL06JKnjXHvZ/g60yG9fyUUyCz9tSudIsDpe11Ytsoa+/Otpdg+9YX0Xo
         +gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=PTICGFhu1GQKfMtrG6PgDSnV6IDAtt/ZZVdVtMyLbx0=;
        b=AEqNtSjzkFPt+spjCwoPk52ya6x58Efa704c7LjH47lRCwn4ekxPI/6AxElVHtxLg3
         Z1DgvYn4i2q9yB5LLnDhANcD5tWo5jzzMImqWs8QqxKZpmPNKC3vd6nMuarTx1HXEKlW
         01t9noibm5RYfSos2xiiizSVJaLO6w2QUPDIWBJxxlRy6wqELXEPul1ded7thLKkFifO
         4Zz8kiakqQ+o0k/TjrGT93bEbWgmdR63o3jAis8kLvN3sCuFoJy8H+C+RhMA+IFhUKUG
         baeGd/NIjLKbwj2dqMWM4sq+3+pnWoLQp+rmOwKB/XQX5R12CXAF+V+zbLEVuVMfQj+A
         tiCQ==
X-Gm-Message-State: AOAM532x/W8TL59gi26jV+X2ELGgN4wVZTl71Un38zGLruzzXkAmo3dw
        mmTsVeGZK8t3Ri8CXN7SLhyodS/F+1DQbA==
X-Google-Smtp-Source: ABdhPJyGh6zv46EbxWnkINGsc7X34fMNHJy35HfXUUpMY97xGeWD+1q3agq30WDstmmmQBVdqEvZVw==
X-Received: by 2002:ad4:5c44:: with SMTP id a4mr290387qva.22.1622732573562;
        Thu, 03 Jun 2021 08:02:53 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id h12sm2007889qkj.52.2021.06.03.08.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 08:02:52 -0700 (PDT)
Subject: Re: [PATCH v3] docs: Convert the Speakup guide to rst
To:     corbet@lwn.net, samuel.thibault@ens-lyon.org,
        jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com
Cc:     speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603145953.10982-1-igormtorrente@gmail.com>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <96641155-0254-81a9-3e20-477ca367b6ee@gmail.com>
Date:   Thu, 3 Jun 2021 12:02:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210603145953.10982-1-igormtorrente@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------8F2755065F9007E1085D124E"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F2755065F9007E1085D124E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

He everybody,

On 6/3/21 11:59 AM, Igor Matheus Andrade Torrente wrote:
> Modify some parts of the text and add the necessary formatting to leverage
> the rst features. Including links, code-blocks, bullet lists, etc.
> 
> Also, add a table of contents at the beginning and changes the license.
> 
> This change helps integrate this documentation to the rest of the rst
> documentation.
> 
> 
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
> 
> v2: Rebase the patch to cover the commit cae2181b498fe
> 
> v3: Adds some Jani and Samuel's suggestion, and changes the licensing.
> 
>      And, therefore, this patch should only be accepted when we have
>      all acks from the copyright owners.
> 
>      Current status:
> 
>      Gene Collins <gene@collinsnet.net> - Pending
>      Samuel Thibault <samuel.thibault@ens-lyon.org> - ACK[1][2]
>      Christopher Brannon <chris@the-brannons.com> - ACK[3]
>      William Hubbs <w.d.hubbs@gmail.com> - Pending
>      Steve Holmes <steve.holmes88@gmail.com> - Pending
> 
>      I will send a reply to this patch with all the files, so the Speakup
>      community can evaluate the changes and compare them against the original
>      and V2.

The files as attachment.

> 
> [1] https://www.spinics.net/lists/linux-doc/msg97635.html
> [2] https://www.spinics.net/lists/linux-doc/msg97636.html
> [3] https://www.spinics.net/lists/linux-doc/msg97655.html
> ---
>   Documentation/admin-guide/index.rst    |    1 +
>   Documentation/admin-guide/spkguide.rst | 1421 +++++++++++++++++++++
>   Documentation/admin-guide/spkguide.txt | 1620 ------------------------
>   3 files changed, 1422 insertions(+), 1620 deletions(-)
>   create mode 100644 Documentation/admin-guide/spkguide.rst
>   delete mode 100644 Documentation/admin-guide/spkguide.txt
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 423116c4e787..c45121777ecf 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -112,6 +112,7 @@ configure specific aspects of kernel behavior to your liking.
>      ras
>      rtc
>      serial-console
> +   spkguide
>      svga
>      syscall-user-dispatch
>      sysrq
> diff --git a/Documentation/admin-guide/spkguide.rst b/Documentation/admin-guide/spkguide.rst
> new file mode 100644
> index 000000000000..ce4d42566e8e
> --- /dev/null
> +++ b/Documentation/admin-guide/spkguide.rst
> @@ -0,0 +1,1421 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +The Speakup User's Guide
> +========================
> +
> +| For Speakup 3.1.2 and Later
> +| By Gene Collins
> +| Updated by others
> +| Last modified on Mon Jun 3 17:08:21 2021
> +| Document version 1.3
> +
> +
> +.. contents:: :local:
> +
> +
> +Copyright
> +=========
> +
> +:Authors:
> + Copyright (c) 2005  Gene Collins
> +
> + Copyright (c) 2008  Samuel Thibault
> +
> + Copyright (c) 2009, 2010  the Speakup Team
> +
> +
> +Preface
> +=======
> +
> +The purpose of this document is to familiarize users with the user
> +interface to Speakup, a Linux Screen Reader.  If you need instructions
> +for installing or obtaining Speakup, visit the web site at
> +http://linux-speakup.org/.  Speakup is a set of patches to the standard
> +Linux kernel source tree.  It can be built as a series of modules, or as
> +a part of a monolithic kernel.  These details are beyond the scope of
> +this manual, but the user may need to be aware of the module
> +capabilities, depending on how your system administrator has installed
> +Speakup.  If Speakup is built as a part of a monolithic kernel, and the
> +user is using a hardware synthesizer, then Speakup will be able to
> +provide speech access from the time the kernel is loaded, until the time
> +the system is shutdown.  This means that if you have obtained Linux
> +installation media for a distribution which includes Speakup as a part
> +of its kernel, you will be able, as a blind person, to install Linux
> +with speech access unaided by a sighted person.  Again, these details
> +are beyond the scope of this manual, but the user should be aware of
> +them.  See the web site mentioned above for further details.
> +
> +
> +1.  Starting Speakup
> +====================
> +
> +If your system administrator has installed Speakup to work with your
> +specific synthesizer by default, then all you need to do to use Speakup
> +is to boot your system, and Speakup should come up talking.  This
> +assumes of course  that your synthesizer is a supported hardware
> +synthesizer, and that it is either installed in or connected to your
> +system, and is if necessary powered on.
> +
> +It is possible, however, that Speakup may have been compiled into the
> +kernel with no default synthesizer.  It is even possible that your
> +kernel has been compiled with support for some of the supported
> +synthesizers and not others.  If you find that this is the case, and
> +your synthesizer is supported but not available, complain to the person
> +who compiled and installed your kernel.  Or better yet, go to the web
> +site, and learn how to patch Speakup into your own kernel source, and
> +build and install your own kernel.
> +
> +If your kernel has been compiled with Speakup, and has no default
> +synthesizer set, or you would like to use a different synthesizer than
> +the default one, then you may issue the following command at the boot
> +prompt of your boot loader.::
> +
> +  linux speakup.synth=ltlk
> +
> +This command would tell Speakup to look for and use a LiteTalk or
> +DoubleTalk LT at boot up.  You may replace the ltlk synthesizer keyword
> +with the keyword for whatever synthesizer you wish to use.  The
> +``speakup.synth`` parameter will accept the following keywords, provided
> +that support for the related synthesizers has been built into the
> +kernel.
> +
> +  acntsa -- Accent SA
> +
> +  acntpc -- Accent PC
> +
> +  apollo -- Apollo
> +
> +  audptr -- Audapter
> +
> +  bns -- Braille 'n Speak
> +
> +  dectlk -- DecTalk Express (old and new, db9 serial only)
> +
> +  decext -- DecTalk (old) External
> +
> +  dtlk -- DoubleTalk PC
> +
> +  keypc -- Keynote Gold PC
> +
> +  ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
> +
> +  spkout -- Speak Out
> +
> +  txprt -- Transport
> +
> +  dummy -- Plain text terminal
> +
> +.. note::
> +   Speakup also does **NOT** support the internal Tripletalk!
> +
> +Speakup does support two other synthesizers, but because they work in
> +conjunction with other software, they must be loaded as modules after
> +their related software is loaded, and so are not available at boot up.
> +These are as follows:
> +
> +  decpc -- DecTalk PC (not available at boot up)
> +
> +  soft -- One of several software synthesizers (not available at boot up)
> +
> +See the sections on loading modules and software synthesizers later in
> +this manual for further details.  It should be noted here that the
> +speakup.synth boot parameter will have no effect if Speakup has been
> +compiled as modules.  In order for Speakup modules to be loaded during
> +the boot process, such action must be configured by your system
> +administrator.  This will mean that you will hear some, but not all,  of
> +the bootup messages.
> +
> +
> +2.  Basic operation
> +===================
> +
> +Once you have booted the system, and if necessary, have supplied the
> +proper bootup parameter for your synthesizer, Speakup will begin
> +talking as soon as the kernel is loaded.  In fact, it will talk a lot!
> +It will speak all the boot up messages that the kernel prints on the
> +screen during the boot process.  This is because Speakup is not a
> +separate screen reader, but is actually built into the operating
> +system.  Since almost all console applications must print text on the
> +screen using the kernel, and must get their keyboard input through the
> +kernel, they are automatically handled properly by Speakup.  There are a
> +few exceptions, but we'll come to those later.
> +
> +.. note::
> +
> +  In this guide I will refer to the numeric keypad as the keypad.
> +  This is done because the speakupmap.map file referred to later in this
> +  manual uses the term keypad instead of numeric keypad.  Also I'm lazy
> +  and would rather only type one word.  So keypad it is.  Got it?  Good.
> +
> +Most of the Speakup review keys are located on the keypad at the far
> +right of the keyboard.  The numlock key should be off, in order for these
> +to work.  If you toggle the numlock on, the keypad will produce numbers,
> +which is exactly what you want for spreadsheets and such.  For the
> +purposes of this guide, you should have the numlock turned off, which is
> +its default state at bootup.
> +
> +You probably won't want to listen to all the bootup messages every time
> +you start your system, though it's a good idea to listen to them at
> +least once, just so you'll know what kind of information is available to
> +you during the boot process.  You can always review these messages after
> +bootup with the command::
> +
> +  dmesg | more
> +
> +In order to speed the boot process, and to silence the speaking of the
> +bootup messages, just press the keypad enter key.  This key is located
> +in the bottom right corner of the keypad.  Speakup will shut up and stay
> +that way, until you press another key.
> +
> +You can check to see if the boot process has completed by pressing the 8
> +key on the keypad, which reads the current line.  This also has the
> +effect of starting Speakup talking again, so you can press keypad enter
> +to silence it again if the boot process has not completed.
> +
> +When the boot process is complete, you will arrive at a "login" prompt.
> +At this point, you'll need to type in your user id and password, as
> +provided by your system administrator.  You will hear Speakup speak the
> +letters of your user id as you type it, but not the password.  This is
> +because the password is not displayed on the screen for security
> +reasons.  This has nothing to do with Speakup, it's a Linux security
> +feature.
> +
> +Once you've logged in, you can run any Linux command or program which is
> +allowed by your user id.  Normal users will not be able to run programs
> +which require root privileges.
> +
> +When you are running a program or command, Speakup will automatically
> +speak new text as it arrives on the screen.  You can at any time silence
> +the speech with keypad enter, or use any of the Speakup review keys.
> +
> +Here are some basic Speakup review keys, and a short description of what
> +they do.
> +
> +  keypad 1 -- read previous character
> +
> +  keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
> +  the current character phonetically)
> +
> +  keypad 3 -- read next character
> +
> +  keypad 4 -- read previous word
> +
> +  keypad 5 -- read current word (press twice rapidly to spell the current word)
> +
> +  keypad 6 -- read next word
> +
> +  keypad 7 -- read previous line
> +
> +  keypad 8 -- read current line (press twice rapidly to hear how much the
> +  text on the current line is indented)
> +
> +  keypad 9 -- read next line
> +
> +  keypad period -- speak current cursor position and announce current
> +  virtual console
> +
> +It's also worth noting that the insert key on the keypad is mapped
> +as the speakup key.  Instead of pressing and releasing this key, as you
> +do under DOS or Windows, you hold it like a shift key, and press other
> +keys in combination with it.  For example, repeatedly holding keypad
> +insert, from now on called speakup, and keypad enter will toggle the
> +speaking of new text on the screen on and off.  This is not the same as
> +just pressing keypad enter by itself, which just silences the speech
> +until you hit another key.  When you hit speakup plus keypad enter,
> +Speakup will say, "You turned me off.", or "Hey, that's better."  When
> +Speakup is turned off, no new text on the screen will be spoken.  You
> +can still use the reading controls to review the screen however.
> +
> +
> +3.  Using the Speakup Help System
> +=================================
> +
> +In order to enter the Speakup help system, press and hold the speakup
> +key (remember that this is the keypad insert key), and press the `f1` key.
> +You will hear the message:
> +
> +"Press space to leave help, cursor up or down to scroll, or a letter to
> +go to commands in list."
> +
> +When you press the `spacebar` to leave the help system, you will hear:
> +
> +"Leaving help."
> +
> +While you are in the Speakup help system, you can scroll up or down
> +through the list of available commands using the cursor keys.  The list
> +of commands is arranged in alphabetical order.  If you wish to jump to
> +commands in a specific part of the alphabet, you may press the letter of
> +the alphabet you wish to jump to.
> +
> +You can also just explore by typing keyboard keys.  Pressing keys will
> +cause Speakup to speak the command associated with that key.  For
> +example, if you press the keypad 8 key, you will hear:
> +
> +"Keypad 8 is line, say current."
> +
> +You'll notice that some commands do not have keys assigned to them.
> +This is because they are very infrequently used commands, and are also
> +accessible through the sys system.  We'll discuss the sys system later
> +in this manual.
> +
> +You'll also notice that some commands have two keys assigned to them.
> +This is because Speakup has a built in set of alternative key bindings
> +for laptop users.  The alternate speakup key is the `caps lock` key.  You
> +can press and hold the `caps lock` key, while pressing an alternate
> +speakup command key to activate the command.  On most laptops, the
> +numeric keypad is defined as the keys in the `j k l` area of the keyboard.
> +
> +There is usually a function key which turns this keypad function on and
> +off, and some other key which controls the numlock state.  Toggling the
> +keypad functionality on and off can become a royal pain.  So, Speakup
> +gives you a simple way to get at an alternative set of key mappings for
> +your laptop.  These are also available by default on desktop systems,
> +because Speakup does not know whether it is running on a desktop or
> +laptop.  So you may choose which set of Speakup keys to use.  Some
> +system administrators may have chosen to compile Speakup for a desktop
> +system without this set of alternate key bindings, but these details are
> +beyond the scope of this manual.  To use the `caps lock` for its normal
> +purpose, hold the shift key while toggling the `caps lock` on and off.
> +
> +.. note::
> +
> +  Holding the `caps lock` key and pressing the `z` key will toggle the
> +  alternate `j k l` keypad on and off.
> +
> +
> +4.  Keys and Their Assigned Commands
> +====================================
> +
> +In this section, we'll go through a list of all the speakup keys and
> +commands.  You can also get a list of commands and assigned keys from
> +the help system.
> +
> +The following list was taken from the ``speakupmap.map`` file.  Key
> +assignments are on the left of the equal sign, and the associated
> +Speakup commands are on the right.  The designation "spk" means to press
> +and hold the speakup key, a.k.a. keypad insert, a.k.a. `caps lock`, while
> +pressing the other specified key.
> +
> +  spk key_f9 = punc_level_dec
> +
> +  spk key_f10 = punc_level_inc
> +
> +  spk key_f11 = reading_punc_dec
> +
> +  spk key_f12 = reading_punc_inc
> +
> +  spk key_1 = vol_dec
> +
> +  spk key_2 =  vol_inc
> +
> +  spk key_3 = pitch_dec
> +
> +  spk key_4 = pitch_inc
> +
> +  spk key_5 = rate_dec
> +
> +  spk key_6 = rate_inc
> +
> +  key_kpasterisk = toggle_cursoring
> +
> +  spk key_kpasterisk = speakup_goto
> +
> +  spk key_f1 = speakup_help
> +
> +  spk key_f2 = set_win
> +
> +  spk key_f3 = clear_win
> +
> +  spk key_f4 = enable_win
> +
> +  spk key_f5 = edit_some
> +
> +  spk key_f6 = edit_most
> +
> +  spk key_f7 = edit_delim
> +
> +  spk key_f8 = edit_repeat
> +
> +  shift spk key_f9 = edit_exnum
> +
> +  key_kp7 = say_prev_line
> +
> +  spk key_kp7 = left_edge
> +
> +  key_kp8 = say_line
> +
> +  double  key_kp8 = say_line_indent
> +
> +  spk key_kp8 = say_from_top
> +
> +  key_kp9 = say_next_line
> +
> +  spk  key_kp9 = top_edge
> +
> +  key_kpminus = speakup_parked
> +
> +  spk key_kpminus = say_char_num
> +
> +  key_kp4 = say_prev_word
> +
> +  spk key_kp4 = say_from_left
> +
> +  key_kp5 = say_word
> +
> +  double key_kp5 = spell_word
> +
> +  spk key_kp5 = spell_phonetic
> +
> +  key_kp6 = say_next_word
> +
> +  spk key_kp6 = say_to_right
> +
> +  key_kpplus = say_screen
> +
> +  spk key_kpplus = say_win
> +
> +  key_kp1 = say_prev_char
> +
> +  spk key_kp1 = right_edge
> +
> +  key_kp2 = say_char
> +
> +  spk key_kp2 = say_to_bottom
> +
> +  double key_kp2 = say_phonetic_char
> +
> +  key_kp3 = say_next_char
> +
> +  spk  key_kp3 = bottom_edge
> +
> +  key_kp0 = spk_key
> +
> +  key_kpdot = say_position
> +
> +  spk key_kpdot = say_attributes
> +
> +  key_kpenter = speakup_quiet
> +
> +  spk key_kpenter = speakup_off
> +
> +  key_sysrq = speech_kill
> +
> +  key_kpslash = speakup_cut
> +
> +  spk key_kpslash = speakup_paste
> +
> +  spk key_pageup = say_first_char
> +
> +  spk key_pagedown = say_last_char
> +
> +  key_capslock = spk_key
> +
> +  spk key_z = spk_lock
> +
> +  key_leftmeta = spk_key
> +
> +  ctrl spk key_0 = speakup_goto
> +
> +  spk key_u = say_prev_line
> +
> +  spk key_i = say_line
> +
> +  double spk key_i = say_line_indent
> +
> +  spk key_o = say_next_line
> +
> +  spk key_minus = speakup_parked
> +
> +  shift spk key_minus = say_char_num
> +
> +  spk key_j = say_prev_word
> +
> +  spk key_k = say_word
> +
> +  double spk key_k = spell_word
> +
> +  spk key_l = say_next_word
> +
> +  spk key_m = say_prev_char
> +
> +  spk key_comma = say_char
> +
> +  double spk key_comma = say_phonetic_char
> +
> +  spk key_dot = say_next_char
> +
> +  spk key_n = say_position
> +
> +  ctrl spk key_m = left_edge
> +
> +  ctrl spk key_y = top_edge
> +
> +  ctrl spk key_dot = right_edge
> +
> +  ctrl spk key_p = bottom_edge
> +
> +  spk key_apostrophe = say_screen
> +
> +  spk key_h = say_from_left
> +
> +  spk key_y = say_from_top
> +
> +  spk key_semicolon = say_to_right
> +
> +  spk key_p = say_to_bottom
> +
> +  spk key_slash = say_attributes
> +
> +  spk key_enter = speakup_quiet
> +
> +  ctrl  spk key_enter = speakup_off
> +
> +  spk key_9 = speakup_cut
> +
> +  spk key_8 = speakup_paste
> +
> +  shift spk key_m = say_first_char
> +
> +  ctrl spk key_semicolon = say_last_char
> +
> +  spk key_r = read_all_doc
> +
> +
> +5.  The Speakup Sys System
> +==========================
> +
> +The Speakup screen reader also creates a speakup subdirectory as a part
> +of the sys system.
> +
> +As a convenience, run as root::
> +
> +  ln -s /sys/accessibility/speakup /speakup
> +
> +to directly access speakup parameters from /speakup.
> +You can see these entries by typing the command::
> +
> +  ls -1 /speakup/*
> +
> +If you issue the above ls command, you will get back something like
> +this::
> +
> +  /speakup/attrib_bleep
> +  /speakup/bell_pos
> +  /speakup/bleep_time
> +  /speakup/bleeps
> +  /speakup/cursor_time
> +  /speakup/delimiters
> +  /speakup/ex_num
> +  /speakup/key_echo
> +  /speakup/keymap
> +  /speakup/no_interrupt
> +  /speakup/punc_all
> +  /speakup/punc_level
> +  /speakup/punc_most
> +  /speakup/punc_some
> +  /speakup/reading_punc
> +  /speakup/repeats
> +  /speakup/say_control
> +  /speakup/say_word_ctl
> +  /speakup/silent
> +  /speakup/spell_delay
> +  /speakup/synth
> +  /speakup/synth_direct
> +  /speakup/version
> +
> +  /speakup/i18n:
> +  announcements
> +  characters
> +  chartab
> +  colors
> +  ctl_keys
> +  formatted
> +  function_names
> +  key_names
> +  states
> +
> +  /speakup/soft:
> +  caps_start
> +  caps_stop
> +  delay_time
> +  direct
> +  freq
> +  full_time
> +  jiffy_delta
> +  pitch
> +  inflection
> +  punct
> +  rate
> +  tone
> +  trigger_time
> +  voice
> +  vol
> +
> +Notice the two subdirectories of ``/speakup``: ``/speakup/i18n`` and
> +``/speakup/soft``.
> +The `i18n` subdirectory is described in a later section.
> +The files under ``/speakup/soft`` represent settings that are specific to the
> +driver for the software synthesizer.  If you use the LiteTalk, your
> +synthesizer-specific settings would be found in ``/speakup/ltlk``.  In other words,
> +a subdirectory named ``/speakup/KWD`` is created to hold parameters specific
> +to the device whose keyword is KWD.
> +These parameters include volume, rate, pitch, and others.
> +
> +In addition to using the Speakup hot keys to change such things as
> +volume, pitch, and rate, you can also echo values to the appropriate
> +entry in the ``/speakup`` directory.  This is very useful, since it
> +lets you control Speakup parameters from within a script.  How you
> +would write such scripts is somewhat beyond the scope of this manual,
> +but I will include a couple of simple examples here to give you a
> +general idea of what such scripts can do.
> +
> +Suppose for example, that you wanted to control both the punctuation
> +level and the reading punctuation level at the same time.  For
> +simplicity, we'll call them punc0, punc1, punc2, and punc3.  The scripts
> +might look something like this:
> +
> +.. code-block:: shell
> +
> +  #!/bin/bash
> +  # punc0
> +  # set punc and reading punc levels to 0
> +  echo 0 >/speakup/punc_level
> +  echo 0 >/speakup/reading_punc
> +  echo Punctuation level set to 0.
> +
> +  #!/bin/bash
> +  # punc1
> +  # set punc and reading punc levels to 1
> +  echo 1 >/speakup/punc_level
> +  echo 1 >/speakup/reading_punc
> +  echo Punctuation level set to 1.
> +
> +  #!/bin/bash
> +  # punc2
> +  # set punc and reading punc levels to 2
> +  echo 2 >/speakup/punc_level
> +  echo 2 >/speakup/reading_punc
> +  echo Punctuation level set to 2.
> +
> +  #!/bin/bash
> +  # punc3
> +  # set punc and reading punc levels to 3
> +  echo 3 >/speakup/punc_level
> +  echo 3 >/speakup/reading_punc
> +  echo Punctuation level set to 3.
> +
> +If you were to store these four small scripts in a directory in your
> +path, perhaps ``/usr/local/bin``, and set the permissions to 755 with the
> +``chmod`` command, then you could change the default reading punc and
> +punctuation levels at the same time by issuing just one command.  For
> +example, if you were to execute the punc3 command at your shell prompt,
> +then the reading punc and punc level would both get set to 3.
> +
> +.. note::
> +
> +  The above scripts were written to work with bash, but
> +  regardless of which shell you use, you should be able to do something
> +  similar.
> +
> +The Speakup sys system also has another interesting use.  You can echo
> +Speakup parameters into the sys system in a script during system
> +startup, and speakup will return to your preferred parameters every time
> +the system is rebooted.
> +
> +Most of the Speakup sys parameters can be manipulated by a regular user
> +on the system.  However, there are a few parameters that are dangerous
> +enough that they should only be manipulated by the root user on your
> +system.  There are even some parameters that are read only, and cannot
> +be written to at all.  For example, the version entry in the Speakup
> +sys system is read only.  This is because there is no reason for a user
> +to tamper with the version number which is reported by Speakup.  Doing
> +an ``ls -l`` on ``/speakup/version`` will return this::
> +
> +  -r--r--r--    1 root     root            0 Mar 21 13:46 /speakup/version
> +
> +As you can see, the version entry in the Speakup sys system is read
> +only, is owned by root, and belongs to the root group.  Doing a cat of
> +``/speakup/version`` will display the Speakup version number, like
> +this::
> +
> +  cat /speakup/version
> +  Speakup v-2.00 CVS: Thu Oct 21 10:38:21 EDT 2004
> +  synth dtlk version 1.1
> +
> +The display shows the Speakup version number, along with the version
> +number of the driver for the current synthesizer.
> +
> +Looking at entries in the Speakup sys system can be useful in many
> +ways.  For example, you might wish to know what level your volume is set
> +at.  You could type::
> +
> +  cat /speakup/KWD/vol
> +  # Replace KWD with the keyword for your synthesizer, E.G., ltlk for LiteTalk.
> +  5
> +
> +The number five which comes back is the level at which the synthesizer
> +volume is set at.
> +
> +All the entries in the Speakup sys system are readable, some are
> +writable by root only, and some are writable by everyone.  Unless you
> +know what you are doing, you should probably leave the ones that are
> +writable by root only alone.  Most of the names are self explanatory.
> +Vol for controlling volume, pitch for pitch, inflection for pitch range, rate
> +for controlling speaking rate, etc.  If you find one you aren't sure about, you
> +can post a query on the Speakup list.
> +
> +
> +6.  Changing Synthesizers
> +=========================
> +
> +It is possible to change to a different synthesizer while speakup is
> +running.  In other words, it is not necessary to reboot the system
> +in order to use a different synthesizer.  You can simply echo the
> +synthesizer keyword to the ``/speakup/synth`` sys entry.
> +Depending on your situation, you may wish to echo none to the synth
> +sys entry, to disable speech while one synthesizer is disconnected and
> +a second one is connected in its place.  Then echo the keyword for the
> +new synthesizer into the synth sys entry in order to start speech
> +with the newly connected synthesizer.  See the list of synthesizer
> +keywords in section 1 to find the keyword which matches your synth.
> +
> +
> +7.  Loading modules
> +===================
> +
> +As mentioned earlier, Speakup can either be completely compiled into the
> +kernel, with the exception of the help module, or it can be compiled as
> +a series of modules.   When compiled as modules, Speakup will only be
> +able to speak some of the bootup messages if your system administrator
> +has configured the system to load the modules at boo time. The modules
> +can  be loaded after the file systems have been checked and mounted, or
> +from an initrd.  There is a third possibility.  Speakup can be compiled
> +with some components built into the kernel, and others as modules.  As
> +we'll see in the next section, this is particularly useful when you are
> +working with software synthesizers.
> +
> +If Speakup is completely compiled as modules, then you must use the
> +modprobe command to load Speakup.  You do this by loading the module for
> +the synthesizer driver you wish to use.  The driver modules are all
> +named speakup_<keyword>, where <keyword> is the keyword for the
> +synthesizer you want.  So, in order to load the driver for the DecTalk
> +Express, you would type the following command::
> +
> +  modprobe speakup_dectlk
> +
> +Issuing this command would load the DecTalk Express driver and all other
> +related Speakup modules necessary to get Speakup up and running.
> +
> +To completely unload Speakup, again presuming that it is entirely built
> +as modules, you would give the command::
> +
> +  modprobe -r speakup_dectlk
> +
> +The above command assumes you were running a DecTalk Express.  If you
> +were using a different synth, then you would substitute its keyword in
> +place of `dectlk`.
> +
> +If you have multiple drivers loaded, you need to unload all of them, in
> +order to completely unload Speakup.
> +For example, if you have loaded both the dectlk and ltlk drivers, use the
> +command::
> +
> +  modprobe -r speakup_dectlk speakup_ltlk
> +
> +You cannot unload the driver for software synthesizers when a user-space
> +daemon is using ``/dev/softsynth``.  First, kill the daemon.  Next, remove
> +the driver with the command::
> +
> +  modprobe -r speakup_soft
> +
> +Now, suppose we have a situation where the main Speakup component
> +is built into the kernel, and some or all of the drivers are built as
> +modules.  Since the main part of Speakup is compiled into the kernel, a
> +partial Speakup sys system has been created which we can take advantage
> +of by simply echoing the synthesizer keyword into the
> +``/speakup/synth`` sys entry.  This will cause the kernel to
> +automatically load the appropriate driver module, and start Speakup
> +talking.  To switch to another synth, just echo a new keyword to the
> +synth sys entry.  For example, to load the DoubleTalk LT driver,
> +you would type::
> +
> +  echo ltlk >/speakup/synth
> +
> +You can use the ``modprobe -r`` command to unload driver modules, regardless
> +of whether the main part of Speakup has been built into the kernel or
> +not.
> +
> +
> +8.  Using Software Synthesizers
> +===============================
> +
> +Using a software synthesizer requires that some other software be
> +installed and running on your system.  For this reason, software
> +synthesizers are not available for use at bootup, or during a system
> +installation process.
> +There are two freely-available solutions for software speech: Espeakup and
> +Speech Dispatcher.
> +These are described in subsections `8.1. Espeakup`_ and
> +`8.2. Speech Dispatcher`_, respectively.
> +
> +During the rest of this section, we assume that `speakup_soft` is either
> +built in to your kernel, or loaded as a module.
> +
> +If your system does not have udev installed , before you can use a
> +software synthesizer, you must have created the ``/dev/softsynth`` device.
> +If you have not already done so, issue the following commands as root::
> +
> +  cd /dev
> +  mknod softsynth c 10 26
> +
> +While we are at it, we might just as well create the ``/dev/synth`` device,
> +which can be used to let user space programs send information to your
> +synthesizer.  To create ``/dev/synth``, change to the ``/dev`` directory, and
> +issue the following command as root::
> +
> +  mknod synth c 10 25
> +
> +of both.
> +
> +8.1. Espeakup
> +-------------
> +
> +Espeakup is a connector between Speakup and the eSpeak software synthesizer.
> +Espeakup may already be available as a package for your distribution
> +of Linux.  If it is not packaged, you need to install it manually.
> +You can find it in the ``contrib/`` subdirectory of the Speakup sources.
> +The filename is ``espeakup-$VERSION.tar.bz2``, where ``$VERSION``
> +depends on the current release of Espeakup.  The Speakup 3.1.2 source
> +ships with version 0.71 of Espeakup.
> +The README file included with the Espeakup sources describes the process
> +of manual installation.
> +
> +Assuming that Espeakup is installed, either by the user or by the distributor,
> +follow these steps to use it.
> +
> +Tell Speakup to use the "soft driver::
> +
> +  echo soft > /speakup/synth
> +
> +Finally, start the espeakup program.  There are two ways to do it.
> +Both require root privileges.
> +
> +If Espeakup was installed as a package for your Linux distribution,
> +you probably have a distribution-specific script that controls the operation
> +of the daemon.  Look for a file named espeakup under ``/etc/init.d`` or
> +``/etc/rc.d``.  Execute the following command with root privileges::
> +
> +  /etc/init.d/espeakup start
> +
> +Replace ``init.d`` with ``rc.d``, if your distribution uses scripts located
> +under ``/etc/rc.d``.
> +Your distribution will also have a procedure for starting daemons at
> +boot-time, so it is possible to have software speech as soon as user-space
> +daemons are started by the bootup scripts.
> +These procedures are not described in this document.
> +
> +If you built Espeakup manually, the ``make install`` step placed the binary
> +under ``/usr/bin``.
> +Run the following command as root::
> +
> +  /usr/bin/espeakup
> +
> +Espeakup should start speaking.
> +
> +8.2. Speech Dispatcher
> +----------------------
> +
> +For this option, you must have a package called
> +Speech Dispatcher running on your system, and it must be configured to
> +work with one of its supported software synthesizers.
> +
> +Two open source synthesizers you might use are Flite and Festival.  You
> +might also choose to purchase the Software DecTalk from Fonix Sales Inc.
> +If you run a google search for Fonix, you'll find their web site.
> +
> +You can obtain a copy of Speech Dispatcher from free(b)soft at
> +http://www.freebsoft.org/.  Follow the installation instructions that
> +come with Speech Dispatcher in order to install and configure Speech
> +Dispatcher.  You can check out the web site for your Linux distribution
> +in order to get a copy of either Flite or Festival.  Your Linux
> +distribution may also have a precompiled Speech Dispatcher package.
> +
> +Once you've installed, configured, and tested Speech Dispatcher with your
> +chosen software synthesizer, you still need one more piece of software
> +in order to make things work.  You need a package called speechd-up.
> +You get it from the free(b)soft web site mentioned above.  After you've
> +compiled and installed speechd-up, you are almost ready to begin using
> +your software synthesizer.
> +
> +Now you can begin using your software synthesizer.  In order to do so,
> +echo the soft keyword to the synth sys entry like this::
> +
> +  echo soft >/speakup/synth
> +
> +Next run the speechd_up command like this::
> +
> +  speechd_up &
> +
> +Your synth should now start talking, and you should be able to adjust
> +the pitch, rate, etc.
> +
> +
> +9.  Using The DecTalk PC Card
> +=============================
> +
> +The DecTalk PC card is an ISA card that is inserted into one of the ISA
> +slots in your computer.  It requires that the DecTalk PC software be
> +installed on your computer, and that the software be loaded onto the
> +Dectalk PC card before it can be used.
> +
> +You can get the ``dec_pc.tgz`` file from the linux-speakup.org site.  The
> +``dec_pc.tgz`` file is in the ``~ftp/pub/linux/speakup`` directory.
> +
> +After you have downloaded the ``dec_pc.tgz`` file, untar it in your home
> +directory, and read the Readme file in the newly created ``dec_pc``
> +directory.
> +
> +The easiest way to get the software working is to copy the entire ``dec_pc``
> +directory into ``/user/local/lib``.  To do this, su to root in your home
> +directory, and issue the command::
> +
> +  cp dec_pc /usr/local/lib
> +
> +You will need to copy the dtload command from the dec_pc directory to a
> +directory in your path. Either ``/usr/bin`` or ``/usr/local/bin`` is a
> +good choice.
> +
> +You can now run the dtload command in order to load the DecTalk PC
> +software onto the card.  After you have done this, ``echo`` the decpc
> +keyword to the synth entry in the sys system like this::
> +
> +  echo decpc >/speakup/synth
> +
> +Your DecTalk PC should start talking, and then you can adjust the pitch,
> +rate, volume, voice, etc.  The voice entry in the Speakup sys system
> +will accept a number from 0 through 7 for the DecTalk PC synthesizer,
> +which will give you access to some of the DecTalk voices.
> +
> +
> +10.  Using Cursor Tracking
> +==========================
> +
> +In Speakup version 2.0 and later, cursor tracking is turned on by
> +default.  This means that when you are using an editor, Speakup will
> +automatically speak characters as you move left and right with the
> +cursor keys, and lines as you move up and down with the cursor keys.
> +This is the traditional sort of cursor tracking.
> +Recent versions of Speakup provide two additional ways to control the
> +text that is spoken when the cursor is moved:
> +"highlight tracking" and "read window."
> +They are described later in this section.
> +Sometimes, these modes get in your way, so you can disable cursor tracking
> +altogether.
> +
> +You may select among the various forms of cursor tracking using the keypad
> +asterisk key.
> +Each time you press this key, a new mode is selected, and Speakup speaks
> +the name of the new mode.  The names for the four possible states of cursor
> +tracking are: "cursoring on", "highlight tracking", "read window",
> +and "cursoring off."  The keypad asterisk key moves through the list of
> +modes in a circular fashion.
> +
> +If highlight tracking is enabled, Speakup tracks highlighted text,
> +rather than the cursor itself. When you move the cursor with the arrow keys,
> +Speakup speaks the currently highlighted information.
> +This is useful when moving through various menus and dialog boxes.
> +If cursor tracking isn't helping you while navigating a menu,
> +try highlight tracking.
> +
> +With the "read window" variety of cursor tracking, you can limit the text
> +that Speakup speaks by specifying a window of interest on the screen.
> +See section 15 for a description of the process of defining windows.
> +When you move the cursor via the arrow keys, Speakup only speaks
> +the contents of the window.  This is especially helpful when you are hearing
> +superfluous speech.  Consider the following example.
> +
> +Suppose that you are at a shell prompt.  You use bash, and you want to
> +explore your command history using the up and down arrow keys.  If you
> +have enabled cursor tracking, you will hear two pieces of information.
> +Speakup speaks both your shell prompt and the current entry from the
> +command history.  You may not want to hear the prompt repeated
> +each time you move, so you can silence it by specifying a window.  Find
> +the last line of text on the screen.  Clear the current window by pressing
> +the key combination speakup `f3`.  Use the review cursor to find the first
> +character that follows your shell prompt.  Press speakup + `f2` twice, to
> +define a one-line window.  The boundaries of the window are the
> +character following the shell prompt and the end of the line.  Now, cycle
> +through the cursor tracking modes using keypad asterisk, until Speakup
> +says "read window."  Move through your history using your arrow keys.
> +You will notice that Speakup no longer speaks the redundant prompt.
> +
> +Some folks like to turn cursor tracking off while they are using the
> +lynx web browser.  You definitely want to turn cursor tracking off when
> +you are using the alsamixer application.  Otherwise, you won't be able
> +to hear your mixer settings while you are using the arrow keys.
> +
> +
> +11.  Cut and Paste
> +==================
> +
> +One of Speakup's more useful features is the ability to cut and paste
> +text on the screen.  This means that you can capture information from a
> +program, and paste that captured text into a different place in the
> +program, or into an entirely different program, which may even be
> +running on a different console.
> +
> +For example, in this manual, we have made references to several web
> +sites.  It would be nice if you could cut and paste these urls into your
> +web browser.  Speakup does this quite nicely.  Suppose you wanted to
> +past the following url into your browser:
> +
> +http://linux-speakup.org/
> +
> +Use the speakup review keys to position the reading cursor on the first
> +character of the above url.  When the reading cursor is in position,
> +press the keypad slash key once.  Speakup will say, "mark".  Next,
> +position the reading cursor on the rightmost character of the above
> +url. Press the keypad slash key once again to actually cut the text
> +from the screen.  Speakup will say, "cut".  Although we call this
> +cutting, Speakup does not actually delete the cut text from the screen.
> +It makes a copy of the text in a special buffer for later pasting.
> +
> +Now that you have the url cut from the screen, you can paste it into
> +your browser, or even paste the url on a command line as an argument to
> +your browser.
> +
> +Suppose you want to start lynx and go to the Speakup site.
> +
> +You can switch to a different console with the alt left and right
> +arrows, or you can switch to a specific console by typing alt and a
> +function key.  These are not Speakup commands, just standard Linux
> +console capabilities.
> +
> +Once you've changed to an appropriate console, and are at a shell prompt,
> +type the word lynx, followed by a space.  Now press and hold the speakup
> +key, while you type the keypad slash character.  The url will be pasted
> +onto the command line, just as though you had typed it in.  Press the
> +enter key to execute the command.
> +
> +The paste buffer will continue to hold the cut information, until a new
> +mark and cut operation is carried out.  This means you can paste the cut
> +information as many times as you like before doing another cut
> +operation.
> +
> +You are not limited to cutting and pasting only one line on the screen.
> +You can also cut and paste rectangular regions of the screen.  Just
> +position the reading cursor at the top left corner of the text to be
> +cut, mark it with the keypad slash key, then position the reading cursor
> +at the bottom right corner of the region to be cut, and cut it with the
> +keypad slash key.
> +
> +
> +12.  Changing the Pronunciation of Characters
> +=============================================
> +
> +Through the ``/speakup/i18n/characters`` sys entry, Speakup gives you the
> +ability to change how Speakup pronounces a given character.  You could,
> +for example, change how some punctuation characters are spoken.  You can
> +even change how Speakup will pronounce certain letters.
> +
> +You may, for example, wish to change how Speakup pronounces the z
> +character.  The author of Speakup, Kirk Reiser, is Canadian, and thus
> +believes that the z should be pronounced zed.  If you are an American,
> +you might wish to use the zee pronunciation instead of zed.  You can
> +change the pronunciation of both the upper and lower case z with the
> +following two commands::
> +
> +  echo 90 zee >/speakup/characters
> +  echo 122 zee >/speakup/characters
> +
> +Let's examine the parts of the two previous commands.  They are issued
> +at the shell prompt, and could be placed in a startup script.
> +
> +The word echo tells the shell that you want to have it display the
> +string of characters that follow the word echo.  If you were to just
> +type::
> +
> +  echo hello.
> +
> +You would get the word hello printed on your screen as soon as you
> +pressed the enter key.  In this case, we are echoing strings that we
> +want to be redirected into the sys system.
> +
> +The numbers 90 and 122 in the above echo commands are the ascii numeric
> +values for the upper and lower case z, the characters we wish to change.
> +
> +The string zee is the pronunciation that we want Speakup to use for the
> +upper and lower case z.
> +
> +The ``>`` symbol redirects the output of the echo command to a file, just
> +like in DOS, or at the Windows command prompt.
> +
> +And finally, ``/speakup/i18n/characters`` is the file entry in the sys system
> +where we want the output to be directed.  Speakup looks at the numeric
> +value of the character we want to change, and inserts the pronunciation
> +string into an internal table.
> +
> +You can look at the whole table with the following command::
> +
> +  cat /speakup/i18n/characters
> +
> +Speakup will then print out the entire character pronunciation table.  I
> +won't display it here, but leave you to look at it at your convenience.
> +
> +
> +13.  Mapping Keys
> +=================
> +
> +Speakup has the capability of allowing you to assign or "map" keys to
> +internal Speakup commands.  This section necessarily assumes you have a
> +Linux kernel source tree installed, and that it has been patched and
> +configured with Speakup.  How you do this is beyond the scope of this
> +manual.  For this information, visit the Speakup web site at
> +http://linux-speakup.org/.  The reason you'll need the kernel source
> +tree patched with Speakup is that the genmap utility you'll need for
> +processing keymaps is in the
> +``/usr/src/linux-<version_number>/drivers/char/speakup`` directory.  The
> +``<version_number>`` in the above directory path is the version number of
> +the Linux source tree you are working with.
> +
> +So ok, you've gone off and gotten your kernel source tree, and patched
> +and configured it.  Now you can start manipulating keymaps.
> +
> +You can either use the
> +``/usr/src/linux-<version_number>/drivers/char/speakup/speakupmap.map`` file
> +included with the Speakup source, or you can cut and paste the copy in
> +section 4 into a separate file.  If you use the one in the Speakup
> +source tree, make sure you make a backup of it before you start making
> +changes.  You have been warned!
> +
> +Suppose that you want to swap the key assignments for the Speakup
> +say_last_char and the Speakup say_first_char commands.  The
> +speakupmap.map lists the key mappings for these two commands as follows::
> +
> +  spk key_pageup = say_first_char
> +  spk key_pagedown = say_last_char
> +
> +You can edit your copy of the speakupmap.map file and swap the command
> +names on the right side of the ``=`` (equals) sign.  You did make a backup,
> +right?  The new keymap lines would look like this::
> +
> +  spk key_pageup = say_last_char
> +  spk key_pagedown = say_first_char
> +
> +After you edit your copy of the speakupmap.map file, save it under a new
> +file name, perhaps newmap.map.  Then exit your editor and return to the
> +shell prompt.
> +
> +You are now ready to load your keymap with your swapped key assignments.
> +Assuming that you saved your new keymap as the file newmap.map, you
> +would load your keymap into the sys system like this::
> +
> +  /usr/src/linux-<version_number>/drivers/char/speakup/genmap newmap.map >/speakup/keymap
> +
> +
> +.. note::
> +
> +  Remember to substitute your kernel version number for the
> +  ``<version_number>`` in the above command.
> +
> +Your say first and say last characters should now be swapped.  Pressing
> +speakup pagedown should read you the first non-whitespace character on
> +the line your reading cursor is in, and pressing speakup pageup should
> +read you the last character on the line your reading cursor is in.
> +
> +.. note::
> +
> +  These new mappings will only stay in effect until you reboot,
> +  or until you load another keymap.
> +
> +One final warning.  If you try to load a partial map, you will quickly
> +find that all the mappings you didn't include in your file got deleted
> +from the working map.  Be extremely careful, and always make a backup!
> +You have been warned!
> +
> +
> +14.  Internationalizing Speakup
> +===============================
> +
> +Speakup indicates various conditions to the user by speaking messages.
> +For instance, when you move to the left edge of the screen with the
> +review keys, Speakup says, "left."
> +Prior to version 3.1.0 of Speakup, all of these messages were in English,
> +and they could not be changed.  If you used a non-English synthesizer,
> +you still heard English messages, such as "left" and "cursoring on."
> +In version 3.1.0 or higher, one may load translations for the various
> +messages via the ``/sys`` filesystem.
> +
> +The directory ``/speakup/i18n`` contains several collections of messages.
> +Each group of messages is stored in its own file.
> +The following section lists all of these files, along with a brief description
> +of each.
> +
> +14.1.  Files Under the i18n Subdirectory
> +----------------------------------------
> +
> +announcements
> +  This file contains various general announcements, most of which cannot
> +  be categorized.  You will find messages such as "You killed Speakup",
> +  "I'm alive", "leaving help", "parked", "unparked", and others.
> +  You will also find the names of the screen edges and cursor tracking modes
> +  here.
> +
> +characters
> +  See `12.  Changing the Pronunciation of Characters`_ for a description
> +  of this file.
> +
> +chartab
> +  See `12.  Changing the Pronunciation of Characters`_.  Unlike the rest
> +  of the files in the i18n subdirectory, this one does not contain messages
> +  to be spoken.
> +
> +colors
> +  When you use the "say attributes" function, Speakup says the name of the
> +  foreground and background colors.  These names come from the i18n/colors
> +  file.
> +
> +ctl_keys
> +  Here, you will find names of control keys.  These are used with Speakup's
> +  say_control feature.
> +
> +formatted
> +  This group of messages contains embedded formatting codes, to specify
> +  the type and width of displayed data.  If you change these, you must
> +  preserve all of the formatting codes, and they must appear in the order
> +  used by the default messages.
> +
> +function_names
> +  Here, you will find a list of names for Speakup functions.  These are used
> +  by the help system.  For example, suppose that you have activated help mode,
> +  and you pressed keypad 3.  Speakup says:
> +  "keypad 3 is character, say next."
> +  The message "character, say next" names a Speakup function, and it
> +  comes from this function_names file.
> +
> +key_names
> +  Again, key_names is used by Speakup's help system.  In the previous
> +  example, Speakup said that you pressed "keypad 3."
> +  This name came from the key_names file.
> +
> +states
> +  This file contains names for key states.
> +  Again, these are part of the help system.  For instance, if you had pressed
> +  speakup + keypad 3, you would hear:
> +  "speakup keypad 3 is go to bottom edge."
> +  The speakup key is depressed, so the name of the key state is speakup.
> +  This part of the message comes from the states collection.
> +
> +14.2.1.  Loading Your Own Messages
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The files under the i18n subdirectory all follow the same format.
> +They consist of lines, with one message per line.
> +Each message is represented by a number, followed by the text of the message.
> +The number is the position of the message in the given collection.
> +For example, if you view the file ``/speakup/i18n/colors``, you will see the
> +following list::
> +
> +  0 - black
> +  1 - blue
> +  2 - green
> +  3 - cyan
> +  4 - red
> +  5 - magenta
> +  6 - yellow
> +  7 - white
> +  8 - grey
> +
> +You can change one message, or you can change a whole group.
> +To load a whole collection of messages from a new source, simply use
> +the cp command::
> +
> +  cp ~/my_colors /speakup/i18n/colors
> +
> +You can change an individual message with the echo command,
> +as shown in the following example.
> +
> +The Spanish name for the color blue is azul.
> +Looking at the colors file, we see that the name "blue" is at position 1
> +within the colors group.  Let's change blue to azul::
> +
> +  echo '1 azul' > /speakup/i18n/colors
> +
> +The next time that Speakup says message 1 from the colors group, it will
> +say "azul", rather than "blue."
> +
> +14.2.2. Choose a language
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In the future, translations into various languages will be made available,
> +and most users will just load the files necessary for their language. So far,
> +only French language is available beyond native Canadian English language.
> +
> +French is only available after you are logged in.
> +
> +Canadian English is the default language. To toggle another language,
> +download the source of Speakup and untar it in your home directory. The
> +following command should let you do this::
> +
> +  tar xvjf speakup-<version>.tar.bz2
> +
> +where ``<version>`` is the version number of the application.
> +
> +Next, change to the newly created directory, then into the tools/ directory, and
> +run the script speakup_setlocale. You are asked the language that you want to
> +use. Type the number associated to your language (e.g. fr for French) then press
> +Enter. Needed files are copied in the i18n directory.
> +
> +Note: the speakupconf must be installed on your system so that settings are saved.
> +Otherwise, you will have an error: your language will be loaded but you will
> +have to run the script again every time Speakup restarts.
> +See section 16.1. for information about speakupconf.
> +
> +You will have to repeat these steps for any change of locale, i.e. if you wish
> +change the speakup's language or charset (iso-8859-15 ou UTF-8).
> +
> +If you wish store the settings, note that at your next login, you will need to
> +do::
> +
> +  speakup load
> +
> +Alternatively, you can add the above line to your file
> +``~/.bashrc`` or ``~/.bash_profile``.
> +
> +If your system administrator ran himself the script, all the users will be able
> +to change from English to the language choosed by root and do directly
> +speakupconf load (or add this to the ``~/.bashrc`` or
> +``~/.bash_profile`` file). If there are several languages to handle, the
> +administrator (or every user) will have to run the first steps until speakupconf
> +save, choosing the appropriate language, in every user's home directory. Every
> +user will then be able to do speakupconf load, Speakup will load his own settings.
> +
> +14.3.  No Support for Non-Western-European Languages
> +----------------------------------------------------
> +
> +As of the current release, Speakup only supports Western European languages.
> +Support for the extended characters used by languages outside of the Western
> +European family of languages is a work in progress.
> +
> +
> +15.  Using Speakup's Windowing Capability
> +=========================================
> +
> +Speakup has the capability of defining and manipulating windows on the
> +screen.  Speakup uses the term "Window", to mean a user defined area of
> +the screen.  The key strokes for defining and manipulating Speakup
> +windows are as follows::
> +
> +  speakup + f2 -- Set the bounds of the window.
> +  Speakup + f3 -- clear the current window definition.
> +  speakup + f4 -- Toggle window silence on and off.
> +  speakup + keypad plus -- Say the currently defined window.
> +
> +These capabilities are useful for tracking a certain part of the screen
> +without rereading the whole screen, or for silencing a part of the
> +screen that is constantly changing, such as a clock or status line.
> +
> +There is no way to save these window settings, and you can only have one
> +window defined for each virtual console.  There is also no way to have
> +windows automatically defined for specific applications.
> +
> +In order to define a window, use the review keys to move your reading
> +cursor to the beginning of the area you want to define.  Then press
> +speakup + `f2`.  Speakup will tell you that the window starts at the
> +indicated row and column position.  Then move the reading cursor to the
> +end of the area to be defined as a window, and press speakup + `f2` again.
> +If there is more than one line in the window, Speakup will tell you
> +that the window ends at the indicated row and column position.  If there
> +is only one line in the window, then Speakup will tell you that the
> +window is the specified line on the screen.  If you are only defining a
> +one line window, you can just press speakup + `f2` twice after placing the
> +reading cursor on the line you want to define as a window.  It is not
> +necessary to position the reading cursor at the end of the line in order
> +to define the whole line as a window.
> +
> +
> +16.  Tools for Controlling Speakup
> +==================================
> +
> +The speakup distribution includes extra tools (in the tools directory)
> +which were written to make speakup easier to use.  This section will
> +briefly describe the use of these tools.
> +
> +16.1.  Speakupconf
> +------------------
> +
> +speakupconf began life as a contribution from Steve Holmes, a member of
> +the speakup community.  We would like to thank him for his work on the
> +early versions of this project.
> +
> +This script may be installed as part of your linux distribution, but if
> +it isn't, the recommended places to put it are ``/usr/local/bin`` or
> +``/usr/bin``.  This script can be run by any user, so it does not require
> +root privileges.
> +
> +Speakupconf allows you to save and load your Speakup settings.  It works
> +by reading and writing the ``/sys`` files described above.
> +
> +The directory that speakupconf uses to store your settings depends on
> +whether it is run from the root account.  If you execute speakupconf as
> +root, it uses the directory ``/etc/speakup``.  Otherwise, it uses the directory
> +``~/.speakup``, where ``~`` is your home directory.
> +Anyone who needs to use Speakup from your console can load his own custom
> +settings with this script.
> +
> +speakupconf takes one required argument: load or save.
> +Use the command::
> +
> +  speakupconf save
> +
> +to save your Speakup settings, and::
> +
> +  speakupconf load
> +
> +to load them into Speakup.
> +
> +A second argument may be specified to use an alternate directory to
> +load or save the speakup parameters.
> +
> +16.2.  Talkwith
> +---------------
> +
> +Charles Hallenbeck, another member of the speakup community, wrote the
> +initial versions of this script, and we would also like to thank him for
> +his work on it.
> +
> +This script needs root privileges to run, so if it is not installed as
> +part of your linux distribution, the recommended places to install it
> +are ``/usr/local/sbin`` or ``/usr/sbin``.
> +
> +Talkwith allows you to switch synthesizers on the fly.  It takes a synthesizer
> +name as an argument.  For instance,
> +talkwith dectlk
> +causes Speakup to use the DecTalk Express.  If you wish to switch to a
> +software synthesizer, you must also indicate which daemon you wish to
> +use.  There are two possible choices:
> +spd and espeakup.  spd is an abbreviation for speechd-up.
> +If you wish to use espeakup for software synthesis, give the command
> +talkwith soft espeakup
> +To use speechd-up, type::
> +
> +  talkwith soft spd
> +
> +Any arguments that follow the name of the daemon are passed to the daemon
> +when it is invoked.  For instance::
> +
> +  talkwith espeakup --default-voice=fr
> +
> +causes espeakup to use the French voice.
> +
> +.. note::
> +
> +  Talkwith must always be executed with root privileges.
> +
> +Talkwith does not attempt to load your settings after the new
> +synthesizer is activated.  You can use speakupconf to load your settings
> +if desired.
> +
> +
> +
> diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.txt
> deleted file mode 100644
> index 977ab3f5a0a8..000000000000
> --- a/Documentation/admin-guide/spkguide.txt
> +++ /dev/null
> @@ -1,1620 +0,0 @@
> -
> -The Speakup User's Guide
> -For Speakup 3.1.2 and Later
> -By Gene Collins
> -Updated by others
> -Last modified on Mon Sep 27 14:26:31 2010
> -Document version 1.3
> -
> -Copyright (c) 2005  Gene Collins
> -Copyright (c) 2008  Samuel Thibault
> -Copyright (c) 2009, 2010  the Speakup Team
> -
> -Permission is granted to copy, distribute and/or modify this document
> -under the terms of the GNU Free Documentation License, Version 1.2 or
> -any later version published by the Free Software Foundation; with no
> -Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A
> -copy of the license is included in the section entitled "GNU Free
> -Documentation License".
> -
> -Preface
> -
> -The purpose of this document is to familiarize users with the user
> -interface to Speakup, a Linux Screen Reader.  If you need instructions
> -for installing or obtaining Speakup, visit the web site at
> -http://linux-speakup.org/.  Speakup is a set of patches to the standard
> -Linux kernel source tree.  It can be built as a series of modules, or as
> -a part of a monolithic kernel.  These details are beyond the scope of
> -this manual, but the user may need to be aware of the module
> -capabilities, depending on how your system administrator has installed
> -Speakup.  If Speakup is built as a part of a monolithic kernel, and the
> -user is using a hardware synthesizer, then Speakup will be able to
> -provide speech access from the time the kernel is loaded, until the time
> -the system is shutdown.  This means that if you have obtained Linux
> -installation media for a distribution which includes Speakup as a part
> -of its kernel, you will be able, as a blind person, to install Linux
> -with speech access unaided by a sighted person.  Again, these details
> -are beyond the scope of this manual, but the user should be aware of
> -them.  See the web site mentioned above for further details.
> -
> -1.  Starting Speakup
> -
> -If your system administrator has installed Speakup to work with your
> -specific synthesizer by default, then all you need to do to use Speakup
> -is to boot your system, and Speakup should come up talking.  This
> -assumes of course  that your synthesizer is a supported hardware
> -synthesizer, and that it is either installed in or connected to your
> -system, and is if necessary powered on.
> -
> -It is possible, however, that Speakup may have been compiled into the
> -kernel with no default synthesizer.  It is even possible that your
> -kernel has been compiled with support for some of the supported
> -synthesizers and not others.  If you find that this is the case, and
> -your synthesizer is supported but not available, complain to the person
> -who compiled and installed your kernel.  Or better yet, go to the web
> -site, and learn how to patch Speakup into your own kernel source, and
> -build and install your own kernel.
> -
> -If your kernel has been compiled with Speakup, and has no default
> -synthesizer set, or you would like to use a different synthesizer than
> -the default one, then you may issue the following command at the boot
> -prompt of your boot loader.
> -
> -linux speakup.synth=ltlk
> -
> -This command would tell Speakup to look for and use a LiteTalk or
> -DoubleTalk LT at boot up.  You may replace the ltlk synthesizer keyword
> -with the keyword for whatever synthesizer you wish to use.  The
> -speakup.synth parameter will accept the following keywords, provided
> -that support for the related synthesizers has been built into the
> -kernel.
> -
> -acntsa -- Accent SA
> -acntpc -- Accent PC
> -apollo -- Apollo
> -audptr -- Audapter
> -bns -- Braille 'n Speak
> -dectlk -- DecTalk Express (old and new, db9 serial only)
> -decext -- DecTalk (old) External
> -dtlk -- DoubleTalk PC
> -keypc -- Keynote Gold PC
> -ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
> -spkout -- Speak Out
> -txprt -- Transport
> -dummy -- Plain text terminal
> -
> -Note: Speakup does * NOT * support usb connections!  Speakup also does *
> -NOT * support the internal Tripletalk!
> -
> -Speakup does support two other synthesizers, but because they work in
> -conjunction with other software, they must be loaded as modules after
> -their related software is loaded, and so are not available at boot up.
> -These are as follows:
> -
> -decpc -- DecTalk PC (not available at boot up)
> -soft -- One of several software synthesizers (not available at boot up)
> -
> -See the sections on loading modules and software synthesizers later in
> -this manual for further details.  It should be noted here that the
> -speakup.synth boot parameter will have no effect if Speakup has been
> -compiled as modules.  In order for Speakup modules to be loaded during
> -the boot process, such action must be configured by your system
> -administrator.  This will mean that you will hear some, but not all,  of
> -the bootup messages.
> -
> -2.  Basic operation
> -
> -Once you have booted the system, and if necessary, have supplied the
> -proper bootup parameter for your synthesizer, Speakup will begin
> -talking as soon as the kernel is loaded.  In fact, it will talk a lot!
> -It will speak all the boot up messages that the kernel prints on the
> -screen during the boot process.  This is because Speakup is not a
> -separate screen reader, but is actually built into the operating
> -system.  Since almost all console applications must print text on the
> -screen using the kernel, and must get their keyboard input through the
> -kernel, they are automatically handled properly by Speakup.  There are a
> -few exceptions, but we'll come to those later.
> -
> -Note:  In this guide I will refer to the numeric keypad as the keypad.
> -This is done because the speakupmap.map file referred to later in this
> -manual uses the term keypad instead of numeric keypad.  Also I'm lazy
> -and would rather only type one word.  So keypad it is.  Got it?  Good.
> -
> -Most of the Speakup review keys are located on the keypad at the far
> -right of the keyboard.  The numlock key should be off, in order for these
> -to work.  If you toggle the numlock on, the keypad will produce numbers,
> -which is exactly what you want for spreadsheets and such.  For the
> -purposes of this guide, you should have the numlock turned off, which is
> -its default state at bootup.
> -
> -You probably won't want to listen to all the bootup messages every time
> -you start your system, though it's a good idea to listen to them at
> -least once, just so you'll know what kind of information is available to
> -you during the boot process.  You can always review these messages after
> -bootup with the command:
> -
> -dmesg | more
> -
> -In order to speed the boot process, and to silence the speaking of the
> -bootup messages, just press the keypad enter key.  This key is located
> -in the bottom right corner of the keypad.  Speakup will shut up and stay
> -that way, until you press another key.
> -
> -You can check to see if the boot process has completed by pressing the 8
> -key on the keypad, which reads the current line.  This also has the
> -effect of starting Speakup talking again, so you can press keypad enter
> -to silence it again if the boot process has not completed.
> -
> -When the boot process is complete, you will arrive at a "login" prompt.
> -At this point, you'll need to type in your user id and password, as
> -provided by your system administrator.  You will hear Speakup speak the
> -letters of your user id as you type it, but not the password.  This is
> -because the password is not displayed on the screen for security
> -reasons.  This has nothing to do with Speakup, it's a Linux security
> -feature.
> -
> -Once you've logged in, you can run any Linux command or program which is
> -allowed by your user id.  Normal users will not be able to run programs
> -which require root privileges.
> -
> -When you are running a program or command, Speakup will automatically
> -speak new text as it arrives on the screen.  You can at any time silence
> -the speech with keypad enter, or use any of the Speakup review keys.
> -
> -Here are some basic Speakup review keys, and a short description of what
> -they do.
> -
> -keypad 1 -- read previous character
> -keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
> -	the current character phonetically)
> -keypad 3 -- read next character
> -keypad 4 -- read previous word
> -keypad 5 -- read current word (press twice rapidly to spell the current word)
> -keypad 6 -- read next word
> -keypad 7 -- read previous line
> -keypad 8 -- read current line (press twice rapidly to hear how much the
> -	text on the current line is indented)
> -keypad 9 -- read next line
> -keypad period -- speak current cursor position and announce current
> -	virtual console
> -
> -It's also worth noting that the insert key on the keypad is mapped
> -as the speakup key.  Instead of pressing and releasing this key, as you
> -do under DOS or Windows, you hold it like a shift key, and press other
> -keys in combination with it.  For example, repeatedly holding keypad
> -insert, from now on called speakup, and keypad enter will toggle the
> -speaking of new text on the screen on and off.  This is not the same as
> -just pressing keypad enter by itself, which just silences the speech
> -until you hit another key.  When you hit speakup plus keypad enter,
> -Speakup will say, "You turned me off.", or "Hey, that's better."  When
> -Speakup is turned off, no new text on the screen will be spoken.  You
> -can still use the reading controls to review the screen however.
> -
> -3.  Using the Speakup Help System
> -
> -In order to enter the Speakup help system, press and hold the speakup
> -key (remember that this is the keypad insert key), and press the f1 key.
> -You will hear the message:
> -
> -"Press space to leave help, cursor up or down to scroll, or a letter to
> -go to commands in list."
> -
> -When you press the spacebar to leave the help system, you will hear:
> -
> -"Leaving help."
> -
> -While you are in the Speakup help system, you can scroll up or down
> -through the list of available commands using the cursor keys.  The list
> -of commands is arranged in alphabetical order.  If you wish to jump to
> -commands in a specific part of the alphabet, you may press the letter of
> -the alphabet you wish to jump to.
> -
> -You can also just explore by typing keyboard keys.  Pressing keys will
> -cause Speakup to speak the command associated with that key.  For
> -example, if you press the keypad 8 key, you will hear:
> -
> -"Keypad 8 is line, say current."
> -
> -You'll notice that some commands do not have keys assigned to them.
> -This is because they are very infrequently used commands, and are also
> -accessible through the sys system.  We'll discuss the sys system later
> -in this manual.
> -
> -You'll also notice that some commands have two keys assigned to them.
> -This is because Speakup has a built in set of alternative key bindings
> -for laptop users.  The alternate speakup key is the caps lock key.  You
> -can press and hold the caps lock key, while pressing an alternate
> -speakup command key to activate the command.  On most laptops, the
> -numeric keypad is defined as the keys in the j k l area of the keyboard.
> -
> -There is usually a function key which turns this keypad function on and
> -off, and some other key which controls the numlock state.  Toggling the
> -keypad functionality on and off can become a royal pain.  So, Speakup
> -gives you a simple way to get at an alternative set of key mappings for
> -your laptop.  These are also available by default on desktop systems,
> -because Speakup does not know whether it is running on a desktop or
> -laptop.  So you may choose which set of Speakup keys to use.  Some
> -system administrators may have chosen to compile Speakup for a desktop
> -system without this set of alternate key bindings, but these details are
> -beyond the scope of this manual.  To use the caps lock for its normal
> -purpose, hold the shift key while toggling the caps lock on and off.  We
> -should note here, that holding the caps lock key and pressing the z key
> -will toggle the alternate j k l keypad on and off.
> -
> -4.  Keys and Their Assigned Commands
> -
> -In this section, we'll go through a list of all the speakup keys and
> -commands.  You can also get a list of commands and assigned keys from
> -the help system.
> -
> -The following list was taken from the speakupmap.map file.  Key
> -assignments are on the left of the equal sign, and the associated
> -Speakup commands are on the right.  The designation "spk" means to press
> -and hold the speakup key, a.k.a. keypad insert, a.k.a. caps lock, while
> -pressing the other specified key.
> -
> -spk key_f9 = punc_level_dec
> -spk key_f10 = punc_level_inc
> -spk key_f11 = reading_punc_dec
> -spk key_f12 = reading_punc_inc
> -spk key_1 = vol_dec
> -spk key_2 =  vol_inc
> -spk key_3 = pitch_dec
> -spk key_4 = pitch_inc
> -spk key_5 = rate_dec
> -spk key_6 = rate_inc
> -key_kpasterisk = toggle_cursoring
> -spk key_kpasterisk = speakup_goto
> -spk key_f1 = speakup_help
> -spk key_f2 = set_win
> -spk key_f3 = clear_win
> -spk key_f4 = enable_win
> -spk key_f5 = edit_some
> -spk key_f6 = edit_most
> -spk key_f7 = edit_delim
> -spk key_f8 = edit_repeat
> -shift spk key_f9 = edit_exnum
> - key_kp7 = say_prev_line
> -spk key_kp7 = left_edge
> - key_kp8 = say_line
> -double  key_kp8 = say_line_indent
> -spk key_kp8 = say_from_top
> - key_kp9 = say_next_line
> -spk  key_kp9 = top_edge
> - key_kpminus = speakup_parked
> -spk key_kpminus = say_char_num
> - key_kp4 = say_prev_word
> -spk key_kp4 = say_from_left
> - key_kp5 = say_word
> -double key_kp5 = spell_word
> -spk key_kp5 = spell_phonetic
> - key_kp6 = say_next_word
> -spk key_kp6 = say_to_right
> - key_kpplus = say_screen
> -spk key_kpplus = say_win
> - key_kp1 = say_prev_char
> -spk key_kp1 = right_edge
> - key_kp2 = say_char
> -spk key_kp2 = say_to_bottom
> -double key_kp2 = say_phonetic_char
> - key_kp3 = say_next_char
> -spk  key_kp3 = bottom_edge
> - key_kp0 = spk_key
> - key_kpdot = say_position
> -spk key_kpdot = say_attributes
> -key_kpenter = speakup_quiet
> -spk key_kpenter = speakup_off
> -key_sysrq = speech_kill
> - key_kpslash = speakup_cut
> -spk key_kpslash = speakup_paste
> -spk key_pageup = say_first_char
> -spk key_pagedown = say_last_char
> -key_capslock = spk_key
> - spk key_z = spk_lock
> -key_leftmeta = spk_key
> -ctrl spk key_0 = speakup_goto
> -spk key_u = say_prev_line
> -spk key_i = say_line
> -double spk key_i = say_line_indent
> -spk key_o = say_next_line
> -spk key_minus = speakup_parked
> -shift spk key_minus = say_char_num
> -spk key_j = say_prev_word
> -spk key_k = say_word
> -double spk key_k = spell_word
> -spk key_l = say_next_word
> -spk key_m = say_prev_char
> -spk key_comma = say_char
> -double spk key_comma = say_phonetic_char
> -spk key_dot = say_next_char
> -spk key_n = say_position
> - ctrl spk key_m = left_edge
> - ctrl spk key_y = top_edge
> - ctrl spk key_dot = right_edge
> -ctrl spk key_p = bottom_edge
> -spk key_apostrophe = say_screen
> -spk key_h = say_from_left
> -spk key_y = say_from_top
> -spk key_semicolon = say_to_right
> -spk key_p = say_to_bottom
> -spk key_slash = say_attributes
> - spk key_enter = speakup_quiet
> - ctrl  spk key_enter = speakup_off
> - spk key_9 = speakup_cut
> -spk key_8 = speakup_paste
> -shift spk key_m = say_first_char
> - ctrl spk key_semicolon = say_last_char
> -spk key_r = read_all_doc
> -
> -5.  The Speakup Sys System
> -
> -The Speakup screen reader also creates a speakup subdirectory as a part
> -of the sys system.
> -
> -As a convenience, run as root
> -
> -ln -s /sys/accessibility/speakup /speakup
> -
> -to directly access speakup parameters from /speakup.
> -You can see these entries by typing the command:
> -
> -ls -1 /speakup/*
> -
> -If you issue the above ls command, you will get back something like
> -this:
> -
> -/speakup/attrib_bleep
> -/speakup/bell_pos
> -/speakup/bleep_time
> -/speakup/bleeps
> -/speakup/cursor_time
> -/speakup/delimiters
> -/speakup/ex_num
> -/speakup/key_echo
> -/speakup/keymap
> -/speakup/no_interrupt
> -/speakup/punc_all
> -/speakup/punc_level
> -/speakup/punc_most
> -/speakup/punc_some
> -/speakup/reading_punc
> -/speakup/repeats
> -/speakup/say_control
> -/speakup/say_word_ctl
> -/speakup/silent
> -/speakup/spell_delay
> -/speakup/synth
> -/speakup/synth_direct
> -/speakup/version
> -
> -/speakup/i18n:
> -announcements
> -characters
> -chartab
> -colors
> -ctl_keys
> -formatted
> -function_names
> -key_names
> -states
> -
> -/speakup/soft:
> -caps_start
> -caps_stop
> -delay_time
> -direct
> -freq
> -full_time
> -jiffy_delta
> -pitch
> -inflection
> -punct
> -rate
> -tone
> -trigger_time
> -voice
> -vol
> -
> -Notice the two subdirectories of /speakup: /speakup/i18n and
> -/speakup/soft.
> -The i18n subdirectory is described in a later section.
> -The files under /speakup/soft represent settings that are specific to the
> -driver for the software synthesizer.  If you use the LiteTalk, your
> -synthesizer-specific settings would be found in /speakup/ltlk.  In other words,
> -a subdirectory named /speakup/KWD is created to hold parameters specific
> -to the device whose keyword is KWD.
> -These parameters include volume, rate, pitch, and others.
> -
> -In addition to using the Speakup hot keys to change such things as
> -volume, pitch, and rate, you can also echo values to the appropriate
> -entry in the /speakup directory.  This is very useful, since it
> -lets you control Speakup parameters from within a script.  How you
> -would write such scripts is somewhat beyond the scope of this manual,
> -but I will include a couple of simple examples here to give you a
> -general idea of what such scripts can do.
> -
> -Suppose for example, that you wanted to control both the punctuation
> -level and the reading punctuation level at the same time.  For
> -simplicity, we'll call them punc0, punc1, punc2, and punc3.  The scripts
> -might look something like this:
> -
> -#!/bin/bash
> -# punc0
> -# set punc and reading punc levels to 0
> -echo 0 >/speakup/punc_level
> -echo 0 >/speakup/reading_punc
> -echo Punctuation level set to 0.
> -
> -#!/bin/bash
> -# punc1
> -# set punc and reading punc levels to 1
> -echo 1 >/speakup/punc_level
> -echo 1 >/speakup/reading_punc
> -echo Punctuation level set to 1.
> -
> -#!/bin/bash
> -# punc2
> -# set punc and reading punc levels to 2
> -echo 2 >/speakup/punc_level
> -echo 2 >/speakup/reading_punc
> -echo Punctuation level set to 2.
> -
> -#!/bin/bash
> -# punc3
> -# set punc and reading punc levels to 3
> -echo 3 >/speakup/punc_level
> -echo 3 >/speakup/reading_punc
> -echo Punctuation level set to 3.
> -
> -If you were to store these four small scripts in a directory in your
> -path, perhaps /usr/local/bin, and set the permissions to 755 with the
> -chmod command, then you could change the default reading punc and
> -punctuation levels at the same time by issuing just one command.  For
> -example, if you were to execute the punc3 command at your shell prompt,
> -then the reading punc and punc level would both get set to 3.
> -
> -I should note that the above scripts were written to work with bash, but
> -regardless of which shell you use, you should be able to do something
> -similar.
> -
> -The Speakup sys system also has another interesting use.  You can echo
> -Speakup parameters into the sys system in a script during system
> -startup, and speakup will return to your preferred parameters every time
> -the system is rebooted.
> -
> -Most of the Speakup sys parameters can be manipulated by a regular user
> -on the system.  However, there are a few parameters that are dangerous
> -enough that they should only be manipulated by the root user on your
> -system.  There are even some parameters that are read only, and cannot
> -be written to at all.  For example, the version entry in the Speakup
> -sys system is read only.  This is because there is no reason for a user
> -to tamper with the version number which is reported by Speakup.  Doing
> -an ls -l on /speakup/version will return this:
> -
> --r--r--r--    1 root     root            0 Mar 21 13:46 /speakup/version
> -
> -As you can see, the version entry in the Speakup sys system is read
> -only, is owned by root, and belongs to the root group.  Doing a cat of
> -/speakup/version will display the Speakup version number, like
> -this:
> -
> -cat /speakup/version
> -Speakup v-2.00 CVS: Thu Oct 21 10:38:21 EDT 2004
> -synth dtlk version 1.1
> -
> -The display shows the Speakup version number, along with the version
> -number of the driver for the current synthesizer.
> -
> -Looking at entries in the Speakup sys system can be useful in many
> -ways.  For example, you might wish to know what level your volume is set
> -at.  You could type:
> -
> -cat /speakup/KWD/vol
> -# Replace KWD with the keyword for your synthesizer, E.G., ltlk for LiteTalk.
> -5
> -
> -The number five which comes back is the level at which the synthesizer
> -volume is set at.
> -
> -All the entries in the Speakup sys system are readable, some are
> -writable by root only, and some are writable by everyone.  Unless you
> -know what you are doing, you should probably leave the ones that are
> -writable by root only alone.  Most of the names are self explanatory.
> -Vol for controlling volume, pitch for pitch, inflection for pitch range, rate
> -for controlling speaking rate, etc.  If you find one you aren't sure about, you
> -can post a query on the Speakup list.
> -
> -6.  Changing Synthesizers
> -
> -It is possible to change to a different synthesizer while speakup is
> -running.  In other words, it is not necessary to reboot the system
> -in order to use a different synthesizer.  You can simply echo the
> -synthesizer keyword to the /speakup/synth sys entry.
> -Depending on your situation, you may wish to echo none to the synth
> -sys entry, to disable speech while one synthesizer is disconnected and
> -a second one is connected in its place.  Then echo the keyword for the
> -new synthesizer into the synth sys entry in order to start speech
> -with the newly connected synthesizer.  See the list of synthesizer
> -keywords in section 1 to find the keyword which matches your synth.
> -
> -7.  Loading modules
> -
> -As mentioned earlier, Speakup can either be completely compiled into the
> -kernel, with the exception of the help module, or it can be compiled as
> -a series of modules.   When compiled as modules, Speakup will only be
> -able to speak some of the bootup messages if your system administrator
> -has configured the system to load the modules at boo time. The modules
> -can  be loaded after the file systems have been checked and mounted, or
> -from an initrd.  There is a third possibility.  Speakup can be compiled
> -with some components built into the kernel, and others as modules.  As
> -we'll see in the next section, this is particularly useful when you are
> -working with software synthesizers.
> -
> -If Speakup is completely compiled as modules, then you must use the
> -modprobe command to load Speakup.  You do this by loading the module for
> -the synthesizer driver you wish to use.  The driver modules are all
> -named speakup_<keyword>, where <keyword> is the keyword for the
> -synthesizer you want.  So, in order to load the driver for the DecTalk
> -Express, you would type the following command:
> -
> -modprobe speakup_dectlk
> -
> -Issuing this command would load the DecTalk Express driver and all other
> -related Speakup modules necessary to get Speakup up and running.
> -
> -To completely unload Speakup, again presuming that it is entirely built
> -as modules, you would give the command:
> -
> -modprobe -r speakup_dectlk
> -
> -The above command assumes you were running a DecTalk Express.  If you
> -were using a different synth, then you would substitute its keyword in
> -place of dectlk.
> -
> -If you have multiple drivers loaded, you need to unload all of them, in
> -order to completely unload Speakup.
> -For example, if you have loaded both the dectlk and ltlk drivers, use the
> -command:
> -modprobe -r speakup_dectlk speakup_ltlk
> -
> -You cannot unload the driver for software synthesizers when a user-space
> -daemon is using /dev/softsynth.  First, kill the daemon.  Next, remove
> -the driver with the command:
> -modprobe -r speakup_soft
> -
> -Now, suppose we have a situation where the main Speakup component
> -is built into the kernel, and some or all of the drivers are built as
> -modules.  Since the main part of Speakup is compiled into the kernel, a
> -partial Speakup sys system has been created which we can take advantage
> -of by simply echoing the synthesizer keyword into the
> -/speakup/synth sys entry.  This will cause the kernel to
> -automatically load the appropriate driver module, and start Speakup
> -talking.  To switch to another synth, just echo a new keyword to the
> -synth sys entry.  For example, to load the DoubleTalk LT driver,
> -you would type:
> -
> -echo ltlk >/speakup/synth
> -
> -You can use the modprobe -r command to unload driver modules, regardless
> -of whether the main part of Speakup has been built into the kernel or
> -not.
> -
> -8.  Using Software Synthesizers
> -
> -Using a software synthesizer requires that some other software be
> -installed and running on your system.  For this reason, software
> -synthesizers are not available for use at bootup, or during a system
> -installation process.
> -There are two freely-available solutions for software speech: Espeakup and
> -Speech Dispatcher.
> -These are described in subsections 8.1 and 8.2, respectively.
> -
> -During the rest of this section, we assume that speakup_soft is either
> -built in to your kernel, or loaded as a module.
> -
> -If your system does not have udev installed , before you can use a
> -software synthesizer, you must have created the /dev/softsynth device.
> -If you have not already done so, issue the following commands as root:
> -
> -cd /dev
> -mknod softsynth c 10 26
> -
> -While we are at it, we might just as well create the /dev/synth device,
> -which can be used to let user space programs send information to your
> -synthesizer.  To create /dev/synth, change to the /dev directory, and
> -issue the following command as root:
> -
> -mknod synth c 10 25
> -
> -of both.
> -
> -8.1. Espeakup
> -
> -Espeakup is a connector between Speakup and the eSpeak software synthesizer.
> -Espeakup may already be available as a package for your distribution
> -of Linux.  If it is not packaged, you need to install it manually.
> -You can find it in the contrib/ subdirectory of the Speakup sources.
> -The filename is espeakup-$VERSION.tar.bz2, where $VERSION
> -depends on the current release of Espeakup.  The Speakup 3.1.2 source
> -ships with version 0.71 of Espeakup.
> -The README file included with the Espeakup sources describes the process
> -of manual installation.
> -
> -Assuming that Espeakup is installed, either by the user or by the distributor,
> -follow these steps to use it.
> -
> -Tell Speakup to use the "soft driver:
> -echo soft > /speakup/synth
> -
> -Finally, start the espeakup program.  There are two ways to do it.
> -Both require root privileges.
> -
> -If Espeakup was installed as a package for your Linux distribution,
> -you probably have a distribution-specific script that controls the operation
> -of the daemon.  Look for a file named espeakup under /etc/init.d or
> -/etc/rc.d.  Execute the following command with root privileges:
> -/etc/init.d/espeakup start
> -Replace init.d with rc.d, if your distribution uses scripts located under
> -/etc/rc.d.
> -Your distribution will also have a procedure for starting daemons at
> -boot-time, so it is possible to have software speech as soon as user-space
> -daemons are started by the bootup scripts.
> -These procedures are not described in this document.
> -
> -If you built Espeakup manually, the "make install" step placed the binary
> -under /usr/bin.
> -Run the following command as root:
> -/usr/bin/espeakup
> -Espeakup should start speaking.
> -
> -8.2. Speech Dispatcher
> -
> -For this option, you must have a package called
> -Speech Dispatcher running on your system, and it must be configured to
> -work with one of its supported software synthesizers.
> -
> -Two open source synthesizers you might use are Flite and Festival.  You
> -might also choose to purchase the Software DecTalk from Fonix Sales Inc.
> -If you run a google search for Fonix, you'll find their web site.
> -
> -You can obtain a copy of Speech Dispatcher from free(b)soft at
> -http://www.freebsoft.org/.  Follow the installation instructions that
> -come with Speech Dispatcher in order to install and configure Speech
> -Dispatcher.  You can check out the web site for your Linux distribution
> -in order to get a copy of either Flite or Festival.  Your Linux
> -distribution may also have a precompiled Speech Dispatcher package.
> -
> -Once you've installed, configured, and tested Speech Dispatcher with your
> -chosen software synthesizer, you still need one more piece of software
> -in order to make things work.  You need a package called speechd-up.
> -You get it from the free(b)soft web site mentioned above.  After you've
> -compiled and installed speechd-up, you are almost ready to begin using
> -your software synthesizer.
> -
> -Now you can begin using your software synthesizer.  In order to do so,
> -echo the soft keyword to the synth sys entry like this:
> -
> -echo soft >/speakup/synth
> -
> -Next run the speechd_up command like this:
> -
> -speechd_up &
> -
> -Your synth should now start talking, and you should be able to adjust
> -the pitch, rate, etc.
> -
> -9.  Using The DecTalk PC Card
> -
> -The DecTalk PC card is an ISA card that is inserted into one of the ISA
> -slots in your computer.  It requires that the DecTalk PC software be
> -installed on your computer, and that the software be loaded onto the
> -Dectalk PC card before it can be used.
> -
> -You can get the dec_pc.tgz file from the linux-speakup.org site.  The
> -dec_pc.tgz file is in the ~ftp/pub/linux/speakup directory.
> -
> -After you have downloaded the dec_pc.tgz file, untar it in your home
> -directory, and read the Readme file in the newly created dec_pc
> -directory.
> -
> -The easiest way to get the software working is to copy the entire dec_pc
> -directory into /user/local/lib.  To do this, su to root in your home
> -directory, and issue the command:
> -
> -cp dec_pc /usr/local/lib
> -
> -You will need to copy the dtload command from the dec_pc directory to a
> -directory in your path.  Either /usr/bin or /usr/local/bin is a good
> -choice.
> -
> -You can now run the dtload command in order to load the DecTalk PC
> -software onto the card.  After you have done this, echo the decpc
> -keyword to the synth entry in the sys system like this:
> -
> -echo decpc >/speakup/synth
> -
> -Your DecTalk PC should start talking, and then you can adjust the pitch,
> -rate, volume, voice, etc.  The voice entry in the Speakup sys system
> -will accept a number from 0 through 7 for the DecTalk PC synthesizer,
> -which will give you access to some of the DecTalk voices.
> -
> -10.  Using Cursor Tracking
> -
> -In Speakup version 2.0 and later, cursor tracking is turned on by
> -default.  This means that when you are using an editor, Speakup will
> -automatically speak characters as you move left and right with the
> -cursor keys, and lines as you move up and down with the cursor keys.
> -This is the traditional sort of cursor tracking.
> -Recent versions of Speakup provide two additional ways to control the
> -text that is spoken when the cursor is moved:
> -"highlight tracking" and "read window."
> -They are described later in this section.
> -Sometimes, these modes get in your way, so you can disable cursor tracking
> -altogether.
> -
> -You may select among the various forms of cursor tracking using the keypad
> -asterisk key.
> -Each time you press this key, a new mode is selected, and Speakup speaks
> -the name of the new mode.  The names for the four possible states of cursor
> -tracking are: "cursoring on", "highlight tracking", "read window",
> -and "cursoring off."  The keypad asterisk key moves through the list of
> -modes in a circular fashion.
> -
> -If highlight tracking is enabled, Speakup tracks highlighted text,
> -rather than the cursor itself. When you move the cursor with the arrow keys,
> -Speakup speaks the currently highlighted information.
> -This is useful when moving through various menus and dialog boxes.
> -If cursor tracking isn't helping you while navigating a menu,
> -try highlight tracking.
> -
> -With the "read window" variety of cursor tracking, you can limit the text
> -that Speakup speaks by specifying a window of interest on the screen.
> -See section 15 for a description of the process of defining windows.
> -When you move the cursor via the arrow keys, Speakup only speaks
> -the contents of the window.  This is especially helpful when you are hearing
> -superfluous speech.  Consider the following example.
> -
> -Suppose that you are at a shell prompt.  You use bash, and you want to
> -explore your command history using the up and down arrow keys.  If you
> -have enabled cursor tracking, you will hear two pieces of information.
> -Speakup speaks both your shell prompt and the current entry from the
> -command history.  You may not want to hear the prompt repeated
> -each time you move, so you can silence it by specifying a window.  Find
> -the last line of text on the screen.  Clear the current window by pressing
> -the key combination speakup f3.  Use the review cursor to find the first
> -character that follows your shell prompt.  Press speakup + f2 twice, to
> -define a one-line window.  The boundaries of the window are the
> -character following the shell prompt and the end of the line.  Now, cycle
> -through the cursor tracking modes using keypad asterisk, until Speakup
> -says "read window."  Move through your history using your arrow keys.
> -You will notice that Speakup no longer speaks the redundant prompt.
> -
> -Some folks like to turn cursor tracking off while they are using the
> -lynx web browser.  You definitely want to turn cursor tracking off when
> -you are using the alsamixer application.  Otherwise, you won't be able
> -to hear your mixer settings while you are using the arrow keys.
> -
> -11.  Cut and Paste
> -
> -One of Speakup's more useful features is the ability to cut and paste
> -text on the screen.  This means that you can capture information from a
> -program, and paste that captured text into a different place in the
> -program, or into an entirely different program, which may even be
> -running on a different console.
> -
> -For example, in this manual, we have made references to several web
> -sites.  It would be nice if you could cut and paste these urls into your
> -web browser.  Speakup does this quite nicely.  Suppose you wanted to
> -past the following url into your browser:
> -
> -http://linux-speakup.org/
> -
> -Use the speakup review keys to position the reading cursor on the first
> -character of the above url.  When the reading cursor is in position,
> -press the keypad slash key once.  Speakup will say, "mark".  Next,
> -position the reading cursor on the rightmost character of the above
> -url. Press the keypad slash key once again to actually cut the text
> -from the screen.  Speakup will say, "cut".  Although we call this
> -cutting, Speakup does not actually delete the cut text from the screen.
> -It makes a copy of the text in a special buffer for later pasting.
> -
> -Now that you have the url cut from the screen, you can paste it into
> -your browser, or even paste the url on a command line as an argument to
> -your browser.
> -
> -Suppose you want to start lynx and go to the Speakup site.
> -
> -You can switch to a different console with the alt left and right
> -arrows, or you can switch to a specific console by typing alt and a
> -function key.  These are not Speakup commands, just standard Linux
> -console capabilities.
> -
> -Once you've changed to an appropriate console, and are at a shell prompt,
> -type the word lynx, followed by a space.  Now press and hold the speakup
> -key, while you type the keypad slash character.  The url will be pasted
> -onto the command line, just as though you had typed it in.  Press the
> -enter key to execute the command.
> -
> -The paste buffer will continue to hold the cut information, until a new
> -mark and cut operation is carried out.  This means you can paste the cut
> -information as many times as you like before doing another cut
> -operation.
> -
> -You are not limited to cutting and pasting only one line on the screen.
> -You can also cut and paste rectangular regions of the screen.  Just
> -position the reading cursor at the top left corner of the text to be
> -cut, mark it with the keypad slash key, then position the reading cursor
> -at the bottom right corner of the region to be cut, and cut it with the
> -keypad slash key.
> -
> -12.  Changing the Pronunciation of Characters
> -
> -Through the /speakup/i18n/characters sys entry, Speakup gives you the
> -ability to change how Speakup pronounces a given character.  You could,
> -for example, change how some punctuation characters are spoken.  You can
> -even change how Speakup will pronounce certain letters.
> -
> -You may, for example, wish to change how Speakup pronounces the z
> -character.  The author of Speakup, Kirk Reiser, is Canadian, and thus
> -believes that the z should be pronounced zed.  If you are an American,
> -you might wish to use the zee pronunciation instead of zed.  You can
> -change the pronunciation of both the upper and lower case z with the
> -following two commands:
> -
> -echo 90 zee >/speakup/characters
> -echo 122 zee >/speakup/characters
> -
> -Let's examine the parts of the two previous commands.  They are issued
> -at the shell prompt, and could be placed in a startup script.
> -
> -The word echo tells the shell that you want to have it display the
> -string of characters that follow the word echo.  If you were to just
> -type:
> -
> -echo hello.
> -
> -You would get the word hello printed on your screen as soon as you
> -pressed the enter key.  In this case, we are echoing strings that we
> -want to be redirected into the sys system.
> -
> -The numbers 90 and 122 in the above echo commands are the ascii numeric
> -values for the upper and lower case z, the characters we wish to change.
> -
> -The string zee is the pronunciation that we want Speakup to use for the
> -upper and lower case z.
> -
> -The > symbol redirects the output of the echo command to a file, just
> -like in DOS, or at the Windows command prompt.
> -
> -And finally, /speakup/i18n/characters is the file entry in the sys system
> -where we want the output to be directed.  Speakup looks at the numeric
> -value of the character we want to change, and inserts the pronunciation
> -string into an internal table.
> -
> -You can look at the whole table with the following command:
> -
> -cat /speakup/i18n/characters
> -
> -Speakup will then print out the entire character pronunciation table.  I
> -won't display it here, but leave you to look at it at your convenience.
> -
> -13.  Mapping Keys
> -
> -Speakup has the capability of allowing you to assign or "map" keys to
> -internal Speakup commands.  This section necessarily assumes you have a
> -Linux kernel source tree installed, and that it has been patched and
> -configured with Speakup.  How you do this is beyond the scope of this
> -manual.  For this information, visit the Speakup web site at
> -http://linux-speakup.org/.  The reason you'll need the kernel source
> -tree patched with Speakup is that the genmap utility you'll need for
> -processing keymaps is in the
> -/usr/src/linux-<version_number>/drivers/char/speakup directory.  The
> -<version_number> in the above directory path is the version number of
> -the Linux source tree you are working with.
> -
> -So ok, you've gone off and gotten your kernel source tree, and patched
> -and configured it.  Now you can start manipulating keymaps.
> -
> -You can either use the
> -/usr/src/linux-<version_number>/drivers/char/speakup/speakupmap.map file
> -included with the Speakup source, or you can cut and paste the copy in
> -section 4 into a separate file.  If you use the one in the Speakup
> -source tree, make sure you make a backup of it before you start making
> -changes.  You have been warned!
> -
> -Suppose that you want to swap the key assignments for the Speakup
> -say_last_char and the Speakup say_first_char commands.  The
> -speakupmap.map lists the key mappings for these two commands as follows:
> -
> -spk key_pageup = say_first_char
> -spk key_pagedown = say_last_char
> -
> -You can edit your copy of the speakupmap.map file and swap the command
> -names on the right side of the = (equals) sign.  You did make a backup,
> -right?  The new keymap lines would look like this:
> -
> -spk key_pageup = say_last_char
> -spk key_pagedown = say_first_char
> -
> -After you edit your copy of the speakupmap.map file, save it under a new
> -file name, perhaps newmap.map.  Then exit your editor and return to the
> -shell prompt.
> -
> -You are now ready to load your keymap with your swapped key assignments.
> - Assuming that you saved your new keymap as the file newmap.map, you
> -would load your keymap into the sys system like this:
> -
> -/usr/src/linux-<version_number>/drivers/char/speakup/genmap newmap.map
> ->/speakup/keymap
> -
> -Remember to substitute your kernel version number for the
> -<version_number> in the above command.  Also note that although the
> -above command wrapped onto two lines in this document, you should type
> -it all on one line.
> -
> -Your say first and say last characters should now be swapped.  Pressing
> -speakup pagedown should read you the first non-whitespace character on
> -the line your reading cursor is in, and pressing speakup pageup should
> -read you the last character on the line your reading cursor is in.
> -
> -You should note that these new mappings will only stay in effect until
> -you reboot, or until you load another keymap.
> -
> -One final warning.  If you try to load a partial map, you will quickly
> -find that all the mappings you didn't include in your file got deleted
> -from the working map.  Be extremely careful, and always make a backup!
> -You have been warned!
> -
> -14.  Internationalizing Speakup
> -
> -Speakup indicates various conditions to the user by speaking messages.
> -For instance, when you move to the left edge of the screen with the
> -review keys, Speakup says, "left."
> -Prior to version 3.1.0 of Speakup, all of these messages were in English,
> -and they could not be changed.  If you used a non-English synthesizer,
> -you still heard English messages, such as "left" and "cursoring on."
> -In version 3.1.0 or higher, one may load translations for the various
> -messages via the /sys filesystem.
> -
> -The directory /speakup/i18n contains several collections of messages.
> -Each group of messages is stored in its own file.
> -The following section lists all of these files, along with a brief description
> -of each.
> -
> -14.1.  Files Under the i18n Subdirectory
> -
> -* announcements:
> -This file contains various general announcements, most of which cannot
> -be categorized.  You will find messages such as "You killed Speakup",
> -"I'm alive", "leaving help", "parked", "unparked", and others.
> -You will also find the names of the screen edges and cursor tracking modes
> -here.
> -
> -* characters:
> -See section 12 for a description of this file.
> -
> -* chartab:
> -See section 12.  Unlike the rest of the files in the i18n subdirectory,
> -this one does not contain messages to be spoken.
> -
> -* colors:
> -When you use the "say attributes" function, Speakup says the name of the
> -foreground and background colors.  These names come from the i18n/colors
> -file.
> -
> -* ctl_keys:
> -Here, you will find names of control keys.  These are used with Speakup's
> -say_control feature.
> -
> -* formatted:
> -This group of messages contains embedded formatting codes, to specify
> -the type and width of displayed data.  If you change these, you must
> -preserve all of the formatting codes, and they must appear in the order
> -used by the default messages.
> -
> -* function_names:
> -Here, you will find a list of names for Speakup functions.  These are used
> -by the help system.  For example, suppose that you have activated help mode,
> -and you pressed keypad 3.  Speakup says:
> -"keypad 3 is character, say next."
> -The message "character, say next" names a Speakup function, and it
> -comes from this function_names file.
> -
> -* key_names:
> -Again, key_names is used by Speakup's help system.  In the previous
> -example, Speakup said that you pressed "keypad 3."
> -This name came from the key_names file.
> -
> -* states:
> -This file contains names for key states.
> -Again, these are part of the help system.  For instance, if you had pressed
> -speakup + keypad 3, you would hear:
> -"speakup keypad 3 is go to bottom edge."
> -The speakup key is depressed, so the name of the key state is speakup.
> -This part of the message comes from the states collection.
> -
> -14.2.  Changing language
> -
> -14.2.1. Loading Your Own Messages
> -
> -The files under the i18n subdirectory all follow the same format.
> -They consist of lines, with one message per line.
> -Each message is represented by a number, followed by the text of the message.
> -The number is the position of the message in the given collection.
> -For example, if you view the file /speakup/i18n/colors, you will see the
> -following list:
> -
> -0	black
> -1	blue
> -2	green
> -3	cyan
> -4	red
> -5	magenta
> -6	yellow
> -7	white
> -8	grey
> -
> -You can change one message, or you can change a whole group.
> -To load a whole collection of messages from a new source, simply use
> -the cp command:
> -cp ~/my_colors /speakup/i18n/colors
> -You can change an individual message with the echo command,
> -as shown in the following example.
> -
> -The Spanish name for the color blue is azul.
> -Looking at the colors file, we see that the name "blue" is at position 1
> -within the colors group.  Let's change blue to azul:
> -echo '1 azul' > /speakup/i18n/colors
> -The next time that Speakup says message 1 from the colors group, it will
> -say "azul", rather than "blue."
> -
> -14.2.2. Choose a language
> -
> -In the future, translations into various languages will be made available,
> -and most users will just load the files necessary for their language. So far,
> -only French language is available beyond native Canadian English language.
> -
> -French is only available after you are logged in.
> -
> -Canadian English is the default language. To toggle another language,
> -download the source of Speakup and untar it in your home directory. The
> -following command should let you do this:
> -
> -tar xvjf speakup-<version>.tar.bz2
> -
> -where <version> is the version number of the application.
> -
> -Next, change to the newly created directory, then into the tools/ directory, and
> -run the script speakup_setlocale. You are asked the language that you want to
> -use. Type the number associated to your language (e.g. fr for French) then press
> -Enter. Needed files are copied in the i18n directory.
> -
> -Note: the speakupconf must be installed on your system so that settings are saved.
> -Otherwise, you will have an error: your language will be loaded but you will
> -have to run the script again every time Speakup restarts.
> -See section 16.1. for information about speakupconf.
> -
> -You will have to repeat these steps for any change of locale, i.e. if you wish
> -change the speakup's language or charset (iso-8859-15 ou UTF-8).
> -
> -If you wish store the settings, note that at your next login, you will need to
> -do:
> -
> -speakup load
> -
> -Alternatively, you can add the above line to your file
> -~/.bashrc or ~/.bash_profile.
> -
> -If your system administrator ran himself the script, all the users will be able
> -to change from English to the language choosed by root and do directly
> -speakupconf load (or add this to the ~/.bashrc or
> -~/.bash_profile file). If there are several languages to handle, the
> -administrator (or every user) will have to run the first steps until speakupconf
> -save, choosing the appropriate language, in every user's home directory. Every
> -user will then be able to do speakupconf load, Speakup will load his own settings.
> -
> -14.3.  No Support for Non-Western-European Languages
> -
> -As of the current release, Speakup only supports Western European languages.
> -Support for the extended characters used by languages outside of the Western
> -European family of languages is a work in progress.
> -
> -15.  Using Speakup's Windowing Capability
> -
> -Speakup has the capability of defining and manipulating windows on the
> -screen.  Speakup uses the term "Window", to mean a user defined area of
> -the screen.  The key strokes for defining and manipulating Speakup
> -windows are as follows:
> -
> -speakup + f2 -- Set the bounds of the window.
> -Speakup + f3 -- clear the current window definition.
> -speakup + f4 -- Toggle window silence on and off.
> -speakup + keypad plus -- Say the currently defined window.
> -
> -These capabilities are useful for tracking a certain part of the screen
> -without rereading the whole screen, or for silencing a part of the
> -screen that is constantly changing, such as a clock or status line.
> -
> -There is no way to save these window settings, and you can only have one
> -window defined for each virtual console.  There is also no way to have
> -windows automatically defined for specific applications.
> -
> -In order to define a window, use the review keys to move your reading
> -cursor to the beginning of the area you want to define.  Then press
> -speakup + f2.  Speakup will tell you that the window starts at the
> -indicated row and column position.  Then move the reading cursor to the
> -end of the area to be defined as a window, and press speakup + f2 again.
> - If there is more than one line in the window, Speakup will tell you
> -that the window ends at the indicated row and column position.  If there
> -is only one line in the window, then Speakup will tell you that the
> -window is the specified line on the screen.  If you are only defining a
> -one line window, you can just press speakup + f2 twice after placing the
> -reading cursor on the line you want to define as a window.  It is not
> -necessary to position the reading cursor at the end of the line in order
> -to define the whole line as a window.
> -
> -16.  Tools for Controlling Speakup
> -
> -The speakup distribution includes extra tools (in the tools directory)
> -which were written to make speakup easier to use.  This section will
> -briefly describe the use of these tools.
> -
> -16.1.  Speakupconf
> -
> -speakupconf began life as a contribution from Steve Holmes, a member of
> -the speakup community.  We would like to thank him for his work on the
> -early versions of this project.
> -
> -This script may be installed as part of your linux distribution, but if
> -it isn't, the recommended places to put it are /usr/local/bin or
> -/usr/bin.  This script can be run by any user, so it does not require
> -root privileges.
> -
> -Speakupconf allows you to save and load your Speakup settings.  It works
> -by reading and writing the /sys files described above.
> -
> -The directory that speakupconf uses to store your settings depends on
> -whether it is run from the root account.  If you execute speakupconf as
> -root, it uses the directory /etc/speakup.  Otherwise, it uses the directory
> -~/.speakup, where ~ is your home directory.
> -Anyone who needs to use Speakup from your console can load his own custom
> -settings with this script.
> -
> -speakupconf takes one required argument: load or save.
> -Use the command
> -speakupconf save
> -to save your Speakup settings, and
> -speakupconf load
> -to load them into Speakup.
> -A second argument may be specified to use an alternate directory to
> -load or save the speakup parameters.
> -
> -16.2.  Talkwith
> -
> -Charles Hallenbeck, another member of the speakup community, wrote the
> -initial versions of this script, and we would also like to thank him for
> -his work on it.
> -
> -This script needs root privileges to run, so if it is not installed as
> -part of your linux distribution, the recommended places to install it
> -are /usr/local/sbin or /usr/sbin.
> -
> -Talkwith allows you to switch synthesizers on the fly.  It takes a synthesizer
> -name as an argument.  For instance,
> -talkwith dectlk
> -causes Speakup to use the DecTalk Express.  If you wish to switch to a
> -software synthesizer, you must also indicate which daemon you wish to
> -use.  There are two possible choices:
> -spd and espeakup.  spd is an abbreviation for speechd-up.
> -If you wish to use espeakup for software synthesis, give the command
> -talkwith soft espeakup
> -To use speechd-up, type:
> -talkwith soft spd
> -Any arguments that follow the name of the daemon are passed to the daemon
> -when it is invoked.  For instance:
> -talkwith espeakup --default-voice=fr
> -causes espeakup to use the French voice.
> -Note that talkwith must always be executed with root privileges.
> -
> -Talkwith does not attempt to load your settings after the new
> -synthesizer is activated.  You can use speakupconf to load your settings
> -if desired.
> -
> -                GNU Free Documentation License
> -                  Version 1.2, November 2002
> -
> -
> - Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
> - Everyone is permitted to copy and distribute verbatim copies
> - of this license document, but changing it is not allowed.
> -
> -
> -0. PREAMBLE
> -
> -The purpose of this License is to make a manual, textbook, or other
> -functional and useful document "free" in the sense of freedom: to
> -assure everyone the effective freedom to copy and redistribute it,
> -with or without modifying it, either commercially or noncommercially.
> -Secondarily, this License preserves for the author and publisher a way
> -to get credit for their work, while not being considered responsible
> -for modifications made by others.
> -
> -This License is a kind of "copyleft", which means that derivative
> -works of the document must themselves be free in the same sense.  It
> -complements the GNU General Public License, which is a copyleft
> -license designed for free software.
> -
> -We have designed this License in order to use it for manuals for free
> -software, because free software needs free documentation: a free
> -program should come with manuals providing the same freedoms that the
> -software does.  But this License is not limited to software manuals;
> -it can be used for any textual work, regardless of subject matter or
> -whether it is published as a printed book.  We recommend this License
> -principally for works whose purpose is instruction or reference.
> -
> -
> -1. APPLICABILITY AND DEFINITIONS
> -
> -This License applies to any manual or other work, in any medium, that
> -contains a notice placed by the copyright holder saying it can be
> -distributed under the terms of this License.  Such a notice grants a
> -world-wide, royalty-free license, unlimited in duration, to use that
> -work under the conditions stated herein.  The "Document", below,
> -refers to any such manual or work.  Any member of the public is a
> -licensee, and is addressed as "you".  You accept the license if you
> -copy, modify or distribute the work in a way requiring permission
> -under copyright law.
> -
> -A "Modified Version" of the Document means any work containing the
> -Document or a portion of it, either copied verbatim, or with
> -modifications and/or translated into another language.
> -
> -A "Secondary Section" is a named appendix or a front-matter section of
> -the Document that deals exclusively with the relationship of the
> -publishers or authors of the Document to the Document's overall subject
> -(or to related matters) and contains nothing that could fall directly
> -within that overall subject.  (Thus, if the Document is in part a
> -textbook of mathematics, a Secondary Section may not explain any
> -mathematics.)  The relationship could be a matter of historical
> -connection with the subject or with related matters, or of legal,
> -commercial, philosophical, ethical or political position regarding
> -them.
> -
> -The "Invariant Sections" are certain Secondary Sections whose titles
> -are designated, as being those of Invariant Sections, in the notice
> -that says that the Document is released under this License.  If a
> -section does not fit the above definition of Secondary then it is not
> -allowed to be designated as Invariant.  The Document may contain zero
> -Invariant Sections.  If the Document does not identify any Invariant
> -Sections then there are none.
> -
> -The "Cover Texts" are certain short passages of text that are listed,
> -as Front-Cover Texts or Back-Cover Texts, in the notice that says that
> -the Document is released under this License.  A Front-Cover Text may
> -be at most 5 words, and a Back-Cover Text may be at most 25 words.
> -
> -A "Transparent" copy of the Document means a machine-readable copy,
> -represented in a format whose specification is available to the
> -general public, that is suitable for revising the document
> -straightforwardly with generic text editors or (for images composed of
> -pixels) generic paint programs or (for drawings) some widely available
> -drawing editor, and that is suitable for input to text formatters or
> -for automatic translation to a variety of formats suitable for input
> -to text formatters.  A copy made in an otherwise Transparent file
> -format whose markup, or absence of markup, has been arranged to thwart
> -or discourage subsequent modification by readers is not Transparent.
> -An image format is not Transparent if used for any substantial amount
> -of text.  A copy that is not "Transparent" is called "Opaque".
> -
> -Examples of suitable formats for Transparent copies include plain
> -ASCII without markup, Texinfo input format, LaTeX input format, SGML
> -or XML using a publicly available DTD, and standard-conforming simple
> -HTML, PostScript or PDF designed for human modification.  Examples of
> -transparent image formats include PNG, XCF and JPG.  Opaque formats
> -include proprietary formats that can be read and edited only by
> -proprietary word processors, SGML or XML for which the DTD and/or
> -processing tools are not generally available, and the
> -machine-generated HTML, PostScript or PDF produced by some word
> -processors for output purposes only.
> -
> -The "Title Page" means, for a printed book, the title page itself,
> -plus such following pages as are needed to hold, legibly, the material
> -this License requires to appear in the title page.  For works in
> -formats which do not have any title page as such, "Title Page" means
> -the text near the most prominent appearance of the work's title,
> -preceding the beginning of the body of the text.
> -
> -A section "Entitled XYZ" means a named subunit of the Document whose
> -title either is precisely XYZ or contains XYZ in parentheses following
> -text that translates XYZ in another language.  (Here XYZ stands for a
> -specific section name mentioned below, such as "Acknowledgements",
> -"Dedications", "Endorsements", or "History".)  To "Preserve the Title"
> -of such a section when you modify the Document means that it remains a
> -section "Entitled XYZ" according to this definition.
> -
> -The Document may include Warranty Disclaimers next to the notice which
> -states that this License applies to the Document.  These Warranty
> -Disclaimers are considered to be included by reference in this
> -License, but only as regards disclaiming warranties: any other
> -implication that these Warranty Disclaimers may have is void and has
> -no effect on the meaning of this License.
> -
> -
> -2. VERBATIM COPYING
> -
> -You may copy and distribute the Document in any medium, either
> -commercially or noncommercially, provided that this License, the
> -copyright notices, and the license notice saying this License applies
> -to the Document are reproduced in all copies, and that you add no other
> -conditions whatsoever to those of this License.  You may not use
> -technical measures to obstruct or control the reading or further
> -copying of the copies you make or distribute.  However, you may accept
> -compensation in exchange for copies.  If you distribute a large enough
> -number of copies you must also follow the conditions in section 3.
> -
> -You may also lend copies, under the same conditions stated above, and
> -you may publicly display copies.
> -
> -
> -3. COPYING IN QUANTITY
> -
> -If you publish printed copies (or copies in media that commonly have
> -printed covers) of the Document, numbering more than 100, and the
> -Document's license notice requires Cover Texts, you must enclose the
> -copies in covers that carry, clearly and legibly, all these Cover
> -Texts: Front-Cover Texts on the front cover, and Back-Cover Texts on
> -the back cover.  Both covers must also clearly and legibly identify
> -you as the publisher of these copies.  The front cover must present
> -the full title with all words of the title equally prominent and
> -visible.  You may add other material on the covers in addition.
> -Copying with changes limited to the covers, as long as they preserve
> -the title of the Document and satisfy these conditions, can be treated
> -as verbatim copying in other respects.
> -
> -If the required texts for either cover are too voluminous to fit
> -legibly, you should put the first ones listed (as many as fit
> -reasonably) on the actual cover, and continue the rest onto adjacent
> -pages.
> -
> -If you publish or distribute Opaque copies of the Document numbering
> -more than 100, you must either include a machine-readable Transparent
> -copy along with each Opaque copy, or state in or with each Opaque copy
> -a computer-network location from which the general network-using
> -public has access to download using public-standard network protocols
> -a complete Transparent copy of the Document, free of added material.
> -If you use the latter option, you must take reasonably prudent steps,
> -when you begin distribution of Opaque copies in quantity, to ensure
> -that this Transparent copy will remain thus accessible at the stated
> -location until at least one year after the last time you distribute an
> -Opaque copy (directly or through your agents or retailers) of that
> -edition to the public.
> -
> -It is requested, but not required, that you contact the authors of the
> -Document well before redistributing any large number of copies, to give
> -them a chance to provide you with an updated version of the Document.
> -
> -
> -4. MODIFICATIONS
> -
> -You may copy and distribute a Modified Version of the Document under
> -the conditions of sections 2 and 3 above, provided that you release
> -the Modified Version under precisely this License, with the Modified
> -Version filling the role of the Document, thus licensing distribution
> -and modification of the Modified Version to whoever possesses a copy
> -of it.  In addition, you must do these things in the Modified Version:
> -
> -A. Use in the Title Page (and on the covers, if any) a title distinct
> -   from that of the Document, and from those of previous versions
> -   (which should, if there were any, be listed in the History section
> -   of the Document).  You may use the same title as a previous version
> -   if the original publisher of that version gives permission.
> -B. List on the Title Page, as authors, one or more persons or entities
> -   responsible for authorship of the modifications in the Modified
> -   Version, together with at least five of the principal authors of the
> -   Document (all of its principal authors, if it has fewer than five),
> -   unless they release you from this requirement.
> -C. State on the Title page the name of the publisher of the
> -   Modified Version, as the publisher.
> -D. Preserve all the copyright notices of the Document.
> -E. Add an appropriate copyright notice for your modifications
> -   adjacent to the other copyright notices.
> -F. Include, immediately after the copyright notices, a license notice
> -   giving the public permission to use the Modified Version under the
> -   terms of this License, in the form shown in the Addendum below.
> -G. Preserve in that license notice the full lists of Invariant Sections
> -   and required Cover Texts given in the Document's license notice.
> -H. Include an unaltered copy of this License.
> -I. Preserve the section Entitled "History", Preserve its Title, and add
> -   to it an item stating at least the title, year, new authors, and
> -   publisher of the Modified Version as given on the Title Page.  If
> -   there is no section Entitled "History" in the Document, create one
> -   stating the title, year, authors, and publisher of the Document as
> -   given on its Title Page, then add an item describing the Modified
> -   Version as stated in the previous sentence.
> -J. Preserve the network location, if any, given in the Document for
> -   public access to a Transparent copy of the Document, and likewise
> -   the network locations given in the Document for previous versions
> -   it was based on.  These may be placed in the "History" section.
> -   You may omit a network location for a work that was published at
> -   least four years before the Document itself, or if the original
> -   publisher of the version it refers to gives permission.
> -K. For any section Entitled "Acknowledgements" or "Dedications",
> -   Preserve the Title of the section, and preserve in the section all
> -   the substance and tone of each of the contributor acknowledgements
> -   and/or dedications given therein.
> -L. Preserve all the Invariant Sections of the Document,
> -   unaltered in their text and in their titles.  Section numbers
> -   or the equivalent are not considered part of the section titles.
> -M. Delete any section Entitled "Endorsements".  Such a section
> -   may not be included in the Modified Version.
> -N. Do not retitle any existing section to be Entitled "Endorsements"
> -   or to conflict in title with any Invariant Section.
> -O. Preserve any Warranty Disclaimers.
> -
> -If the Modified Version includes new front-matter sections or
> -appendices that qualify as Secondary Sections and contain no material
> -copied from the Document, you may at your option designate some or all
> -of these sections as invariant.  To do this, add their titles to the
> -list of Invariant Sections in the Modified Version's license notice.
> -These titles must be distinct from any other section titles.
> -
> -You may add a section Entitled "Endorsements", provided it contains
> -nothing but endorsements of your Modified Version by various
> -parties--for example, statements of peer review or that the text has
> -been approved by an organization as the authoritative definition of a
> -standard.
> -
> -You may add a passage of up to five words as a Front-Cover Text, and a
> -passage of up to 25 words as a Back-Cover Text, to the end of the list
> -of Cover Texts in the Modified Version.  Only one passage of
> -Front-Cover Text and one of Back-Cover Text may be added by (or
> -through arrangements made by) any one entity.  If the Document already
> -includes a cover text for the same cover, previously added by you or
> -by arrangement made by the same entity you are acting on behalf of,
> -you may not add another; but you may replace the old one, on explicit
> -permission from the previous publisher that added the old one.
> -
> -The author(s) and publisher(s) of the Document do not by this License
> -give permission to use their names for publicity for or to assert or
> -imply endorsement of any Modified Version.
> -
> -
> -5. COMBINING DOCUMENTS
> -
> -You may combine the Document with other documents released under this
> -License, under the terms defined in section 4 above for modified
> -versions, provided that you include in the combination all of the
> -Invariant Sections of all of the original documents, unmodified, and
> -list them all as Invariant Sections of your combined work in its
> -license notice, and that you preserve all their Warranty Disclaimers.
> -
> -The combined work need only contain one copy of this License, and
> -multiple identical Invariant Sections may be replaced with a single
> -copy.  If there are multiple Invariant Sections with the same name but
> -different contents, make the title of each such section unique by
> -adding at the end of it, in parentheses, the name of the original
> -author or publisher of that section if known, or else a unique number.
> -Make the same adjustment to the section titles in the list of
> -Invariant Sections in the license notice of the combined work.
> -
> -In the combination, you must combine any sections Entitled "History"
> -in the various original documents, forming one section Entitled
> -"History"; likewise combine any sections Entitled "Acknowledgements",
> -and any sections Entitled "Dedications".  You must delete all sections
> -Entitled "Endorsements".
> -
> -
> -6. COLLECTIONS OF DOCUMENTS
> -
> -You may make a collection consisting of the Document and other documents
> -released under this License, and replace the individual copies of this
> -License in the various documents with a single copy that is included in
> -the collection, provided that you follow the rules of this License for
> -verbatim copying of each of the documents in all other respects.
> -
> -You may extract a single document from such a collection, and distribute
> -it individually under this License, provided you insert a copy of this
> -License into the extracted document, and follow this License in all
> -other respects regarding verbatim copying of that document.
> -
> -
> -7. AGGREGATION WITH INDEPENDENT WORKS
> -
> -A compilation of the Document or its derivatives with other separate
> -and independent documents or works, in or on a volume of a storage or
> -distribution medium, is called an "aggregate" if the copyright
> -resulting from the compilation is not used to limit the legal rights
> -of the compilation's users beyond what the individual works permit.
> -When the Document is included in an aggregate, this License does not
> -apply to the other works in the aggregate which are not themselves
> -derivative works of the Document.
> -
> -If the Cover Text requirement of section 3 is applicable to these
> -copies of the Document, then if the Document is less than one half of
> -the entire aggregate, the Document's Cover Texts may be placed on
> -covers that bracket the Document within the aggregate, or the
> -electronic equivalent of covers if the Document is in electronic form.
> -Otherwise they must appear on printed covers that bracket the whole
> -aggregate.
> -
> -
> -8. TRANSLATION
> -
> -Translation is considered a kind of modification, so you may
> -distribute translations of the Document under the terms of section 4.
> -Replacing Invariant Sections with translations requires special
> -permission from their copyright holders, but you may include
> -translations of some or all Invariant Sections in addition to the
> -original versions of these Invariant Sections.  You may include a
> -translation of this License, and all the license notices in the
> -Document, and any Warranty Disclaimers, provided that you also include
> -the original English version of this License and the original versions
> -of those notices and disclaimers.  In case of a disagreement between
> -the translation and the original version of this License or a notice
> -or disclaimer, the original version will prevail.
> -
> -If a section in the Document is Entitled "Acknowledgements",
> -"Dedications", or "History", the requirement (section 4) to Preserve
> -its Title (section 1) will typically require changing the actual
> -title.
> -
> -
> -9. TERMINATION
> -
> -You may not copy, modify, sublicense, or distribute the Document except
> -as expressly provided for under this License.  Any other attempt to
> -copy, modify, sublicense or distribute the Document is void, and will
> -automatically terminate your rights under this License.  However,
> -parties who have received copies, or rights, from you under this
> -License will not have their licenses terminated so long as such
> -parties remain in full compliance.
> -
> -
> -10. FUTURE REVISIONS OF THIS LICENSE
> -
> -The Free Software Foundation may publish new, revised versions
> -of the GNU Free Documentation License from time to time.  Such new
> -versions will be similar in spirit to the present version, but may
> -differ in detail to address new problems or concerns.  See
> -https://www.gnu.org/copyleft/.
> -
> -Each version of the License is given a distinguishing version number.
> -If the Document specifies that a particular numbered version of this
> -License "or any later version" applies to it, you have the option of
> -following the terms and conditions either of that specified version or
> -of any later version that has been published (not as a draft) by the
> -Free Software Foundation.  If the Document does not specify a version
> -number of this License, you may choose any version ever published (not
> -as a draft) by the Free Software Foundation.
> -
> -
> -ADDENDUM: How to use this License for your documents
> -
> -To use this License in a document you have written, include a copy of
> -the License in the document and put the following copyright and
> -license notices just after the title page:
> -
> -    Copyright (c)  YEAR  YOUR NAME.
> -    Permission is granted to copy, distribute and/or modify this document
> -    under the terms of the GNU Free Documentation License, Version 1.2
> -    or any later version published by the Free Software Foundation;
> -    with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
> -    A copy of the license is included in the section entitled "GNU
> -    Free Documentation License".
> -
> -If you have Invariant Sections, Front-Cover Texts and Back-Cover Texts,
> -replace the "with...Texts." line with this:
> -
> -    with the Invariant Sections being LIST THEIR TITLES, with the
> -    Front-Cover Texts being LIST, and with the Back-Cover Texts being LIST.
> -
> -If you have Invariant Sections without Cover Texts, or some other
> -combination of the three, merge those two alternatives to suit the
> -situation.
> -
> -If your document contains nontrivial examples of program code, we
> -recommend releasing these examples in parallel under your choice of
> -free software license, such as the GNU General Public License,
> -to permit their use in free software.
> -
> -The End.
> 

--------------8F2755065F9007E1085D124E
Content-Type: text/plain; charset=UTF-8;
 name="spkguide-original.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="spkguide-original.txt"

ClRoZSBTcGVha3VwIFVzZXIncyBHdWlkZQpGb3IgU3BlYWt1cCAzLjEuMiBhbmQgTGF0ZXIK
QnkgR2VuZSBDb2xsaW5zClVwZGF0ZWQgYnkgb3RoZXJzCkxhc3QgbW9kaWZpZWQgb24gTW9u
IFNlcCAyNyAxNDoyNjozMSAyMDEwCkRvY3VtZW50IHZlcnNpb24gMS4zCgpDb3B5cmlnaHQg
KGMpIDIwMDUgIEdlbmUgQ29sbGlucwpDb3B5cmlnaHQgKGMpIDIwMDggIFNhbXVlbCBUaGli
YXVsdApDb3B5cmlnaHQgKGMpIDIwMDksIDIwMTAgIHRoZSBTcGVha3VwIFRlYW0KClBlcm1p
c3Npb24gaXMgZ3JhbnRlZCB0byBjb3B5LCBkaXN0cmlidXRlIGFuZC9vciBtb2RpZnkgdGhp
cyBkb2N1bWVudAp1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBGcmVlIERvY3VtZW50YXRp
b24gTGljZW5zZSwgVmVyc2lvbiAxLjIgb3IKYW55IGxhdGVyIHZlcnNpb24gcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IHdpdGggbm8KSW52YXJpYW50IFNl
Y3Rpb25zLCBubyBGcm9udC1Db3ZlciBUZXh0cywgYW5kIG5vIEJhY2stQ292ZXIgVGV4dHMu
IEEKY29weSBvZiB0aGUgbGljZW5zZSBpcyBpbmNsdWRlZCBpbiB0aGUgc2VjdGlvbiBlbnRp
dGxlZCAiR05VIEZyZWUKRG9jdW1lbnRhdGlvbiBMaWNlbnNlIi4KClByZWZhY2UKClRoZSBw
dXJwb3NlIG9mIHRoaXMgZG9jdW1lbnQgaXMgdG8gZmFtaWxpYXJpemUgdXNlcnMgd2l0aCB0
aGUgdXNlcgppbnRlcmZhY2UgdG8gU3BlYWt1cCwgYSBMaW51eCBTY3JlZW4gUmVhZGVyLiAg
SWYgeW91IG5lZWQgaW5zdHJ1Y3Rpb25zCmZvciBpbnN0YWxsaW5nIG9yIG9idGFpbmluZyBT
cGVha3VwLCB2aXNpdCB0aGUgd2ViIHNpdGUgYXQKaHR0cDovL2xpbnV4LXNwZWFrdXAub3Jn
Ly4gIFNwZWFrdXAgaXMgYSBzZXQgb2YgcGF0Y2hlcyB0byB0aGUgc3RhbmRhcmQKTGludXgg
a2VybmVsIHNvdXJjZSB0cmVlLiAgSXQgY2FuIGJlIGJ1aWx0IGFzIGEgc2VyaWVzIG9mIG1v
ZHVsZXMsIG9yIGFzCmEgcGFydCBvZiBhIG1vbm9saXRoaWMga2VybmVsLiAgVGhlc2UgZGV0
YWlscyBhcmUgYmV5b25kIHRoZSBzY29wZSBvZgp0aGlzIG1hbnVhbCwgYnV0IHRoZSB1c2Vy
IG1heSBuZWVkIHRvIGJlIGF3YXJlIG9mIHRoZSBtb2R1bGUKY2FwYWJpbGl0aWVzLCBkZXBl
bmRpbmcgb24gaG93IHlvdXIgc3lzdGVtIGFkbWluaXN0cmF0b3IgaGFzIGluc3RhbGxlZApT
cGVha3VwLiAgSWYgU3BlYWt1cCBpcyBidWlsdCBhcyBhIHBhcnQgb2YgYSBtb25vbGl0aGlj
IGtlcm5lbCwgYW5kIHRoZQp1c2VyIGlzIHVzaW5nIGEgaGFyZHdhcmUgc3ludGhlc2l6ZXIs
IHRoZW4gU3BlYWt1cCB3aWxsIGJlIGFibGUgdG8KcHJvdmlkZSBzcGVlY2ggYWNjZXNzIGZy
b20gdGhlIHRpbWUgdGhlIGtlcm5lbCBpcyBsb2FkZWQsIHVudGlsIHRoZSB0aW1lCnRoZSBz
eXN0ZW0gaXMgc2h1dGRvd24uICBUaGlzIG1lYW5zIHRoYXQgaWYgeW91IGhhdmUgb2J0YWlu
ZWQgTGludXgKaW5zdGFsbGF0aW9uIG1lZGlhIGZvciBhIGRpc3RyaWJ1dGlvbiB3aGljaCBp
bmNsdWRlcyBTcGVha3VwIGFzIGEgcGFydApvZiBpdHMga2VybmVsLCB5b3Ugd2lsbCBiZSBh
YmxlLCBhcyBhIGJsaW5kIHBlcnNvbiwgdG8gaW5zdGFsbCBMaW51eAp3aXRoIHNwZWVjaCBh
Y2Nlc3MgdW5haWRlZCBieSBhIHNpZ2h0ZWQgcGVyc29uLiAgQWdhaW4sIHRoZXNlIGRldGFp
bHMKYXJlIGJleW9uZCB0aGUgc2NvcGUgb2YgdGhpcyBtYW51YWwsIGJ1dCB0aGUgdXNlciBz
aG91bGQgYmUgYXdhcmUgb2YKdGhlbS4gIFNlZSB0aGUgd2ViIHNpdGUgbWVudGlvbmVkIGFi
b3ZlIGZvciBmdXJ0aGVyIGRldGFpbHMuCgoxLiAgU3RhcnRpbmcgU3BlYWt1cAoKSWYgeW91
ciBzeXN0ZW0gYWRtaW5pc3RyYXRvciBoYXMgaW5zdGFsbGVkIFNwZWFrdXAgdG8gd29yayB3
aXRoIHlvdXIKc3BlY2lmaWMgc3ludGhlc2l6ZXIgYnkgZGVmYXVsdCwgdGhlbiBhbGwgeW91
IG5lZWQgdG8gZG8gdG8gdXNlIFNwZWFrdXAKaXMgdG8gYm9vdCB5b3VyIHN5c3RlbSwgYW5k
IFNwZWFrdXAgc2hvdWxkIGNvbWUgdXAgdGFsa2luZy4gIFRoaXMKYXNzdW1lcyBvZiBjb3Vy
c2UgIHRoYXQgeW91ciBzeW50aGVzaXplciBpcyBhIHN1cHBvcnRlZCBoYXJkd2FyZQpzeW50
aGVzaXplciwgYW5kIHRoYXQgaXQgaXMgZWl0aGVyIGluc3RhbGxlZCBpbiBvciBjb25uZWN0
ZWQgdG8geW91cgpzeXN0ZW0sIGFuZCBpcyBpZiBuZWNlc3NhcnkgcG93ZXJlZCBvbi4KCkl0
IGlzIHBvc3NpYmxlLCBob3dldmVyLCB0aGF0IFNwZWFrdXAgbWF5IGhhdmUgYmVlbiBjb21w
aWxlZCBpbnRvIHRoZQprZXJuZWwgd2l0aCBubyBkZWZhdWx0IHN5bnRoZXNpemVyLiAgSXQg
aXMgZXZlbiBwb3NzaWJsZSB0aGF0IHlvdXIKa2VybmVsIGhhcyBiZWVuIGNvbXBpbGVkIHdp
dGggc3VwcG9ydCBmb3Igc29tZSBvZiB0aGUgc3VwcG9ydGVkCnN5bnRoZXNpemVycyBhbmQg
bm90IG90aGVycy4gIElmIHlvdSBmaW5kIHRoYXQgdGhpcyBpcyB0aGUgY2FzZSwgYW5kCnlv
dXIgc3ludGhlc2l6ZXIgaXMgc3VwcG9ydGVkIGJ1dCBub3QgYXZhaWxhYmxlLCBjb21wbGFp
biB0byB0aGUgcGVyc29uCndobyBjb21waWxlZCBhbmQgaW5zdGFsbGVkIHlvdXIga2VybmVs
LiAgT3IgYmV0dGVyIHlldCwgZ28gdG8gdGhlIHdlYgpzaXRlLCBhbmQgbGVhcm4gaG93IHRv
IHBhdGNoIFNwZWFrdXAgaW50byB5b3VyIG93biBrZXJuZWwgc291cmNlLCBhbmQKYnVpbGQg
YW5kIGluc3RhbGwgeW91ciBvd24ga2VybmVsLgoKSWYgeW91ciBrZXJuZWwgaGFzIGJlZW4g
Y29tcGlsZWQgd2l0aCBTcGVha3VwLCBhbmQgaGFzIG5vIGRlZmF1bHQKc3ludGhlc2l6ZXIg
c2V0LCBvciB5b3Ugd291bGQgbGlrZSB0byB1c2UgYSBkaWZmZXJlbnQgc3ludGhlc2l6ZXIg
dGhhbgp0aGUgZGVmYXVsdCBvbmUsIHRoZW4geW91IG1heSBpc3N1ZSB0aGUgZm9sbG93aW5n
IGNvbW1hbmQgYXQgdGhlIGJvb3QKcHJvbXB0IG9mIHlvdXIgYm9vdCBsb2FkZXIuCgpsaW51
eCBzcGVha3VwLnN5bnRoPWx0bGsKClRoaXMgY29tbWFuZCB3b3VsZCB0ZWxsIFNwZWFrdXAg
dG8gbG9vayBmb3IgYW5kIHVzZSBhIExpdGVUYWxrIG9yCkRvdWJsZVRhbGsgTFQgYXQgYm9v
dCB1cC4gIFlvdSBtYXkgcmVwbGFjZSB0aGUgbHRsayBzeW50aGVzaXplciBrZXl3b3JkCndp
dGggdGhlIGtleXdvcmQgZm9yIHdoYXRldmVyIHN5bnRoZXNpemVyIHlvdSB3aXNoIHRvIHVz
ZS4gIFRoZQpzcGVha3VwLnN5bnRoIHBhcmFtZXRlciB3aWxsIGFjY2VwdCB0aGUgZm9sbG93
aW5nIGtleXdvcmRzLCBwcm92aWRlZAp0aGF0IHN1cHBvcnQgZm9yIHRoZSByZWxhdGVkIHN5
bnRoZXNpemVycyBoYXMgYmVlbiBidWlsdCBpbnRvIHRoZQprZXJuZWwuCgphY250c2EgLS0g
QWNjZW50IFNBCmFjbnRwYyAtLSBBY2NlbnQgUEMKYXBvbGxvIC0tIEFwb2xsbwphdWRwdHIg
LS0gQXVkYXB0ZXIKYm5zIC0tIEJyYWlsbGUgJ24gU3BlYWsKZGVjdGxrIC0tIERlY1RhbGsg
RXhwcmVzcyAob2xkIGFuZCBuZXcsIGRiOSBzZXJpYWwgb25seSkKZGVjZXh0IC0tIERlY1Rh
bGsgKG9sZCkgRXh0ZXJuYWwKZHRsayAtLSBEb3VibGVUYWxrIFBDCmtleXBjIC0tIEtleW5v
dGUgR29sZCBQQwpsdGxrIC0tIERvdWJsZVRhbGsgTFQsIExpdGVUYWxrLCBvciBleHRlcm5h
bCBUcmlwbGV0YWxrIChkYjkgc2VyaWFsIG9ubHkpCnNwa291dCAtLSBTcGVhayBPdXQKdHhw
cnQgLS0gVHJhbnNwb3J0CmR1bW15IC0tIFBsYWluIHRleHQgdGVybWluYWwKCk5vdGU6IFNw
ZWFrdXAgZG9lcyAqIE5PVCAqIHN1cHBvcnQgdXNiIGNvbm5lY3Rpb25zISAgU3BlYWt1cCBh
bHNvIGRvZXMgKgpOT1QgKiBzdXBwb3J0IHRoZSBpbnRlcm5hbCBUcmlwbGV0YWxrIQoKU3Bl
YWt1cCBkb2VzIHN1cHBvcnQgdHdvIG90aGVyIHN5bnRoZXNpemVycywgYnV0IGJlY2F1c2Ug
dGhleSB3b3JrIGluCmNvbmp1bmN0aW9uIHdpdGggb3RoZXIgc29mdHdhcmUsIHRoZXkgbXVz
dCBiZSBsb2FkZWQgYXMgbW9kdWxlcyBhZnRlcgp0aGVpciByZWxhdGVkIHNvZnR3YXJlIGlz
IGxvYWRlZCwgYW5kIHNvIGFyZSBub3QgYXZhaWxhYmxlIGF0IGJvb3QgdXAuClRoZXNlIGFy
ZSBhcyBmb2xsb3dzOgoKZGVjcGMgLS0gRGVjVGFsayBQQyAobm90IGF2YWlsYWJsZSBhdCBi
b290IHVwKQpzb2Z0IC0tIE9uZSBvZiBzZXZlcmFsIHNvZnR3YXJlIHN5bnRoZXNpemVycyAo
bm90IGF2YWlsYWJsZSBhdCBib290IHVwKQoKU2VlIHRoZSBzZWN0aW9ucyBvbiBsb2FkaW5n
IG1vZHVsZXMgYW5kIHNvZnR3YXJlIHN5bnRoZXNpemVycyBsYXRlciBpbgp0aGlzIG1hbnVh
bCBmb3IgZnVydGhlciBkZXRhaWxzLiAgSXQgc2hvdWxkIGJlIG5vdGVkIGhlcmUgdGhhdCB0
aGUKc3BlYWt1cC5zeW50aCBib290IHBhcmFtZXRlciB3aWxsIGhhdmUgbm8gZWZmZWN0IGlm
IFNwZWFrdXAgaGFzIGJlZW4KY29tcGlsZWQgYXMgbW9kdWxlcy4gIEluIG9yZGVyIGZvciBT
cGVha3VwIG1vZHVsZXMgdG8gYmUgbG9hZGVkIGR1cmluZwp0aGUgYm9vdCBwcm9jZXNzLCBz
dWNoIGFjdGlvbiBtdXN0IGJlIGNvbmZpZ3VyZWQgYnkgeW91ciBzeXN0ZW0KYWRtaW5pc3Ry
YXRvci4gIFRoaXMgd2lsbCBtZWFuIHRoYXQgeW91IHdpbGwgaGVhciBzb21lLCBidXQgbm90
IGFsbCwgIG9mCnRoZSBib290dXAgbWVzc2FnZXMuCgoyLiAgQmFzaWMgb3BlcmF0aW9uCgpP
bmNlIHlvdSBoYXZlIGJvb3RlZCB0aGUgc3lzdGVtLCBhbmQgaWYgbmVjZXNzYXJ5LCBoYXZl
IHN1cHBsaWVkIHRoZQpwcm9wZXIgYm9vdHVwIHBhcmFtZXRlciBmb3IgeW91ciBzeW50aGVz
aXplciwgU3BlYWt1cCB3aWxsIGJlZ2luCnRhbGtpbmcgYXMgc29vbiBhcyB0aGUga2VybmVs
IGlzIGxvYWRlZC4gIEluIGZhY3QsIGl0IHdpbGwgdGFsayBhIGxvdCEKSXQgd2lsbCBzcGVh
ayBhbGwgdGhlIGJvb3QgdXAgbWVzc2FnZXMgdGhhdCB0aGUga2VybmVsIHByaW50cyBvbiB0
aGUKc2NyZWVuIGR1cmluZyB0aGUgYm9vdCBwcm9jZXNzLiAgVGhpcyBpcyBiZWNhdXNlIFNw
ZWFrdXAgaXMgbm90IGEKc2VwYXJhdGUgc2NyZWVuIHJlYWRlciwgYnV0IGlzIGFjdHVhbGx5
IGJ1aWx0IGludG8gdGhlIG9wZXJhdGluZwpzeXN0ZW0uICBTaW5jZSBhbG1vc3QgYWxsIGNv
bnNvbGUgYXBwbGljYXRpb25zIG11c3QgcHJpbnQgdGV4dCBvbiB0aGUKc2NyZWVuIHVzaW5n
IHRoZSBrZXJuZWwsIGFuZCBtdXN0IGdldCB0aGVpciBrZXlib2FyZCBpbnB1dCB0aHJvdWdo
IHRoZQprZXJuZWwsIHRoZXkgYXJlIGF1dG9tYXRpY2FsbHkgaGFuZGxlZCBwcm9wZXJseSBi
eSBTcGVha3VwLiAgVGhlcmUgYXJlIGEKZmV3IGV4Y2VwdGlvbnMsIGJ1dCB3ZSdsbCBjb21l
IHRvIHRob3NlIGxhdGVyLgoKTm90ZTogIEluIHRoaXMgZ3VpZGUgSSB3aWxsIHJlZmVyIHRv
IHRoZSBudW1lcmljIGtleXBhZCBhcyB0aGUga2V5cGFkLgpUaGlzIGlzIGRvbmUgYmVjYXVz
ZSB0aGUgc3BlYWt1cG1hcC5tYXAgZmlsZSByZWZlcnJlZCB0byBsYXRlciBpbiB0aGlzCm1h
bnVhbCB1c2VzIHRoZSB0ZXJtIGtleXBhZCBpbnN0ZWFkIG9mIG51bWVyaWMga2V5cGFkLiAg
QWxzbyBJJ20gbGF6eQphbmQgd291bGQgcmF0aGVyIG9ubHkgdHlwZSBvbmUgd29yZC4gIFNv
IGtleXBhZCBpdCBpcy4gIEdvdCBpdD8gIEdvb2QuCgpNb3N0IG9mIHRoZSBTcGVha3VwIHJl
dmlldyBrZXlzIGFyZSBsb2NhdGVkIG9uIHRoZSBrZXlwYWQgYXQgdGhlIGZhcgpyaWdodCBv
ZiB0aGUga2V5Ym9hcmQuICBUaGUgbnVtbG9jayBrZXkgc2hvdWxkIGJlIG9mZiwgaW4gb3Jk
ZXIgZm9yIHRoZXNlCnRvIHdvcmsuICBJZiB5b3UgdG9nZ2xlIHRoZSBudW1sb2NrIG9uLCB0
aGUga2V5cGFkIHdpbGwgcHJvZHVjZSBudW1iZXJzLAp3aGljaCBpcyBleGFjdGx5IHdoYXQg
eW91IHdhbnQgZm9yIHNwcmVhZHNoZWV0cyBhbmQgc3VjaC4gIEZvciB0aGUKcHVycG9zZXMg
b2YgdGhpcyBndWlkZSwgeW91IHNob3VsZCBoYXZlIHRoZSBudW1sb2NrIHR1cm5lZCBvZmYs
IHdoaWNoIGlzCml0cyBkZWZhdWx0IHN0YXRlIGF0IGJvb3R1cC4KCllvdSBwcm9iYWJseSB3
b24ndCB3YW50IHRvIGxpc3RlbiB0byBhbGwgdGhlIGJvb3R1cCBtZXNzYWdlcyBldmVyeSB0
aW1lCnlvdSBzdGFydCB5b3VyIHN5c3RlbSwgdGhvdWdoIGl0J3MgYSBnb29kIGlkZWEgdG8g
bGlzdGVuIHRvIHRoZW0gYXQKbGVhc3Qgb25jZSwganVzdCBzbyB5b3UnbGwga25vdyB3aGF0
IGtpbmQgb2YgaW5mb3JtYXRpb24gaXMgYXZhaWxhYmxlIHRvCnlvdSBkdXJpbmcgdGhlIGJv
b3QgcHJvY2Vzcy4gIFlvdSBjYW4gYWx3YXlzIHJldmlldyB0aGVzZSBtZXNzYWdlcyBhZnRl
cgpib290dXAgd2l0aCB0aGUgY29tbWFuZDoKCmRtZXNnIHwgbW9yZQoKSW4gb3JkZXIgdG8g
c3BlZWQgdGhlIGJvb3QgcHJvY2VzcywgYW5kIHRvIHNpbGVuY2UgdGhlIHNwZWFraW5nIG9m
IHRoZQpib290dXAgbWVzc2FnZXMsIGp1c3QgcHJlc3MgdGhlIGtleXBhZCBlbnRlciBrZXku
ICBUaGlzIGtleSBpcyBsb2NhdGVkCmluIHRoZSBib3R0b20gcmlnaHQgY29ybmVyIG9mIHRo
ZSBrZXlwYWQuICBTcGVha3VwIHdpbGwgc2h1dCB1cCBhbmQgc3RheQp0aGF0IHdheSwgdW50
aWwgeW91IHByZXNzIGFub3RoZXIga2V5LgoKWW91IGNhbiBjaGVjayB0byBzZWUgaWYgdGhl
IGJvb3QgcHJvY2VzcyBoYXMgY29tcGxldGVkIGJ5IHByZXNzaW5nIHRoZSA4CmtleSBvbiB0
aGUga2V5cGFkLCB3aGljaCByZWFkcyB0aGUgY3VycmVudCBsaW5lLiAgVGhpcyBhbHNvIGhh
cyB0aGUKZWZmZWN0IG9mIHN0YXJ0aW5nIFNwZWFrdXAgdGFsa2luZyBhZ2Fpbiwgc28geW91
IGNhbiBwcmVzcyBrZXlwYWQgZW50ZXIKdG8gc2lsZW5jZSBpdCBhZ2FpbiBpZiB0aGUgYm9v
dCBwcm9jZXNzIGhhcyBub3QgY29tcGxldGVkLgoKV2hlbiB0aGUgYm9vdCBwcm9jZXNzIGlz
IGNvbXBsZXRlLCB5b3Ugd2lsbCBhcnJpdmUgYXQgYSAibG9naW4iIHByb21wdC4KQXQgdGhp
cyBwb2ludCwgeW91J2xsIG5lZWQgdG8gdHlwZSBpbiB5b3VyIHVzZXIgaWQgYW5kIHBhc3N3
b3JkLCBhcwpwcm92aWRlZCBieSB5b3VyIHN5c3RlbSBhZG1pbmlzdHJhdG9yLiAgWW91IHdp
bGwgaGVhciBTcGVha3VwIHNwZWFrIHRoZQpsZXR0ZXJzIG9mIHlvdXIgdXNlciBpZCBhcyB5
b3UgdHlwZSBpdCwgYnV0IG5vdCB0aGUgcGFzc3dvcmQuICBUaGlzIGlzCmJlY2F1c2UgdGhl
IHBhc3N3b3JkIGlzIG5vdCBkaXNwbGF5ZWQgb24gdGhlIHNjcmVlbiBmb3Igc2VjdXJpdHkK
cmVhc29ucy4gIFRoaXMgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBTcGVha3VwLCBpdCdzIGEg
TGludXggc2VjdXJpdHkKZmVhdHVyZS4KCk9uY2UgeW91J3ZlIGxvZ2dlZCBpbiwgeW91IGNh
biBydW4gYW55IExpbnV4IGNvbW1hbmQgb3IgcHJvZ3JhbSB3aGljaCBpcwphbGxvd2VkIGJ5
IHlvdXIgdXNlciBpZC4gIE5vcm1hbCB1c2VycyB3aWxsIG5vdCBiZSBhYmxlIHRvIHJ1biBw
cm9ncmFtcwp3aGljaCByZXF1aXJlIHJvb3QgcHJpdmlsZWdlcy4KCldoZW4geW91IGFyZSBy
dW5uaW5nIGEgcHJvZ3JhbSBvciBjb21tYW5kLCBTcGVha3VwIHdpbGwgYXV0b21hdGljYWxs
eQpzcGVhayBuZXcgdGV4dCBhcyBpdCBhcnJpdmVzIG9uIHRoZSBzY3JlZW4uICBZb3UgY2Fu
IGF0IGFueSB0aW1lIHNpbGVuY2UKdGhlIHNwZWVjaCB3aXRoIGtleXBhZCBlbnRlciwgb3Ig
dXNlIGFueSBvZiB0aGUgU3BlYWt1cCByZXZpZXcga2V5cy4KCkhlcmUgYXJlIHNvbWUgYmFz
aWMgU3BlYWt1cCByZXZpZXcga2V5cywgYW5kIGEgc2hvcnQgZGVzY3JpcHRpb24gb2Ygd2hh
dAp0aGV5IGRvLgoKa2V5cGFkIDEgLS0gcmVhZCBwcmV2aW91cyBjaGFyYWN0ZXIKa2V5cGFk
IDIgLS0gcmVhZCBjdXJyZW50IGNoYXJhY3RlciAocHJlc3Npbmcga2V5cGFkIDIgdHdpY2Ug
cmFwaWRseSB3aWxsIHNwZWFrCgl0aGUgY3VycmVudCBjaGFyYWN0ZXIgcGhvbmV0aWNhbGx5
KQprZXlwYWQgMyAtLSByZWFkIG5leHQgY2hhcmFjdGVyCmtleXBhZCA0IC0tIHJlYWQgcHJl
dmlvdXMgd29yZAprZXlwYWQgNSAtLSByZWFkIGN1cnJlbnQgd29yZCAocHJlc3MgdHdpY2Ug
cmFwaWRseSB0byBzcGVsbCB0aGUgY3VycmVudCB3b3JkKQprZXlwYWQgNiAtLSByZWFkIG5l
eHQgd29yZAprZXlwYWQgNyAtLSByZWFkIHByZXZpb3VzIGxpbmUKa2V5cGFkIDggLS0gcmVh
ZCBjdXJyZW50IGxpbmUgKHByZXNzIHR3aWNlIHJhcGlkbHkgdG8gaGVhciBob3cgbXVjaCB0
aGUKCXRleHQgb24gdGhlIGN1cnJlbnQgbGluZSBpcyBpbmRlbnRlZCkKa2V5cGFkIDkgLS0g
cmVhZCBuZXh0IGxpbmUKa2V5cGFkIHBlcmlvZCAtLSBzcGVhayBjdXJyZW50IGN1cnNvciBw
b3NpdGlvbiBhbmQgYW5ub3VuY2UgY3VycmVudAoJdmlydHVhbCBjb25zb2xlCgpJdCdzIGFs
c28gd29ydGggbm90aW5nIHRoYXQgdGhlIGluc2VydCBrZXkgb24gdGhlIGtleXBhZCBpcyBt
YXBwZWQKYXMgdGhlIHNwZWFrdXAga2V5LiAgSW5zdGVhZCBvZiBwcmVzc2luZyBhbmQgcmVs
ZWFzaW5nIHRoaXMga2V5LCBhcyB5b3UKZG8gdW5kZXIgRE9TIG9yIFdpbmRvd3MsIHlvdSBo
b2xkIGl0IGxpa2UgYSBzaGlmdCBrZXksIGFuZCBwcmVzcyBvdGhlcgprZXlzIGluIGNvbWJp
bmF0aW9uIHdpdGggaXQuICBGb3IgZXhhbXBsZSwgcmVwZWF0ZWRseSBob2xkaW5nIGtleXBh
ZAppbnNlcnQsIGZyb20gbm93IG9uIGNhbGxlZCBzcGVha3VwLCBhbmQga2V5cGFkIGVudGVy
IHdpbGwgdG9nZ2xlIHRoZQpzcGVha2luZyBvZiBuZXcgdGV4dCBvbiB0aGUgc2NyZWVuIG9u
IGFuZCBvZmYuICBUaGlzIGlzIG5vdCB0aGUgc2FtZSBhcwpqdXN0IHByZXNzaW5nIGtleXBh
ZCBlbnRlciBieSBpdHNlbGYsIHdoaWNoIGp1c3Qgc2lsZW5jZXMgdGhlIHNwZWVjaAp1bnRp
bCB5b3UgaGl0IGFub3RoZXIga2V5LiAgV2hlbiB5b3UgaGl0IHNwZWFrdXAgcGx1cyBrZXlw
YWQgZW50ZXIsClNwZWFrdXAgd2lsbCBzYXksICJZb3UgdHVybmVkIG1lIG9mZi4iLCBvciAi
SGV5LCB0aGF0J3MgYmV0dGVyLiIgIFdoZW4KU3BlYWt1cCBpcyB0dXJuZWQgb2ZmLCBubyBu
ZXcgdGV4dCBvbiB0aGUgc2NyZWVuIHdpbGwgYmUgc3Bva2VuLiAgWW91CmNhbiBzdGlsbCB1
c2UgdGhlIHJlYWRpbmcgY29udHJvbHMgdG8gcmV2aWV3IHRoZSBzY3JlZW4gaG93ZXZlci4K
CjMuICBVc2luZyB0aGUgU3BlYWt1cCBIZWxwIFN5c3RlbQoKSW4gb3JkZXIgdG8gZW50ZXIg
dGhlIFNwZWFrdXAgaGVscCBzeXN0ZW0sIHByZXNzIGFuZCBob2xkIHRoZSBzcGVha3VwCmtl
eSAocmVtZW1iZXIgdGhhdCB0aGlzIGlzIHRoZSBrZXlwYWQgaW5zZXJ0IGtleSksIGFuZCBw
cmVzcyB0aGUgZjEga2V5LgpZb3Ugd2lsbCBoZWFyIHRoZSBtZXNzYWdlOgoKIlByZXNzIHNw
YWNlIHRvIGxlYXZlIGhlbHAsIGN1cnNvciB1cCBvciBkb3duIHRvIHNjcm9sbCwgb3IgYSBs
ZXR0ZXIgdG8KZ28gdG8gY29tbWFuZHMgaW4gbGlzdC4iCgpXaGVuIHlvdSBwcmVzcyB0aGUg
c3BhY2ViYXIgdG8gbGVhdmUgdGhlIGhlbHAgc3lzdGVtLCB5b3Ugd2lsbCBoZWFyOgoKIkxl
YXZpbmcgaGVscC4iCgpXaGlsZSB5b3UgYXJlIGluIHRoZSBTcGVha3VwIGhlbHAgc3lzdGVt
LCB5b3UgY2FuIHNjcm9sbCB1cCBvciBkb3duCnRocm91Z2ggdGhlIGxpc3Qgb2YgYXZhaWxh
YmxlIGNvbW1hbmRzIHVzaW5nIHRoZSBjdXJzb3Iga2V5cy4gIFRoZSBsaXN0Cm9mIGNvbW1h
bmRzIGlzIGFycmFuZ2VkIGluIGFscGhhYmV0aWNhbCBvcmRlci4gIElmIHlvdSB3aXNoIHRv
IGp1bXAgdG8KY29tbWFuZHMgaW4gYSBzcGVjaWZpYyBwYXJ0IG9mIHRoZSBhbHBoYWJldCwg
eW91IG1heSBwcmVzcyB0aGUgbGV0dGVyIG9mCnRoZSBhbHBoYWJldCB5b3Ugd2lzaCB0byBq
dW1wIHRvLgoKWW91IGNhbiBhbHNvIGp1c3QgZXhwbG9yZSBieSB0eXBpbmcga2V5Ym9hcmQg
a2V5cy4gIFByZXNzaW5nIGtleXMgd2lsbApjYXVzZSBTcGVha3VwIHRvIHNwZWFrIHRoZSBj
b21tYW5kIGFzc29jaWF0ZWQgd2l0aCB0aGF0IGtleS4gIEZvcgpleGFtcGxlLCBpZiB5b3Ug
cHJlc3MgdGhlIGtleXBhZCA4IGtleSwgeW91IHdpbGwgaGVhcjoKCiJLZXlwYWQgOCBpcyBs
aW5lLCBzYXkgY3VycmVudC4iCgpZb3UnbGwgbm90aWNlIHRoYXQgc29tZSBjb21tYW5kcyBk
byBub3QgaGF2ZSBrZXlzIGFzc2lnbmVkIHRvIHRoZW0uClRoaXMgaXMgYmVjYXVzZSB0aGV5
IGFyZSB2ZXJ5IGluZnJlcXVlbnRseSB1c2VkIGNvbW1hbmRzLCBhbmQgYXJlIGFsc28KYWNj
ZXNzaWJsZSB0aHJvdWdoIHRoZSBzeXMgc3lzdGVtLiAgV2UnbGwgZGlzY3VzcyB0aGUgc3lz
IHN5c3RlbSBsYXRlcgppbiB0aGlzIG1hbnVhbC4KCllvdSdsbCBhbHNvIG5vdGljZSB0aGF0
IHNvbWUgY29tbWFuZHMgaGF2ZSB0d28ga2V5cyBhc3NpZ25lZCB0byB0aGVtLgpUaGlzIGlz
IGJlY2F1c2UgU3BlYWt1cCBoYXMgYSBidWlsdCBpbiBzZXQgb2YgYWx0ZXJuYXRpdmUga2V5
IGJpbmRpbmdzCmZvciBsYXB0b3AgdXNlcnMuICBUaGUgYWx0ZXJuYXRlIHNwZWFrdXAga2V5
IGlzIHRoZSBjYXBzIGxvY2sga2V5LiAgWW91CmNhbiBwcmVzcyBhbmQgaG9sZCB0aGUgY2Fw
cyBsb2NrIGtleSwgd2hpbGUgcHJlc3NpbmcgYW4gYWx0ZXJuYXRlCnNwZWFrdXAgY29tbWFu
ZCBrZXkgdG8gYWN0aXZhdGUgdGhlIGNvbW1hbmQuICBPbiBtb3N0IGxhcHRvcHMsIHRoZQpu
dW1lcmljIGtleXBhZCBpcyBkZWZpbmVkIGFzIHRoZSBrZXlzIGluIHRoZSBqIGsgbCBhcmVh
IG9mIHRoZSBrZXlib2FyZC4KClRoZXJlIGlzIHVzdWFsbHkgYSBmdW5jdGlvbiBrZXkgd2hp
Y2ggdHVybnMgdGhpcyBrZXlwYWQgZnVuY3Rpb24gb24gYW5kCm9mZiwgYW5kIHNvbWUgb3Ro
ZXIga2V5IHdoaWNoIGNvbnRyb2xzIHRoZSBudW1sb2NrIHN0YXRlLiAgVG9nZ2xpbmcgdGhl
CmtleXBhZCBmdW5jdGlvbmFsaXR5IG9uIGFuZCBvZmYgY2FuIGJlY29tZSBhIHJveWFsIHBh
aW4uICBTbywgU3BlYWt1cApnaXZlcyB5b3UgYSBzaW1wbGUgd2F5IHRvIGdldCBhdCBhbiBh
bHRlcm5hdGl2ZSBzZXQgb2Yga2V5IG1hcHBpbmdzIGZvcgp5b3VyIGxhcHRvcC4gIFRoZXNl
IGFyZSBhbHNvIGF2YWlsYWJsZSBieSBkZWZhdWx0IG9uIGRlc2t0b3Agc3lzdGVtcywKYmVj
YXVzZSBTcGVha3VwIGRvZXMgbm90IGtub3cgd2hldGhlciBpdCBpcyBydW5uaW5nIG9uIGEg
ZGVza3RvcCBvcgpsYXB0b3AuICBTbyB5b3UgbWF5IGNob29zZSB3aGljaCBzZXQgb2YgU3Bl
YWt1cCBrZXlzIHRvIHVzZS4gIFNvbWUKc3lzdGVtIGFkbWluaXN0cmF0b3JzIG1heSBoYXZl
IGNob3NlbiB0byBjb21waWxlIFNwZWFrdXAgZm9yIGEgZGVza3RvcApzeXN0ZW0gd2l0aG91
dCB0aGlzIHNldCBvZiBhbHRlcm5hdGUga2V5IGJpbmRpbmdzLCBidXQgdGhlc2UgZGV0YWls
cyBhcmUKYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIG1hbnVhbC4gIFRvIHVzZSB0aGUgY2Fw
cyBsb2NrIGZvciBpdHMgbm9ybWFsCnB1cnBvc2UsIGhvbGQgdGhlIHNoaWZ0IGtleSB3aGls
ZSB0b2dnbGluZyB0aGUgY2FwcyBsb2NrIG9uIGFuZCBvZmYuICBXZQpzaG91bGQgbm90ZSBo
ZXJlLCB0aGF0IGhvbGRpbmcgdGhlIGNhcHMgbG9jayBrZXkgYW5kIHByZXNzaW5nIHRoZSB6
IGtleQp3aWxsIHRvZ2dsZSB0aGUgYWx0ZXJuYXRlIGogayBsIGtleXBhZCBvbiBhbmQgb2Zm
LgoKNC4gIEtleXMgYW5kIFRoZWlyIEFzc2lnbmVkIENvbW1hbmRzCgpJbiB0aGlzIHNlY3Rp
b24sIHdlJ2xsIGdvIHRocm91Z2ggYSBsaXN0IG9mIGFsbCB0aGUgc3BlYWt1cCBrZXlzIGFu
ZApjb21tYW5kcy4gIFlvdSBjYW4gYWxzbyBnZXQgYSBsaXN0IG9mIGNvbW1hbmRzIGFuZCBh
c3NpZ25lZCBrZXlzIGZyb20KdGhlIGhlbHAgc3lzdGVtLgoKVGhlIGZvbGxvd2luZyBsaXN0
IHdhcyB0YWtlbiBmcm9tIHRoZSBzcGVha3VwbWFwLm1hcCBmaWxlLiAgS2V5CmFzc2lnbm1l
bnRzIGFyZSBvbiB0aGUgbGVmdCBvZiB0aGUgZXF1YWwgc2lnbiwgYW5kIHRoZSBhc3NvY2lh
dGVkClNwZWFrdXAgY29tbWFuZHMgYXJlIG9uIHRoZSByaWdodC4gIFRoZSBkZXNpZ25hdGlv
biAic3BrIiBtZWFucyB0byBwcmVzcwphbmQgaG9sZCB0aGUgc3BlYWt1cCBrZXksIGEuay5h
LiBrZXlwYWQgaW5zZXJ0LCBhLmsuYS4gY2FwcyBsb2NrLCB3aGlsZQpwcmVzc2luZyB0aGUg
b3RoZXIgc3BlY2lmaWVkIGtleS4KCnNwayBrZXlfZjkgPSBwdW5jX2xldmVsX2RlYwpzcGsg
a2V5X2YxMCA9IHB1bmNfbGV2ZWxfaW5jCnNwayBrZXlfZjExID0gcmVhZGluZ19wdW5jX2Rl
YwpzcGsga2V5X2YxMiA9IHJlYWRpbmdfcHVuY19pbmMKc3BrIGtleV8xID0gdm9sX2RlYwpz
cGsga2V5XzIgPSAgdm9sX2luYwpzcGsga2V5XzMgPSBwaXRjaF9kZWMKc3BrIGtleV80ID0g
cGl0Y2hfaW5jCnNwayBrZXlfNSA9IHJhdGVfZGVjCnNwayBrZXlfNiA9IHJhdGVfaW5jCmtl
eV9rcGFzdGVyaXNrID0gdG9nZ2xlX2N1cnNvcmluZwpzcGsga2V5X2twYXN0ZXJpc2sgPSBz
cGVha3VwX2dvdG8Kc3BrIGtleV9mMSA9IHNwZWFrdXBfaGVscApzcGsga2V5X2YyID0gc2V0
X3dpbgpzcGsga2V5X2YzID0gY2xlYXJfd2luCnNwayBrZXlfZjQgPSBlbmFibGVfd2luCnNw
ayBrZXlfZjUgPSBlZGl0X3NvbWUKc3BrIGtleV9mNiA9IGVkaXRfbW9zdApzcGsga2V5X2Y3
ID0gZWRpdF9kZWxpbQpzcGsga2V5X2Y4ID0gZWRpdF9yZXBlYXQKc2hpZnQgc3BrIGtleV9m
OSA9IGVkaXRfZXhudW0KIGtleV9rcDcgPSBzYXlfcHJldl9saW5lCnNwayBrZXlfa3A3ID0g
bGVmdF9lZGdlCiBrZXlfa3A4ID0gc2F5X2xpbmUKZG91YmxlICBrZXlfa3A4ID0gc2F5X2xp
bmVfaW5kZW50CnNwayBrZXlfa3A4ID0gc2F5X2Zyb21fdG9wCiBrZXlfa3A5ID0gc2F5X25l
eHRfbGluZQpzcGsgIGtleV9rcDkgPSB0b3BfZWRnZQoga2V5X2twbWludXMgPSBzcGVha3Vw
X3BhcmtlZApzcGsga2V5X2twbWludXMgPSBzYXlfY2hhcl9udW0KIGtleV9rcDQgPSBzYXlf
cHJldl93b3JkCnNwayBrZXlfa3A0ID0gc2F5X2Zyb21fbGVmdAoga2V5X2twNSA9IHNheV93
b3JkCmRvdWJsZSBrZXlfa3A1ID0gc3BlbGxfd29yZApzcGsga2V5X2twNSA9IHNwZWxsX3Bo
b25ldGljCiBrZXlfa3A2ID0gc2F5X25leHRfd29yZApzcGsga2V5X2twNiA9IHNheV90b19y
aWdodAoga2V5X2twcGx1cyA9IHNheV9zY3JlZW4Kc3BrIGtleV9rcHBsdXMgPSBzYXlfd2lu
CiBrZXlfa3AxID0gc2F5X3ByZXZfY2hhcgpzcGsga2V5X2twMSA9IHJpZ2h0X2VkZ2UKIGtl
eV9rcDIgPSBzYXlfY2hhcgpzcGsga2V5X2twMiA9IHNheV90b19ib3R0b20KZG91YmxlIGtl
eV9rcDIgPSBzYXlfcGhvbmV0aWNfY2hhcgoga2V5X2twMyA9IHNheV9uZXh0X2NoYXIKc3Br
ICBrZXlfa3AzID0gYm90dG9tX2VkZ2UKIGtleV9rcDAgPSBzcGtfa2V5CiBrZXlfa3Bkb3Qg
PSBzYXlfcG9zaXRpb24Kc3BrIGtleV9rcGRvdCA9IHNheV9hdHRyaWJ1dGVzCmtleV9rcGVu
dGVyID0gc3BlYWt1cF9xdWlldApzcGsga2V5X2twZW50ZXIgPSBzcGVha3VwX29mZgprZXlf
c3lzcnEgPSBzcGVlY2hfa2lsbAoga2V5X2twc2xhc2ggPSBzcGVha3VwX2N1dApzcGsga2V5
X2twc2xhc2ggPSBzcGVha3VwX3Bhc3RlCnNwayBrZXlfcGFnZXVwID0gc2F5X2ZpcnN0X2No
YXIKc3BrIGtleV9wYWdlZG93biA9IHNheV9sYXN0X2NoYXIKa2V5X2NhcHNsb2NrID0gc3Br
X2tleQogc3BrIGtleV96ID0gc3BrX2xvY2sKa2V5X2xlZnRtZXRhID0gc3BrX2tleQpjdHJs
IHNwayBrZXlfMCA9IHNwZWFrdXBfZ290bwpzcGsga2V5X3UgPSBzYXlfcHJldl9saW5lCnNw
ayBrZXlfaSA9IHNheV9saW5lCmRvdWJsZSBzcGsga2V5X2kgPSBzYXlfbGluZV9pbmRlbnQK
c3BrIGtleV9vID0gc2F5X25leHRfbGluZQpzcGsga2V5X21pbnVzID0gc3BlYWt1cF9wYXJr
ZWQKc2hpZnQgc3BrIGtleV9taW51cyA9IHNheV9jaGFyX251bQpzcGsga2V5X2ogPSBzYXlf
cHJldl93b3JkCnNwayBrZXlfayA9IHNheV93b3JkCmRvdWJsZSBzcGsga2V5X2sgPSBzcGVs
bF93b3JkCnNwayBrZXlfbCA9IHNheV9uZXh0X3dvcmQKc3BrIGtleV9tID0gc2F5X3ByZXZf
Y2hhcgpzcGsga2V5X2NvbW1hID0gc2F5X2NoYXIKZG91YmxlIHNwayBrZXlfY29tbWEgPSBz
YXlfcGhvbmV0aWNfY2hhcgpzcGsga2V5X2RvdCA9IHNheV9uZXh0X2NoYXIKc3BrIGtleV9u
ID0gc2F5X3Bvc2l0aW9uCiBjdHJsIHNwayBrZXlfbSA9IGxlZnRfZWRnZQogY3RybCBzcGsg
a2V5X3kgPSB0b3BfZWRnZQogY3RybCBzcGsga2V5X2RvdCA9IHJpZ2h0X2VkZ2UKY3RybCBz
cGsga2V5X3AgPSBib3R0b21fZWRnZQpzcGsga2V5X2Fwb3N0cm9waGUgPSBzYXlfc2NyZWVu
CnNwayBrZXlfaCA9IHNheV9mcm9tX2xlZnQKc3BrIGtleV95ID0gc2F5X2Zyb21fdG9wCnNw
ayBrZXlfc2VtaWNvbG9uID0gc2F5X3RvX3JpZ2h0CnNwayBrZXlfcCA9IHNheV90b19ib3R0
b20Kc3BrIGtleV9zbGFzaCA9IHNheV9hdHRyaWJ1dGVzCiBzcGsga2V5X2VudGVyID0gc3Bl
YWt1cF9xdWlldAogY3RybCAgc3BrIGtleV9lbnRlciA9IHNwZWFrdXBfb2ZmCiBzcGsga2V5
XzkgPSBzcGVha3VwX2N1dApzcGsga2V5XzggPSBzcGVha3VwX3Bhc3RlCnNoaWZ0IHNwayBr
ZXlfbSA9IHNheV9maXJzdF9jaGFyCiBjdHJsIHNwayBrZXlfc2VtaWNvbG9uID0gc2F5X2xh
c3RfY2hhcgpzcGsga2V5X3IgPSByZWFkX2FsbF9kb2MKCjUuICBUaGUgU3BlYWt1cCBTeXMg
U3lzdGVtCgpUaGUgU3BlYWt1cCBzY3JlZW4gcmVhZGVyIGFsc28gY3JlYXRlcyBhIHNwZWFr
dXAgc3ViZGlyZWN0b3J5IGFzIGEgcGFydApvZiB0aGUgc3lzIHN5c3RlbS4KCkFzIGEgY29u
dmVuaWVuY2UsIHJ1biBhcyByb290CgpsbiAtcyAvc3lzL2FjY2Vzc2liaWxpdHkvc3BlYWt1
cCAvc3BlYWt1cAoKdG8gZGlyZWN0bHkgYWNjZXNzIHNwZWFrdXAgcGFyYW1ldGVycyBmcm9t
IC9zcGVha3VwLgpZb3UgY2FuIHNlZSB0aGVzZSBlbnRyaWVzIGJ5IHR5cGluZyB0aGUgY29t
bWFuZDoKCmxzIC0xIC9zcGVha3VwLyoKCklmIHlvdSBpc3N1ZSB0aGUgYWJvdmUgbHMgY29t
bWFuZCwgeW91IHdpbGwgZ2V0IGJhY2sgc29tZXRoaW5nIGxpa2UKdGhpczoKCi9zcGVha3Vw
L2F0dHJpYl9ibGVlcAovc3BlYWt1cC9iZWxsX3Bvcwovc3BlYWt1cC9ibGVlcF90aW1lCi9z
cGVha3VwL2JsZWVwcwovc3BlYWt1cC9jdXJzb3JfdGltZQovc3BlYWt1cC9kZWxpbWl0ZXJz
Ci9zcGVha3VwL2V4X251bQovc3BlYWt1cC9rZXlfZWNobwovc3BlYWt1cC9rZXltYXAKL3Nw
ZWFrdXAvbm9faW50ZXJydXB0Ci9zcGVha3VwL3B1bmNfYWxsCi9zcGVha3VwL3B1bmNfbGV2
ZWwKL3NwZWFrdXAvcHVuY19tb3N0Ci9zcGVha3VwL3B1bmNfc29tZQovc3BlYWt1cC9yZWFk
aW5nX3B1bmMKL3NwZWFrdXAvcmVwZWF0cwovc3BlYWt1cC9zYXlfY29udHJvbAovc3BlYWt1
cC9zYXlfd29yZF9jdGwKL3NwZWFrdXAvc2lsZW50Ci9zcGVha3VwL3NwZWxsX2RlbGF5Ci9z
cGVha3VwL3N5bnRoCi9zcGVha3VwL3N5bnRoX2RpcmVjdAovc3BlYWt1cC92ZXJzaW9uCgov
c3BlYWt1cC9pMThuOgphbm5vdW5jZW1lbnRzCmNoYXJhY3RlcnMKY2hhcnRhYgpjb2xvcnMK
Y3RsX2tleXMKZm9ybWF0dGVkCmZ1bmN0aW9uX25hbWVzCmtleV9uYW1lcwpzdGF0ZXMKCi9z
cGVha3VwL3NvZnQ6CmNhcHNfc3RhcnQKY2Fwc19zdG9wCmRlbGF5X3RpbWUKZGlyZWN0CmZy
ZXEKZnVsbF90aW1lCmppZmZ5X2RlbHRhCnBpdGNoCmluZmxlY3Rpb24KcHVuY3QKcmF0ZQp0
b25lCnRyaWdnZXJfdGltZQp2b2ljZQp2b2wKCk5vdGljZSB0aGUgdHdvIHN1YmRpcmVjdG9y
aWVzIG9mIC9zcGVha3VwOiAvc3BlYWt1cC9pMThuIGFuZAovc3BlYWt1cC9zb2Z0LgpUaGUg
aTE4biBzdWJkaXJlY3RvcnkgaXMgZGVzY3JpYmVkIGluIGEgbGF0ZXIgc2VjdGlvbi4KVGhl
IGZpbGVzIHVuZGVyIC9zcGVha3VwL3NvZnQgcmVwcmVzZW50IHNldHRpbmdzIHRoYXQgYXJl
IHNwZWNpZmljIHRvIHRoZQpkcml2ZXIgZm9yIHRoZSBzb2Z0d2FyZSBzeW50aGVzaXplci4g
IElmIHlvdSB1c2UgdGhlIExpdGVUYWxrLCB5b3VyCnN5bnRoZXNpemVyLXNwZWNpZmljIHNl
dHRpbmdzIHdvdWxkIGJlIGZvdW5kIGluIC9zcGVha3VwL2x0bGsuICBJbiBvdGhlciB3b3Jk
cywKYSBzdWJkaXJlY3RvcnkgbmFtZWQgL3NwZWFrdXAvS1dEIGlzIGNyZWF0ZWQgdG8gaG9s
ZCBwYXJhbWV0ZXJzIHNwZWNpZmljCnRvIHRoZSBkZXZpY2Ugd2hvc2Uga2V5d29yZCBpcyBL
V0QuClRoZXNlIHBhcmFtZXRlcnMgaW5jbHVkZSB2b2x1bWUsIHJhdGUsIHBpdGNoLCBhbmQg
b3RoZXJzLgoKSW4gYWRkaXRpb24gdG8gdXNpbmcgdGhlIFNwZWFrdXAgaG90IGtleXMgdG8g
Y2hhbmdlIHN1Y2ggdGhpbmdzIGFzCnZvbHVtZSwgcGl0Y2gsIGFuZCByYXRlLCB5b3UgY2Fu
IGFsc28gZWNobyB2YWx1ZXMgdG8gdGhlIGFwcHJvcHJpYXRlCmVudHJ5IGluIHRoZSAvc3Bl
YWt1cCBkaXJlY3RvcnkuICBUaGlzIGlzIHZlcnkgdXNlZnVsLCBzaW5jZSBpdApsZXRzIHlv
dSBjb250cm9sIFNwZWFrdXAgcGFyYW1ldGVycyBmcm9tIHdpdGhpbiBhIHNjcmlwdC4gIEhv
dyB5b3UKd291bGQgd3JpdGUgc3VjaCBzY3JpcHRzIGlzIHNvbWV3aGF0IGJleW9uZCB0aGUg
c2NvcGUgb2YgdGhpcyBtYW51YWwsCmJ1dCBJIHdpbGwgaW5jbHVkZSBhIGNvdXBsZSBvZiBz
aW1wbGUgZXhhbXBsZXMgaGVyZSB0byBnaXZlIHlvdSBhCmdlbmVyYWwgaWRlYSBvZiB3aGF0
IHN1Y2ggc2NyaXB0cyBjYW4gZG8uCgpTdXBwb3NlIGZvciBleGFtcGxlLCB0aGF0IHlvdSB3
YW50ZWQgdG8gY29udHJvbCBib3RoIHRoZSBwdW5jdHVhdGlvbgpsZXZlbCBhbmQgdGhlIHJl
YWRpbmcgcHVuY3R1YXRpb24gbGV2ZWwgYXQgdGhlIHNhbWUgdGltZS4gIEZvcgpzaW1wbGlj
aXR5LCB3ZSdsbCBjYWxsIHRoZW0gcHVuYzAsIHB1bmMxLCBwdW5jMiwgYW5kIHB1bmMzLiAg
VGhlIHNjcmlwdHMKbWlnaHQgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlzOgoKIyEvYmluL2Jh
c2gKIyBwdW5jMAojIHNldCBwdW5jIGFuZCByZWFkaW5nIHB1bmMgbGV2ZWxzIHRvIDAKZWNo
byAwID4vc3BlYWt1cC9wdW5jX2xldmVsCmVjaG8gMCA+L3NwZWFrdXAvcmVhZGluZ19wdW5j
CmVjaG8gUHVuY3R1YXRpb24gbGV2ZWwgc2V0IHRvIDAuCgojIS9iaW4vYmFzaAojIHB1bmMx
CiMgc2V0IHB1bmMgYW5kIHJlYWRpbmcgcHVuYyBsZXZlbHMgdG8gMQplY2hvIDEgPi9zcGVh
a3VwL3B1bmNfbGV2ZWwKZWNobyAxID4vc3BlYWt1cC9yZWFkaW5nX3B1bmMKZWNobyBQdW5j
dHVhdGlvbiBsZXZlbCBzZXQgdG8gMS4KCiMhL2Jpbi9iYXNoCiMgcHVuYzIKIyBzZXQgcHVu
YyBhbmQgcmVhZGluZyBwdW5jIGxldmVscyB0byAyCmVjaG8gMiA+L3NwZWFrdXAvcHVuY19s
ZXZlbAplY2hvIDIgPi9zcGVha3VwL3JlYWRpbmdfcHVuYwplY2hvIFB1bmN0dWF0aW9uIGxl
dmVsIHNldCB0byAyLgoKIyEvYmluL2Jhc2gKIyBwdW5jMwojIHNldCBwdW5jIGFuZCByZWFk
aW5nIHB1bmMgbGV2ZWxzIHRvIDMKZWNobyAzID4vc3BlYWt1cC9wdW5jX2xldmVsCmVjaG8g
MyA+L3NwZWFrdXAvcmVhZGluZ19wdW5jCmVjaG8gUHVuY3R1YXRpb24gbGV2ZWwgc2V0IHRv
IDMuCgpJZiB5b3Ugd2VyZSB0byBzdG9yZSB0aGVzZSBmb3VyIHNtYWxsIHNjcmlwdHMgaW4g
YSBkaXJlY3RvcnkgaW4geW91cgpwYXRoLCBwZXJoYXBzIC91c3IvbG9jYWwvYmluLCBhbmQg
c2V0IHRoZSBwZXJtaXNzaW9ucyB0byA3NTUgd2l0aCB0aGUKY2htb2QgY29tbWFuZCwgdGhl
biB5b3UgY291bGQgY2hhbmdlIHRoZSBkZWZhdWx0IHJlYWRpbmcgcHVuYyBhbmQKcHVuY3R1
YXRpb24gbGV2ZWxzIGF0IHRoZSBzYW1lIHRpbWUgYnkgaXNzdWluZyBqdXN0IG9uZSBjb21t
YW5kLiAgRm9yCmV4YW1wbGUsIGlmIHlvdSB3ZXJlIHRvIGV4ZWN1dGUgdGhlIHB1bmMzIGNv
bW1hbmQgYXQgeW91ciBzaGVsbCBwcm9tcHQsCnRoZW4gdGhlIHJlYWRpbmcgcHVuYyBhbmQg
cHVuYyBsZXZlbCB3b3VsZCBib3RoIGdldCBzZXQgdG8gMy4KCkkgc2hvdWxkIG5vdGUgdGhh
dCB0aGUgYWJvdmUgc2NyaXB0cyB3ZXJlIHdyaXR0ZW4gdG8gd29yayB3aXRoIGJhc2gsIGJ1
dApyZWdhcmRsZXNzIG9mIHdoaWNoIHNoZWxsIHlvdSB1c2UsIHlvdSBzaG91bGQgYmUgYWJs
ZSB0byBkbyBzb21ldGhpbmcKc2ltaWxhci4KClRoZSBTcGVha3VwIHN5cyBzeXN0ZW0gYWxz
byBoYXMgYW5vdGhlciBpbnRlcmVzdGluZyB1c2UuICBZb3UgY2FuIGVjaG8KU3BlYWt1cCBw
YXJhbWV0ZXJzIGludG8gdGhlIHN5cyBzeXN0ZW0gaW4gYSBzY3JpcHQgZHVyaW5nIHN5c3Rl
bQpzdGFydHVwLCBhbmQgc3BlYWt1cCB3aWxsIHJldHVybiB0byB5b3VyIHByZWZlcnJlZCBw
YXJhbWV0ZXJzIGV2ZXJ5IHRpbWUKdGhlIHN5c3RlbSBpcyByZWJvb3RlZC4KCk1vc3Qgb2Yg
dGhlIFNwZWFrdXAgc3lzIHBhcmFtZXRlcnMgY2FuIGJlIG1hbmlwdWxhdGVkIGJ5IGEgcmVn
dWxhciB1c2VyCm9uIHRoZSBzeXN0ZW0uICBIb3dldmVyLCB0aGVyZSBhcmUgYSBmZXcgcGFy
YW1ldGVycyB0aGF0IGFyZSBkYW5nZXJvdXMKZW5vdWdoIHRoYXQgdGhleSBzaG91bGQgb25s
eSBiZSBtYW5pcHVsYXRlZCBieSB0aGUgcm9vdCB1c2VyIG9uIHlvdXIKc3lzdGVtLiAgVGhl
cmUgYXJlIGV2ZW4gc29tZSBwYXJhbWV0ZXJzIHRoYXQgYXJlIHJlYWQgb25seSwgYW5kIGNh
bm5vdApiZSB3cml0dGVuIHRvIGF0IGFsbC4gIEZvciBleGFtcGxlLCB0aGUgdmVyc2lvbiBl
bnRyeSBpbiB0aGUgU3BlYWt1cApzeXMgc3lzdGVtIGlzIHJlYWQgb25seS4gIFRoaXMgaXMg
YmVjYXVzZSB0aGVyZSBpcyBubyByZWFzb24gZm9yIGEgdXNlcgp0byB0YW1wZXIgd2l0aCB0
aGUgdmVyc2lvbiBudW1iZXIgd2hpY2ggaXMgcmVwb3J0ZWQgYnkgU3BlYWt1cC4gIERvaW5n
CmFuIGxzIC1sIG9uIC9zcGVha3VwL3ZlcnNpb24gd2lsbCByZXR1cm4gdGhpczoKCi1yLS1y
LS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgICAgMCBNYXIgMjEgMTM6NDYgL3Nw
ZWFrdXAvdmVyc2lvbgoKQXMgeW91IGNhbiBzZWUsIHRoZSB2ZXJzaW9uIGVudHJ5IGluIHRo
ZSBTcGVha3VwIHN5cyBzeXN0ZW0gaXMgcmVhZApvbmx5LCBpcyBvd25lZCBieSByb290LCBh
bmQgYmVsb25ncyB0byB0aGUgcm9vdCBncm91cC4gIERvaW5nIGEgY2F0IG9mCi9zcGVha3Vw
L3ZlcnNpb24gd2lsbCBkaXNwbGF5IHRoZSBTcGVha3VwIHZlcnNpb24gbnVtYmVyLCBsaWtl
CnRoaXM6CgpjYXQgL3NwZWFrdXAvdmVyc2lvbgpTcGVha3VwIHYtMi4wMCBDVlM6IFRodSBP
Y3QgMjEgMTA6Mzg6MjEgRURUIDIwMDQKc3ludGggZHRsayB2ZXJzaW9uIDEuMQoKVGhlIGRp
c3BsYXkgc2hvd3MgdGhlIFNwZWFrdXAgdmVyc2lvbiBudW1iZXIsIGFsb25nIHdpdGggdGhl
IHZlcnNpb24KbnVtYmVyIG9mIHRoZSBkcml2ZXIgZm9yIHRoZSBjdXJyZW50IHN5bnRoZXNp
emVyLgoKTG9va2luZyBhdCBlbnRyaWVzIGluIHRoZSBTcGVha3VwIHN5cyBzeXN0ZW0gY2Fu
IGJlIHVzZWZ1bCBpbiBtYW55CndheXMuICBGb3IgZXhhbXBsZSwgeW91IG1pZ2h0IHdpc2gg
dG8ga25vdyB3aGF0IGxldmVsIHlvdXIgdm9sdW1lIGlzIHNldAphdC4gIFlvdSBjb3VsZCB0
eXBlOgoKY2F0IC9zcGVha3VwL0tXRC92b2wKIyBSZXBsYWNlIEtXRCB3aXRoIHRoZSBrZXl3
b3JkIGZvciB5b3VyIHN5bnRoZXNpemVyLCBFLkcuLCBsdGxrIGZvciBMaXRlVGFsay4KNQoK
VGhlIG51bWJlciBmaXZlIHdoaWNoIGNvbWVzIGJhY2sgaXMgdGhlIGxldmVsIGF0IHdoaWNo
IHRoZSBzeW50aGVzaXplcgp2b2x1bWUgaXMgc2V0IGF0LgoKQWxsIHRoZSBlbnRyaWVzIGlu
IHRoZSBTcGVha3VwIHN5cyBzeXN0ZW0gYXJlIHJlYWRhYmxlLCBzb21lIGFyZQp3cml0YWJs
ZSBieSByb290IG9ubHksIGFuZCBzb21lIGFyZSB3cml0YWJsZSBieSBldmVyeW9uZS4gIFVu
bGVzcyB5b3UKa25vdyB3aGF0IHlvdSBhcmUgZG9pbmcsIHlvdSBzaG91bGQgcHJvYmFibHkg
bGVhdmUgdGhlIG9uZXMgdGhhdCBhcmUKd3JpdGFibGUgYnkgcm9vdCBvbmx5IGFsb25lLiAg
TW9zdCBvZiB0aGUgbmFtZXMgYXJlIHNlbGYgZXhwbGFuYXRvcnkuClZvbCBmb3IgY29udHJv
bGxpbmcgdm9sdW1lLCBwaXRjaCBmb3IgcGl0Y2gsIGluZmxlY3Rpb24gZm9yIHBpdGNoIHJh
bmdlLCByYXRlCmZvciBjb250cm9sbGluZyBzcGVha2luZyByYXRlLCBldGMuICBJZiB5b3Ug
ZmluZCBvbmUgeW91IGFyZW4ndCBzdXJlIGFib3V0LCB5b3UKY2FuIHBvc3QgYSBxdWVyeSBv
biB0aGUgU3BlYWt1cCBsaXN0LgoKNi4gIENoYW5naW5nIFN5bnRoZXNpemVycwoKSXQgaXMg
cG9zc2libGUgdG8gY2hhbmdlIHRvIGEgZGlmZmVyZW50IHN5bnRoZXNpemVyIHdoaWxlIHNw
ZWFrdXAgaXMKcnVubmluZy4gIEluIG90aGVyIHdvcmRzLCBpdCBpcyBub3QgbmVjZXNzYXJ5
IHRvIHJlYm9vdCB0aGUgc3lzdGVtCmluIG9yZGVyIHRvIHVzZSBhIGRpZmZlcmVudCBzeW50
aGVzaXplci4gIFlvdSBjYW4gc2ltcGx5IGVjaG8gdGhlCnN5bnRoZXNpemVyIGtleXdvcmQg
dG8gdGhlIC9zcGVha3VwL3N5bnRoIHN5cyBlbnRyeS4KRGVwZW5kaW5nIG9uIHlvdXIgc2l0
dWF0aW9uLCB5b3UgbWF5IHdpc2ggdG8gZWNobyBub25lIHRvIHRoZSBzeW50aApzeXMgZW50
cnksIHRvIGRpc2FibGUgc3BlZWNoIHdoaWxlIG9uZSBzeW50aGVzaXplciBpcyBkaXNjb25u
ZWN0ZWQgYW5kCmEgc2Vjb25kIG9uZSBpcyBjb25uZWN0ZWQgaW4gaXRzIHBsYWNlLiAgVGhl
biBlY2hvIHRoZSBrZXl3b3JkIGZvciB0aGUKbmV3IHN5bnRoZXNpemVyIGludG8gdGhlIHN5
bnRoIHN5cyBlbnRyeSBpbiBvcmRlciB0byBzdGFydCBzcGVlY2gKd2l0aCB0aGUgbmV3bHkg
Y29ubmVjdGVkIHN5bnRoZXNpemVyLiAgU2VlIHRoZSBsaXN0IG9mIHN5bnRoZXNpemVyCmtl
eXdvcmRzIGluIHNlY3Rpb24gMSB0byBmaW5kIHRoZSBrZXl3b3JkIHdoaWNoIG1hdGNoZXMg
eW91ciBzeW50aC4KCjcuICBMb2FkaW5nIG1vZHVsZXMKCkFzIG1lbnRpb25lZCBlYXJsaWVy
LCBTcGVha3VwIGNhbiBlaXRoZXIgYmUgY29tcGxldGVseSBjb21waWxlZCBpbnRvIHRoZQpr
ZXJuZWwsIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiB0aGUgaGVscCBtb2R1bGUsIG9yIGl0IGNh
biBiZSBjb21waWxlZCBhcwphIHNlcmllcyBvZiBtb2R1bGVzLiAgIFdoZW4gY29tcGlsZWQg
YXMgbW9kdWxlcywgU3BlYWt1cCB3aWxsIG9ubHkgYmUKYWJsZSB0byBzcGVhayBzb21lIG9m
IHRoZSBib290dXAgbWVzc2FnZXMgaWYgeW91ciBzeXN0ZW0gYWRtaW5pc3RyYXRvcgpoYXMg
Y29uZmlndXJlZCB0aGUgc3lzdGVtIHRvIGxvYWQgdGhlIG1vZHVsZXMgYXQgYm9vIHRpbWUu
IFRoZSBtb2R1bGVzCmNhbiAgYmUgbG9hZGVkIGFmdGVyIHRoZSBmaWxlIHN5c3RlbXMgaGF2
ZSBiZWVuIGNoZWNrZWQgYW5kIG1vdW50ZWQsIG9yCmZyb20gYW4gaW5pdHJkLiAgVGhlcmUg
aXMgYSB0aGlyZCBwb3NzaWJpbGl0eS4gIFNwZWFrdXAgY2FuIGJlIGNvbXBpbGVkCndpdGgg
c29tZSBjb21wb25lbnRzIGJ1aWx0IGludG8gdGhlIGtlcm5lbCwgYW5kIG90aGVycyBhcyBt
b2R1bGVzLiAgQXMKd2UnbGwgc2VlIGluIHRoZSBuZXh0IHNlY3Rpb24sIHRoaXMgaXMgcGFy
dGljdWxhcmx5IHVzZWZ1bCB3aGVuIHlvdSBhcmUKd29ya2luZyB3aXRoIHNvZnR3YXJlIHN5
bnRoZXNpemVycy4KCklmIFNwZWFrdXAgaXMgY29tcGxldGVseSBjb21waWxlZCBhcyBtb2R1
bGVzLCB0aGVuIHlvdSBtdXN0IHVzZSB0aGUKbW9kcHJvYmUgY29tbWFuZCB0byBsb2FkIFNw
ZWFrdXAuICBZb3UgZG8gdGhpcyBieSBsb2FkaW5nIHRoZSBtb2R1bGUgZm9yCnRoZSBzeW50
aGVzaXplciBkcml2ZXIgeW91IHdpc2ggdG8gdXNlLiAgVGhlIGRyaXZlciBtb2R1bGVzIGFy
ZSBhbGwKbmFtZWQgc3BlYWt1cF88a2V5d29yZD4sIHdoZXJlIDxrZXl3b3JkPiBpcyB0aGUg
a2V5d29yZCBmb3IgdGhlCnN5bnRoZXNpemVyIHlvdSB3YW50LiAgU28sIGluIG9yZGVyIHRv
IGxvYWQgdGhlIGRyaXZlciBmb3IgdGhlIERlY1RhbGsKRXhwcmVzcywgeW91IHdvdWxkIHR5
cGUgdGhlIGZvbGxvd2luZyBjb21tYW5kOgoKbW9kcHJvYmUgc3BlYWt1cF9kZWN0bGsKCklz
c3VpbmcgdGhpcyBjb21tYW5kIHdvdWxkIGxvYWQgdGhlIERlY1RhbGsgRXhwcmVzcyBkcml2
ZXIgYW5kIGFsbCBvdGhlcgpyZWxhdGVkIFNwZWFrdXAgbW9kdWxlcyBuZWNlc3NhcnkgdG8g
Z2V0IFNwZWFrdXAgdXAgYW5kIHJ1bm5pbmcuCgpUbyBjb21wbGV0ZWx5IHVubG9hZCBTcGVh
a3VwLCBhZ2FpbiBwcmVzdW1pbmcgdGhhdCBpdCBpcyBlbnRpcmVseSBidWlsdAphcyBtb2R1
bGVzLCB5b3Ugd291bGQgZ2l2ZSB0aGUgY29tbWFuZDoKCm1vZHByb2JlIC1yIHNwZWFrdXBf
ZGVjdGxrCgpUaGUgYWJvdmUgY29tbWFuZCBhc3N1bWVzIHlvdSB3ZXJlIHJ1bm5pbmcgYSBE
ZWNUYWxrIEV4cHJlc3MuICBJZiB5b3UKd2VyZSB1c2luZyBhIGRpZmZlcmVudCBzeW50aCwg
dGhlbiB5b3Ugd291bGQgc3Vic3RpdHV0ZSBpdHMga2V5d29yZCBpbgpwbGFjZSBvZiBkZWN0
bGsuCgpJZiB5b3UgaGF2ZSBtdWx0aXBsZSBkcml2ZXJzIGxvYWRlZCwgeW91IG5lZWQgdG8g
dW5sb2FkIGFsbCBvZiB0aGVtLCBpbgpvcmRlciB0byBjb21wbGV0ZWx5IHVubG9hZCBTcGVh
a3VwLgpGb3IgZXhhbXBsZSwgaWYgeW91IGhhdmUgbG9hZGVkIGJvdGggdGhlIGRlY3RsayBh
bmQgbHRsayBkcml2ZXJzLCB1c2UgdGhlCmNvbW1hbmQ6Cm1vZHByb2JlIC1yIHNwZWFrdXBf
ZGVjdGxrIHNwZWFrdXBfbHRsawoKWW91IGNhbm5vdCB1bmxvYWQgdGhlIGRyaXZlciBmb3Ig
c29mdHdhcmUgc3ludGhlc2l6ZXJzIHdoZW4gYSB1c2VyLXNwYWNlCmRhZW1vbiBpcyB1c2lu
ZyAvZGV2L3NvZnRzeW50aC4gIEZpcnN0LCBraWxsIHRoZSBkYWVtb24uICBOZXh0LCByZW1v
dmUKdGhlIGRyaXZlciB3aXRoIHRoZSBjb21tYW5kOgptb2Rwcm9iZSAtciBzcGVha3VwX3Nv
ZnQKCk5vdywgc3VwcG9zZSB3ZSBoYXZlIGEgc2l0dWF0aW9uIHdoZXJlIHRoZSBtYWluIFNw
ZWFrdXAgY29tcG9uZW50CmlzIGJ1aWx0IGludG8gdGhlIGtlcm5lbCwgYW5kIHNvbWUgb3Ig
YWxsIG9mIHRoZSBkcml2ZXJzIGFyZSBidWlsdCBhcwptb2R1bGVzLiAgU2luY2UgdGhlIG1h
aW4gcGFydCBvZiBTcGVha3VwIGlzIGNvbXBpbGVkIGludG8gdGhlIGtlcm5lbCwgYQpwYXJ0
aWFsIFNwZWFrdXAgc3lzIHN5c3RlbSBoYXMgYmVlbiBjcmVhdGVkIHdoaWNoIHdlIGNhbiB0
YWtlIGFkdmFudGFnZQpvZiBieSBzaW1wbHkgZWNob2luZyB0aGUgc3ludGhlc2l6ZXIga2V5
d29yZCBpbnRvIHRoZQovc3BlYWt1cC9zeW50aCBzeXMgZW50cnkuICBUaGlzIHdpbGwgY2F1
c2UgdGhlIGtlcm5lbCB0bwphdXRvbWF0aWNhbGx5IGxvYWQgdGhlIGFwcHJvcHJpYXRlIGRy
aXZlciBtb2R1bGUsIGFuZCBzdGFydCBTcGVha3VwCnRhbGtpbmcuICBUbyBzd2l0Y2ggdG8g
YW5vdGhlciBzeW50aCwganVzdCBlY2hvIGEgbmV3IGtleXdvcmQgdG8gdGhlCnN5bnRoIHN5
cyBlbnRyeS4gIEZvciBleGFtcGxlLCB0byBsb2FkIHRoZSBEb3VibGVUYWxrIExUIGRyaXZl
ciwKeW91IHdvdWxkIHR5cGU6CgplY2hvIGx0bGsgPi9zcGVha3VwL3N5bnRoCgpZb3UgY2Fu
IHVzZSB0aGUgbW9kcHJvYmUgLXIgY29tbWFuZCB0byB1bmxvYWQgZHJpdmVyIG1vZHVsZXMs
IHJlZ2FyZGxlc3MKb2Ygd2hldGhlciB0aGUgbWFpbiBwYXJ0IG9mIFNwZWFrdXAgaGFzIGJl
ZW4gYnVpbHQgaW50byB0aGUga2VybmVsIG9yCm5vdC4KCjguICBVc2luZyBTb2Z0d2FyZSBT
eW50aGVzaXplcnMKClVzaW5nIGEgc29mdHdhcmUgc3ludGhlc2l6ZXIgcmVxdWlyZXMgdGhh
dCBzb21lIG90aGVyIHNvZnR3YXJlIGJlCmluc3RhbGxlZCBhbmQgcnVubmluZyBvbiB5b3Vy
IHN5c3RlbS4gIEZvciB0aGlzIHJlYXNvbiwgc29mdHdhcmUKc3ludGhlc2l6ZXJzIGFyZSBu
b3QgYXZhaWxhYmxlIGZvciB1c2UgYXQgYm9vdHVwLCBvciBkdXJpbmcgYSBzeXN0ZW0KaW5z
dGFsbGF0aW9uIHByb2Nlc3MuClRoZXJlIGFyZSB0d28gZnJlZWx5LWF2YWlsYWJsZSBzb2x1
dGlvbnMgZm9yIHNvZnR3YXJlIHNwZWVjaDogRXNwZWFrdXAgYW5kClNwZWVjaCBEaXNwYXRj
aGVyLgpUaGVzZSBhcmUgZGVzY3JpYmVkIGluIHN1YnNlY3Rpb25zIDguMSBhbmQgOC4yLCBy
ZXNwZWN0aXZlbHkuCgpEdXJpbmcgdGhlIHJlc3Qgb2YgdGhpcyBzZWN0aW9uLCB3ZSBhc3N1
bWUgdGhhdCBzcGVha3VwX3NvZnQgaXMgZWl0aGVyCmJ1aWx0IGluIHRvIHlvdXIga2VybmVs
LCBvciBsb2FkZWQgYXMgYSBtb2R1bGUuCgpJZiB5b3VyIHN5c3RlbSBkb2VzIG5vdCBoYXZl
IHVkZXYgaW5zdGFsbGVkICwgYmVmb3JlIHlvdSBjYW4gdXNlIGEKc29mdHdhcmUgc3ludGhl
c2l6ZXIsIHlvdSBtdXN0IGhhdmUgY3JlYXRlZCB0aGUgL2Rldi9zb2Z0c3ludGggZGV2aWNl
LgpJZiB5b3UgaGF2ZSBub3QgYWxyZWFkeSBkb25lIHNvLCBpc3N1ZSB0aGUgZm9sbG93aW5n
IGNvbW1hbmRzIGFzIHJvb3Q6CgpjZCAvZGV2Cm1rbm9kIHNvZnRzeW50aCBjIDEwIDI2CgpX
aGlsZSB3ZSBhcmUgYXQgaXQsIHdlIG1pZ2h0IGp1c3QgYXMgd2VsbCBjcmVhdGUgdGhlIC9k
ZXYvc3ludGggZGV2aWNlLAp3aGljaCBjYW4gYmUgdXNlZCB0byBsZXQgdXNlciBzcGFjZSBw
cm9ncmFtcyBzZW5kIGluZm9ybWF0aW9uIHRvIHlvdXIKc3ludGhlc2l6ZXIuICBUbyBjcmVh
dGUgL2Rldi9zeW50aCwgY2hhbmdlIHRvIHRoZSAvZGV2IGRpcmVjdG9yeSwgYW5kCmlzc3Vl
IHRoZSBmb2xsb3dpbmcgY29tbWFuZCBhcyByb290OgoKbWtub2Qgc3ludGggYyAxMCAyNQoK
b2YgYm90aC4KCjguMS4gRXNwZWFrdXAKCkVzcGVha3VwIGlzIGEgY29ubmVjdG9yIGJldHdl
ZW4gU3BlYWt1cCBhbmQgdGhlIGVTcGVhayBzb2Z0d2FyZSBzeW50aGVzaXplci4KRXNwZWFr
dXAgbWF5IGFscmVhZHkgYmUgYXZhaWxhYmxlIGFzIGEgcGFja2FnZSBmb3IgeW91ciBkaXN0
cmlidXRpb24Kb2YgTGludXguICBJZiBpdCBpcyBub3QgcGFja2FnZWQsIHlvdSBuZWVkIHRv
IGluc3RhbGwgaXQgbWFudWFsbHkuCllvdSBjYW4gZmluZCBpdCBpbiB0aGUgY29udHJpYi8g
c3ViZGlyZWN0b3J5IG9mIHRoZSBTcGVha3VwIHNvdXJjZXMuClRoZSBmaWxlbmFtZSBpcyBl
c3BlYWt1cC0kVkVSU0lPTi50YXIuYnoyLCB3aGVyZSAkVkVSU0lPTgpkZXBlbmRzIG9uIHRo
ZSBjdXJyZW50IHJlbGVhc2Ugb2YgRXNwZWFrdXAuICBUaGUgU3BlYWt1cCAzLjEuMiBzb3Vy
Y2UKc2hpcHMgd2l0aCB2ZXJzaW9uIDAuNzEgb2YgRXNwZWFrdXAuClRoZSBSRUFETUUgZmls
ZSBpbmNsdWRlZCB3aXRoIHRoZSBFc3BlYWt1cCBzb3VyY2VzIGRlc2NyaWJlcyB0aGUgcHJv
Y2VzcwpvZiBtYW51YWwgaW5zdGFsbGF0aW9uLgoKQXNzdW1pbmcgdGhhdCBFc3BlYWt1cCBp
cyBpbnN0YWxsZWQsIGVpdGhlciBieSB0aGUgdXNlciBvciBieSB0aGUgZGlzdHJpYnV0b3Is
CmZvbGxvdyB0aGVzZSBzdGVwcyB0byB1c2UgaXQuCgpUZWxsIFNwZWFrdXAgdG8gdXNlIHRo
ZSAic29mdCBkcml2ZXI6CmVjaG8gc29mdCA+IC9zcGVha3VwL3N5bnRoCgpGaW5hbGx5LCBz
dGFydCB0aGUgZXNwZWFrdXAgcHJvZ3JhbS4gIFRoZXJlIGFyZSB0d28gd2F5cyB0byBkbyBp
dC4KQm90aCByZXF1aXJlIHJvb3QgcHJpdmlsZWdlcy4KCklmIEVzcGVha3VwIHdhcyBpbnN0
YWxsZWQgYXMgYSBwYWNrYWdlIGZvciB5b3VyIExpbnV4IGRpc3RyaWJ1dGlvbiwKeW91IHBy
b2JhYmx5IGhhdmUgYSBkaXN0cmlidXRpb24tc3BlY2lmaWMgc2NyaXB0IHRoYXQgY29udHJv
bHMgdGhlIG9wZXJhdGlvbgpvZiB0aGUgZGFlbW9uLiAgTG9vayBmb3IgYSBmaWxlIG5hbWVk
IGVzcGVha3VwIHVuZGVyIC9ldGMvaW5pdC5kIG9yCi9ldGMvcmMuZC4gIEV4ZWN1dGUgdGhl
IGZvbGxvd2luZyBjb21tYW5kIHdpdGggcm9vdCBwcml2aWxlZ2VzOgovZXRjL2luaXQuZC9l
c3BlYWt1cCBzdGFydApSZXBsYWNlIGluaXQuZCB3aXRoIHJjLmQsIGlmIHlvdXIgZGlzdHJp
YnV0aW9uIHVzZXMgc2NyaXB0cyBsb2NhdGVkIHVuZGVyCi9ldGMvcmMuZC4KWW91ciBkaXN0
cmlidXRpb24gd2lsbCBhbHNvIGhhdmUgYSBwcm9jZWR1cmUgZm9yIHN0YXJ0aW5nIGRhZW1v
bnMgYXQKYm9vdC10aW1lLCBzbyBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIHNvZnR3YXJlIHNw
ZWVjaCBhcyBzb29uIGFzIHVzZXItc3BhY2UKZGFlbW9ucyBhcmUgc3RhcnRlZCBieSB0aGUg
Ym9vdHVwIHNjcmlwdHMuClRoZXNlIHByb2NlZHVyZXMgYXJlIG5vdCBkZXNjcmliZWQgaW4g
dGhpcyBkb2N1bWVudC4KCklmIHlvdSBidWlsdCBFc3BlYWt1cCBtYW51YWxseSwgdGhlICJt
YWtlIGluc3RhbGwiIHN0ZXAgcGxhY2VkIHRoZSBiaW5hcnkKdW5kZXIgL3Vzci9iaW4uClJ1
biB0aGUgZm9sbG93aW5nIGNvbW1hbmQgYXMgcm9vdDoKL3Vzci9iaW4vZXNwZWFrdXAKRXNw
ZWFrdXAgc2hvdWxkIHN0YXJ0IHNwZWFraW5nLgoKOC4yLiBTcGVlY2ggRGlzcGF0Y2hlcgoK
Rm9yIHRoaXMgb3B0aW9uLCB5b3UgbXVzdCBoYXZlIGEgcGFja2FnZSBjYWxsZWQKU3BlZWNo
IERpc3BhdGNoZXIgcnVubmluZyBvbiB5b3VyIHN5c3RlbSwgYW5kIGl0IG11c3QgYmUgY29u
ZmlndXJlZCB0bwp3b3JrIHdpdGggb25lIG9mIGl0cyBzdXBwb3J0ZWQgc29mdHdhcmUgc3lu
dGhlc2l6ZXJzLgoKVHdvIG9wZW4gc291cmNlIHN5bnRoZXNpemVycyB5b3UgbWlnaHQgdXNl
IGFyZSBGbGl0ZSBhbmQgRmVzdGl2YWwuICBZb3UKbWlnaHQgYWxzbyBjaG9vc2UgdG8gcHVy
Y2hhc2UgdGhlIFNvZnR3YXJlIERlY1RhbGsgZnJvbSBGb25peCBTYWxlcyBJbmMuCklmIHlv
dSBydW4gYSBnb29nbGUgc2VhcmNoIGZvciBGb25peCwgeW91J2xsIGZpbmQgdGhlaXIgd2Vi
IHNpdGUuCgpZb3UgY2FuIG9idGFpbiBhIGNvcHkgb2YgU3BlZWNoIERpc3BhdGNoZXIgZnJv
bSBmcmVlKGIpc29mdCBhdApodHRwOi8vd3d3LmZyZWVic29mdC5vcmcvLiAgRm9sbG93IHRo
ZSBpbnN0YWxsYXRpb24gaW5zdHJ1Y3Rpb25zIHRoYXQKY29tZSB3aXRoIFNwZWVjaCBEaXNw
YXRjaGVyIGluIG9yZGVyIHRvIGluc3RhbGwgYW5kIGNvbmZpZ3VyZSBTcGVlY2gKRGlzcGF0
Y2hlci4gIFlvdSBjYW4gY2hlY2sgb3V0IHRoZSB3ZWIgc2l0ZSBmb3IgeW91ciBMaW51eCBk
aXN0cmlidXRpb24KaW4gb3JkZXIgdG8gZ2V0IGEgY29weSBvZiBlaXRoZXIgRmxpdGUgb3Ig
RmVzdGl2YWwuICBZb3VyIExpbnV4CmRpc3RyaWJ1dGlvbiBtYXkgYWxzbyBoYXZlIGEgcHJl
Y29tcGlsZWQgU3BlZWNoIERpc3BhdGNoZXIgcGFja2FnZS4KCk9uY2UgeW91J3ZlIGluc3Rh
bGxlZCwgY29uZmlndXJlZCwgYW5kIHRlc3RlZCBTcGVlY2ggRGlzcGF0Y2hlciB3aXRoIHlv
dXIKY2hvc2VuIHNvZnR3YXJlIHN5bnRoZXNpemVyLCB5b3Ugc3RpbGwgbmVlZCBvbmUgbW9y
ZSBwaWVjZSBvZiBzb2Z0d2FyZQppbiBvcmRlciB0byBtYWtlIHRoaW5ncyB3b3JrLiAgWW91
IG5lZWQgYSBwYWNrYWdlIGNhbGxlZCBzcGVlY2hkLXVwLgpZb3UgZ2V0IGl0IGZyb20gdGhl
IGZyZWUoYilzb2Z0IHdlYiBzaXRlIG1lbnRpb25lZCBhYm92ZS4gIEFmdGVyIHlvdSd2ZQpj
b21waWxlZCBhbmQgaW5zdGFsbGVkIHNwZWVjaGQtdXAsIHlvdSBhcmUgYWxtb3N0IHJlYWR5
IHRvIGJlZ2luIHVzaW5nCnlvdXIgc29mdHdhcmUgc3ludGhlc2l6ZXIuCgpOb3cgeW91IGNh
biBiZWdpbiB1c2luZyB5b3VyIHNvZnR3YXJlIHN5bnRoZXNpemVyLiAgSW4gb3JkZXIgdG8g
ZG8gc28sCmVjaG8gdGhlIHNvZnQga2V5d29yZCB0byB0aGUgc3ludGggc3lzIGVudHJ5IGxp
a2UgdGhpczoKCmVjaG8gc29mdCA+L3NwZWFrdXAvc3ludGgKCk5leHQgcnVuIHRoZSBzcGVl
Y2hkX3VwIGNvbW1hbmQgbGlrZSB0aGlzOgoKc3BlZWNoZF91cCAmCgpZb3VyIHN5bnRoIHNo
b3VsZCBub3cgc3RhcnQgdGFsa2luZywgYW5kIHlvdSBzaG91bGQgYmUgYWJsZSB0byBhZGp1
c3QKdGhlIHBpdGNoLCByYXRlLCBldGMuCgo5LiAgVXNpbmcgVGhlIERlY1RhbGsgUEMgQ2Fy
ZAoKVGhlIERlY1RhbGsgUEMgY2FyZCBpcyBhbiBJU0EgY2FyZCB0aGF0IGlzIGluc2VydGVk
IGludG8gb25lIG9mIHRoZSBJU0EKc2xvdHMgaW4geW91ciBjb21wdXRlci4gIEl0IHJlcXVp
cmVzIHRoYXQgdGhlIERlY1RhbGsgUEMgc29mdHdhcmUgYmUKaW5zdGFsbGVkIG9uIHlvdXIg
Y29tcHV0ZXIsIGFuZCB0aGF0IHRoZSBzb2Z0d2FyZSBiZSBsb2FkZWQgb250byB0aGUKRGVj
dGFsayBQQyBjYXJkIGJlZm9yZSBpdCBjYW4gYmUgdXNlZC4KCllvdSBjYW4gZ2V0IHRoZSBk
ZWNfcGMudGd6IGZpbGUgZnJvbSB0aGUgbGludXgtc3BlYWt1cC5vcmcgc2l0ZS4gIFRoZQpk
ZWNfcGMudGd6IGZpbGUgaXMgaW4gdGhlIH5mdHAvcHViL2xpbnV4L3NwZWFrdXAgZGlyZWN0
b3J5LgoKQWZ0ZXIgeW91IGhhdmUgZG93bmxvYWRlZCB0aGUgZGVjX3BjLnRneiBmaWxlLCB1
bnRhciBpdCBpbiB5b3VyIGhvbWUKZGlyZWN0b3J5LCBhbmQgcmVhZCB0aGUgUmVhZG1lIGZp
bGUgaW4gdGhlIG5ld2x5IGNyZWF0ZWQgZGVjX3BjCmRpcmVjdG9yeS4KClRoZSBlYXNpZXN0
IHdheSB0byBnZXQgdGhlIHNvZnR3YXJlIHdvcmtpbmcgaXMgdG8gY29weSB0aGUgZW50aXJl
IGRlY19wYwpkaXJlY3RvcnkgaW50byAvdXNlci9sb2NhbC9saWIuICBUbyBkbyB0aGlzLCBz
dSB0byByb290IGluIHlvdXIgaG9tZQpkaXJlY3RvcnksIGFuZCBpc3N1ZSB0aGUgY29tbWFu
ZDoKCmNwIGRlY19wYyAvdXNyL2xvY2FsL2xpYgoKWW91IHdpbGwgbmVlZCB0byBjb3B5IHRo
ZSBkdGxvYWQgY29tbWFuZCBmcm9tIHRoZSBkZWNfcGMgZGlyZWN0b3J5IHRvIGEKZGlyZWN0
b3J5IGluIHlvdXIgcGF0aC4gIEVpdGhlciAvdXNyL2JpbiBvciAvdXNyL2xvY2FsL2JpbiBp
cyBhIGdvb2QKY2hvaWNlLgoKWW91IGNhbiBub3cgcnVuIHRoZSBkdGxvYWQgY29tbWFuZCBp
biBvcmRlciB0byBsb2FkIHRoZSBEZWNUYWxrIFBDCnNvZnR3YXJlIG9udG8gdGhlIGNhcmQu
ICBBZnRlciB5b3UgaGF2ZSBkb25lIHRoaXMsIGVjaG8gdGhlIGRlY3BjCmtleXdvcmQgdG8g
dGhlIHN5bnRoIGVudHJ5IGluIHRoZSBzeXMgc3lzdGVtIGxpa2UgdGhpczoKCmVjaG8gZGVj
cGMgPi9zcGVha3VwL3N5bnRoCgpZb3VyIERlY1RhbGsgUEMgc2hvdWxkIHN0YXJ0IHRhbGtp
bmcsIGFuZCB0aGVuIHlvdSBjYW4gYWRqdXN0IHRoZSBwaXRjaCwKcmF0ZSwgdm9sdW1lLCB2
b2ljZSwgZXRjLiAgVGhlIHZvaWNlIGVudHJ5IGluIHRoZSBTcGVha3VwIHN5cyBzeXN0ZW0K
d2lsbCBhY2NlcHQgYSBudW1iZXIgZnJvbSAwIHRocm91Z2ggNyBmb3IgdGhlIERlY1RhbGsg
UEMgc3ludGhlc2l6ZXIsCndoaWNoIHdpbGwgZ2l2ZSB5b3UgYWNjZXNzIHRvIHNvbWUgb2Yg
dGhlIERlY1RhbGsgdm9pY2VzLgoKMTAuICBVc2luZyBDdXJzb3IgVHJhY2tpbmcKCkluIFNw
ZWFrdXAgdmVyc2lvbiAyLjAgYW5kIGxhdGVyLCBjdXJzb3IgdHJhY2tpbmcgaXMgdHVybmVk
IG9uIGJ5CmRlZmF1bHQuICBUaGlzIG1lYW5zIHRoYXQgd2hlbiB5b3UgYXJlIHVzaW5nIGFu
IGVkaXRvciwgU3BlYWt1cCB3aWxsCmF1dG9tYXRpY2FsbHkgc3BlYWsgY2hhcmFjdGVycyBh
cyB5b3UgbW92ZSBsZWZ0IGFuZCByaWdodCB3aXRoIHRoZQpjdXJzb3Iga2V5cywgYW5kIGxp
bmVzIGFzIHlvdSBtb3ZlIHVwIGFuZCBkb3duIHdpdGggdGhlIGN1cnNvciBrZXlzLgpUaGlz
IGlzIHRoZSB0cmFkaXRpb25hbCBzb3J0IG9mIGN1cnNvciB0cmFja2luZy4KUmVjZW50IHZl
cnNpb25zIG9mIFNwZWFrdXAgcHJvdmlkZSB0d28gYWRkaXRpb25hbCB3YXlzIHRvIGNvbnRy
b2wgdGhlCnRleHQgdGhhdCBpcyBzcG9rZW4gd2hlbiB0aGUgY3Vyc29yIGlzIG1vdmVkOgoi
aGlnaGxpZ2h0IHRyYWNraW5nIiBhbmQgInJlYWQgd2luZG93LiIKVGhleSBhcmUgZGVzY3Jp
YmVkIGxhdGVyIGluIHRoaXMgc2VjdGlvbi4KU29tZXRpbWVzLCB0aGVzZSBtb2RlcyBnZXQg
aW4geW91ciB3YXksIHNvIHlvdSBjYW4gZGlzYWJsZSBjdXJzb3IgdHJhY2tpbmcKYWx0b2dl
dGhlci4KCllvdSBtYXkgc2VsZWN0IGFtb25nIHRoZSB2YXJpb3VzIGZvcm1zIG9mIGN1cnNv
ciB0cmFja2luZyB1c2luZyB0aGUga2V5cGFkCmFzdGVyaXNrIGtleS4KRWFjaCB0aW1lIHlv
dSBwcmVzcyB0aGlzIGtleSwgYSBuZXcgbW9kZSBpcyBzZWxlY3RlZCwgYW5kIFNwZWFrdXAg
c3BlYWtzCnRoZSBuYW1lIG9mIHRoZSBuZXcgbW9kZS4gIFRoZSBuYW1lcyBmb3IgdGhlIGZv
dXIgcG9zc2libGUgc3RhdGVzIG9mIGN1cnNvcgp0cmFja2luZyBhcmU6ICJjdXJzb3Jpbmcg
b24iLCAiaGlnaGxpZ2h0IHRyYWNraW5nIiwgInJlYWQgd2luZG93IiwKYW5kICJjdXJzb3Jp
bmcgb2ZmLiIgIFRoZSBrZXlwYWQgYXN0ZXJpc2sga2V5IG1vdmVzIHRocm91Z2ggdGhlIGxp
c3Qgb2YKbW9kZXMgaW4gYSBjaXJjdWxhciBmYXNoaW9uLgoKSWYgaGlnaGxpZ2h0IHRyYWNr
aW5nIGlzIGVuYWJsZWQsIFNwZWFrdXAgdHJhY2tzIGhpZ2hsaWdodGVkIHRleHQsCnJhdGhl
ciB0aGFuIHRoZSBjdXJzb3IgaXRzZWxmLiBXaGVuIHlvdSBtb3ZlIHRoZSBjdXJzb3Igd2l0
aCB0aGUgYXJyb3cga2V5cywKU3BlYWt1cCBzcGVha3MgdGhlIGN1cnJlbnRseSBoaWdobGln
aHRlZCBpbmZvcm1hdGlvbi4KVGhpcyBpcyB1c2VmdWwgd2hlbiBtb3ZpbmcgdGhyb3VnaCB2
YXJpb3VzIG1lbnVzIGFuZCBkaWFsb2cgYm94ZXMuCklmIGN1cnNvciB0cmFja2luZyBpc24n
dCBoZWxwaW5nIHlvdSB3aGlsZSBuYXZpZ2F0aW5nIGEgbWVudSwKdHJ5IGhpZ2hsaWdodCB0
cmFja2luZy4KCldpdGggdGhlICJyZWFkIHdpbmRvdyIgdmFyaWV0eSBvZiBjdXJzb3IgdHJh
Y2tpbmcsIHlvdSBjYW4gbGltaXQgdGhlIHRleHQKdGhhdCBTcGVha3VwIHNwZWFrcyBieSBz
cGVjaWZ5aW5nIGEgd2luZG93IG9mIGludGVyZXN0IG9uIHRoZSBzY3JlZW4uClNlZSBzZWN0
aW9uIDE1IGZvciBhIGRlc2NyaXB0aW9uIG9mIHRoZSBwcm9jZXNzIG9mIGRlZmluaW5nIHdp
bmRvd3MuCldoZW4geW91IG1vdmUgdGhlIGN1cnNvciB2aWEgdGhlIGFycm93IGtleXMsIFNw
ZWFrdXAgb25seSBzcGVha3MKdGhlIGNvbnRlbnRzIG9mIHRoZSB3aW5kb3cuICBUaGlzIGlz
IGVzcGVjaWFsbHkgaGVscGZ1bCB3aGVuIHlvdSBhcmUgaGVhcmluZwpzdXBlcmZsdW91cyBz
cGVlY2guICBDb25zaWRlciB0aGUgZm9sbG93aW5nIGV4YW1wbGUuCgpTdXBwb3NlIHRoYXQg
eW91IGFyZSBhdCBhIHNoZWxsIHByb21wdC4gIFlvdSB1c2UgYmFzaCwgYW5kIHlvdSB3YW50
IHRvCmV4cGxvcmUgeW91ciBjb21tYW5kIGhpc3RvcnkgdXNpbmcgdGhlIHVwIGFuZCBkb3du
IGFycm93IGtleXMuICBJZiB5b3UKaGF2ZSBlbmFibGVkIGN1cnNvciB0cmFja2luZywgeW91
IHdpbGwgaGVhciB0d28gcGllY2VzIG9mIGluZm9ybWF0aW9uLgpTcGVha3VwIHNwZWFrcyBi
b3RoIHlvdXIgc2hlbGwgcHJvbXB0IGFuZCB0aGUgY3VycmVudCBlbnRyeSBmcm9tIHRoZQpj
b21tYW5kIGhpc3RvcnkuICBZb3UgbWF5IG5vdCB3YW50IHRvIGhlYXIgdGhlIHByb21wdCBy
ZXBlYXRlZAplYWNoIHRpbWUgeW91IG1vdmUsIHNvIHlvdSBjYW4gc2lsZW5jZSBpdCBieSBz
cGVjaWZ5aW5nIGEgd2luZG93LiAgRmluZAp0aGUgbGFzdCBsaW5lIG9mIHRleHQgb24gdGhl
IHNjcmVlbi4gIENsZWFyIHRoZSBjdXJyZW50IHdpbmRvdyBieSBwcmVzc2luZwp0aGUga2V5
IGNvbWJpbmF0aW9uIHNwZWFrdXAgZjMuICBVc2UgdGhlIHJldmlldyBjdXJzb3IgdG8gZmlu
ZCB0aGUgZmlyc3QKY2hhcmFjdGVyIHRoYXQgZm9sbG93cyB5b3VyIHNoZWxsIHByb21wdC4g
IFByZXNzIHNwZWFrdXAgKyBmMiB0d2ljZSwgdG8KZGVmaW5lIGEgb25lLWxpbmUgd2luZG93
LiAgVGhlIGJvdW5kYXJpZXMgb2YgdGhlIHdpbmRvdyBhcmUgdGhlCmNoYXJhY3RlciBmb2xs
b3dpbmcgdGhlIHNoZWxsIHByb21wdCBhbmQgdGhlIGVuZCBvZiB0aGUgbGluZS4gIE5vdywg
Y3ljbGUKdGhyb3VnaCB0aGUgY3Vyc29yIHRyYWNraW5nIG1vZGVzIHVzaW5nIGtleXBhZCBh
c3RlcmlzaywgdW50aWwgU3BlYWt1cApzYXlzICJyZWFkIHdpbmRvdy4iICBNb3ZlIHRocm91
Z2ggeW91ciBoaXN0b3J5IHVzaW5nIHlvdXIgYXJyb3cga2V5cy4KWW91IHdpbGwgbm90aWNl
IHRoYXQgU3BlYWt1cCBubyBsb25nZXIgc3BlYWtzIHRoZSByZWR1bmRhbnQgcHJvbXB0LgoK
U29tZSBmb2xrcyBsaWtlIHRvIHR1cm4gY3Vyc29yIHRyYWNraW5nIG9mZiB3aGlsZSB0aGV5
IGFyZSB1c2luZyB0aGUKbHlueCB3ZWIgYnJvd3Nlci4gIFlvdSBkZWZpbml0ZWx5IHdhbnQg
dG8gdHVybiBjdXJzb3IgdHJhY2tpbmcgb2ZmIHdoZW4KeW91IGFyZSB1c2luZyB0aGUgYWxz
YW1peGVyIGFwcGxpY2F0aW9uLiAgT3RoZXJ3aXNlLCB5b3Ugd29uJ3QgYmUgYWJsZQp0byBo
ZWFyIHlvdXIgbWl4ZXIgc2V0dGluZ3Mgd2hpbGUgeW91IGFyZSB1c2luZyB0aGUgYXJyb3cg
a2V5cy4KCjExLiAgQ3V0IGFuZCBQYXN0ZQoKT25lIG9mIFNwZWFrdXAncyBtb3JlIHVzZWZ1
bCBmZWF0dXJlcyBpcyB0aGUgYWJpbGl0eSB0byBjdXQgYW5kIHBhc3RlCnRleHQgb24gdGhl
IHNjcmVlbi4gIFRoaXMgbWVhbnMgdGhhdCB5b3UgY2FuIGNhcHR1cmUgaW5mb3JtYXRpb24g
ZnJvbSBhCnByb2dyYW0sIGFuZCBwYXN0ZSB0aGF0IGNhcHR1cmVkIHRleHQgaW50byBhIGRp
ZmZlcmVudCBwbGFjZSBpbiB0aGUKcHJvZ3JhbSwgb3IgaW50byBhbiBlbnRpcmVseSBkaWZm
ZXJlbnQgcHJvZ3JhbSwgd2hpY2ggbWF5IGV2ZW4gYmUKcnVubmluZyBvbiBhIGRpZmZlcmVu
dCBjb25zb2xlLgoKRm9yIGV4YW1wbGUsIGluIHRoaXMgbWFudWFsLCB3ZSBoYXZlIG1hZGUg
cmVmZXJlbmNlcyB0byBzZXZlcmFsIHdlYgpzaXRlcy4gIEl0IHdvdWxkIGJlIG5pY2UgaWYg
eW91IGNvdWxkIGN1dCBhbmQgcGFzdGUgdGhlc2UgdXJscyBpbnRvIHlvdXIKd2ViIGJyb3dz
ZXIuICBTcGVha3VwIGRvZXMgdGhpcyBxdWl0ZSBuaWNlbHkuICBTdXBwb3NlIHlvdSB3YW50
ZWQgdG8KcGFzdCB0aGUgZm9sbG93aW5nIHVybCBpbnRvIHlvdXIgYnJvd3NlcjoKCmh0dHA6
Ly9saW51eC1zcGVha3VwLm9yZy8KClVzZSB0aGUgc3BlYWt1cCByZXZpZXcga2V5cyB0byBw
b3NpdGlvbiB0aGUgcmVhZGluZyBjdXJzb3Igb24gdGhlIGZpcnN0CmNoYXJhY3RlciBvZiB0
aGUgYWJvdmUgdXJsLiAgV2hlbiB0aGUgcmVhZGluZyBjdXJzb3IgaXMgaW4gcG9zaXRpb24s
CnByZXNzIHRoZSBrZXlwYWQgc2xhc2gga2V5IG9uY2UuICBTcGVha3VwIHdpbGwgc2F5LCAi
bWFyayIuICBOZXh0LApwb3NpdGlvbiB0aGUgcmVhZGluZyBjdXJzb3Igb24gdGhlIHJpZ2h0
bW9zdCBjaGFyYWN0ZXIgb2YgdGhlIGFib3ZlCnVybC4gUHJlc3MgdGhlIGtleXBhZCBzbGFz
aCBrZXkgb25jZSBhZ2FpbiB0byBhY3R1YWxseSBjdXQgdGhlIHRleHQKZnJvbSB0aGUgc2Ny
ZWVuLiAgU3BlYWt1cCB3aWxsIHNheSwgImN1dCIuICBBbHRob3VnaCB3ZSBjYWxsIHRoaXMK
Y3V0dGluZywgU3BlYWt1cCBkb2VzIG5vdCBhY3R1YWxseSBkZWxldGUgdGhlIGN1dCB0ZXh0
IGZyb20gdGhlIHNjcmVlbi4KSXQgbWFrZXMgYSBjb3B5IG9mIHRoZSB0ZXh0IGluIGEgc3Bl
Y2lhbCBidWZmZXIgZm9yIGxhdGVyIHBhc3RpbmcuCgpOb3cgdGhhdCB5b3UgaGF2ZSB0aGUg
dXJsIGN1dCBmcm9tIHRoZSBzY3JlZW4sIHlvdSBjYW4gcGFzdGUgaXQgaW50bwp5b3VyIGJy
b3dzZXIsIG9yIGV2ZW4gcGFzdGUgdGhlIHVybCBvbiBhIGNvbW1hbmQgbGluZSBhcyBhbiBh
cmd1bWVudCB0bwp5b3VyIGJyb3dzZXIuCgpTdXBwb3NlIHlvdSB3YW50IHRvIHN0YXJ0IGx5
bnggYW5kIGdvIHRvIHRoZSBTcGVha3VwIHNpdGUuCgpZb3UgY2FuIHN3aXRjaCB0byBhIGRp
ZmZlcmVudCBjb25zb2xlIHdpdGggdGhlIGFsdCBsZWZ0IGFuZCByaWdodAphcnJvd3MsIG9y
IHlvdSBjYW4gc3dpdGNoIHRvIGEgc3BlY2lmaWMgY29uc29sZSBieSB0eXBpbmcgYWx0IGFu
ZCBhCmZ1bmN0aW9uIGtleS4gIFRoZXNlIGFyZSBub3QgU3BlYWt1cCBjb21tYW5kcywganVz
dCBzdGFuZGFyZCBMaW51eApjb25zb2xlIGNhcGFiaWxpdGllcy4KCk9uY2UgeW91J3ZlIGNo
YW5nZWQgdG8gYW4gYXBwcm9wcmlhdGUgY29uc29sZSwgYW5kIGFyZSBhdCBhIHNoZWxsIHBy
b21wdCwKdHlwZSB0aGUgd29yZCBseW54LCBmb2xsb3dlZCBieSBhIHNwYWNlLiAgTm93IHBy
ZXNzIGFuZCBob2xkIHRoZSBzcGVha3VwCmtleSwgd2hpbGUgeW91IHR5cGUgdGhlIGtleXBh
ZCBzbGFzaCBjaGFyYWN0ZXIuICBUaGUgdXJsIHdpbGwgYmUgcGFzdGVkCm9udG8gdGhlIGNv
bW1hbmQgbGluZSwganVzdCBhcyB0aG91Z2ggeW91IGhhZCB0eXBlZCBpdCBpbi4gIFByZXNz
IHRoZQplbnRlciBrZXkgdG8gZXhlY3V0ZSB0aGUgY29tbWFuZC4KClRoZSBwYXN0ZSBidWZm
ZXIgd2lsbCBjb250aW51ZSB0byBob2xkIHRoZSBjdXQgaW5mb3JtYXRpb24sIHVudGlsIGEg
bmV3Cm1hcmsgYW5kIGN1dCBvcGVyYXRpb24gaXMgY2FycmllZCBvdXQuICBUaGlzIG1lYW5z
IHlvdSBjYW4gcGFzdGUgdGhlIGN1dAppbmZvcm1hdGlvbiBhcyBtYW55IHRpbWVzIGFzIHlv
dSBsaWtlIGJlZm9yZSBkb2luZyBhbm90aGVyIGN1dApvcGVyYXRpb24uCgpZb3UgYXJlIG5v
dCBsaW1pdGVkIHRvIGN1dHRpbmcgYW5kIHBhc3Rpbmcgb25seSBvbmUgbGluZSBvbiB0aGUg
c2NyZWVuLgpZb3UgY2FuIGFsc28gY3V0IGFuZCBwYXN0ZSByZWN0YW5ndWxhciByZWdpb25z
IG9mIHRoZSBzY3JlZW4uICBKdXN0CnBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNvciBhdCB0
aGUgdG9wIGxlZnQgY29ybmVyIG9mIHRoZSB0ZXh0IHRvIGJlCmN1dCwgbWFyayBpdCB3aXRo
IHRoZSBrZXlwYWQgc2xhc2gga2V5LCB0aGVuIHBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNv
cgphdCB0aGUgYm90dG9tIHJpZ2h0IGNvcm5lciBvZiB0aGUgcmVnaW9uIHRvIGJlIGN1dCwg
YW5kIGN1dCBpdCB3aXRoIHRoZQprZXlwYWQgc2xhc2gga2V5LgoKMTIuICBDaGFuZ2luZyB0
aGUgUHJvbnVuY2lhdGlvbiBvZiBDaGFyYWN0ZXJzCgpUaHJvdWdoIHRoZSAvc3BlYWt1cC9p
MThuL2NoYXJhY3RlcnMgc3lzIGVudHJ5LCBTcGVha3VwIGdpdmVzIHlvdSB0aGUKYWJpbGl0
eSB0byBjaGFuZ2UgaG93IFNwZWFrdXAgcHJvbm91bmNlcyBhIGdpdmVuIGNoYXJhY3Rlci4g
IFlvdSBjb3VsZCwKZm9yIGV4YW1wbGUsIGNoYW5nZSBob3cgc29tZSBwdW5jdHVhdGlvbiBj
aGFyYWN0ZXJzIGFyZSBzcG9rZW4uICBZb3UgY2FuCmV2ZW4gY2hhbmdlIGhvdyBTcGVha3Vw
IHdpbGwgcHJvbm91bmNlIGNlcnRhaW4gbGV0dGVycy4KCllvdSBtYXksIGZvciBleGFtcGxl
LCB3aXNoIHRvIGNoYW5nZSBob3cgU3BlYWt1cCBwcm9ub3VuY2VzIHRoZSB6CmNoYXJhY3Rl
ci4gIFRoZSBhdXRob3Igb2YgU3BlYWt1cCwgS2lyayBSZWlzZXIsIGlzIENhbmFkaWFuLCBh
bmQgdGh1cwpiZWxpZXZlcyB0aGF0IHRoZSB6IHNob3VsZCBiZSBwcm9ub3VuY2VkIHplZC4g
IElmIHlvdSBhcmUgYW4gQW1lcmljYW4sCnlvdSBtaWdodCB3aXNoIHRvIHVzZSB0aGUgemVl
IHByb251bmNpYXRpb24gaW5zdGVhZCBvZiB6ZWQuICBZb3UgY2FuCmNoYW5nZSB0aGUgcHJv
bnVuY2lhdGlvbiBvZiBib3RoIHRoZSB1cHBlciBhbmQgbG93ZXIgY2FzZSB6IHdpdGggdGhl
CmZvbGxvd2luZyB0d28gY29tbWFuZHM6CgplY2hvIDkwIHplZSA+L3NwZWFrdXAvY2hhcmFj
dGVycwplY2hvIDEyMiB6ZWUgPi9zcGVha3VwL2NoYXJhY3RlcnMKCkxldCdzIGV4YW1pbmUg
dGhlIHBhcnRzIG9mIHRoZSB0d28gcHJldmlvdXMgY29tbWFuZHMuICBUaGV5IGFyZSBpc3N1
ZWQKYXQgdGhlIHNoZWxsIHByb21wdCwgYW5kIGNvdWxkIGJlIHBsYWNlZCBpbiBhIHN0YXJ0
dXAgc2NyaXB0LgoKVGhlIHdvcmQgZWNobyB0ZWxscyB0aGUgc2hlbGwgdGhhdCB5b3Ugd2Fu
dCB0byBoYXZlIGl0IGRpc3BsYXkgdGhlCnN0cmluZyBvZiBjaGFyYWN0ZXJzIHRoYXQgZm9s
bG93IHRoZSB3b3JkIGVjaG8uICBJZiB5b3Ugd2VyZSB0byBqdXN0CnR5cGU6CgplY2hvIGhl
bGxvLgoKWW91IHdvdWxkIGdldCB0aGUgd29yZCBoZWxsbyBwcmludGVkIG9uIHlvdXIgc2Ny
ZWVuIGFzIHNvb24gYXMgeW91CnByZXNzZWQgdGhlIGVudGVyIGtleS4gIEluIHRoaXMgY2Fz
ZSwgd2UgYXJlIGVjaG9pbmcgc3RyaW5ncyB0aGF0IHdlCndhbnQgdG8gYmUgcmVkaXJlY3Rl
ZCBpbnRvIHRoZSBzeXMgc3lzdGVtLgoKVGhlIG51bWJlcnMgOTAgYW5kIDEyMiBpbiB0aGUg
YWJvdmUgZWNobyBjb21tYW5kcyBhcmUgdGhlIGFzY2lpIG51bWVyaWMKdmFsdWVzIGZvciB0
aGUgdXBwZXIgYW5kIGxvd2VyIGNhc2UgeiwgdGhlIGNoYXJhY3RlcnMgd2Ugd2lzaCB0byBj
aGFuZ2UuCgpUaGUgc3RyaW5nIHplZSBpcyB0aGUgcHJvbnVuY2lhdGlvbiB0aGF0IHdlIHdh
bnQgU3BlYWt1cCB0byB1c2UgZm9yIHRoZQp1cHBlciBhbmQgbG93ZXIgY2FzZSB6LgoKVGhl
ID4gc3ltYm9sIHJlZGlyZWN0cyB0aGUgb3V0cHV0IG9mIHRoZSBlY2hvIGNvbW1hbmQgdG8g
YSBmaWxlLCBqdXN0Cmxpa2UgaW4gRE9TLCBvciBhdCB0aGUgV2luZG93cyBjb21tYW5kIHBy
b21wdC4KCkFuZCBmaW5hbGx5LCAvc3BlYWt1cC9pMThuL2NoYXJhY3RlcnMgaXMgdGhlIGZp
bGUgZW50cnkgaW4gdGhlIHN5cyBzeXN0ZW0Kd2hlcmUgd2Ugd2FudCB0aGUgb3V0cHV0IHRv
IGJlIGRpcmVjdGVkLiAgU3BlYWt1cCBsb29rcyBhdCB0aGUgbnVtZXJpYwp2YWx1ZSBvZiB0
aGUgY2hhcmFjdGVyIHdlIHdhbnQgdG8gY2hhbmdlLCBhbmQgaW5zZXJ0cyB0aGUgcHJvbnVu
Y2lhdGlvbgpzdHJpbmcgaW50byBhbiBpbnRlcm5hbCB0YWJsZS4KCllvdSBjYW4gbG9vayBh
dCB0aGUgd2hvbGUgdGFibGUgd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6CgpjYXQgL3Nw
ZWFrdXAvaTE4bi9jaGFyYWN0ZXJzCgpTcGVha3VwIHdpbGwgdGhlbiBwcmludCBvdXQgdGhl
IGVudGlyZSBjaGFyYWN0ZXIgcHJvbnVuY2lhdGlvbiB0YWJsZS4gIEkKd29uJ3QgZGlzcGxh
eSBpdCBoZXJlLCBidXQgbGVhdmUgeW91IHRvIGxvb2sgYXQgaXQgYXQgeW91ciBjb252ZW5p
ZW5jZS4KCjEzLiAgTWFwcGluZyBLZXlzCgpTcGVha3VwIGhhcyB0aGUgY2FwYWJpbGl0eSBv
ZiBhbGxvd2luZyB5b3UgdG8gYXNzaWduIG9yICJtYXAiIGtleXMgdG8KaW50ZXJuYWwgU3Bl
YWt1cCBjb21tYW5kcy4gIFRoaXMgc2VjdGlvbiBuZWNlc3NhcmlseSBhc3N1bWVzIHlvdSBo
YXZlIGEKTGludXgga2VybmVsIHNvdXJjZSB0cmVlIGluc3RhbGxlZCwgYW5kIHRoYXQgaXQg
aGFzIGJlZW4gcGF0Y2hlZCBhbmQKY29uZmlndXJlZCB3aXRoIFNwZWFrdXAuICBIb3cgeW91
IGRvIHRoaXMgaXMgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzCm1hbnVhbC4gIEZvciB0aGlz
IGluZm9ybWF0aW9uLCB2aXNpdCB0aGUgU3BlYWt1cCB3ZWIgc2l0ZSBhdApodHRwOi8vbGlu
dXgtc3BlYWt1cC5vcmcvLiAgVGhlIHJlYXNvbiB5b3UnbGwgbmVlZCB0aGUga2VybmVsIHNv
dXJjZQp0cmVlIHBhdGNoZWQgd2l0aCBTcGVha3VwIGlzIHRoYXQgdGhlIGdlbm1hcCB1dGls
aXR5IHlvdSdsbCBuZWVkIGZvcgpwcm9jZXNzaW5nIGtleW1hcHMgaXMgaW4gdGhlCi91c3Iv
c3JjL2xpbnV4LTx2ZXJzaW9uX251bWJlcj4vZHJpdmVycy9jaGFyL3NwZWFrdXAgZGlyZWN0
b3J5LiAgVGhlCjx2ZXJzaW9uX251bWJlcj4gaW4gdGhlIGFib3ZlIGRpcmVjdG9yeSBwYXRo
IGlzIHRoZSB2ZXJzaW9uIG51bWJlciBvZgp0aGUgTGludXggc291cmNlIHRyZWUgeW91IGFy
ZSB3b3JraW5nIHdpdGguCgpTbyBvaywgeW91J3ZlIGdvbmUgb2ZmIGFuZCBnb3R0ZW4geW91
ciBrZXJuZWwgc291cmNlIHRyZWUsIGFuZCBwYXRjaGVkCmFuZCBjb25maWd1cmVkIGl0LiAg
Tm93IHlvdSBjYW4gc3RhcnQgbWFuaXB1bGF0aW5nIGtleW1hcHMuCgpZb3UgY2FuIGVpdGhl
ciB1c2UgdGhlCi91c3Ivc3JjL2xpbnV4LTx2ZXJzaW9uX251bWJlcj4vZHJpdmVycy9jaGFy
L3NwZWFrdXAvc3BlYWt1cG1hcC5tYXAgZmlsZQppbmNsdWRlZCB3aXRoIHRoZSBTcGVha3Vw
IHNvdXJjZSwgb3IgeW91IGNhbiBjdXQgYW5kIHBhc3RlIHRoZSBjb3B5IGluCnNlY3Rpb24g
NCBpbnRvIGEgc2VwYXJhdGUgZmlsZS4gIElmIHlvdSB1c2UgdGhlIG9uZSBpbiB0aGUgU3Bl
YWt1cApzb3VyY2UgdHJlZSwgbWFrZSBzdXJlIHlvdSBtYWtlIGEgYmFja3VwIG9mIGl0IGJl
Zm9yZSB5b3Ugc3RhcnQgbWFraW5nCmNoYW5nZXMuICBZb3UgaGF2ZSBiZWVuIHdhcm5lZCEK
ClN1cHBvc2UgdGhhdCB5b3Ugd2FudCB0byBzd2FwIHRoZSBrZXkgYXNzaWdubWVudHMgZm9y
IHRoZSBTcGVha3VwCnNheV9sYXN0X2NoYXIgYW5kIHRoZSBTcGVha3VwIHNheV9maXJzdF9j
aGFyIGNvbW1hbmRzLiAgVGhlCnNwZWFrdXBtYXAubWFwIGxpc3RzIHRoZSBrZXkgbWFwcGlu
Z3MgZm9yIHRoZXNlIHR3byBjb21tYW5kcyBhcyBmb2xsb3dzOgoKc3BrIGtleV9wYWdldXAg
PSBzYXlfZmlyc3RfY2hhcgpzcGsga2V5X3BhZ2Vkb3duID0gc2F5X2xhc3RfY2hhcgoKWW91
IGNhbiBlZGl0IHlvdXIgY29weSBvZiB0aGUgc3BlYWt1cG1hcC5tYXAgZmlsZSBhbmQgc3dh
cCB0aGUgY29tbWFuZApuYW1lcyBvbiB0aGUgcmlnaHQgc2lkZSBvZiB0aGUgPSAoZXF1YWxz
KSBzaWduLiAgWW91IGRpZCBtYWtlIGEgYmFja3VwLApyaWdodD8gIFRoZSBuZXcga2V5bWFw
IGxpbmVzIHdvdWxkIGxvb2sgbGlrZSB0aGlzOgoKc3BrIGtleV9wYWdldXAgPSBzYXlfbGFz
dF9jaGFyCnNwayBrZXlfcGFnZWRvd24gPSBzYXlfZmlyc3RfY2hhcgoKQWZ0ZXIgeW91IGVk
aXQgeW91ciBjb3B5IG9mIHRoZSBzcGVha3VwbWFwLm1hcCBmaWxlLCBzYXZlIGl0IHVuZGVy
IGEgbmV3CmZpbGUgbmFtZSwgcGVyaGFwcyBuZXdtYXAubWFwLiAgVGhlbiBleGl0IHlvdXIg
ZWRpdG9yIGFuZCByZXR1cm4gdG8gdGhlCnNoZWxsIHByb21wdC4KCllvdSBhcmUgbm93IHJl
YWR5IHRvIGxvYWQgeW91ciBrZXltYXAgd2l0aCB5b3VyIHN3YXBwZWQga2V5IGFzc2lnbm1l
bnRzLgogQXNzdW1pbmcgdGhhdCB5b3Ugc2F2ZWQgeW91ciBuZXcga2V5bWFwIGFzIHRoZSBm
aWxlIG5ld21hcC5tYXAsIHlvdQp3b3VsZCBsb2FkIHlvdXIga2V5bWFwIGludG8gdGhlIHN5
cyBzeXN0ZW0gbGlrZSB0aGlzOgoKL3Vzci9zcmMvbGludXgtPHZlcnNpb25fbnVtYmVyPi9k
cml2ZXJzL2NoYXIvc3BlYWt1cC9nZW5tYXAgbmV3bWFwLm1hcAo+L3NwZWFrdXAva2V5bWFw
CgpSZW1lbWJlciB0byBzdWJzdGl0dXRlIHlvdXIga2VybmVsIHZlcnNpb24gbnVtYmVyIGZv
ciB0aGUKPHZlcnNpb25fbnVtYmVyPiBpbiB0aGUgYWJvdmUgY29tbWFuZC4gIEFsc28gbm90
ZSB0aGF0IGFsdGhvdWdoIHRoZQphYm92ZSBjb21tYW5kIHdyYXBwZWQgb250byB0d28gbGlu
ZXMgaW4gdGhpcyBkb2N1bWVudCwgeW91IHNob3VsZCB0eXBlCml0IGFsbCBvbiBvbmUgbGlu
ZS4KCllvdXIgc2F5IGZpcnN0IGFuZCBzYXkgbGFzdCBjaGFyYWN0ZXJzIHNob3VsZCBub3cg
YmUgc3dhcHBlZC4gIFByZXNzaW5nCnNwZWFrdXAgcGFnZWRvd24gc2hvdWxkIHJlYWQgeW91
IHRoZSBmaXJzdCBub24td2hpdGVzcGFjZSBjaGFyYWN0ZXIgb24KdGhlIGxpbmUgeW91ciBy
ZWFkaW5nIGN1cnNvciBpcyBpbiwgYW5kIHByZXNzaW5nIHNwZWFrdXAgcGFnZXVwIHNob3Vs
ZApyZWFkIHlvdSB0aGUgbGFzdCBjaGFyYWN0ZXIgb24gdGhlIGxpbmUgeW91ciByZWFkaW5n
IGN1cnNvciBpcyBpbi4KCllvdSBzaG91bGQgbm90ZSB0aGF0IHRoZXNlIG5ldyBtYXBwaW5n
cyB3aWxsIG9ubHkgc3RheSBpbiBlZmZlY3QgdW50aWwKeW91IHJlYm9vdCwgb3IgdW50aWwg
eW91IGxvYWQgYW5vdGhlciBrZXltYXAuCgpPbmUgZmluYWwgd2FybmluZy4gIElmIHlvdSB0
cnkgdG8gbG9hZCBhIHBhcnRpYWwgbWFwLCB5b3Ugd2lsbCBxdWlja2x5CmZpbmQgdGhhdCBh
bGwgdGhlIG1hcHBpbmdzIHlvdSBkaWRuJ3QgaW5jbHVkZSBpbiB5b3VyIGZpbGUgZ290IGRl
bGV0ZWQKZnJvbSB0aGUgd29ya2luZyBtYXAuICBCZSBleHRyZW1lbHkgY2FyZWZ1bCwgYW5k
IGFsd2F5cyBtYWtlIGEgYmFja3VwIQpZb3UgaGF2ZSBiZWVuIHdhcm5lZCEKCjE0LiAgSW50
ZXJuYXRpb25hbGl6aW5nIFNwZWFrdXAKClNwZWFrdXAgaW5kaWNhdGVzIHZhcmlvdXMgY29u
ZGl0aW9ucyB0byB0aGUgdXNlciBieSBzcGVha2luZyBtZXNzYWdlcy4KRm9yIGluc3RhbmNl
LCB3aGVuIHlvdSBtb3ZlIHRvIHRoZSBsZWZ0IGVkZ2Ugb2YgdGhlIHNjcmVlbiB3aXRoIHRo
ZQpyZXZpZXcga2V5cywgU3BlYWt1cCBzYXlzLCAibGVmdC4iClByaW9yIHRvIHZlcnNpb24g
My4xLjAgb2YgU3BlYWt1cCwgYWxsIG9mIHRoZXNlIG1lc3NhZ2VzIHdlcmUgaW4gRW5nbGlz
aCwKYW5kIHRoZXkgY291bGQgbm90IGJlIGNoYW5nZWQuICBJZiB5b3UgdXNlZCBhIG5vbi1F
bmdsaXNoIHN5bnRoZXNpemVyLAp5b3Ugc3RpbGwgaGVhcmQgRW5nbGlzaCBtZXNzYWdlcywg
c3VjaCBhcyAibGVmdCIgYW5kICJjdXJzb3Jpbmcgb24uIgpJbiB2ZXJzaW9uIDMuMS4wIG9y
IGhpZ2hlciwgb25lIG1heSBsb2FkIHRyYW5zbGF0aW9ucyBmb3IgdGhlIHZhcmlvdXMKbWVz
c2FnZXMgdmlhIHRoZSAvc3lzIGZpbGVzeXN0ZW0uCgpUaGUgZGlyZWN0b3J5IC9zcGVha3Vw
L2kxOG4gY29udGFpbnMgc2V2ZXJhbCBjb2xsZWN0aW9ucyBvZiBtZXNzYWdlcy4KRWFjaCBn
cm91cCBvZiBtZXNzYWdlcyBpcyBzdG9yZWQgaW4gaXRzIG93biBmaWxlLgpUaGUgZm9sbG93
aW5nIHNlY3Rpb24gbGlzdHMgYWxsIG9mIHRoZXNlIGZpbGVzLCBhbG9uZyB3aXRoIGEgYnJp
ZWYgZGVzY3JpcHRpb24Kb2YgZWFjaC4KCjE0LjEuICBGaWxlcyBVbmRlciB0aGUgaTE4biBT
dWJkaXJlY3RvcnkKCiogYW5ub3VuY2VtZW50czoKVGhpcyBmaWxlIGNvbnRhaW5zIHZhcmlv
dXMgZ2VuZXJhbCBhbm5vdW5jZW1lbnRzLCBtb3N0IG9mIHdoaWNoIGNhbm5vdApiZSBjYXRl
Z29yaXplZC4gIFlvdSB3aWxsIGZpbmQgbWVzc2FnZXMgc3VjaCBhcyAiWW91IGtpbGxlZCBT
cGVha3VwIiwKIkknbSBhbGl2ZSIsICJsZWF2aW5nIGhlbHAiLCAicGFya2VkIiwgInVucGFy
a2VkIiwgYW5kIG90aGVycy4KWW91IHdpbGwgYWxzbyBmaW5kIHRoZSBuYW1lcyBvZiB0aGUg
c2NyZWVuIGVkZ2VzIGFuZCBjdXJzb3IgdHJhY2tpbmcgbW9kZXMKaGVyZS4KCiogY2hhcmFj
dGVyczoKU2VlIHNlY3Rpb24gMTIgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhpcyBmaWxlLgoK
KiBjaGFydGFiOgpTZWUgc2VjdGlvbiAxMi4gIFVubGlrZSB0aGUgcmVzdCBvZiB0aGUgZmls
ZXMgaW4gdGhlIGkxOG4gc3ViZGlyZWN0b3J5LAp0aGlzIG9uZSBkb2VzIG5vdCBjb250YWlu
IG1lc3NhZ2VzIHRvIGJlIHNwb2tlbi4KCiogY29sb3JzOgpXaGVuIHlvdSB1c2UgdGhlICJz
YXkgYXR0cmlidXRlcyIgZnVuY3Rpb24sIFNwZWFrdXAgc2F5cyB0aGUgbmFtZSBvZiB0aGUK
Zm9yZWdyb3VuZCBhbmQgYmFja2dyb3VuZCBjb2xvcnMuICBUaGVzZSBuYW1lcyBjb21lIGZy
b20gdGhlIGkxOG4vY29sb3JzCmZpbGUuCgoqIGN0bF9rZXlzOgpIZXJlLCB5b3Ugd2lsbCBm
aW5kIG5hbWVzIG9mIGNvbnRyb2wga2V5cy4gIFRoZXNlIGFyZSB1c2VkIHdpdGggU3BlYWt1
cCdzCnNheV9jb250cm9sIGZlYXR1cmUuCgoqIGZvcm1hdHRlZDoKVGhpcyBncm91cCBvZiBt
ZXNzYWdlcyBjb250YWlucyBlbWJlZGRlZCBmb3JtYXR0aW5nIGNvZGVzLCB0byBzcGVjaWZ5
CnRoZSB0eXBlIGFuZCB3aWR0aCBvZiBkaXNwbGF5ZWQgZGF0YS4gIElmIHlvdSBjaGFuZ2Ug
dGhlc2UsIHlvdSBtdXN0CnByZXNlcnZlIGFsbCBvZiB0aGUgZm9ybWF0dGluZyBjb2Rlcywg
YW5kIHRoZXkgbXVzdCBhcHBlYXIgaW4gdGhlIG9yZGVyCnVzZWQgYnkgdGhlIGRlZmF1bHQg
bWVzc2FnZXMuCgoqIGZ1bmN0aW9uX25hbWVzOgpIZXJlLCB5b3Ugd2lsbCBmaW5kIGEgbGlz
dCBvZiBuYW1lcyBmb3IgU3BlYWt1cCBmdW5jdGlvbnMuICBUaGVzZSBhcmUgdXNlZApieSB0
aGUgaGVscCBzeXN0ZW0uICBGb3IgZXhhbXBsZSwgc3VwcG9zZSB0aGF0IHlvdSBoYXZlIGFj
dGl2YXRlZCBoZWxwIG1vZGUsCmFuZCB5b3UgcHJlc3NlZCBrZXlwYWQgMy4gIFNwZWFrdXAg
c2F5czoKImtleXBhZCAzIGlzIGNoYXJhY3Rlciwgc2F5IG5leHQuIgpUaGUgbWVzc2FnZSAi
Y2hhcmFjdGVyLCBzYXkgbmV4dCIgbmFtZXMgYSBTcGVha3VwIGZ1bmN0aW9uLCBhbmQgaXQK
Y29tZXMgZnJvbSB0aGlzIGZ1bmN0aW9uX25hbWVzIGZpbGUuCgoqIGtleV9uYW1lczoKQWdh
aW4sIGtleV9uYW1lcyBpcyB1c2VkIGJ5IFNwZWFrdXAncyBoZWxwIHN5c3RlbS4gIEluIHRo
ZSBwcmV2aW91cwpleGFtcGxlLCBTcGVha3VwIHNhaWQgdGhhdCB5b3UgcHJlc3NlZCAia2V5
cGFkIDMuIgpUaGlzIG5hbWUgY2FtZSBmcm9tIHRoZSBrZXlfbmFtZXMgZmlsZS4KCiogc3Rh
dGVzOgpUaGlzIGZpbGUgY29udGFpbnMgbmFtZXMgZm9yIGtleSBzdGF0ZXMuCkFnYWluLCB0
aGVzZSBhcmUgcGFydCBvZiB0aGUgaGVscCBzeXN0ZW0uICBGb3IgaW5zdGFuY2UsIGlmIHlv
dSBoYWQgcHJlc3NlZApzcGVha3VwICsga2V5cGFkIDMsIHlvdSB3b3VsZCBoZWFyOgoic3Bl
YWt1cCBrZXlwYWQgMyBpcyBnbyB0byBib3R0b20gZWRnZS4iClRoZSBzcGVha3VwIGtleSBp
cyBkZXByZXNzZWQsIHNvIHRoZSBuYW1lIG9mIHRoZSBrZXkgc3RhdGUgaXMgc3BlYWt1cC4K
VGhpcyBwYXJ0IG9mIHRoZSBtZXNzYWdlIGNvbWVzIGZyb20gdGhlIHN0YXRlcyBjb2xsZWN0
aW9uLgoKMTQuMi4gIENoYW5naW5nIGxhbmd1YWdlCgoxNC4yLjEuIExvYWRpbmcgWW91ciBP
d24gTWVzc2FnZXMKClRoZSBmaWxlcyB1bmRlciB0aGUgaTE4biBzdWJkaXJlY3RvcnkgYWxs
IGZvbGxvdyB0aGUgc2FtZSBmb3JtYXQuClRoZXkgY29uc2lzdCBvZiBsaW5lcywgd2l0aCBv
bmUgbWVzc2FnZSBwZXIgbGluZS4KRWFjaCBtZXNzYWdlIGlzIHJlcHJlc2VudGVkIGJ5IGEg
bnVtYmVyLCBmb2xsb3dlZCBieSB0aGUgdGV4dCBvZiB0aGUgbWVzc2FnZS4KVGhlIG51bWJl
ciBpcyB0aGUgcG9zaXRpb24gb2YgdGhlIG1lc3NhZ2UgaW4gdGhlIGdpdmVuIGNvbGxlY3Rp
b24uCkZvciBleGFtcGxlLCBpZiB5b3UgdmlldyB0aGUgZmlsZSAvc3BlYWt1cC9pMThuL2Nv
bG9ycywgeW91IHdpbGwgc2VlIHRoZQpmb2xsb3dpbmcgbGlzdDoKCjAJYmxhY2sKMQlibHVl
CjIJZ3JlZW4KMwljeWFuCjQJcmVkCjUJbWFnZW50YQo2CXllbGxvdwo3CXdoaXRlCjgJZ3Jl
eQoKWW91IGNhbiBjaGFuZ2Ugb25lIG1lc3NhZ2UsIG9yIHlvdSBjYW4gY2hhbmdlIGEgd2hv
bGUgZ3JvdXAuClRvIGxvYWQgYSB3aG9sZSBjb2xsZWN0aW9uIG9mIG1lc3NhZ2VzIGZyb20g
YSBuZXcgc291cmNlLCBzaW1wbHkgdXNlCnRoZSBjcCBjb21tYW5kOgpjcCB+L215X2NvbG9y
cyAvc3BlYWt1cC9pMThuL2NvbG9ycwpZb3UgY2FuIGNoYW5nZSBhbiBpbmRpdmlkdWFsIG1l
c3NhZ2Ugd2l0aCB0aGUgZWNobyBjb21tYW5kLAphcyBzaG93biBpbiB0aGUgZm9sbG93aW5n
IGV4YW1wbGUuCgpUaGUgU3BhbmlzaCBuYW1lIGZvciB0aGUgY29sb3IgYmx1ZSBpcyBhenVs
LgpMb29raW5nIGF0IHRoZSBjb2xvcnMgZmlsZSwgd2Ugc2VlIHRoYXQgdGhlIG5hbWUgImJs
dWUiIGlzIGF0IHBvc2l0aW9uIDEKd2l0aGluIHRoZSBjb2xvcnMgZ3JvdXAuICBMZXQncyBj
aGFuZ2UgYmx1ZSB0byBhenVsOgplY2hvICcxIGF6dWwnID4gL3NwZWFrdXAvaTE4bi9jb2xv
cnMKVGhlIG5leHQgdGltZSB0aGF0IFNwZWFrdXAgc2F5cyBtZXNzYWdlIDEgZnJvbSB0aGUg
Y29sb3JzIGdyb3VwLCBpdCB3aWxsCnNheSAiYXp1bCIsIHJhdGhlciB0aGFuICJibHVlLiIK
CjE0LjIuMi4gQ2hvb3NlIGEgbGFuZ3VhZ2UKCkluIHRoZSBmdXR1cmUsIHRyYW5zbGF0aW9u
cyBpbnRvIHZhcmlvdXMgbGFuZ3VhZ2VzIHdpbGwgYmUgbWFkZSBhdmFpbGFibGUsCmFuZCBt
b3N0IHVzZXJzIHdpbGwganVzdCBsb2FkIHRoZSBmaWxlcyBuZWNlc3NhcnkgZm9yIHRoZWly
IGxhbmd1YWdlLiBTbyBmYXIsCm9ubHkgRnJlbmNoIGxhbmd1YWdlIGlzIGF2YWlsYWJsZSBi
ZXlvbmQgbmF0aXZlIENhbmFkaWFuIEVuZ2xpc2ggbGFuZ3VhZ2UuCgpGcmVuY2ggaXMgb25s
eSBhdmFpbGFibGUgYWZ0ZXIgeW91IGFyZSBsb2dnZWQgaW4uCgpDYW5hZGlhbiBFbmdsaXNo
IGlzIHRoZSBkZWZhdWx0IGxhbmd1YWdlLiBUbyB0b2dnbGUgYW5vdGhlciBsYW5ndWFnZSwK
ZG93bmxvYWQgdGhlIHNvdXJjZSBvZiBTcGVha3VwIGFuZCB1bnRhciBpdCBpbiB5b3VyIGhv
bWUgZGlyZWN0b3J5LiBUaGUKZm9sbG93aW5nIGNvbW1hbmQgc2hvdWxkIGxldCB5b3UgZG8g
dGhpczoKCnRhciB4dmpmIHNwZWFrdXAtPHZlcnNpb24+LnRhci5iejIKCndoZXJlIDx2ZXJz
aW9uPiBpcyB0aGUgdmVyc2lvbiBudW1iZXIgb2YgdGhlIGFwcGxpY2F0aW9uLgoKTmV4dCwg
Y2hhbmdlIHRvIHRoZSBuZXdseSBjcmVhdGVkIGRpcmVjdG9yeSwgdGhlbiBpbnRvIHRoZSB0
b29scy8gZGlyZWN0b3J5LCBhbmQKcnVuIHRoZSBzY3JpcHQgc3BlYWt1cF9zZXRsb2NhbGUu
IFlvdSBhcmUgYXNrZWQgdGhlIGxhbmd1YWdlIHRoYXQgeW91IHdhbnQgdG8KdXNlLiBUeXBl
IHRoZSBudW1iZXIgYXNzb2NpYXRlZCB0byB5b3VyIGxhbmd1YWdlIChlLmcuIGZyIGZvciBG
cmVuY2gpIHRoZW4gcHJlc3MKRW50ZXIuIE5lZWRlZCBmaWxlcyBhcmUgY29waWVkIGluIHRo
ZSBpMThuIGRpcmVjdG9yeS4KCk5vdGU6IHRoZSBzcGVha3VwY29uZiBtdXN0IGJlIGluc3Rh
bGxlZCBvbiB5b3VyIHN5c3RlbSBzbyB0aGF0IHNldHRpbmdzIGFyZSBzYXZlZC4KT3RoZXJ3
aXNlLCB5b3Ugd2lsbCBoYXZlIGFuIGVycm9yOiB5b3VyIGxhbmd1YWdlIHdpbGwgYmUgbG9h
ZGVkIGJ1dCB5b3Ugd2lsbApoYXZlIHRvIHJ1biB0aGUgc2NyaXB0IGFnYWluIGV2ZXJ5IHRp
bWUgU3BlYWt1cCByZXN0YXJ0cy4KU2VlIHNlY3Rpb24gMTYuMS4gZm9yIGluZm9ybWF0aW9u
IGFib3V0IHNwZWFrdXBjb25mLgoKWW91IHdpbGwgaGF2ZSB0byByZXBlYXQgdGhlc2Ugc3Rl
cHMgZm9yIGFueSBjaGFuZ2Ugb2YgbG9jYWxlLCBpLmUuIGlmIHlvdSB3aXNoCmNoYW5nZSB0
aGUgc3BlYWt1cCdzIGxhbmd1YWdlIG9yIGNoYXJzZXQgKGlzby04ODU5LTE1IG91IFVURi04
KS4KCklmIHlvdSB3aXNoIHN0b3JlIHRoZSBzZXR0aW5ncywgbm90ZSB0aGF0IGF0IHlvdXIg
bmV4dCBsb2dpbiwgeW91IHdpbGwgbmVlZCB0bwpkbzoKCnNwZWFrdXAgbG9hZAoKQWx0ZXJu
YXRpdmVseSwgeW91IGNhbiBhZGQgdGhlIGFib3ZlIGxpbmUgdG8geW91ciBmaWxlCn4vLmJh
c2hyYyBvciB+Ly5iYXNoX3Byb2ZpbGUuCgpJZiB5b3VyIHN5c3RlbSBhZG1pbmlzdHJhdG9y
IHJhbiBoaW1zZWxmIHRoZSBzY3JpcHQsIGFsbCB0aGUgdXNlcnMgd2lsbCBiZSBhYmxlCnRv
IGNoYW5nZSBmcm9tIEVuZ2xpc2ggdG8gdGhlIGxhbmd1YWdlIGNob29zZWQgYnkgcm9vdCBh
bmQgZG8gZGlyZWN0bHkKc3BlYWt1cGNvbmYgbG9hZCAob3IgYWRkIHRoaXMgdG8gdGhlIH4v
LmJhc2hyYyBvcgp+Ly5iYXNoX3Byb2ZpbGUgZmlsZSkuIElmIHRoZXJlIGFyZSBzZXZlcmFs
IGxhbmd1YWdlcyB0byBoYW5kbGUsIHRoZQphZG1pbmlzdHJhdG9yIChvciBldmVyeSB1c2Vy
KSB3aWxsIGhhdmUgdG8gcnVuIHRoZSBmaXJzdCBzdGVwcyB1bnRpbCBzcGVha3VwY29uZgpz
YXZlLCBjaG9vc2luZyB0aGUgYXBwcm9wcmlhdGUgbGFuZ3VhZ2UsIGluIGV2ZXJ5IHVzZXIn
cyBob21lIGRpcmVjdG9yeS4gRXZlcnkKdXNlciB3aWxsIHRoZW4gYmUgYWJsZSB0byBkbyBz
cGVha3VwY29uZiBsb2FkLCBTcGVha3VwIHdpbGwgbG9hZCBoaXMgb3duIHNldHRpbmdzLgoK
MTQuMy4gIE5vIFN1cHBvcnQgZm9yIE5vbi1XZXN0ZXJuLUV1cm9wZWFuIExhbmd1YWdlcwoK
QXMgb2YgdGhlIGN1cnJlbnQgcmVsZWFzZSwgU3BlYWt1cCBvbmx5IHN1cHBvcnRzIFdlc3Rl
cm4gRXVyb3BlYW4gbGFuZ3VhZ2VzLgpTdXBwb3J0IGZvciB0aGUgZXh0ZW5kZWQgY2hhcmFj
dGVycyB1c2VkIGJ5IGxhbmd1YWdlcyBvdXRzaWRlIG9mIHRoZSBXZXN0ZXJuCkV1cm9wZWFu
IGZhbWlseSBvZiBsYW5ndWFnZXMgaXMgYSB3b3JrIGluIHByb2dyZXNzLgoKMTUuICBVc2lu
ZyBTcGVha3VwJ3MgV2luZG93aW5nIENhcGFiaWxpdHkKClNwZWFrdXAgaGFzIHRoZSBjYXBh
YmlsaXR5IG9mIGRlZmluaW5nIGFuZCBtYW5pcHVsYXRpbmcgd2luZG93cyBvbiB0aGUKc2Ny
ZWVuLiAgU3BlYWt1cCB1c2VzIHRoZSB0ZXJtICJXaW5kb3ciLCB0byBtZWFuIGEgdXNlciBk
ZWZpbmVkIGFyZWEgb2YKdGhlIHNjcmVlbi4gIFRoZSBrZXkgc3Ryb2tlcyBmb3IgZGVmaW5p
bmcgYW5kIG1hbmlwdWxhdGluZyBTcGVha3VwCndpbmRvd3MgYXJlIGFzIGZvbGxvd3M6Cgpz
cGVha3VwICsgZjIgLS0gU2V0IHRoZSBib3VuZHMgb2YgdGhlIHdpbmRvdy4KU3BlYWt1cCAr
IGYzIC0tIGNsZWFyIHRoZSBjdXJyZW50IHdpbmRvdyBkZWZpbml0aW9uLgpzcGVha3VwICsg
ZjQgLS0gVG9nZ2xlIHdpbmRvdyBzaWxlbmNlIG9uIGFuZCBvZmYuCnNwZWFrdXAgKyBrZXlw
YWQgcGx1cyAtLSBTYXkgdGhlIGN1cnJlbnRseSBkZWZpbmVkIHdpbmRvdy4KClRoZXNlIGNh
cGFiaWxpdGllcyBhcmUgdXNlZnVsIGZvciB0cmFja2luZyBhIGNlcnRhaW4gcGFydCBvZiB0
aGUgc2NyZWVuCndpdGhvdXQgcmVyZWFkaW5nIHRoZSB3aG9sZSBzY3JlZW4sIG9yIGZvciBz
aWxlbmNpbmcgYSBwYXJ0IG9mIHRoZQpzY3JlZW4gdGhhdCBpcyBjb25zdGFudGx5IGNoYW5n
aW5nLCBzdWNoIGFzIGEgY2xvY2sgb3Igc3RhdHVzIGxpbmUuCgpUaGVyZSBpcyBubyB3YXkg
dG8gc2F2ZSB0aGVzZSB3aW5kb3cgc2V0dGluZ3MsIGFuZCB5b3UgY2FuIG9ubHkgaGF2ZSBv
bmUKd2luZG93IGRlZmluZWQgZm9yIGVhY2ggdmlydHVhbCBjb25zb2xlLiAgVGhlcmUgaXMg
YWxzbyBubyB3YXkgdG8gaGF2ZQp3aW5kb3dzIGF1dG9tYXRpY2FsbHkgZGVmaW5lZCBmb3Ig
c3BlY2lmaWMgYXBwbGljYXRpb25zLgoKSW4gb3JkZXIgdG8gZGVmaW5lIGEgd2luZG93LCB1
c2UgdGhlIHJldmlldyBrZXlzIHRvIG1vdmUgeW91ciByZWFkaW5nCmN1cnNvciB0byB0aGUg
YmVnaW5uaW5nIG9mIHRoZSBhcmVhIHlvdSB3YW50IHRvIGRlZmluZS4gIFRoZW4gcHJlc3MK
c3BlYWt1cCArIGYyLiAgU3BlYWt1cCB3aWxsIHRlbGwgeW91IHRoYXQgdGhlIHdpbmRvdyBz
dGFydHMgYXQgdGhlCmluZGljYXRlZCByb3cgYW5kIGNvbHVtbiBwb3NpdGlvbi4gIFRoZW4g
bW92ZSB0aGUgcmVhZGluZyBjdXJzb3IgdG8gdGhlCmVuZCBvZiB0aGUgYXJlYSB0byBiZSBk
ZWZpbmVkIGFzIGEgd2luZG93LCBhbmQgcHJlc3Mgc3BlYWt1cCArIGYyIGFnYWluLgogSWYg
dGhlcmUgaXMgbW9yZSB0aGFuIG9uZSBsaW5lIGluIHRoZSB3aW5kb3csIFNwZWFrdXAgd2ls
bCB0ZWxsIHlvdQp0aGF0IHRoZSB3aW5kb3cgZW5kcyBhdCB0aGUgaW5kaWNhdGVkIHJvdyBh
bmQgY29sdW1uIHBvc2l0aW9uLiAgSWYgdGhlcmUKaXMgb25seSBvbmUgbGluZSBpbiB0aGUg
d2luZG93LCB0aGVuIFNwZWFrdXAgd2lsbCB0ZWxsIHlvdSB0aGF0IHRoZQp3aW5kb3cgaXMg
dGhlIHNwZWNpZmllZCBsaW5lIG9uIHRoZSBzY3JlZW4uICBJZiB5b3UgYXJlIG9ubHkgZGVm
aW5pbmcgYQpvbmUgbGluZSB3aW5kb3csIHlvdSBjYW4ganVzdCBwcmVzcyBzcGVha3VwICsg
ZjIgdHdpY2UgYWZ0ZXIgcGxhY2luZyB0aGUKcmVhZGluZyBjdXJzb3Igb24gdGhlIGxpbmUg
eW91IHdhbnQgdG8gZGVmaW5lIGFzIGEgd2luZG93LiAgSXQgaXMgbm90Cm5lY2Vzc2FyeSB0
byBwb3NpdGlvbiB0aGUgcmVhZGluZyBjdXJzb3IgYXQgdGhlIGVuZCBvZiB0aGUgbGluZSBp
biBvcmRlcgp0byBkZWZpbmUgdGhlIHdob2xlIGxpbmUgYXMgYSB3aW5kb3cuCgoxNi4gIFRv
b2xzIGZvciBDb250cm9sbGluZyBTcGVha3VwCgpUaGUgc3BlYWt1cCBkaXN0cmlidXRpb24g
aW5jbHVkZXMgZXh0cmEgdG9vbHMgKGluIHRoZSB0b29scyBkaXJlY3RvcnkpCndoaWNoIHdl
cmUgd3JpdHRlbiB0byBtYWtlIHNwZWFrdXAgZWFzaWVyIHRvIHVzZS4gIFRoaXMgc2VjdGlv
biB3aWxsCmJyaWVmbHkgZGVzY3JpYmUgdGhlIHVzZSBvZiB0aGVzZSB0b29scy4KCjE2LjEu
ICBTcGVha3VwY29uZgoKc3BlYWt1cGNvbmYgYmVnYW4gbGlmZSBhcyBhIGNvbnRyaWJ1dGlv
biBmcm9tIFN0ZXZlIEhvbG1lcywgYSBtZW1iZXIgb2YKdGhlIHNwZWFrdXAgY29tbXVuaXR5
LiAgV2Ugd291bGQgbGlrZSB0byB0aGFuayBoaW0gZm9yIGhpcyB3b3JrIG9uIHRoZQplYXJs
eSB2ZXJzaW9ucyBvZiB0aGlzIHByb2plY3QuCgpUaGlzIHNjcmlwdCBtYXkgYmUgaW5zdGFs
bGVkIGFzIHBhcnQgb2YgeW91ciBsaW51eCBkaXN0cmlidXRpb24sIGJ1dCBpZgppdCBpc24n
dCwgdGhlIHJlY29tbWVuZGVkIHBsYWNlcyB0byBwdXQgaXQgYXJlIC91c3IvbG9jYWwvYmlu
IG9yCi91c3IvYmluLiAgVGhpcyBzY3JpcHQgY2FuIGJlIHJ1biBieSBhbnkgdXNlciwgc28g
aXQgZG9lcyBub3QgcmVxdWlyZQpyb290IHByaXZpbGVnZXMuCgpTcGVha3VwY29uZiBhbGxv
d3MgeW91IHRvIHNhdmUgYW5kIGxvYWQgeW91ciBTcGVha3VwIHNldHRpbmdzLiAgSXQgd29y
a3MKYnkgcmVhZGluZyBhbmQgd3JpdGluZyB0aGUgL3N5cyBmaWxlcyBkZXNjcmliZWQgYWJv
dmUuCgpUaGUgZGlyZWN0b3J5IHRoYXQgc3BlYWt1cGNvbmYgdXNlcyB0byBzdG9yZSB5b3Vy
IHNldHRpbmdzIGRlcGVuZHMgb24Kd2hldGhlciBpdCBpcyBydW4gZnJvbSB0aGUgcm9vdCBh
Y2NvdW50LiAgSWYgeW91IGV4ZWN1dGUgc3BlYWt1cGNvbmYgYXMKcm9vdCwgaXQgdXNlcyB0
aGUgZGlyZWN0b3J5IC9ldGMvc3BlYWt1cC4gIE90aGVyd2lzZSwgaXQgdXNlcyB0aGUgZGly
ZWN0b3J5Cn4vLnNwZWFrdXAsIHdoZXJlIH4gaXMgeW91ciBob21lIGRpcmVjdG9yeS4KQW55
b25lIHdobyBuZWVkcyB0byB1c2UgU3BlYWt1cCBmcm9tIHlvdXIgY29uc29sZSBjYW4gbG9h
ZCBoaXMgb3duIGN1c3RvbQpzZXR0aW5ncyB3aXRoIHRoaXMgc2NyaXB0LgoKc3BlYWt1cGNv
bmYgdGFrZXMgb25lIHJlcXVpcmVkIGFyZ3VtZW50OiBsb2FkIG9yIHNhdmUuClVzZSB0aGUg
Y29tbWFuZApzcGVha3VwY29uZiBzYXZlCnRvIHNhdmUgeW91ciBTcGVha3VwIHNldHRpbmdz
LCBhbmQKc3BlYWt1cGNvbmYgbG9hZAp0byBsb2FkIHRoZW0gaW50byBTcGVha3VwLgpBIHNl
Y29uZCBhcmd1bWVudCBtYXkgYmUgc3BlY2lmaWVkIHRvIHVzZSBhbiBhbHRlcm5hdGUgZGly
ZWN0b3J5IHRvCmxvYWQgb3Igc2F2ZSB0aGUgc3BlYWt1cCBwYXJhbWV0ZXJzLgoKMTYuMi4g
IFRhbGt3aXRoCgpDaGFybGVzIEhhbGxlbmJlY2ssIGFub3RoZXIgbWVtYmVyIG9mIHRoZSBz
cGVha3VwIGNvbW11bml0eSwgd3JvdGUgdGhlCmluaXRpYWwgdmVyc2lvbnMgb2YgdGhpcyBz
Y3JpcHQsIGFuZCB3ZSB3b3VsZCBhbHNvIGxpa2UgdG8gdGhhbmsgaGltIGZvcgpoaXMgd29y
ayBvbiBpdC4KClRoaXMgc2NyaXB0IG5lZWRzIHJvb3QgcHJpdmlsZWdlcyB0byBydW4sIHNv
IGlmIGl0IGlzIG5vdCBpbnN0YWxsZWQgYXMKcGFydCBvZiB5b3VyIGxpbnV4IGRpc3RyaWJ1
dGlvbiwgdGhlIHJlY29tbWVuZGVkIHBsYWNlcyB0byBpbnN0YWxsIGl0CmFyZSAvdXNyL2xv
Y2FsL3NiaW4gb3IgL3Vzci9zYmluLgoKVGFsa3dpdGggYWxsb3dzIHlvdSB0byBzd2l0Y2gg
c3ludGhlc2l6ZXJzIG9uIHRoZSBmbHkuICBJdCB0YWtlcyBhIHN5bnRoZXNpemVyCm5hbWUg
YXMgYW4gYXJndW1lbnQuICBGb3IgaW5zdGFuY2UsCnRhbGt3aXRoIGRlY3RsawpjYXVzZXMg
U3BlYWt1cCB0byB1c2UgdGhlIERlY1RhbGsgRXhwcmVzcy4gIElmIHlvdSB3aXNoIHRvIHN3
aXRjaCB0byBhCnNvZnR3YXJlIHN5bnRoZXNpemVyLCB5b3UgbXVzdCBhbHNvIGluZGljYXRl
IHdoaWNoIGRhZW1vbiB5b3Ugd2lzaCB0bwp1c2UuICBUaGVyZSBhcmUgdHdvIHBvc3NpYmxl
IGNob2ljZXM6CnNwZCBhbmQgZXNwZWFrdXAuICBzcGQgaXMgYW4gYWJicmV2aWF0aW9uIGZv
ciBzcGVlY2hkLXVwLgpJZiB5b3Ugd2lzaCB0byB1c2UgZXNwZWFrdXAgZm9yIHNvZnR3YXJl
IHN5bnRoZXNpcywgZ2l2ZSB0aGUgY29tbWFuZAp0YWxrd2l0aCBzb2Z0IGVzcGVha3VwClRv
IHVzZSBzcGVlY2hkLXVwLCB0eXBlOgp0YWxrd2l0aCBzb2Z0IHNwZApBbnkgYXJndW1lbnRz
IHRoYXQgZm9sbG93IHRoZSBuYW1lIG9mIHRoZSBkYWVtb24gYXJlIHBhc3NlZCB0byB0aGUg
ZGFlbW9uCndoZW4gaXQgaXMgaW52b2tlZC4gIEZvciBpbnN0YW5jZToKdGFsa3dpdGggZXNw
ZWFrdXAgLS1kZWZhdWx0LXZvaWNlPWZyCmNhdXNlcyBlc3BlYWt1cCB0byB1c2UgdGhlIEZy
ZW5jaCB2b2ljZS4KTm90ZSB0aGF0IHRhbGt3aXRoIG11c3QgYWx3YXlzIGJlIGV4ZWN1dGVk
IHdpdGggcm9vdCBwcml2aWxlZ2VzLgoKVGFsa3dpdGggZG9lcyBub3QgYXR0ZW1wdCB0byBs
b2FkIHlvdXIgc2V0dGluZ3MgYWZ0ZXIgdGhlIG5ldwpzeW50aGVzaXplciBpcyBhY3RpdmF0
ZWQuICBZb3UgY2FuIHVzZSBzcGVha3VwY29uZiB0byBsb2FkIHlvdXIgc2V0dGluZ3MKaWYg
ZGVzaXJlZC4KCiAgICAgICAgICAgICAgICBHTlUgRnJlZSBEb2N1bWVudGF0aW9uIExpY2Vu
c2UKICAgICAgICAgICAgICAgICAgVmVyc2lvbiAxLjIsIE5vdmVtYmVyIDIwMDIKCgogQ29w
eXJpZ2h0IChDKSAyMDAwLDIwMDEsMjAwMiAgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJ
bmMuCiBFdmVyeW9uZSBpcyBwZXJtaXR0ZWQgdG8gY29weSBhbmQgZGlzdHJpYnV0ZSB2ZXJi
YXRpbSBjb3BpZXMKIG9mIHRoaXMgbGljZW5zZSBkb2N1bWVudCwgYnV0IGNoYW5naW5nIGl0
IGlzIG5vdCBhbGxvd2VkLgoKCjAuIFBSRUFNQkxFCgpUaGUgcHVycG9zZSBvZiB0aGlzIExp
Y2Vuc2UgaXMgdG8gbWFrZSBhIG1hbnVhbCwgdGV4dGJvb2ssIG9yIG90aGVyCmZ1bmN0aW9u
YWwgYW5kIHVzZWZ1bCBkb2N1bWVudCAiZnJlZSIgaW4gdGhlIHNlbnNlIG9mIGZyZWVkb206
IHRvCmFzc3VyZSBldmVyeW9uZSB0aGUgZWZmZWN0aXZlIGZyZWVkb20gdG8gY29weSBhbmQg
cmVkaXN0cmlidXRlIGl0LAp3aXRoIG9yIHdpdGhvdXQgbW9kaWZ5aW5nIGl0LCBlaXRoZXIg
Y29tbWVyY2lhbGx5IG9yIG5vbmNvbW1lcmNpYWxseS4KU2Vjb25kYXJpbHksIHRoaXMgTGlj
ZW5zZSBwcmVzZXJ2ZXMgZm9yIHRoZSBhdXRob3IgYW5kIHB1Ymxpc2hlciBhIHdheQp0byBn
ZXQgY3JlZGl0IGZvciB0aGVpciB3b3JrLCB3aGlsZSBub3QgYmVpbmcgY29uc2lkZXJlZCBy
ZXNwb25zaWJsZQpmb3IgbW9kaWZpY2F0aW9ucyBtYWRlIGJ5IG90aGVycy4KClRoaXMgTGlj
ZW5zZSBpcyBhIGtpbmQgb2YgImNvcHlsZWZ0Iiwgd2hpY2ggbWVhbnMgdGhhdCBkZXJpdmF0
aXZlCndvcmtzIG9mIHRoZSBkb2N1bWVudCBtdXN0IHRoZW1zZWx2ZXMgYmUgZnJlZSBpbiB0
aGUgc2FtZSBzZW5zZS4gIEl0CmNvbXBsZW1lbnRzIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSwgd2hpY2ggaXMgYSBjb3B5bGVmdApsaWNlbnNlIGRlc2lnbmVkIGZvciBmcmVl
IHNvZnR3YXJlLgoKV2UgaGF2ZSBkZXNpZ25lZCB0aGlzIExpY2Vuc2UgaW4gb3JkZXIgdG8g
dXNlIGl0IGZvciBtYW51YWxzIGZvciBmcmVlCnNvZnR3YXJlLCBiZWNhdXNlIGZyZWUgc29m
dHdhcmUgbmVlZHMgZnJlZSBkb2N1bWVudGF0aW9uOiBhIGZyZWUKcHJvZ3JhbSBzaG91bGQg
Y29tZSB3aXRoIG1hbnVhbHMgcHJvdmlkaW5nIHRoZSBzYW1lIGZyZWVkb21zIHRoYXQgdGhl
CnNvZnR3YXJlIGRvZXMuICBCdXQgdGhpcyBMaWNlbnNlIGlzIG5vdCBsaW1pdGVkIHRvIHNv
ZnR3YXJlIG1hbnVhbHM7Cml0IGNhbiBiZSB1c2VkIGZvciBhbnkgdGV4dHVhbCB3b3JrLCBy
ZWdhcmRsZXNzIG9mIHN1YmplY3QgbWF0dGVyIG9yCndoZXRoZXIgaXQgaXMgcHVibGlzaGVk
IGFzIGEgcHJpbnRlZCBib29rLiAgV2UgcmVjb21tZW5kIHRoaXMgTGljZW5zZQpwcmluY2lw
YWxseSBmb3Igd29ya3Mgd2hvc2UgcHVycG9zZSBpcyBpbnN0cnVjdGlvbiBvciByZWZlcmVu
Y2UuCgoKMS4gQVBQTElDQUJJTElUWSBBTkQgREVGSU5JVElPTlMKClRoaXMgTGljZW5zZSBh
cHBsaWVzIHRvIGFueSBtYW51YWwgb3Igb3RoZXIgd29yaywgaW4gYW55IG1lZGl1bSwgdGhh
dApjb250YWlucyBhIG5vdGljZSBwbGFjZWQgYnkgdGhlIGNvcHlyaWdodCBob2xkZXIgc2F5
aW5nIGl0IGNhbiBiZQpkaXN0cmlidXRlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhpcyBMaWNl
bnNlLiAgU3VjaCBhIG5vdGljZSBncmFudHMgYQp3b3JsZC13aWRlLCByb3lhbHR5LWZyZWUg
bGljZW5zZSwgdW5saW1pdGVkIGluIGR1cmF0aW9uLCB0byB1c2UgdGhhdAp3b3JrIHVuZGVy
IHRoZSBjb25kaXRpb25zIHN0YXRlZCBoZXJlaW4uICBUaGUgIkRvY3VtZW50IiwgYmVsb3cs
CnJlZmVycyB0byBhbnkgc3VjaCBtYW51YWwgb3Igd29yay4gIEFueSBtZW1iZXIgb2YgdGhl
IHB1YmxpYyBpcyBhCmxpY2Vuc2VlLCBhbmQgaXMgYWRkcmVzc2VkIGFzICJ5b3UiLiAgWW91
IGFjY2VwdCB0aGUgbGljZW5zZSBpZiB5b3UKY29weSwgbW9kaWZ5IG9yIGRpc3RyaWJ1dGUg
dGhlIHdvcmsgaW4gYSB3YXkgcmVxdWlyaW5nIHBlcm1pc3Npb24KdW5kZXIgY29weXJpZ2h0
IGxhdy4KCkEgIk1vZGlmaWVkIFZlcnNpb24iIG9mIHRoZSBEb2N1bWVudCBtZWFucyBhbnkg
d29yayBjb250YWluaW5nIHRoZQpEb2N1bWVudCBvciBhIHBvcnRpb24gb2YgaXQsIGVpdGhl
ciBjb3BpZWQgdmVyYmF0aW0sIG9yIHdpdGgKbW9kaWZpY2F0aW9ucyBhbmQvb3IgdHJhbnNs
YXRlZCBpbnRvIGFub3RoZXIgbGFuZ3VhZ2UuCgpBICJTZWNvbmRhcnkgU2VjdGlvbiIgaXMg
YSBuYW1lZCBhcHBlbmRpeCBvciBhIGZyb250LW1hdHRlciBzZWN0aW9uIG9mCnRoZSBEb2N1
bWVudCB0aGF0IGRlYWxzIGV4Y2x1c2l2ZWx5IHdpdGggdGhlIHJlbGF0aW9uc2hpcCBvZiB0
aGUKcHVibGlzaGVycyBvciBhdXRob3JzIG9mIHRoZSBEb2N1bWVudCB0byB0aGUgRG9jdW1l
bnQncyBvdmVyYWxsIHN1YmplY3QKKG9yIHRvIHJlbGF0ZWQgbWF0dGVycykgYW5kIGNvbnRh
aW5zIG5vdGhpbmcgdGhhdCBjb3VsZCBmYWxsIGRpcmVjdGx5CndpdGhpbiB0aGF0IG92ZXJh
bGwgc3ViamVjdC4gIChUaHVzLCBpZiB0aGUgRG9jdW1lbnQgaXMgaW4gcGFydCBhCnRleHRi
b29rIG9mIG1hdGhlbWF0aWNzLCBhIFNlY29uZGFyeSBTZWN0aW9uIG1heSBub3QgZXhwbGFp
biBhbnkKbWF0aGVtYXRpY3MuKSAgVGhlIHJlbGF0aW9uc2hpcCBjb3VsZCBiZSBhIG1hdHRl
ciBvZiBoaXN0b3JpY2FsCmNvbm5lY3Rpb24gd2l0aCB0aGUgc3ViamVjdCBvciB3aXRoIHJl
bGF0ZWQgbWF0dGVycywgb3Igb2YgbGVnYWwsCmNvbW1lcmNpYWwsIHBoaWxvc29waGljYWws
IGV0aGljYWwgb3IgcG9saXRpY2FsIHBvc2l0aW9uIHJlZ2FyZGluZwp0aGVtLgoKVGhlICJJ
bnZhcmlhbnQgU2VjdGlvbnMiIGFyZSBjZXJ0YWluIFNlY29uZGFyeSBTZWN0aW9ucyB3aG9z
ZSB0aXRsZXMKYXJlIGRlc2lnbmF0ZWQsIGFzIGJlaW5nIHRob3NlIG9mIEludmFyaWFudCBT
ZWN0aW9ucywgaW4gdGhlIG5vdGljZQp0aGF0IHNheXMgdGhhdCB0aGUgRG9jdW1lbnQgaXMg
cmVsZWFzZWQgdW5kZXIgdGhpcyBMaWNlbnNlLiAgSWYgYQpzZWN0aW9uIGRvZXMgbm90IGZp
dCB0aGUgYWJvdmUgZGVmaW5pdGlvbiBvZiBTZWNvbmRhcnkgdGhlbiBpdCBpcyBub3QKYWxs
b3dlZCB0byBiZSBkZXNpZ25hdGVkIGFzIEludmFyaWFudC4gIFRoZSBEb2N1bWVudCBtYXkg
Y29udGFpbiB6ZXJvCkludmFyaWFudCBTZWN0aW9ucy4gIElmIHRoZSBEb2N1bWVudCBkb2Vz
IG5vdCBpZGVudGlmeSBhbnkgSW52YXJpYW50ClNlY3Rpb25zIHRoZW4gdGhlcmUgYXJlIG5v
bmUuCgpUaGUgIkNvdmVyIFRleHRzIiBhcmUgY2VydGFpbiBzaG9ydCBwYXNzYWdlcyBvZiB0
ZXh0IHRoYXQgYXJlIGxpc3RlZCwKYXMgRnJvbnQtQ292ZXIgVGV4dHMgb3IgQmFjay1Db3Zl
ciBUZXh0cywgaW4gdGhlIG5vdGljZSB0aGF0IHNheXMgdGhhdAp0aGUgRG9jdW1lbnQgaXMg
cmVsZWFzZWQgdW5kZXIgdGhpcyBMaWNlbnNlLiAgQSBGcm9udC1Db3ZlciBUZXh0IG1heQpi
ZSBhdCBtb3N0IDUgd29yZHMsIGFuZCBhIEJhY2stQ292ZXIgVGV4dCBtYXkgYmUgYXQgbW9z
dCAyNSB3b3Jkcy4KCkEgIlRyYW5zcGFyZW50IiBjb3B5IG9mIHRoZSBEb2N1bWVudCBtZWFu
cyBhIG1hY2hpbmUtcmVhZGFibGUgY29weSwKcmVwcmVzZW50ZWQgaW4gYSBmb3JtYXQgd2hv
c2Ugc3BlY2lmaWNhdGlvbiBpcyBhdmFpbGFibGUgdG8gdGhlCmdlbmVyYWwgcHVibGljLCB0
aGF0IGlzIHN1aXRhYmxlIGZvciByZXZpc2luZyB0aGUgZG9jdW1lbnQKc3RyYWlnaHRmb3J3
YXJkbHkgd2l0aCBnZW5lcmljIHRleHQgZWRpdG9ycyBvciAoZm9yIGltYWdlcyBjb21wb3Nl
ZCBvZgpwaXhlbHMpIGdlbmVyaWMgcGFpbnQgcHJvZ3JhbXMgb3IgKGZvciBkcmF3aW5ncykg
c29tZSB3aWRlbHkgYXZhaWxhYmxlCmRyYXdpbmcgZWRpdG9yLCBhbmQgdGhhdCBpcyBzdWl0
YWJsZSBmb3IgaW5wdXQgdG8gdGV4dCBmb3JtYXR0ZXJzIG9yCmZvciBhdXRvbWF0aWMgdHJh
bnNsYXRpb24gdG8gYSB2YXJpZXR5IG9mIGZvcm1hdHMgc3VpdGFibGUgZm9yIGlucHV0CnRv
IHRleHQgZm9ybWF0dGVycy4gIEEgY29weSBtYWRlIGluIGFuIG90aGVyd2lzZSBUcmFuc3Bh
cmVudCBmaWxlCmZvcm1hdCB3aG9zZSBtYXJrdXAsIG9yIGFic2VuY2Ugb2YgbWFya3VwLCBo
YXMgYmVlbiBhcnJhbmdlZCB0byB0aHdhcnQKb3IgZGlzY291cmFnZSBzdWJzZXF1ZW50IG1v
ZGlmaWNhdGlvbiBieSByZWFkZXJzIGlzIG5vdCBUcmFuc3BhcmVudC4KQW4gaW1hZ2UgZm9y
bWF0IGlzIG5vdCBUcmFuc3BhcmVudCBpZiB1c2VkIGZvciBhbnkgc3Vic3RhbnRpYWwgYW1v
dW50Cm9mIHRleHQuICBBIGNvcHkgdGhhdCBpcyBub3QgIlRyYW5zcGFyZW50IiBpcyBjYWxs
ZWQgIk9wYXF1ZSIuCgpFeGFtcGxlcyBvZiBzdWl0YWJsZSBmb3JtYXRzIGZvciBUcmFuc3Bh
cmVudCBjb3BpZXMgaW5jbHVkZSBwbGFpbgpBU0NJSSB3aXRob3V0IG1hcmt1cCwgVGV4aW5m
byBpbnB1dCBmb3JtYXQsIExhVGVYIGlucHV0IGZvcm1hdCwgU0dNTApvciBYTUwgdXNpbmcg
YSBwdWJsaWNseSBhdmFpbGFibGUgRFRELCBhbmQgc3RhbmRhcmQtY29uZm9ybWluZyBzaW1w
bGUKSFRNTCwgUG9zdFNjcmlwdCBvciBQREYgZGVzaWduZWQgZm9yIGh1bWFuIG1vZGlmaWNh
dGlvbi4gIEV4YW1wbGVzIG9mCnRyYW5zcGFyZW50IGltYWdlIGZvcm1hdHMgaW5jbHVkZSBQ
TkcsIFhDRiBhbmQgSlBHLiAgT3BhcXVlIGZvcm1hdHMKaW5jbHVkZSBwcm9wcmlldGFyeSBm
b3JtYXRzIHRoYXQgY2FuIGJlIHJlYWQgYW5kIGVkaXRlZCBvbmx5IGJ5CnByb3ByaWV0YXJ5
IHdvcmQgcHJvY2Vzc29ycywgU0dNTCBvciBYTUwgZm9yIHdoaWNoIHRoZSBEVEQgYW5kL29y
CnByb2Nlc3NpbmcgdG9vbHMgYXJlIG5vdCBnZW5lcmFsbHkgYXZhaWxhYmxlLCBhbmQgdGhl
Cm1hY2hpbmUtZ2VuZXJhdGVkIEhUTUwsIFBvc3RTY3JpcHQgb3IgUERGIHByb2R1Y2VkIGJ5
IHNvbWUgd29yZApwcm9jZXNzb3JzIGZvciBvdXRwdXQgcHVycG9zZXMgb25seS4KClRoZSAi
VGl0bGUgUGFnZSIgbWVhbnMsIGZvciBhIHByaW50ZWQgYm9vaywgdGhlIHRpdGxlIHBhZ2Ug
aXRzZWxmLApwbHVzIHN1Y2ggZm9sbG93aW5nIHBhZ2VzIGFzIGFyZSBuZWVkZWQgdG8gaG9s
ZCwgbGVnaWJseSwgdGhlIG1hdGVyaWFsCnRoaXMgTGljZW5zZSByZXF1aXJlcyB0byBhcHBl
YXIgaW4gdGhlIHRpdGxlIHBhZ2UuICBGb3Igd29ya3MgaW4KZm9ybWF0cyB3aGljaCBkbyBu
b3QgaGF2ZSBhbnkgdGl0bGUgcGFnZSBhcyBzdWNoLCAiVGl0bGUgUGFnZSIgbWVhbnMKdGhl
IHRleHQgbmVhciB0aGUgbW9zdCBwcm9taW5lbnQgYXBwZWFyYW5jZSBvZiB0aGUgd29yaydz
IHRpdGxlLApwcmVjZWRpbmcgdGhlIGJlZ2lubmluZyBvZiB0aGUgYm9keSBvZiB0aGUgdGV4
dC4KCkEgc2VjdGlvbiAiRW50aXRsZWQgWFlaIiBtZWFucyBhIG5hbWVkIHN1YnVuaXQgb2Yg
dGhlIERvY3VtZW50IHdob3NlCnRpdGxlIGVpdGhlciBpcyBwcmVjaXNlbHkgWFlaIG9yIGNv
bnRhaW5zIFhZWiBpbiBwYXJlbnRoZXNlcyBmb2xsb3dpbmcKdGV4dCB0aGF0IHRyYW5zbGF0
ZXMgWFlaIGluIGFub3RoZXIgbGFuZ3VhZ2UuICAoSGVyZSBYWVogc3RhbmRzIGZvciBhCnNw
ZWNpZmljIHNlY3Rpb24gbmFtZSBtZW50aW9uZWQgYmVsb3csIHN1Y2ggYXMgIkFja25vd2xl
ZGdlbWVudHMiLAoiRGVkaWNhdGlvbnMiLCAiRW5kb3JzZW1lbnRzIiwgb3IgIkhpc3Rvcnki
LikgIFRvICJQcmVzZXJ2ZSB0aGUgVGl0bGUiCm9mIHN1Y2ggYSBzZWN0aW9uIHdoZW4geW91
IG1vZGlmeSB0aGUgRG9jdW1lbnQgbWVhbnMgdGhhdCBpdCByZW1haW5zIGEKc2VjdGlvbiAi
RW50aXRsZWQgWFlaIiBhY2NvcmRpbmcgdG8gdGhpcyBkZWZpbml0aW9uLgoKVGhlIERvY3Vt
ZW50IG1heSBpbmNsdWRlIFdhcnJhbnR5IERpc2NsYWltZXJzIG5leHQgdG8gdGhlIG5vdGlj
ZSB3aGljaApzdGF0ZXMgdGhhdCB0aGlzIExpY2Vuc2UgYXBwbGllcyB0byB0aGUgRG9jdW1l
bnQuICBUaGVzZSBXYXJyYW50eQpEaXNjbGFpbWVycyBhcmUgY29uc2lkZXJlZCB0byBiZSBp
bmNsdWRlZCBieSByZWZlcmVuY2UgaW4gdGhpcwpMaWNlbnNlLCBidXQgb25seSBhcyByZWdh
cmRzIGRpc2NsYWltaW5nIHdhcnJhbnRpZXM6IGFueSBvdGhlcgppbXBsaWNhdGlvbiB0aGF0
IHRoZXNlIFdhcnJhbnR5IERpc2NsYWltZXJzIG1heSBoYXZlIGlzIHZvaWQgYW5kIGhhcwpu
byBlZmZlY3Qgb24gdGhlIG1lYW5pbmcgb2YgdGhpcyBMaWNlbnNlLgoKCjIuIFZFUkJBVElN
IENPUFlJTkcKCllvdSBtYXkgY29weSBhbmQgZGlzdHJpYnV0ZSB0aGUgRG9jdW1lbnQgaW4g
YW55IG1lZGl1bSwgZWl0aGVyCmNvbW1lcmNpYWxseSBvciBub25jb21tZXJjaWFsbHksIHBy
b3ZpZGVkIHRoYXQgdGhpcyBMaWNlbnNlLCB0aGUKY29weXJpZ2h0IG5vdGljZXMsIGFuZCB0
aGUgbGljZW5zZSBub3RpY2Ugc2F5aW5nIHRoaXMgTGljZW5zZSBhcHBsaWVzCnRvIHRoZSBE
b2N1bWVudCBhcmUgcmVwcm9kdWNlZCBpbiBhbGwgY29waWVzLCBhbmQgdGhhdCB5b3UgYWRk
IG5vIG90aGVyCmNvbmRpdGlvbnMgd2hhdHNvZXZlciB0byB0aG9zZSBvZiB0aGlzIExpY2Vu
c2UuICBZb3UgbWF5IG5vdCB1c2UKdGVjaG5pY2FsIG1lYXN1cmVzIHRvIG9ic3RydWN0IG9y
IGNvbnRyb2wgdGhlIHJlYWRpbmcgb3IgZnVydGhlcgpjb3B5aW5nIG9mIHRoZSBjb3BpZXMg
eW91IG1ha2Ugb3IgZGlzdHJpYnV0ZS4gIEhvd2V2ZXIsIHlvdSBtYXkgYWNjZXB0CmNvbXBl
bnNhdGlvbiBpbiBleGNoYW5nZSBmb3IgY29waWVzLiAgSWYgeW91IGRpc3RyaWJ1dGUgYSBs
YXJnZSBlbm91Z2gKbnVtYmVyIG9mIGNvcGllcyB5b3UgbXVzdCBhbHNvIGZvbGxvdyB0aGUg
Y29uZGl0aW9ucyBpbiBzZWN0aW9uIDMuCgpZb3UgbWF5IGFsc28gbGVuZCBjb3BpZXMsIHVu
ZGVyIHRoZSBzYW1lIGNvbmRpdGlvbnMgc3RhdGVkIGFib3ZlLCBhbmQKeW91IG1heSBwdWJs
aWNseSBkaXNwbGF5IGNvcGllcy4KCgozLiBDT1BZSU5HIElOIFFVQU5USVRZCgpJZiB5b3Ug
cHVibGlzaCBwcmludGVkIGNvcGllcyAob3IgY29waWVzIGluIG1lZGlhIHRoYXQgY29tbW9u
bHkgaGF2ZQpwcmludGVkIGNvdmVycykgb2YgdGhlIERvY3VtZW50LCBudW1iZXJpbmcgbW9y
ZSB0aGFuIDEwMCwgYW5kIHRoZQpEb2N1bWVudCdzIGxpY2Vuc2Ugbm90aWNlIHJlcXVpcmVz
IENvdmVyIFRleHRzLCB5b3UgbXVzdCBlbmNsb3NlIHRoZQpjb3BpZXMgaW4gY292ZXJzIHRo
YXQgY2FycnksIGNsZWFybHkgYW5kIGxlZ2libHksIGFsbCB0aGVzZSBDb3ZlcgpUZXh0czog
RnJvbnQtQ292ZXIgVGV4dHMgb24gdGhlIGZyb250IGNvdmVyLCBhbmQgQmFjay1Db3ZlciBU
ZXh0cyBvbgp0aGUgYmFjayBjb3Zlci4gIEJvdGggY292ZXJzIG11c3QgYWxzbyBjbGVhcmx5
IGFuZCBsZWdpYmx5IGlkZW50aWZ5CnlvdSBhcyB0aGUgcHVibGlzaGVyIG9mIHRoZXNlIGNv
cGllcy4gIFRoZSBmcm9udCBjb3ZlciBtdXN0IHByZXNlbnQKdGhlIGZ1bGwgdGl0bGUgd2l0
aCBhbGwgd29yZHMgb2YgdGhlIHRpdGxlIGVxdWFsbHkgcHJvbWluZW50IGFuZAp2aXNpYmxl
LiAgWW91IG1heSBhZGQgb3RoZXIgbWF0ZXJpYWwgb24gdGhlIGNvdmVycyBpbiBhZGRpdGlv
bi4KQ29weWluZyB3aXRoIGNoYW5nZXMgbGltaXRlZCB0byB0aGUgY292ZXJzLCBhcyBsb25n
IGFzIHRoZXkgcHJlc2VydmUKdGhlIHRpdGxlIG9mIHRoZSBEb2N1bWVudCBhbmQgc2F0aXNm
eSB0aGVzZSBjb25kaXRpb25zLCBjYW4gYmUgdHJlYXRlZAphcyB2ZXJiYXRpbSBjb3B5aW5n
IGluIG90aGVyIHJlc3BlY3RzLgoKSWYgdGhlIHJlcXVpcmVkIHRleHRzIGZvciBlaXRoZXIg
Y292ZXIgYXJlIHRvbyB2b2x1bWlub3VzIHRvIGZpdApsZWdpYmx5LCB5b3Ugc2hvdWxkIHB1
dCB0aGUgZmlyc3Qgb25lcyBsaXN0ZWQgKGFzIG1hbnkgYXMgZml0CnJlYXNvbmFibHkpIG9u
IHRoZSBhY3R1YWwgY292ZXIsIGFuZCBjb250aW51ZSB0aGUgcmVzdCBvbnRvIGFkamFjZW50
CnBhZ2VzLgoKSWYgeW91IHB1Ymxpc2ggb3IgZGlzdHJpYnV0ZSBPcGFxdWUgY29waWVzIG9m
IHRoZSBEb2N1bWVudCBudW1iZXJpbmcKbW9yZSB0aGFuIDEwMCwgeW91IG11c3QgZWl0aGVy
IGluY2x1ZGUgYSBtYWNoaW5lLXJlYWRhYmxlIFRyYW5zcGFyZW50CmNvcHkgYWxvbmcgd2l0
aCBlYWNoIE9wYXF1ZSBjb3B5LCBvciBzdGF0ZSBpbiBvciB3aXRoIGVhY2ggT3BhcXVlIGNv
cHkKYSBjb21wdXRlci1uZXR3b3JrIGxvY2F0aW9uIGZyb20gd2hpY2ggdGhlIGdlbmVyYWwg
bmV0d29yay11c2luZwpwdWJsaWMgaGFzIGFjY2VzcyB0byBkb3dubG9hZCB1c2luZyBwdWJs
aWMtc3RhbmRhcmQgbmV0d29yayBwcm90b2NvbHMKYSBjb21wbGV0ZSBUcmFuc3BhcmVudCBj
b3B5IG9mIHRoZSBEb2N1bWVudCwgZnJlZSBvZiBhZGRlZCBtYXRlcmlhbC4KSWYgeW91IHVz
ZSB0aGUgbGF0dGVyIG9wdGlvbiwgeW91IG11c3QgdGFrZSByZWFzb25hYmx5IHBydWRlbnQg
c3RlcHMsCndoZW4geW91IGJlZ2luIGRpc3RyaWJ1dGlvbiBvZiBPcGFxdWUgY29waWVzIGlu
IHF1YW50aXR5LCB0byBlbnN1cmUKdGhhdCB0aGlzIFRyYW5zcGFyZW50IGNvcHkgd2lsbCBy
ZW1haW4gdGh1cyBhY2Nlc3NpYmxlIGF0IHRoZSBzdGF0ZWQKbG9jYXRpb24gdW50aWwgYXQg
bGVhc3Qgb25lIHllYXIgYWZ0ZXIgdGhlIGxhc3QgdGltZSB5b3UgZGlzdHJpYnV0ZSBhbgpP
cGFxdWUgY29weSAoZGlyZWN0bHkgb3IgdGhyb3VnaCB5b3VyIGFnZW50cyBvciByZXRhaWxl
cnMpIG9mIHRoYXQKZWRpdGlvbiB0byB0aGUgcHVibGljLgoKSXQgaXMgcmVxdWVzdGVkLCBi
dXQgbm90IHJlcXVpcmVkLCB0aGF0IHlvdSBjb250YWN0IHRoZSBhdXRob3JzIG9mIHRoZQpE
b2N1bWVudCB3ZWxsIGJlZm9yZSByZWRpc3RyaWJ1dGluZyBhbnkgbGFyZ2UgbnVtYmVyIG9m
IGNvcGllcywgdG8gZ2l2ZQp0aGVtIGEgY2hhbmNlIHRvIHByb3ZpZGUgeW91IHdpdGggYW4g
dXBkYXRlZCB2ZXJzaW9uIG9mIHRoZSBEb2N1bWVudC4KCgo0LiBNT0RJRklDQVRJT05TCgpZ
b3UgbWF5IGNvcHkgYW5kIGRpc3RyaWJ1dGUgYSBNb2RpZmllZCBWZXJzaW9uIG9mIHRoZSBE
b2N1bWVudCB1bmRlcgp0aGUgY29uZGl0aW9ucyBvZiBzZWN0aW9ucyAyIGFuZCAzIGFib3Zl
LCBwcm92aWRlZCB0aGF0IHlvdSByZWxlYXNlCnRoZSBNb2RpZmllZCBWZXJzaW9uIHVuZGVy
IHByZWNpc2VseSB0aGlzIExpY2Vuc2UsIHdpdGggdGhlIE1vZGlmaWVkClZlcnNpb24gZmls
bGluZyB0aGUgcm9sZSBvZiB0aGUgRG9jdW1lbnQsIHRodXMgbGljZW5zaW5nIGRpc3RyaWJ1
dGlvbgphbmQgbW9kaWZpY2F0aW9uIG9mIHRoZSBNb2RpZmllZCBWZXJzaW9uIHRvIHdob2V2
ZXIgcG9zc2Vzc2VzIGEgY29weQpvZiBpdC4gIEluIGFkZGl0aW9uLCB5b3UgbXVzdCBkbyB0
aGVzZSB0aGluZ3MgaW4gdGhlIE1vZGlmaWVkIFZlcnNpb246CgpBLiBVc2UgaW4gdGhlIFRp
dGxlIFBhZ2UgKGFuZCBvbiB0aGUgY292ZXJzLCBpZiBhbnkpIGEgdGl0bGUgZGlzdGluY3QK
ICAgZnJvbSB0aGF0IG9mIHRoZSBEb2N1bWVudCwgYW5kIGZyb20gdGhvc2Ugb2YgcHJldmlv
dXMgdmVyc2lvbnMKICAgKHdoaWNoIHNob3VsZCwgaWYgdGhlcmUgd2VyZSBhbnksIGJlIGxp
c3RlZCBpbiB0aGUgSGlzdG9yeSBzZWN0aW9uCiAgIG9mIHRoZSBEb2N1bWVudCkuICBZb3Ug
bWF5IHVzZSB0aGUgc2FtZSB0aXRsZSBhcyBhIHByZXZpb3VzIHZlcnNpb24KICAgaWYgdGhl
IG9yaWdpbmFsIHB1Ymxpc2hlciBvZiB0aGF0IHZlcnNpb24gZ2l2ZXMgcGVybWlzc2lvbi4K
Qi4gTGlzdCBvbiB0aGUgVGl0bGUgUGFnZSwgYXMgYXV0aG9ycywgb25lIG9yIG1vcmUgcGVy
c29ucyBvciBlbnRpdGllcwogICByZXNwb25zaWJsZSBmb3IgYXV0aG9yc2hpcCBvZiB0aGUg
bW9kaWZpY2F0aW9ucyBpbiB0aGUgTW9kaWZpZWQKICAgVmVyc2lvbiwgdG9nZXRoZXIgd2l0
aCBhdCBsZWFzdCBmaXZlIG9mIHRoZSBwcmluY2lwYWwgYXV0aG9ycyBvZiB0aGUKICAgRG9j
dW1lbnQgKGFsbCBvZiBpdHMgcHJpbmNpcGFsIGF1dGhvcnMsIGlmIGl0IGhhcyBmZXdlciB0
aGFuIGZpdmUpLAogICB1bmxlc3MgdGhleSByZWxlYXNlIHlvdSBmcm9tIHRoaXMgcmVxdWly
ZW1lbnQuCkMuIFN0YXRlIG9uIHRoZSBUaXRsZSBwYWdlIHRoZSBuYW1lIG9mIHRoZSBwdWJs
aXNoZXIgb2YgdGhlCiAgIE1vZGlmaWVkIFZlcnNpb24sIGFzIHRoZSBwdWJsaXNoZXIuCkQu
IFByZXNlcnZlIGFsbCB0aGUgY29weXJpZ2h0IG5vdGljZXMgb2YgdGhlIERvY3VtZW50LgpF
LiBBZGQgYW4gYXBwcm9wcmlhdGUgY29weXJpZ2h0IG5vdGljZSBmb3IgeW91ciBtb2RpZmlj
YXRpb25zCiAgIGFkamFjZW50IHRvIHRoZSBvdGhlciBjb3B5cmlnaHQgbm90aWNlcy4KRi4g
SW5jbHVkZSwgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGNvcHlyaWdodCBub3RpY2VzLCBhIGxp
Y2Vuc2Ugbm90aWNlCiAgIGdpdmluZyB0aGUgcHVibGljIHBlcm1pc3Npb24gdG8gdXNlIHRo
ZSBNb2RpZmllZCBWZXJzaW9uIHVuZGVyIHRoZQogICB0ZXJtcyBvZiB0aGlzIExpY2Vuc2Us
IGluIHRoZSBmb3JtIHNob3duIGluIHRoZSBBZGRlbmR1bSBiZWxvdy4KRy4gUHJlc2VydmUg
aW4gdGhhdCBsaWNlbnNlIG5vdGljZSB0aGUgZnVsbCBsaXN0cyBvZiBJbnZhcmlhbnQgU2Vj
dGlvbnMKICAgYW5kIHJlcXVpcmVkIENvdmVyIFRleHRzIGdpdmVuIGluIHRoZSBEb2N1bWVu
dCdzIGxpY2Vuc2Ugbm90aWNlLgpILiBJbmNsdWRlIGFuIHVuYWx0ZXJlZCBjb3B5IG9mIHRo
aXMgTGljZW5zZS4KSS4gUHJlc2VydmUgdGhlIHNlY3Rpb24gRW50aXRsZWQgIkhpc3Rvcnki
LCBQcmVzZXJ2ZSBpdHMgVGl0bGUsIGFuZCBhZGQKICAgdG8gaXQgYW4gaXRlbSBzdGF0aW5n
IGF0IGxlYXN0IHRoZSB0aXRsZSwgeWVhciwgbmV3IGF1dGhvcnMsIGFuZAogICBwdWJsaXNo
ZXIgb2YgdGhlIE1vZGlmaWVkIFZlcnNpb24gYXMgZ2l2ZW4gb24gdGhlIFRpdGxlIFBhZ2Uu
ICBJZgogICB0aGVyZSBpcyBubyBzZWN0aW9uIEVudGl0bGVkICJIaXN0b3J5IiBpbiB0aGUg
RG9jdW1lbnQsIGNyZWF0ZSBvbmUKICAgc3RhdGluZyB0aGUgdGl0bGUsIHllYXIsIGF1dGhv
cnMsIGFuZCBwdWJsaXNoZXIgb2YgdGhlIERvY3VtZW50IGFzCiAgIGdpdmVuIG9uIGl0cyBU
aXRsZSBQYWdlLCB0aGVuIGFkZCBhbiBpdGVtIGRlc2NyaWJpbmcgdGhlIE1vZGlmaWVkCiAg
IFZlcnNpb24gYXMgc3RhdGVkIGluIHRoZSBwcmV2aW91cyBzZW50ZW5jZS4KSi4gUHJlc2Vy
dmUgdGhlIG5ldHdvcmsgbG9jYXRpb24sIGlmIGFueSwgZ2l2ZW4gaW4gdGhlIERvY3VtZW50
IGZvcgogICBwdWJsaWMgYWNjZXNzIHRvIGEgVHJhbnNwYXJlbnQgY29weSBvZiB0aGUgRG9j
dW1lbnQsIGFuZCBsaWtld2lzZQogICB0aGUgbmV0d29yayBsb2NhdGlvbnMgZ2l2ZW4gaW4g
dGhlIERvY3VtZW50IGZvciBwcmV2aW91cyB2ZXJzaW9ucwogICBpdCB3YXMgYmFzZWQgb24u
ICBUaGVzZSBtYXkgYmUgcGxhY2VkIGluIHRoZSAiSGlzdG9yeSIgc2VjdGlvbi4KICAgWW91
IG1heSBvbWl0IGEgbmV0d29yayBsb2NhdGlvbiBmb3IgYSB3b3JrIHRoYXQgd2FzIHB1Ymxp
c2hlZCBhdAogICBsZWFzdCBmb3VyIHllYXJzIGJlZm9yZSB0aGUgRG9jdW1lbnQgaXRzZWxm
LCBvciBpZiB0aGUgb3JpZ2luYWwKICAgcHVibGlzaGVyIG9mIHRoZSB2ZXJzaW9uIGl0IHJl
ZmVycyB0byBnaXZlcyBwZXJtaXNzaW9uLgpLLiBGb3IgYW55IHNlY3Rpb24gRW50aXRsZWQg
IkFja25vd2xlZGdlbWVudHMiIG9yICJEZWRpY2F0aW9ucyIsCiAgIFByZXNlcnZlIHRoZSBU
aXRsZSBvZiB0aGUgc2VjdGlvbiwgYW5kIHByZXNlcnZlIGluIHRoZSBzZWN0aW9uIGFsbAog
ICB0aGUgc3Vic3RhbmNlIGFuZCB0b25lIG9mIGVhY2ggb2YgdGhlIGNvbnRyaWJ1dG9yIGFj
a25vd2xlZGdlbWVudHMKICAgYW5kL29yIGRlZGljYXRpb25zIGdpdmVuIHRoZXJlaW4uCkwu
IFByZXNlcnZlIGFsbCB0aGUgSW52YXJpYW50IFNlY3Rpb25zIG9mIHRoZSBEb2N1bWVudCwK
ICAgdW5hbHRlcmVkIGluIHRoZWlyIHRleHQgYW5kIGluIHRoZWlyIHRpdGxlcy4gIFNlY3Rp
b24gbnVtYmVycwogICBvciB0aGUgZXF1aXZhbGVudCBhcmUgbm90IGNvbnNpZGVyZWQgcGFy
dCBvZiB0aGUgc2VjdGlvbiB0aXRsZXMuCk0uIERlbGV0ZSBhbnkgc2VjdGlvbiBFbnRpdGxl
ZCAiRW5kb3JzZW1lbnRzIi4gIFN1Y2ggYSBzZWN0aW9uCiAgIG1heSBub3QgYmUgaW5jbHVk
ZWQgaW4gdGhlIE1vZGlmaWVkIFZlcnNpb24uCk4uIERvIG5vdCByZXRpdGxlIGFueSBleGlz
dGluZyBzZWN0aW9uIHRvIGJlIEVudGl0bGVkICJFbmRvcnNlbWVudHMiCiAgIG9yIHRvIGNv
bmZsaWN0IGluIHRpdGxlIHdpdGggYW55IEludmFyaWFudCBTZWN0aW9uLgpPLiBQcmVzZXJ2
ZSBhbnkgV2FycmFudHkgRGlzY2xhaW1lcnMuCgpJZiB0aGUgTW9kaWZpZWQgVmVyc2lvbiBp
bmNsdWRlcyBuZXcgZnJvbnQtbWF0dGVyIHNlY3Rpb25zIG9yCmFwcGVuZGljZXMgdGhhdCBx
dWFsaWZ5IGFzIFNlY29uZGFyeSBTZWN0aW9ucyBhbmQgY29udGFpbiBubyBtYXRlcmlhbApj
b3BpZWQgZnJvbSB0aGUgRG9jdW1lbnQsIHlvdSBtYXkgYXQgeW91ciBvcHRpb24gZGVzaWdu
YXRlIHNvbWUgb3IgYWxsCm9mIHRoZXNlIHNlY3Rpb25zIGFzIGludmFyaWFudC4gIFRvIGRv
IHRoaXMsIGFkZCB0aGVpciB0aXRsZXMgdG8gdGhlCmxpc3Qgb2YgSW52YXJpYW50IFNlY3Rp
b25zIGluIHRoZSBNb2RpZmllZCBWZXJzaW9uJ3MgbGljZW5zZSBub3RpY2UuClRoZXNlIHRp
dGxlcyBtdXN0IGJlIGRpc3RpbmN0IGZyb20gYW55IG90aGVyIHNlY3Rpb24gdGl0bGVzLgoK
WW91IG1heSBhZGQgYSBzZWN0aW9uIEVudGl0bGVkICJFbmRvcnNlbWVudHMiLCBwcm92aWRl
ZCBpdCBjb250YWlucwpub3RoaW5nIGJ1dCBlbmRvcnNlbWVudHMgb2YgeW91ciBNb2RpZmll
ZCBWZXJzaW9uIGJ5IHZhcmlvdXMKcGFydGllcy0tZm9yIGV4YW1wbGUsIHN0YXRlbWVudHMg
b2YgcGVlciByZXZpZXcgb3IgdGhhdCB0aGUgdGV4dCBoYXMKYmVlbiBhcHByb3ZlZCBieSBh
biBvcmdhbml6YXRpb24gYXMgdGhlIGF1dGhvcml0YXRpdmUgZGVmaW5pdGlvbiBvZiBhCnN0
YW5kYXJkLgoKWW91IG1heSBhZGQgYSBwYXNzYWdlIG9mIHVwIHRvIGZpdmUgd29yZHMgYXMg
YSBGcm9udC1Db3ZlciBUZXh0LCBhbmQgYQpwYXNzYWdlIG9mIHVwIHRvIDI1IHdvcmRzIGFz
IGEgQmFjay1Db3ZlciBUZXh0LCB0byB0aGUgZW5kIG9mIHRoZSBsaXN0Cm9mIENvdmVyIFRl
eHRzIGluIHRoZSBNb2RpZmllZCBWZXJzaW9uLiAgT25seSBvbmUgcGFzc2FnZSBvZgpGcm9u
dC1Db3ZlciBUZXh0IGFuZCBvbmUgb2YgQmFjay1Db3ZlciBUZXh0IG1heSBiZSBhZGRlZCBi
eSAob3IKdGhyb3VnaCBhcnJhbmdlbWVudHMgbWFkZSBieSkgYW55IG9uZSBlbnRpdHkuICBJ
ZiB0aGUgRG9jdW1lbnQgYWxyZWFkeQppbmNsdWRlcyBhIGNvdmVyIHRleHQgZm9yIHRoZSBz
YW1lIGNvdmVyLCBwcmV2aW91c2x5IGFkZGVkIGJ5IHlvdSBvcgpieSBhcnJhbmdlbWVudCBt
YWRlIGJ5IHRoZSBzYW1lIGVudGl0eSB5b3UgYXJlIGFjdGluZyBvbiBiZWhhbGYgb2YsCnlv
dSBtYXkgbm90IGFkZCBhbm90aGVyOyBidXQgeW91IG1heSByZXBsYWNlIHRoZSBvbGQgb25l
LCBvbiBleHBsaWNpdApwZXJtaXNzaW9uIGZyb20gdGhlIHByZXZpb3VzIHB1Ymxpc2hlciB0
aGF0IGFkZGVkIHRoZSBvbGQgb25lLgoKVGhlIGF1dGhvcihzKSBhbmQgcHVibGlzaGVyKHMp
IG9mIHRoZSBEb2N1bWVudCBkbyBub3QgYnkgdGhpcyBMaWNlbnNlCmdpdmUgcGVybWlzc2lv
biB0byB1c2UgdGhlaXIgbmFtZXMgZm9yIHB1YmxpY2l0eSBmb3Igb3IgdG8gYXNzZXJ0IG9y
CmltcGx5IGVuZG9yc2VtZW50IG9mIGFueSBNb2RpZmllZCBWZXJzaW9uLgoKCjUuIENPTUJJ
TklORyBET0NVTUVOVFMKCllvdSBtYXkgY29tYmluZSB0aGUgRG9jdW1lbnQgd2l0aCBvdGhl
ciBkb2N1bWVudHMgcmVsZWFzZWQgdW5kZXIgdGhpcwpMaWNlbnNlLCB1bmRlciB0aGUgdGVy
bXMgZGVmaW5lZCBpbiBzZWN0aW9uIDQgYWJvdmUgZm9yIG1vZGlmaWVkCnZlcnNpb25zLCBw
cm92aWRlZCB0aGF0IHlvdSBpbmNsdWRlIGluIHRoZSBjb21iaW5hdGlvbiBhbGwgb2YgdGhl
CkludmFyaWFudCBTZWN0aW9ucyBvZiBhbGwgb2YgdGhlIG9yaWdpbmFsIGRvY3VtZW50cywg
dW5tb2RpZmllZCwgYW5kCmxpc3QgdGhlbSBhbGwgYXMgSW52YXJpYW50IFNlY3Rpb25zIG9m
IHlvdXIgY29tYmluZWQgd29yayBpbiBpdHMKbGljZW5zZSBub3RpY2UsIGFuZCB0aGF0IHlv
dSBwcmVzZXJ2ZSBhbGwgdGhlaXIgV2FycmFudHkgRGlzY2xhaW1lcnMuCgpUaGUgY29tYmlu
ZWQgd29yayBuZWVkIG9ubHkgY29udGFpbiBvbmUgY29weSBvZiB0aGlzIExpY2Vuc2UsIGFu
ZAptdWx0aXBsZSBpZGVudGljYWwgSW52YXJpYW50IFNlY3Rpb25zIG1heSBiZSByZXBsYWNl
ZCB3aXRoIGEgc2luZ2xlCmNvcHkuICBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgSW52YXJpYW50
IFNlY3Rpb25zIHdpdGggdGhlIHNhbWUgbmFtZSBidXQKZGlmZmVyZW50IGNvbnRlbnRzLCBt
YWtlIHRoZSB0aXRsZSBvZiBlYWNoIHN1Y2ggc2VjdGlvbiB1bmlxdWUgYnkKYWRkaW5nIGF0
IHRoZSBlbmQgb2YgaXQsIGluIHBhcmVudGhlc2VzLCB0aGUgbmFtZSBvZiB0aGUgb3JpZ2lu
YWwKYXV0aG9yIG9yIHB1Ymxpc2hlciBvZiB0aGF0IHNlY3Rpb24gaWYga25vd24sIG9yIGVs
c2UgYSB1bmlxdWUgbnVtYmVyLgpNYWtlIHRoZSBzYW1lIGFkanVzdG1lbnQgdG8gdGhlIHNl
Y3Rpb24gdGl0bGVzIGluIHRoZSBsaXN0IG9mCkludmFyaWFudCBTZWN0aW9ucyBpbiB0aGUg
bGljZW5zZSBub3RpY2Ugb2YgdGhlIGNvbWJpbmVkIHdvcmsuCgpJbiB0aGUgY29tYmluYXRp
b24sIHlvdSBtdXN0IGNvbWJpbmUgYW55IHNlY3Rpb25zIEVudGl0bGVkICJIaXN0b3J5Igpp
biB0aGUgdmFyaW91cyBvcmlnaW5hbCBkb2N1bWVudHMsIGZvcm1pbmcgb25lIHNlY3Rpb24g
RW50aXRsZWQKIkhpc3RvcnkiOyBsaWtld2lzZSBjb21iaW5lIGFueSBzZWN0aW9ucyBFbnRp
dGxlZCAiQWNrbm93bGVkZ2VtZW50cyIsCmFuZCBhbnkgc2VjdGlvbnMgRW50aXRsZWQgIkRl
ZGljYXRpb25zIi4gIFlvdSBtdXN0IGRlbGV0ZSBhbGwgc2VjdGlvbnMKRW50aXRsZWQgIkVu
ZG9yc2VtZW50cyIuCgoKNi4gQ09MTEVDVElPTlMgT0YgRE9DVU1FTlRTCgpZb3UgbWF5IG1h
a2UgYSBjb2xsZWN0aW9uIGNvbnNpc3Rpbmcgb2YgdGhlIERvY3VtZW50IGFuZCBvdGhlciBk
b2N1bWVudHMKcmVsZWFzZWQgdW5kZXIgdGhpcyBMaWNlbnNlLCBhbmQgcmVwbGFjZSB0aGUg
aW5kaXZpZHVhbCBjb3BpZXMgb2YgdGhpcwpMaWNlbnNlIGluIHRoZSB2YXJpb3VzIGRvY3Vt
ZW50cyB3aXRoIGEgc2luZ2xlIGNvcHkgdGhhdCBpcyBpbmNsdWRlZCBpbgp0aGUgY29sbGVj
dGlvbiwgcHJvdmlkZWQgdGhhdCB5b3UgZm9sbG93IHRoZSBydWxlcyBvZiB0aGlzIExpY2Vu
c2UgZm9yCnZlcmJhdGltIGNvcHlpbmcgb2YgZWFjaCBvZiB0aGUgZG9jdW1lbnRzIGluIGFs
bCBvdGhlciByZXNwZWN0cy4KCllvdSBtYXkgZXh0cmFjdCBhIHNpbmdsZSBkb2N1bWVudCBm
cm9tIHN1Y2ggYSBjb2xsZWN0aW9uLCBhbmQgZGlzdHJpYnV0ZQppdCBpbmRpdmlkdWFsbHkg
dW5kZXIgdGhpcyBMaWNlbnNlLCBwcm92aWRlZCB5b3UgaW5zZXJ0IGEgY29weSBvZiB0aGlz
CkxpY2Vuc2UgaW50byB0aGUgZXh0cmFjdGVkIGRvY3VtZW50LCBhbmQgZm9sbG93IHRoaXMg
TGljZW5zZSBpbiBhbGwKb3RoZXIgcmVzcGVjdHMgcmVnYXJkaW5nIHZlcmJhdGltIGNvcHlp
bmcgb2YgdGhhdCBkb2N1bWVudC4KCgo3LiBBR0dSRUdBVElPTiBXSVRIIElOREVQRU5ERU5U
IFdPUktTCgpBIGNvbXBpbGF0aW9uIG9mIHRoZSBEb2N1bWVudCBvciBpdHMgZGVyaXZhdGl2
ZXMgd2l0aCBvdGhlciBzZXBhcmF0ZQphbmQgaW5kZXBlbmRlbnQgZG9jdW1lbnRzIG9yIHdv
cmtzLCBpbiBvciBvbiBhIHZvbHVtZSBvZiBhIHN0b3JhZ2Ugb3IKZGlzdHJpYnV0aW9uIG1l
ZGl1bSwgaXMgY2FsbGVkIGFuICJhZ2dyZWdhdGUiIGlmIHRoZSBjb3B5cmlnaHQKcmVzdWx0
aW5nIGZyb20gdGhlIGNvbXBpbGF0aW9uIGlzIG5vdCB1c2VkIHRvIGxpbWl0IHRoZSBsZWdh
bCByaWdodHMKb2YgdGhlIGNvbXBpbGF0aW9uJ3MgdXNlcnMgYmV5b25kIHdoYXQgdGhlIGlu
ZGl2aWR1YWwgd29ya3MgcGVybWl0LgpXaGVuIHRoZSBEb2N1bWVudCBpcyBpbmNsdWRlZCBp
biBhbiBhZ2dyZWdhdGUsIHRoaXMgTGljZW5zZSBkb2VzIG5vdAphcHBseSB0byB0aGUgb3Ro
ZXIgd29ya3MgaW4gdGhlIGFnZ3JlZ2F0ZSB3aGljaCBhcmUgbm90IHRoZW1zZWx2ZXMKZGVy
aXZhdGl2ZSB3b3JrcyBvZiB0aGUgRG9jdW1lbnQuCgpJZiB0aGUgQ292ZXIgVGV4dCByZXF1
aXJlbWVudCBvZiBzZWN0aW9uIDMgaXMgYXBwbGljYWJsZSB0byB0aGVzZQpjb3BpZXMgb2Yg
dGhlIERvY3VtZW50LCB0aGVuIGlmIHRoZSBEb2N1bWVudCBpcyBsZXNzIHRoYW4gb25lIGhh
bGYgb2YKdGhlIGVudGlyZSBhZ2dyZWdhdGUsIHRoZSBEb2N1bWVudCdzIENvdmVyIFRleHRz
IG1heSBiZSBwbGFjZWQgb24KY292ZXJzIHRoYXQgYnJhY2tldCB0aGUgRG9jdW1lbnQgd2l0
aGluIHRoZSBhZ2dyZWdhdGUsIG9yIHRoZQplbGVjdHJvbmljIGVxdWl2YWxlbnQgb2YgY292
ZXJzIGlmIHRoZSBEb2N1bWVudCBpcyBpbiBlbGVjdHJvbmljIGZvcm0uCk90aGVyd2lzZSB0
aGV5IG11c3QgYXBwZWFyIG9uIHByaW50ZWQgY292ZXJzIHRoYXQgYnJhY2tldCB0aGUgd2hv
bGUKYWdncmVnYXRlLgoKCjguIFRSQU5TTEFUSU9OCgpUcmFuc2xhdGlvbiBpcyBjb25zaWRl
cmVkIGEga2luZCBvZiBtb2RpZmljYXRpb24sIHNvIHlvdSBtYXkKZGlzdHJpYnV0ZSB0cmFu
c2xhdGlvbnMgb2YgdGhlIERvY3VtZW50IHVuZGVyIHRoZSB0ZXJtcyBvZiBzZWN0aW9uIDQu
ClJlcGxhY2luZyBJbnZhcmlhbnQgU2VjdGlvbnMgd2l0aCB0cmFuc2xhdGlvbnMgcmVxdWly
ZXMgc3BlY2lhbApwZXJtaXNzaW9uIGZyb20gdGhlaXIgY29weXJpZ2h0IGhvbGRlcnMsIGJ1
dCB5b3UgbWF5IGluY2x1ZGUKdHJhbnNsYXRpb25zIG9mIHNvbWUgb3IgYWxsIEludmFyaWFu
dCBTZWN0aW9ucyBpbiBhZGRpdGlvbiB0byB0aGUKb3JpZ2luYWwgdmVyc2lvbnMgb2YgdGhl
c2UgSW52YXJpYW50IFNlY3Rpb25zLiAgWW91IG1heSBpbmNsdWRlIGEKdHJhbnNsYXRpb24g
b2YgdGhpcyBMaWNlbnNlLCBhbmQgYWxsIHRoZSBsaWNlbnNlIG5vdGljZXMgaW4gdGhlCkRv
Y3VtZW50LCBhbmQgYW55IFdhcnJhbnR5IERpc2NsYWltZXJzLCBwcm92aWRlZCB0aGF0IHlv
dSBhbHNvIGluY2x1ZGUKdGhlIG9yaWdpbmFsIEVuZ2xpc2ggdmVyc2lvbiBvZiB0aGlzIExp
Y2Vuc2UgYW5kIHRoZSBvcmlnaW5hbCB2ZXJzaW9ucwpvZiB0aG9zZSBub3RpY2VzIGFuZCBk
aXNjbGFpbWVycy4gIEluIGNhc2Ugb2YgYSBkaXNhZ3JlZW1lbnQgYmV0d2Vlbgp0aGUgdHJh
bnNsYXRpb24gYW5kIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIG9mIHRoaXMgTGljZW5zZSBvciBh
IG5vdGljZQpvciBkaXNjbGFpbWVyLCB0aGUgb3JpZ2luYWwgdmVyc2lvbiB3aWxsIHByZXZh
aWwuCgpJZiBhIHNlY3Rpb24gaW4gdGhlIERvY3VtZW50IGlzIEVudGl0bGVkICJBY2tub3ds
ZWRnZW1lbnRzIiwKIkRlZGljYXRpb25zIiwgb3IgIkhpc3RvcnkiLCB0aGUgcmVxdWlyZW1l
bnQgKHNlY3Rpb24gNCkgdG8gUHJlc2VydmUKaXRzIFRpdGxlIChzZWN0aW9uIDEpIHdpbGwg
dHlwaWNhbGx5IHJlcXVpcmUgY2hhbmdpbmcgdGhlIGFjdHVhbAp0aXRsZS4KCgo5LiBURVJN
SU5BVElPTgoKWW91IG1heSBub3QgY29weSwgbW9kaWZ5LCBzdWJsaWNlbnNlLCBvciBkaXN0
cmlidXRlIHRoZSBEb2N1bWVudCBleGNlcHQKYXMgZXhwcmVzc2x5IHByb3ZpZGVkIGZvciB1
bmRlciB0aGlzIExpY2Vuc2UuICBBbnkgb3RoZXIgYXR0ZW1wdCB0bwpjb3B5LCBtb2RpZnks
IHN1YmxpY2Vuc2Ugb3IgZGlzdHJpYnV0ZSB0aGUgRG9jdW1lbnQgaXMgdm9pZCwgYW5kIHdp
bGwKYXV0b21hdGljYWxseSB0ZXJtaW5hdGUgeW91ciByaWdodHMgdW5kZXIgdGhpcyBMaWNl
bnNlLiAgSG93ZXZlciwKcGFydGllcyB3aG8gaGF2ZSByZWNlaXZlZCBjb3BpZXMsIG9yIHJp
Z2h0cywgZnJvbSB5b3UgdW5kZXIgdGhpcwpMaWNlbnNlIHdpbGwgbm90IGhhdmUgdGhlaXIg
bGljZW5zZXMgdGVybWluYXRlZCBzbyBsb25nIGFzIHN1Y2gKcGFydGllcyByZW1haW4gaW4g
ZnVsbCBjb21wbGlhbmNlLgoKCjEwLiBGVVRVUkUgUkVWSVNJT05TIE9GIFRISVMgTElDRU5T
RQoKVGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiBtYXkgcHVibGlzaCBuZXcsIHJldmlz
ZWQgdmVyc2lvbnMKb2YgdGhlIEdOVSBGcmVlIERvY3VtZW50YXRpb24gTGljZW5zZSBmcm9t
IHRpbWUgdG8gdGltZS4gIFN1Y2ggbmV3CnZlcnNpb25zIHdpbGwgYmUgc2ltaWxhciBpbiBz
cGlyaXQgdG8gdGhlIHByZXNlbnQgdmVyc2lvbiwgYnV0IG1heQpkaWZmZXIgaW4gZGV0YWls
IHRvIGFkZHJlc3MgbmV3IHByb2JsZW1zIG9yIGNvbmNlcm5zLiAgU2VlCmh0dHBzOi8vd3d3
LmdudS5vcmcvY29weWxlZnQvLgoKRWFjaCB2ZXJzaW9uIG9mIHRoZSBMaWNlbnNlIGlzIGdp
dmVuIGEgZGlzdGluZ3Vpc2hpbmcgdmVyc2lvbiBudW1iZXIuCklmIHRoZSBEb2N1bWVudCBz
cGVjaWZpZXMgdGhhdCBhIHBhcnRpY3VsYXIgbnVtYmVyZWQgdmVyc2lvbiBvZiB0aGlzCkxp
Y2Vuc2UgIm9yIGFueSBsYXRlciB2ZXJzaW9uIiBhcHBsaWVzIHRvIGl0LCB5b3UgaGF2ZSB0
aGUgb3B0aW9uIG9mCmZvbGxvd2luZyB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgZWl0aGVy
IG9mIHRoYXQgc3BlY2lmaWVkIHZlcnNpb24gb3IKb2YgYW55IGxhdGVyIHZlcnNpb24gdGhh
dCBoYXMgYmVlbiBwdWJsaXNoZWQgKG5vdCBhcyBhIGRyYWZ0KSBieSB0aGUKRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLiAgSWYgdGhlIERvY3VtZW50IGRvZXMgbm90IHNwZWNpZnkgYSB2
ZXJzaW9uCm51bWJlciBvZiB0aGlzIExpY2Vuc2UsIHlvdSBtYXkgY2hvb3NlIGFueSB2ZXJz
aW9uIGV2ZXIgcHVibGlzaGVkIChub3QKYXMgYSBkcmFmdCkgYnkgdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbi4KCgpBRERFTkRVTTogSG93IHRvIHVzZSB0aGlzIExpY2Vuc2UgZm9y
IHlvdXIgZG9jdW1lbnRzCgpUbyB1c2UgdGhpcyBMaWNlbnNlIGluIGEgZG9jdW1lbnQgeW91
IGhhdmUgd3JpdHRlbiwgaW5jbHVkZSBhIGNvcHkgb2YKdGhlIExpY2Vuc2UgaW4gdGhlIGRv
Y3VtZW50IGFuZCBwdXQgdGhlIGZvbGxvd2luZyBjb3B5cmlnaHQgYW5kCmxpY2Vuc2Ugbm90
aWNlcyBqdXN0IGFmdGVyIHRoZSB0aXRsZSBwYWdlOgoKICAgIENvcHlyaWdodCAoYykgIFlF
QVIgIFlPVVIgTkFNRS4KICAgIFBlcm1pc3Npb24gaXMgZ3JhbnRlZCB0byBjb3B5LCBkaXN0
cmlidXRlIGFuZC9vciBtb2RpZnkgdGhpcyBkb2N1bWVudAogICAgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgRnJlZSBEb2N1bWVudGF0aW9uIExpY2Vuc2UsIFZlcnNpb24gMS4yCiAg
ICBvciBhbnkgbGF0ZXIgdmVyc2lvbiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsKICAgIHdpdGggbm8gSW52YXJpYW50IFNlY3Rpb25zLCBubyBGcm9udC1D
b3ZlciBUZXh0cywgYW5kIG5vIEJhY2stQ292ZXIgVGV4dHMuCiAgICBBIGNvcHkgb2YgdGhl
IGxpY2Vuc2UgaXMgaW5jbHVkZWQgaW4gdGhlIHNlY3Rpb24gZW50aXRsZWQgIkdOVQogICAg
RnJlZSBEb2N1bWVudGF0aW9uIExpY2Vuc2UiLgoKSWYgeW91IGhhdmUgSW52YXJpYW50IFNl
Y3Rpb25zLCBGcm9udC1Db3ZlciBUZXh0cyBhbmQgQmFjay1Db3ZlciBUZXh0cywKcmVwbGFj
ZSB0aGUgIndpdGguLi5UZXh0cy4iIGxpbmUgd2l0aCB0aGlzOgoKICAgIHdpdGggdGhlIElu
dmFyaWFudCBTZWN0aW9ucyBiZWluZyBMSVNUIFRIRUlSIFRJVExFUywgd2l0aCB0aGUKICAg
IEZyb250LUNvdmVyIFRleHRzIGJlaW5nIExJU1QsIGFuZCB3aXRoIHRoZSBCYWNrLUNvdmVy
IFRleHRzIGJlaW5nIExJU1QuCgpJZiB5b3UgaGF2ZSBJbnZhcmlhbnQgU2VjdGlvbnMgd2l0
aG91dCBDb3ZlciBUZXh0cywgb3Igc29tZSBvdGhlcgpjb21iaW5hdGlvbiBvZiB0aGUgdGhy
ZWUsIG1lcmdlIHRob3NlIHR3byBhbHRlcm5hdGl2ZXMgdG8gc3VpdCB0aGUKc2l0dWF0aW9u
LgoKSWYgeW91ciBkb2N1bWVudCBjb250YWlucyBub250cml2aWFsIGV4YW1wbGVzIG9mIHBy
b2dyYW0gY29kZSwgd2UKcmVjb21tZW5kIHJlbGVhc2luZyB0aGVzZSBleGFtcGxlcyBpbiBw
YXJhbGxlbCB1bmRlciB5b3VyIGNob2ljZSBvZgpmcmVlIHNvZnR3YXJlIGxpY2Vuc2UsIHN1
Y2ggYXMgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLAp0byBwZXJtaXQgdGhlaXIg
dXNlIGluIGZyZWUgc29mdHdhcmUuCgpUaGUgRW5kLgo=
--------------8F2755065F9007E1085D124E
Content-Type: text/plain; charset=UTF-8;
 name="spkguide-v2.rst"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="spkguide-v2.rst"

PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGUgU3BlYWt1cCBVc2VyJ3MgR3VpZGUNCj09
PT09PT09PT09PT09PT09PT09PT09PQ0KDQp8IEZvciBTcGVha3VwIDMuMS4yIGFuZCBMYXRl
cg0KfCBCeSBHZW5lIENvbGxpbnMNCnwgVXBkYXRlZCBieSBvdGhlcnMNCnwgTGFzdCBtb2Rp
ZmllZCBvbiBNb24gSmFuIDIxIDE3OjA4OjIxIDIwMjENCnwgRG9jdW1lbnQgdmVyc2lvbiAx
LjMNCg0KDQpDb3B5cmlnaHQgYW5kIExpY2Vuc2UNCj09PT09PT09PT09PT09PT09PT09PQ0K
DQp8IENvcHlyaWdodCAoYykgMjAwNSAgR2VuZSBDb2xsaW5zDQp8IENvcHlyaWdodCAoYykg
MjAwOCAgU2FtdWVsIFRoaWJhdWx0DQp8IENvcHlyaWdodCAoYykgMjAwOSwgMjAxMCAgdGhl
IFNwZWFrdXAgVGVhbQ0KDQpQZXJtaXNzaW9uIGlzIGdyYW50ZWQgdG8gY29weSwgZGlzdHJp
YnV0ZSBhbmQvb3IgbW9kaWZ5IHRoaXMgZG9jdW1lbnQNCnVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEZyZWUgRG9jdW1lbnRhdGlvbiBMaWNlbnNlLCBWZXJzaW9uIDEuMiBvcg0KYW55
IGxhdGVyIHZlcnNpb24gcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IHdpdGggbm8NCkludmFyaWFudCBTZWN0aW9ucywgbm8gRnJvbnQtQ292ZXIgVGV4dHMs
IGFuZCBubyBCYWNrLUNvdmVyIFRleHRzLiBBDQpjb3B5IG9mIHRoZSBsaWNlbnNlIGlzIGlu
Y2x1ZGVkIGluIHRoZSBzZWN0aW9uIGVudGl0bGVkICJHTlUgRnJlZQ0KRG9jdW1lbnRhdGlv
biBMaWNlbnNlIi4NCg0KDQpDb250ZW50cw0KPT09PT09PT0NCg0KKiBgUHJlZmFjZWBfLg0K
DQoqIGAxLiAgU3RhcnRpbmcgU3BlYWt1cGBfDQoqIGAyLiAgQmFzaWMgb3BlcmF0aW9uYF8N
CiogYDMuICBVc2luZyB0aGUgU3BlYWt1cCBIZWxwIFN5c3RlbWBfDQoqIGA0LiAgS2V5cyBh
bmQgVGhlaXIgQXNzaWduZWQgQ29tbWFuZHNgXw0KKiBgNS4gIFRoZSBTcGVha3VwIFN5cyBT
eXN0ZW1gXw0KKiBgNi4gIENoYW5naW5nIFN5bnRoZXNpemVyc2BfDQoqIGA3LiAgTG9hZGlu
ZyBtb2R1bGVzYF8NCiogYDguICBVc2luZyBTb2Z0d2FyZSBTeW50aGVzaXplcnNgXw0KICAg
ICAtIGA4LjEuIEVzcGVha3VwYF8NCiAgICAgLSBgOC4yLiBTcGVlY2ggRGlzcGF0Y2hlcmBf
DQoqIGA5LiAgVXNpbmcgVGhlIERlY1RhbGsgUEMgQ2FyZGBfDQoqIGAxMC4gIFVzaW5nIEN1
cnNvciBUcmFja2luZ2BfDQoqIGAxMS4gIEN1dCBhbmQgUGFzdGVgXw0KKiBgMTIuICBDaGFu
Z2luZyB0aGUgUHJvbnVuY2lhdGlvbiBvZiBDaGFyYWN0ZXJzYF8NCiogYDEzLiAgTWFwcGlu
ZyBLZXlzYF8NCiogYDE0LiAgSW50ZXJuYXRpb25hbGl6aW5nIFNwZWFrdXBgXw0KICAgICAt
IGAxNC4xLiAgRmlsZXMgVW5kZXIgdGhlIGkxOG4gU3ViZGlyZWN0b3J5YF8uDQogICAgIC0g
YDE0LjIuMS4gIExvYWRpbmcgWW91ciBPd24gTWVzc2FnZXNgXy4NCiAgICAgLSBgMTQuMi4y
LiBDaG9vc2UgYSBsYW5ndWFnZWBfLg0KICAgICAtIGAxNC4zLiAgTm8gU3VwcG9ydCBmb3Ig
Tm9uLVdlc3Rlcm4tRXVyb3BlYW4gTGFuZ3VhZ2VzYF8uDQoqIGAxNS4gIFVzaW5nIFNwZWFr
dXAncyBXaW5kb3dpbmcgQ2FwYWJpbGl0eWBfDQoqIGAxNi4gIFRvb2xzIGZvciBDb250cm9s
bGluZyBTcGVha3VwYF8NCiAgICAgLSBgMTYuMS4gIFNwZWFrdXBjb25mYF8uDQogICAgIC0g
YDE2LjIuICBUYWxrd2l0aGBfDQoNCg0KUHJlZmFjZQ0KPT09PT09PQ0KDQpUaGUgcHVycG9z
ZSBvZiB0aGlzIGRvY3VtZW50IGlzIHRvIGZhbWlsaWFyaXplIHVzZXJzIHdpdGggdGhlIHVz
ZXINCmludGVyZmFjZSB0byBTcGVha3VwLCBhIExpbnV4IFNjcmVlbiBSZWFkZXIuICBJZiB5
b3UgbmVlZCBpbnN0cnVjdGlvbnMNCmZvciBpbnN0YWxsaW5nIG9yIG9idGFpbmluZyBTcGVh
a3VwLCB2aXNpdCB0aGUgd2ViIHNpdGUgYXQNCmh0dHA6Ly9saW51eC1zcGVha3VwLm9yZy8u
ICBTcGVha3VwIGlzIGEgc2V0IG9mIHBhdGNoZXMgdG8gdGhlIHN0YW5kYXJkDQpMaW51eCBr
ZXJuZWwgc291cmNlIHRyZWUuICBJdCBjYW4gYmUgYnVpbHQgYXMgYSBzZXJpZXMgb2YgbW9k
dWxlcywgb3IgYXMNCmEgcGFydCBvZiBhIG1vbm9saXRoaWMga2VybmVsLiAgVGhlc2UgZGV0
YWlscyBhcmUgYmV5b25kIHRoZSBzY29wZSBvZg0KdGhpcyBtYW51YWwsIGJ1dCB0aGUgdXNl
ciBtYXkgbmVlZCB0byBiZSBhd2FyZSBvZiB0aGUgbW9kdWxlDQpjYXBhYmlsaXRpZXMsIGRl
cGVuZGluZyBvbiBob3cgeW91ciBzeXN0ZW0gYWRtaW5pc3RyYXRvciBoYXMgaW5zdGFsbGVk
DQpTcGVha3VwLiAgSWYgU3BlYWt1cCBpcyBidWlsdCBhcyBhIHBhcnQgb2YgYSBtb25vbGl0
aGljIGtlcm5lbCwgYW5kIHRoZQ0KdXNlciBpcyB1c2luZyBhIGhhcmR3YXJlIHN5bnRoZXNp
emVyLCB0aGVuIFNwZWFrdXAgd2lsbCBiZSBhYmxlIHRvDQpwcm92aWRlIHNwZWVjaCBhY2Nl
c3MgZnJvbSB0aGUgdGltZSB0aGUga2VybmVsIGlzIGxvYWRlZCwgdW50aWwgdGhlIHRpbWUN
CnRoZSBzeXN0ZW0gaXMgc2h1dGRvd24uICBUaGlzIG1lYW5zIHRoYXQgaWYgeW91IGhhdmUg
b2J0YWluZWQgTGludXgNCmluc3RhbGxhdGlvbiBtZWRpYSBmb3IgYSBkaXN0cmlidXRpb24g
d2hpY2ggaW5jbHVkZXMgU3BlYWt1cCBhcyBhIHBhcnQNCm9mIGl0cyBrZXJuZWwsIHlvdSB3
aWxsIGJlIGFibGUsIGFzIGEgYmxpbmQgcGVyc29uLCB0byBpbnN0YWxsIExpbnV4DQp3aXRo
IHNwZWVjaCBhY2Nlc3MgdW5haWRlZCBieSBhIHNpZ2h0ZWQgcGVyc29uLiAgQWdhaW4sIHRo
ZXNlIGRldGFpbHMNCmFyZSBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoaXMgbWFudWFsLCBidXQg
dGhlIHVzZXIgc2hvdWxkIGJlIGF3YXJlIG9mDQp0aGVtLiAgU2VlIHRoZSB3ZWIgc2l0ZSBt
ZW50aW9uZWQgYWJvdmUgZm9yIGZ1cnRoZXIgZGV0YWlscy4NCg0KDQoxLiAgU3RhcnRpbmcg
U3BlYWt1cA0KPT09PT09PT09PT09PT09PT09PT0NCg0KSWYgeW91ciBzeXN0ZW0gYWRtaW5p
c3RyYXRvciBoYXMgaW5zdGFsbGVkIFNwZWFrdXAgdG8gd29yayB3aXRoIHlvdXINCnNwZWNp
ZmljIHN5bnRoZXNpemVyIGJ5IGRlZmF1bHQsIHRoZW4gYWxsIHlvdSBuZWVkIHRvIGRvIHRv
IHVzZSBTcGVha3VwDQppcyB0byBib290IHlvdXIgc3lzdGVtLCBhbmQgU3BlYWt1cCBzaG91
bGQgY29tZSB1cCB0YWxraW5nLiAgVGhpcw0KYXNzdW1lcyBvZiBjb3Vyc2UgIHRoYXQgeW91
ciBzeW50aGVzaXplciBpcyBhIHN1cHBvcnRlZCBoYXJkd2FyZQ0Kc3ludGhlc2l6ZXIsIGFu
ZCB0aGF0IGl0IGlzIGVpdGhlciBpbnN0YWxsZWQgaW4gb3IgY29ubmVjdGVkIHRvIHlvdXIN
CnN5c3RlbSwgYW5kIGlzIGlmIG5lY2Vzc2FyeSBwb3dlcmVkIG9uLg0KDQpJdCBpcyBwb3Nz
aWJsZSwgaG93ZXZlciwgdGhhdCBTcGVha3VwIG1heSBoYXZlIGJlZW4gY29tcGlsZWQgaW50
byB0aGUNCmtlcm5lbCB3aXRoIG5vIGRlZmF1bHQgc3ludGhlc2l6ZXIuICBJdCBpcyBldmVu
IHBvc3NpYmxlIHRoYXQgeW91cg0Ka2VybmVsIGhhcyBiZWVuIGNvbXBpbGVkIHdpdGggc3Vw
cG9ydCBmb3Igc29tZSBvZiB0aGUgc3VwcG9ydGVkDQpzeW50aGVzaXplcnMgYW5kIG5vdCBv
dGhlcnMuICBJZiB5b3UgZmluZCB0aGF0IHRoaXMgaXMgdGhlIGNhc2UsIGFuZA0KeW91ciBz
eW50aGVzaXplciBpcyBzdXBwb3J0ZWQgYnV0IG5vdCBhdmFpbGFibGUsIGNvbXBsYWluIHRv
IHRoZSBwZXJzb24NCndobyBjb21waWxlZCBhbmQgaW5zdGFsbGVkIHlvdXIga2VybmVsLiAg
T3IgYmV0dGVyIHlldCwgZ28gdG8gdGhlIHdlYg0Kc2l0ZSwgYW5kIGxlYXJuIGhvdyB0byBw
YXRjaCBTcGVha3VwIGludG8geW91ciBvd24ga2VybmVsIHNvdXJjZSwgYW5kDQpidWlsZCBh
bmQgaW5zdGFsbCB5b3VyIG93biBrZXJuZWwuDQoNCklmIHlvdXIga2VybmVsIGhhcyBiZWVu
IGNvbXBpbGVkIHdpdGggU3BlYWt1cCwgYW5kIGhhcyBubyBkZWZhdWx0DQpzeW50aGVzaXpl
ciBzZXQsIG9yIHlvdSB3b3VsZCBsaWtlIHRvIHVzZSBhIGRpZmZlcmVudCBzeW50aGVzaXpl
ciB0aGFuDQp0aGUgZGVmYXVsdCBvbmUsIHRoZW4geW91IG1heSBpc3N1ZSB0aGUgZm9sbG93
aW5nIGNvbW1hbmQgYXQgdGhlIGJvb3QNCnByb21wdCBvZiB5b3VyIGJvb3QgbG9hZGVyLjo6
DQoNCiAgbGludXggc3BlYWt1cC5zeW50aD1sdGxrDQoNClRoaXMgY29tbWFuZCB3b3VsZCB0
ZWxsIFNwZWFrdXAgdG8gbG9vayBmb3IgYW5kIHVzZSBhIExpdGVUYWxrIG9yDQpEb3VibGVU
YWxrIExUIGF0IGJvb3QgdXAuICBZb3UgbWF5IHJlcGxhY2UgdGhlIGx0bGsgc3ludGhlc2l6
ZXIga2V5d29yZA0Kd2l0aCB0aGUga2V5d29yZCBmb3Igd2hhdGV2ZXIgc3ludGhlc2l6ZXIg
eW91IHdpc2ggdG8gdXNlLiAgVGhlDQpgYHNwZWFrdXAuc3ludGhgYCBwYXJhbWV0ZXIgd2ls
bCBhY2NlcHQgdGhlIGZvbGxvd2luZyBrZXl3b3JkcywgcHJvdmlkZWQNCnRoYXQgc3VwcG9y
dCBmb3IgdGhlIHJlbGF0ZWQgc3ludGhlc2l6ZXJzIGhhcyBiZWVuIGJ1aWx0IGludG8gdGhl
DQprZXJuZWwuDQoNCnwgYWNudHNhIC0tIEFjY2VudCBTQQ0KfCBhY250cGMgLS0gQWNjZW50
IFBDDQp8IGFwb2xsbyAtLSBBcG9sbG8NCnwgYXVkcHRyIC0tIEF1ZGFwdGVyDQp8IGJucyAt
LSBCcmFpbGxlICduIFNwZWFrDQp8IGRlY3RsayAtLSBEZWNUYWxrIEV4cHJlc3MgKG9sZCBh
bmQgbmV3LCBkYjkgc2VyaWFsIG9ubHkpDQp8IGRlY2V4dCAtLSBEZWNUYWxrIChvbGQpIEV4
dGVybmFsDQp8IGR0bGsgLS0gRG91YmxlVGFsayBQQw0KfCBrZXlwYyAtLSBLZXlub3RlIEdv
bGQgUEMNCnwgbHRsayAtLSBEb3VibGVUYWxrIExULCBMaXRlVGFsaywgb3IgZXh0ZXJuYWwg
VHJpcGxldGFsayAoZGI5IHNlcmlhbCBvbmx5KQ0KfCBzcGtvdXQgLS0gU3BlYWsgT3V0DQp8
IHR4cHJ0IC0tIFRyYW5zcG9ydA0KfCBkdW1teSAtLSBQbGFpbiB0ZXh0IHRlcm1pbmFsDQoN
Ci4uIG5vdGU6Og0KDQogICB8IFNwZWFrdXAgZG9lcyAqKk5PVCoqIHN1cHBvcnQgdXNiIGNv
bm5lY3Rpb25zIQ0KICAgfCBTcGVha3VwIGFsc28gZG9lcyAqKk5PVCoqIHN1cHBvcnQgdGhl
IGludGVybmFsIFRyaXBsZXRhbGshDQoNClNwZWFrdXAgZG9lcyBzdXBwb3J0IHR3byBvdGhl
ciBzeW50aGVzaXplcnMsIGJ1dCBiZWNhdXNlIHRoZXkgd29yayBpbg0KY29uanVuY3Rpb24g
d2l0aCBvdGhlciBzb2Z0d2FyZSwgdGhleSBtdXN0IGJlIGxvYWRlZCBhcyBtb2R1bGVzIGFm
dGVyDQp0aGVpciByZWxhdGVkIHNvZnR3YXJlIGlzIGxvYWRlZCwgYW5kIHNvIGFyZSBub3Qg
YXZhaWxhYmxlIGF0IGJvb3QgdXAuDQpUaGVzZSBhcmUgYXMgZm9sbG93czoNCg0KfCBkZWNw
YyAtLSBEZWNUYWxrIFBDIChub3QgYXZhaWxhYmxlIGF0IGJvb3QgdXApDQp8IHNvZnQgLS0g
T25lIG9mIHNldmVyYWwgc29mdHdhcmUgc3ludGhlc2l6ZXJzIChub3QgYXZhaWxhYmxlIGF0
IGJvb3QgdXApDQoNClNlZSB0aGUgc2VjdGlvbnMgb24gbG9hZGluZyBtb2R1bGVzIGFuZCBz
b2Z0d2FyZSBzeW50aGVzaXplcnMgbGF0ZXIgaW4NCnRoaXMgbWFudWFsIGZvciBmdXJ0aGVy
IGRldGFpbHMuICBJdCBzaG91bGQgYmUgbm90ZWQgaGVyZSB0aGF0IHRoZQ0Kc3BlYWt1cC5z
eW50aCBib290IHBhcmFtZXRlciB3aWxsIGhhdmUgbm8gZWZmZWN0IGlmIFNwZWFrdXAgaGFz
IGJlZW4NCmNvbXBpbGVkIGFzIG1vZHVsZXMuICBJbiBvcmRlciBmb3IgU3BlYWt1cCBtb2R1
bGVzIHRvIGJlIGxvYWRlZCBkdXJpbmcNCnRoZSBib290IHByb2Nlc3MsIHN1Y2ggYWN0aW9u
IG11c3QgYmUgY29uZmlndXJlZCBieSB5b3VyIHN5c3RlbQ0KYWRtaW5pc3RyYXRvci4gIFRo
aXMgd2lsbCBtZWFuIHRoYXQgeW91IHdpbGwgaGVhciBzb21lLCBidXQgbm90IGFsbCwgIG9m
DQp0aGUgYm9vdHVwIG1lc3NhZ2VzLg0KDQoNCjIuICBCYXNpYyBvcGVyYXRpb24NCj09PT09
PT09PT09PT09PT09PT0NCg0KT25jZSB5b3UgaGF2ZSBib290ZWQgdGhlIHN5c3RlbSwgYW5k
IGlmIG5lY2Vzc2FyeSwgaGF2ZSBzdXBwbGllZCB0aGUNCnByb3BlciBib290dXAgcGFyYW1l
dGVyIGZvciB5b3VyIHN5bnRoZXNpemVyLCBTcGVha3VwIHdpbGwgYmVnaW4NCnRhbGtpbmcg
YXMgc29vbiBhcyB0aGUga2VybmVsIGlzIGxvYWRlZC4gIEluIGZhY3QsIGl0IHdpbGwgdGFs
ayBhIGxvdCENCkl0IHdpbGwgc3BlYWsgYWxsIHRoZSBib290IHVwIG1lc3NhZ2VzIHRoYXQg
dGhlIGtlcm5lbCBwcmludHMgb24gdGhlDQpzY3JlZW4gZHVyaW5nIHRoZSBib290IHByb2Nl
c3MuICBUaGlzIGlzIGJlY2F1c2UgU3BlYWt1cCBpcyBub3QgYQ0Kc2VwYXJhdGUgc2NyZWVu
IHJlYWRlciwgYnV0IGlzIGFjdHVhbGx5IGJ1aWx0IGludG8gdGhlIG9wZXJhdGluZw0Kc3lz
dGVtLiAgU2luY2UgYWxtb3N0IGFsbCBjb25zb2xlIGFwcGxpY2F0aW9ucyBtdXN0IHByaW50
IHRleHQgb24gdGhlDQpzY3JlZW4gdXNpbmcgdGhlIGtlcm5lbCwgYW5kIG11c3QgZ2V0IHRo
ZWlyIGtleWJvYXJkIGlucHV0IHRocm91Z2ggdGhlDQprZXJuZWwsIHRoZXkgYXJlIGF1dG9t
YXRpY2FsbHkgaGFuZGxlZCBwcm9wZXJseSBieSBTcGVha3VwLiAgVGhlcmUgYXJlIGENCmZl
dyBleGNlcHRpb25zLCBidXQgd2UnbGwgY29tZSB0byB0aG9zZSBsYXRlci4NCg0KLi4gbm90
ZTo6DQoNCiAgSW4gdGhpcyBndWlkZSBJIHdpbGwgcmVmZXIgdG8gdGhlIG51bWVyaWMga2V5
cGFkIGFzIHRoZSBrZXlwYWQuDQogIFRoaXMgaXMgZG9uZSBiZWNhdXNlIHRoZSBzcGVha3Vw
bWFwLm1hcCBmaWxlIHJlZmVycmVkIHRvIGxhdGVyIGluIHRoaXMNCiAgbWFudWFsIHVzZXMg
dGhlIHRlcm0ga2V5cGFkIGluc3RlYWQgb2YgbnVtZXJpYyBrZXlwYWQuICBBbHNvIEknbSBs
YXp5DQogIGFuZCB3b3VsZCByYXRoZXIgb25seSB0eXBlIG9uZSB3b3JkLiAgU28ga2V5cGFk
IGl0IGlzLiAgR290IGl0PyAgR29vZC4NCg0KTW9zdCBvZiB0aGUgU3BlYWt1cCByZXZpZXcg
a2V5cyBhcmUgbG9jYXRlZCBvbiB0aGUga2V5cGFkIGF0IHRoZSBmYXINCnJpZ2h0IG9mIHRo
ZSBrZXlib2FyZC4gIFRoZSBudW1sb2NrIGtleSBzaG91bGQgYmUgb2ZmLCBpbiBvcmRlciBm
b3IgdGhlc2UNCnRvIHdvcmsuICBJZiB5b3UgdG9nZ2xlIHRoZSBudW1sb2NrIG9uLCB0aGUg
a2V5cGFkIHdpbGwgcHJvZHVjZSBudW1iZXJzLA0Kd2hpY2ggaXMgZXhhY3RseSB3aGF0IHlv
dSB3YW50IGZvciBzcHJlYWRzaGVldHMgYW5kIHN1Y2guICBGb3IgdGhlDQpwdXJwb3NlcyBv
ZiB0aGlzIGd1aWRlLCB5b3Ugc2hvdWxkIGhhdmUgdGhlIG51bWxvY2sgdHVybmVkIG9mZiwg
d2hpY2ggaXMNCml0cyBkZWZhdWx0IHN0YXRlIGF0IGJvb3R1cC4NCg0KWW91IHByb2JhYmx5
IHdvbid0IHdhbnQgdG8gbGlzdGVuIHRvIGFsbCB0aGUgYm9vdHVwIG1lc3NhZ2VzIGV2ZXJ5
IHRpbWUNCnlvdSBzdGFydCB5b3VyIHN5c3RlbSwgdGhvdWdoIGl0J3MgYSBnb29kIGlkZWEg
dG8gbGlzdGVuIHRvIHRoZW0gYXQNCmxlYXN0IG9uY2UsIGp1c3Qgc28geW91J2xsIGtub3cg
d2hhdCBraW5kIG9mIGluZm9ybWF0aW9uIGlzIGF2YWlsYWJsZSB0bw0KeW91IGR1cmluZyB0
aGUgYm9vdCBwcm9jZXNzLiAgWW91IGNhbiBhbHdheXMgcmV2aWV3IHRoZXNlIG1lc3NhZ2Vz
IGFmdGVyDQpib290dXAgd2l0aCB0aGUgY29tbWFuZDo6DQoNCiAgZG1lc2cgfCBtb3JlDQoN
CkluIG9yZGVyIHRvIHNwZWVkIHRoZSBib290IHByb2Nlc3MsIGFuZCB0byBzaWxlbmNlIHRo
ZSBzcGVha2luZyBvZiB0aGUNCmJvb3R1cCBtZXNzYWdlcywganVzdCBwcmVzcyB0aGUga2V5
cGFkIGVudGVyIGtleS4gIFRoaXMga2V5IGlzIGxvY2F0ZWQNCmluIHRoZSBib3R0b20gcmln
aHQgY29ybmVyIG9mIHRoZSBrZXlwYWQuICBTcGVha3VwIHdpbGwgc2h1dCB1cCBhbmQgc3Rh
eQ0KdGhhdCB3YXksIHVudGlsIHlvdSBwcmVzcyBhbm90aGVyIGtleS4NCg0KWW91IGNhbiBj
aGVjayB0byBzZWUgaWYgdGhlIGJvb3QgcHJvY2VzcyBoYXMgY29tcGxldGVkIGJ5IHByZXNz
aW5nIHRoZSA4DQprZXkgb24gdGhlIGtleXBhZCwgd2hpY2ggcmVhZHMgdGhlIGN1cnJlbnQg
bGluZS4gIFRoaXMgYWxzbyBoYXMgdGhlDQplZmZlY3Qgb2Ygc3RhcnRpbmcgU3BlYWt1cCB0
YWxraW5nIGFnYWluLCBzbyB5b3UgY2FuIHByZXNzIGtleXBhZCBlbnRlcg0KdG8gc2lsZW5j
ZSBpdCBhZ2FpbiBpZiB0aGUgYm9vdCBwcm9jZXNzIGhhcyBub3QgY29tcGxldGVkLg0KDQpX
aGVuIHRoZSBib290IHByb2Nlc3MgaXMgY29tcGxldGUsIHlvdSB3aWxsIGFycml2ZSBhdCBh
ICJsb2dpbiIgcHJvbXB0Lg0KQXQgdGhpcyBwb2ludCwgeW91J2xsIG5lZWQgdG8gdHlwZSBp
biB5b3VyIHVzZXIgaWQgYW5kIHBhc3N3b3JkLCBhcw0KcHJvdmlkZWQgYnkgeW91ciBzeXN0
ZW0gYWRtaW5pc3RyYXRvci4gIFlvdSB3aWxsIGhlYXIgU3BlYWt1cCBzcGVhayB0aGUNCmxl
dHRlcnMgb2YgeW91ciB1c2VyIGlkIGFzIHlvdSB0eXBlIGl0LCBidXQgbm90IHRoZSBwYXNz
d29yZC4gIFRoaXMgaXMNCmJlY2F1c2UgdGhlIHBhc3N3b3JkIGlzIG5vdCBkaXNwbGF5ZWQg
b24gdGhlIHNjcmVlbiBmb3Igc2VjdXJpdHkNCnJlYXNvbnMuICBUaGlzIGhhcyBub3RoaW5n
IHRvIGRvIHdpdGggU3BlYWt1cCwgaXQncyBhIExpbnV4IHNlY3VyaXR5DQpmZWF0dXJlLg0K
DQpPbmNlIHlvdSd2ZSBsb2dnZWQgaW4sIHlvdSBjYW4gcnVuIGFueSBMaW51eCBjb21tYW5k
IG9yIHByb2dyYW0gd2hpY2ggaXMNCmFsbG93ZWQgYnkgeW91ciB1c2VyIGlkLiAgTm9ybWFs
IHVzZXJzIHdpbGwgbm90IGJlIGFibGUgdG8gcnVuIHByb2dyYW1zDQp3aGljaCByZXF1aXJl
IHJvb3QgcHJpdmlsZWdlcy4NCg0KV2hlbiB5b3UgYXJlIHJ1bm5pbmcgYSBwcm9ncmFtIG9y
IGNvbW1hbmQsIFNwZWFrdXAgd2lsbCBhdXRvbWF0aWNhbGx5DQpzcGVhayBuZXcgdGV4dCBh
cyBpdCBhcnJpdmVzIG9uIHRoZSBzY3JlZW4uICBZb3UgY2FuIGF0IGFueSB0aW1lIHNpbGVu
Y2UNCnRoZSBzcGVlY2ggd2l0aCBrZXlwYWQgZW50ZXIsIG9yIHVzZSBhbnkgb2YgdGhlIFNw
ZWFrdXAgcmV2aWV3IGtleXMuDQoNCkhlcmUgYXJlIHNvbWUgYmFzaWMgU3BlYWt1cCByZXZp
ZXcga2V5cywgYW5kIGEgc2hvcnQgZGVzY3JpcHRpb24gb2Ygd2hhdA0KdGhleSBkby4NCg0K
fCBrZXlwYWQgMSAtLSByZWFkIHByZXZpb3VzIGNoYXJhY3Rlcg0KfCBrZXlwYWQgMiAtLSBy
ZWFkIGN1cnJlbnQgY2hhcmFjdGVyIChwcmVzc2luZyBrZXlwYWQgMiB0d2ljZSByYXBpZGx5
IHdpbGwgc3BlYWsNCgkgICAgICB0aGUgY3VycmVudCBjaGFyYWN0ZXIgcGhvbmV0aWNhbGx5
KQ0KfCBrZXlwYWQgMyAtLSByZWFkIG5leHQgY2hhcmFjdGVyDQp8IGtleXBhZCA0IC0tIHJl
YWQgcHJldmlvdXMgd29yZA0KfCBrZXlwYWQgNSAtLSByZWFkIGN1cnJlbnQgd29yZCAocHJl
c3MgdHdpY2UgcmFwaWRseSB0byBzcGVsbCB0aGUgY3VycmVudCB3b3JkKQ0KfCBrZXlwYWQg
NiAtLSByZWFkIG5leHQgd29yZA0KfCBrZXlwYWQgNyAtLSByZWFkIHByZXZpb3VzIGxpbmUN
Cnwga2V5cGFkIDggLS0gcmVhZCBjdXJyZW50IGxpbmUgKHByZXNzIHR3aWNlIHJhcGlkbHkg
dG8gaGVhciBob3cgbXVjaCB0aGUNCgkgICAgICB0ZXh0IG9uIHRoZSBjdXJyZW50IGxpbmUg
aXMgaW5kZW50ZWQpDQp8IGtleXBhZCA5IC0tIHJlYWQgbmV4dCBsaW5lDQp8IGtleXBhZCBw
ZXJpb2QgLS0gc3BlYWsgY3VycmVudCBjdXJzb3IgcG9zaXRpb24gYW5kIGFubm91bmNlIGN1
cnJlbnQNCgkJICAgdmlydHVhbCBjb25zb2xlDQoNCkl0J3MgYWxzbyB3b3J0aCBub3Rpbmcg
dGhhdCB0aGUgaW5zZXJ0IGtleSBvbiB0aGUga2V5cGFkIGlzIG1hcHBlZA0KYXMgdGhlIHNw
ZWFrdXAga2V5LiAgSW5zdGVhZCBvZiBwcmVzc2luZyBhbmQgcmVsZWFzaW5nIHRoaXMga2V5
LCBhcyB5b3UNCmRvIHVuZGVyIERPUyBvciBXaW5kb3dzLCB5b3UgaG9sZCBpdCBsaWtlIGEg
c2hpZnQga2V5LCBhbmQgcHJlc3Mgb3RoZXINCmtleXMgaW4gY29tYmluYXRpb24gd2l0aCBp
dC4gIEZvciBleGFtcGxlLCByZXBlYXRlZGx5IGhvbGRpbmcga2V5cGFkDQppbnNlcnQsIGZy
b20gbm93IG9uIGNhbGxlZCBzcGVha3VwLCBhbmQga2V5cGFkIGVudGVyIHdpbGwgdG9nZ2xl
IHRoZQ0Kc3BlYWtpbmcgb2YgbmV3IHRleHQgb24gdGhlIHNjcmVlbiBvbiBhbmQgb2ZmLiAg
VGhpcyBpcyBub3QgdGhlIHNhbWUgYXMNCmp1c3QgcHJlc3Npbmcga2V5cGFkIGVudGVyIGJ5
IGl0c2VsZiwgd2hpY2gganVzdCBzaWxlbmNlcyB0aGUgc3BlZWNoDQp1bnRpbCB5b3UgaGl0
IGFub3RoZXIga2V5LiAgV2hlbiB5b3UgaGl0IHNwZWFrdXAgcGx1cyBrZXlwYWQgZW50ZXIs
DQpTcGVha3VwIHdpbGwgc2F5LCAiWW91IHR1cm5lZCBtZSBvZmYuIiwgb3IgIkhleSwgdGhh
dCdzIGJldHRlci4iICBXaGVuDQpTcGVha3VwIGlzIHR1cm5lZCBvZmYsIG5vIG5ldyB0ZXh0
IG9uIHRoZSBzY3JlZW4gd2lsbCBiZSBzcG9rZW4uICBZb3UNCmNhbiBzdGlsbCB1c2UgdGhl
IHJlYWRpbmcgY29udHJvbHMgdG8gcmV2aWV3IHRoZSBzY3JlZW4gaG93ZXZlci4NCg0KDQoz
LiAgVXNpbmcgdGhlIFNwZWFrdXAgSGVscCBTeXN0ZW0NCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KDQpJbiBvcmRlciB0byBlbnRlciB0aGUgU3BlYWt1cCBoZWxwIHN5
c3RlbSwgcHJlc3MgYW5kIGhvbGQgdGhlIHNwZWFrdXANCmtleSAocmVtZW1iZXIgdGhhdCB0
aGlzIGlzIHRoZSBrZXlwYWQgaW5zZXJ0IGtleSksIGFuZCBwcmVzcyB0aGUgYGYxYCBrZXku
DQpZb3Ugd2lsbCBoZWFyIHRoZSBtZXNzYWdlOg0KDQoiUHJlc3Mgc3BhY2UgdG8gbGVhdmUg
aGVscCwgY3Vyc29yIHVwIG9yIGRvd24gdG8gc2Nyb2xsLCBvciBhIGxldHRlciB0bw0KZ28g
dG8gY29tbWFuZHMgaW4gbGlzdC4iDQoNCldoZW4geW91IHByZXNzIHRoZSBgc3BhY2ViYXJg
IHRvIGxlYXZlIHRoZSBoZWxwIHN5c3RlbSwgeW91IHdpbGwgaGVhcjoNCg0KIkxlYXZpbmcg
aGVscC4iDQoNCldoaWxlIHlvdSBhcmUgaW4gdGhlIFNwZWFrdXAgaGVscCBzeXN0ZW0sIHlv
dSBjYW4gc2Nyb2xsIHVwIG9yIGRvd24NCnRocm91Z2ggdGhlIGxpc3Qgb2YgYXZhaWxhYmxl
IGNvbW1hbmRzIHVzaW5nIHRoZSBjdXJzb3Iga2V5cy4gIFRoZSBsaXN0DQpvZiBjb21tYW5k
cyBpcyBhcnJhbmdlZCBpbiBhbHBoYWJldGljYWwgb3JkZXIuICBJZiB5b3Ugd2lzaCB0byBq
dW1wIHRvDQpjb21tYW5kcyBpbiBhIHNwZWNpZmljIHBhcnQgb2YgdGhlIGFscGhhYmV0LCB5
b3UgbWF5IHByZXNzIHRoZSBsZXR0ZXIgb2YNCnRoZSBhbHBoYWJldCB5b3Ugd2lzaCB0byBq
dW1wIHRvLg0KDQpZb3UgY2FuIGFsc28ganVzdCBleHBsb3JlIGJ5IHR5cGluZyBrZXlib2Fy
ZCBrZXlzLiAgUHJlc3Npbmcga2V5cyB3aWxsDQpjYXVzZSBTcGVha3VwIHRvIHNwZWFrIHRo
ZSBjb21tYW5kIGFzc29jaWF0ZWQgd2l0aCB0aGF0IGtleS4gIEZvcg0KZXhhbXBsZSwgaWYg
eW91IHByZXNzIHRoZSBrZXlwYWQgOCBrZXksIHlvdSB3aWxsIGhlYXI6DQoNCiJLZXlwYWQg
OCBpcyBsaW5lLCBzYXkgY3VycmVudC4iDQoNCllvdSdsbCBub3RpY2UgdGhhdCBzb21lIGNv
bW1hbmRzIGRvIG5vdCBoYXZlIGtleXMgYXNzaWduZWQgdG8gdGhlbS4NClRoaXMgaXMgYmVj
YXVzZSB0aGV5IGFyZSB2ZXJ5IGluZnJlcXVlbnRseSB1c2VkIGNvbW1hbmRzLCBhbmQgYXJl
IGFsc28NCmFjY2Vzc2libGUgdGhyb3VnaCB0aGUgc3lzIHN5c3RlbS4gIFdlJ2xsIGRpc2N1
c3MgdGhlIHN5cyBzeXN0ZW0gbGF0ZXINCmluIHRoaXMgbWFudWFsLg0KDQpZb3UnbGwgYWxz
byBub3RpY2UgdGhhdCBzb21lIGNvbW1hbmRzIGhhdmUgdHdvIGtleXMgYXNzaWduZWQgdG8g
dGhlbS4NClRoaXMgaXMgYmVjYXVzZSBTcGVha3VwIGhhcyBhIGJ1aWx0IGluIHNldCBvZiBh
bHRlcm5hdGl2ZSBrZXkgYmluZGluZ3MNCmZvciBsYXB0b3AgdXNlcnMuICBUaGUgYWx0ZXJu
YXRlIHNwZWFrdXAga2V5IGlzIHRoZSBgY2FwcyBsb2NrYCBrZXkuICBZb3UNCmNhbiBwcmVz
cyBhbmQgaG9sZCB0aGUgYGNhcHMgbG9ja2Aga2V5LCB3aGlsZSBwcmVzc2luZyBhbiBhbHRl
cm5hdGUNCnNwZWFrdXAgY29tbWFuZCBrZXkgdG8gYWN0aXZhdGUgdGhlIGNvbW1hbmQuICBP
biBtb3N0IGxhcHRvcHMsIHRoZQ0KbnVtZXJpYyBrZXlwYWQgaXMgZGVmaW5lZCBhcyB0aGUg
a2V5cyBpbiB0aGUgYGogayBsYCBhcmVhIG9mIHRoZSBrZXlib2FyZC4NCg0KVGhlcmUgaXMg
dXN1YWxseSBhIGZ1bmN0aW9uIGtleSB3aGljaCB0dXJucyB0aGlzIGtleXBhZCBmdW5jdGlv
biBvbiBhbmQNCm9mZiwgYW5kIHNvbWUgb3RoZXIga2V5IHdoaWNoIGNvbnRyb2xzIHRoZSBu
dW1sb2NrIHN0YXRlLiAgVG9nZ2xpbmcgdGhlDQprZXlwYWQgZnVuY3Rpb25hbGl0eSBvbiBh
bmQgb2ZmIGNhbiBiZWNvbWUgYSByb3lhbCBwYWluLiAgU28sIFNwZWFrdXANCmdpdmVzIHlv
dSBhIHNpbXBsZSB3YXkgdG8gZ2V0IGF0IGFuIGFsdGVybmF0aXZlIHNldCBvZiBrZXkgbWFw
cGluZ3MgZm9yDQp5b3VyIGxhcHRvcC4gIFRoZXNlIGFyZSBhbHNvIGF2YWlsYWJsZSBieSBk
ZWZhdWx0IG9uIGRlc2t0b3Agc3lzdGVtcywNCmJlY2F1c2UgU3BlYWt1cCBkb2VzIG5vdCBr
bm93IHdoZXRoZXIgaXQgaXMgcnVubmluZyBvbiBhIGRlc2t0b3Agb3INCmxhcHRvcC4gIFNv
IHlvdSBtYXkgY2hvb3NlIHdoaWNoIHNldCBvZiBTcGVha3VwIGtleXMgdG8gdXNlLiAgU29t
ZQ0Kc3lzdGVtIGFkbWluaXN0cmF0b3JzIG1heSBoYXZlIGNob3NlbiB0byBjb21waWxlIFNw
ZWFrdXAgZm9yIGEgZGVza3RvcA0Kc3lzdGVtIHdpdGhvdXQgdGhpcyBzZXQgb2YgYWx0ZXJu
YXRlIGtleSBiaW5kaW5ncywgYnV0IHRoZXNlIGRldGFpbHMgYXJlDQpiZXlvbmQgdGhlIHNj
b3BlIG9mIHRoaXMgbWFudWFsLiAgVG8gdXNlIHRoZSBgY2FwcyBsb2NrYCBmb3IgaXRzIG5v
cm1hbA0KcHVycG9zZSwgaG9sZCB0aGUgc2hpZnQga2V5IHdoaWxlIHRvZ2dsaW5nIHRoZSBg
Y2FwcyBsb2NrYCBvbiBhbmQgb2ZmLg0KDQouLiBub3RlOjoNCg0KICBIb2xkaW5nIHRoZSBg
Y2FwcyBsb2NrYCBrZXkgYW5kIHByZXNzaW5nIHRoZSBgemAga2V5IHdpbGwgdG9nZ2xlIHRo
ZQ0KICBhbHRlcm5hdGUgYGogayBsYCBrZXlwYWQgb24gYW5kIG9mZi4NCg0KDQo0LiAgS2V5
cyBhbmQgVGhlaXIgQXNzaWduZWQgQ29tbWFuZHMNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KDQpJbiB0aGlzIHNlY3Rpb24sIHdlJ2xsIGdvIHRocm91Z2ggYSBs
aXN0IG9mIGFsbCB0aGUgc3BlYWt1cCBrZXlzIGFuZA0KY29tbWFuZHMuICBZb3UgY2FuIGFs
c28gZ2V0IGEgbGlzdCBvZiBjb21tYW5kcyBhbmQgYXNzaWduZWQga2V5cyBmcm9tDQp0aGUg
aGVscCBzeXN0ZW0uDQoNClRoZSBmb2xsb3dpbmcgbGlzdCB3YXMgdGFrZW4gZnJvbSB0aGUg
YGBzcGVha3VwbWFwLm1hcGBgIGZpbGUuICBLZXkNCmFzc2lnbm1lbnRzIGFyZSBvbiB0aGUg
bGVmdCBvZiB0aGUgZXF1YWwgc2lnbiwgYW5kIHRoZSBhc3NvY2lhdGVkDQpTcGVha3VwIGNv
bW1hbmRzIGFyZSBvbiB0aGUgcmlnaHQuICBUaGUgZGVzaWduYXRpb24gInNwayIgbWVhbnMg
dG8gcHJlc3MNCmFuZCBob2xkIHRoZSBzcGVha3VwIGtleSwgYS5rLmEuIGtleXBhZCBpbnNl
cnQsIGEuay5hLiBgY2FwcyBsb2NrYCwgd2hpbGUNCnByZXNzaW5nIHRoZSBvdGhlciBzcGVj
aWZpZWQga2V5Lg0KDQp8IHNwayBrZXlfZjkgPSBwdW5jX2xldmVsX2RlYw0KfCBzcGsga2V5
X2YxMCA9IHB1bmNfbGV2ZWxfaW5jDQp8IHNwayBrZXlfZjExID0gcmVhZGluZ19wdW5jX2Rl
Yw0KfCBzcGsga2V5X2YxMiA9IHJlYWRpbmdfcHVuY19pbmMNCnwgc3BrIGtleV8xID0gdm9s
X2RlYw0KfCBzcGsga2V5XzIgPSAgdm9sX2luYw0KfCBzcGsga2V5XzMgPSBwaXRjaF9kZWMN
Cnwgc3BrIGtleV80ID0gcGl0Y2hfaW5jDQp8IHNwayBrZXlfNSA9IHJhdGVfZGVjDQp8IHNw
ayBrZXlfNiA9IHJhdGVfaW5jDQp8IGtleV9rcGFzdGVyaXNrID0gdG9nZ2xlX2N1cnNvcmlu
Zw0KfCBzcGsga2V5X2twYXN0ZXJpc2sgPSBzcGVha3VwX2dvdG8NCnwgc3BrIGtleV9mMSA9
IHNwZWFrdXBfaGVscA0KfCBzcGsga2V5X2YyID0gc2V0X3dpbg0KfCBzcGsga2V5X2YzID0g
Y2xlYXJfd2luDQp8IHNwayBrZXlfZjQgPSBlbmFibGVfd2luDQp8IHNwayBrZXlfZjUgPSBl
ZGl0X3NvbWUNCnwgc3BrIGtleV9mNiA9IGVkaXRfbW9zdA0KfCBzcGsga2V5X2Y3ID0gZWRp
dF9kZWxpbQ0KfCBzcGsga2V5X2Y4ID0gZWRpdF9yZXBlYXQNCnwgc2hpZnQgc3BrIGtleV9m
OSA9IGVkaXRfZXhudW0NCnwgIGtleV9rcDcgPSBzYXlfcHJldl9saW5lDQp8IHNwayBrZXlf
a3A3ID0gbGVmdF9lZGdlDQp8ICBrZXlfa3A4ID0gc2F5X2xpbmUNCnwgZG91YmxlICBrZXlf
a3A4ID0gc2F5X2xpbmVfaW5kZW50DQp8IHNwayBrZXlfa3A4ID0gc2F5X2Zyb21fdG9wDQp8
ICBrZXlfa3A5ID0gc2F5X25leHRfbGluZQ0KfCBzcGsgIGtleV9rcDkgPSB0b3BfZWRnZQ0K
fCAga2V5X2twbWludXMgPSBzcGVha3VwX3BhcmtlZA0KfCBzcGsga2V5X2twbWludXMgPSBz
YXlfY2hhcl9udW0NCnwgIGtleV9rcDQgPSBzYXlfcHJldl93b3JkDQp8IHNwayBrZXlfa3A0
ID0gc2F5X2Zyb21fbGVmdA0KfCAga2V5X2twNSA9IHNheV93b3JkDQp8IGRvdWJsZSBrZXlf
a3A1ID0gc3BlbGxfd29yZA0KfCBzcGsga2V5X2twNSA9IHNwZWxsX3Bob25ldGljDQp8ICBr
ZXlfa3A2ID0gc2F5X25leHRfd29yZA0KfCBzcGsga2V5X2twNiA9IHNheV90b19yaWdodA0K
fCAga2V5X2twcGx1cyA9IHNheV9zY3JlZW4NCnwgc3BrIGtleV9rcHBsdXMgPSBzYXlfd2lu
DQp8ICBrZXlfa3AxID0gc2F5X3ByZXZfY2hhcg0KfCBzcGsga2V5X2twMSA9IHJpZ2h0X2Vk
Z2UNCnwgIGtleV9rcDIgPSBzYXlfY2hhcg0KfCBzcGsga2V5X2twMiA9IHNheV90b19ib3R0
b20NCnwgZG91YmxlIGtleV9rcDIgPSBzYXlfcGhvbmV0aWNfY2hhcg0KfCAga2V5X2twMyA9
IHNheV9uZXh0X2NoYXINCnwgc3BrICBrZXlfa3AzID0gYm90dG9tX2VkZ2UNCnwgIGtleV9r
cDAgPSBzcGtfa2V5DQp8ICBrZXlfa3Bkb3QgPSBzYXlfcG9zaXRpb24NCnwgc3BrIGtleV9r
cGRvdCA9IHNheV9hdHRyaWJ1dGVzDQp8IGtleV9rcGVudGVyID0gc3BlYWt1cF9xdWlldA0K
fCBzcGsga2V5X2twZW50ZXIgPSBzcGVha3VwX29mZg0KfCBrZXlfc3lzcnEgPSBzcGVlY2hf
a2lsbA0KfCAga2V5X2twc2xhc2ggPSBzcGVha3VwX2N1dA0KfCBzcGsga2V5X2twc2xhc2gg
PSBzcGVha3VwX3Bhc3RlDQp8IHNwayBrZXlfcGFnZXVwID0gc2F5X2ZpcnN0X2NoYXINCnwg
c3BrIGtleV9wYWdlZG93biA9IHNheV9sYXN0X2NoYXINCnwga2V5X2NhcHNsb2NrID0gc3Br
X2tleQ0KfCAgc3BrIGtleV96ID0gc3BrX2xvY2sNCnwga2V5X2xlZnRtZXRhID0gc3BrX2tl
eQ0KfCBjdHJsIHNwayBrZXlfMCA9IHNwZWFrdXBfZ290bw0KfCBzcGsga2V5X3UgPSBzYXlf
cHJldl9saW5lDQp8IHNwayBrZXlfaSA9IHNheV9saW5lDQp8IGRvdWJsZSBzcGsga2V5X2kg
PSBzYXlfbGluZV9pbmRlbnQNCnwgc3BrIGtleV9vID0gc2F5X25leHRfbGluZQ0KfCBzcGsg
a2V5X21pbnVzID0gc3BlYWt1cF9wYXJrZWQNCnwgc2hpZnQgc3BrIGtleV9taW51cyA9IHNh
eV9jaGFyX251bQ0KfCBzcGsga2V5X2ogPSBzYXlfcHJldl93b3JkDQp8IHNwayBrZXlfayA9
IHNheV93b3JkDQp8IGRvdWJsZSBzcGsga2V5X2sgPSBzcGVsbF93b3JkDQp8IHNwayBrZXlf
bCA9IHNheV9uZXh0X3dvcmQNCnwgc3BrIGtleV9tID0gc2F5X3ByZXZfY2hhcg0KfCBzcGsg
a2V5X2NvbW1hID0gc2F5X2NoYXINCnwgZG91YmxlIHNwayBrZXlfY29tbWEgPSBzYXlfcGhv
bmV0aWNfY2hhcg0KfCBzcGsga2V5X2RvdCA9IHNheV9uZXh0X2NoYXINCnwgc3BrIGtleV9u
ID0gc2F5X3Bvc2l0aW9uDQp8ICBjdHJsIHNwayBrZXlfbSA9IGxlZnRfZWRnZQ0KfCAgY3Ry
bCBzcGsga2V5X3kgPSB0b3BfZWRnZQ0KfCAgY3RybCBzcGsga2V5X2RvdCA9IHJpZ2h0X2Vk
Z2UNCnwgY3RybCBzcGsga2V5X3AgPSBib3R0b21fZWRnZQ0KfCBzcGsga2V5X2Fwb3N0cm9w
aGUgPSBzYXlfc2NyZWVuDQp8IHNwayBrZXlfaCA9IHNheV9mcm9tX2xlZnQNCnwgc3BrIGtl
eV95ID0gc2F5X2Zyb21fdG9wDQp8IHNwayBrZXlfc2VtaWNvbG9uID0gc2F5X3RvX3JpZ2h0
DQp8IHNwayBrZXlfcCA9IHNheV90b19ib3R0b20NCnwgc3BrIGtleV9zbGFzaCA9IHNheV9h
dHRyaWJ1dGVzDQp8ICBzcGsga2V5X2VudGVyID0gc3BlYWt1cF9xdWlldA0KfCAgY3RybCAg
c3BrIGtleV9lbnRlciA9IHNwZWFrdXBfb2ZmDQp8ICBzcGsga2V5XzkgPSBzcGVha3VwX2N1
dA0KfCBzcGsga2V5XzggPSBzcGVha3VwX3Bhc3RlDQp8IHNoaWZ0IHNwayBrZXlfbSA9IHNh
eV9maXJzdF9jaGFyDQp8ICBjdHJsIHNwayBrZXlfc2VtaWNvbG9uID0gc2F5X2xhc3RfY2hh
cg0KfCBzcGsga2V5X3IgPSByZWFkX2FsbF9kb2MNCg0KDQo1LiAgVGhlIFNwZWFrdXAgU3lz
IFN5c3RlbQ0KPT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KVGhlIFNwZWFrdXAgc2Ny
ZWVuIHJlYWRlciBhbHNvIGNyZWF0ZXMgYSBzcGVha3VwIHN1YmRpcmVjdG9yeSBhcyBhIHBh
cnQNCm9mIHRoZSBzeXMgc3lzdGVtLg0KDQpBcyBhIGNvbnZlbmllbmNlLCBydW4gYXMgcm9v
dDo6DQoNCiAgbG4gLXMgL3N5cy9hY2Nlc3NpYmlsaXR5L3NwZWFrdXAgL3NwZWFrdXANCg0K
dG8gZGlyZWN0bHkgYWNjZXNzIHNwZWFrdXAgcGFyYW1ldGVycyBmcm9tIC9zcGVha3VwLg0K
WW91IGNhbiBzZWUgdGhlc2UgZW50cmllcyBieSB0eXBpbmcgdGhlIGNvbW1hbmQ6Og0KDQog
IGxzIC0xIC9zcGVha3VwLyoNCg0KSWYgeW91IGlzc3VlIHRoZSBhYm92ZSBscyBjb21tYW5k
LCB5b3Ugd2lsbCBnZXQgYmFjayBzb21ldGhpbmcgbGlrZQ0KdGhpczo6DQoNCiAgL3NwZWFr
dXAvYXR0cmliX2JsZWVwDQogIC9zcGVha3VwL2JlbGxfcG9zDQogIC9zcGVha3VwL2JsZWVw
X3RpbWUNCiAgL3NwZWFrdXAvYmxlZXBzDQogIC9zcGVha3VwL2N1cnNvcl90aW1lDQogIC9z
cGVha3VwL2RlbGltaXRlcnMNCiAgL3NwZWFrdXAvZXhfbnVtDQogIC9zcGVha3VwL2tleV9l
Y2hvDQogIC9zcGVha3VwL2tleW1hcA0KICAvc3BlYWt1cC9ub19pbnRlcnJ1cHQNCiAgL3Nw
ZWFrdXAvcHVuY19hbGwNCiAgL3NwZWFrdXAvcHVuY19sZXZlbA0KICAvc3BlYWt1cC9wdW5j
X21vc3QNCiAgL3NwZWFrdXAvcHVuY19zb21lDQogIC9zcGVha3VwL3JlYWRpbmdfcHVuYw0K
ICAvc3BlYWt1cC9yZXBlYXRzDQogIC9zcGVha3VwL3NheV9jb250cm9sDQogIC9zcGVha3Vw
L3NheV93b3JkX2N0bA0KICAvc3BlYWt1cC9zaWxlbnQNCiAgL3NwZWFrdXAvc3BlbGxfZGVs
YXkNCiAgL3NwZWFrdXAvc3ludGgNCiAgL3NwZWFrdXAvc3ludGhfZGlyZWN0DQogIC9zcGVh
a3VwL3ZlcnNpb24NCg0KICAvc3BlYWt1cC9pMThuOg0KICBhbm5vdW5jZW1lbnRzDQogIGNo
YXJhY3RlcnMNCiAgY2hhcnRhYg0KICBjb2xvcnMNCiAgY3RsX2tleXMNCiAgZm9ybWF0dGVk
DQogIGZ1bmN0aW9uX25hbWVzDQogIGtleV9uYW1lcw0KICBzdGF0ZXMNCg0KICAvc3BlYWt1
cC9zb2Z0Og0KICBjYXBzX3N0YXJ0DQogIGNhcHNfc3RvcA0KICBkZWxheV90aW1lDQogIGRp
cmVjdA0KICBmcmVxDQogIGZ1bGxfdGltZQ0KICBqaWZmeV9kZWx0YQ0KICBwaXRjaA0KICBp
bmZsZWN0aW9uDQogIHB1bmN0DQogIHJhdGUNCiAgdG9uZQ0KICB0cmlnZ2VyX3RpbWUNCiAg
dm9pY2UNCiAgdm9sDQoNCk5vdGljZSB0aGUgdHdvIHN1YmRpcmVjdG9yaWVzIG9mIGBgL3Nw
ZWFrdXBgYDogYGAvc3BlYWt1cC9pMThuYGAgYW5kDQpgYC9zcGVha3VwL3NvZnRgYC4NClRo
ZSBgaTE4bmAgc3ViZGlyZWN0b3J5IGlzIGRlc2NyaWJlZCBpbiBhIGxhdGVyIHNlY3Rpb24u
DQpUaGUgZmlsZXMgdW5kZXIgYGAvc3BlYWt1cC9zb2Z0YGAgcmVwcmVzZW50IHNldHRpbmdz
IHRoYXQgYXJlIHNwZWNpZmljIHRvIHRoZQ0KZHJpdmVyIGZvciB0aGUgc29mdHdhcmUgc3lu
dGhlc2l6ZXIuICBJZiB5b3UgdXNlIHRoZSBMaXRlVGFsaywgeW91cg0Kc3ludGhlc2l6ZXIt
c3BlY2lmaWMgc2V0dGluZ3Mgd291bGQgYmUgZm91bmQgaW4gYGAvc3BlYWt1cC9sdGxrYGAu
ICBJbiBvdGhlciB3b3JkcywNCmEgc3ViZGlyZWN0b3J5IG5hbWVkIGBgL3NwZWFrdXAvS1dE
YGAgaXMgY3JlYXRlZCB0byBob2xkIHBhcmFtZXRlcnMgc3BlY2lmaWMNCnRvIHRoZSBkZXZp
Y2Ugd2hvc2Uga2V5d29yZCBpcyBLV0QuDQpUaGVzZSBwYXJhbWV0ZXJzIGluY2x1ZGUgdm9s
dW1lLCByYXRlLCBwaXRjaCwgYW5kIG90aGVycy4NCg0KSW4gYWRkaXRpb24gdG8gdXNpbmcg
dGhlIFNwZWFrdXAgaG90IGtleXMgdG8gY2hhbmdlIHN1Y2ggdGhpbmdzIGFzDQp2b2x1bWUs
IHBpdGNoLCBhbmQgcmF0ZSwgeW91IGNhbiBhbHNvIGVjaG8gdmFsdWVzIHRvIHRoZSBhcHBy
b3ByaWF0ZQ0KZW50cnkgaW4gdGhlIGBgL3NwZWFrdXBgYCBkaXJlY3RvcnkuICBUaGlzIGlz
IHZlcnkgdXNlZnVsLCBzaW5jZSBpdA0KbGV0cyB5b3UgY29udHJvbCBTcGVha3VwIHBhcmFt
ZXRlcnMgZnJvbSB3aXRoaW4gYSBzY3JpcHQuICBIb3cgeW91DQp3b3VsZCB3cml0ZSBzdWNo
IHNjcmlwdHMgaXMgc29tZXdoYXQgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIG1hbnVhbCwN
CmJ1dCBJIHdpbGwgaW5jbHVkZSBhIGNvdXBsZSBvZiBzaW1wbGUgZXhhbXBsZXMgaGVyZSB0
byBnaXZlIHlvdSBhDQpnZW5lcmFsIGlkZWEgb2Ygd2hhdCBzdWNoIHNjcmlwdHMgY2FuIGRv
Lg0KDQpTdXBwb3NlIGZvciBleGFtcGxlLCB0aGF0IHlvdSB3YW50ZWQgdG8gY29udHJvbCBi
b3RoIHRoZSBwdW5jdHVhdGlvbg0KbGV2ZWwgYW5kIHRoZSByZWFkaW5nIHB1bmN0dWF0aW9u
IGxldmVsIGF0IHRoZSBzYW1lIHRpbWUuICBGb3INCnNpbXBsaWNpdHksIHdlJ2xsIGNhbGwg
dGhlbSBwdW5jMCwgcHVuYzEsIHB1bmMyLCBhbmQgcHVuYzMuICBUaGUgc2NyaXB0cw0KbWln
aHQgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQouLiBjb2RlLWJsb2NrOjogc2hlbGwN
Cg0KICAjIS9iaW4vYmFzaA0KICAjIHB1bmMwDQogICMgc2V0IHB1bmMgYW5kIHJlYWRpbmcg
cHVuYyBsZXZlbHMgdG8gMA0KICBlY2hvIDAgPi9zcGVha3VwL3B1bmNfbGV2ZWwNCiAgZWNo
byAwID4vc3BlYWt1cC9yZWFkaW5nX3B1bmMNCiAgZWNobyBQdW5jdHVhdGlvbiBsZXZlbCBz
ZXQgdG8gMC4NCg0KICAjIS9iaW4vYmFzaA0KICAjIHB1bmMxDQogICMgc2V0IHB1bmMgYW5k
IHJlYWRpbmcgcHVuYyBsZXZlbHMgdG8gMQ0KICBlY2hvIDEgPi9zcGVha3VwL3B1bmNfbGV2
ZWwNCiAgZWNobyAxID4vc3BlYWt1cC9yZWFkaW5nX3B1bmMNCiAgZWNobyBQdW5jdHVhdGlv
biBsZXZlbCBzZXQgdG8gMS4NCg0KICAjIS9iaW4vYmFzaA0KICAjIHB1bmMyDQogICMgc2V0
IHB1bmMgYW5kIHJlYWRpbmcgcHVuYyBsZXZlbHMgdG8gMg0KICBlY2hvIDIgPi9zcGVha3Vw
L3B1bmNfbGV2ZWwNCiAgZWNobyAyID4vc3BlYWt1cC9yZWFkaW5nX3B1bmMNCiAgZWNobyBQ
dW5jdHVhdGlvbiBsZXZlbCBzZXQgdG8gMi4NCg0KICAjIS9iaW4vYmFzaA0KICAjIHB1bmMz
DQogICMgc2V0IHB1bmMgYW5kIHJlYWRpbmcgcHVuYyBsZXZlbHMgdG8gMw0KICBlY2hvIDMg
Pi9zcGVha3VwL3B1bmNfbGV2ZWwNCiAgZWNobyAzID4vc3BlYWt1cC9yZWFkaW5nX3B1bmMN
CiAgZWNobyBQdW5jdHVhdGlvbiBsZXZlbCBzZXQgdG8gMy4NCg0KSWYgeW91IHdlcmUgdG8g
c3RvcmUgdGhlc2UgZm91ciBzbWFsbCBzY3JpcHRzIGluIGEgZGlyZWN0b3J5IGluIHlvdXIN
CnBhdGgsIHBlcmhhcHMgYGAvdXNyL2xvY2FsL2JpbmBgLCBhbmQgc2V0IHRoZSBwZXJtaXNz
aW9ucyB0byA3NTUgd2l0aCB0aGUNCmBgY2htb2RgYCBjb21tYW5kLCB0aGVuIHlvdSBjb3Vs
ZCBjaGFuZ2UgdGhlIGRlZmF1bHQgcmVhZGluZyBwdW5jIGFuZA0KcHVuY3R1YXRpb24gbGV2
ZWxzIGF0IHRoZSBzYW1lIHRpbWUgYnkgaXNzdWluZyBqdXN0IG9uZSBjb21tYW5kLiAgRm9y
DQpleGFtcGxlLCBpZiB5b3Ugd2VyZSB0byBleGVjdXRlIHRoZSBwdW5jMyBjb21tYW5kIGF0
IHlvdXIgc2hlbGwgcHJvbXB0LA0KdGhlbiB0aGUgcmVhZGluZyBwdW5jIGFuZCBwdW5jIGxl
dmVsIHdvdWxkIGJvdGggZ2V0IHNldCB0byAzLg0KDQouLiBub3RlOjoNCg0KICBUaGUgYWJv
dmUgc2NyaXB0cyB3ZXJlIHdyaXR0ZW4gdG8gd29yayB3aXRoIGJhc2gsIGJ1dA0KICByZWdh
cmRsZXNzIG9mIHdoaWNoIHNoZWxsIHlvdSB1c2UsIHlvdSBzaG91bGQgYmUgYWJsZSB0byBk
byBzb21ldGhpbmcNCiAgc2ltaWxhci4NCg0KVGhlIFNwZWFrdXAgc3lzIHN5c3RlbSBhbHNv
IGhhcyBhbm90aGVyIGludGVyZXN0aW5nIHVzZS4gIFlvdSBjYW4gZWNobw0KU3BlYWt1cCBw
YXJhbWV0ZXJzIGludG8gdGhlIHN5cyBzeXN0ZW0gaW4gYSBzY3JpcHQgZHVyaW5nIHN5c3Rl
bQ0Kc3RhcnR1cCwgYW5kIHNwZWFrdXAgd2lsbCByZXR1cm4gdG8geW91ciBwcmVmZXJyZWQg
cGFyYW1ldGVycyBldmVyeSB0aW1lDQp0aGUgc3lzdGVtIGlzIHJlYm9vdGVkLg0KDQpNb3N0
IG9mIHRoZSBTcGVha3VwIHN5cyBwYXJhbWV0ZXJzIGNhbiBiZSBtYW5pcHVsYXRlZCBieSBh
IHJlZ3VsYXIgdXNlcg0Kb24gdGhlIHN5c3RlbS4gIEhvd2V2ZXIsIHRoZXJlIGFyZSBhIGZl
dyBwYXJhbWV0ZXJzIHRoYXQgYXJlIGRhbmdlcm91cw0KZW5vdWdoIHRoYXQgdGhleSBzaG91
bGQgb25seSBiZSBtYW5pcHVsYXRlZCBieSB0aGUgcm9vdCB1c2VyIG9uIHlvdXINCnN5c3Rl
bS4gIFRoZXJlIGFyZSBldmVuIHNvbWUgcGFyYW1ldGVycyB0aGF0IGFyZSByZWFkIG9ubHks
IGFuZCBjYW5ub3QNCmJlIHdyaXR0ZW4gdG8gYXQgYWxsLiAgRm9yIGV4YW1wbGUsIHRoZSB2
ZXJzaW9uIGVudHJ5IGluIHRoZSBTcGVha3VwDQpzeXMgc3lzdGVtIGlzIHJlYWQgb25seS4g
IFRoaXMgaXMgYmVjYXVzZSB0aGVyZSBpcyBubyByZWFzb24gZm9yIGEgdXNlcg0KdG8gdGFt
cGVyIHdpdGggdGhlIHZlcnNpb24gbnVtYmVyIHdoaWNoIGlzIHJlcG9ydGVkIGJ5IFNwZWFr
dXAuICBEb2luZw0KYW4gYGBscyAtbGBgIG9uIGBgL3NwZWFrdXAvdmVyc2lvbmBgIHdpbGwg
cmV0dXJuIHRoaXM6Og0KDQogIC1yLS1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAg
ICAgICAgMCBNYXIgMjEgMTM6NDYgL3NwZWFrdXAvdmVyc2lvbg0KDQpBcyB5b3UgY2FuIHNl
ZSwgdGhlIHZlcnNpb24gZW50cnkgaW4gdGhlIFNwZWFrdXAgc3lzIHN5c3RlbSBpcyByZWFk
DQpvbmx5LCBpcyBvd25lZCBieSByb290LCBhbmQgYmVsb25ncyB0byB0aGUgcm9vdCBncm91
cC4gIERvaW5nIGEgY2F0IG9mDQpgYC9zcGVha3VwL3ZlcnNpb25gYCB3aWxsIGRpc3BsYXkg
dGhlIFNwZWFrdXAgdmVyc2lvbiBudW1iZXIsIGxpa2UNCnRoaXM6Og0KDQogIGNhdCAvc3Bl
YWt1cC92ZXJzaW9uDQogIFNwZWFrdXAgdi0yLjAwIENWUzogVGh1IE9jdCAyMSAxMDozODoy
MSBFRFQgMjAwNA0KICBzeW50aCBkdGxrIHZlcnNpb24gMS4xDQoNClRoZSBkaXNwbGF5IHNo
b3dzIHRoZSBTcGVha3VwIHZlcnNpb24gbnVtYmVyLCBhbG9uZyB3aXRoIHRoZSB2ZXJzaW9u
DQpudW1iZXIgb2YgdGhlIGRyaXZlciBmb3IgdGhlIGN1cnJlbnQgc3ludGhlc2l6ZXIuDQoN
Ckxvb2tpbmcgYXQgZW50cmllcyBpbiB0aGUgU3BlYWt1cCBzeXMgc3lzdGVtIGNhbiBiZSB1
c2VmdWwgaW4gbWFueQ0Kd2F5cy4gIEZvciBleGFtcGxlLCB5b3UgbWlnaHQgd2lzaCB0byBr
bm93IHdoYXQgbGV2ZWwgeW91ciB2b2x1bWUgaXMgc2V0DQphdC4gIFlvdSBjb3VsZCB0eXBl
OjoNCg0KICBjYXQgL3NwZWFrdXAvS1dEL3ZvbA0KICAjIFJlcGxhY2UgS1dEIHdpdGggdGhl
IGtleXdvcmQgZm9yIHlvdXIgc3ludGhlc2l6ZXIsIEUuRy4sIGx0bGsgZm9yIExpdGVUYWxr
Lg0KICA1DQoNClRoZSBudW1iZXIgZml2ZSB3aGljaCBjb21lcyBiYWNrIGlzIHRoZSBsZXZl
bCBhdCB3aGljaCB0aGUgc3ludGhlc2l6ZXINCnZvbHVtZSBpcyBzZXQgYXQuDQoNCkFsbCB0
aGUgZW50cmllcyBpbiB0aGUgU3BlYWt1cCBzeXMgc3lzdGVtIGFyZSByZWFkYWJsZSwgc29t
ZSBhcmUNCndyaXRhYmxlIGJ5IHJvb3Qgb25seSwgYW5kIHNvbWUgYXJlIHdyaXRhYmxlIGJ5
IGV2ZXJ5b25lLiAgVW5sZXNzIHlvdQ0Ka25vdyB3aGF0IHlvdSBhcmUgZG9pbmcsIHlvdSBz
aG91bGQgcHJvYmFibHkgbGVhdmUgdGhlIG9uZXMgdGhhdCBhcmUNCndyaXRhYmxlIGJ5IHJv
b3Qgb25seSBhbG9uZS4gIE1vc3Qgb2YgdGhlIG5hbWVzIGFyZSBzZWxmIGV4cGxhbmF0b3J5
Lg0KVm9sIGZvciBjb250cm9sbGluZyB2b2x1bWUsIHBpdGNoIGZvciBwaXRjaCwgaW5mbGVj
dGlvbiBmb3IgcGl0Y2ggcmFuZ2UsIHJhdGUNCmZvciBjb250cm9sbGluZyBzcGVha2luZyBy
YXRlLCBldGMuICBJZiB5b3UgZmluZCBvbmUgeW91IGFyZW4ndCBzdXJlIGFib3V0LCB5b3UN
CmNhbiBwb3N0IGEgcXVlcnkgb24gdGhlIFNwZWFrdXAgbGlzdC4NCg0KDQo2LiAgQ2hhbmdp
bmcgU3ludGhlc2l6ZXJzDQo9PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkl0IGlzIHBv
c3NpYmxlIHRvIGNoYW5nZSB0byBhIGRpZmZlcmVudCBzeW50aGVzaXplciB3aGlsZSBzcGVh
a3VwIGlzDQpydW5uaW5nLiAgSW4gb3RoZXIgd29yZHMsIGl0IGlzIG5vdCBuZWNlc3Nhcnkg
dG8gcmVib290IHRoZSBzeXN0ZW0NCmluIG9yZGVyIHRvIHVzZSBhIGRpZmZlcmVudCBzeW50
aGVzaXplci4gIFlvdSBjYW4gc2ltcGx5IGVjaG8gdGhlDQpzeW50aGVzaXplciBrZXl3b3Jk
IHRvIHRoZSBgYC9zcGVha3VwL3N5bnRoYGAgc3lzIGVudHJ5Lg0KRGVwZW5kaW5nIG9uIHlv
dXIgc2l0dWF0aW9uLCB5b3UgbWF5IHdpc2ggdG8gZWNobyBub25lIHRvIHRoZSBzeW50aA0K
c3lzIGVudHJ5LCB0byBkaXNhYmxlIHNwZWVjaCB3aGlsZSBvbmUgc3ludGhlc2l6ZXIgaXMg
ZGlzY29ubmVjdGVkIGFuZA0KYSBzZWNvbmQgb25lIGlzIGNvbm5lY3RlZCBpbiBpdHMgcGxh
Y2UuICBUaGVuIGVjaG8gdGhlIGtleXdvcmQgZm9yIHRoZQ0KbmV3IHN5bnRoZXNpemVyIGlu
dG8gdGhlIHN5bnRoIHN5cyBlbnRyeSBpbiBvcmRlciB0byBzdGFydCBzcGVlY2gNCndpdGgg
dGhlIG5ld2x5IGNvbm5lY3RlZCBzeW50aGVzaXplci4gIFNlZSB0aGUgbGlzdCBvZiBzeW50
aGVzaXplcg0Ka2V5d29yZHMgaW4gc2VjdGlvbiAxIHRvIGZpbmQgdGhlIGtleXdvcmQgd2hp
Y2ggbWF0Y2hlcyB5b3VyIHN5bnRoLg0KDQoNCjcuICBMb2FkaW5nIG1vZHVsZXMNCj09PT09
PT09PT09PT09PT09PT0NCg0KQXMgbWVudGlvbmVkIGVhcmxpZXIsIFNwZWFrdXAgY2FuIGVp
dGhlciBiZSBjb21wbGV0ZWx5IGNvbXBpbGVkIGludG8gdGhlDQprZXJuZWwsIHdpdGggdGhl
IGV4Y2VwdGlvbiBvZiB0aGUgaGVscCBtb2R1bGUsIG9yIGl0IGNhbiBiZSBjb21waWxlZCBh
cw0KYSBzZXJpZXMgb2YgbW9kdWxlcy4gICBXaGVuIGNvbXBpbGVkIGFzIG1vZHVsZXMsIFNw
ZWFrdXAgd2lsbCBvbmx5IGJlDQphYmxlIHRvIHNwZWFrIHNvbWUgb2YgdGhlIGJvb3R1cCBt
ZXNzYWdlcyBpZiB5b3VyIHN5c3RlbSBhZG1pbmlzdHJhdG9yDQpoYXMgY29uZmlndXJlZCB0
aGUgc3lzdGVtIHRvIGxvYWQgdGhlIG1vZHVsZXMgYXQgYm9vIHRpbWUuIFRoZSBtb2R1bGVz
DQpjYW4gIGJlIGxvYWRlZCBhZnRlciB0aGUgZmlsZSBzeXN0ZW1zIGhhdmUgYmVlbiBjaGVj
a2VkIGFuZCBtb3VudGVkLCBvcg0KZnJvbSBhbiBpbml0cmQuICBUaGVyZSBpcyBhIHRoaXJk
IHBvc3NpYmlsaXR5LiAgU3BlYWt1cCBjYW4gYmUgY29tcGlsZWQNCndpdGggc29tZSBjb21w
b25lbnRzIGJ1aWx0IGludG8gdGhlIGtlcm5lbCwgYW5kIG90aGVycyBhcyBtb2R1bGVzLiAg
QXMNCndlJ2xsIHNlZSBpbiB0aGUgbmV4dCBzZWN0aW9uLCB0aGlzIGlzIHBhcnRpY3VsYXJs
eSB1c2VmdWwgd2hlbiB5b3UgYXJlDQp3b3JraW5nIHdpdGggc29mdHdhcmUgc3ludGhlc2l6
ZXJzLg0KDQpJZiBTcGVha3VwIGlzIGNvbXBsZXRlbHkgY29tcGlsZWQgYXMgbW9kdWxlcywg
dGhlbiB5b3UgbXVzdCB1c2UgdGhlDQptb2Rwcm9iZSBjb21tYW5kIHRvIGxvYWQgU3BlYWt1
cC4gIFlvdSBkbyB0aGlzIGJ5IGxvYWRpbmcgdGhlIG1vZHVsZSBmb3INCnRoZSBzeW50aGVz
aXplciBkcml2ZXIgeW91IHdpc2ggdG8gdXNlLiAgVGhlIGRyaXZlciBtb2R1bGVzIGFyZSBh
bGwNCm5hbWVkIHNwZWFrdXBfPGtleXdvcmQ+LCB3aGVyZSA8a2V5d29yZD4gaXMgdGhlIGtl
eXdvcmQgZm9yIHRoZQ0Kc3ludGhlc2l6ZXIgeW91IHdhbnQuICBTbywgaW4gb3JkZXIgdG8g
bG9hZCB0aGUgZHJpdmVyIGZvciB0aGUgRGVjVGFsaw0KRXhwcmVzcywgeW91IHdvdWxkIHR5
cGUgdGhlIGZvbGxvd2luZyBjb21tYW5kOjoNCg0KICBtb2Rwcm9iZSBzcGVha3VwX2RlY3Rs
aw0KDQpJc3N1aW5nIHRoaXMgY29tbWFuZCB3b3VsZCBsb2FkIHRoZSBEZWNUYWxrIEV4cHJl
c3MgZHJpdmVyIGFuZCBhbGwgb3RoZXINCnJlbGF0ZWQgU3BlYWt1cCBtb2R1bGVzIG5lY2Vz
c2FyeSB0byBnZXQgU3BlYWt1cCB1cCBhbmQgcnVubmluZy4NCg0KVG8gY29tcGxldGVseSB1
bmxvYWQgU3BlYWt1cCwgYWdhaW4gcHJlc3VtaW5nIHRoYXQgaXQgaXMgZW50aXJlbHkgYnVp
bHQNCmFzIG1vZHVsZXMsIHlvdSB3b3VsZCBnaXZlIHRoZSBjb21tYW5kOjoNCg0KICBtb2Rw
cm9iZSAtciBzcGVha3VwX2RlY3Rsaw0KDQpUaGUgYWJvdmUgY29tbWFuZCBhc3N1bWVzIHlv
dSB3ZXJlIHJ1bm5pbmcgYSBEZWNUYWxrIEV4cHJlc3MuICBJZiB5b3UNCndlcmUgdXNpbmcg
YSBkaWZmZXJlbnQgc3ludGgsIHRoZW4geW91IHdvdWxkIHN1YnN0aXR1dGUgaXRzIGtleXdv
cmQgaW4NCnBsYWNlIG9mIGBkZWN0bGtgLg0KDQpJZiB5b3UgaGF2ZSBtdWx0aXBsZSBkcml2
ZXJzIGxvYWRlZCwgeW91IG5lZWQgdG8gdW5sb2FkIGFsbCBvZiB0aGVtLCBpbg0Kb3JkZXIg
dG8gY29tcGxldGVseSB1bmxvYWQgU3BlYWt1cC4NCkZvciBleGFtcGxlLCBpZiB5b3UgaGF2
ZSBsb2FkZWQgYm90aCB0aGUgZGVjdGxrIGFuZCBsdGxrIGRyaXZlcnMsIHVzZSB0aGUNCmNv
bW1hbmQ6Og0KDQogIG1vZHByb2JlIC1yIHNwZWFrdXBfZGVjdGxrIHNwZWFrdXBfbHRsaw0K
DQpZb3UgY2Fubm90IHVubG9hZCB0aGUgZHJpdmVyIGZvciBzb2Z0d2FyZSBzeW50aGVzaXpl
cnMgd2hlbiBhIHVzZXItc3BhY2UNCmRhZW1vbiBpcyB1c2luZyBgYC9kZXYvc29mdHN5bnRo
YGAuICBGaXJzdCwga2lsbCB0aGUgZGFlbW9uLiAgTmV4dCwgcmVtb3ZlDQp0aGUgZHJpdmVy
IHdpdGggdGhlIGNvbW1hbmQ6Og0KDQogIG1vZHByb2JlIC1yIHNwZWFrdXBfc29mdA0KDQpO
b3csIHN1cHBvc2Ugd2UgaGF2ZSBhIHNpdHVhdGlvbiB3aGVyZSB0aGUgbWFpbiBTcGVha3Vw
IGNvbXBvbmVudA0KaXMgYnVpbHQgaW50byB0aGUga2VybmVsLCBhbmQgc29tZSBvciBhbGwg
b2YgdGhlIGRyaXZlcnMgYXJlIGJ1aWx0IGFzDQptb2R1bGVzLiAgU2luY2UgdGhlIG1haW4g
cGFydCBvZiBTcGVha3VwIGlzIGNvbXBpbGVkIGludG8gdGhlIGtlcm5lbCwgYQ0KcGFydGlh
bCBTcGVha3VwIHN5cyBzeXN0ZW0gaGFzIGJlZW4gY3JlYXRlZCB3aGljaCB3ZSBjYW4gdGFr
ZSBhZHZhbnRhZ2UNCm9mIGJ5IHNpbXBseSBlY2hvaW5nIHRoZSBzeW50aGVzaXplciBrZXl3
b3JkIGludG8gdGhlDQpgYC9zcGVha3VwL3N5bnRoYGAgc3lzIGVudHJ5LiAgVGhpcyB3aWxs
IGNhdXNlIHRoZSBrZXJuZWwgdG8NCmF1dG9tYXRpY2FsbHkgbG9hZCB0aGUgYXBwcm9wcmlh
dGUgZHJpdmVyIG1vZHVsZSwgYW5kIHN0YXJ0IFNwZWFrdXANCnRhbGtpbmcuICBUbyBzd2l0
Y2ggdG8gYW5vdGhlciBzeW50aCwganVzdCBlY2hvIGEgbmV3IGtleXdvcmQgdG8gdGhlDQpz
eW50aCBzeXMgZW50cnkuICBGb3IgZXhhbXBsZSwgdG8gbG9hZCB0aGUgRG91YmxlVGFsayBM
VCBkcml2ZXIsDQp5b3Ugd291bGQgdHlwZTo6DQoNCiAgZWNobyBsdGxrID4vc3BlYWt1cC9z
eW50aA0KDQpZb3UgY2FuIHVzZSB0aGUgYGBtb2Rwcm9iZSAtcmBgIGNvbW1hbmQgdG8gdW5s
b2FkIGRyaXZlciBtb2R1bGVzLCByZWdhcmRsZXNzDQpvZiB3aGV0aGVyIHRoZSBtYWluIHBh
cnQgb2YgU3BlYWt1cCBoYXMgYmVlbiBidWlsdCBpbnRvIHRoZSBrZXJuZWwgb3INCm5vdC4N
Cg0KDQo4LiAgVXNpbmcgU29mdHdhcmUgU3ludGhlc2l6ZXJzDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQoNClVzaW5nIGEgc29mdHdhcmUgc3ludGhlc2l6ZXIgcmVxdWly
ZXMgdGhhdCBzb21lIG90aGVyIHNvZnR3YXJlIGJlDQppbnN0YWxsZWQgYW5kIHJ1bm5pbmcg
b24geW91ciBzeXN0ZW0uICBGb3IgdGhpcyByZWFzb24sIHNvZnR3YXJlDQpzeW50aGVzaXpl
cnMgYXJlIG5vdCBhdmFpbGFibGUgZm9yIHVzZSBhdCBib290dXAsIG9yIGR1cmluZyBhIHN5
c3RlbQ0KaW5zdGFsbGF0aW9uIHByb2Nlc3MuDQpUaGVyZSBhcmUgdHdvIGZyZWVseS1hdmFp
bGFibGUgc29sdXRpb25zIGZvciBzb2Z0d2FyZSBzcGVlY2g6IEVzcGVha3VwIGFuZA0KU3Bl
ZWNoIERpc3BhdGNoZXIuDQpUaGVzZSBhcmUgZGVzY3JpYmVkIGluIHN1YnNlY3Rpb25zIGA4
LjEuIEVzcGVha3VwYF8gYW5kDQpgOC4yLiBTcGVlY2ggRGlzcGF0Y2hlcmBfLCByZXNwZWN0
aXZlbHkuDQoNCkR1cmluZyB0aGUgcmVzdCBvZiB0aGlzIHNlY3Rpb24sIHdlIGFzc3VtZSB0
aGF0IGBzcGVha3VwX3NvZnRgIGlzIGVpdGhlcg0KYnVpbHQgaW4gdG8geW91ciBrZXJuZWws
IG9yIGxvYWRlZCBhcyBhIG1vZHVsZS4NCg0KSWYgeW91ciBzeXN0ZW0gZG9lcyBub3QgaGF2
ZSB1ZGV2IGluc3RhbGxlZCAsIGJlZm9yZSB5b3UgY2FuIHVzZSBhDQpzb2Z0d2FyZSBzeW50
aGVzaXplciwgeW91IG11c3QgaGF2ZSBjcmVhdGVkIHRoZSBgYC9kZXYvc29mdHN5bnRoYGAg
ZGV2aWNlLg0KSWYgeW91IGhhdmUgbm90IGFscmVhZHkgZG9uZSBzbywgaXNzdWUgdGhlIGZv
bGxvd2luZyBjb21tYW5kcyBhcyByb290OjoNCg0KICBjZCAvZGV2DQogIG1rbm9kIHNvZnRz
eW50aCBjIDEwIDI2DQoNCldoaWxlIHdlIGFyZSBhdCBpdCwgd2UgbWlnaHQganVzdCBhcyB3
ZWxsIGNyZWF0ZSB0aGUgYGAvZGV2L3N5bnRoYGAgZGV2aWNlLA0Kd2hpY2ggY2FuIGJlIHVz
ZWQgdG8gbGV0IHVzZXIgc3BhY2UgcHJvZ3JhbXMgc2VuZCBpbmZvcm1hdGlvbiB0byB5b3Vy
DQpzeW50aGVzaXplci4gIFRvIGNyZWF0ZSBgYC9kZXYvc3ludGhgYCwgY2hhbmdlIHRvIHRo
ZSBgYC9kZXZgYCBkaXJlY3RvcnksIGFuZA0KaXNzdWUgdGhlIGZvbGxvd2luZyBjb21tYW5k
IGFzIHJvb3Q6Og0KDQogIG1rbm9kIHN5bnRoIGMgMTAgMjUNCg0Kb2YgYm90aC4NCg0KOC4x
LiBFc3BlYWt1cA0KLS0tLS0tLS0tLS0tLQ0KDQpFc3BlYWt1cCBpcyBhIGNvbm5lY3RvciBi
ZXR3ZWVuIFNwZWFrdXAgYW5kIHRoZSBlU3BlYWsgc29mdHdhcmUgc3ludGhlc2l6ZXIuDQpF
c3BlYWt1cCBtYXkgYWxyZWFkeSBiZSBhdmFpbGFibGUgYXMgYSBwYWNrYWdlIGZvciB5b3Vy
IGRpc3RyaWJ1dGlvbg0Kb2YgTGludXguICBJZiBpdCBpcyBub3QgcGFja2FnZWQsIHlvdSBu
ZWVkIHRvIGluc3RhbGwgaXQgbWFudWFsbHkuDQpZb3UgY2FuIGZpbmQgaXQgaW4gdGhlIGBg
Y29udHJpYi9gYCBzdWJkaXJlY3Rvcnkgb2YgdGhlIFNwZWFrdXAgc291cmNlcy4NClRoZSBm
aWxlbmFtZSBpcyBgYGVzcGVha3VwLSRWRVJTSU9OLnRhci5iejJgYCwgd2hlcmUgYGAkVkVS
U0lPTmBgDQpkZXBlbmRzIG9uIHRoZSBjdXJyZW50IHJlbGVhc2Ugb2YgRXNwZWFrdXAuICBU
aGUgU3BlYWt1cCAzLjEuMiBzb3VyY2UNCnNoaXBzIHdpdGggdmVyc2lvbiAwLjcxIG9mIEVz
cGVha3VwLg0KVGhlIFJFQURNRSBmaWxlIGluY2x1ZGVkIHdpdGggdGhlIEVzcGVha3VwIHNv
dXJjZXMgZGVzY3JpYmVzIHRoZSBwcm9jZXNzDQpvZiBtYW51YWwgaW5zdGFsbGF0aW9uLg0K
DQpBc3N1bWluZyB0aGF0IEVzcGVha3VwIGlzIGluc3RhbGxlZCwgZWl0aGVyIGJ5IHRoZSB1
c2VyIG9yIGJ5IHRoZSBkaXN0cmlidXRvciwNCmZvbGxvdyB0aGVzZSBzdGVwcyB0byB1c2Ug
aXQuDQoNClRlbGwgU3BlYWt1cCB0byB1c2UgdGhlICJzb2Z0IGRyaXZlcjo6DQoNCiAgZWNo
byBzb2Z0ID4gL3NwZWFrdXAvc3ludGgNCg0KRmluYWxseSwgc3RhcnQgdGhlIGVzcGVha3Vw
IHByb2dyYW0uICBUaGVyZSBhcmUgdHdvIHdheXMgdG8gZG8gaXQuDQpCb3RoIHJlcXVpcmUg
cm9vdCBwcml2aWxlZ2VzLg0KDQpJZiBFc3BlYWt1cCB3YXMgaW5zdGFsbGVkIGFzIGEgcGFj
a2FnZSBmb3IgeW91ciBMaW51eCBkaXN0cmlidXRpb24sDQp5b3UgcHJvYmFibHkgaGF2ZSBh
IGRpc3RyaWJ1dGlvbi1zcGVjaWZpYyBzY3JpcHQgdGhhdCBjb250cm9scyB0aGUgb3BlcmF0
aW9uDQpvZiB0aGUgZGFlbW9uLiAgTG9vayBmb3IgYSBmaWxlIG5hbWVkIGVzcGVha3VwIHVu
ZGVyIGBgL2V0Yy9pbml0LmRgYCBvcg0KYGAvZXRjL3JjLmRgYC4gIEV4ZWN1dGUgdGhlIGZv
bGxvd2luZyBjb21tYW5kIHdpdGggcm9vdCBwcml2aWxlZ2VzOjoNCg0KICAvZXRjL2luaXQu
ZC9lc3BlYWt1cCBzdGFydA0KDQpSZXBsYWNlIGBgaW5pdC5kYGAgd2l0aCBgYHJjLmRgYCwg
aWYgeW91ciBkaXN0cmlidXRpb24gdXNlcyBzY3JpcHRzIGxvY2F0ZWQNCnVuZGVyIGBgL2V0
Yy9yYy5kYGAuDQpZb3VyIGRpc3RyaWJ1dGlvbiB3aWxsIGFsc28gaGF2ZSBhIHByb2NlZHVy
ZSBmb3Igc3RhcnRpbmcgZGFlbW9ucyBhdA0KYm9vdC10aW1lLCBzbyBpdCBpcyBwb3NzaWJs
ZSB0byBoYXZlIHNvZnR3YXJlIHNwZWVjaCBhcyBzb29uIGFzIHVzZXItc3BhY2UNCmRhZW1v
bnMgYXJlIHN0YXJ0ZWQgYnkgdGhlIGJvb3R1cCBzY3JpcHRzLg0KVGhlc2UgcHJvY2VkdXJl
cyBhcmUgbm90IGRlc2NyaWJlZCBpbiB0aGlzIGRvY3VtZW50Lg0KDQpJZiB5b3UgYnVpbHQg
RXNwZWFrdXAgbWFudWFsbHksIHRoZSBgYG1ha2UgaW5zdGFsbGBgIHN0ZXAgcGxhY2VkIHRo
ZSBiaW5hcnkNCnVuZGVyIGBgL3Vzci9iaW5gYC4NClJ1biB0aGUgZm9sbG93aW5nIGNvbW1h
bmQgYXMgcm9vdDo6DQoNCiAgL3Vzci9iaW4vZXNwZWFrdXANCg0KRXNwZWFrdXAgc2hvdWxk
IHN0YXJ0IHNwZWFraW5nLg0KDQo4LjIuIFNwZWVjaCBEaXNwYXRjaGVyDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQoNCkZvciB0aGlzIG9wdGlvbiwgeW91IG11c3QgaGF2ZSBhIHBhY2th
Z2UgY2FsbGVkDQpTcGVlY2ggRGlzcGF0Y2hlciBydW5uaW5nIG9uIHlvdXIgc3lzdGVtLCBh
bmQgaXQgbXVzdCBiZSBjb25maWd1cmVkIHRvDQp3b3JrIHdpdGggb25lIG9mIGl0cyBzdXBw
b3J0ZWQgc29mdHdhcmUgc3ludGhlc2l6ZXJzLg0KDQpUd28gb3BlbiBzb3VyY2Ugc3ludGhl
c2l6ZXJzIHlvdSBtaWdodCB1c2UgYXJlIEZsaXRlIGFuZCBGZXN0aXZhbC4gIFlvdQ0KbWln
aHQgYWxzbyBjaG9vc2UgdG8gcHVyY2hhc2UgdGhlIFNvZnR3YXJlIERlY1RhbGsgZnJvbSBG
b25peCBTYWxlcyBJbmMuDQpJZiB5b3UgcnVuIGEgZ29vZ2xlIHNlYXJjaCBmb3IgRm9uaXgs
IHlvdSdsbCBmaW5kIHRoZWlyIHdlYiBzaXRlLg0KDQpZb3UgY2FuIG9idGFpbiBhIGNvcHkg
b2YgU3BlZWNoIERpc3BhdGNoZXIgZnJvbSBmcmVlKGIpc29mdCBhdA0KaHR0cDovL3d3dy5m
cmVlYnNvZnQub3JnLy4gIEZvbGxvdyB0aGUgaW5zdGFsbGF0aW9uIGluc3RydWN0aW9ucyB0
aGF0DQpjb21lIHdpdGggU3BlZWNoIERpc3BhdGNoZXIgaW4gb3JkZXIgdG8gaW5zdGFsbCBh
bmQgY29uZmlndXJlIFNwZWVjaA0KRGlzcGF0Y2hlci4gIFlvdSBjYW4gY2hlY2sgb3V0IHRo
ZSB3ZWIgc2l0ZSBmb3IgeW91ciBMaW51eCBkaXN0cmlidXRpb24NCmluIG9yZGVyIHRvIGdl
dCBhIGNvcHkgb2YgZWl0aGVyIEZsaXRlIG9yIEZlc3RpdmFsLiAgWW91ciBMaW51eA0KZGlz
dHJpYnV0aW9uIG1heSBhbHNvIGhhdmUgYSBwcmVjb21waWxlZCBTcGVlY2ggRGlzcGF0Y2hl
ciBwYWNrYWdlLg0KDQpPbmNlIHlvdSd2ZSBpbnN0YWxsZWQsIGNvbmZpZ3VyZWQsIGFuZCB0
ZXN0ZWQgU3BlZWNoIERpc3BhdGNoZXIgd2l0aCB5b3VyDQpjaG9zZW4gc29mdHdhcmUgc3lu
dGhlc2l6ZXIsIHlvdSBzdGlsbCBuZWVkIG9uZSBtb3JlIHBpZWNlIG9mIHNvZnR3YXJlDQpp
biBvcmRlciB0byBtYWtlIHRoaW5ncyB3b3JrLiAgWW91IG5lZWQgYSBwYWNrYWdlIGNhbGxl
ZCBzcGVlY2hkLXVwLg0KWW91IGdldCBpdCBmcm9tIHRoZSBmcmVlKGIpc29mdCB3ZWIgc2l0
ZSBtZW50aW9uZWQgYWJvdmUuICBBZnRlciB5b3UndmUNCmNvbXBpbGVkIGFuZCBpbnN0YWxs
ZWQgc3BlZWNoZC11cCwgeW91IGFyZSBhbG1vc3QgcmVhZHkgdG8gYmVnaW4gdXNpbmcNCnlv
dXIgc29mdHdhcmUgc3ludGhlc2l6ZXIuDQoNCk5vdyB5b3UgY2FuIGJlZ2luIHVzaW5nIHlv
dXIgc29mdHdhcmUgc3ludGhlc2l6ZXIuICBJbiBvcmRlciB0byBkbyBzbywNCmVjaG8gdGhl
IHNvZnQga2V5d29yZCB0byB0aGUgc3ludGggc3lzIGVudHJ5IGxpa2UgdGhpczo6DQoNCiAg
ZWNobyBzb2Z0ID4vc3BlYWt1cC9zeW50aA0KDQpOZXh0IHJ1biB0aGUgc3BlZWNoZF91cCBj
b21tYW5kIGxpa2UgdGhpczo6DQoNCiAgc3BlZWNoZF91cCAmDQoNCllvdXIgc3ludGggc2hv
dWxkIG5vdyBzdGFydCB0YWxraW5nLCBhbmQgeW91IHNob3VsZCBiZSBhYmxlIHRvIGFkanVz
dA0KdGhlIHBpdGNoLCByYXRlLCBldGMuDQoNCg0KOS4gIFVzaW5nIFRoZSBEZWNUYWxrIFBD
IENhcmQNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNClRoZSBEZWNUYWxrIFBD
IGNhcmQgaXMgYW4gSVNBIGNhcmQgdGhhdCBpcyBpbnNlcnRlZCBpbnRvIG9uZSBvZiB0aGUg
SVNBDQpzbG90cyBpbiB5b3VyIGNvbXB1dGVyLiAgSXQgcmVxdWlyZXMgdGhhdCB0aGUgRGVj
VGFsayBQQyBzb2Z0d2FyZSBiZQ0KaW5zdGFsbGVkIG9uIHlvdXIgY29tcHV0ZXIsIGFuZCB0
aGF0IHRoZSBzb2Z0d2FyZSBiZSBsb2FkZWQgb250byB0aGUNCkRlY3RhbGsgUEMgY2FyZCBi
ZWZvcmUgaXQgY2FuIGJlIHVzZWQuDQoNCllvdSBjYW4gZ2V0IHRoZSBgYGRlY19wYy50Z3pg
YCBmaWxlIGZyb20gdGhlIGxpbnV4LXNwZWFrdXAub3JnIHNpdGUuICBUaGUNCmBgZGVjX3Bj
LnRnemBgIGZpbGUgaXMgaW4gdGhlIGBgfmZ0cC9wdWIvbGludXgvc3BlYWt1cGBgIGRpcmVj
dG9yeS4NCg0KQWZ0ZXIgeW91IGhhdmUgZG93bmxvYWRlZCB0aGUgYGBkZWNfcGMudGd6YGAg
ZmlsZSwgdW50YXIgaXQgaW4geW91ciBob21lDQpkaXJlY3RvcnksIGFuZCByZWFkIHRoZSBS
ZWFkbWUgZmlsZSBpbiB0aGUgbmV3bHkgY3JlYXRlZCBgYGRlY19wY2BgDQpkaXJlY3Rvcnku
DQoNClRoZSBlYXNpZXN0IHdheSB0byBnZXQgdGhlIHNvZnR3YXJlIHdvcmtpbmcgaXMgdG8g
Y29weSB0aGUgZW50aXJlIGBgZGVjX3BjYGANCmRpcmVjdG9yeSBpbnRvIGBgL3VzZXIvbG9j
YWwvbGliYGAuICBUbyBkbyB0aGlzLCBzdSB0byByb290IGluIHlvdXIgaG9tZQ0KZGlyZWN0
b3J5LCBhbmQgaXNzdWUgdGhlIGNvbW1hbmQ6Og0KDQogIGNwIGRlY19wYyAvdXNyL2xvY2Fs
L2xpYg0KDQpZb3Ugd2lsbCBuZWVkIHRvIGNvcHkgdGhlIGR0bG9hZCBjb21tYW5kIGZyb20g
dGhlIGRlY19wYyBkaXJlY3RvcnkgdG8gYQ0KZGlyZWN0b3J5IGluIHlvdXIgcGF0aC4gRWl0
aGVyIGBgL3Vzci9iaW5gYCBvciBgYC91c3IvbG9jYWwvYmluYGAgaXMgYQ0KZ29vZCBjaG9p
Y2UuDQoNCllvdSBjYW4gbm93IHJ1biB0aGUgZHRsb2FkIGNvbW1hbmQgaW4gb3JkZXIgdG8g
bG9hZCB0aGUgRGVjVGFsayBQQw0Kc29mdHdhcmUgb250byB0aGUgY2FyZC4gIEFmdGVyIHlv
dSBoYXZlIGRvbmUgdGhpcywgYGBlY2hvYGAgdGhlIGRlY3BjDQprZXl3b3JkIHRvIHRoZSBz
eW50aCBlbnRyeSBpbiB0aGUgc3lzIHN5c3RlbSBsaWtlIHRoaXM6Og0KDQogIGVjaG8gZGVj
cGMgPi9zcGVha3VwL3N5bnRoDQoNCllvdXIgRGVjVGFsayBQQyBzaG91bGQgc3RhcnQgdGFs
a2luZywgYW5kIHRoZW4geW91IGNhbiBhZGp1c3QgdGhlIHBpdGNoLA0KcmF0ZSwgdm9sdW1l
LCB2b2ljZSwgZXRjLiAgVGhlIHZvaWNlIGVudHJ5IGluIHRoZSBTcGVha3VwIHN5cyBzeXN0
ZW0NCndpbGwgYWNjZXB0IGEgbnVtYmVyIGZyb20gMCB0aHJvdWdoIDcgZm9yIHRoZSBEZWNU
YWxrIFBDIHN5bnRoZXNpemVyLA0Kd2hpY2ggd2lsbCBnaXZlIHlvdSBhY2Nlc3MgdG8gc29t
ZSBvZiB0aGUgRGVjVGFsayB2b2ljZXMuDQoNCg0KMTAuICBVc2luZyBDdXJzb3IgVHJhY2tp
bmcNCj09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkluIFNwZWFrdXAgdmVyc2lvbiAy
LjAgYW5kIGxhdGVyLCBjdXJzb3IgdHJhY2tpbmcgaXMgdHVybmVkIG9uIGJ5DQpkZWZhdWx0
LiAgVGhpcyBtZWFucyB0aGF0IHdoZW4geW91IGFyZSB1c2luZyBhbiBlZGl0b3IsIFNwZWFr
dXAgd2lsbA0KYXV0b21hdGljYWxseSBzcGVhayBjaGFyYWN0ZXJzIGFzIHlvdSBtb3ZlIGxl
ZnQgYW5kIHJpZ2h0IHdpdGggdGhlDQpjdXJzb3Iga2V5cywgYW5kIGxpbmVzIGFzIHlvdSBt
b3ZlIHVwIGFuZCBkb3duIHdpdGggdGhlIGN1cnNvciBrZXlzLg0KVGhpcyBpcyB0aGUgdHJh
ZGl0aW9uYWwgc29ydCBvZiBjdXJzb3IgdHJhY2tpbmcuDQpSZWNlbnQgdmVyc2lvbnMgb2Yg
U3BlYWt1cCBwcm92aWRlIHR3byBhZGRpdGlvbmFsIHdheXMgdG8gY29udHJvbCB0aGUNCnRl
eHQgdGhhdCBpcyBzcG9rZW4gd2hlbiB0aGUgY3Vyc29yIGlzIG1vdmVkOg0KImhpZ2hsaWdo
dCB0cmFja2luZyIgYW5kICJyZWFkIHdpbmRvdy4iDQpUaGV5IGFyZSBkZXNjcmliZWQgbGF0
ZXIgaW4gdGhpcyBzZWN0aW9uLg0KU29tZXRpbWVzLCB0aGVzZSBtb2RlcyBnZXQgaW4geW91
ciB3YXksIHNvIHlvdSBjYW4gZGlzYWJsZSBjdXJzb3IgdHJhY2tpbmcNCmFsdG9nZXRoZXIu
DQoNCllvdSBtYXkgc2VsZWN0IGFtb25nIHRoZSB2YXJpb3VzIGZvcm1zIG9mIGN1cnNvciB0
cmFja2luZyB1c2luZyB0aGUga2V5cGFkDQphc3RlcmlzayBrZXkuDQpFYWNoIHRpbWUgeW91
IHByZXNzIHRoaXMga2V5LCBhIG5ldyBtb2RlIGlzIHNlbGVjdGVkLCBhbmQgU3BlYWt1cCBz
cGVha3MNCnRoZSBuYW1lIG9mIHRoZSBuZXcgbW9kZS4gIFRoZSBuYW1lcyBmb3IgdGhlIGZv
dXIgcG9zc2libGUgc3RhdGVzIG9mIGN1cnNvcg0KdHJhY2tpbmcgYXJlOiAiY3Vyc29yaW5n
IG9uIiwgImhpZ2hsaWdodCB0cmFja2luZyIsICJyZWFkIHdpbmRvdyIsDQphbmQgImN1cnNv
cmluZyBvZmYuIiAgVGhlIGtleXBhZCBhc3RlcmlzayBrZXkgbW92ZXMgdGhyb3VnaCB0aGUg
bGlzdCBvZg0KbW9kZXMgaW4gYSBjaXJjdWxhciBmYXNoaW9uLg0KDQpJZiBoaWdobGlnaHQg
dHJhY2tpbmcgaXMgZW5hYmxlZCwgU3BlYWt1cCB0cmFja3MgaGlnaGxpZ2h0ZWQgdGV4dCwN
CnJhdGhlciB0aGFuIHRoZSBjdXJzb3IgaXRzZWxmLiBXaGVuIHlvdSBtb3ZlIHRoZSBjdXJz
b3Igd2l0aCB0aGUgYXJyb3cga2V5cywNClNwZWFrdXAgc3BlYWtzIHRoZSBjdXJyZW50bHkg
aGlnaGxpZ2h0ZWQgaW5mb3JtYXRpb24uDQpUaGlzIGlzIHVzZWZ1bCB3aGVuIG1vdmluZyB0
aHJvdWdoIHZhcmlvdXMgbWVudXMgYW5kIGRpYWxvZyBib3hlcy4NCklmIGN1cnNvciB0cmFj
a2luZyBpc24ndCBoZWxwaW5nIHlvdSB3aGlsZSBuYXZpZ2F0aW5nIGEgbWVudSwNCnRyeSBo
aWdobGlnaHQgdHJhY2tpbmcuDQoNCldpdGggdGhlICJyZWFkIHdpbmRvdyIgdmFyaWV0eSBv
ZiBjdXJzb3IgdHJhY2tpbmcsIHlvdSBjYW4gbGltaXQgdGhlIHRleHQNCnRoYXQgU3BlYWt1
cCBzcGVha3MgYnkgc3BlY2lmeWluZyBhIHdpbmRvdyBvZiBpbnRlcmVzdCBvbiB0aGUgc2Ny
ZWVuLg0KU2VlIHNlY3Rpb24gMTUgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhlIHByb2Nlc3Mg
b2YgZGVmaW5pbmcgd2luZG93cy4NCldoZW4geW91IG1vdmUgdGhlIGN1cnNvciB2aWEgdGhl
IGFycm93IGtleXMsIFNwZWFrdXAgb25seSBzcGVha3MNCnRoZSBjb250ZW50cyBvZiB0aGUg
d2luZG93LiAgVGhpcyBpcyBlc3BlY2lhbGx5IGhlbHBmdWwgd2hlbiB5b3UgYXJlIGhlYXJp
bmcNCnN1cGVyZmx1b3VzIHNwZWVjaC4gIENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgZXhhbXBs
ZS4NCg0KU3VwcG9zZSB0aGF0IHlvdSBhcmUgYXQgYSBzaGVsbCBwcm9tcHQuICBZb3UgdXNl
IGJhc2gsIGFuZCB5b3Ugd2FudCB0bw0KZXhwbG9yZSB5b3VyIGNvbW1hbmQgaGlzdG9yeSB1
c2luZyB0aGUgdXAgYW5kIGRvd24gYXJyb3cga2V5cy4gIElmIHlvdQ0KaGF2ZSBlbmFibGVk
IGN1cnNvciB0cmFja2luZywgeW91IHdpbGwgaGVhciB0d28gcGllY2VzIG9mIGluZm9ybWF0
aW9uLg0KU3BlYWt1cCBzcGVha3MgYm90aCB5b3VyIHNoZWxsIHByb21wdCBhbmQgdGhlIGN1
cnJlbnQgZW50cnkgZnJvbSB0aGUNCmNvbW1hbmQgaGlzdG9yeS4gIFlvdSBtYXkgbm90IHdh
bnQgdG8gaGVhciB0aGUgcHJvbXB0IHJlcGVhdGVkDQplYWNoIHRpbWUgeW91IG1vdmUsIHNv
IHlvdSBjYW4gc2lsZW5jZSBpdCBieSBzcGVjaWZ5aW5nIGEgd2luZG93LiAgRmluZA0KdGhl
IGxhc3QgbGluZSBvZiB0ZXh0IG9uIHRoZSBzY3JlZW4uICBDbGVhciB0aGUgY3VycmVudCB3
aW5kb3cgYnkgcHJlc3NpbmcNCnRoZSBrZXkgY29tYmluYXRpb24gc3BlYWt1cCBgZjNgLiAg
VXNlIHRoZSByZXZpZXcgY3Vyc29yIHRvIGZpbmQgdGhlIGZpcnN0DQpjaGFyYWN0ZXIgdGhh
dCBmb2xsb3dzIHlvdXIgc2hlbGwgcHJvbXB0LiAgUHJlc3Mgc3BlYWt1cCArIGBmMmAgdHdp
Y2UsIHRvDQpkZWZpbmUgYSBvbmUtbGluZSB3aW5kb3cuICBUaGUgYm91bmRhcmllcyBvZiB0
aGUgd2luZG93IGFyZSB0aGUNCmNoYXJhY3RlciBmb2xsb3dpbmcgdGhlIHNoZWxsIHByb21w
dCBhbmQgdGhlIGVuZCBvZiB0aGUgbGluZS4gIE5vdywgY3ljbGUNCnRocm91Z2ggdGhlIGN1
cnNvciB0cmFja2luZyBtb2RlcyB1c2luZyBrZXlwYWQgYXN0ZXJpc2ssIHVudGlsIFNwZWFr
dXANCnNheXMgInJlYWQgd2luZG93LiIgIE1vdmUgdGhyb3VnaCB5b3VyIGhpc3RvcnkgdXNp
bmcgeW91ciBhcnJvdyBrZXlzLg0KWW91IHdpbGwgbm90aWNlIHRoYXQgU3BlYWt1cCBubyBs
b25nZXIgc3BlYWtzIHRoZSByZWR1bmRhbnQgcHJvbXB0Lg0KDQpTb21lIGZvbGtzIGxpa2Ug
dG8gdHVybiBjdXJzb3IgdHJhY2tpbmcgb2ZmIHdoaWxlIHRoZXkgYXJlIHVzaW5nIHRoZQ0K
bHlueCB3ZWIgYnJvd3Nlci4gIFlvdSBkZWZpbml0ZWx5IHdhbnQgdG8gdHVybiBjdXJzb3Ig
dHJhY2tpbmcgb2ZmIHdoZW4NCnlvdSBhcmUgdXNpbmcgdGhlIGFsc2FtaXhlciBhcHBsaWNh
dGlvbi4gIE90aGVyd2lzZSwgeW91IHdvbid0IGJlIGFibGUNCnRvIGhlYXIgeW91ciBtaXhl
ciBzZXR0aW5ncyB3aGlsZSB5b3UgYXJlIHVzaW5nIHRoZSBhcnJvdyBrZXlzLg0KDQoNCjEx
LiAgQ3V0IGFuZCBQYXN0ZQ0KPT09PT09PT09PT09PT09PT09DQoNCk9uZSBvZiBTcGVha3Vw
J3MgbW9yZSB1c2VmdWwgZmVhdHVyZXMgaXMgdGhlIGFiaWxpdHkgdG8gY3V0IGFuZCBwYXN0
ZQ0KdGV4dCBvbiB0aGUgc2NyZWVuLiAgVGhpcyBtZWFucyB0aGF0IHlvdSBjYW4gY2FwdHVy
ZSBpbmZvcm1hdGlvbiBmcm9tIGENCnByb2dyYW0sIGFuZCBwYXN0ZSB0aGF0IGNhcHR1cmVk
IHRleHQgaW50byBhIGRpZmZlcmVudCBwbGFjZSBpbiB0aGUNCnByb2dyYW0sIG9yIGludG8g
YW4gZW50aXJlbHkgZGlmZmVyZW50IHByb2dyYW0sIHdoaWNoIG1heSBldmVuIGJlDQpydW5u
aW5nIG9uIGEgZGlmZmVyZW50IGNvbnNvbGUuDQoNCkZvciBleGFtcGxlLCBpbiB0aGlzIG1h
bnVhbCwgd2UgaGF2ZSBtYWRlIHJlZmVyZW5jZXMgdG8gc2V2ZXJhbCB3ZWINCnNpdGVzLiAg
SXQgd291bGQgYmUgbmljZSBpZiB5b3UgY291bGQgY3V0IGFuZCBwYXN0ZSB0aGVzZSB1cmxz
IGludG8geW91cg0Kd2ViIGJyb3dzZXIuICBTcGVha3VwIGRvZXMgdGhpcyBxdWl0ZSBuaWNl
bHkuICBTdXBwb3NlIHlvdSB3YW50ZWQgdG8NCnBhc3QgdGhlIGZvbGxvd2luZyB1cmwgaW50
byB5b3VyIGJyb3dzZXI6DQoNCmh0dHA6Ly9saW51eC1zcGVha3VwLm9yZy8NCg0KVXNlIHRo
ZSBzcGVha3VwIHJldmlldyBrZXlzIHRvIHBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNvciBv
biB0aGUgZmlyc3QNCmNoYXJhY3RlciBvZiB0aGUgYWJvdmUgdXJsLiAgV2hlbiB0aGUgcmVh
ZGluZyBjdXJzb3IgaXMgaW4gcG9zaXRpb24sDQpwcmVzcyB0aGUga2V5cGFkIHNsYXNoIGtl
eSBvbmNlLiAgU3BlYWt1cCB3aWxsIHNheSwgIm1hcmsiLiAgTmV4dCwNCnBvc2l0aW9uIHRo
ZSByZWFkaW5nIGN1cnNvciBvbiB0aGUgcmlnaHRtb3N0IGNoYXJhY3RlciBvZiB0aGUgYWJv
dmUNCnVybC4gUHJlc3MgdGhlIGtleXBhZCBzbGFzaCBrZXkgb25jZSBhZ2FpbiB0byBhY3R1
YWxseSBjdXQgdGhlIHRleHQNCmZyb20gdGhlIHNjcmVlbi4gIFNwZWFrdXAgd2lsbCBzYXks
ICJjdXQiLiAgQWx0aG91Z2ggd2UgY2FsbCB0aGlzDQpjdXR0aW5nLCBTcGVha3VwIGRvZXMg
bm90IGFjdHVhbGx5IGRlbGV0ZSB0aGUgY3V0IHRleHQgZnJvbSB0aGUgc2NyZWVuLg0KSXQg
bWFrZXMgYSBjb3B5IG9mIHRoZSB0ZXh0IGluIGEgc3BlY2lhbCBidWZmZXIgZm9yIGxhdGVy
IHBhc3RpbmcuDQoNCk5vdyB0aGF0IHlvdSBoYXZlIHRoZSB1cmwgY3V0IGZyb20gdGhlIHNj
cmVlbiwgeW91IGNhbiBwYXN0ZSBpdCBpbnRvDQp5b3VyIGJyb3dzZXIsIG9yIGV2ZW4gcGFz
dGUgdGhlIHVybCBvbiBhIGNvbW1hbmQgbGluZSBhcyBhbiBhcmd1bWVudCB0bw0KeW91ciBi
cm93c2VyLg0KDQpTdXBwb3NlIHlvdSB3YW50IHRvIHN0YXJ0IGx5bnggYW5kIGdvIHRvIHRo
ZSBTcGVha3VwIHNpdGUuDQoNCllvdSBjYW4gc3dpdGNoIHRvIGEgZGlmZmVyZW50IGNvbnNv
bGUgd2l0aCB0aGUgYWx0IGxlZnQgYW5kIHJpZ2h0DQphcnJvd3MsIG9yIHlvdSBjYW4gc3dp
dGNoIHRvIGEgc3BlY2lmaWMgY29uc29sZSBieSB0eXBpbmcgYWx0IGFuZCBhDQpmdW5jdGlv
biBrZXkuICBUaGVzZSBhcmUgbm90IFNwZWFrdXAgY29tbWFuZHMsIGp1c3Qgc3RhbmRhcmQg
TGludXgNCmNvbnNvbGUgY2FwYWJpbGl0aWVzLg0KDQpPbmNlIHlvdSd2ZSBjaGFuZ2VkIHRv
IGFuIGFwcHJvcHJpYXRlIGNvbnNvbGUsIGFuZCBhcmUgYXQgYSBzaGVsbCBwcm9tcHQsDQp0
eXBlIHRoZSB3b3JkIGx5bngsIGZvbGxvd2VkIGJ5IGEgc3BhY2UuICBOb3cgcHJlc3MgYW5k
IGhvbGQgdGhlIHNwZWFrdXANCmtleSwgd2hpbGUgeW91IHR5cGUgdGhlIGtleXBhZCBzbGFz
aCBjaGFyYWN0ZXIuICBUaGUgdXJsIHdpbGwgYmUgcGFzdGVkDQpvbnRvIHRoZSBjb21tYW5k
IGxpbmUsIGp1c3QgYXMgdGhvdWdoIHlvdSBoYWQgdHlwZWQgaXQgaW4uICBQcmVzcyB0aGUN
CmVudGVyIGtleSB0byBleGVjdXRlIHRoZSBjb21tYW5kLg0KDQpUaGUgcGFzdGUgYnVmZmVy
IHdpbGwgY29udGludWUgdG8gaG9sZCB0aGUgY3V0IGluZm9ybWF0aW9uLCB1bnRpbCBhIG5l
dw0KbWFyayBhbmQgY3V0IG9wZXJhdGlvbiBpcyBjYXJyaWVkIG91dC4gIFRoaXMgbWVhbnMg
eW91IGNhbiBwYXN0ZSB0aGUgY3V0DQppbmZvcm1hdGlvbiBhcyBtYW55IHRpbWVzIGFzIHlv
dSBsaWtlIGJlZm9yZSBkb2luZyBhbm90aGVyIGN1dA0Kb3BlcmF0aW9uLg0KDQpZb3UgYXJl
IG5vdCBsaW1pdGVkIHRvIGN1dHRpbmcgYW5kIHBhc3Rpbmcgb25seSBvbmUgbGluZSBvbiB0
aGUgc2NyZWVuLg0KWW91IGNhbiBhbHNvIGN1dCBhbmQgcGFzdGUgcmVjdGFuZ3VsYXIgcmVn
aW9ucyBvZiB0aGUgc2NyZWVuLiAgSnVzdA0KcG9zaXRpb24gdGhlIHJlYWRpbmcgY3Vyc29y
IGF0IHRoZSB0b3AgbGVmdCBjb3JuZXIgb2YgdGhlIHRleHQgdG8gYmUNCmN1dCwgbWFyayBp
dCB3aXRoIHRoZSBrZXlwYWQgc2xhc2gga2V5LCB0aGVuIHBvc2l0aW9uIHRoZSByZWFkaW5n
IGN1cnNvcg0KYXQgdGhlIGJvdHRvbSByaWdodCBjb3JuZXIgb2YgdGhlIHJlZ2lvbiB0byBi
ZSBjdXQsIGFuZCBjdXQgaXQgd2l0aCB0aGUNCmtleXBhZCBzbGFzaCBrZXkuDQoNCg0KMTIu
ICBDaGFuZ2luZyB0aGUgUHJvbnVuY2lhdGlvbiBvZiBDaGFyYWN0ZXJzDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KVGhyb3VnaCB0aGUgYGAv
c3BlYWt1cC9pMThuL2NoYXJhY3RlcnNgYCBzeXMgZW50cnksIFNwZWFrdXAgZ2l2ZXMgeW91
IHRoZQ0KYWJpbGl0eSB0byBjaGFuZ2UgaG93IFNwZWFrdXAgcHJvbm91bmNlcyBhIGdpdmVu
IGNoYXJhY3Rlci4gIFlvdSBjb3VsZCwNCmZvciBleGFtcGxlLCBjaGFuZ2UgaG93IHNvbWUg
cHVuY3R1YXRpb24gY2hhcmFjdGVycyBhcmUgc3Bva2VuLiAgWW91IGNhbg0KZXZlbiBjaGFu
Z2UgaG93IFNwZWFrdXAgd2lsbCBwcm9ub3VuY2UgY2VydGFpbiBsZXR0ZXJzLg0KDQpZb3Ug
bWF5LCBmb3IgZXhhbXBsZSwgd2lzaCB0byBjaGFuZ2UgaG93IFNwZWFrdXAgcHJvbm91bmNl
cyB0aGUgeg0KY2hhcmFjdGVyLiAgVGhlIGF1dGhvciBvZiBTcGVha3VwLCBLaXJrIFJlaXNl
ciwgaXMgQ2FuYWRpYW4sIGFuZCB0aHVzDQpiZWxpZXZlcyB0aGF0IHRoZSB6IHNob3VsZCBi
ZSBwcm9ub3VuY2VkIHplZC4gIElmIHlvdSBhcmUgYW4gQW1lcmljYW4sDQp5b3UgbWlnaHQg
d2lzaCB0byB1c2UgdGhlIHplZSBwcm9udW5jaWF0aW9uIGluc3RlYWQgb2YgemVkLiAgWW91
IGNhbg0KY2hhbmdlIHRoZSBwcm9udW5jaWF0aW9uIG9mIGJvdGggdGhlIHVwcGVyIGFuZCBs
b3dlciBjYXNlIHogd2l0aCB0aGUNCmZvbGxvd2luZyB0d28gY29tbWFuZHM6Og0KDQogIGVj
aG8gOTAgemVlID4vc3BlYWt1cC9jaGFyYWN0ZXJzDQogIGVjaG8gMTIyIHplZSA+L3NwZWFr
dXAvY2hhcmFjdGVycw0KDQpMZXQncyBleGFtaW5lIHRoZSBwYXJ0cyBvZiB0aGUgdHdvIHBy
ZXZpb3VzIGNvbW1hbmRzLiAgVGhleSBhcmUgaXNzdWVkDQphdCB0aGUgc2hlbGwgcHJvbXB0
LCBhbmQgY291bGQgYmUgcGxhY2VkIGluIGEgc3RhcnR1cCBzY3JpcHQuDQoNClRoZSB3b3Jk
IGVjaG8gdGVsbHMgdGhlIHNoZWxsIHRoYXQgeW91IHdhbnQgdG8gaGF2ZSBpdCBkaXNwbGF5
IHRoZQ0Kc3RyaW5nIG9mIGNoYXJhY3RlcnMgdGhhdCBmb2xsb3cgdGhlIHdvcmQgZWNoby4g
IElmIHlvdSB3ZXJlIHRvIGp1c3QNCnR5cGU6Og0KDQogIGVjaG8gaGVsbG8uDQoNCllvdSB3
b3VsZCBnZXQgdGhlIHdvcmQgaGVsbG8gcHJpbnRlZCBvbiB5b3VyIHNjcmVlbiBhcyBzb29u
IGFzIHlvdQ0KcHJlc3NlZCB0aGUgZW50ZXIga2V5LiAgSW4gdGhpcyBjYXNlLCB3ZSBhcmUg
ZWNob2luZyBzdHJpbmdzIHRoYXQgd2UNCndhbnQgdG8gYmUgcmVkaXJlY3RlZCBpbnRvIHRo
ZSBzeXMgc3lzdGVtLg0KDQpUaGUgbnVtYmVycyA5MCBhbmQgMTIyIGluIHRoZSBhYm92ZSBl
Y2hvIGNvbW1hbmRzIGFyZSB0aGUgYXNjaWkgbnVtZXJpYw0KdmFsdWVzIGZvciB0aGUgdXBw
ZXIgYW5kIGxvd2VyIGNhc2UgeiwgdGhlIGNoYXJhY3RlcnMgd2Ugd2lzaCB0byBjaGFuZ2Uu
DQoNClRoZSBzdHJpbmcgemVlIGlzIHRoZSBwcm9udW5jaWF0aW9uIHRoYXQgd2Ugd2FudCBT
cGVha3VwIHRvIHVzZSBmb3IgdGhlDQp1cHBlciBhbmQgbG93ZXIgY2FzZSB6Lg0KDQpUaGUg
YGA+YGAgc3ltYm9sIHJlZGlyZWN0cyB0aGUgb3V0cHV0IG9mIHRoZSBlY2hvIGNvbW1hbmQg
dG8gYSBmaWxlLCBqdXN0DQpsaWtlIGluIERPUywgb3IgYXQgdGhlIFdpbmRvd3MgY29tbWFu
ZCBwcm9tcHQuDQoNCkFuZCBmaW5hbGx5LCBgYC9zcGVha3VwL2kxOG4vY2hhcmFjdGVyc2Bg
IGlzIHRoZSBmaWxlIGVudHJ5IGluIHRoZSBzeXMgc3lzdGVtDQp3aGVyZSB3ZSB3YW50IHRo
ZSBvdXRwdXQgdG8gYmUgZGlyZWN0ZWQuICBTcGVha3VwIGxvb2tzIGF0IHRoZSBudW1lcmlj
DQp2YWx1ZSBvZiB0aGUgY2hhcmFjdGVyIHdlIHdhbnQgdG8gY2hhbmdlLCBhbmQgaW5zZXJ0
cyB0aGUgcHJvbnVuY2lhdGlvbg0Kc3RyaW5nIGludG8gYW4gaW50ZXJuYWwgdGFibGUuDQoN
CllvdSBjYW4gbG9vayBhdCB0aGUgd2hvbGUgdGFibGUgd2l0aCB0aGUgZm9sbG93aW5nIGNv
bW1hbmQ6Og0KDQogIGNhdCAvc3BlYWt1cC9pMThuL2NoYXJhY3RlcnMNCg0KU3BlYWt1cCB3
aWxsIHRoZW4gcHJpbnQgb3V0IHRoZSBlbnRpcmUgY2hhcmFjdGVyIHByb251bmNpYXRpb24g
dGFibGUuICBJDQp3b24ndCBkaXNwbGF5IGl0IGhlcmUsIGJ1dCBsZWF2ZSB5b3UgdG8gbG9v
ayBhdCBpdCBhdCB5b3VyIGNvbnZlbmllbmNlLg0KDQoNCjEzLiAgTWFwcGluZyBLZXlzDQo9
PT09PT09PT09PT09PT09PQ0KDQpTcGVha3VwIGhhcyB0aGUgY2FwYWJpbGl0eSBvZiBhbGxv
d2luZyB5b3UgdG8gYXNzaWduIG9yICJtYXAiIGtleXMgdG8NCmludGVybmFsIFNwZWFrdXAg
Y29tbWFuZHMuICBUaGlzIHNlY3Rpb24gbmVjZXNzYXJpbHkgYXNzdW1lcyB5b3UgaGF2ZSBh
DQpMaW51eCBrZXJuZWwgc291cmNlIHRyZWUgaW5zdGFsbGVkLCBhbmQgdGhhdCBpdCBoYXMg
YmVlbiBwYXRjaGVkIGFuZA0KY29uZmlndXJlZCB3aXRoIFNwZWFrdXAuICBIb3cgeW91IGRv
IHRoaXMgaXMgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzDQptYW51YWwuICBGb3IgdGhpcyBp
bmZvcm1hdGlvbiwgdmlzaXQgdGhlIFNwZWFrdXAgd2ViIHNpdGUgYXQNCmh0dHA6Ly9saW51
eC1zcGVha3VwLm9yZy8uICBUaGUgcmVhc29uIHlvdSdsbCBuZWVkIHRoZSBrZXJuZWwgc291
cmNlDQp0cmVlIHBhdGNoZWQgd2l0aCBTcGVha3VwIGlzIHRoYXQgdGhlIGdlbm1hcCB1dGls
aXR5IHlvdSdsbCBuZWVkIGZvcg0KcHJvY2Vzc2luZyBrZXltYXBzIGlzIGluIHRoZQ0KYGAv
dXNyL3NyYy9saW51eC08dmVyc2lvbl9udW1iZXI+L2RyaXZlcnMvY2hhci9zcGVha3VwYGAg
ZGlyZWN0b3J5LiAgVGhlDQpgYDx2ZXJzaW9uX251bWJlcj5gYCBpbiB0aGUgYWJvdmUgZGly
ZWN0b3J5IHBhdGggaXMgdGhlIHZlcnNpb24gbnVtYmVyIG9mDQp0aGUgTGludXggc291cmNl
IHRyZWUgeW91IGFyZSB3b3JraW5nIHdpdGguDQoNClNvIG9rLCB5b3UndmUgZ29uZSBvZmYg
YW5kIGdvdHRlbiB5b3VyIGtlcm5lbCBzb3VyY2UgdHJlZSwgYW5kIHBhdGNoZWQNCmFuZCBj
b25maWd1cmVkIGl0LiAgTm93IHlvdSBjYW4gc3RhcnQgbWFuaXB1bGF0aW5nIGtleW1hcHMu
DQoNCllvdSBjYW4gZWl0aGVyIHVzZSB0aGUNCmBgL3Vzci9zcmMvbGludXgtPHZlcnNpb25f
bnVtYmVyPi9kcml2ZXJzL2NoYXIvc3BlYWt1cC9zcGVha3VwbWFwLm1hcGBgIGZpbGUNCmlu
Y2x1ZGVkIHdpdGggdGhlIFNwZWFrdXAgc291cmNlLCBvciB5b3UgY2FuIGN1dCBhbmQgcGFz
dGUgdGhlIGNvcHkgaW4NCnNlY3Rpb24gNCBpbnRvIGEgc2VwYXJhdGUgZmlsZS4gIElmIHlv
dSB1c2UgdGhlIG9uZSBpbiB0aGUgU3BlYWt1cA0Kc291cmNlIHRyZWUsIG1ha2Ugc3VyZSB5
b3UgbWFrZSBhIGJhY2t1cCBvZiBpdCBiZWZvcmUgeW91IHN0YXJ0IG1ha2luZw0KY2hhbmdl
cy4gIFlvdSBoYXZlIGJlZW4gd2FybmVkIQ0KDQpTdXBwb3NlIHRoYXQgeW91IHdhbnQgdG8g
c3dhcCB0aGUga2V5IGFzc2lnbm1lbnRzIGZvciB0aGUgU3BlYWt1cA0Kc2F5X2xhc3RfY2hh
ciBhbmQgdGhlIFNwZWFrdXAgc2F5X2ZpcnN0X2NoYXIgY29tbWFuZHMuICBUaGUNCnNwZWFr
dXBtYXAubWFwIGxpc3RzIHRoZSBrZXkgbWFwcGluZ3MgZm9yIHRoZXNlIHR3byBjb21tYW5k
cyBhcyBmb2xsb3dzOjoNCg0KICBzcGsga2V5X3BhZ2V1cCA9IHNheV9maXJzdF9jaGFyDQog
IHNwayBrZXlfcGFnZWRvd24gPSBzYXlfbGFzdF9jaGFyDQoNCllvdSBjYW4gZWRpdCB5b3Vy
IGNvcHkgb2YgdGhlIHNwZWFrdXBtYXAubWFwIGZpbGUgYW5kIHN3YXAgdGhlIGNvbW1hbmQN
Cm5hbWVzIG9uIHRoZSByaWdodCBzaWRlIG9mIHRoZSBgYD1gYCAoZXF1YWxzKSBzaWduLiAg
WW91IGRpZCBtYWtlIGEgYmFja3VwLA0KcmlnaHQ/ICBUaGUgbmV3IGtleW1hcCBsaW5lcyB3
b3VsZCBsb29rIGxpa2UgdGhpczo6DQoNCiAgc3BrIGtleV9wYWdldXAgPSBzYXlfbGFzdF9j
aGFyDQogIHNwayBrZXlfcGFnZWRvd24gPSBzYXlfZmlyc3RfY2hhcg0KDQpBZnRlciB5b3Ug
ZWRpdCB5b3VyIGNvcHkgb2YgdGhlIHNwZWFrdXBtYXAubWFwIGZpbGUsIHNhdmUgaXQgdW5k
ZXIgYSBuZXcNCmZpbGUgbmFtZSwgcGVyaGFwcyBuZXdtYXAubWFwLiAgVGhlbiBleGl0IHlv
dXIgZWRpdG9yIGFuZCByZXR1cm4gdG8gdGhlDQpzaGVsbCBwcm9tcHQuDQoNCllvdSBhcmUg
bm93IHJlYWR5IHRvIGxvYWQgeW91ciBrZXltYXAgd2l0aCB5b3VyIHN3YXBwZWQga2V5IGFz
c2lnbm1lbnRzLg0KQXNzdW1pbmcgdGhhdCB5b3Ugc2F2ZWQgeW91ciBuZXcga2V5bWFwIGFz
IHRoZSBmaWxlIG5ld21hcC5tYXAsIHlvdQ0Kd291bGQgbG9hZCB5b3VyIGtleW1hcCBpbnRv
IHRoZSBzeXMgc3lzdGVtIGxpa2UgdGhpczo6DQoNCiAgL3Vzci9zcmMvbGludXgtPHZlcnNp
b25fbnVtYmVyPi9kcml2ZXJzL2NoYXIvc3BlYWt1cC9nZW5tYXAgbmV3bWFwLm1hcCA+L3Nw
ZWFrdXAva2V5bWFwDQoNCg0KLi4gbm90ZTo6DQoNCiAgUmVtZW1iZXIgdG8gc3Vic3RpdHV0
ZSB5b3VyIGtlcm5lbCB2ZXJzaW9uIG51bWJlciBmb3IgdGhlDQogIGBgPHZlcnNpb25fbnVt
YmVyPmBgIGluIHRoZSBhYm92ZSBjb21tYW5kLg0KDQpZb3VyIHNheSBmaXJzdCBhbmQgc2F5
IGxhc3QgY2hhcmFjdGVycyBzaG91bGQgbm93IGJlIHN3YXBwZWQuICBQcmVzc2luZw0Kc3Bl
YWt1cCBwYWdlZG93biBzaG91bGQgcmVhZCB5b3UgdGhlIGZpcnN0IG5vbi13aGl0ZXNwYWNl
IGNoYXJhY3RlciBvbg0KdGhlIGxpbmUgeW91ciByZWFkaW5nIGN1cnNvciBpcyBpbiwgYW5k
IHByZXNzaW5nIHNwZWFrdXAgcGFnZXVwIHNob3VsZA0KcmVhZCB5b3UgdGhlIGxhc3QgY2hh
cmFjdGVyIG9uIHRoZSBsaW5lIHlvdXIgcmVhZGluZyBjdXJzb3IgaXMgaW4uDQoNCi4uIG5v
dGU6Og0KDQogIFRoZXNlIG5ldyBtYXBwaW5ncyB3aWxsIG9ubHkgc3RheSBpbiBlZmZlY3Qg
dW50aWwgeW91IHJlYm9vdCwNCiAgb3IgdW50aWwgeW91IGxvYWQgYW5vdGhlciBrZXltYXAu
DQoNCk9uZSBmaW5hbCB3YXJuaW5nLiAgSWYgeW91IHRyeSB0byBsb2FkIGEgcGFydGlhbCBt
YXAsIHlvdSB3aWxsIHF1aWNrbHkNCmZpbmQgdGhhdCBhbGwgdGhlIG1hcHBpbmdzIHlvdSBk
aWRuJ3QgaW5jbHVkZSBpbiB5b3VyIGZpbGUgZ290IGRlbGV0ZWQNCmZyb20gdGhlIHdvcmtp
bmcgbWFwLiAgQmUgZXh0cmVtZWx5IGNhcmVmdWwsIGFuZCBhbHdheXMgbWFrZSBhIGJhY2t1
cCENCllvdSBoYXZlIGJlZW4gd2FybmVkIQ0KDQoNCjE0LiAgSW50ZXJuYXRpb25hbGl6aW5n
IFNwZWFrdXANCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KU3BlYWt1cCBp
bmRpY2F0ZXMgdmFyaW91cyBjb25kaXRpb25zIHRvIHRoZSB1c2VyIGJ5IHNwZWFraW5nIG1l
c3NhZ2VzLg0KRm9yIGluc3RhbmNlLCB3aGVuIHlvdSBtb3ZlIHRvIHRoZSBsZWZ0IGVkZ2Ug
b2YgdGhlIHNjcmVlbiB3aXRoIHRoZQ0KcmV2aWV3IGtleXMsIFNwZWFrdXAgc2F5cywgImxl
ZnQuIg0KUHJpb3IgdG8gdmVyc2lvbiAzLjEuMCBvZiBTcGVha3VwLCBhbGwgb2YgdGhlc2Ug
bWVzc2FnZXMgd2VyZSBpbiBFbmdsaXNoLA0KYW5kIHRoZXkgY291bGQgbm90IGJlIGNoYW5n
ZWQuICBJZiB5b3UgdXNlZCBhIG5vbi1FbmdsaXNoIHN5bnRoZXNpemVyLA0KeW91IHN0aWxs
IGhlYXJkIEVuZ2xpc2ggbWVzc2FnZXMsIHN1Y2ggYXMgImxlZnQiIGFuZCAiY3Vyc29yaW5n
IG9uLiINCkluIHZlcnNpb24gMy4xLjAgb3IgaGlnaGVyLCBvbmUgbWF5IGxvYWQgdHJhbnNs
YXRpb25zIGZvciB0aGUgdmFyaW91cw0KbWVzc2FnZXMgdmlhIHRoZSBgYC9zeXNgYCBmaWxl
c3lzdGVtLg0KDQpUaGUgZGlyZWN0b3J5IGBgL3NwZWFrdXAvaTE4bmBgIGNvbnRhaW5zIHNl
dmVyYWwgY29sbGVjdGlvbnMgb2YgbWVzc2FnZXMuDQpFYWNoIGdyb3VwIG9mIG1lc3NhZ2Vz
IGlzIHN0b3JlZCBpbiBpdHMgb3duIGZpbGUuDQpUaGUgZm9sbG93aW5nIHNlY3Rpb24gbGlz
dHMgYWxsIG9mIHRoZXNlIGZpbGVzLCBhbG9uZyB3aXRoIGEgYnJpZWYgZGVzY3JpcHRpb24N
Cm9mIGVhY2guDQoNCjE0LjEuICBGaWxlcyBVbmRlciB0aGUgaTE4biBTdWJkaXJlY3RvcnkN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KYW5ub3VuY2Vt
ZW50cw0KICBUaGlzIGZpbGUgY29udGFpbnMgdmFyaW91cyBnZW5lcmFsIGFubm91bmNlbWVu
dHMsIG1vc3Qgb2Ygd2hpY2ggY2Fubm90DQogIGJlIGNhdGVnb3JpemVkLiAgWW91IHdpbGwg
ZmluZCBtZXNzYWdlcyBzdWNoIGFzICJZb3Uga2lsbGVkIFNwZWFrdXAiLA0KICAiSSdtIGFs
aXZlIiwgImxlYXZpbmcgaGVscCIsICJwYXJrZWQiLCAidW5wYXJrZWQiLCBhbmQgb3RoZXJz
Lg0KICBZb3Ugd2lsbCBhbHNvIGZpbmQgdGhlIG5hbWVzIG9mIHRoZSBzY3JlZW4gZWRnZXMg
YW5kIGN1cnNvciB0cmFja2luZyBtb2Rlcw0KICBoZXJlLg0KDQpjaGFyYWN0ZXJzDQogIFNl
ZSBgMTIuICBDaGFuZ2luZyB0aGUgUHJvbnVuY2lhdGlvbiBvZiBDaGFyYWN0ZXJzYF8gZm9y
IGEgZGVzY3JpcHRpb24NCiAgb2YgdGhpcyBmaWxlLg0KDQpjaGFydGFiDQogIFNlZSBgMTIu
ICBDaGFuZ2luZyB0aGUgUHJvbnVuY2lhdGlvbiBvZiBDaGFyYWN0ZXJzYF8uICBVbmxpa2Ug
dGhlIHJlc3QNCiAgb2YgdGhlIGZpbGVzIGluIHRoZSBpMThuIHN1YmRpcmVjdG9yeSwgdGhp
cyBvbmUgZG9lcyBub3QgY29udGFpbiBtZXNzYWdlcw0KICB0byBiZSBzcG9rZW4uDQoNCmNv
bG9ycw0KICBXaGVuIHlvdSB1c2UgdGhlICJzYXkgYXR0cmlidXRlcyIgZnVuY3Rpb24sIFNw
ZWFrdXAgc2F5cyB0aGUgbmFtZSBvZiB0aGUNCiAgZm9yZWdyb3VuZCBhbmQgYmFja2dyb3Vu
ZCBjb2xvcnMuICBUaGVzZSBuYW1lcyBjb21lIGZyb20gdGhlIGkxOG4vY29sb3JzDQogIGZp
bGUuDQoNCmN0bF9rZXlzDQogIEhlcmUsIHlvdSB3aWxsIGZpbmQgbmFtZXMgb2YgY29udHJv
bCBrZXlzLiAgVGhlc2UgYXJlIHVzZWQgd2l0aCBTcGVha3VwJ3MNCiAgc2F5X2NvbnRyb2wg
ZmVhdHVyZS4NCg0KZm9ybWF0dGVkDQogIFRoaXMgZ3JvdXAgb2YgbWVzc2FnZXMgY29udGFp
bnMgZW1iZWRkZWQgZm9ybWF0dGluZyBjb2RlcywgdG8gc3BlY2lmeQ0KICB0aGUgdHlwZSBh
bmQgd2lkdGggb2YgZGlzcGxheWVkIGRhdGEuICBJZiB5b3UgY2hhbmdlIHRoZXNlLCB5b3Ug
bXVzdA0KICBwcmVzZXJ2ZSBhbGwgb2YgdGhlIGZvcm1hdHRpbmcgY29kZXMsIGFuZCB0aGV5
IG11c3QgYXBwZWFyIGluIHRoZSBvcmRlcg0KICB1c2VkIGJ5IHRoZSBkZWZhdWx0IG1lc3Nh
Z2VzLg0KDQpmdW5jdGlvbl9uYW1lcw0KICBIZXJlLCB5b3Ugd2lsbCBmaW5kIGEgbGlzdCBv
ZiBuYW1lcyBmb3IgU3BlYWt1cCBmdW5jdGlvbnMuICBUaGVzZSBhcmUgdXNlZA0KICBieSB0
aGUgaGVscCBzeXN0ZW0uICBGb3IgZXhhbXBsZSwgc3VwcG9zZSB0aGF0IHlvdSBoYXZlIGFj
dGl2YXRlZCBoZWxwIG1vZGUsDQogIGFuZCB5b3UgcHJlc3NlZCBrZXlwYWQgMy4gIFNwZWFr
dXAgc2F5czoNCiAgImtleXBhZCAzIGlzIGNoYXJhY3Rlciwgc2F5IG5leHQuIg0KICBUaGUg
bWVzc2FnZSAiY2hhcmFjdGVyLCBzYXkgbmV4dCIgbmFtZXMgYSBTcGVha3VwIGZ1bmN0aW9u
LCBhbmQgaXQNCiAgY29tZXMgZnJvbSB0aGlzIGZ1bmN0aW9uX25hbWVzIGZpbGUuDQoNCmtl
eV9uYW1lcw0KICBBZ2Fpbiwga2V5X25hbWVzIGlzIHVzZWQgYnkgU3BlYWt1cCdzIGhlbHAg
c3lzdGVtLiAgSW4gdGhlIHByZXZpb3VzDQogIGV4YW1wbGUsIFNwZWFrdXAgc2FpZCB0aGF0
IHlvdSBwcmVzc2VkICJrZXlwYWQgMy4iDQogIFRoaXMgbmFtZSBjYW1lIGZyb20gdGhlIGtl
eV9uYW1lcyBmaWxlLg0KDQpzdGF0ZXMNCiAgVGhpcyBmaWxlIGNvbnRhaW5zIG5hbWVzIGZv
ciBrZXkgc3RhdGVzLg0KICBBZ2FpbiwgdGhlc2UgYXJlIHBhcnQgb2YgdGhlIGhlbHAgc3lz
dGVtLiAgRm9yIGluc3RhbmNlLCBpZiB5b3UgaGFkIHByZXNzZWQNCiAgc3BlYWt1cCArIGtl
eXBhZCAzLCB5b3Ugd291bGQgaGVhcjoNCiAgInNwZWFrdXAga2V5cGFkIDMgaXMgZ28gdG8g
Ym90dG9tIGVkZ2UuIg0KICBUaGUgc3BlYWt1cCBrZXkgaXMgZGVwcmVzc2VkLCBzbyB0aGUg
bmFtZSBvZiB0aGUga2V5IHN0YXRlIGlzIHNwZWFrdXAuDQogIFRoaXMgcGFydCBvZiB0aGUg
bWVzc2FnZSBjb21lcyBmcm9tIHRoZSBzdGF0ZXMgY29sbGVjdGlvbi4NCg0KMTQuMi4xLiAg
TG9hZGluZyBZb3VyIE93biBNZXNzYWdlcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KDQpUaGUgZmlsZXMgdW5kZXIgdGhlIGkxOG4gc3ViZGlyZWN0b3J5IGFsbCBm
b2xsb3cgdGhlIHNhbWUgZm9ybWF0Lg0KVGhleSBjb25zaXN0IG9mIGxpbmVzLCB3aXRoIG9u
ZSBtZXNzYWdlIHBlciBsaW5lLg0KRWFjaCBtZXNzYWdlIGlzIHJlcHJlc2VudGVkIGJ5IGEg
bnVtYmVyLCBmb2xsb3dlZCBieSB0aGUgdGV4dCBvZiB0aGUgbWVzc2FnZS4NClRoZSBudW1i
ZXIgaXMgdGhlIHBvc2l0aW9uIG9mIHRoZSBtZXNzYWdlIGluIHRoZSBnaXZlbiBjb2xsZWN0
aW9uLg0KRm9yIGV4YW1wbGUsIGlmIHlvdSB2aWV3IHRoZSBmaWxlIGBgL3NwZWFrdXAvaTE4
bi9jb2xvcnNgYCwgeW91IHdpbGwgc2VlIHRoZQ0KZm9sbG93aW5nIGxpc3Q6Og0KDQogIDAg
LSBibGFjaw0KICAxIC0gYmx1ZQ0KICAyIC0gZ3JlZW4NCiAgMyAtIGN5YW4NCiAgNCAtIHJl
ZA0KICA1IC0gbWFnZW50YQ0KICA2IC0geWVsbG93DQogIDcgLSB3aGl0ZQ0KICA4IC0gZ3Jl
eQ0KDQpZb3UgY2FuIGNoYW5nZSBvbmUgbWVzc2FnZSwgb3IgeW91IGNhbiBjaGFuZ2UgYSB3
aG9sZSBncm91cC4NClRvIGxvYWQgYSB3aG9sZSBjb2xsZWN0aW9uIG9mIG1lc3NhZ2VzIGZy
b20gYSBuZXcgc291cmNlLCBzaW1wbHkgdXNlDQp0aGUgY3AgY29tbWFuZDo6DQoNCiAgY3Ag
fi9teV9jb2xvcnMgL3NwZWFrdXAvaTE4bi9jb2xvcnMNCg0KWW91IGNhbiBjaGFuZ2UgYW4g
aW5kaXZpZHVhbCBtZXNzYWdlIHdpdGggdGhlIGVjaG8gY29tbWFuZCwNCmFzIHNob3duIGlu
IHRoZSBmb2xsb3dpbmcgZXhhbXBsZS4NCg0KVGhlIFNwYW5pc2ggbmFtZSBmb3IgdGhlIGNv
bG9yIGJsdWUgaXMgYXp1bC4NCkxvb2tpbmcgYXQgdGhlIGNvbG9ycyBmaWxlLCB3ZSBzZWUg
dGhhdCB0aGUgbmFtZSAiYmx1ZSIgaXMgYXQgcG9zaXRpb24gMQ0Kd2l0aGluIHRoZSBjb2xv
cnMgZ3JvdXAuICBMZXQncyBjaGFuZ2UgYmx1ZSB0byBhenVsOjoNCg0KICBlY2hvICcxIGF6
dWwnID4gL3NwZWFrdXAvaTE4bi9jb2xvcnMNCg0KVGhlIG5leHQgdGltZSB0aGF0IFNwZWFr
dXAgc2F5cyBtZXNzYWdlIDEgZnJvbSB0aGUgY29sb3JzIGdyb3VwLCBpdCB3aWxsDQpzYXkg
ImF6dWwiLCByYXRoZXIgdGhhbiAiYmx1ZS4iDQoNCjE0LjIuMi4gQ2hvb3NlIGEgbGFuZ3Vh
Z2UNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KSW4gdGhlIGZ1dHVyZSwgdHJhbnNs
YXRpb25zIGludG8gdmFyaW91cyBsYW5ndWFnZXMgd2lsbCBiZSBtYWRlIGF2YWlsYWJsZSwN
CmFuZCBtb3N0IHVzZXJzIHdpbGwganVzdCBsb2FkIHRoZSBmaWxlcyBuZWNlc3NhcnkgZm9y
IHRoZWlyIGxhbmd1YWdlLiBTbyBmYXIsDQpvbmx5IEZyZW5jaCBsYW5ndWFnZSBpcyBhdmFp
bGFibGUgYmV5b25kIG5hdGl2ZSBDYW5hZGlhbiBFbmdsaXNoIGxhbmd1YWdlLg0KDQpGcmVu
Y2ggaXMgb25seSBhdmFpbGFibGUgYWZ0ZXIgeW91IGFyZSBsb2dnZWQgaW4uDQoNCkNhbmFk
aWFuIEVuZ2xpc2ggaXMgdGhlIGRlZmF1bHQgbGFuZ3VhZ2UuIFRvIHRvZ2dsZSBhbm90aGVy
IGxhbmd1YWdlLA0KZG93bmxvYWQgdGhlIHNvdXJjZSBvZiBTcGVha3VwIGFuZCB1bnRhciBp
dCBpbiB5b3VyIGhvbWUgZGlyZWN0b3J5LiBUaGUNCmZvbGxvd2luZyBjb21tYW5kIHNob3Vs
ZCBsZXQgeW91IGRvIHRoaXM6Og0KDQogIHRhciB4dmpmIHNwZWFrdXAtPHZlcnNpb24+LnRh
ci5iejINCg0Kd2hlcmUgYGA8dmVyc2lvbj5gYCBpcyB0aGUgdmVyc2lvbiBudW1iZXIgb2Yg
dGhlIGFwcGxpY2F0aW9uLg0KDQpOZXh0LCBjaGFuZ2UgdG8gdGhlIG5ld2x5IGNyZWF0ZWQg
ZGlyZWN0b3J5LCB0aGVuIGludG8gdGhlIHRvb2xzLyBkaXJlY3RvcnksIGFuZA0KcnVuIHRo
ZSBzY3JpcHQgc3BlYWt1cF9zZXRsb2NhbGUuIFlvdSBhcmUgYXNrZWQgdGhlIGxhbmd1YWdl
IHRoYXQgeW91IHdhbnQgdG8NCnVzZS4gVHlwZSB0aGUgbnVtYmVyIGFzc29jaWF0ZWQgdG8g
eW91ciBsYW5ndWFnZSAoZS5nLiBmciBmb3IgRnJlbmNoKSB0aGVuIHByZXNzDQpFbnRlci4g
TmVlZGVkIGZpbGVzIGFyZSBjb3BpZWQgaW4gdGhlIGkxOG4gZGlyZWN0b3J5Lg0KDQpOb3Rl
OiB0aGUgc3BlYWt1cGNvbmYgbXVzdCBiZSBpbnN0YWxsZWQgb24geW91ciBzeXN0ZW0gc28g
dGhhdCBzZXR0aW5ncyBhcmUgc2F2ZWQuDQpPdGhlcndpc2UsIHlvdSB3aWxsIGhhdmUgYW4g
ZXJyb3I6IHlvdXIgbGFuZ3VhZ2Ugd2lsbCBiZSBsb2FkZWQgYnV0IHlvdSB3aWxsDQpoYXZl
IHRvIHJ1biB0aGUgc2NyaXB0IGFnYWluIGV2ZXJ5IHRpbWUgU3BlYWt1cCByZXN0YXJ0cy4N
ClNlZSBzZWN0aW9uIDE2LjEuIGZvciBpbmZvcm1hdGlvbiBhYm91dCBzcGVha3VwY29uZi4N
Cg0KWW91IHdpbGwgaGF2ZSB0byByZXBlYXQgdGhlc2Ugc3RlcHMgZm9yIGFueSBjaGFuZ2Ug
b2YgbG9jYWxlLCBpLmUuIGlmIHlvdSB3aXNoDQpjaGFuZ2UgdGhlIHNwZWFrdXAncyBsYW5n
dWFnZSBvciBjaGFyc2V0IChpc28tODg1OS0xNSBvdSBVVEYtOCkuDQoNCklmIHlvdSB3aXNo
IHN0b3JlIHRoZSBzZXR0aW5ncywgbm90ZSB0aGF0IGF0IHlvdXIgbmV4dCBsb2dpbiwgeW91
IHdpbGwgbmVlZCB0bw0KZG86Og0KDQogIHNwZWFrdXAgbG9hZA0KDQpBbHRlcm5hdGl2ZWx5
LCB5b3UgY2FuIGFkZCB0aGUgYWJvdmUgbGluZSB0byB5b3VyIGZpbGUNCmBgfi8uYmFzaHJj
YGAgb3IgYGB+Ly5iYXNoX3Byb2ZpbGVgYC4NCg0KSWYgeW91ciBzeXN0ZW0gYWRtaW5pc3Ry
YXRvciByYW4gaGltc2VsZiB0aGUgc2NyaXB0LCBhbGwgdGhlIHVzZXJzIHdpbGwgYmUgYWJs
ZQ0KdG8gY2hhbmdlIGZyb20gRW5nbGlzaCB0byB0aGUgbGFuZ3VhZ2UgY2hvb3NlZCBieSBy
b290IGFuZCBkbyBkaXJlY3RseQ0Kc3BlYWt1cGNvbmYgbG9hZCAob3IgYWRkIHRoaXMgdG8g
dGhlIGBgfi8uYmFzaHJjYGAgb3INCmBgfi8uYmFzaF9wcm9maWxlYGAgZmlsZSkuIElmIHRo
ZXJlIGFyZSBzZXZlcmFsIGxhbmd1YWdlcyB0byBoYW5kbGUsIHRoZQ0KYWRtaW5pc3RyYXRv
ciAob3IgZXZlcnkgdXNlcikgd2lsbCBoYXZlIHRvIHJ1biB0aGUgZmlyc3Qgc3RlcHMgdW50
aWwgc3BlYWt1cGNvbmYNCnNhdmUsIGNob29zaW5nIHRoZSBhcHByb3ByaWF0ZSBsYW5ndWFn
ZSwgaW4gZXZlcnkgdXNlcidzIGhvbWUgZGlyZWN0b3J5LiBFdmVyeQ0KdXNlciB3aWxsIHRo
ZW4gYmUgYWJsZSB0byBkbyBzcGVha3VwY29uZiBsb2FkLCBTcGVha3VwIHdpbGwgbG9hZCBo
aXMgb3duIHNldHRpbmdzLg0KDQoxNC4zLiAgTm8gU3VwcG9ydCBmb3IgTm9uLVdlc3Rlcm4t
RXVyb3BlYW4gTGFuZ3VhZ2VzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQoNCkFzIG9mIHRoZSBjdXJyZW50IHJlbGVhc2UsIFNwZWFr
dXAgb25seSBzdXBwb3J0cyBXZXN0ZXJuIEV1cm9wZWFuIGxhbmd1YWdlcy4NClN1cHBvcnQg
Zm9yIHRoZSBleHRlbmRlZCBjaGFyYWN0ZXJzIHVzZWQgYnkgbGFuZ3VhZ2VzIG91dHNpZGUg
b2YgdGhlIFdlc3Rlcm4NCkV1cm9wZWFuIGZhbWlseSBvZiBsYW5ndWFnZXMgaXMgYSB3b3Jr
IGluIHByb2dyZXNzLg0KDQoNCjE1LiAgVXNpbmcgU3BlYWt1cCdzIFdpbmRvd2luZyBDYXBh
YmlsaXR5DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpT
cGVha3VwIGhhcyB0aGUgY2FwYWJpbGl0eSBvZiBkZWZpbmluZyBhbmQgbWFuaXB1bGF0aW5n
IHdpbmRvd3Mgb24gdGhlDQpzY3JlZW4uICBTcGVha3VwIHVzZXMgdGhlIHRlcm0gIldpbmRv
dyIsIHRvIG1lYW4gYSB1c2VyIGRlZmluZWQgYXJlYSBvZg0KdGhlIHNjcmVlbi4gIFRoZSBr
ZXkgc3Ryb2tlcyBmb3IgZGVmaW5pbmcgYW5kIG1hbmlwdWxhdGluZyBTcGVha3VwDQp3aW5k
b3dzIGFyZSBhcyBmb2xsb3dzOjoNCg0KICBzcGVha3VwICsgZjIgLS0gU2V0IHRoZSBib3Vu
ZHMgb2YgdGhlIHdpbmRvdy4NCiAgU3BlYWt1cCArIGYzIC0tIGNsZWFyIHRoZSBjdXJyZW50
IHdpbmRvdyBkZWZpbml0aW9uLg0KICBzcGVha3VwICsgZjQgLS0gVG9nZ2xlIHdpbmRvdyBz
aWxlbmNlIG9uIGFuZCBvZmYuDQogIHNwZWFrdXAgKyBrZXlwYWQgcGx1cyAtLSBTYXkgdGhl
IGN1cnJlbnRseSBkZWZpbmVkIHdpbmRvdy4NCg0KVGhlc2UgY2FwYWJpbGl0aWVzIGFyZSB1
c2VmdWwgZm9yIHRyYWNraW5nIGEgY2VydGFpbiBwYXJ0IG9mIHRoZSBzY3JlZW4NCndpdGhv
dXQgcmVyZWFkaW5nIHRoZSB3aG9sZSBzY3JlZW4sIG9yIGZvciBzaWxlbmNpbmcgYSBwYXJ0
IG9mIHRoZQ0Kc2NyZWVuIHRoYXQgaXMgY29uc3RhbnRseSBjaGFuZ2luZywgc3VjaCBhcyBh
IGNsb2NrIG9yIHN0YXR1cyBsaW5lLg0KDQpUaGVyZSBpcyBubyB3YXkgdG8gc2F2ZSB0aGVz
ZSB3aW5kb3cgc2V0dGluZ3MsIGFuZCB5b3UgY2FuIG9ubHkgaGF2ZSBvbmUNCndpbmRvdyBk
ZWZpbmVkIGZvciBlYWNoIHZpcnR1YWwgY29uc29sZS4gIFRoZXJlIGlzIGFsc28gbm8gd2F5
IHRvIGhhdmUNCndpbmRvd3MgYXV0b21hdGljYWxseSBkZWZpbmVkIGZvciBzcGVjaWZpYyBh
cHBsaWNhdGlvbnMuDQoNCkluIG9yZGVyIHRvIGRlZmluZSBhIHdpbmRvdywgdXNlIHRoZSBy
ZXZpZXcga2V5cyB0byBtb3ZlIHlvdXIgcmVhZGluZw0KY3Vyc29yIHRvIHRoZSBiZWdpbm5p
bmcgb2YgdGhlIGFyZWEgeW91IHdhbnQgdG8gZGVmaW5lLiAgVGhlbiBwcmVzcw0Kc3BlYWt1
cCArIGBmMmAuICBTcGVha3VwIHdpbGwgdGVsbCB5b3UgdGhhdCB0aGUgd2luZG93IHN0YXJ0
cyBhdCB0aGUNCmluZGljYXRlZCByb3cgYW5kIGNvbHVtbiBwb3NpdGlvbi4gIFRoZW4gbW92
ZSB0aGUgcmVhZGluZyBjdXJzb3IgdG8gdGhlDQplbmQgb2YgdGhlIGFyZWEgdG8gYmUgZGVm
aW5lZCBhcyBhIHdpbmRvdywgYW5kIHByZXNzIHNwZWFrdXAgKyBgZjJgIGFnYWluLg0KSWYg
dGhlcmUgaXMgbW9yZSB0aGFuIG9uZSBsaW5lIGluIHRoZSB3aW5kb3csIFNwZWFrdXAgd2ls
bCB0ZWxsIHlvdQ0KdGhhdCB0aGUgd2luZG93IGVuZHMgYXQgdGhlIGluZGljYXRlZCByb3cg
YW5kIGNvbHVtbiBwb3NpdGlvbi4gIElmIHRoZXJlDQppcyBvbmx5IG9uZSBsaW5lIGluIHRo
ZSB3aW5kb3csIHRoZW4gU3BlYWt1cCB3aWxsIHRlbGwgeW91IHRoYXQgdGhlDQp3aW5kb3cg
aXMgdGhlIHNwZWNpZmllZCBsaW5lIG9uIHRoZSBzY3JlZW4uICBJZiB5b3UgYXJlIG9ubHkg
ZGVmaW5pbmcgYQ0Kb25lIGxpbmUgd2luZG93LCB5b3UgY2FuIGp1c3QgcHJlc3Mgc3BlYWt1
cCArIGBmMmAgdHdpY2UgYWZ0ZXIgcGxhY2luZyB0aGUNCnJlYWRpbmcgY3Vyc29yIG9uIHRo
ZSBsaW5lIHlvdSB3YW50IHRvIGRlZmluZSBhcyBhIHdpbmRvdy4gIEl0IGlzIG5vdA0KbmVj
ZXNzYXJ5IHRvIHBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNvciBhdCB0aGUgZW5kIG9mIHRo
ZSBsaW5lIGluIG9yZGVyDQp0byBkZWZpbmUgdGhlIHdob2xlIGxpbmUgYXMgYSB3aW5kb3cu
DQoNCg0KMTYuICBUb29scyBmb3IgQ29udHJvbGxpbmcgU3BlYWt1cA0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KDQpUaGUgc3BlYWt1cCBkaXN0cmlidXRpb24gaW5j
bHVkZXMgZXh0cmEgdG9vbHMgKGluIHRoZSB0b29scyBkaXJlY3RvcnkpDQp3aGljaCB3ZXJl
IHdyaXR0ZW4gdG8gbWFrZSBzcGVha3VwIGVhc2llciB0byB1c2UuICBUaGlzIHNlY3Rpb24g
d2lsbA0KYnJpZWZseSBkZXNjcmliZSB0aGUgdXNlIG9mIHRoZXNlIHRvb2xzLg0KDQoxNi4x
LiAgU3BlYWt1cGNvbmYNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpzcGVha3VwY29uZiBiZWdh
biBsaWZlIGFzIGEgY29udHJpYnV0aW9uIGZyb20gU3RldmUgSG9sbWVzLCBhIG1lbWJlciBv
Zg0KdGhlIHNwZWFrdXAgY29tbXVuaXR5LiAgV2Ugd291bGQgbGlrZSB0byB0aGFuayBoaW0g
Zm9yIGhpcyB3b3JrIG9uIHRoZQ0KZWFybHkgdmVyc2lvbnMgb2YgdGhpcyBwcm9qZWN0Lg0K
DQpUaGlzIHNjcmlwdCBtYXkgYmUgaW5zdGFsbGVkIGFzIHBhcnQgb2YgeW91ciBsaW51eCBk
aXN0cmlidXRpb24sIGJ1dCBpZg0KaXQgaXNuJ3QsIHRoZSByZWNvbW1lbmRlZCBwbGFjZXMg
dG8gcHV0IGl0IGFyZSBgYC91c3IvbG9jYWwvYmluYGAgb3INCmBgL3Vzci9iaW5gYC4gIFRo
aXMgc2NyaXB0IGNhbiBiZSBydW4gYnkgYW55IHVzZXIsIHNvIGl0IGRvZXMgbm90IHJlcXVp
cmUNCnJvb3QgcHJpdmlsZWdlcy4NCg0KU3BlYWt1cGNvbmYgYWxsb3dzIHlvdSB0byBzYXZl
IGFuZCBsb2FkIHlvdXIgU3BlYWt1cCBzZXR0aW5ncy4gIEl0IHdvcmtzDQpieSByZWFkaW5n
IGFuZCB3cml0aW5nIHRoZSBgYC9zeXNgYCBmaWxlcyBkZXNjcmliZWQgYWJvdmUuDQoNClRo
ZSBkaXJlY3RvcnkgdGhhdCBzcGVha3VwY29uZiB1c2VzIHRvIHN0b3JlIHlvdXIgc2V0dGlu
Z3MgZGVwZW5kcyBvbg0Kd2hldGhlciBpdCBpcyBydW4gZnJvbSB0aGUgcm9vdCBhY2NvdW50
LiAgSWYgeW91IGV4ZWN1dGUgc3BlYWt1cGNvbmYgYXMNCnJvb3QsIGl0IHVzZXMgdGhlIGRp
cmVjdG9yeSBgYC9ldGMvc3BlYWt1cGBgLiAgT3RoZXJ3aXNlLCBpdCB1c2VzIHRoZSBkaXJl
Y3RvcnkNCmBgfi8uc3BlYWt1cGBgLCB3aGVyZSBgYH5gYCBpcyB5b3VyIGhvbWUgZGlyZWN0
b3J5Lg0KQW55b25lIHdobyBuZWVkcyB0byB1c2UgU3BlYWt1cCBmcm9tIHlvdXIgY29uc29s
ZSBjYW4gbG9hZCBoaXMgb3duIGN1c3RvbQ0Kc2V0dGluZ3Mgd2l0aCB0aGlzIHNjcmlwdC4N
Cg0Kc3BlYWt1cGNvbmYgdGFrZXMgb25lIHJlcXVpcmVkIGFyZ3VtZW50OiBsb2FkIG9yIHNh
dmUuDQpVc2UgdGhlIGNvbW1hbmQ6Og0KDQogIHNwZWFrdXBjb25mIHNhdmUNCg0KdG8gc2F2
ZSB5b3VyIFNwZWFrdXAgc2V0dGluZ3MsIGFuZDo6DQoNCiAgc3BlYWt1cGNvbmYgbG9hZA0K
DQp0byBsb2FkIHRoZW0gaW50byBTcGVha3VwLg0KDQpBIHNlY29uZCBhcmd1bWVudCBtYXkg
YmUgc3BlY2lmaWVkIHRvIHVzZSBhbiBhbHRlcm5hdGUgZGlyZWN0b3J5IHRvDQpsb2FkIG9y
IHNhdmUgdGhlIHNwZWFrdXAgcGFyYW1ldGVycy4NCg0KMTYuMi4gIFRhbGt3aXRoDQotLS0t
LS0tLS0tLS0tLS0NCg0KQ2hhcmxlcyBIYWxsZW5iZWNrLCBhbm90aGVyIG1lbWJlciBvZiB0
aGUgc3BlYWt1cCBjb21tdW5pdHksIHdyb3RlIHRoZQ0KaW5pdGlhbCB2ZXJzaW9ucyBvZiB0
aGlzIHNjcmlwdCwgYW5kIHdlIHdvdWxkIGFsc28gbGlrZSB0byB0aGFuayBoaW0gZm9yDQpo
aXMgd29yayBvbiBpdC4NCg0KVGhpcyBzY3JpcHQgbmVlZHMgcm9vdCBwcml2aWxlZ2VzIHRv
IHJ1biwgc28gaWYgaXQgaXMgbm90IGluc3RhbGxlZCBhcw0KcGFydCBvZiB5b3VyIGxpbnV4
IGRpc3RyaWJ1dGlvbiwgdGhlIHJlY29tbWVuZGVkIHBsYWNlcyB0byBpbnN0YWxsIGl0DQph
cmUgYGAvdXNyL2xvY2FsL3NiaW5gYCBvciBgYC91c3Ivc2JpbmBgLg0KDQpUYWxrd2l0aCBh
bGxvd3MgeW91IHRvIHN3aXRjaCBzeW50aGVzaXplcnMgb24gdGhlIGZseS4gIEl0IHRha2Vz
IGEgc3ludGhlc2l6ZXINCm5hbWUgYXMgYW4gYXJndW1lbnQuICBGb3IgaW5zdGFuY2UsDQp0
YWxrd2l0aCBkZWN0bGsNCmNhdXNlcyBTcGVha3VwIHRvIHVzZSB0aGUgRGVjVGFsayBFeHBy
ZXNzLiAgSWYgeW91IHdpc2ggdG8gc3dpdGNoIHRvIGENCnNvZnR3YXJlIHN5bnRoZXNpemVy
LCB5b3UgbXVzdCBhbHNvIGluZGljYXRlIHdoaWNoIGRhZW1vbiB5b3Ugd2lzaCB0bw0KdXNl
LiAgVGhlcmUgYXJlIHR3byBwb3NzaWJsZSBjaG9pY2VzOg0Kc3BkIGFuZCBlc3BlYWt1cC4g
IHNwZCBpcyBhbiBhYmJyZXZpYXRpb24gZm9yIHNwZWVjaGQtdXAuDQpJZiB5b3Ugd2lzaCB0
byB1c2UgZXNwZWFrdXAgZm9yIHNvZnR3YXJlIHN5bnRoZXNpcywgZ2l2ZSB0aGUgY29tbWFu
ZA0KdGFsa3dpdGggc29mdCBlc3BlYWt1cA0KVG8gdXNlIHNwZWVjaGQtdXAsIHR5cGU6Og0K
DQogIHRhbGt3aXRoIHNvZnQgc3BkDQoNCkFueSBhcmd1bWVudHMgdGhhdCBmb2xsb3cgdGhl
IG5hbWUgb2YgdGhlIGRhZW1vbiBhcmUgcGFzc2VkIHRvIHRoZSBkYWVtb24NCndoZW4gaXQg
aXMgaW52b2tlZC4gIEZvciBpbnN0YW5jZTo6DQoNCiAgdGFsa3dpdGggZXNwZWFrdXAgLS1k
ZWZhdWx0LXZvaWNlPWZyDQoNCmNhdXNlcyBlc3BlYWt1cCB0byB1c2UgdGhlIEZyZW5jaCB2
b2ljZS4NCg0KLi4gbm90ZTo6DQoNCiAgVGFsa3dpdGggbXVzdCBhbHdheXMgYmUgZXhlY3V0
ZWQgd2l0aCByb290IHByaXZpbGVnZXMuDQoNClRhbGt3aXRoIGRvZXMgbm90IGF0dGVtcHQg
dG8gbG9hZCB5b3VyIHNldHRpbmdzIGFmdGVyIHRoZSBuZXcNCnN5bnRoZXNpemVyIGlzIGFj
dGl2YXRlZC4gIFlvdSBjYW4gdXNlIHNwZWFrdXBjb25mIHRvIGxvYWQgeW91ciBzZXR0aW5n
cw0KaWYgZGVzaXJlZC4NCg0KDQpEb2N1bWVudCBMaWNlbnNlDQo9PT09PT09PT09PT09PT09
DQoNCiAgICAgICAgICAgICAgICBHTlUgRnJlZSBEb2N1bWVudGF0aW9uIExpY2Vuc2UNCiAg
ICAgICAgICAgICAgICAgIFZlcnNpb24gMS4yLCBOb3ZlbWJlciAyMDAyDQoNCg0KQ29weXJp
Z2h0IChDKSAyMDAwLDIwMDEsMjAwMiAgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMu
DQpFdmVyeW9uZSBpcyBwZXJtaXR0ZWQgdG8gY29weSBhbmQgZGlzdHJpYnV0ZSB2ZXJiYXRp
bSBjb3BpZXMNCm9mIHRoaXMgbGljZW5zZSBkb2N1bWVudCwgYnV0IGNoYW5naW5nIGl0IGlz
IG5vdCBhbGxvd2VkLg0KDQoNCjAuIFBSRUFNQkxFDQoNClRoZSBwdXJwb3NlIG9mIHRoaXMg
TGljZW5zZSBpcyB0byBtYWtlIGEgbWFudWFsLCB0ZXh0Ym9vaywgb3Igb3RoZXINCmZ1bmN0
aW9uYWwgYW5kIHVzZWZ1bCBkb2N1bWVudCAiZnJlZSIgaW4gdGhlIHNlbnNlIG9mIGZyZWVk
b206IHRvDQphc3N1cmUgZXZlcnlvbmUgdGhlIGVmZmVjdGl2ZSBmcmVlZG9tIHRvIGNvcHkg
YW5kIHJlZGlzdHJpYnV0ZSBpdCwNCndpdGggb3Igd2l0aG91dCBtb2RpZnlpbmcgaXQsIGVp
dGhlciBjb21tZXJjaWFsbHkgb3Igbm9uY29tbWVyY2lhbGx5Lg0KU2Vjb25kYXJpbHksIHRo
aXMgTGljZW5zZSBwcmVzZXJ2ZXMgZm9yIHRoZSBhdXRob3IgYW5kIHB1Ymxpc2hlciBhIHdh
eQ0KdG8gZ2V0IGNyZWRpdCBmb3IgdGhlaXIgd29yaywgd2hpbGUgbm90IGJlaW5nIGNvbnNp
ZGVyZWQgcmVzcG9uc2libGUNCmZvciBtb2RpZmljYXRpb25zIG1hZGUgYnkgb3RoZXJzLg0K
DQpUaGlzIExpY2Vuc2UgaXMgYSBraW5kIG9mICJjb3B5bGVmdCIsIHdoaWNoIG1lYW5zIHRo
YXQgZGVyaXZhdGl2ZQ0Kd29ya3Mgb2YgdGhlIGRvY3VtZW50IG11c3QgdGhlbXNlbHZlcyBi
ZSBmcmVlIGluIHRoZSBzYW1lIHNlbnNlLiAgSXQNCmNvbXBsZW1lbnRzIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSwgd2hpY2ggaXMgYSBjb3B5bGVmdA0KbGljZW5zZSBkZXNp
Z25lZCBmb3IgZnJlZSBzb2Z0d2FyZS4NCg0KV2UgaGF2ZSBkZXNpZ25lZCB0aGlzIExpY2Vu
c2UgaW4gb3JkZXIgdG8gdXNlIGl0IGZvciBtYW51YWxzIGZvciBmcmVlDQpzb2Z0d2FyZSwg
YmVjYXVzZSBmcmVlIHNvZnR3YXJlIG5lZWRzIGZyZWUgZG9jdW1lbnRhdGlvbjogYSBmcmVl
DQpwcm9ncmFtIHNob3VsZCBjb21lIHdpdGggbWFudWFscyBwcm92aWRpbmcgdGhlIHNhbWUg
ZnJlZWRvbXMgdGhhdCB0aGUNCnNvZnR3YXJlIGRvZXMuICBCdXQgdGhpcyBMaWNlbnNlIGlz
IG5vdCBsaW1pdGVkIHRvIHNvZnR3YXJlIG1hbnVhbHM7DQppdCBjYW4gYmUgdXNlZCBmb3Ig
YW55IHRleHR1YWwgd29yaywgcmVnYXJkbGVzcyBvZiBzdWJqZWN0IG1hdHRlciBvcg0Kd2hl
dGhlciBpdCBpcyBwdWJsaXNoZWQgYXMgYSBwcmludGVkIGJvb2suICBXZSByZWNvbW1lbmQg
dGhpcyBMaWNlbnNlDQpwcmluY2lwYWxseSBmb3Igd29ya3Mgd2hvc2UgcHVycG9zZSBpcyBp
bnN0cnVjdGlvbiBvciByZWZlcmVuY2UuDQoNCg0KMS4gQVBQTElDQUJJTElUWSBBTkQgREVG
SU5JVElPTlMNCg0KVGhpcyBMaWNlbnNlIGFwcGxpZXMgdG8gYW55IG1hbnVhbCBvciBvdGhl
ciB3b3JrLCBpbiBhbnkgbWVkaXVtLCB0aGF0DQpjb250YWlucyBhIG5vdGljZSBwbGFjZWQg
YnkgdGhlIGNvcHlyaWdodCBob2xkZXIgc2F5aW5nIGl0IGNhbiBiZQ0KZGlzdHJpYnV0ZWQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoaXMgTGljZW5zZS4gIFN1Y2ggYSBub3RpY2UgZ3JhbnRz
IGENCndvcmxkLXdpZGUsIHJveWFsdHktZnJlZSBsaWNlbnNlLCB1bmxpbWl0ZWQgaW4gZHVy
YXRpb24sIHRvIHVzZSB0aGF0DQp3b3JrIHVuZGVyIHRoZSBjb25kaXRpb25zIHN0YXRlZCBo
ZXJlaW4uICBUaGUgIkRvY3VtZW50IiwgYmVsb3csDQpyZWZlcnMgdG8gYW55IHN1Y2ggbWFu
dWFsIG9yIHdvcmsuICBBbnkgbWVtYmVyIG9mIHRoZSBwdWJsaWMgaXMgYQ0KbGljZW5zZWUs
IGFuZCBpcyBhZGRyZXNzZWQgYXMgInlvdSIuICBZb3UgYWNjZXB0IHRoZSBsaWNlbnNlIGlm
IHlvdQ0KY29weSwgbW9kaWZ5IG9yIGRpc3RyaWJ1dGUgdGhlIHdvcmsgaW4gYSB3YXkgcmVx
dWlyaW5nIHBlcm1pc3Npb24NCnVuZGVyIGNvcHlyaWdodCBsYXcuDQoNCkEgIk1vZGlmaWVk
IFZlcnNpb24iIG9mIHRoZSBEb2N1bWVudCBtZWFucyBhbnkgd29yayBjb250YWluaW5nIHRo
ZQ0KRG9jdW1lbnQgb3IgYSBwb3J0aW9uIG9mIGl0LCBlaXRoZXIgY29waWVkIHZlcmJhdGlt
LCBvciB3aXRoDQptb2RpZmljYXRpb25zIGFuZC9vciB0cmFuc2xhdGVkIGludG8gYW5vdGhl
ciBsYW5ndWFnZS4NCg0KQSAiU2Vjb25kYXJ5IFNlY3Rpb24iIGlzIGEgbmFtZWQgYXBwZW5k
aXggb3IgYSBmcm9udC1tYXR0ZXIgc2VjdGlvbiBvZg0KdGhlIERvY3VtZW50IHRoYXQgZGVh
bHMgZXhjbHVzaXZlbHkgd2l0aCB0aGUgcmVsYXRpb25zaGlwIG9mIHRoZQ0KcHVibGlzaGVy
cyBvciBhdXRob3JzIG9mIHRoZSBEb2N1bWVudCB0byB0aGUgRG9jdW1lbnQncyBvdmVyYWxs
IHN1YmplY3QNCihvciB0byByZWxhdGVkIG1hdHRlcnMpIGFuZCBjb250YWlucyBub3RoaW5n
IHRoYXQgY291bGQgZmFsbCBkaXJlY3RseQ0Kd2l0aGluIHRoYXQgb3ZlcmFsbCBzdWJqZWN0
LiAgKFRodXMsIGlmIHRoZSBEb2N1bWVudCBpcyBpbiBwYXJ0IGENCnRleHRib29rIG9mIG1h
dGhlbWF0aWNzLCBhIFNlY29uZGFyeSBTZWN0aW9uIG1heSBub3QgZXhwbGFpbiBhbnkNCm1h
dGhlbWF0aWNzLikgIFRoZSByZWxhdGlvbnNoaXAgY291bGQgYmUgYSBtYXR0ZXIgb2YgaGlz
dG9yaWNhbA0KY29ubmVjdGlvbiB3aXRoIHRoZSBzdWJqZWN0IG9yIHdpdGggcmVsYXRlZCBt
YXR0ZXJzLCBvciBvZiBsZWdhbCwNCmNvbW1lcmNpYWwsIHBoaWxvc29waGljYWwsIGV0aGlj
YWwgb3IgcG9saXRpY2FsIHBvc2l0aW9uIHJlZ2FyZGluZw0KdGhlbS4NCg0KVGhlICJJbnZh
cmlhbnQgU2VjdGlvbnMiIGFyZSBjZXJ0YWluIFNlY29uZGFyeSBTZWN0aW9ucyB3aG9zZSB0
aXRsZXMNCmFyZSBkZXNpZ25hdGVkLCBhcyBiZWluZyB0aG9zZSBvZiBJbnZhcmlhbnQgU2Vj
dGlvbnMsIGluIHRoZSBub3RpY2UNCnRoYXQgc2F5cyB0aGF0IHRoZSBEb2N1bWVudCBpcyBy
ZWxlYXNlZCB1bmRlciB0aGlzIExpY2Vuc2UuICBJZiBhDQpzZWN0aW9uIGRvZXMgbm90IGZp
dCB0aGUgYWJvdmUgZGVmaW5pdGlvbiBvZiBTZWNvbmRhcnkgdGhlbiBpdCBpcyBub3QNCmFs
bG93ZWQgdG8gYmUgZGVzaWduYXRlZCBhcyBJbnZhcmlhbnQuICBUaGUgRG9jdW1lbnQgbWF5
IGNvbnRhaW4gemVybw0KSW52YXJpYW50IFNlY3Rpb25zLiAgSWYgdGhlIERvY3VtZW50IGRv
ZXMgbm90IGlkZW50aWZ5IGFueSBJbnZhcmlhbnQNClNlY3Rpb25zIHRoZW4gdGhlcmUgYXJl
IG5vbmUuDQoNClRoZSAiQ292ZXIgVGV4dHMiIGFyZSBjZXJ0YWluIHNob3J0IHBhc3NhZ2Vz
IG9mIHRleHQgdGhhdCBhcmUgbGlzdGVkLA0KYXMgRnJvbnQtQ292ZXIgVGV4dHMgb3IgQmFj
ay1Db3ZlciBUZXh0cywgaW4gdGhlIG5vdGljZSB0aGF0IHNheXMgdGhhdA0KdGhlIERvY3Vt
ZW50IGlzIHJlbGVhc2VkIHVuZGVyIHRoaXMgTGljZW5zZS4gIEEgRnJvbnQtQ292ZXIgVGV4
dCBtYXkNCmJlIGF0IG1vc3QgNSB3b3JkcywgYW5kIGEgQmFjay1Db3ZlciBUZXh0IG1heSBi
ZSBhdCBtb3N0IDI1IHdvcmRzLg0KDQpBICJUcmFuc3BhcmVudCIgY29weSBvZiB0aGUgRG9j
dW1lbnQgbWVhbnMgYSBtYWNoaW5lLXJlYWRhYmxlIGNvcHksDQpyZXByZXNlbnRlZCBpbiBh
IGZvcm1hdCB3aG9zZSBzcGVjaWZpY2F0aW9uIGlzIGF2YWlsYWJsZSB0byB0aGUNCmdlbmVy
YWwgcHVibGljLCB0aGF0IGlzIHN1aXRhYmxlIGZvciByZXZpc2luZyB0aGUgZG9jdW1lbnQN
CnN0cmFpZ2h0Zm9yd2FyZGx5IHdpdGggZ2VuZXJpYyB0ZXh0IGVkaXRvcnMgb3IgKGZvciBp
bWFnZXMgY29tcG9zZWQgb2YNCnBpeGVscykgZ2VuZXJpYyBwYWludCBwcm9ncmFtcyBvciAo
Zm9yIGRyYXdpbmdzKSBzb21lIHdpZGVseSBhdmFpbGFibGUNCmRyYXdpbmcgZWRpdG9yLCBh
bmQgdGhhdCBpcyBzdWl0YWJsZSBmb3IgaW5wdXQgdG8gdGV4dCBmb3JtYXR0ZXJzIG9yDQpm
b3IgYXV0b21hdGljIHRyYW5zbGF0aW9uIHRvIGEgdmFyaWV0eSBvZiBmb3JtYXRzIHN1aXRh
YmxlIGZvciBpbnB1dA0KdG8gdGV4dCBmb3JtYXR0ZXJzLiAgQSBjb3B5IG1hZGUgaW4gYW4g
b3RoZXJ3aXNlIFRyYW5zcGFyZW50IGZpbGUNCmZvcm1hdCB3aG9zZSBtYXJrdXAsIG9yIGFi
c2VuY2Ugb2YgbWFya3VwLCBoYXMgYmVlbiBhcnJhbmdlZCB0byB0aHdhcnQNCm9yIGRpc2Nv
dXJhZ2Ugc3Vic2VxdWVudCBtb2RpZmljYXRpb24gYnkgcmVhZGVycyBpcyBub3QgVHJhbnNw
YXJlbnQuDQpBbiBpbWFnZSBmb3JtYXQgaXMgbm90IFRyYW5zcGFyZW50IGlmIHVzZWQgZm9y
IGFueSBzdWJzdGFudGlhbCBhbW91bnQNCm9mIHRleHQuICBBIGNvcHkgdGhhdCBpcyBub3Qg
IlRyYW5zcGFyZW50IiBpcyBjYWxsZWQgIk9wYXF1ZSIuDQoNCkV4YW1wbGVzIG9mIHN1aXRh
YmxlIGZvcm1hdHMgZm9yIFRyYW5zcGFyZW50IGNvcGllcyBpbmNsdWRlIHBsYWluDQpBU0NJ
SSB3aXRob3V0IG1hcmt1cCwgVGV4aW5mbyBpbnB1dCBmb3JtYXQsIExhVGVYIGlucHV0IGZv
cm1hdCwgU0dNTA0Kb3IgWE1MIHVzaW5nIGEgcHVibGljbHkgYXZhaWxhYmxlIERURCwgYW5k
IHN0YW5kYXJkLWNvbmZvcm1pbmcgc2ltcGxlDQpIVE1MLCBQb3N0U2NyaXB0IG9yIFBERiBk
ZXNpZ25lZCBmb3IgaHVtYW4gbW9kaWZpY2F0aW9uLiAgRXhhbXBsZXMgb2YNCnRyYW5zcGFy
ZW50IGltYWdlIGZvcm1hdHMgaW5jbHVkZSBQTkcsIFhDRiBhbmQgSlBHLiAgT3BhcXVlIGZv
cm1hdHMNCmluY2x1ZGUgcHJvcHJpZXRhcnkgZm9ybWF0cyB0aGF0IGNhbiBiZSByZWFkIGFu
ZCBlZGl0ZWQgb25seSBieQ0KcHJvcHJpZXRhcnkgd29yZCBwcm9jZXNzb3JzLCBTR01MIG9y
IFhNTCBmb3Igd2hpY2ggdGhlIERURCBhbmQvb3INCnByb2Nlc3NpbmcgdG9vbHMgYXJlIG5v
dCBnZW5lcmFsbHkgYXZhaWxhYmxlLCBhbmQgdGhlDQptYWNoaW5lLWdlbmVyYXRlZCBIVE1M
LCBQb3N0U2NyaXB0IG9yIFBERiBwcm9kdWNlZCBieSBzb21lIHdvcmQNCnByb2Nlc3NvcnMg
Zm9yIG91dHB1dCBwdXJwb3NlcyBvbmx5Lg0KDQpUaGUgIlRpdGxlIFBhZ2UiIG1lYW5zLCBm
b3IgYSBwcmludGVkIGJvb2ssIHRoZSB0aXRsZSBwYWdlIGl0c2VsZiwNCnBsdXMgc3VjaCBm
b2xsb3dpbmcgcGFnZXMgYXMgYXJlIG5lZWRlZCB0byBob2xkLCBsZWdpYmx5LCB0aGUgbWF0
ZXJpYWwNCnRoaXMgTGljZW5zZSByZXF1aXJlcyB0byBhcHBlYXIgaW4gdGhlIHRpdGxlIHBh
Z2UuICBGb3Igd29ya3MgaW4NCmZvcm1hdHMgd2hpY2ggZG8gbm90IGhhdmUgYW55IHRpdGxl
IHBhZ2UgYXMgc3VjaCwgIlRpdGxlIFBhZ2UiIG1lYW5zDQp0aGUgdGV4dCBuZWFyIHRoZSBt
b3N0IHByb21pbmVudCBhcHBlYXJhbmNlIG9mIHRoZSB3b3JrJ3MgdGl0bGUsDQpwcmVjZWRp
bmcgdGhlIGJlZ2lubmluZyBvZiB0aGUgYm9keSBvZiB0aGUgdGV4dC4NCg0KQSBzZWN0aW9u
ICJFbnRpdGxlZCBYWVoiIG1lYW5zIGEgbmFtZWQgc3VidW5pdCBvZiB0aGUgRG9jdW1lbnQg
d2hvc2UNCnRpdGxlIGVpdGhlciBpcyBwcmVjaXNlbHkgWFlaIG9yIGNvbnRhaW5zIFhZWiBp
biBwYXJlbnRoZXNlcyBmb2xsb3dpbmcNCnRleHQgdGhhdCB0cmFuc2xhdGVzIFhZWiBpbiBh
bm90aGVyIGxhbmd1YWdlLiAgKEhlcmUgWFlaIHN0YW5kcyBmb3IgYQ0Kc3BlY2lmaWMgc2Vj
dGlvbiBuYW1lIG1lbnRpb25lZCBiZWxvdywgc3VjaCBhcyAiQWNrbm93bGVkZ2VtZW50cyIs
DQoiRGVkaWNhdGlvbnMiLCAiRW5kb3JzZW1lbnRzIiwgb3IgIkhpc3RvcnkiLikgIFRvICJQ
cmVzZXJ2ZSB0aGUgVGl0bGUiDQpvZiBzdWNoIGEgc2VjdGlvbiB3aGVuIHlvdSBtb2RpZnkg
dGhlIERvY3VtZW50IG1lYW5zIHRoYXQgaXQgcmVtYWlucyBhDQpzZWN0aW9uICJFbnRpdGxl
ZCBYWVoiIGFjY29yZGluZyB0byB0aGlzIGRlZmluaXRpb24uDQoNClRoZSBEb2N1bWVudCBt
YXkgaW5jbHVkZSBXYXJyYW50eSBEaXNjbGFpbWVycyBuZXh0IHRvIHRoZSBub3RpY2Ugd2hp
Y2gNCnN0YXRlcyB0aGF0IHRoaXMgTGljZW5zZSBhcHBsaWVzIHRvIHRoZSBEb2N1bWVudC4g
IFRoZXNlIFdhcnJhbnR5DQpEaXNjbGFpbWVycyBhcmUgY29uc2lkZXJlZCB0byBiZSBpbmNs
dWRlZCBieSByZWZlcmVuY2UgaW4gdGhpcw0KTGljZW5zZSwgYnV0IG9ubHkgYXMgcmVnYXJk
cyBkaXNjbGFpbWluZyB3YXJyYW50aWVzOiBhbnkgb3RoZXINCmltcGxpY2F0aW9uIHRoYXQg
dGhlc2UgV2FycmFudHkgRGlzY2xhaW1lcnMgbWF5IGhhdmUgaXMgdm9pZCBhbmQgaGFzDQpu
byBlZmZlY3Qgb24gdGhlIG1lYW5pbmcgb2YgdGhpcyBMaWNlbnNlLg0KDQoNCjIuIFZFUkJB
VElNIENPUFlJTkcNCg0KWW91IG1heSBjb3B5IGFuZCBkaXN0cmlidXRlIHRoZSBEb2N1bWVu
dCBpbiBhbnkgbWVkaXVtLCBlaXRoZXINCmNvbW1lcmNpYWxseSBvciBub25jb21tZXJjaWFs
bHksIHByb3ZpZGVkIHRoYXQgdGhpcyBMaWNlbnNlLCB0aGUNCmNvcHlyaWdodCBub3RpY2Vz
LCBhbmQgdGhlIGxpY2Vuc2Ugbm90aWNlIHNheWluZyB0aGlzIExpY2Vuc2UgYXBwbGllcw0K
dG8gdGhlIERvY3VtZW50IGFyZSByZXByb2R1Y2VkIGluIGFsbCBjb3BpZXMsIGFuZCB0aGF0
IHlvdSBhZGQgbm8gb3RoZXINCmNvbmRpdGlvbnMgd2hhdHNvZXZlciB0byB0aG9zZSBvZiB0
aGlzIExpY2Vuc2UuICBZb3UgbWF5IG5vdCB1c2UNCnRlY2huaWNhbCBtZWFzdXJlcyB0byBv
YnN0cnVjdCBvciBjb250cm9sIHRoZSByZWFkaW5nIG9yIGZ1cnRoZXINCmNvcHlpbmcgb2Yg
dGhlIGNvcGllcyB5b3UgbWFrZSBvciBkaXN0cmlidXRlLiAgSG93ZXZlciwgeW91IG1heSBh
Y2NlcHQNCmNvbXBlbnNhdGlvbiBpbiBleGNoYW5nZSBmb3IgY29waWVzLiAgSWYgeW91IGRp
c3RyaWJ1dGUgYSBsYXJnZSBlbm91Z2gNCm51bWJlciBvZiBjb3BpZXMgeW91IG11c3QgYWxz
byBmb2xsb3cgdGhlIGNvbmRpdGlvbnMgaW4gc2VjdGlvbiAzLg0KDQpZb3UgbWF5IGFsc28g
bGVuZCBjb3BpZXMsIHVuZGVyIHRoZSBzYW1lIGNvbmRpdGlvbnMgc3RhdGVkIGFib3ZlLCBh
bmQNCnlvdSBtYXkgcHVibGljbHkgZGlzcGxheSBjb3BpZXMuDQoNCg0KMy4gQ09QWUlORyBJ
TiBRVUFOVElUWQ0KDQpJZiB5b3UgcHVibGlzaCBwcmludGVkIGNvcGllcyAob3IgY29waWVz
IGluIG1lZGlhIHRoYXQgY29tbW9ubHkgaGF2ZQ0KcHJpbnRlZCBjb3ZlcnMpIG9mIHRoZSBE
b2N1bWVudCwgbnVtYmVyaW5nIG1vcmUgdGhhbiAxMDAsIGFuZCB0aGUNCkRvY3VtZW50J3Mg
bGljZW5zZSBub3RpY2UgcmVxdWlyZXMgQ292ZXIgVGV4dHMsIHlvdSBtdXN0IGVuY2xvc2Ug
dGhlDQpjb3BpZXMgaW4gY292ZXJzIHRoYXQgY2FycnksIGNsZWFybHkgYW5kIGxlZ2libHks
IGFsbCB0aGVzZSBDb3Zlcg0KVGV4dHM6IEZyb250LUNvdmVyIFRleHRzIG9uIHRoZSBmcm9u
dCBjb3ZlciwgYW5kIEJhY2stQ292ZXIgVGV4dHMgb24NCnRoZSBiYWNrIGNvdmVyLiAgQm90
aCBjb3ZlcnMgbXVzdCBhbHNvIGNsZWFybHkgYW5kIGxlZ2libHkgaWRlbnRpZnkNCnlvdSBh
cyB0aGUgcHVibGlzaGVyIG9mIHRoZXNlIGNvcGllcy4gIFRoZSBmcm9udCBjb3ZlciBtdXN0
IHByZXNlbnQNCnRoZSBmdWxsIHRpdGxlIHdpdGggYWxsIHdvcmRzIG9mIHRoZSB0aXRsZSBl
cXVhbGx5IHByb21pbmVudCBhbmQNCnZpc2libGUuICBZb3UgbWF5IGFkZCBvdGhlciBtYXRl
cmlhbCBvbiB0aGUgY292ZXJzIGluIGFkZGl0aW9uLg0KQ29weWluZyB3aXRoIGNoYW5nZXMg
bGltaXRlZCB0byB0aGUgY292ZXJzLCBhcyBsb25nIGFzIHRoZXkgcHJlc2VydmUNCnRoZSB0
aXRsZSBvZiB0aGUgRG9jdW1lbnQgYW5kIHNhdGlzZnkgdGhlc2UgY29uZGl0aW9ucywgY2Fu
IGJlIHRyZWF0ZWQNCmFzIHZlcmJhdGltIGNvcHlpbmcgaW4gb3RoZXIgcmVzcGVjdHMuDQoN
CklmIHRoZSByZXF1aXJlZCB0ZXh0cyBmb3IgZWl0aGVyIGNvdmVyIGFyZSB0b28gdm9sdW1p
bm91cyB0byBmaXQNCmxlZ2libHksIHlvdSBzaG91bGQgcHV0IHRoZSBmaXJzdCBvbmVzIGxp
c3RlZCAoYXMgbWFueSBhcyBmaXQNCnJlYXNvbmFibHkpIG9uIHRoZSBhY3R1YWwgY292ZXIs
IGFuZCBjb250aW51ZSB0aGUgcmVzdCBvbnRvIGFkamFjZW50DQpwYWdlcy4NCg0KSWYgeW91
IHB1Ymxpc2ggb3IgZGlzdHJpYnV0ZSBPcGFxdWUgY29waWVzIG9mIHRoZSBEb2N1bWVudCBu
dW1iZXJpbmcNCm1vcmUgdGhhbiAxMDAsIHlvdSBtdXN0IGVpdGhlciBpbmNsdWRlIGEgbWFj
aGluZS1yZWFkYWJsZSBUcmFuc3BhcmVudA0KY29weSBhbG9uZyB3aXRoIGVhY2ggT3BhcXVl
IGNvcHksIG9yIHN0YXRlIGluIG9yIHdpdGggZWFjaCBPcGFxdWUgY29weQ0KYSBjb21wdXRl
ci1uZXR3b3JrIGxvY2F0aW9uIGZyb20gd2hpY2ggdGhlIGdlbmVyYWwgbmV0d29yay11c2lu
Zw0KcHVibGljIGhhcyBhY2Nlc3MgdG8gZG93bmxvYWQgdXNpbmcgcHVibGljLXN0YW5kYXJk
IG5ldHdvcmsgcHJvdG9jb2xzDQphIGNvbXBsZXRlIFRyYW5zcGFyZW50IGNvcHkgb2YgdGhl
IERvY3VtZW50LCBmcmVlIG9mIGFkZGVkIG1hdGVyaWFsLg0KSWYgeW91IHVzZSB0aGUgbGF0
dGVyIG9wdGlvbiwgeW91IG11c3QgdGFrZSByZWFzb25hYmx5IHBydWRlbnQgc3RlcHMsDQp3
aGVuIHlvdSBiZWdpbiBkaXN0cmlidXRpb24gb2YgT3BhcXVlIGNvcGllcyBpbiBxdWFudGl0
eSwgdG8gZW5zdXJlDQp0aGF0IHRoaXMgVHJhbnNwYXJlbnQgY29weSB3aWxsIHJlbWFpbiB0
aHVzIGFjY2Vzc2libGUgYXQgdGhlIHN0YXRlZA0KbG9jYXRpb24gdW50aWwgYXQgbGVhc3Qg
b25lIHllYXIgYWZ0ZXIgdGhlIGxhc3QgdGltZSB5b3UgZGlzdHJpYnV0ZSBhbg0KT3BhcXVl
IGNvcHkgKGRpcmVjdGx5IG9yIHRocm91Z2ggeW91ciBhZ2VudHMgb3IgcmV0YWlsZXJzKSBv
ZiB0aGF0DQplZGl0aW9uIHRvIHRoZSBwdWJsaWMuDQoNCkl0IGlzIHJlcXVlc3RlZCwgYnV0
IG5vdCByZXF1aXJlZCwgdGhhdCB5b3UgY29udGFjdCB0aGUgYXV0aG9ycyBvZiB0aGUNCkRv
Y3VtZW50IHdlbGwgYmVmb3JlIHJlZGlzdHJpYnV0aW5nIGFueSBsYXJnZSBudW1iZXIgb2Yg
Y29waWVzLCB0byBnaXZlDQp0aGVtIGEgY2hhbmNlIHRvIHByb3ZpZGUgeW91IHdpdGggYW4g
dXBkYXRlZCB2ZXJzaW9uIG9mIHRoZSBEb2N1bWVudC4NCg0KDQo0LiBNT0RJRklDQVRJT05T
DQoNCllvdSBtYXkgY29weSBhbmQgZGlzdHJpYnV0ZSBhIE1vZGlmaWVkIFZlcnNpb24gb2Yg
dGhlIERvY3VtZW50IHVuZGVyDQp0aGUgY29uZGl0aW9ucyBvZiBzZWN0aW9ucyAyIGFuZCAz
IGFib3ZlLCBwcm92aWRlZCB0aGF0IHlvdSByZWxlYXNlDQp0aGUgTW9kaWZpZWQgVmVyc2lv
biB1bmRlciBwcmVjaXNlbHkgdGhpcyBMaWNlbnNlLCB3aXRoIHRoZSBNb2RpZmllZA0KVmVy
c2lvbiBmaWxsaW5nIHRoZSByb2xlIG9mIHRoZSBEb2N1bWVudCwgdGh1cyBsaWNlbnNpbmcg
ZGlzdHJpYnV0aW9uDQphbmQgbW9kaWZpY2F0aW9uIG9mIHRoZSBNb2RpZmllZCBWZXJzaW9u
IHRvIHdob2V2ZXIgcG9zc2Vzc2VzIGEgY29weQ0Kb2YgaXQuICBJbiBhZGRpdGlvbiwgeW91
IG11c3QgZG8gdGhlc2UgdGhpbmdzIGluIHRoZSBNb2RpZmllZCBWZXJzaW9uOg0KDQpBLiBV
c2UgaW4gdGhlIFRpdGxlIFBhZ2UgKGFuZCBvbiB0aGUgY292ZXJzLCBpZiBhbnkpIGEgdGl0
bGUgZGlzdGluY3QNCiAgIGZyb20gdGhhdCBvZiB0aGUgRG9jdW1lbnQsIGFuZCBmcm9tIHRo
b3NlIG9mIHByZXZpb3VzIHZlcnNpb25zDQogICAod2hpY2ggc2hvdWxkLCBpZiB0aGVyZSB3
ZXJlIGFueSwgYmUgbGlzdGVkIGluIHRoZSBIaXN0b3J5IHNlY3Rpb24NCiAgIG9mIHRoZSBE
b2N1bWVudCkuICBZb3UgbWF5IHVzZSB0aGUgc2FtZSB0aXRsZSBhcyBhIHByZXZpb3VzIHZl
cnNpb24NCiAgIGlmIHRoZSBvcmlnaW5hbCBwdWJsaXNoZXIgb2YgdGhhdCB2ZXJzaW9uIGdp
dmVzIHBlcm1pc3Npb24uDQpCLiBMaXN0IG9uIHRoZSBUaXRsZSBQYWdlLCBhcyBhdXRob3Jz
LCBvbmUgb3IgbW9yZSBwZXJzb25zIG9yIGVudGl0aWVzDQogICByZXNwb25zaWJsZSBmb3Ig
YXV0aG9yc2hpcCBvZiB0aGUgbW9kaWZpY2F0aW9ucyBpbiB0aGUgTW9kaWZpZWQNCiAgIFZl
cnNpb24sIHRvZ2V0aGVyIHdpdGggYXQgbGVhc3QgZml2ZSBvZiB0aGUgcHJpbmNpcGFsIGF1
dGhvcnMgb2YgdGhlDQogICBEb2N1bWVudCAoYWxsIG9mIGl0cyBwcmluY2lwYWwgYXV0aG9y
cywgaWYgaXQgaGFzIGZld2VyIHRoYW4gZml2ZSksDQogICB1bmxlc3MgdGhleSByZWxlYXNl
IHlvdSBmcm9tIHRoaXMgcmVxdWlyZW1lbnQuDQpDLiBTdGF0ZSBvbiB0aGUgVGl0bGUgcGFn
ZSB0aGUgbmFtZSBvZiB0aGUgcHVibGlzaGVyIG9mIHRoZQ0KICAgTW9kaWZpZWQgVmVyc2lv
biwgYXMgdGhlIHB1Ymxpc2hlci4NCkQuIFByZXNlcnZlIGFsbCB0aGUgY29weXJpZ2h0IG5v
dGljZXMgb2YgdGhlIERvY3VtZW50Lg0KRS4gQWRkIGFuIGFwcHJvcHJpYXRlIGNvcHlyaWdo
dCBub3RpY2UgZm9yIHlvdXIgbW9kaWZpY2F0aW9ucw0KICAgYWRqYWNlbnQgdG8gdGhlIG90
aGVyIGNvcHlyaWdodCBub3RpY2VzLg0KRi4gSW5jbHVkZSwgaW1tZWRpYXRlbHkgYWZ0ZXIg
dGhlIGNvcHlyaWdodCBub3RpY2VzLCBhIGxpY2Vuc2Ugbm90aWNlDQogICBnaXZpbmcgdGhl
IHB1YmxpYyBwZXJtaXNzaW9uIHRvIHVzZSB0aGUgTW9kaWZpZWQgVmVyc2lvbiB1bmRlciB0
aGUNCiAgIHRlcm1zIG9mIHRoaXMgTGljZW5zZSwgaW4gdGhlIGZvcm0gc2hvd24gaW4gdGhl
IEFkZGVuZHVtIGJlbG93Lg0KRy4gUHJlc2VydmUgaW4gdGhhdCBsaWNlbnNlIG5vdGljZSB0
aGUgZnVsbCBsaXN0cyBvZiBJbnZhcmlhbnQgU2VjdGlvbnMNCiAgIGFuZCByZXF1aXJlZCBD
b3ZlciBUZXh0cyBnaXZlbiBpbiB0aGUgRG9jdW1lbnQncyBsaWNlbnNlIG5vdGljZS4NCkgu
IEluY2x1ZGUgYW4gdW5hbHRlcmVkIGNvcHkgb2YgdGhpcyBMaWNlbnNlLg0KSS4gUHJlc2Vy
dmUgdGhlIHNlY3Rpb24gRW50aXRsZWQgIkhpc3RvcnkiLCBQcmVzZXJ2ZSBpdHMgVGl0bGUs
IGFuZCBhZGQNCiAgIHRvIGl0IGFuIGl0ZW0gc3RhdGluZyBhdCBsZWFzdCB0aGUgdGl0bGUs
IHllYXIsIG5ldyBhdXRob3JzLCBhbmQNCiAgIHB1Ymxpc2hlciBvZiB0aGUgTW9kaWZpZWQg
VmVyc2lvbiBhcyBnaXZlbiBvbiB0aGUgVGl0bGUgUGFnZS4gIElmDQogICB0aGVyZSBpcyBu
byBzZWN0aW9uIEVudGl0bGVkICJIaXN0b3J5IiBpbiB0aGUgRG9jdW1lbnQsIGNyZWF0ZSBv
bmUNCiAgIHN0YXRpbmcgdGhlIHRpdGxlLCB5ZWFyLCBhdXRob3JzLCBhbmQgcHVibGlzaGVy
IG9mIHRoZSBEb2N1bWVudCBhcw0KICAgZ2l2ZW4gb24gaXRzIFRpdGxlIFBhZ2UsIHRoZW4g
YWRkIGFuIGl0ZW0gZGVzY3JpYmluZyB0aGUgTW9kaWZpZWQNCiAgIFZlcnNpb24gYXMgc3Rh
dGVkIGluIHRoZSBwcmV2aW91cyBzZW50ZW5jZS4NCkouIFByZXNlcnZlIHRoZSBuZXR3b3Jr
IGxvY2F0aW9uLCBpZiBhbnksIGdpdmVuIGluIHRoZSBEb2N1bWVudCBmb3INCiAgIHB1Ymxp
YyBhY2Nlc3MgdG8gYSBUcmFuc3BhcmVudCBjb3B5IG9mIHRoZSBEb2N1bWVudCwgYW5kIGxp
a2V3aXNlDQogICB0aGUgbmV0d29yayBsb2NhdGlvbnMgZ2l2ZW4gaW4gdGhlIERvY3VtZW50
IGZvciBwcmV2aW91cyB2ZXJzaW9ucw0KICAgaXQgd2FzIGJhc2VkIG9uLiAgVGhlc2UgbWF5
IGJlIHBsYWNlZCBpbiB0aGUgIkhpc3RvcnkiIHNlY3Rpb24uDQogICBZb3UgbWF5IG9taXQg
YSBuZXR3b3JrIGxvY2F0aW9uIGZvciBhIHdvcmsgdGhhdCB3YXMgcHVibGlzaGVkIGF0DQog
ICBsZWFzdCBmb3VyIHllYXJzIGJlZm9yZSB0aGUgRG9jdW1lbnQgaXRzZWxmLCBvciBpZiB0
aGUgb3JpZ2luYWwNCiAgIHB1Ymxpc2hlciBvZiB0aGUgdmVyc2lvbiBpdCByZWZlcnMgdG8g
Z2l2ZXMgcGVybWlzc2lvbi4NCksuIEZvciBhbnkgc2VjdGlvbiBFbnRpdGxlZCAiQWNrbm93
bGVkZ2VtZW50cyIgb3IgIkRlZGljYXRpb25zIiwNCiAgIFByZXNlcnZlIHRoZSBUaXRsZSBv
ZiB0aGUgc2VjdGlvbiwgYW5kIHByZXNlcnZlIGluIHRoZSBzZWN0aW9uIGFsbA0KICAgdGhl
IHN1YnN0YW5jZSBhbmQgdG9uZSBvZiBlYWNoIG9mIHRoZSBjb250cmlidXRvciBhY2tub3ds
ZWRnZW1lbnRzDQogICBhbmQvb3IgZGVkaWNhdGlvbnMgZ2l2ZW4gdGhlcmVpbi4NCkwuIFBy
ZXNlcnZlIGFsbCB0aGUgSW52YXJpYW50IFNlY3Rpb25zIG9mIHRoZSBEb2N1bWVudCwNCiAg
IHVuYWx0ZXJlZCBpbiB0aGVpciB0ZXh0IGFuZCBpbiB0aGVpciB0aXRsZXMuICBTZWN0aW9u
IG51bWJlcnMNCiAgIG9yIHRoZSBlcXVpdmFsZW50IGFyZSBub3QgY29uc2lkZXJlZCBwYXJ0
IG9mIHRoZSBzZWN0aW9uIHRpdGxlcy4NCk0uIERlbGV0ZSBhbnkgc2VjdGlvbiBFbnRpdGxl
ZCAiRW5kb3JzZW1lbnRzIi4gIFN1Y2ggYSBzZWN0aW9uDQogICBtYXkgbm90IGJlIGluY2x1
ZGVkIGluIHRoZSBNb2RpZmllZCBWZXJzaW9uLg0KTi4gRG8gbm90IHJldGl0bGUgYW55IGV4
aXN0aW5nIHNlY3Rpb24gdG8gYmUgRW50aXRsZWQgIkVuZG9yc2VtZW50cyINCiAgIG9yIHRv
IGNvbmZsaWN0IGluIHRpdGxlIHdpdGggYW55IEludmFyaWFudCBTZWN0aW9uLg0KTy4gUHJl
c2VydmUgYW55IFdhcnJhbnR5IERpc2NsYWltZXJzLg0KDQpJZiB0aGUgTW9kaWZpZWQgVmVy
c2lvbiBpbmNsdWRlcyBuZXcgZnJvbnQtbWF0dGVyIHNlY3Rpb25zIG9yDQphcHBlbmRpY2Vz
IHRoYXQgcXVhbGlmeSBhcyBTZWNvbmRhcnkgU2VjdGlvbnMgYW5kIGNvbnRhaW4gbm8gbWF0
ZXJpYWwNCmNvcGllZCBmcm9tIHRoZSBEb2N1bWVudCwgeW91IG1heSBhdCB5b3VyIG9wdGlv
biBkZXNpZ25hdGUgc29tZSBvciBhbGwNCm9mIHRoZXNlIHNlY3Rpb25zIGFzIGludmFyaWFu
dC4gIFRvIGRvIHRoaXMsIGFkZCB0aGVpciB0aXRsZXMgdG8gdGhlDQpsaXN0IG9mIEludmFy
aWFudCBTZWN0aW9ucyBpbiB0aGUgTW9kaWZpZWQgVmVyc2lvbidzIGxpY2Vuc2Ugbm90aWNl
Lg0KVGhlc2UgdGl0bGVzIG11c3QgYmUgZGlzdGluY3QgZnJvbSBhbnkgb3RoZXIgc2VjdGlv
biB0aXRsZXMuDQoNCllvdSBtYXkgYWRkIGEgc2VjdGlvbiBFbnRpdGxlZCAiRW5kb3JzZW1l
bnRzIiwgcHJvdmlkZWQgaXQgY29udGFpbnMNCm5vdGhpbmcgYnV0IGVuZG9yc2VtZW50cyBv
ZiB5b3VyIE1vZGlmaWVkIFZlcnNpb24gYnkgdmFyaW91cw0KcGFydGllcy0tZm9yIGV4YW1w
bGUsIHN0YXRlbWVudHMgb2YgcGVlciByZXZpZXcgb3IgdGhhdCB0aGUgdGV4dCBoYXMNCmJl
ZW4gYXBwcm92ZWQgYnkgYW4gb3JnYW5pemF0aW9uIGFzIHRoZSBhdXRob3JpdGF0aXZlIGRl
ZmluaXRpb24gb2YgYQ0Kc3RhbmRhcmQuDQoNCllvdSBtYXkgYWRkIGEgcGFzc2FnZSBvZiB1
cCB0byBmaXZlIHdvcmRzIGFzIGEgRnJvbnQtQ292ZXIgVGV4dCwgYW5kIGENCnBhc3NhZ2Ug
b2YgdXAgdG8gMjUgd29yZHMgYXMgYSBCYWNrLUNvdmVyIFRleHQsIHRvIHRoZSBlbmQgb2Yg
dGhlIGxpc3QNCm9mIENvdmVyIFRleHRzIGluIHRoZSBNb2RpZmllZCBWZXJzaW9uLiAgT25s
eSBvbmUgcGFzc2FnZSBvZg0KRnJvbnQtQ292ZXIgVGV4dCBhbmQgb25lIG9mIEJhY2stQ292
ZXIgVGV4dCBtYXkgYmUgYWRkZWQgYnkgKG9yDQp0aHJvdWdoIGFycmFuZ2VtZW50cyBtYWRl
IGJ5KSBhbnkgb25lIGVudGl0eS4gIElmIHRoZSBEb2N1bWVudCBhbHJlYWR5DQppbmNsdWRl
cyBhIGNvdmVyIHRleHQgZm9yIHRoZSBzYW1lIGNvdmVyLCBwcmV2aW91c2x5IGFkZGVkIGJ5
IHlvdSBvcg0KYnkgYXJyYW5nZW1lbnQgbWFkZSBieSB0aGUgc2FtZSBlbnRpdHkgeW91IGFy
ZSBhY3Rpbmcgb24gYmVoYWxmIG9mLA0KeW91IG1heSBub3QgYWRkIGFub3RoZXI7IGJ1dCB5
b3UgbWF5IHJlcGxhY2UgdGhlIG9sZCBvbmUsIG9uIGV4cGxpY2l0DQpwZXJtaXNzaW9uIGZy
b20gdGhlIHByZXZpb3VzIHB1Ymxpc2hlciB0aGF0IGFkZGVkIHRoZSBvbGQgb25lLg0KDQpU
aGUgYXV0aG9yKHMpIGFuZCBwdWJsaXNoZXIocykgb2YgdGhlIERvY3VtZW50IGRvIG5vdCBi
eSB0aGlzIExpY2Vuc2UNCmdpdmUgcGVybWlzc2lvbiB0byB1c2UgdGhlaXIgbmFtZXMgZm9y
IHB1YmxpY2l0eSBmb3Igb3IgdG8gYXNzZXJ0IG9yDQppbXBseSBlbmRvcnNlbWVudCBvZiBh
bnkgTW9kaWZpZWQgVmVyc2lvbi4NCg0KDQo1LiBDT01CSU5JTkcgRE9DVU1FTlRTDQoNCllv
dSBtYXkgY29tYmluZSB0aGUgRG9jdW1lbnQgd2l0aCBvdGhlciBkb2N1bWVudHMgcmVsZWFz
ZWQgdW5kZXIgdGhpcw0KTGljZW5zZSwgdW5kZXIgdGhlIHRlcm1zIGRlZmluZWQgaW4gc2Vj
dGlvbiA0IGFib3ZlIGZvciBtb2RpZmllZA0KdmVyc2lvbnMsIHByb3ZpZGVkIHRoYXQgeW91
IGluY2x1ZGUgaW4gdGhlIGNvbWJpbmF0aW9uIGFsbCBvZiB0aGUNCkludmFyaWFudCBTZWN0
aW9ucyBvZiBhbGwgb2YgdGhlIG9yaWdpbmFsIGRvY3VtZW50cywgdW5tb2RpZmllZCwgYW5k
DQpsaXN0IHRoZW0gYWxsIGFzIEludmFyaWFudCBTZWN0aW9ucyBvZiB5b3VyIGNvbWJpbmVk
IHdvcmsgaW4gaXRzDQpsaWNlbnNlIG5vdGljZSwgYW5kIHRoYXQgeW91IHByZXNlcnZlIGFs
bCB0aGVpciBXYXJyYW50eSBEaXNjbGFpbWVycy4NCg0KVGhlIGNvbWJpbmVkIHdvcmsgbmVl
ZCBvbmx5IGNvbnRhaW4gb25lIGNvcHkgb2YgdGhpcyBMaWNlbnNlLCBhbmQNCm11bHRpcGxl
IGlkZW50aWNhbCBJbnZhcmlhbnQgU2VjdGlvbnMgbWF5IGJlIHJlcGxhY2VkIHdpdGggYSBz
aW5nbGUNCmNvcHkuICBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgSW52YXJpYW50IFNlY3Rpb25z
IHdpdGggdGhlIHNhbWUgbmFtZSBidXQNCmRpZmZlcmVudCBjb250ZW50cywgbWFrZSB0aGUg
dGl0bGUgb2YgZWFjaCBzdWNoIHNlY3Rpb24gdW5pcXVlIGJ5DQphZGRpbmcgYXQgdGhlIGVu
ZCBvZiBpdCwgaW4gcGFyZW50aGVzZXMsIHRoZSBuYW1lIG9mIHRoZSBvcmlnaW5hbA0KYXV0
aG9yIG9yIHB1Ymxpc2hlciBvZiB0aGF0IHNlY3Rpb24gaWYga25vd24sIG9yIGVsc2UgYSB1
bmlxdWUgbnVtYmVyLg0KTWFrZSB0aGUgc2FtZSBhZGp1c3RtZW50IHRvIHRoZSBzZWN0aW9u
IHRpdGxlcyBpbiB0aGUgbGlzdCBvZg0KSW52YXJpYW50IFNlY3Rpb25zIGluIHRoZSBsaWNl
bnNlIG5vdGljZSBvZiB0aGUgY29tYmluZWQgd29yay4NCg0KSW4gdGhlIGNvbWJpbmF0aW9u
LCB5b3UgbXVzdCBjb21iaW5lIGFueSBzZWN0aW9ucyBFbnRpdGxlZCAiSGlzdG9yeSINCmlu
IHRoZSB2YXJpb3VzIG9yaWdpbmFsIGRvY3VtZW50cywgZm9ybWluZyBvbmUgc2VjdGlvbiBF
bnRpdGxlZA0KIkhpc3RvcnkiOyBsaWtld2lzZSBjb21iaW5lIGFueSBzZWN0aW9ucyBFbnRp
dGxlZCAiQWNrbm93bGVkZ2VtZW50cyIsDQphbmQgYW55IHNlY3Rpb25zIEVudGl0bGVkICJE
ZWRpY2F0aW9ucyIuICBZb3UgbXVzdCBkZWxldGUgYWxsIHNlY3Rpb25zDQpFbnRpdGxlZCAi
RW5kb3JzZW1lbnRzIi4NCg0KDQo2LiBDT0xMRUNUSU9OUyBPRiBET0NVTUVOVFMNCg0KWW91
IG1heSBtYWtlIGEgY29sbGVjdGlvbiBjb25zaXN0aW5nIG9mIHRoZSBEb2N1bWVudCBhbmQg
b3RoZXIgZG9jdW1lbnRzDQpyZWxlYXNlZCB1bmRlciB0aGlzIExpY2Vuc2UsIGFuZCByZXBs
YWNlIHRoZSBpbmRpdmlkdWFsIGNvcGllcyBvZiB0aGlzDQpMaWNlbnNlIGluIHRoZSB2YXJp
b3VzIGRvY3VtZW50cyB3aXRoIGEgc2luZ2xlIGNvcHkgdGhhdCBpcyBpbmNsdWRlZCBpbg0K
dGhlIGNvbGxlY3Rpb24sIHByb3ZpZGVkIHRoYXQgeW91IGZvbGxvdyB0aGUgcnVsZXMgb2Yg
dGhpcyBMaWNlbnNlIGZvcg0KdmVyYmF0aW0gY29weWluZyBvZiBlYWNoIG9mIHRoZSBkb2N1
bWVudHMgaW4gYWxsIG90aGVyIHJlc3BlY3RzLg0KDQpZb3UgbWF5IGV4dHJhY3QgYSBzaW5n
bGUgZG9jdW1lbnQgZnJvbSBzdWNoIGEgY29sbGVjdGlvbiwgYW5kIGRpc3RyaWJ1dGUNCml0
IGluZGl2aWR1YWxseSB1bmRlciB0aGlzIExpY2Vuc2UsIHByb3ZpZGVkIHlvdSBpbnNlcnQg
YSBjb3B5IG9mIHRoaXMNCkxpY2Vuc2UgaW50byB0aGUgZXh0cmFjdGVkIGRvY3VtZW50LCBh
bmQgZm9sbG93IHRoaXMgTGljZW5zZSBpbiBhbGwNCm90aGVyIHJlc3BlY3RzIHJlZ2FyZGlu
ZyB2ZXJiYXRpbSBjb3B5aW5nIG9mIHRoYXQgZG9jdW1lbnQuDQoNCg0KNy4gQUdHUkVHQVRJ
T04gV0lUSCBJTkRFUEVOREVOVCBXT1JLUw0KDQpBIGNvbXBpbGF0aW9uIG9mIHRoZSBEb2N1
bWVudCBvciBpdHMgZGVyaXZhdGl2ZXMgd2l0aCBvdGhlciBzZXBhcmF0ZQ0KYW5kIGluZGVw
ZW5kZW50IGRvY3VtZW50cyBvciB3b3JrcywgaW4gb3Igb24gYSB2b2x1bWUgb2YgYSBzdG9y
YWdlIG9yDQpkaXN0cmlidXRpb24gbWVkaXVtLCBpcyBjYWxsZWQgYW4gImFnZ3JlZ2F0ZSIg
aWYgdGhlIGNvcHlyaWdodA0KcmVzdWx0aW5nIGZyb20gdGhlIGNvbXBpbGF0aW9uIGlzIG5v
dCB1c2VkIHRvIGxpbWl0IHRoZSBsZWdhbCByaWdodHMNCm9mIHRoZSBjb21waWxhdGlvbidz
IHVzZXJzIGJleW9uZCB3aGF0IHRoZSBpbmRpdmlkdWFsIHdvcmtzIHBlcm1pdC4NCldoZW4g
dGhlIERvY3VtZW50IGlzIGluY2x1ZGVkIGluIGFuIGFnZ3JlZ2F0ZSwgdGhpcyBMaWNlbnNl
IGRvZXMgbm90DQphcHBseSB0byB0aGUgb3RoZXIgd29ya3MgaW4gdGhlIGFnZ3JlZ2F0ZSB3
aGljaCBhcmUgbm90IHRoZW1zZWx2ZXMNCmRlcml2YXRpdmUgd29ya3Mgb2YgdGhlIERvY3Vt
ZW50Lg0KDQpJZiB0aGUgQ292ZXIgVGV4dCByZXF1aXJlbWVudCBvZiBzZWN0aW9uIDMgaXMg
YXBwbGljYWJsZSB0byB0aGVzZQ0KY29waWVzIG9mIHRoZSBEb2N1bWVudCwgdGhlbiBpZiB0
aGUgRG9jdW1lbnQgaXMgbGVzcyB0aGFuIG9uZSBoYWxmIG9mDQp0aGUgZW50aXJlIGFnZ3Jl
Z2F0ZSwgdGhlIERvY3VtZW50J3MgQ292ZXIgVGV4dHMgbWF5IGJlIHBsYWNlZCBvbg0KY292
ZXJzIHRoYXQgYnJhY2tldCB0aGUgRG9jdW1lbnQgd2l0aGluIHRoZSBhZ2dyZWdhdGUsIG9y
IHRoZQ0KZWxlY3Ryb25pYyBlcXVpdmFsZW50IG9mIGNvdmVycyBpZiB0aGUgRG9jdW1lbnQg
aXMgaW4gZWxlY3Ryb25pYyBmb3JtLg0KT3RoZXJ3aXNlIHRoZXkgbXVzdCBhcHBlYXIgb24g
cHJpbnRlZCBjb3ZlcnMgdGhhdCBicmFja2V0IHRoZSB3aG9sZQ0KYWdncmVnYXRlLg0KDQoN
CjguIFRSQU5TTEFUSU9ODQoNClRyYW5zbGF0aW9uIGlzIGNvbnNpZGVyZWQgYSBraW5kIG9m
IG1vZGlmaWNhdGlvbiwgc28geW91IG1heQ0KZGlzdHJpYnV0ZSB0cmFuc2xhdGlvbnMgb2Yg
dGhlIERvY3VtZW50IHVuZGVyIHRoZSB0ZXJtcyBvZiBzZWN0aW9uIDQuDQpSZXBsYWNpbmcg
SW52YXJpYW50IFNlY3Rpb25zIHdpdGggdHJhbnNsYXRpb25zIHJlcXVpcmVzIHNwZWNpYWwN
CnBlcm1pc3Npb24gZnJvbSB0aGVpciBjb3B5cmlnaHQgaG9sZGVycywgYnV0IHlvdSBtYXkg
aW5jbHVkZQ0KdHJhbnNsYXRpb25zIG9mIHNvbWUgb3IgYWxsIEludmFyaWFudCBTZWN0aW9u
cyBpbiBhZGRpdGlvbiB0byB0aGUNCm9yaWdpbmFsIHZlcnNpb25zIG9mIHRoZXNlIEludmFy
aWFudCBTZWN0aW9ucy4gIFlvdSBtYXkgaW5jbHVkZSBhDQp0cmFuc2xhdGlvbiBvZiB0aGlz
IExpY2Vuc2UsIGFuZCBhbGwgdGhlIGxpY2Vuc2Ugbm90aWNlcyBpbiB0aGUNCkRvY3VtZW50
LCBhbmQgYW55IFdhcnJhbnR5IERpc2NsYWltZXJzLCBwcm92aWRlZCB0aGF0IHlvdSBhbHNv
IGluY2x1ZGUNCnRoZSBvcmlnaW5hbCBFbmdsaXNoIHZlcnNpb24gb2YgdGhpcyBMaWNlbnNl
IGFuZCB0aGUgb3JpZ2luYWwgdmVyc2lvbnMNCm9mIHRob3NlIG5vdGljZXMgYW5kIGRpc2Ns
YWltZXJzLiAgSW4gY2FzZSBvZiBhIGRpc2FncmVlbWVudCBiZXR3ZWVuDQp0aGUgdHJhbnNs
YXRpb24gYW5kIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIG9mIHRoaXMgTGljZW5zZSBvciBhIG5v
dGljZQ0Kb3IgZGlzY2xhaW1lciwgdGhlIG9yaWdpbmFsIHZlcnNpb24gd2lsbCBwcmV2YWls
Lg0KDQpJZiBhIHNlY3Rpb24gaW4gdGhlIERvY3VtZW50IGlzIEVudGl0bGVkICJBY2tub3ds
ZWRnZW1lbnRzIiwNCiJEZWRpY2F0aW9ucyIsIG9yICJIaXN0b3J5IiwgdGhlIHJlcXVpcmVt
ZW50IChzZWN0aW9uIDQpIHRvIFByZXNlcnZlDQppdHMgVGl0bGUgKHNlY3Rpb24gMSkgd2ls
bCB0eXBpY2FsbHkgcmVxdWlyZSBjaGFuZ2luZyB0aGUgYWN0dWFsDQp0aXRsZS4NCg0KDQo5
LiBURVJNSU5BVElPTg0KDQpZb3UgbWF5IG5vdCBjb3B5LCBtb2RpZnksIHN1YmxpY2Vuc2Us
IG9yIGRpc3RyaWJ1dGUgdGhlIERvY3VtZW50IGV4Y2VwdA0KYXMgZXhwcmVzc2x5IHByb3Zp
ZGVkIGZvciB1bmRlciB0aGlzIExpY2Vuc2UuICBBbnkgb3RoZXIgYXR0ZW1wdCB0bw0KY29w
eSwgbW9kaWZ5LCBzdWJsaWNlbnNlIG9yIGRpc3RyaWJ1dGUgdGhlIERvY3VtZW50IGlzIHZv
aWQsIGFuZCB3aWxsDQphdXRvbWF0aWNhbGx5IHRlcm1pbmF0ZSB5b3VyIHJpZ2h0cyB1bmRl
ciB0aGlzIExpY2Vuc2UuICBIb3dldmVyLA0KcGFydGllcyB3aG8gaGF2ZSByZWNlaXZlZCBj
b3BpZXMsIG9yIHJpZ2h0cywgZnJvbSB5b3UgdW5kZXIgdGhpcw0KTGljZW5zZSB3aWxsIG5v
dCBoYXZlIHRoZWlyIGxpY2Vuc2VzIHRlcm1pbmF0ZWQgc28gbG9uZyBhcyBzdWNoDQpwYXJ0
aWVzIHJlbWFpbiBpbiBmdWxsIGNvbXBsaWFuY2UuDQoNCg0KMTAuIEZVVFVSRSBSRVZJU0lP
TlMgT0YgVEhJUyBMSUNFTlNFDQoNClRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24gbWF5
IHB1Ymxpc2ggbmV3LCByZXZpc2VkIHZlcnNpb25zDQpvZiB0aGUgR05VIEZyZWUgRG9jdW1l
bnRhdGlvbiBMaWNlbnNlIGZyb20gdGltZSB0byB0aW1lLiAgU3VjaCBuZXcNCnZlcnNpb25z
IHdpbGwgYmUgc2ltaWxhciBpbiBzcGlyaXQgdG8gdGhlIHByZXNlbnQgdmVyc2lvbiwgYnV0
IG1heQ0KZGlmZmVyIGluIGRldGFpbCB0byBhZGRyZXNzIG5ldyBwcm9ibGVtcyBvciBjb25j
ZXJucy4gIFNlZQ0KaHR0cHM6Ly93d3cuZ251Lm9yZy9jb3B5bGVmdC8uDQoNCkVhY2ggdmVy
c2lvbiBvZiB0aGUgTGljZW5zZSBpcyBnaXZlbiBhIGRpc3Rpbmd1aXNoaW5nIHZlcnNpb24g
bnVtYmVyLg0KSWYgdGhlIERvY3VtZW50IHNwZWNpZmllcyB0aGF0IGEgcGFydGljdWxhciBu
dW1iZXJlZCB2ZXJzaW9uIG9mIHRoaXMNCkxpY2Vuc2UgIm9yIGFueSBsYXRlciB2ZXJzaW9u
IiBhcHBsaWVzIHRvIGl0LCB5b3UgaGF2ZSB0aGUgb3B0aW9uIG9mDQpmb2xsb3dpbmcgdGhl
IHRlcm1zIGFuZCBjb25kaXRpb25zIGVpdGhlciBvZiB0aGF0IHNwZWNpZmllZCB2ZXJzaW9u
IG9yDQpvZiBhbnkgbGF0ZXIgdmVyc2lvbiB0aGF0IGhhcyBiZWVuIHB1Ymxpc2hlZCAobm90
IGFzIGEgZHJhZnQpIGJ5IHRoZQ0KRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLiAgSWYgdGhl
IERvY3VtZW50IGRvZXMgbm90IHNwZWNpZnkgYSB2ZXJzaW9uDQpudW1iZXIgb2YgdGhpcyBM
aWNlbnNlLCB5b3UgbWF5IGNob29zZSBhbnkgdmVyc2lvbiBldmVyIHB1Ymxpc2hlZCAobm90
DQphcyBhIGRyYWZ0KSBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KDQoNCkFE
REVORFVNOiBIb3cgdG8gdXNlIHRoaXMgTGljZW5zZSBmb3IgeW91ciBkb2N1bWVudHMNCg0K
VG8gdXNlIHRoaXMgTGljZW5zZSBpbiBhIGRvY3VtZW50IHlvdSBoYXZlIHdyaXR0ZW4sIGlu
Y2x1ZGUgYSBjb3B5IG9mDQp0aGUgTGljZW5zZSBpbiB0aGUgZG9jdW1lbnQgYW5kIHB1dCB0
aGUgZm9sbG93aW5nIGNvcHlyaWdodCBhbmQNCmxpY2Vuc2Ugbm90aWNlcyBqdXN0IGFmdGVy
IHRoZSB0aXRsZSBwYWdlOg0KDQogICAgQ29weXJpZ2h0IChjKSAgWUVBUiAgWU9VUiBOQU1F
Lg0KICAgIFBlcm1pc3Npb24gaXMgZ3JhbnRlZCB0byBjb3B5LCBkaXN0cmlidXRlIGFuZC9v
ciBtb2RpZnkgdGhpcyBkb2N1bWVudA0KICAgIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEZyZWUgRG9jdW1lbnRhdGlvbiBMaWNlbnNlLCBWZXJzaW9uIDEuMg0KICAgIG9yIGFueSBs
YXRlciB2ZXJzaW9uIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
Ow0KICAgIHdpdGggbm8gSW52YXJpYW50IFNlY3Rpb25zLCBubyBGcm9udC1Db3ZlciBUZXh0
cywgYW5kIG5vIEJhY2stQ292ZXIgVGV4dHMuDQogICAgQSBjb3B5IG9mIHRoZSBsaWNlbnNl
IGlzIGluY2x1ZGVkIGluIHRoZSBzZWN0aW9uIGVudGl0bGVkICJHTlUNCiAgICBGcmVlIERv
Y3VtZW50YXRpb24gTGljZW5zZSIuDQoNCklmIHlvdSBoYXZlIEludmFyaWFudCBTZWN0aW9u
cywgRnJvbnQtQ292ZXIgVGV4dHMgYW5kIEJhY2stQ292ZXIgVGV4dHMsDQpyZXBsYWNlIHRo
ZSAid2l0aC4uLlRleHRzLiIgbGluZSB3aXRoIHRoaXM6DQoNCiAgICB3aXRoIHRoZSBJbnZh
cmlhbnQgU2VjdGlvbnMgYmVpbmcgTElTVCBUSEVJUiBUSVRMRVMsIHdpdGggdGhlDQogICAg
RnJvbnQtQ292ZXIgVGV4dHMgYmVpbmcgTElTVCwgYW5kIHdpdGggdGhlIEJhY2stQ292ZXIg
VGV4dHMgYmVpbmcgTElTVC4NCg0KSWYgeW91IGhhdmUgSW52YXJpYW50IFNlY3Rpb25zIHdp
dGhvdXQgQ292ZXIgVGV4dHMsIG9yIHNvbWUgb3RoZXINCmNvbWJpbmF0aW9uIG9mIHRoZSB0
aHJlZSwgbWVyZ2UgdGhvc2UgdHdvIGFsdGVybmF0aXZlcyB0byBzdWl0IHRoZQ0Kc2l0dWF0
aW9uLg0KDQpJZiB5b3VyIGRvY3VtZW50IGNvbnRhaW5zIG5vbnRyaXZpYWwgZXhhbXBsZXMg
b2YgcHJvZ3JhbSBjb2RlLCB3ZQ0KcmVjb21tZW5kIHJlbGVhc2luZyB0aGVzZSBleGFtcGxl
cyBpbiBwYXJhbGxlbCB1bmRlciB5b3VyIGNob2ljZSBvZg0KZnJlZSBzb2Z0d2FyZSBsaWNl
bnNlLCBzdWNoIGFzIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSwNCnRvIHBlcm1p
dCB0aGVpciB1c2UgaW4gZnJlZSBzb2Z0d2FyZS4NCg0KVGhlIEVuZC4NCg==
--------------8F2755065F9007E1085D124E
Content-Type: text/plain; charset=UTF-8;
 name="spkguide-v3.rst"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="spkguide-v3.rst"

Li4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKCj09PT09PT09PT09PT09PT09
PT09PT09PQpUaGUgU3BlYWt1cCBVc2VyJ3MgR3VpZGUKPT09PT09PT09PT09PT09PT09PT09
PT09Cgp8IEZvciBTcGVha3VwIDMuMS4yIGFuZCBMYXRlcgp8IEJ5IEdlbmUgQ29sbGlucwp8
IFVwZGF0ZWQgYnkgb3RoZXJzCnwgTGFzdCBtb2RpZmllZCBvbiBNb24gSnVuIDMgMTc6MDg6
MjEgMjAyMQp8IERvY3VtZW50IHZlcnNpb24gMS4zCgoKLi4gY29udGVudHM6OiA6bG9jYWw6
CgoKQ29weXJpZ2h0Cj09PT09PT09PQoKOkF1dGhvcnM6CiBDb3B5cmlnaHQgKGMpIDIwMDUg
IEdlbmUgQ29sbGlucwoKIENvcHlyaWdodCAoYykgMjAwOCAgU2FtdWVsIFRoaWJhdWx0Cgog
Q29weXJpZ2h0IChjKSAyMDA5LCAyMDEwICB0aGUgU3BlYWt1cCBUZWFtCgoKUHJlZmFjZQo9
PT09PT09CgpUaGUgcHVycG9zZSBvZiB0aGlzIGRvY3VtZW50IGlzIHRvIGZhbWlsaWFyaXpl
IHVzZXJzIHdpdGggdGhlIHVzZXIKaW50ZXJmYWNlIHRvIFNwZWFrdXAsIGEgTGludXggU2Ny
ZWVuIFJlYWRlci4gIElmIHlvdSBuZWVkIGluc3RydWN0aW9ucwpmb3IgaW5zdGFsbGluZyBv
ciBvYnRhaW5pbmcgU3BlYWt1cCwgdmlzaXQgdGhlIHdlYiBzaXRlIGF0Cmh0dHA6Ly9saW51
eC1zcGVha3VwLm9yZy8uICBTcGVha3VwIGlzIGEgc2V0IG9mIHBhdGNoZXMgdG8gdGhlIHN0
YW5kYXJkCkxpbnV4IGtlcm5lbCBzb3VyY2UgdHJlZS4gIEl0IGNhbiBiZSBidWlsdCBhcyBh
IHNlcmllcyBvZiBtb2R1bGVzLCBvciBhcwphIHBhcnQgb2YgYSBtb25vbGl0aGljIGtlcm5l
bC4gIFRoZXNlIGRldGFpbHMgYXJlIGJleW9uZCB0aGUgc2NvcGUgb2YKdGhpcyBtYW51YWws
IGJ1dCB0aGUgdXNlciBtYXkgbmVlZCB0byBiZSBhd2FyZSBvZiB0aGUgbW9kdWxlCmNhcGFi
aWxpdGllcywgZGVwZW5kaW5nIG9uIGhvdyB5b3VyIHN5c3RlbSBhZG1pbmlzdHJhdG9yIGhh
cyBpbnN0YWxsZWQKU3BlYWt1cC4gIElmIFNwZWFrdXAgaXMgYnVpbHQgYXMgYSBwYXJ0IG9m
IGEgbW9ub2xpdGhpYyBrZXJuZWwsIGFuZCB0aGUKdXNlciBpcyB1c2luZyBhIGhhcmR3YXJl
IHN5bnRoZXNpemVyLCB0aGVuIFNwZWFrdXAgd2lsbCBiZSBhYmxlIHRvCnByb3ZpZGUgc3Bl
ZWNoIGFjY2VzcyBmcm9tIHRoZSB0aW1lIHRoZSBrZXJuZWwgaXMgbG9hZGVkLCB1bnRpbCB0
aGUgdGltZQp0aGUgc3lzdGVtIGlzIHNodXRkb3duLiAgVGhpcyBtZWFucyB0aGF0IGlmIHlv
dSBoYXZlIG9idGFpbmVkIExpbnV4Cmluc3RhbGxhdGlvbiBtZWRpYSBmb3IgYSBkaXN0cmli
dXRpb24gd2hpY2ggaW5jbHVkZXMgU3BlYWt1cCBhcyBhIHBhcnQKb2YgaXRzIGtlcm5lbCwg
eW91IHdpbGwgYmUgYWJsZSwgYXMgYSBibGluZCBwZXJzb24sIHRvIGluc3RhbGwgTGludXgK
d2l0aCBzcGVlY2ggYWNjZXNzIHVuYWlkZWQgYnkgYSBzaWdodGVkIHBlcnNvbi4gIEFnYWlu
LCB0aGVzZSBkZXRhaWxzCmFyZSBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoaXMgbWFudWFsLCBi
dXQgdGhlIHVzZXIgc2hvdWxkIGJlIGF3YXJlIG9mCnRoZW0uICBTZWUgdGhlIHdlYiBzaXRl
IG1lbnRpb25lZCBhYm92ZSBmb3IgZnVydGhlciBkZXRhaWxzLgoKCjEuICBTdGFydGluZyBT
cGVha3VwCj09PT09PT09PT09PT09PT09PT09CgpJZiB5b3VyIHN5c3RlbSBhZG1pbmlzdHJh
dG9yIGhhcyBpbnN0YWxsZWQgU3BlYWt1cCB0byB3b3JrIHdpdGggeW91cgpzcGVjaWZpYyBz
eW50aGVzaXplciBieSBkZWZhdWx0LCB0aGVuIGFsbCB5b3UgbmVlZCB0byBkbyB0byB1c2Ug
U3BlYWt1cAppcyB0byBib290IHlvdXIgc3lzdGVtLCBhbmQgU3BlYWt1cCBzaG91bGQgY29t
ZSB1cCB0YWxraW5nLiAgVGhpcwphc3N1bWVzIG9mIGNvdXJzZSAgdGhhdCB5b3VyIHN5bnRo
ZXNpemVyIGlzIGEgc3VwcG9ydGVkIGhhcmR3YXJlCnN5bnRoZXNpemVyLCBhbmQgdGhhdCBp
dCBpcyBlaXRoZXIgaW5zdGFsbGVkIGluIG9yIGNvbm5lY3RlZCB0byB5b3VyCnN5c3RlbSwg
YW5kIGlzIGlmIG5lY2Vzc2FyeSBwb3dlcmVkIG9uLgoKSXQgaXMgcG9zc2libGUsIGhvd2V2
ZXIsIHRoYXQgU3BlYWt1cCBtYXkgaGF2ZSBiZWVuIGNvbXBpbGVkIGludG8gdGhlCmtlcm5l
bCB3aXRoIG5vIGRlZmF1bHQgc3ludGhlc2l6ZXIuICBJdCBpcyBldmVuIHBvc3NpYmxlIHRo
YXQgeW91cgprZXJuZWwgaGFzIGJlZW4gY29tcGlsZWQgd2l0aCBzdXBwb3J0IGZvciBzb21l
IG9mIHRoZSBzdXBwb3J0ZWQKc3ludGhlc2l6ZXJzIGFuZCBub3Qgb3RoZXJzLiAgSWYgeW91
IGZpbmQgdGhhdCB0aGlzIGlzIHRoZSBjYXNlLCBhbmQKeW91ciBzeW50aGVzaXplciBpcyBz
dXBwb3J0ZWQgYnV0IG5vdCBhdmFpbGFibGUsIGNvbXBsYWluIHRvIHRoZSBwZXJzb24Kd2hv
IGNvbXBpbGVkIGFuZCBpbnN0YWxsZWQgeW91ciBrZXJuZWwuICBPciBiZXR0ZXIgeWV0LCBn
byB0byB0aGUgd2ViCnNpdGUsIGFuZCBsZWFybiBob3cgdG8gcGF0Y2ggU3BlYWt1cCBpbnRv
IHlvdXIgb3duIGtlcm5lbCBzb3VyY2UsIGFuZApidWlsZCBhbmQgaW5zdGFsbCB5b3VyIG93
biBrZXJuZWwuCgpJZiB5b3VyIGtlcm5lbCBoYXMgYmVlbiBjb21waWxlZCB3aXRoIFNwZWFr
dXAsIGFuZCBoYXMgbm8gZGVmYXVsdApzeW50aGVzaXplciBzZXQsIG9yIHlvdSB3b3VsZCBs
aWtlIHRvIHVzZSBhIGRpZmZlcmVudCBzeW50aGVzaXplciB0aGFuCnRoZSBkZWZhdWx0IG9u
ZSwgdGhlbiB5b3UgbWF5IGlzc3VlIHRoZSBmb2xsb3dpbmcgY29tbWFuZCBhdCB0aGUgYm9v
dApwcm9tcHQgb2YgeW91ciBib290IGxvYWRlci46OgoKICBsaW51eCBzcGVha3VwLnN5bnRo
PWx0bGsKClRoaXMgY29tbWFuZCB3b3VsZCB0ZWxsIFNwZWFrdXAgdG8gbG9vayBmb3IgYW5k
IHVzZSBhIExpdGVUYWxrIG9yCkRvdWJsZVRhbGsgTFQgYXQgYm9vdCB1cC4gIFlvdSBtYXkg
cmVwbGFjZSB0aGUgbHRsayBzeW50aGVzaXplciBrZXl3b3JkCndpdGggdGhlIGtleXdvcmQg
Zm9yIHdoYXRldmVyIHN5bnRoZXNpemVyIHlvdSB3aXNoIHRvIHVzZS4gIFRoZQpgYHNwZWFr
dXAuc3ludGhgYCBwYXJhbWV0ZXIgd2lsbCBhY2NlcHQgdGhlIGZvbGxvd2luZyBrZXl3b3Jk
cywgcHJvdmlkZWQKdGhhdCBzdXBwb3J0IGZvciB0aGUgcmVsYXRlZCBzeW50aGVzaXplcnMg
aGFzIGJlZW4gYnVpbHQgaW50byB0aGUKa2VybmVsLgoKICBhY250c2EgLS0gQWNjZW50IFNB
CgogIGFjbnRwYyAtLSBBY2NlbnQgUEMKCiAgYXBvbGxvIC0tIEFwb2xsbwoKICBhdWRwdHIg
LS0gQXVkYXB0ZXIKCiAgYm5zIC0tIEJyYWlsbGUgJ24gU3BlYWsKCiAgZGVjdGxrIC0tIERl
Y1RhbGsgRXhwcmVzcyAob2xkIGFuZCBuZXcsIGRiOSBzZXJpYWwgb25seSkKCiAgZGVjZXh0
IC0tIERlY1RhbGsgKG9sZCkgRXh0ZXJuYWwKCiAgZHRsayAtLSBEb3VibGVUYWxrIFBDCgog
IGtleXBjIC0tIEtleW5vdGUgR29sZCBQQwoKICBsdGxrIC0tIERvdWJsZVRhbGsgTFQsIExp
dGVUYWxrLCBvciBleHRlcm5hbCBUcmlwbGV0YWxrIChkYjkgc2VyaWFsIG9ubHkpCgogIHNw
a291dCAtLSBTcGVhayBPdXQKCiAgdHhwcnQgLS0gVHJhbnNwb3J0CgogIGR1bW15IC0tIFBs
YWluIHRleHQgdGVybWluYWwKCi4uIG5vdGU6OgogICBTcGVha3VwIGFsc28gZG9lcyAqKk5P
VCoqIHN1cHBvcnQgdGhlIGludGVybmFsIFRyaXBsZXRhbGshCgpTcGVha3VwIGRvZXMgc3Vw
cG9ydCB0d28gb3RoZXIgc3ludGhlc2l6ZXJzLCBidXQgYmVjYXVzZSB0aGV5IHdvcmsgaW4K
Y29uanVuY3Rpb24gd2l0aCBvdGhlciBzb2Z0d2FyZSwgdGhleSBtdXN0IGJlIGxvYWRlZCBh
cyBtb2R1bGVzIGFmdGVyCnRoZWlyIHJlbGF0ZWQgc29mdHdhcmUgaXMgbG9hZGVkLCBhbmQg
c28gYXJlIG5vdCBhdmFpbGFibGUgYXQgYm9vdCB1cC4KVGhlc2UgYXJlIGFzIGZvbGxvd3M6
CgogIGRlY3BjIC0tIERlY1RhbGsgUEMgKG5vdCBhdmFpbGFibGUgYXQgYm9vdCB1cCkKCiAg
c29mdCAtLSBPbmUgb2Ygc2V2ZXJhbCBzb2Z0d2FyZSBzeW50aGVzaXplcnMgKG5vdCBhdmFp
bGFibGUgYXQgYm9vdCB1cCkKClNlZSB0aGUgc2VjdGlvbnMgb24gbG9hZGluZyBtb2R1bGVz
IGFuZCBzb2Z0d2FyZSBzeW50aGVzaXplcnMgbGF0ZXIgaW4KdGhpcyBtYW51YWwgZm9yIGZ1
cnRoZXIgZGV0YWlscy4gIEl0IHNob3VsZCBiZSBub3RlZCBoZXJlIHRoYXQgdGhlCnNwZWFr
dXAuc3ludGggYm9vdCBwYXJhbWV0ZXIgd2lsbCBoYXZlIG5vIGVmZmVjdCBpZiBTcGVha3Vw
IGhhcyBiZWVuCmNvbXBpbGVkIGFzIG1vZHVsZXMuICBJbiBvcmRlciBmb3IgU3BlYWt1cCBt
b2R1bGVzIHRvIGJlIGxvYWRlZCBkdXJpbmcKdGhlIGJvb3QgcHJvY2Vzcywgc3VjaCBhY3Rp
b24gbXVzdCBiZSBjb25maWd1cmVkIGJ5IHlvdXIgc3lzdGVtCmFkbWluaXN0cmF0b3IuICBU
aGlzIHdpbGwgbWVhbiB0aGF0IHlvdSB3aWxsIGhlYXIgc29tZSwgYnV0IG5vdCBhbGwsICBv
Zgp0aGUgYm9vdHVwIG1lc3NhZ2VzLgoKCjIuICBCYXNpYyBvcGVyYXRpb24KPT09PT09PT09
PT09PT09PT09PQoKT25jZSB5b3UgaGF2ZSBib290ZWQgdGhlIHN5c3RlbSwgYW5kIGlmIG5l
Y2Vzc2FyeSwgaGF2ZSBzdXBwbGllZCB0aGUKcHJvcGVyIGJvb3R1cCBwYXJhbWV0ZXIgZm9y
IHlvdXIgc3ludGhlc2l6ZXIsIFNwZWFrdXAgd2lsbCBiZWdpbgp0YWxraW5nIGFzIHNvb24g
YXMgdGhlIGtlcm5lbCBpcyBsb2FkZWQuICBJbiBmYWN0LCBpdCB3aWxsIHRhbGsgYSBsb3Qh
Ckl0IHdpbGwgc3BlYWsgYWxsIHRoZSBib290IHVwIG1lc3NhZ2VzIHRoYXQgdGhlIGtlcm5l
bCBwcmludHMgb24gdGhlCnNjcmVlbiBkdXJpbmcgdGhlIGJvb3QgcHJvY2Vzcy4gIFRoaXMg
aXMgYmVjYXVzZSBTcGVha3VwIGlzIG5vdCBhCnNlcGFyYXRlIHNjcmVlbiByZWFkZXIsIGJ1
dCBpcyBhY3R1YWxseSBidWlsdCBpbnRvIHRoZSBvcGVyYXRpbmcKc3lzdGVtLiAgU2luY2Ug
YWxtb3N0IGFsbCBjb25zb2xlIGFwcGxpY2F0aW9ucyBtdXN0IHByaW50IHRleHQgb24gdGhl
CnNjcmVlbiB1c2luZyB0aGUga2VybmVsLCBhbmQgbXVzdCBnZXQgdGhlaXIga2V5Ym9hcmQg
aW5wdXQgdGhyb3VnaCB0aGUKa2VybmVsLCB0aGV5IGFyZSBhdXRvbWF0aWNhbGx5IGhhbmRs
ZWQgcHJvcGVybHkgYnkgU3BlYWt1cC4gIFRoZXJlIGFyZSBhCmZldyBleGNlcHRpb25zLCBi
dXQgd2UnbGwgY29tZSB0byB0aG9zZSBsYXRlci4KCi4uIG5vdGU6OgoKICBJbiB0aGlzIGd1
aWRlIEkgd2lsbCByZWZlciB0byB0aGUgbnVtZXJpYyBrZXlwYWQgYXMgdGhlIGtleXBhZC4K
ICBUaGlzIGlzIGRvbmUgYmVjYXVzZSB0aGUgc3BlYWt1cG1hcC5tYXAgZmlsZSByZWZlcnJl
ZCB0byBsYXRlciBpbiB0aGlzCiAgbWFudWFsIHVzZXMgdGhlIHRlcm0ga2V5cGFkIGluc3Rl
YWQgb2YgbnVtZXJpYyBrZXlwYWQuICBBbHNvIEknbSBsYXp5CiAgYW5kIHdvdWxkIHJhdGhl
ciBvbmx5IHR5cGUgb25lIHdvcmQuICBTbyBrZXlwYWQgaXQgaXMuICBHb3QgaXQ/ICBHb29k
LgoKTW9zdCBvZiB0aGUgU3BlYWt1cCByZXZpZXcga2V5cyBhcmUgbG9jYXRlZCBvbiB0aGUg
a2V5cGFkIGF0IHRoZSBmYXIKcmlnaHQgb2YgdGhlIGtleWJvYXJkLiAgVGhlIG51bWxvY2sg
a2V5IHNob3VsZCBiZSBvZmYsIGluIG9yZGVyIGZvciB0aGVzZQp0byB3b3JrLiAgSWYgeW91
IHRvZ2dsZSB0aGUgbnVtbG9jayBvbiwgdGhlIGtleXBhZCB3aWxsIHByb2R1Y2UgbnVtYmVy
cywKd2hpY2ggaXMgZXhhY3RseSB3aGF0IHlvdSB3YW50IGZvciBzcHJlYWRzaGVldHMgYW5k
IHN1Y2guICBGb3IgdGhlCnB1cnBvc2VzIG9mIHRoaXMgZ3VpZGUsIHlvdSBzaG91bGQgaGF2
ZSB0aGUgbnVtbG9jayB0dXJuZWQgb2ZmLCB3aGljaCBpcwppdHMgZGVmYXVsdCBzdGF0ZSBh
dCBib290dXAuCgpZb3UgcHJvYmFibHkgd29uJ3Qgd2FudCB0byBsaXN0ZW4gdG8gYWxsIHRo
ZSBib290dXAgbWVzc2FnZXMgZXZlcnkgdGltZQp5b3Ugc3RhcnQgeW91ciBzeXN0ZW0sIHRo
b3VnaCBpdCdzIGEgZ29vZCBpZGVhIHRvIGxpc3RlbiB0byB0aGVtIGF0CmxlYXN0IG9uY2Us
IGp1c3Qgc28geW91J2xsIGtub3cgd2hhdCBraW5kIG9mIGluZm9ybWF0aW9uIGlzIGF2YWls
YWJsZSB0bwp5b3UgZHVyaW5nIHRoZSBib290IHByb2Nlc3MuICBZb3UgY2FuIGFsd2F5cyBy
ZXZpZXcgdGhlc2UgbWVzc2FnZXMgYWZ0ZXIKYm9vdHVwIHdpdGggdGhlIGNvbW1hbmQ6OgoK
ICBkbWVzZyB8IG1vcmUKCkluIG9yZGVyIHRvIHNwZWVkIHRoZSBib290IHByb2Nlc3MsIGFu
ZCB0byBzaWxlbmNlIHRoZSBzcGVha2luZyBvZiB0aGUKYm9vdHVwIG1lc3NhZ2VzLCBqdXN0
IHByZXNzIHRoZSBrZXlwYWQgZW50ZXIga2V5LiAgVGhpcyBrZXkgaXMgbG9jYXRlZAppbiB0
aGUgYm90dG9tIHJpZ2h0IGNvcm5lciBvZiB0aGUga2V5cGFkLiAgU3BlYWt1cCB3aWxsIHNo
dXQgdXAgYW5kIHN0YXkKdGhhdCB3YXksIHVudGlsIHlvdSBwcmVzcyBhbm90aGVyIGtleS4K
CllvdSBjYW4gY2hlY2sgdG8gc2VlIGlmIHRoZSBib290IHByb2Nlc3MgaGFzIGNvbXBsZXRl
ZCBieSBwcmVzc2luZyB0aGUgOAprZXkgb24gdGhlIGtleXBhZCwgd2hpY2ggcmVhZHMgdGhl
IGN1cnJlbnQgbGluZS4gIFRoaXMgYWxzbyBoYXMgdGhlCmVmZmVjdCBvZiBzdGFydGluZyBT
cGVha3VwIHRhbGtpbmcgYWdhaW4sIHNvIHlvdSBjYW4gcHJlc3Mga2V5cGFkIGVudGVyCnRv
IHNpbGVuY2UgaXQgYWdhaW4gaWYgdGhlIGJvb3QgcHJvY2VzcyBoYXMgbm90IGNvbXBsZXRl
ZC4KCldoZW4gdGhlIGJvb3QgcHJvY2VzcyBpcyBjb21wbGV0ZSwgeW91IHdpbGwgYXJyaXZl
IGF0IGEgImxvZ2luIiBwcm9tcHQuCkF0IHRoaXMgcG9pbnQsIHlvdSdsbCBuZWVkIHRvIHR5
cGUgaW4geW91ciB1c2VyIGlkIGFuZCBwYXNzd29yZCwgYXMKcHJvdmlkZWQgYnkgeW91ciBz
eXN0ZW0gYWRtaW5pc3RyYXRvci4gIFlvdSB3aWxsIGhlYXIgU3BlYWt1cCBzcGVhayB0aGUK
bGV0dGVycyBvZiB5b3VyIHVzZXIgaWQgYXMgeW91IHR5cGUgaXQsIGJ1dCBub3QgdGhlIHBh
c3N3b3JkLiAgVGhpcyBpcwpiZWNhdXNlIHRoZSBwYXNzd29yZCBpcyBub3QgZGlzcGxheWVk
IG9uIHRoZSBzY3JlZW4gZm9yIHNlY3VyaXR5CnJlYXNvbnMuICBUaGlzIGhhcyBub3RoaW5n
IHRvIGRvIHdpdGggU3BlYWt1cCwgaXQncyBhIExpbnV4IHNlY3VyaXR5CmZlYXR1cmUuCgpP
bmNlIHlvdSd2ZSBsb2dnZWQgaW4sIHlvdSBjYW4gcnVuIGFueSBMaW51eCBjb21tYW5kIG9y
IHByb2dyYW0gd2hpY2ggaXMKYWxsb3dlZCBieSB5b3VyIHVzZXIgaWQuICBOb3JtYWwgdXNl
cnMgd2lsbCBub3QgYmUgYWJsZSB0byBydW4gcHJvZ3JhbXMKd2hpY2ggcmVxdWlyZSByb290
IHByaXZpbGVnZXMuCgpXaGVuIHlvdSBhcmUgcnVubmluZyBhIHByb2dyYW0gb3IgY29tbWFu
ZCwgU3BlYWt1cCB3aWxsIGF1dG9tYXRpY2FsbHkKc3BlYWsgbmV3IHRleHQgYXMgaXQgYXJy
aXZlcyBvbiB0aGUgc2NyZWVuLiAgWW91IGNhbiBhdCBhbnkgdGltZSBzaWxlbmNlCnRoZSBz
cGVlY2ggd2l0aCBrZXlwYWQgZW50ZXIsIG9yIHVzZSBhbnkgb2YgdGhlIFNwZWFrdXAgcmV2
aWV3IGtleXMuCgpIZXJlIGFyZSBzb21lIGJhc2ljIFNwZWFrdXAgcmV2aWV3IGtleXMsIGFu
ZCBhIHNob3J0IGRlc2NyaXB0aW9uIG9mIHdoYXQKdGhleSBkby4KCiAga2V5cGFkIDEgLS0g
cmVhZCBwcmV2aW91cyBjaGFyYWN0ZXIKCiAga2V5cGFkIDIgLS0gcmVhZCBjdXJyZW50IGNo
YXJhY3RlciAocHJlc3Npbmcga2V5cGFkIDIgdHdpY2UgcmFwaWRseSB3aWxsIHNwZWFrCiAg
dGhlIGN1cnJlbnQgY2hhcmFjdGVyIHBob25ldGljYWxseSkKCiAga2V5cGFkIDMgLS0gcmVh
ZCBuZXh0IGNoYXJhY3RlcgoKICBrZXlwYWQgNCAtLSByZWFkIHByZXZpb3VzIHdvcmQKCiAg
a2V5cGFkIDUgLS0gcmVhZCBjdXJyZW50IHdvcmQgKHByZXNzIHR3aWNlIHJhcGlkbHkgdG8g
c3BlbGwgdGhlIGN1cnJlbnQgd29yZCkKCiAga2V5cGFkIDYgLS0gcmVhZCBuZXh0IHdvcmQK
CiAga2V5cGFkIDcgLS0gcmVhZCBwcmV2aW91cyBsaW5lCgogIGtleXBhZCA4IC0tIHJlYWQg
Y3VycmVudCBsaW5lIChwcmVzcyB0d2ljZSByYXBpZGx5IHRvIGhlYXIgaG93IG11Y2ggdGhl
CiAgdGV4dCBvbiB0aGUgY3VycmVudCBsaW5lIGlzIGluZGVudGVkKQoKICBrZXlwYWQgOSAt
LSByZWFkIG5leHQgbGluZQoKICBrZXlwYWQgcGVyaW9kIC0tIHNwZWFrIGN1cnJlbnQgY3Vy
c29yIHBvc2l0aW9uIGFuZCBhbm5vdW5jZSBjdXJyZW50CiAgdmlydHVhbCBjb25zb2xlCgpJ
dCdzIGFsc28gd29ydGggbm90aW5nIHRoYXQgdGhlIGluc2VydCBrZXkgb24gdGhlIGtleXBh
ZCBpcyBtYXBwZWQKYXMgdGhlIHNwZWFrdXAga2V5LiAgSW5zdGVhZCBvZiBwcmVzc2luZyBh
bmQgcmVsZWFzaW5nIHRoaXMga2V5LCBhcyB5b3UKZG8gdW5kZXIgRE9TIG9yIFdpbmRvd3Ms
IHlvdSBob2xkIGl0IGxpa2UgYSBzaGlmdCBrZXksIGFuZCBwcmVzcyBvdGhlcgprZXlzIGlu
IGNvbWJpbmF0aW9uIHdpdGggaXQuICBGb3IgZXhhbXBsZSwgcmVwZWF0ZWRseSBob2xkaW5n
IGtleXBhZAppbnNlcnQsIGZyb20gbm93IG9uIGNhbGxlZCBzcGVha3VwLCBhbmQga2V5cGFk
IGVudGVyIHdpbGwgdG9nZ2xlIHRoZQpzcGVha2luZyBvZiBuZXcgdGV4dCBvbiB0aGUgc2Ny
ZWVuIG9uIGFuZCBvZmYuICBUaGlzIGlzIG5vdCB0aGUgc2FtZSBhcwpqdXN0IHByZXNzaW5n
IGtleXBhZCBlbnRlciBieSBpdHNlbGYsIHdoaWNoIGp1c3Qgc2lsZW5jZXMgdGhlIHNwZWVj
aAp1bnRpbCB5b3UgaGl0IGFub3RoZXIga2V5LiAgV2hlbiB5b3UgaGl0IHNwZWFrdXAgcGx1
cyBrZXlwYWQgZW50ZXIsClNwZWFrdXAgd2lsbCBzYXksICJZb3UgdHVybmVkIG1lIG9mZi4i
LCBvciAiSGV5LCB0aGF0J3MgYmV0dGVyLiIgIFdoZW4KU3BlYWt1cCBpcyB0dXJuZWQgb2Zm
LCBubyBuZXcgdGV4dCBvbiB0aGUgc2NyZWVuIHdpbGwgYmUgc3Bva2VuLiAgWW91CmNhbiBz
dGlsbCB1c2UgdGhlIHJlYWRpbmcgY29udHJvbHMgdG8gcmV2aWV3IHRoZSBzY3JlZW4gaG93
ZXZlci4KCgozLiAgVXNpbmcgdGhlIFNwZWFrdXAgSGVscCBTeXN0ZW0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CgpJbiBvcmRlciB0byBlbnRlciB0aGUgU3BlYWt1cCBo
ZWxwIHN5c3RlbSwgcHJlc3MgYW5kIGhvbGQgdGhlIHNwZWFrdXAKa2V5IChyZW1lbWJlciB0
aGF0IHRoaXMgaXMgdGhlIGtleXBhZCBpbnNlcnQga2V5KSwgYW5kIHByZXNzIHRoZSBgZjFg
IGtleS4KWW91IHdpbGwgaGVhciB0aGUgbWVzc2FnZToKCiJQcmVzcyBzcGFjZSB0byBsZWF2
ZSBoZWxwLCBjdXJzb3IgdXAgb3IgZG93biB0byBzY3JvbGwsIG9yIGEgbGV0dGVyIHRvCmdv
IHRvIGNvbW1hbmRzIGluIGxpc3QuIgoKV2hlbiB5b3UgcHJlc3MgdGhlIGBzcGFjZWJhcmAg
dG8gbGVhdmUgdGhlIGhlbHAgc3lzdGVtLCB5b3Ugd2lsbCBoZWFyOgoKIkxlYXZpbmcgaGVs
cC4iCgpXaGlsZSB5b3UgYXJlIGluIHRoZSBTcGVha3VwIGhlbHAgc3lzdGVtLCB5b3UgY2Fu
IHNjcm9sbCB1cCBvciBkb3duCnRocm91Z2ggdGhlIGxpc3Qgb2YgYXZhaWxhYmxlIGNvbW1h
bmRzIHVzaW5nIHRoZSBjdXJzb3Iga2V5cy4gIFRoZSBsaXN0Cm9mIGNvbW1hbmRzIGlzIGFy
cmFuZ2VkIGluIGFscGhhYmV0aWNhbCBvcmRlci4gIElmIHlvdSB3aXNoIHRvIGp1bXAgdG8K
Y29tbWFuZHMgaW4gYSBzcGVjaWZpYyBwYXJ0IG9mIHRoZSBhbHBoYWJldCwgeW91IG1heSBw
cmVzcyB0aGUgbGV0dGVyIG9mCnRoZSBhbHBoYWJldCB5b3Ugd2lzaCB0byBqdW1wIHRvLgoK
WW91IGNhbiBhbHNvIGp1c3QgZXhwbG9yZSBieSB0eXBpbmcga2V5Ym9hcmQga2V5cy4gIFBy
ZXNzaW5nIGtleXMgd2lsbApjYXVzZSBTcGVha3VwIHRvIHNwZWFrIHRoZSBjb21tYW5kIGFz
c29jaWF0ZWQgd2l0aCB0aGF0IGtleS4gIEZvcgpleGFtcGxlLCBpZiB5b3UgcHJlc3MgdGhl
IGtleXBhZCA4IGtleSwgeW91IHdpbGwgaGVhcjoKCiJLZXlwYWQgOCBpcyBsaW5lLCBzYXkg
Y3VycmVudC4iCgpZb3UnbGwgbm90aWNlIHRoYXQgc29tZSBjb21tYW5kcyBkbyBub3QgaGF2
ZSBrZXlzIGFzc2lnbmVkIHRvIHRoZW0uClRoaXMgaXMgYmVjYXVzZSB0aGV5IGFyZSB2ZXJ5
IGluZnJlcXVlbnRseSB1c2VkIGNvbW1hbmRzLCBhbmQgYXJlIGFsc28KYWNjZXNzaWJsZSB0
aHJvdWdoIHRoZSBzeXMgc3lzdGVtLiAgV2UnbGwgZGlzY3VzcyB0aGUgc3lzIHN5c3RlbSBs
YXRlcgppbiB0aGlzIG1hbnVhbC4KCllvdSdsbCBhbHNvIG5vdGljZSB0aGF0IHNvbWUgY29t
bWFuZHMgaGF2ZSB0d28ga2V5cyBhc3NpZ25lZCB0byB0aGVtLgpUaGlzIGlzIGJlY2F1c2Ug
U3BlYWt1cCBoYXMgYSBidWlsdCBpbiBzZXQgb2YgYWx0ZXJuYXRpdmUga2V5IGJpbmRpbmdz
CmZvciBsYXB0b3AgdXNlcnMuICBUaGUgYWx0ZXJuYXRlIHNwZWFrdXAga2V5IGlzIHRoZSBg
Y2FwcyBsb2NrYCBrZXkuICBZb3UKY2FuIHByZXNzIGFuZCBob2xkIHRoZSBgY2FwcyBsb2Nr
YCBrZXksIHdoaWxlIHByZXNzaW5nIGFuIGFsdGVybmF0ZQpzcGVha3VwIGNvbW1hbmQga2V5
IHRvIGFjdGl2YXRlIHRoZSBjb21tYW5kLiAgT24gbW9zdCBsYXB0b3BzLCB0aGUKbnVtZXJp
YyBrZXlwYWQgaXMgZGVmaW5lZCBhcyB0aGUga2V5cyBpbiB0aGUgYGogayBsYCBhcmVhIG9m
IHRoZSBrZXlib2FyZC4KClRoZXJlIGlzIHVzdWFsbHkgYSBmdW5jdGlvbiBrZXkgd2hpY2gg
dHVybnMgdGhpcyBrZXlwYWQgZnVuY3Rpb24gb24gYW5kCm9mZiwgYW5kIHNvbWUgb3RoZXIg
a2V5IHdoaWNoIGNvbnRyb2xzIHRoZSBudW1sb2NrIHN0YXRlLiAgVG9nZ2xpbmcgdGhlCmtl
eXBhZCBmdW5jdGlvbmFsaXR5IG9uIGFuZCBvZmYgY2FuIGJlY29tZSBhIHJveWFsIHBhaW4u
ICBTbywgU3BlYWt1cApnaXZlcyB5b3UgYSBzaW1wbGUgd2F5IHRvIGdldCBhdCBhbiBhbHRl
cm5hdGl2ZSBzZXQgb2Yga2V5IG1hcHBpbmdzIGZvcgp5b3VyIGxhcHRvcC4gIFRoZXNlIGFy
ZSBhbHNvIGF2YWlsYWJsZSBieSBkZWZhdWx0IG9uIGRlc2t0b3Agc3lzdGVtcywKYmVjYXVz
ZSBTcGVha3VwIGRvZXMgbm90IGtub3cgd2hldGhlciBpdCBpcyBydW5uaW5nIG9uIGEgZGVz
a3RvcCBvcgpsYXB0b3AuICBTbyB5b3UgbWF5IGNob29zZSB3aGljaCBzZXQgb2YgU3BlYWt1
cCBrZXlzIHRvIHVzZS4gIFNvbWUKc3lzdGVtIGFkbWluaXN0cmF0b3JzIG1heSBoYXZlIGNo
b3NlbiB0byBjb21waWxlIFNwZWFrdXAgZm9yIGEgZGVza3RvcApzeXN0ZW0gd2l0aG91dCB0
aGlzIHNldCBvZiBhbHRlcm5hdGUga2V5IGJpbmRpbmdzLCBidXQgdGhlc2UgZGV0YWlscyBh
cmUKYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIG1hbnVhbC4gIFRvIHVzZSB0aGUgYGNhcHMg
bG9ja2AgZm9yIGl0cyBub3JtYWwKcHVycG9zZSwgaG9sZCB0aGUgc2hpZnQga2V5IHdoaWxl
IHRvZ2dsaW5nIHRoZSBgY2FwcyBsb2NrYCBvbiBhbmQgb2ZmLgoKLi4gbm90ZTo6CgogIEhv
bGRpbmcgdGhlIGBjYXBzIGxvY2tgIGtleSBhbmQgcHJlc3NpbmcgdGhlIGB6YCBrZXkgd2ls
bCB0b2dnbGUgdGhlCiAgYWx0ZXJuYXRlIGBqIGsgbGAga2V5cGFkIG9uIGFuZCBvZmYuCgoK
NC4gIEtleXMgYW5kIFRoZWlyIEFzc2lnbmVkIENvbW1hbmRzCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQoKSW4gdGhpcyBzZWN0aW9uLCB3ZSdsbCBnbyB0aHJvdWdo
IGEgbGlzdCBvZiBhbGwgdGhlIHNwZWFrdXAga2V5cyBhbmQKY29tbWFuZHMuICBZb3UgY2Fu
IGFsc28gZ2V0IGEgbGlzdCBvZiBjb21tYW5kcyBhbmQgYXNzaWduZWQga2V5cyBmcm9tCnRo
ZSBoZWxwIHN5c3RlbS4KClRoZSBmb2xsb3dpbmcgbGlzdCB3YXMgdGFrZW4gZnJvbSB0aGUg
YGBzcGVha3VwbWFwLm1hcGBgIGZpbGUuICBLZXkKYXNzaWdubWVudHMgYXJlIG9uIHRoZSBs
ZWZ0IG9mIHRoZSBlcXVhbCBzaWduLCBhbmQgdGhlIGFzc29jaWF0ZWQKU3BlYWt1cCBjb21t
YW5kcyBhcmUgb24gdGhlIHJpZ2h0LiAgVGhlIGRlc2lnbmF0aW9uICJzcGsiIG1lYW5zIHRv
IHByZXNzCmFuZCBob2xkIHRoZSBzcGVha3VwIGtleSwgYS5rLmEuIGtleXBhZCBpbnNlcnQs
IGEuay5hLiBgY2FwcyBsb2NrYCwgd2hpbGUKcHJlc3NpbmcgdGhlIG90aGVyIHNwZWNpZmll
ZCBrZXkuCgogIHNwayBrZXlfZjkgPSBwdW5jX2xldmVsX2RlYwoKICBzcGsga2V5X2YxMCA9
IHB1bmNfbGV2ZWxfaW5jCgogIHNwayBrZXlfZjExID0gcmVhZGluZ19wdW5jX2RlYwoKICBz
cGsga2V5X2YxMiA9IHJlYWRpbmdfcHVuY19pbmMKCiAgc3BrIGtleV8xID0gdm9sX2RlYwoK
ICBzcGsga2V5XzIgPSAgdm9sX2luYwoKICBzcGsga2V5XzMgPSBwaXRjaF9kZWMKCiAgc3Br
IGtleV80ID0gcGl0Y2hfaW5jCgogIHNwayBrZXlfNSA9IHJhdGVfZGVjCgogIHNwayBrZXlf
NiA9IHJhdGVfaW5jCgogIGtleV9rcGFzdGVyaXNrID0gdG9nZ2xlX2N1cnNvcmluZwoKICBz
cGsga2V5X2twYXN0ZXJpc2sgPSBzcGVha3VwX2dvdG8KCiAgc3BrIGtleV9mMSA9IHNwZWFr
dXBfaGVscAoKICBzcGsga2V5X2YyID0gc2V0X3dpbgoKICBzcGsga2V5X2YzID0gY2xlYXJf
d2luCgogIHNwayBrZXlfZjQgPSBlbmFibGVfd2luCgogIHNwayBrZXlfZjUgPSBlZGl0X3Nv
bWUKCiAgc3BrIGtleV9mNiA9IGVkaXRfbW9zdAoKICBzcGsga2V5X2Y3ID0gZWRpdF9kZWxp
bQoKICBzcGsga2V5X2Y4ID0gZWRpdF9yZXBlYXQKCiAgc2hpZnQgc3BrIGtleV9mOSA9IGVk
aXRfZXhudW0KCiAga2V5X2twNyA9IHNheV9wcmV2X2xpbmUKCiAgc3BrIGtleV9rcDcgPSBs
ZWZ0X2VkZ2UKCiAga2V5X2twOCA9IHNheV9saW5lCgogIGRvdWJsZSAga2V5X2twOCA9IHNh
eV9saW5lX2luZGVudAoKICBzcGsga2V5X2twOCA9IHNheV9mcm9tX3RvcAoKICBrZXlfa3A5
ID0gc2F5X25leHRfbGluZQoKICBzcGsgIGtleV9rcDkgPSB0b3BfZWRnZQoKICBrZXlfa3Bt
aW51cyA9IHNwZWFrdXBfcGFya2VkCgogIHNwayBrZXlfa3BtaW51cyA9IHNheV9jaGFyX251
bQoKICBrZXlfa3A0ID0gc2F5X3ByZXZfd29yZAoKICBzcGsga2V5X2twNCA9IHNheV9mcm9t
X2xlZnQKCiAga2V5X2twNSA9IHNheV93b3JkCgogIGRvdWJsZSBrZXlfa3A1ID0gc3BlbGxf
d29yZAoKICBzcGsga2V5X2twNSA9IHNwZWxsX3Bob25ldGljCgogIGtleV9rcDYgPSBzYXlf
bmV4dF93b3JkCgogIHNwayBrZXlfa3A2ID0gc2F5X3RvX3JpZ2h0CgogIGtleV9rcHBsdXMg
PSBzYXlfc2NyZWVuCgogIHNwayBrZXlfa3BwbHVzID0gc2F5X3dpbgoKICBrZXlfa3AxID0g
c2F5X3ByZXZfY2hhcgoKICBzcGsga2V5X2twMSA9IHJpZ2h0X2VkZ2UKCiAga2V5X2twMiA9
IHNheV9jaGFyCgogIHNwayBrZXlfa3AyID0gc2F5X3RvX2JvdHRvbQoKICBkb3VibGUga2V5
X2twMiA9IHNheV9waG9uZXRpY19jaGFyCgogIGtleV9rcDMgPSBzYXlfbmV4dF9jaGFyCgog
IHNwayAga2V5X2twMyA9IGJvdHRvbV9lZGdlCgogIGtleV9rcDAgPSBzcGtfa2V5CgogIGtl
eV9rcGRvdCA9IHNheV9wb3NpdGlvbgoKICBzcGsga2V5X2twZG90ID0gc2F5X2F0dHJpYnV0
ZXMKCiAga2V5X2twZW50ZXIgPSBzcGVha3VwX3F1aWV0CgogIHNwayBrZXlfa3BlbnRlciA9
IHNwZWFrdXBfb2ZmCgogIGtleV9zeXNycSA9IHNwZWVjaF9raWxsCgogIGtleV9rcHNsYXNo
ID0gc3BlYWt1cF9jdXQKCiAgc3BrIGtleV9rcHNsYXNoID0gc3BlYWt1cF9wYXN0ZQoKICBz
cGsga2V5X3BhZ2V1cCA9IHNheV9maXJzdF9jaGFyCgogIHNwayBrZXlfcGFnZWRvd24gPSBz
YXlfbGFzdF9jaGFyCgogIGtleV9jYXBzbG9jayA9IHNwa19rZXkKCiAgc3BrIGtleV96ID0g
c3BrX2xvY2sKCiAga2V5X2xlZnRtZXRhID0gc3BrX2tleQoKICBjdHJsIHNwayBrZXlfMCA9
IHNwZWFrdXBfZ290bwoKICBzcGsga2V5X3UgPSBzYXlfcHJldl9saW5lCgogIHNwayBrZXlf
aSA9IHNheV9saW5lCgogIGRvdWJsZSBzcGsga2V5X2kgPSBzYXlfbGluZV9pbmRlbnQKCiAg
c3BrIGtleV9vID0gc2F5X25leHRfbGluZQoKICBzcGsga2V5X21pbnVzID0gc3BlYWt1cF9w
YXJrZWQKCiAgc2hpZnQgc3BrIGtleV9taW51cyA9IHNheV9jaGFyX251bQoKICBzcGsga2V5
X2ogPSBzYXlfcHJldl93b3JkCgogIHNwayBrZXlfayA9IHNheV93b3JkCgogIGRvdWJsZSBz
cGsga2V5X2sgPSBzcGVsbF93b3JkCgogIHNwayBrZXlfbCA9IHNheV9uZXh0X3dvcmQKCiAg
c3BrIGtleV9tID0gc2F5X3ByZXZfY2hhcgoKICBzcGsga2V5X2NvbW1hID0gc2F5X2NoYXIK
CiAgZG91YmxlIHNwayBrZXlfY29tbWEgPSBzYXlfcGhvbmV0aWNfY2hhcgoKICBzcGsga2V5
X2RvdCA9IHNheV9uZXh0X2NoYXIKCiAgc3BrIGtleV9uID0gc2F5X3Bvc2l0aW9uCgogIGN0
cmwgc3BrIGtleV9tID0gbGVmdF9lZGdlCgogIGN0cmwgc3BrIGtleV95ID0gdG9wX2VkZ2UK
CiAgY3RybCBzcGsga2V5X2RvdCA9IHJpZ2h0X2VkZ2UKCiAgY3RybCBzcGsga2V5X3AgPSBi
b3R0b21fZWRnZQoKICBzcGsga2V5X2Fwb3N0cm9waGUgPSBzYXlfc2NyZWVuCgogIHNwayBr
ZXlfaCA9IHNheV9mcm9tX2xlZnQKCiAgc3BrIGtleV95ID0gc2F5X2Zyb21fdG9wCgogIHNw
ayBrZXlfc2VtaWNvbG9uID0gc2F5X3RvX3JpZ2h0CgogIHNwayBrZXlfcCA9IHNheV90b19i
b3R0b20KCiAgc3BrIGtleV9zbGFzaCA9IHNheV9hdHRyaWJ1dGVzCgogIHNwayBrZXlfZW50
ZXIgPSBzcGVha3VwX3F1aWV0CgogIGN0cmwgIHNwayBrZXlfZW50ZXIgPSBzcGVha3VwX29m
ZgoKICBzcGsga2V5XzkgPSBzcGVha3VwX2N1dAoKICBzcGsga2V5XzggPSBzcGVha3VwX3Bh
c3RlCgogIHNoaWZ0IHNwayBrZXlfbSA9IHNheV9maXJzdF9jaGFyCgogIGN0cmwgc3BrIGtl
eV9zZW1pY29sb24gPSBzYXlfbGFzdF9jaGFyCgogIHNwayBrZXlfciA9IHJlYWRfYWxsX2Rv
YwoKCjUuICBUaGUgU3BlYWt1cCBTeXMgU3lzdGVtCj09PT09PT09PT09PT09PT09PT09PT09
PT09CgpUaGUgU3BlYWt1cCBzY3JlZW4gcmVhZGVyIGFsc28gY3JlYXRlcyBhIHNwZWFrdXAg
c3ViZGlyZWN0b3J5IGFzIGEgcGFydApvZiB0aGUgc3lzIHN5c3RlbS4KCkFzIGEgY29udmVu
aWVuY2UsIHJ1biBhcyByb290OjoKCiAgbG4gLXMgL3N5cy9hY2Nlc3NpYmlsaXR5L3NwZWFr
dXAgL3NwZWFrdXAKCnRvIGRpcmVjdGx5IGFjY2VzcyBzcGVha3VwIHBhcmFtZXRlcnMgZnJv
bSAvc3BlYWt1cC4KWW91IGNhbiBzZWUgdGhlc2UgZW50cmllcyBieSB0eXBpbmcgdGhlIGNv
bW1hbmQ6OgoKICBscyAtMSAvc3BlYWt1cC8qCgpJZiB5b3UgaXNzdWUgdGhlIGFib3ZlIGxz
IGNvbW1hbmQsIHlvdSB3aWxsIGdldCBiYWNrIHNvbWV0aGluZyBsaWtlCnRoaXM6OgoKICAv
c3BlYWt1cC9hdHRyaWJfYmxlZXAKICAvc3BlYWt1cC9iZWxsX3BvcwogIC9zcGVha3VwL2Js
ZWVwX3RpbWUKICAvc3BlYWt1cC9ibGVlcHMKICAvc3BlYWt1cC9jdXJzb3JfdGltZQogIC9z
cGVha3VwL2RlbGltaXRlcnMKICAvc3BlYWt1cC9leF9udW0KICAvc3BlYWt1cC9rZXlfZWNo
bwogIC9zcGVha3VwL2tleW1hcAogIC9zcGVha3VwL25vX2ludGVycnVwdAogIC9zcGVha3Vw
L3B1bmNfYWxsCiAgL3NwZWFrdXAvcHVuY19sZXZlbAogIC9zcGVha3VwL3B1bmNfbW9zdAog
IC9zcGVha3VwL3B1bmNfc29tZQogIC9zcGVha3VwL3JlYWRpbmdfcHVuYwogIC9zcGVha3Vw
L3JlcGVhdHMKICAvc3BlYWt1cC9zYXlfY29udHJvbAogIC9zcGVha3VwL3NheV93b3JkX2N0
bAogIC9zcGVha3VwL3NpbGVudAogIC9zcGVha3VwL3NwZWxsX2RlbGF5CiAgL3NwZWFrdXAv
c3ludGgKICAvc3BlYWt1cC9zeW50aF9kaXJlY3QKICAvc3BlYWt1cC92ZXJzaW9uCgogIC9z
cGVha3VwL2kxOG46CiAgYW5ub3VuY2VtZW50cwogIGNoYXJhY3RlcnMKICBjaGFydGFiCiAg
Y29sb3JzCiAgY3RsX2tleXMKICBmb3JtYXR0ZWQKICBmdW5jdGlvbl9uYW1lcwogIGtleV9u
YW1lcwogIHN0YXRlcwoKICAvc3BlYWt1cC9zb2Z0OgogIGNhcHNfc3RhcnQKICBjYXBzX3N0
b3AKICBkZWxheV90aW1lCiAgZGlyZWN0CiAgZnJlcQogIGZ1bGxfdGltZQogIGppZmZ5X2Rl
bHRhCiAgcGl0Y2gKICBpbmZsZWN0aW9uCiAgcHVuY3QKICByYXRlCiAgdG9uZQogIHRyaWdn
ZXJfdGltZQogIHZvaWNlCiAgdm9sCgpOb3RpY2UgdGhlIHR3byBzdWJkaXJlY3RvcmllcyBv
ZiBgYC9zcGVha3VwYGA6IGBgL3NwZWFrdXAvaTE4bmBgIGFuZApgYC9zcGVha3VwL3NvZnRg
YC4KVGhlIGBpMThuYCBzdWJkaXJlY3RvcnkgaXMgZGVzY3JpYmVkIGluIGEgbGF0ZXIgc2Vj
dGlvbi4KVGhlIGZpbGVzIHVuZGVyIGBgL3NwZWFrdXAvc29mdGBgIHJlcHJlc2VudCBzZXR0
aW5ncyB0aGF0IGFyZSBzcGVjaWZpYyB0byB0aGUKZHJpdmVyIGZvciB0aGUgc29mdHdhcmUg
c3ludGhlc2l6ZXIuICBJZiB5b3UgdXNlIHRoZSBMaXRlVGFsaywgeW91cgpzeW50aGVzaXpl
ci1zcGVjaWZpYyBzZXR0aW5ncyB3b3VsZCBiZSBmb3VuZCBpbiBgYC9zcGVha3VwL2x0bGtg
YC4gIEluIG90aGVyIHdvcmRzLAphIHN1YmRpcmVjdG9yeSBuYW1lZCBgYC9zcGVha3VwL0tX
RGBgIGlzIGNyZWF0ZWQgdG8gaG9sZCBwYXJhbWV0ZXJzIHNwZWNpZmljCnRvIHRoZSBkZXZp
Y2Ugd2hvc2Uga2V5d29yZCBpcyBLV0QuClRoZXNlIHBhcmFtZXRlcnMgaW5jbHVkZSB2b2x1
bWUsIHJhdGUsIHBpdGNoLCBhbmQgb3RoZXJzLgoKSW4gYWRkaXRpb24gdG8gdXNpbmcgdGhl
IFNwZWFrdXAgaG90IGtleXMgdG8gY2hhbmdlIHN1Y2ggdGhpbmdzIGFzCnZvbHVtZSwgcGl0
Y2gsIGFuZCByYXRlLCB5b3UgY2FuIGFsc28gZWNobyB2YWx1ZXMgdG8gdGhlIGFwcHJvcHJp
YXRlCmVudHJ5IGluIHRoZSBgYC9zcGVha3VwYGAgZGlyZWN0b3J5LiAgVGhpcyBpcyB2ZXJ5
IHVzZWZ1bCwgc2luY2UgaXQKbGV0cyB5b3UgY29udHJvbCBTcGVha3VwIHBhcmFtZXRlcnMg
ZnJvbSB3aXRoaW4gYSBzY3JpcHQuICBIb3cgeW91CndvdWxkIHdyaXRlIHN1Y2ggc2NyaXB0
cyBpcyBzb21ld2hhdCBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoaXMgbWFudWFsLApidXQgSSB3
aWxsIGluY2x1ZGUgYSBjb3VwbGUgb2Ygc2ltcGxlIGV4YW1wbGVzIGhlcmUgdG8gZ2l2ZSB5
b3UgYQpnZW5lcmFsIGlkZWEgb2Ygd2hhdCBzdWNoIHNjcmlwdHMgY2FuIGRvLgoKU3VwcG9z
ZSBmb3IgZXhhbXBsZSwgdGhhdCB5b3Ugd2FudGVkIHRvIGNvbnRyb2wgYm90aCB0aGUgcHVu
Y3R1YXRpb24KbGV2ZWwgYW5kIHRoZSByZWFkaW5nIHB1bmN0dWF0aW9uIGxldmVsIGF0IHRo
ZSBzYW1lIHRpbWUuICBGb3IKc2ltcGxpY2l0eSwgd2UnbGwgY2FsbCB0aGVtIHB1bmMwLCBw
dW5jMSwgcHVuYzIsIGFuZCBwdW5jMy4gIFRoZSBzY3JpcHRzCm1pZ2h0IGxvb2sgc29tZXRo
aW5nIGxpa2UgdGhpczoKCi4uIGNvZGUtYmxvY2s6OiBzaGVsbAoKICAjIS9iaW4vYmFzaAog
ICMgcHVuYzAKICAjIHNldCBwdW5jIGFuZCByZWFkaW5nIHB1bmMgbGV2ZWxzIHRvIDAKICBl
Y2hvIDAgPi9zcGVha3VwL3B1bmNfbGV2ZWwKICBlY2hvIDAgPi9zcGVha3VwL3JlYWRpbmdf
cHVuYwogIGVjaG8gUHVuY3R1YXRpb24gbGV2ZWwgc2V0IHRvIDAuCgogICMhL2Jpbi9iYXNo
CiAgIyBwdW5jMQogICMgc2V0IHB1bmMgYW5kIHJlYWRpbmcgcHVuYyBsZXZlbHMgdG8gMQog
IGVjaG8gMSA+L3NwZWFrdXAvcHVuY19sZXZlbAogIGVjaG8gMSA+L3NwZWFrdXAvcmVhZGlu
Z19wdW5jCiAgZWNobyBQdW5jdHVhdGlvbiBsZXZlbCBzZXQgdG8gMS4KCiAgIyEvYmluL2Jh
c2gKICAjIHB1bmMyCiAgIyBzZXQgcHVuYyBhbmQgcmVhZGluZyBwdW5jIGxldmVscyB0byAy
CiAgZWNobyAyID4vc3BlYWt1cC9wdW5jX2xldmVsCiAgZWNobyAyID4vc3BlYWt1cC9yZWFk
aW5nX3B1bmMKICBlY2hvIFB1bmN0dWF0aW9uIGxldmVsIHNldCB0byAyLgoKICAjIS9iaW4v
YmFzaAogICMgcHVuYzMKICAjIHNldCBwdW5jIGFuZCByZWFkaW5nIHB1bmMgbGV2ZWxzIHRv
IDMKICBlY2hvIDMgPi9zcGVha3VwL3B1bmNfbGV2ZWwKICBlY2hvIDMgPi9zcGVha3VwL3Jl
YWRpbmdfcHVuYwogIGVjaG8gUHVuY3R1YXRpb24gbGV2ZWwgc2V0IHRvIDMuCgpJZiB5b3Ug
d2VyZSB0byBzdG9yZSB0aGVzZSBmb3VyIHNtYWxsIHNjcmlwdHMgaW4gYSBkaXJlY3Rvcnkg
aW4geW91cgpwYXRoLCBwZXJoYXBzIGBgL3Vzci9sb2NhbC9iaW5gYCwgYW5kIHNldCB0aGUg
cGVybWlzc2lvbnMgdG8gNzU1IHdpdGggdGhlCmBgY2htb2RgYCBjb21tYW5kLCB0aGVuIHlv
dSBjb3VsZCBjaGFuZ2UgdGhlIGRlZmF1bHQgcmVhZGluZyBwdW5jIGFuZApwdW5jdHVhdGlv
biBsZXZlbHMgYXQgdGhlIHNhbWUgdGltZSBieSBpc3N1aW5nIGp1c3Qgb25lIGNvbW1hbmQu
ICBGb3IKZXhhbXBsZSwgaWYgeW91IHdlcmUgdG8gZXhlY3V0ZSB0aGUgcHVuYzMgY29tbWFu
ZCBhdCB5b3VyIHNoZWxsIHByb21wdCwKdGhlbiB0aGUgcmVhZGluZyBwdW5jIGFuZCBwdW5j
IGxldmVsIHdvdWxkIGJvdGggZ2V0IHNldCB0byAzLgoKLi4gbm90ZTo6CgogIFRoZSBhYm92
ZSBzY3JpcHRzIHdlcmUgd3JpdHRlbiB0byB3b3JrIHdpdGggYmFzaCwgYnV0CiAgcmVnYXJk
bGVzcyBvZiB3aGljaCBzaGVsbCB5b3UgdXNlLCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gZG8g
c29tZXRoaW5nCiAgc2ltaWxhci4KClRoZSBTcGVha3VwIHN5cyBzeXN0ZW0gYWxzbyBoYXMg
YW5vdGhlciBpbnRlcmVzdGluZyB1c2UuICBZb3UgY2FuIGVjaG8KU3BlYWt1cCBwYXJhbWV0
ZXJzIGludG8gdGhlIHN5cyBzeXN0ZW0gaW4gYSBzY3JpcHQgZHVyaW5nIHN5c3RlbQpzdGFy
dHVwLCBhbmQgc3BlYWt1cCB3aWxsIHJldHVybiB0byB5b3VyIHByZWZlcnJlZCBwYXJhbWV0
ZXJzIGV2ZXJ5IHRpbWUKdGhlIHN5c3RlbSBpcyByZWJvb3RlZC4KCk1vc3Qgb2YgdGhlIFNw
ZWFrdXAgc3lzIHBhcmFtZXRlcnMgY2FuIGJlIG1hbmlwdWxhdGVkIGJ5IGEgcmVndWxhciB1
c2VyCm9uIHRoZSBzeXN0ZW0uICBIb3dldmVyLCB0aGVyZSBhcmUgYSBmZXcgcGFyYW1ldGVy
cyB0aGF0IGFyZSBkYW5nZXJvdXMKZW5vdWdoIHRoYXQgdGhleSBzaG91bGQgb25seSBiZSBt
YW5pcHVsYXRlZCBieSB0aGUgcm9vdCB1c2VyIG9uIHlvdXIKc3lzdGVtLiAgVGhlcmUgYXJl
IGV2ZW4gc29tZSBwYXJhbWV0ZXJzIHRoYXQgYXJlIHJlYWQgb25seSwgYW5kIGNhbm5vdApi
ZSB3cml0dGVuIHRvIGF0IGFsbC4gIEZvciBleGFtcGxlLCB0aGUgdmVyc2lvbiBlbnRyeSBp
biB0aGUgU3BlYWt1cApzeXMgc3lzdGVtIGlzIHJlYWQgb25seS4gIFRoaXMgaXMgYmVjYXVz
ZSB0aGVyZSBpcyBubyByZWFzb24gZm9yIGEgdXNlcgp0byB0YW1wZXIgd2l0aCB0aGUgdmVy
c2lvbiBudW1iZXIgd2hpY2ggaXMgcmVwb3J0ZWQgYnkgU3BlYWt1cC4gIERvaW5nCmFuIGBg
bHMgLWxgYCBvbiBgYC9zcGVha3VwL3ZlcnNpb25gYCB3aWxsIHJldHVybiB0aGlzOjoKCiAg
LXItLXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAwIE1hciAyMSAxMzo0
NiAvc3BlYWt1cC92ZXJzaW9uCgpBcyB5b3UgY2FuIHNlZSwgdGhlIHZlcnNpb24gZW50cnkg
aW4gdGhlIFNwZWFrdXAgc3lzIHN5c3RlbSBpcyByZWFkCm9ubHksIGlzIG93bmVkIGJ5IHJv
b3QsIGFuZCBiZWxvbmdzIHRvIHRoZSByb290IGdyb3VwLiAgRG9pbmcgYSBjYXQgb2YKYGAv
c3BlYWt1cC92ZXJzaW9uYGAgd2lsbCBkaXNwbGF5IHRoZSBTcGVha3VwIHZlcnNpb24gbnVt
YmVyLCBsaWtlCnRoaXM6OgoKICBjYXQgL3NwZWFrdXAvdmVyc2lvbgogIFNwZWFrdXAgdi0y
LjAwIENWUzogVGh1IE9jdCAyMSAxMDozODoyMSBFRFQgMjAwNAogIHN5bnRoIGR0bGsgdmVy
c2lvbiAxLjEKClRoZSBkaXNwbGF5IHNob3dzIHRoZSBTcGVha3VwIHZlcnNpb24gbnVtYmVy
LCBhbG9uZyB3aXRoIHRoZSB2ZXJzaW9uCm51bWJlciBvZiB0aGUgZHJpdmVyIGZvciB0aGUg
Y3VycmVudCBzeW50aGVzaXplci4KCkxvb2tpbmcgYXQgZW50cmllcyBpbiB0aGUgU3BlYWt1
cCBzeXMgc3lzdGVtIGNhbiBiZSB1c2VmdWwgaW4gbWFueQp3YXlzLiAgRm9yIGV4YW1wbGUs
IHlvdSBtaWdodCB3aXNoIHRvIGtub3cgd2hhdCBsZXZlbCB5b3VyIHZvbHVtZSBpcyBzZXQK
YXQuICBZb3UgY291bGQgdHlwZTo6CgogIGNhdCAvc3BlYWt1cC9LV0Qvdm9sCiAgIyBSZXBs
YWNlIEtXRCB3aXRoIHRoZSBrZXl3b3JkIGZvciB5b3VyIHN5bnRoZXNpemVyLCBFLkcuLCBs
dGxrIGZvciBMaXRlVGFsay4KICA1CgpUaGUgbnVtYmVyIGZpdmUgd2hpY2ggY29tZXMgYmFj
ayBpcyB0aGUgbGV2ZWwgYXQgd2hpY2ggdGhlIHN5bnRoZXNpemVyCnZvbHVtZSBpcyBzZXQg
YXQuCgpBbGwgdGhlIGVudHJpZXMgaW4gdGhlIFNwZWFrdXAgc3lzIHN5c3RlbSBhcmUgcmVh
ZGFibGUsIHNvbWUgYXJlCndyaXRhYmxlIGJ5IHJvb3Qgb25seSwgYW5kIHNvbWUgYXJlIHdy
aXRhYmxlIGJ5IGV2ZXJ5b25lLiAgVW5sZXNzIHlvdQprbm93IHdoYXQgeW91IGFyZSBkb2lu
ZywgeW91IHNob3VsZCBwcm9iYWJseSBsZWF2ZSB0aGUgb25lcyB0aGF0IGFyZQp3cml0YWJs
ZSBieSByb290IG9ubHkgYWxvbmUuICBNb3N0IG9mIHRoZSBuYW1lcyBhcmUgc2VsZiBleHBs
YW5hdG9yeS4KVm9sIGZvciBjb250cm9sbGluZyB2b2x1bWUsIHBpdGNoIGZvciBwaXRjaCwg
aW5mbGVjdGlvbiBmb3IgcGl0Y2ggcmFuZ2UsIHJhdGUKZm9yIGNvbnRyb2xsaW5nIHNwZWFr
aW5nIHJhdGUsIGV0Yy4gIElmIHlvdSBmaW5kIG9uZSB5b3UgYXJlbid0IHN1cmUgYWJvdXQs
IHlvdQpjYW4gcG9zdCBhIHF1ZXJ5IG9uIHRoZSBTcGVha3VwIGxpc3QuCgoKNi4gIENoYW5n
aW5nIFN5bnRoZXNpemVycwo9PT09PT09PT09PT09PT09PT09PT09PT09CgpJdCBpcyBwb3Nz
aWJsZSB0byBjaGFuZ2UgdG8gYSBkaWZmZXJlbnQgc3ludGhlc2l6ZXIgd2hpbGUgc3BlYWt1
cCBpcwpydW5uaW5nLiAgSW4gb3RoZXIgd29yZHMsIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8g
cmVib290IHRoZSBzeXN0ZW0KaW4gb3JkZXIgdG8gdXNlIGEgZGlmZmVyZW50IHN5bnRoZXNp
emVyLiAgWW91IGNhbiBzaW1wbHkgZWNobyB0aGUKc3ludGhlc2l6ZXIga2V5d29yZCB0byB0
aGUgYGAvc3BlYWt1cC9zeW50aGBgIHN5cyBlbnRyeS4KRGVwZW5kaW5nIG9uIHlvdXIgc2l0
dWF0aW9uLCB5b3UgbWF5IHdpc2ggdG8gZWNobyBub25lIHRvIHRoZSBzeW50aApzeXMgZW50
cnksIHRvIGRpc2FibGUgc3BlZWNoIHdoaWxlIG9uZSBzeW50aGVzaXplciBpcyBkaXNjb25u
ZWN0ZWQgYW5kCmEgc2Vjb25kIG9uZSBpcyBjb25uZWN0ZWQgaW4gaXRzIHBsYWNlLiAgVGhl
biBlY2hvIHRoZSBrZXl3b3JkIGZvciB0aGUKbmV3IHN5bnRoZXNpemVyIGludG8gdGhlIHN5
bnRoIHN5cyBlbnRyeSBpbiBvcmRlciB0byBzdGFydCBzcGVlY2gKd2l0aCB0aGUgbmV3bHkg
Y29ubmVjdGVkIHN5bnRoZXNpemVyLiAgU2VlIHRoZSBsaXN0IG9mIHN5bnRoZXNpemVyCmtl
eXdvcmRzIGluIHNlY3Rpb24gMSB0byBmaW5kIHRoZSBrZXl3b3JkIHdoaWNoIG1hdGNoZXMg
eW91ciBzeW50aC4KCgo3LiAgTG9hZGluZyBtb2R1bGVzCj09PT09PT09PT09PT09PT09PT0K
CkFzIG1lbnRpb25lZCBlYXJsaWVyLCBTcGVha3VwIGNhbiBlaXRoZXIgYmUgY29tcGxldGVs
eSBjb21waWxlZCBpbnRvIHRoZQprZXJuZWwsIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiB0aGUg
aGVscCBtb2R1bGUsIG9yIGl0IGNhbiBiZSBjb21waWxlZCBhcwphIHNlcmllcyBvZiBtb2R1
bGVzLiAgIFdoZW4gY29tcGlsZWQgYXMgbW9kdWxlcywgU3BlYWt1cCB3aWxsIG9ubHkgYmUK
YWJsZSB0byBzcGVhayBzb21lIG9mIHRoZSBib290dXAgbWVzc2FnZXMgaWYgeW91ciBzeXN0
ZW0gYWRtaW5pc3RyYXRvcgpoYXMgY29uZmlndXJlZCB0aGUgc3lzdGVtIHRvIGxvYWQgdGhl
IG1vZHVsZXMgYXQgYm9vIHRpbWUuIFRoZSBtb2R1bGVzCmNhbiAgYmUgbG9hZGVkIGFmdGVy
IHRoZSBmaWxlIHN5c3RlbXMgaGF2ZSBiZWVuIGNoZWNrZWQgYW5kIG1vdW50ZWQsIG9yCmZy
b20gYW4gaW5pdHJkLiAgVGhlcmUgaXMgYSB0aGlyZCBwb3NzaWJpbGl0eS4gIFNwZWFrdXAg
Y2FuIGJlIGNvbXBpbGVkCndpdGggc29tZSBjb21wb25lbnRzIGJ1aWx0IGludG8gdGhlIGtl
cm5lbCwgYW5kIG90aGVycyBhcyBtb2R1bGVzLiAgQXMKd2UnbGwgc2VlIGluIHRoZSBuZXh0
IHNlY3Rpb24sIHRoaXMgaXMgcGFydGljdWxhcmx5IHVzZWZ1bCB3aGVuIHlvdSBhcmUKd29y
a2luZyB3aXRoIHNvZnR3YXJlIHN5bnRoZXNpemVycy4KCklmIFNwZWFrdXAgaXMgY29tcGxl
dGVseSBjb21waWxlZCBhcyBtb2R1bGVzLCB0aGVuIHlvdSBtdXN0IHVzZSB0aGUKbW9kcHJv
YmUgY29tbWFuZCB0byBsb2FkIFNwZWFrdXAuICBZb3UgZG8gdGhpcyBieSBsb2FkaW5nIHRo
ZSBtb2R1bGUgZm9yCnRoZSBzeW50aGVzaXplciBkcml2ZXIgeW91IHdpc2ggdG8gdXNlLiAg
VGhlIGRyaXZlciBtb2R1bGVzIGFyZSBhbGwKbmFtZWQgc3BlYWt1cF88a2V5d29yZD4sIHdo
ZXJlIDxrZXl3b3JkPiBpcyB0aGUga2V5d29yZCBmb3IgdGhlCnN5bnRoZXNpemVyIHlvdSB3
YW50LiAgU28sIGluIG9yZGVyIHRvIGxvYWQgdGhlIGRyaXZlciBmb3IgdGhlIERlY1RhbGsK
RXhwcmVzcywgeW91IHdvdWxkIHR5cGUgdGhlIGZvbGxvd2luZyBjb21tYW5kOjoKCiAgbW9k
cHJvYmUgc3BlYWt1cF9kZWN0bGsKCklzc3VpbmcgdGhpcyBjb21tYW5kIHdvdWxkIGxvYWQg
dGhlIERlY1RhbGsgRXhwcmVzcyBkcml2ZXIgYW5kIGFsbCBvdGhlcgpyZWxhdGVkIFNwZWFr
dXAgbW9kdWxlcyBuZWNlc3NhcnkgdG8gZ2V0IFNwZWFrdXAgdXAgYW5kIHJ1bm5pbmcuCgpU
byBjb21wbGV0ZWx5IHVubG9hZCBTcGVha3VwLCBhZ2FpbiBwcmVzdW1pbmcgdGhhdCBpdCBp
cyBlbnRpcmVseSBidWlsdAphcyBtb2R1bGVzLCB5b3Ugd291bGQgZ2l2ZSB0aGUgY29tbWFu
ZDo6CgogIG1vZHByb2JlIC1yIHNwZWFrdXBfZGVjdGxrCgpUaGUgYWJvdmUgY29tbWFuZCBh
c3N1bWVzIHlvdSB3ZXJlIHJ1bm5pbmcgYSBEZWNUYWxrIEV4cHJlc3MuICBJZiB5b3UKd2Vy
ZSB1c2luZyBhIGRpZmZlcmVudCBzeW50aCwgdGhlbiB5b3Ugd291bGQgc3Vic3RpdHV0ZSBp
dHMga2V5d29yZCBpbgpwbGFjZSBvZiBgZGVjdGxrYC4KCklmIHlvdSBoYXZlIG11bHRpcGxl
IGRyaXZlcnMgbG9hZGVkLCB5b3UgbmVlZCB0byB1bmxvYWQgYWxsIG9mIHRoZW0sIGluCm9y
ZGVyIHRvIGNvbXBsZXRlbHkgdW5sb2FkIFNwZWFrdXAuCkZvciBleGFtcGxlLCBpZiB5b3Ug
aGF2ZSBsb2FkZWQgYm90aCB0aGUgZGVjdGxrIGFuZCBsdGxrIGRyaXZlcnMsIHVzZSB0aGUK
Y29tbWFuZDo6CgogIG1vZHByb2JlIC1yIHNwZWFrdXBfZGVjdGxrIHNwZWFrdXBfbHRsawoK
WW91IGNhbm5vdCB1bmxvYWQgdGhlIGRyaXZlciBmb3Igc29mdHdhcmUgc3ludGhlc2l6ZXJz
IHdoZW4gYSB1c2VyLXNwYWNlCmRhZW1vbiBpcyB1c2luZyBgYC9kZXYvc29mdHN5bnRoYGAu
ICBGaXJzdCwga2lsbCB0aGUgZGFlbW9uLiAgTmV4dCwgcmVtb3ZlCnRoZSBkcml2ZXIgd2l0
aCB0aGUgY29tbWFuZDo6CgogIG1vZHByb2JlIC1yIHNwZWFrdXBfc29mdAoKTm93LCBzdXBw
b3NlIHdlIGhhdmUgYSBzaXR1YXRpb24gd2hlcmUgdGhlIG1haW4gU3BlYWt1cCBjb21wb25l
bnQKaXMgYnVpbHQgaW50byB0aGUga2VybmVsLCBhbmQgc29tZSBvciBhbGwgb2YgdGhlIGRy
aXZlcnMgYXJlIGJ1aWx0IGFzCm1vZHVsZXMuICBTaW5jZSB0aGUgbWFpbiBwYXJ0IG9mIFNw
ZWFrdXAgaXMgY29tcGlsZWQgaW50byB0aGUga2VybmVsLCBhCnBhcnRpYWwgU3BlYWt1cCBz
eXMgc3lzdGVtIGhhcyBiZWVuIGNyZWF0ZWQgd2hpY2ggd2UgY2FuIHRha2UgYWR2YW50YWdl
Cm9mIGJ5IHNpbXBseSBlY2hvaW5nIHRoZSBzeW50aGVzaXplciBrZXl3b3JkIGludG8gdGhl
CmBgL3NwZWFrdXAvc3ludGhgYCBzeXMgZW50cnkuICBUaGlzIHdpbGwgY2F1c2UgdGhlIGtl
cm5lbCB0bwphdXRvbWF0aWNhbGx5IGxvYWQgdGhlIGFwcHJvcHJpYXRlIGRyaXZlciBtb2R1
bGUsIGFuZCBzdGFydCBTcGVha3VwCnRhbGtpbmcuICBUbyBzd2l0Y2ggdG8gYW5vdGhlciBz
eW50aCwganVzdCBlY2hvIGEgbmV3IGtleXdvcmQgdG8gdGhlCnN5bnRoIHN5cyBlbnRyeS4g
IEZvciBleGFtcGxlLCB0byBsb2FkIHRoZSBEb3VibGVUYWxrIExUIGRyaXZlciwKeW91IHdv
dWxkIHR5cGU6OgoKICBlY2hvIGx0bGsgPi9zcGVha3VwL3N5bnRoCgpZb3UgY2FuIHVzZSB0
aGUgYGBtb2Rwcm9iZSAtcmBgIGNvbW1hbmQgdG8gdW5sb2FkIGRyaXZlciBtb2R1bGVzLCBy
ZWdhcmRsZXNzCm9mIHdoZXRoZXIgdGhlIG1haW4gcGFydCBvZiBTcGVha3VwIGhhcyBiZWVu
IGJ1aWx0IGludG8gdGhlIGtlcm5lbCBvcgpub3QuCgoKOC4gIFVzaW5nIFNvZnR3YXJlIFN5
bnRoZXNpemVycwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpVc2luZyBhIHNv
ZnR3YXJlIHN5bnRoZXNpemVyIHJlcXVpcmVzIHRoYXQgc29tZSBvdGhlciBzb2Z0d2FyZSBi
ZQppbnN0YWxsZWQgYW5kIHJ1bm5pbmcgb24geW91ciBzeXN0ZW0uICBGb3IgdGhpcyByZWFz
b24sIHNvZnR3YXJlCnN5bnRoZXNpemVycyBhcmUgbm90IGF2YWlsYWJsZSBmb3IgdXNlIGF0
IGJvb3R1cCwgb3IgZHVyaW5nIGEgc3lzdGVtCmluc3RhbGxhdGlvbiBwcm9jZXNzLgpUaGVy
ZSBhcmUgdHdvIGZyZWVseS1hdmFpbGFibGUgc29sdXRpb25zIGZvciBzb2Z0d2FyZSBzcGVl
Y2g6IEVzcGVha3VwIGFuZApTcGVlY2ggRGlzcGF0Y2hlci4KVGhlc2UgYXJlIGRlc2NyaWJl
ZCBpbiBzdWJzZWN0aW9ucyBgOC4xLiBFc3BlYWt1cGBfIGFuZApgOC4yLiBTcGVlY2ggRGlz
cGF0Y2hlcmBfLCByZXNwZWN0aXZlbHkuCgpEdXJpbmcgdGhlIHJlc3Qgb2YgdGhpcyBzZWN0
aW9uLCB3ZSBhc3N1bWUgdGhhdCBgc3BlYWt1cF9zb2Z0YCBpcyBlaXRoZXIKYnVpbHQgaW4g
dG8geW91ciBrZXJuZWwsIG9yIGxvYWRlZCBhcyBhIG1vZHVsZS4KCklmIHlvdXIgc3lzdGVt
IGRvZXMgbm90IGhhdmUgdWRldiBpbnN0YWxsZWQgLCBiZWZvcmUgeW91IGNhbiB1c2UgYQpz
b2Z0d2FyZSBzeW50aGVzaXplciwgeW91IG11c3QgaGF2ZSBjcmVhdGVkIHRoZSBgYC9kZXYv
c29mdHN5bnRoYGAgZGV2aWNlLgpJZiB5b3UgaGF2ZSBub3QgYWxyZWFkeSBkb25lIHNvLCBp
c3N1ZSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIGFzIHJvb3Q6OgoKICBjZCAvZGV2CiAgbWtu
b2Qgc29mdHN5bnRoIGMgMTAgMjYKCldoaWxlIHdlIGFyZSBhdCBpdCwgd2UgbWlnaHQganVz
dCBhcyB3ZWxsIGNyZWF0ZSB0aGUgYGAvZGV2L3N5bnRoYGAgZGV2aWNlLAp3aGljaCBjYW4g
YmUgdXNlZCB0byBsZXQgdXNlciBzcGFjZSBwcm9ncmFtcyBzZW5kIGluZm9ybWF0aW9uIHRv
IHlvdXIKc3ludGhlc2l6ZXIuICBUbyBjcmVhdGUgYGAvZGV2L3N5bnRoYGAsIGNoYW5nZSB0
byB0aGUgYGAvZGV2YGAgZGlyZWN0b3J5LCBhbmQKaXNzdWUgdGhlIGZvbGxvd2luZyBjb21t
YW5kIGFzIHJvb3Q6OgoKICBta25vZCBzeW50aCBjIDEwIDI1CgpvZiBib3RoLgoKOC4xLiBF
c3BlYWt1cAotLS0tLS0tLS0tLS0tCgpFc3BlYWt1cCBpcyBhIGNvbm5lY3RvciBiZXR3ZWVu
IFNwZWFrdXAgYW5kIHRoZSBlU3BlYWsgc29mdHdhcmUgc3ludGhlc2l6ZXIuCkVzcGVha3Vw
IG1heSBhbHJlYWR5IGJlIGF2YWlsYWJsZSBhcyBhIHBhY2thZ2UgZm9yIHlvdXIgZGlzdHJp
YnV0aW9uCm9mIExpbnV4LiAgSWYgaXQgaXMgbm90IHBhY2thZ2VkLCB5b3UgbmVlZCB0byBp
bnN0YWxsIGl0IG1hbnVhbGx5LgpZb3UgY2FuIGZpbmQgaXQgaW4gdGhlIGBgY29udHJpYi9g
YCBzdWJkaXJlY3Rvcnkgb2YgdGhlIFNwZWFrdXAgc291cmNlcy4KVGhlIGZpbGVuYW1lIGlz
IGBgZXNwZWFrdXAtJFZFUlNJT04udGFyLmJ6MmBgLCB3aGVyZSBgYCRWRVJTSU9OYGAKZGVw
ZW5kcyBvbiB0aGUgY3VycmVudCByZWxlYXNlIG9mIEVzcGVha3VwLiAgVGhlIFNwZWFrdXAg
My4xLjIgc291cmNlCnNoaXBzIHdpdGggdmVyc2lvbiAwLjcxIG9mIEVzcGVha3VwLgpUaGUg
UkVBRE1FIGZpbGUgaW5jbHVkZWQgd2l0aCB0aGUgRXNwZWFrdXAgc291cmNlcyBkZXNjcmli
ZXMgdGhlIHByb2Nlc3MKb2YgbWFudWFsIGluc3RhbGxhdGlvbi4KCkFzc3VtaW5nIHRoYXQg
RXNwZWFrdXAgaXMgaW5zdGFsbGVkLCBlaXRoZXIgYnkgdGhlIHVzZXIgb3IgYnkgdGhlIGRp
c3RyaWJ1dG9yLApmb2xsb3cgdGhlc2Ugc3RlcHMgdG8gdXNlIGl0LgoKVGVsbCBTcGVha3Vw
IHRvIHVzZSB0aGUgInNvZnQgZHJpdmVyOjoKCiAgZWNobyBzb2Z0ID4gL3NwZWFrdXAvc3lu
dGgKCkZpbmFsbHksIHN0YXJ0IHRoZSBlc3BlYWt1cCBwcm9ncmFtLiAgVGhlcmUgYXJlIHR3
byB3YXlzIHRvIGRvIGl0LgpCb3RoIHJlcXVpcmUgcm9vdCBwcml2aWxlZ2VzLgoKSWYgRXNw
ZWFrdXAgd2FzIGluc3RhbGxlZCBhcyBhIHBhY2thZ2UgZm9yIHlvdXIgTGludXggZGlzdHJp
YnV0aW9uLAp5b3UgcHJvYmFibHkgaGF2ZSBhIGRpc3RyaWJ1dGlvbi1zcGVjaWZpYyBzY3Jp
cHQgdGhhdCBjb250cm9scyB0aGUgb3BlcmF0aW9uCm9mIHRoZSBkYWVtb24uICBMb29rIGZv
ciBhIGZpbGUgbmFtZWQgZXNwZWFrdXAgdW5kZXIgYGAvZXRjL2luaXQuZGBgIG9yCmBgL2V0
Yy9yYy5kYGAuICBFeGVjdXRlIHRoZSBmb2xsb3dpbmcgY29tbWFuZCB3aXRoIHJvb3QgcHJp
dmlsZWdlczo6CgogIC9ldGMvaW5pdC5kL2VzcGVha3VwIHN0YXJ0CgpSZXBsYWNlIGBgaW5p
dC5kYGAgd2l0aCBgYHJjLmRgYCwgaWYgeW91ciBkaXN0cmlidXRpb24gdXNlcyBzY3JpcHRz
IGxvY2F0ZWQKdW5kZXIgYGAvZXRjL3JjLmRgYC4KWW91ciBkaXN0cmlidXRpb24gd2lsbCBh
bHNvIGhhdmUgYSBwcm9jZWR1cmUgZm9yIHN0YXJ0aW5nIGRhZW1vbnMgYXQKYm9vdC10aW1l
LCBzbyBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIHNvZnR3YXJlIHNwZWVjaCBhcyBzb29uIGFz
IHVzZXItc3BhY2UKZGFlbW9ucyBhcmUgc3RhcnRlZCBieSB0aGUgYm9vdHVwIHNjcmlwdHMu
ClRoZXNlIHByb2NlZHVyZXMgYXJlIG5vdCBkZXNjcmliZWQgaW4gdGhpcyBkb2N1bWVudC4K
CklmIHlvdSBidWlsdCBFc3BlYWt1cCBtYW51YWxseSwgdGhlIGBgbWFrZSBpbnN0YWxsYGAg
c3RlcCBwbGFjZWQgdGhlIGJpbmFyeQp1bmRlciBgYC91c3IvYmluYGAuClJ1biB0aGUgZm9s
bG93aW5nIGNvbW1hbmQgYXMgcm9vdDo6CgogIC91c3IvYmluL2VzcGVha3VwCgpFc3BlYWt1
cCBzaG91bGQgc3RhcnQgc3BlYWtpbmcuCgo4LjIuIFNwZWVjaCBEaXNwYXRjaGVyCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KCkZvciB0aGlzIG9wdGlvbiwgeW91IG11c3QgaGF2ZSBhIHBh
Y2thZ2UgY2FsbGVkClNwZWVjaCBEaXNwYXRjaGVyIHJ1bm5pbmcgb24geW91ciBzeXN0ZW0s
IGFuZCBpdCBtdXN0IGJlIGNvbmZpZ3VyZWQgdG8Kd29yayB3aXRoIG9uZSBvZiBpdHMgc3Vw
cG9ydGVkIHNvZnR3YXJlIHN5bnRoZXNpemVycy4KClR3byBvcGVuIHNvdXJjZSBzeW50aGVz
aXplcnMgeW91IG1pZ2h0IHVzZSBhcmUgRmxpdGUgYW5kIEZlc3RpdmFsLiAgWW91Cm1pZ2h0
IGFsc28gY2hvb3NlIHRvIHB1cmNoYXNlIHRoZSBTb2Z0d2FyZSBEZWNUYWxrIGZyb20gRm9u
aXggU2FsZXMgSW5jLgpJZiB5b3UgcnVuIGEgZ29vZ2xlIHNlYXJjaCBmb3IgRm9uaXgsIHlv
dSdsbCBmaW5kIHRoZWlyIHdlYiBzaXRlLgoKWW91IGNhbiBvYnRhaW4gYSBjb3B5IG9mIFNw
ZWVjaCBEaXNwYXRjaGVyIGZyb20gZnJlZShiKXNvZnQgYXQKaHR0cDovL3d3dy5mcmVlYnNv
ZnQub3JnLy4gIEZvbGxvdyB0aGUgaW5zdGFsbGF0aW9uIGluc3RydWN0aW9ucyB0aGF0CmNv
bWUgd2l0aCBTcGVlY2ggRGlzcGF0Y2hlciBpbiBvcmRlciB0byBpbnN0YWxsIGFuZCBjb25m
aWd1cmUgU3BlZWNoCkRpc3BhdGNoZXIuICBZb3UgY2FuIGNoZWNrIG91dCB0aGUgd2ViIHNp
dGUgZm9yIHlvdXIgTGludXggZGlzdHJpYnV0aW9uCmluIG9yZGVyIHRvIGdldCBhIGNvcHkg
b2YgZWl0aGVyIEZsaXRlIG9yIEZlc3RpdmFsLiAgWW91ciBMaW51eApkaXN0cmlidXRpb24g
bWF5IGFsc28gaGF2ZSBhIHByZWNvbXBpbGVkIFNwZWVjaCBEaXNwYXRjaGVyIHBhY2thZ2Uu
CgpPbmNlIHlvdSd2ZSBpbnN0YWxsZWQsIGNvbmZpZ3VyZWQsIGFuZCB0ZXN0ZWQgU3BlZWNo
IERpc3BhdGNoZXIgd2l0aCB5b3VyCmNob3NlbiBzb2Z0d2FyZSBzeW50aGVzaXplciwgeW91
IHN0aWxsIG5lZWQgb25lIG1vcmUgcGllY2Ugb2Ygc29mdHdhcmUKaW4gb3JkZXIgdG8gbWFr
ZSB0aGluZ3Mgd29yay4gIFlvdSBuZWVkIGEgcGFja2FnZSBjYWxsZWQgc3BlZWNoZC11cC4K
WW91IGdldCBpdCBmcm9tIHRoZSBmcmVlKGIpc29mdCB3ZWIgc2l0ZSBtZW50aW9uZWQgYWJv
dmUuICBBZnRlciB5b3UndmUKY29tcGlsZWQgYW5kIGluc3RhbGxlZCBzcGVlY2hkLXVwLCB5
b3UgYXJlIGFsbW9zdCByZWFkeSB0byBiZWdpbiB1c2luZwp5b3VyIHNvZnR3YXJlIHN5bnRo
ZXNpemVyLgoKTm93IHlvdSBjYW4gYmVnaW4gdXNpbmcgeW91ciBzb2Z0d2FyZSBzeW50aGVz
aXplci4gIEluIG9yZGVyIHRvIGRvIHNvLAplY2hvIHRoZSBzb2Z0IGtleXdvcmQgdG8gdGhl
IHN5bnRoIHN5cyBlbnRyeSBsaWtlIHRoaXM6OgoKICBlY2hvIHNvZnQgPi9zcGVha3VwL3N5
bnRoCgpOZXh0IHJ1biB0aGUgc3BlZWNoZF91cCBjb21tYW5kIGxpa2UgdGhpczo6CgogIHNw
ZWVjaGRfdXAgJgoKWW91ciBzeW50aCBzaG91bGQgbm93IHN0YXJ0IHRhbGtpbmcsIGFuZCB5
b3Ugc2hvdWxkIGJlIGFibGUgdG8gYWRqdXN0CnRoZSBwaXRjaCwgcmF0ZSwgZXRjLgoKCjku
ICBVc2luZyBUaGUgRGVjVGFsayBQQyBDYXJkCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09CgpUaGUgRGVjVGFsayBQQyBjYXJkIGlzIGFuIElTQSBjYXJkIHRoYXQgaXMgaW5zZXJ0
ZWQgaW50byBvbmUgb2YgdGhlIElTQQpzbG90cyBpbiB5b3VyIGNvbXB1dGVyLiAgSXQgcmVx
dWlyZXMgdGhhdCB0aGUgRGVjVGFsayBQQyBzb2Z0d2FyZSBiZQppbnN0YWxsZWQgb24geW91
ciBjb21wdXRlciwgYW5kIHRoYXQgdGhlIHNvZnR3YXJlIGJlIGxvYWRlZCBvbnRvIHRoZQpE
ZWN0YWxrIFBDIGNhcmQgYmVmb3JlIGl0IGNhbiBiZSB1c2VkLgoKWW91IGNhbiBnZXQgdGhl
IGBgZGVjX3BjLnRnemBgIGZpbGUgZnJvbSB0aGUgbGludXgtc3BlYWt1cC5vcmcgc2l0ZS4g
IFRoZQpgYGRlY19wYy50Z3pgYCBmaWxlIGlzIGluIHRoZSBgYH5mdHAvcHViL2xpbnV4L3Nw
ZWFrdXBgYCBkaXJlY3RvcnkuCgpBZnRlciB5b3UgaGF2ZSBkb3dubG9hZGVkIHRoZSBgYGRl
Y19wYy50Z3pgYCBmaWxlLCB1bnRhciBpdCBpbiB5b3VyIGhvbWUKZGlyZWN0b3J5LCBhbmQg
cmVhZCB0aGUgUmVhZG1lIGZpbGUgaW4gdGhlIG5ld2x5IGNyZWF0ZWQgYGBkZWNfcGNgYApk
aXJlY3RvcnkuCgpUaGUgZWFzaWVzdCB3YXkgdG8gZ2V0IHRoZSBzb2Z0d2FyZSB3b3JraW5n
IGlzIHRvIGNvcHkgdGhlIGVudGlyZSBgYGRlY19wY2BgCmRpcmVjdG9yeSBpbnRvIGBgL3Vz
ZXIvbG9jYWwvbGliYGAuICBUbyBkbyB0aGlzLCBzdSB0byByb290IGluIHlvdXIgaG9tZQpk
aXJlY3RvcnksIGFuZCBpc3N1ZSB0aGUgY29tbWFuZDo6CgogIGNwIGRlY19wYyAvdXNyL2xv
Y2FsL2xpYgoKWW91IHdpbGwgbmVlZCB0byBjb3B5IHRoZSBkdGxvYWQgY29tbWFuZCBmcm9t
IHRoZSBkZWNfcGMgZGlyZWN0b3J5IHRvIGEKZGlyZWN0b3J5IGluIHlvdXIgcGF0aC4gRWl0
aGVyIGBgL3Vzci9iaW5gYCBvciBgYC91c3IvbG9jYWwvYmluYGAgaXMgYQpnb29kIGNob2lj
ZS4KCllvdSBjYW4gbm93IHJ1biB0aGUgZHRsb2FkIGNvbW1hbmQgaW4gb3JkZXIgdG8gbG9h
ZCB0aGUgRGVjVGFsayBQQwpzb2Z0d2FyZSBvbnRvIHRoZSBjYXJkLiAgQWZ0ZXIgeW91IGhh
dmUgZG9uZSB0aGlzLCBgYGVjaG9gYCB0aGUgZGVjcGMKa2V5d29yZCB0byB0aGUgc3ludGgg
ZW50cnkgaW4gdGhlIHN5cyBzeXN0ZW0gbGlrZSB0aGlzOjoKCiAgZWNobyBkZWNwYyA+L3Nw
ZWFrdXAvc3ludGgKCllvdXIgRGVjVGFsayBQQyBzaG91bGQgc3RhcnQgdGFsa2luZywgYW5k
IHRoZW4geW91IGNhbiBhZGp1c3QgdGhlIHBpdGNoLApyYXRlLCB2b2x1bWUsIHZvaWNlLCBl
dGMuICBUaGUgdm9pY2UgZW50cnkgaW4gdGhlIFNwZWFrdXAgc3lzIHN5c3RlbQp3aWxsIGFj
Y2VwdCBhIG51bWJlciBmcm9tIDAgdGhyb3VnaCA3IGZvciB0aGUgRGVjVGFsayBQQyBzeW50
aGVzaXplciwKd2hpY2ggd2lsbCBnaXZlIHlvdSBhY2Nlc3MgdG8gc29tZSBvZiB0aGUgRGVj
VGFsayB2b2ljZXMuCgoKMTAuICBVc2luZyBDdXJzb3IgVHJhY2tpbmcKPT09PT09PT09PT09
PT09PT09PT09PT09PT0KCkluIFNwZWFrdXAgdmVyc2lvbiAyLjAgYW5kIGxhdGVyLCBjdXJz
b3IgdHJhY2tpbmcgaXMgdHVybmVkIG9uIGJ5CmRlZmF1bHQuICBUaGlzIG1lYW5zIHRoYXQg
d2hlbiB5b3UgYXJlIHVzaW5nIGFuIGVkaXRvciwgU3BlYWt1cCB3aWxsCmF1dG9tYXRpY2Fs
bHkgc3BlYWsgY2hhcmFjdGVycyBhcyB5b3UgbW92ZSBsZWZ0IGFuZCByaWdodCB3aXRoIHRo
ZQpjdXJzb3Iga2V5cywgYW5kIGxpbmVzIGFzIHlvdSBtb3ZlIHVwIGFuZCBkb3duIHdpdGgg
dGhlIGN1cnNvciBrZXlzLgpUaGlzIGlzIHRoZSB0cmFkaXRpb25hbCBzb3J0IG9mIGN1cnNv
ciB0cmFja2luZy4KUmVjZW50IHZlcnNpb25zIG9mIFNwZWFrdXAgcHJvdmlkZSB0d28gYWRk
aXRpb25hbCB3YXlzIHRvIGNvbnRyb2wgdGhlCnRleHQgdGhhdCBpcyBzcG9rZW4gd2hlbiB0
aGUgY3Vyc29yIGlzIG1vdmVkOgoiaGlnaGxpZ2h0IHRyYWNraW5nIiBhbmQgInJlYWQgd2lu
ZG93LiIKVGhleSBhcmUgZGVzY3JpYmVkIGxhdGVyIGluIHRoaXMgc2VjdGlvbi4KU29tZXRp
bWVzLCB0aGVzZSBtb2RlcyBnZXQgaW4geW91ciB3YXksIHNvIHlvdSBjYW4gZGlzYWJsZSBj
dXJzb3IgdHJhY2tpbmcKYWx0b2dldGhlci4KCllvdSBtYXkgc2VsZWN0IGFtb25nIHRoZSB2
YXJpb3VzIGZvcm1zIG9mIGN1cnNvciB0cmFja2luZyB1c2luZyB0aGUga2V5cGFkCmFzdGVy
aXNrIGtleS4KRWFjaCB0aW1lIHlvdSBwcmVzcyB0aGlzIGtleSwgYSBuZXcgbW9kZSBpcyBz
ZWxlY3RlZCwgYW5kIFNwZWFrdXAgc3BlYWtzCnRoZSBuYW1lIG9mIHRoZSBuZXcgbW9kZS4g
IFRoZSBuYW1lcyBmb3IgdGhlIGZvdXIgcG9zc2libGUgc3RhdGVzIG9mIGN1cnNvcgp0cmFj
a2luZyBhcmU6ICJjdXJzb3Jpbmcgb24iLCAiaGlnaGxpZ2h0IHRyYWNraW5nIiwgInJlYWQg
d2luZG93IiwKYW5kICJjdXJzb3Jpbmcgb2ZmLiIgIFRoZSBrZXlwYWQgYXN0ZXJpc2sga2V5
IG1vdmVzIHRocm91Z2ggdGhlIGxpc3Qgb2YKbW9kZXMgaW4gYSBjaXJjdWxhciBmYXNoaW9u
LgoKSWYgaGlnaGxpZ2h0IHRyYWNraW5nIGlzIGVuYWJsZWQsIFNwZWFrdXAgdHJhY2tzIGhp
Z2hsaWdodGVkIHRleHQsCnJhdGhlciB0aGFuIHRoZSBjdXJzb3IgaXRzZWxmLiBXaGVuIHlv
dSBtb3ZlIHRoZSBjdXJzb3Igd2l0aCB0aGUgYXJyb3cga2V5cywKU3BlYWt1cCBzcGVha3Mg
dGhlIGN1cnJlbnRseSBoaWdobGlnaHRlZCBpbmZvcm1hdGlvbi4KVGhpcyBpcyB1c2VmdWwg
d2hlbiBtb3ZpbmcgdGhyb3VnaCB2YXJpb3VzIG1lbnVzIGFuZCBkaWFsb2cgYm94ZXMuCklm
IGN1cnNvciB0cmFja2luZyBpc24ndCBoZWxwaW5nIHlvdSB3aGlsZSBuYXZpZ2F0aW5nIGEg
bWVudSwKdHJ5IGhpZ2hsaWdodCB0cmFja2luZy4KCldpdGggdGhlICJyZWFkIHdpbmRvdyIg
dmFyaWV0eSBvZiBjdXJzb3IgdHJhY2tpbmcsIHlvdSBjYW4gbGltaXQgdGhlIHRleHQKdGhh
dCBTcGVha3VwIHNwZWFrcyBieSBzcGVjaWZ5aW5nIGEgd2luZG93IG9mIGludGVyZXN0IG9u
IHRoZSBzY3JlZW4uClNlZSBzZWN0aW9uIDE1IGZvciBhIGRlc2NyaXB0aW9uIG9mIHRoZSBw
cm9jZXNzIG9mIGRlZmluaW5nIHdpbmRvd3MuCldoZW4geW91IG1vdmUgdGhlIGN1cnNvciB2
aWEgdGhlIGFycm93IGtleXMsIFNwZWFrdXAgb25seSBzcGVha3MKdGhlIGNvbnRlbnRzIG9m
IHRoZSB3aW5kb3cuICBUaGlzIGlzIGVzcGVjaWFsbHkgaGVscGZ1bCB3aGVuIHlvdSBhcmUg
aGVhcmluZwpzdXBlcmZsdW91cyBzcGVlY2guICBDb25zaWRlciB0aGUgZm9sbG93aW5nIGV4
YW1wbGUuCgpTdXBwb3NlIHRoYXQgeW91IGFyZSBhdCBhIHNoZWxsIHByb21wdC4gIFlvdSB1
c2UgYmFzaCwgYW5kIHlvdSB3YW50IHRvCmV4cGxvcmUgeW91ciBjb21tYW5kIGhpc3Rvcnkg
dXNpbmcgdGhlIHVwIGFuZCBkb3duIGFycm93IGtleXMuICBJZiB5b3UKaGF2ZSBlbmFibGVk
IGN1cnNvciB0cmFja2luZywgeW91IHdpbGwgaGVhciB0d28gcGllY2VzIG9mIGluZm9ybWF0
aW9uLgpTcGVha3VwIHNwZWFrcyBib3RoIHlvdXIgc2hlbGwgcHJvbXB0IGFuZCB0aGUgY3Vy
cmVudCBlbnRyeSBmcm9tIHRoZQpjb21tYW5kIGhpc3RvcnkuICBZb3UgbWF5IG5vdCB3YW50
IHRvIGhlYXIgdGhlIHByb21wdCByZXBlYXRlZAplYWNoIHRpbWUgeW91IG1vdmUsIHNvIHlv
dSBjYW4gc2lsZW5jZSBpdCBieSBzcGVjaWZ5aW5nIGEgd2luZG93LiAgRmluZAp0aGUgbGFz
dCBsaW5lIG9mIHRleHQgb24gdGhlIHNjcmVlbi4gIENsZWFyIHRoZSBjdXJyZW50IHdpbmRv
dyBieSBwcmVzc2luZwp0aGUga2V5IGNvbWJpbmF0aW9uIHNwZWFrdXAgYGYzYC4gIFVzZSB0
aGUgcmV2aWV3IGN1cnNvciB0byBmaW5kIHRoZSBmaXJzdApjaGFyYWN0ZXIgdGhhdCBmb2xs
b3dzIHlvdXIgc2hlbGwgcHJvbXB0LiAgUHJlc3Mgc3BlYWt1cCArIGBmMmAgdHdpY2UsIHRv
CmRlZmluZSBhIG9uZS1saW5lIHdpbmRvdy4gIFRoZSBib3VuZGFyaWVzIG9mIHRoZSB3aW5k
b3cgYXJlIHRoZQpjaGFyYWN0ZXIgZm9sbG93aW5nIHRoZSBzaGVsbCBwcm9tcHQgYW5kIHRo
ZSBlbmQgb2YgdGhlIGxpbmUuICBOb3csIGN5Y2xlCnRocm91Z2ggdGhlIGN1cnNvciB0cmFj
a2luZyBtb2RlcyB1c2luZyBrZXlwYWQgYXN0ZXJpc2ssIHVudGlsIFNwZWFrdXAKc2F5cyAi
cmVhZCB3aW5kb3cuIiAgTW92ZSB0aHJvdWdoIHlvdXIgaGlzdG9yeSB1c2luZyB5b3VyIGFy
cm93IGtleXMuCllvdSB3aWxsIG5vdGljZSB0aGF0IFNwZWFrdXAgbm8gbG9uZ2VyIHNwZWFr
cyB0aGUgcmVkdW5kYW50IHByb21wdC4KClNvbWUgZm9sa3MgbGlrZSB0byB0dXJuIGN1cnNv
ciB0cmFja2luZyBvZmYgd2hpbGUgdGhleSBhcmUgdXNpbmcgdGhlCmx5bnggd2ViIGJyb3dz
ZXIuICBZb3UgZGVmaW5pdGVseSB3YW50IHRvIHR1cm4gY3Vyc29yIHRyYWNraW5nIG9mZiB3
aGVuCnlvdSBhcmUgdXNpbmcgdGhlIGFsc2FtaXhlciBhcHBsaWNhdGlvbi4gIE90aGVyd2lz
ZSwgeW91IHdvbid0IGJlIGFibGUKdG8gaGVhciB5b3VyIG1peGVyIHNldHRpbmdzIHdoaWxl
IHlvdSBhcmUgdXNpbmcgdGhlIGFycm93IGtleXMuCgoKMTEuICBDdXQgYW5kIFBhc3RlCj09
PT09PT09PT09PT09PT09PQoKT25lIG9mIFNwZWFrdXAncyBtb3JlIHVzZWZ1bCBmZWF0dXJl
cyBpcyB0aGUgYWJpbGl0eSB0byBjdXQgYW5kIHBhc3RlCnRleHQgb24gdGhlIHNjcmVlbi4g
IFRoaXMgbWVhbnMgdGhhdCB5b3UgY2FuIGNhcHR1cmUgaW5mb3JtYXRpb24gZnJvbSBhCnBy
b2dyYW0sIGFuZCBwYXN0ZSB0aGF0IGNhcHR1cmVkIHRleHQgaW50byBhIGRpZmZlcmVudCBw
bGFjZSBpbiB0aGUKcHJvZ3JhbSwgb3IgaW50byBhbiBlbnRpcmVseSBkaWZmZXJlbnQgcHJv
Z3JhbSwgd2hpY2ggbWF5IGV2ZW4gYmUKcnVubmluZyBvbiBhIGRpZmZlcmVudCBjb25zb2xl
LgoKRm9yIGV4YW1wbGUsIGluIHRoaXMgbWFudWFsLCB3ZSBoYXZlIG1hZGUgcmVmZXJlbmNl
cyB0byBzZXZlcmFsIHdlYgpzaXRlcy4gIEl0IHdvdWxkIGJlIG5pY2UgaWYgeW91IGNvdWxk
IGN1dCBhbmQgcGFzdGUgdGhlc2UgdXJscyBpbnRvIHlvdXIKd2ViIGJyb3dzZXIuICBTcGVh
a3VwIGRvZXMgdGhpcyBxdWl0ZSBuaWNlbHkuICBTdXBwb3NlIHlvdSB3YW50ZWQgdG8KcGFz
dCB0aGUgZm9sbG93aW5nIHVybCBpbnRvIHlvdXIgYnJvd3NlcjoKCmh0dHA6Ly9saW51eC1z
cGVha3VwLm9yZy8KClVzZSB0aGUgc3BlYWt1cCByZXZpZXcga2V5cyB0byBwb3NpdGlvbiB0
aGUgcmVhZGluZyBjdXJzb3Igb24gdGhlIGZpcnN0CmNoYXJhY3RlciBvZiB0aGUgYWJvdmUg
dXJsLiAgV2hlbiB0aGUgcmVhZGluZyBjdXJzb3IgaXMgaW4gcG9zaXRpb24sCnByZXNzIHRo
ZSBrZXlwYWQgc2xhc2gga2V5IG9uY2UuICBTcGVha3VwIHdpbGwgc2F5LCAibWFyayIuICBO
ZXh0LApwb3NpdGlvbiB0aGUgcmVhZGluZyBjdXJzb3Igb24gdGhlIHJpZ2h0bW9zdCBjaGFy
YWN0ZXIgb2YgdGhlIGFib3ZlCnVybC4gUHJlc3MgdGhlIGtleXBhZCBzbGFzaCBrZXkgb25j
ZSBhZ2FpbiB0byBhY3R1YWxseSBjdXQgdGhlIHRleHQKZnJvbSB0aGUgc2NyZWVuLiAgU3Bl
YWt1cCB3aWxsIHNheSwgImN1dCIuICBBbHRob3VnaCB3ZSBjYWxsIHRoaXMKY3V0dGluZywg
U3BlYWt1cCBkb2VzIG5vdCBhY3R1YWxseSBkZWxldGUgdGhlIGN1dCB0ZXh0IGZyb20gdGhl
IHNjcmVlbi4KSXQgbWFrZXMgYSBjb3B5IG9mIHRoZSB0ZXh0IGluIGEgc3BlY2lhbCBidWZm
ZXIgZm9yIGxhdGVyIHBhc3RpbmcuCgpOb3cgdGhhdCB5b3UgaGF2ZSB0aGUgdXJsIGN1dCBm
cm9tIHRoZSBzY3JlZW4sIHlvdSBjYW4gcGFzdGUgaXQgaW50bwp5b3VyIGJyb3dzZXIsIG9y
IGV2ZW4gcGFzdGUgdGhlIHVybCBvbiBhIGNvbW1hbmQgbGluZSBhcyBhbiBhcmd1bWVudCB0
bwp5b3VyIGJyb3dzZXIuCgpTdXBwb3NlIHlvdSB3YW50IHRvIHN0YXJ0IGx5bnggYW5kIGdv
IHRvIHRoZSBTcGVha3VwIHNpdGUuCgpZb3UgY2FuIHN3aXRjaCB0byBhIGRpZmZlcmVudCBj
b25zb2xlIHdpdGggdGhlIGFsdCBsZWZ0IGFuZCByaWdodAphcnJvd3MsIG9yIHlvdSBjYW4g
c3dpdGNoIHRvIGEgc3BlY2lmaWMgY29uc29sZSBieSB0eXBpbmcgYWx0IGFuZCBhCmZ1bmN0
aW9uIGtleS4gIFRoZXNlIGFyZSBub3QgU3BlYWt1cCBjb21tYW5kcywganVzdCBzdGFuZGFy
ZCBMaW51eApjb25zb2xlIGNhcGFiaWxpdGllcy4KCk9uY2UgeW91J3ZlIGNoYW5nZWQgdG8g
YW4gYXBwcm9wcmlhdGUgY29uc29sZSwgYW5kIGFyZSBhdCBhIHNoZWxsIHByb21wdCwKdHlw
ZSB0aGUgd29yZCBseW54LCBmb2xsb3dlZCBieSBhIHNwYWNlLiAgTm93IHByZXNzIGFuZCBo
b2xkIHRoZSBzcGVha3VwCmtleSwgd2hpbGUgeW91IHR5cGUgdGhlIGtleXBhZCBzbGFzaCBj
aGFyYWN0ZXIuICBUaGUgdXJsIHdpbGwgYmUgcGFzdGVkCm9udG8gdGhlIGNvbW1hbmQgbGlu
ZSwganVzdCBhcyB0aG91Z2ggeW91IGhhZCB0eXBlZCBpdCBpbi4gIFByZXNzIHRoZQplbnRl
ciBrZXkgdG8gZXhlY3V0ZSB0aGUgY29tbWFuZC4KClRoZSBwYXN0ZSBidWZmZXIgd2lsbCBj
b250aW51ZSB0byBob2xkIHRoZSBjdXQgaW5mb3JtYXRpb24sIHVudGlsIGEgbmV3Cm1hcmsg
YW5kIGN1dCBvcGVyYXRpb24gaXMgY2FycmllZCBvdXQuICBUaGlzIG1lYW5zIHlvdSBjYW4g
cGFzdGUgdGhlIGN1dAppbmZvcm1hdGlvbiBhcyBtYW55IHRpbWVzIGFzIHlvdSBsaWtlIGJl
Zm9yZSBkb2luZyBhbm90aGVyIGN1dApvcGVyYXRpb24uCgpZb3UgYXJlIG5vdCBsaW1pdGVk
IHRvIGN1dHRpbmcgYW5kIHBhc3Rpbmcgb25seSBvbmUgbGluZSBvbiB0aGUgc2NyZWVuLgpZ
b3UgY2FuIGFsc28gY3V0IGFuZCBwYXN0ZSByZWN0YW5ndWxhciByZWdpb25zIG9mIHRoZSBz
Y3JlZW4uICBKdXN0CnBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNvciBhdCB0aGUgdG9wIGxl
ZnQgY29ybmVyIG9mIHRoZSB0ZXh0IHRvIGJlCmN1dCwgbWFyayBpdCB3aXRoIHRoZSBrZXlw
YWQgc2xhc2gga2V5LCB0aGVuIHBvc2l0aW9uIHRoZSByZWFkaW5nIGN1cnNvcgphdCB0aGUg
Ym90dG9tIHJpZ2h0IGNvcm5lciBvZiB0aGUgcmVnaW9uIHRvIGJlIGN1dCwgYW5kIGN1dCBp
dCB3aXRoIHRoZQprZXlwYWQgc2xhc2gga2V5LgoKCjEyLiAgQ2hhbmdpbmcgdGhlIFByb251
bmNpYXRpb24gb2YgQ2hhcmFjdGVycwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KClRocm91Z2ggdGhlIGBgL3NwZWFrdXAvaTE4bi9jaGFyYWN0ZXJz
YGAgc3lzIGVudHJ5LCBTcGVha3VwIGdpdmVzIHlvdSB0aGUKYWJpbGl0eSB0byBjaGFuZ2Ug
aG93IFNwZWFrdXAgcHJvbm91bmNlcyBhIGdpdmVuIGNoYXJhY3Rlci4gIFlvdSBjb3VsZCwK
Zm9yIGV4YW1wbGUsIGNoYW5nZSBob3cgc29tZSBwdW5jdHVhdGlvbiBjaGFyYWN0ZXJzIGFy
ZSBzcG9rZW4uICBZb3UgY2FuCmV2ZW4gY2hhbmdlIGhvdyBTcGVha3VwIHdpbGwgcHJvbm91
bmNlIGNlcnRhaW4gbGV0dGVycy4KCllvdSBtYXksIGZvciBleGFtcGxlLCB3aXNoIHRvIGNo
YW5nZSBob3cgU3BlYWt1cCBwcm9ub3VuY2VzIHRoZSB6CmNoYXJhY3Rlci4gIFRoZSBhdXRo
b3Igb2YgU3BlYWt1cCwgS2lyayBSZWlzZXIsIGlzIENhbmFkaWFuLCBhbmQgdGh1cwpiZWxp
ZXZlcyB0aGF0IHRoZSB6IHNob3VsZCBiZSBwcm9ub3VuY2VkIHplZC4gIElmIHlvdSBhcmUg
YW4gQW1lcmljYW4sCnlvdSBtaWdodCB3aXNoIHRvIHVzZSB0aGUgemVlIHByb251bmNpYXRp
b24gaW5zdGVhZCBvZiB6ZWQuICBZb3UgY2FuCmNoYW5nZSB0aGUgcHJvbnVuY2lhdGlvbiBv
ZiBib3RoIHRoZSB1cHBlciBhbmQgbG93ZXIgY2FzZSB6IHdpdGggdGhlCmZvbGxvd2luZyB0
d28gY29tbWFuZHM6OgoKICBlY2hvIDkwIHplZSA+L3NwZWFrdXAvY2hhcmFjdGVycwogIGVj
aG8gMTIyIHplZSA+L3NwZWFrdXAvY2hhcmFjdGVycwoKTGV0J3MgZXhhbWluZSB0aGUgcGFy
dHMgb2YgdGhlIHR3byBwcmV2aW91cyBjb21tYW5kcy4gIFRoZXkgYXJlIGlzc3VlZAphdCB0
aGUgc2hlbGwgcHJvbXB0LCBhbmQgY291bGQgYmUgcGxhY2VkIGluIGEgc3RhcnR1cCBzY3Jp
cHQuCgpUaGUgd29yZCBlY2hvIHRlbGxzIHRoZSBzaGVsbCB0aGF0IHlvdSB3YW50IHRvIGhh
dmUgaXQgZGlzcGxheSB0aGUKc3RyaW5nIG9mIGNoYXJhY3RlcnMgdGhhdCBmb2xsb3cgdGhl
IHdvcmQgZWNoby4gIElmIHlvdSB3ZXJlIHRvIGp1c3QKdHlwZTo6CgogIGVjaG8gaGVsbG8u
CgpZb3Ugd291bGQgZ2V0IHRoZSB3b3JkIGhlbGxvIHByaW50ZWQgb24geW91ciBzY3JlZW4g
YXMgc29vbiBhcyB5b3UKcHJlc3NlZCB0aGUgZW50ZXIga2V5LiAgSW4gdGhpcyBjYXNlLCB3
ZSBhcmUgZWNob2luZyBzdHJpbmdzIHRoYXQgd2UKd2FudCB0byBiZSByZWRpcmVjdGVkIGlu
dG8gdGhlIHN5cyBzeXN0ZW0uCgpUaGUgbnVtYmVycyA5MCBhbmQgMTIyIGluIHRoZSBhYm92
ZSBlY2hvIGNvbW1hbmRzIGFyZSB0aGUgYXNjaWkgbnVtZXJpYwp2YWx1ZXMgZm9yIHRoZSB1
cHBlciBhbmQgbG93ZXIgY2FzZSB6LCB0aGUgY2hhcmFjdGVycyB3ZSB3aXNoIHRvIGNoYW5n
ZS4KClRoZSBzdHJpbmcgemVlIGlzIHRoZSBwcm9udW5jaWF0aW9uIHRoYXQgd2Ugd2FudCBT
cGVha3VwIHRvIHVzZSBmb3IgdGhlCnVwcGVyIGFuZCBsb3dlciBjYXNlIHouCgpUaGUgYGA+
YGAgc3ltYm9sIHJlZGlyZWN0cyB0aGUgb3V0cHV0IG9mIHRoZSBlY2hvIGNvbW1hbmQgdG8g
YSBmaWxlLCBqdXN0Cmxpa2UgaW4gRE9TLCBvciBhdCB0aGUgV2luZG93cyBjb21tYW5kIHBy
b21wdC4KCkFuZCBmaW5hbGx5LCBgYC9zcGVha3VwL2kxOG4vY2hhcmFjdGVyc2BgIGlzIHRo
ZSBmaWxlIGVudHJ5IGluIHRoZSBzeXMgc3lzdGVtCndoZXJlIHdlIHdhbnQgdGhlIG91dHB1
dCB0byBiZSBkaXJlY3RlZC4gIFNwZWFrdXAgbG9va3MgYXQgdGhlIG51bWVyaWMKdmFsdWUg
b2YgdGhlIGNoYXJhY3RlciB3ZSB3YW50IHRvIGNoYW5nZSwgYW5kIGluc2VydHMgdGhlIHBy
b251bmNpYXRpb24Kc3RyaW5nIGludG8gYW4gaW50ZXJuYWwgdGFibGUuCgpZb3UgY2FuIGxv
b2sgYXQgdGhlIHdob2xlIHRhYmxlIHdpdGggdGhlIGZvbGxvd2luZyBjb21tYW5kOjoKCiAg
Y2F0IC9zcGVha3VwL2kxOG4vY2hhcmFjdGVycwoKU3BlYWt1cCB3aWxsIHRoZW4gcHJpbnQg
b3V0IHRoZSBlbnRpcmUgY2hhcmFjdGVyIHByb251bmNpYXRpb24gdGFibGUuICBJCndvbid0
IGRpc3BsYXkgaXQgaGVyZSwgYnV0IGxlYXZlIHlvdSB0byBsb29rIGF0IGl0IGF0IHlvdXIg
Y29udmVuaWVuY2UuCgoKMTMuICBNYXBwaW5nIEtleXMKPT09PT09PT09PT09PT09PT0KClNw
ZWFrdXAgaGFzIHRoZSBjYXBhYmlsaXR5IG9mIGFsbG93aW5nIHlvdSB0byBhc3NpZ24gb3Ig
Im1hcCIga2V5cyB0bwppbnRlcm5hbCBTcGVha3VwIGNvbW1hbmRzLiAgVGhpcyBzZWN0aW9u
IG5lY2Vzc2FyaWx5IGFzc3VtZXMgeW91IGhhdmUgYQpMaW51eCBrZXJuZWwgc291cmNlIHRy
ZWUgaW5zdGFsbGVkLCBhbmQgdGhhdCBpdCBoYXMgYmVlbiBwYXRjaGVkIGFuZApjb25maWd1
cmVkIHdpdGggU3BlYWt1cC4gIEhvdyB5b3UgZG8gdGhpcyBpcyBiZXlvbmQgdGhlIHNjb3Bl
IG9mIHRoaXMKbWFudWFsLiAgRm9yIHRoaXMgaW5mb3JtYXRpb24sIHZpc2l0IHRoZSBTcGVh
a3VwIHdlYiBzaXRlIGF0Cmh0dHA6Ly9saW51eC1zcGVha3VwLm9yZy8uICBUaGUgcmVhc29u
IHlvdSdsbCBuZWVkIHRoZSBrZXJuZWwgc291cmNlCnRyZWUgcGF0Y2hlZCB3aXRoIFNwZWFr
dXAgaXMgdGhhdCB0aGUgZ2VubWFwIHV0aWxpdHkgeW91J2xsIG5lZWQgZm9yCnByb2Nlc3Np
bmcga2V5bWFwcyBpcyBpbiB0aGUKYGAvdXNyL3NyYy9saW51eC08dmVyc2lvbl9udW1iZXI+
L2RyaXZlcnMvY2hhci9zcGVha3VwYGAgZGlyZWN0b3J5LiAgVGhlCmBgPHZlcnNpb25fbnVt
YmVyPmBgIGluIHRoZSBhYm92ZSBkaXJlY3RvcnkgcGF0aCBpcyB0aGUgdmVyc2lvbiBudW1i
ZXIgb2YKdGhlIExpbnV4IHNvdXJjZSB0cmVlIHlvdSBhcmUgd29ya2luZyB3aXRoLgoKU28g
b2ssIHlvdSd2ZSBnb25lIG9mZiBhbmQgZ290dGVuIHlvdXIga2VybmVsIHNvdXJjZSB0cmVl
LCBhbmQgcGF0Y2hlZAphbmQgY29uZmlndXJlZCBpdC4gIE5vdyB5b3UgY2FuIHN0YXJ0IG1h
bmlwdWxhdGluZyBrZXltYXBzLgoKWW91IGNhbiBlaXRoZXIgdXNlIHRoZQpgYC91c3Ivc3Jj
L2xpbnV4LTx2ZXJzaW9uX251bWJlcj4vZHJpdmVycy9jaGFyL3NwZWFrdXAvc3BlYWt1cG1h
cC5tYXBgYCBmaWxlCmluY2x1ZGVkIHdpdGggdGhlIFNwZWFrdXAgc291cmNlLCBvciB5b3Ug
Y2FuIGN1dCBhbmQgcGFzdGUgdGhlIGNvcHkgaW4Kc2VjdGlvbiA0IGludG8gYSBzZXBhcmF0
ZSBmaWxlLiAgSWYgeW91IHVzZSB0aGUgb25lIGluIHRoZSBTcGVha3VwCnNvdXJjZSB0cmVl
LCBtYWtlIHN1cmUgeW91IG1ha2UgYSBiYWNrdXAgb2YgaXQgYmVmb3JlIHlvdSBzdGFydCBt
YWtpbmcKY2hhbmdlcy4gIFlvdSBoYXZlIGJlZW4gd2FybmVkIQoKU3VwcG9zZSB0aGF0IHlv
dSB3YW50IHRvIHN3YXAgdGhlIGtleSBhc3NpZ25tZW50cyBmb3IgdGhlIFNwZWFrdXAKc2F5
X2xhc3RfY2hhciBhbmQgdGhlIFNwZWFrdXAgc2F5X2ZpcnN0X2NoYXIgY29tbWFuZHMuICBU
aGUKc3BlYWt1cG1hcC5tYXAgbGlzdHMgdGhlIGtleSBtYXBwaW5ncyBmb3IgdGhlc2UgdHdv
IGNvbW1hbmRzIGFzIGZvbGxvd3M6OgoKICBzcGsga2V5X3BhZ2V1cCA9IHNheV9maXJzdF9j
aGFyCiAgc3BrIGtleV9wYWdlZG93biA9IHNheV9sYXN0X2NoYXIKCllvdSBjYW4gZWRpdCB5
b3VyIGNvcHkgb2YgdGhlIHNwZWFrdXBtYXAubWFwIGZpbGUgYW5kIHN3YXAgdGhlIGNvbW1h
bmQKbmFtZXMgb24gdGhlIHJpZ2h0IHNpZGUgb2YgdGhlIGBgPWBgIChlcXVhbHMpIHNpZ24u
ICBZb3UgZGlkIG1ha2UgYSBiYWNrdXAsCnJpZ2h0PyAgVGhlIG5ldyBrZXltYXAgbGluZXMg
d291bGQgbG9vayBsaWtlIHRoaXM6OgoKICBzcGsga2V5X3BhZ2V1cCA9IHNheV9sYXN0X2No
YXIKICBzcGsga2V5X3BhZ2Vkb3duID0gc2F5X2ZpcnN0X2NoYXIKCkFmdGVyIHlvdSBlZGl0
IHlvdXIgY29weSBvZiB0aGUgc3BlYWt1cG1hcC5tYXAgZmlsZSwgc2F2ZSBpdCB1bmRlciBh
IG5ldwpmaWxlIG5hbWUsIHBlcmhhcHMgbmV3bWFwLm1hcC4gIFRoZW4gZXhpdCB5b3VyIGVk
aXRvciBhbmQgcmV0dXJuIHRvIHRoZQpzaGVsbCBwcm9tcHQuCgpZb3UgYXJlIG5vdyByZWFk
eSB0byBsb2FkIHlvdXIga2V5bWFwIHdpdGggeW91ciBzd2FwcGVkIGtleSBhc3NpZ25tZW50
cy4KQXNzdW1pbmcgdGhhdCB5b3Ugc2F2ZWQgeW91ciBuZXcga2V5bWFwIGFzIHRoZSBmaWxl
IG5ld21hcC5tYXAsIHlvdQp3b3VsZCBsb2FkIHlvdXIga2V5bWFwIGludG8gdGhlIHN5cyBz
eXN0ZW0gbGlrZSB0aGlzOjoKCiAgL3Vzci9zcmMvbGludXgtPHZlcnNpb25fbnVtYmVyPi9k
cml2ZXJzL2NoYXIvc3BlYWt1cC9nZW5tYXAgbmV3bWFwLm1hcCA+L3NwZWFrdXAva2V5bWFw
CgoKLi4gbm90ZTo6CgogIFJlbWVtYmVyIHRvIHN1YnN0aXR1dGUgeW91ciBrZXJuZWwgdmVy
c2lvbiBudW1iZXIgZm9yIHRoZQogIGBgPHZlcnNpb25fbnVtYmVyPmBgIGluIHRoZSBhYm92
ZSBjb21tYW5kLgoKWW91ciBzYXkgZmlyc3QgYW5kIHNheSBsYXN0IGNoYXJhY3RlcnMgc2hv
dWxkIG5vdyBiZSBzd2FwcGVkLiAgUHJlc3NpbmcKc3BlYWt1cCBwYWdlZG93biBzaG91bGQg
cmVhZCB5b3UgdGhlIGZpcnN0IG5vbi13aGl0ZXNwYWNlIGNoYXJhY3RlciBvbgp0aGUgbGlu
ZSB5b3VyIHJlYWRpbmcgY3Vyc29yIGlzIGluLCBhbmQgcHJlc3Npbmcgc3BlYWt1cCBwYWdl
dXAgc2hvdWxkCnJlYWQgeW91IHRoZSBsYXN0IGNoYXJhY3RlciBvbiB0aGUgbGluZSB5b3Vy
IHJlYWRpbmcgY3Vyc29yIGlzIGluLgoKLi4gbm90ZTo6CgogIFRoZXNlIG5ldyBtYXBwaW5n
cyB3aWxsIG9ubHkgc3RheSBpbiBlZmZlY3QgdW50aWwgeW91IHJlYm9vdCwKICBvciB1bnRp
bCB5b3UgbG9hZCBhbm90aGVyIGtleW1hcC4KCk9uZSBmaW5hbCB3YXJuaW5nLiAgSWYgeW91
IHRyeSB0byBsb2FkIGEgcGFydGlhbCBtYXAsIHlvdSB3aWxsIHF1aWNrbHkKZmluZCB0aGF0
IGFsbCB0aGUgbWFwcGluZ3MgeW91IGRpZG4ndCBpbmNsdWRlIGluIHlvdXIgZmlsZSBnb3Qg
ZGVsZXRlZApmcm9tIHRoZSB3b3JraW5nIG1hcC4gIEJlIGV4dHJlbWVseSBjYXJlZnVsLCBh
bmQgYWx3YXlzIG1ha2UgYSBiYWNrdXAhCllvdSBoYXZlIGJlZW4gd2FybmVkIQoKCjE0LiAg
SW50ZXJuYXRpb25hbGl6aW5nIFNwZWFrdXAKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQoKU3BlYWt1cCBpbmRpY2F0ZXMgdmFyaW91cyBjb25kaXRpb25zIHRvIHRoZSB1c2Vy
IGJ5IHNwZWFraW5nIG1lc3NhZ2VzLgpGb3IgaW5zdGFuY2UsIHdoZW4geW91IG1vdmUgdG8g
dGhlIGxlZnQgZWRnZSBvZiB0aGUgc2NyZWVuIHdpdGggdGhlCnJldmlldyBrZXlzLCBTcGVh
a3VwIHNheXMsICJsZWZ0LiIKUHJpb3IgdG8gdmVyc2lvbiAzLjEuMCBvZiBTcGVha3VwLCBh
bGwgb2YgdGhlc2UgbWVzc2FnZXMgd2VyZSBpbiBFbmdsaXNoLAphbmQgdGhleSBjb3VsZCBu
b3QgYmUgY2hhbmdlZC4gIElmIHlvdSB1c2VkIGEgbm9uLUVuZ2xpc2ggc3ludGhlc2l6ZXIs
CnlvdSBzdGlsbCBoZWFyZCBFbmdsaXNoIG1lc3NhZ2VzLCBzdWNoIGFzICJsZWZ0IiBhbmQg
ImN1cnNvcmluZyBvbi4iCkluIHZlcnNpb24gMy4xLjAgb3IgaGlnaGVyLCBvbmUgbWF5IGxv
YWQgdHJhbnNsYXRpb25zIGZvciB0aGUgdmFyaW91cwptZXNzYWdlcyB2aWEgdGhlIGBgL3N5
c2BgIGZpbGVzeXN0ZW0uCgpUaGUgZGlyZWN0b3J5IGBgL3NwZWFrdXAvaTE4bmBgIGNvbnRh
aW5zIHNldmVyYWwgY29sbGVjdGlvbnMgb2YgbWVzc2FnZXMuCkVhY2ggZ3JvdXAgb2YgbWVz
c2FnZXMgaXMgc3RvcmVkIGluIGl0cyBvd24gZmlsZS4KVGhlIGZvbGxvd2luZyBzZWN0aW9u
IGxpc3RzIGFsbCBvZiB0aGVzZSBmaWxlcywgYWxvbmcgd2l0aCBhIGJyaWVmIGRlc2NyaXB0
aW9uCm9mIGVhY2guCgoxNC4xLiAgRmlsZXMgVW5kZXIgdGhlIGkxOG4gU3ViZGlyZWN0b3J5
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCmFubm91bmNlbWVu
dHMKICBUaGlzIGZpbGUgY29udGFpbnMgdmFyaW91cyBnZW5lcmFsIGFubm91bmNlbWVudHMs
IG1vc3Qgb2Ygd2hpY2ggY2Fubm90CiAgYmUgY2F0ZWdvcml6ZWQuICBZb3Ugd2lsbCBmaW5k
IG1lc3NhZ2VzIHN1Y2ggYXMgIllvdSBraWxsZWQgU3BlYWt1cCIsCiAgIkknbSBhbGl2ZSIs
ICJsZWF2aW5nIGhlbHAiLCAicGFya2VkIiwgInVucGFya2VkIiwgYW5kIG90aGVycy4KICBZ
b3Ugd2lsbCBhbHNvIGZpbmQgdGhlIG5hbWVzIG9mIHRoZSBzY3JlZW4gZWRnZXMgYW5kIGN1
cnNvciB0cmFja2luZyBtb2RlcwogIGhlcmUuCgpjaGFyYWN0ZXJzCiAgU2VlIGAxMi4gIENo
YW5naW5nIHRoZSBQcm9udW5jaWF0aW9uIG9mIENoYXJhY3RlcnNgXyBmb3IgYSBkZXNjcmlw
dGlvbgogIG9mIHRoaXMgZmlsZS4KCmNoYXJ0YWIKICBTZWUgYDEyLiAgQ2hhbmdpbmcgdGhl
IFByb251bmNpYXRpb24gb2YgQ2hhcmFjdGVyc2BfLiAgVW5saWtlIHRoZSByZXN0CiAgb2Yg
dGhlIGZpbGVzIGluIHRoZSBpMThuIHN1YmRpcmVjdG9yeSwgdGhpcyBvbmUgZG9lcyBub3Qg
Y29udGFpbiBtZXNzYWdlcwogIHRvIGJlIHNwb2tlbi4KCmNvbG9ycwogIFdoZW4geW91IHVz
ZSB0aGUgInNheSBhdHRyaWJ1dGVzIiBmdW5jdGlvbiwgU3BlYWt1cCBzYXlzIHRoZSBuYW1l
IG9mIHRoZQogIGZvcmVncm91bmQgYW5kIGJhY2tncm91bmQgY29sb3JzLiAgVGhlc2UgbmFt
ZXMgY29tZSBmcm9tIHRoZSBpMThuL2NvbG9ycwogIGZpbGUuCgpjdGxfa2V5cwogIEhlcmUs
IHlvdSB3aWxsIGZpbmQgbmFtZXMgb2YgY29udHJvbCBrZXlzLiAgVGhlc2UgYXJlIHVzZWQg
d2l0aCBTcGVha3VwJ3MKICBzYXlfY29udHJvbCBmZWF0dXJlLgoKZm9ybWF0dGVkCiAgVGhp
cyBncm91cCBvZiBtZXNzYWdlcyBjb250YWlucyBlbWJlZGRlZCBmb3JtYXR0aW5nIGNvZGVz
LCB0byBzcGVjaWZ5CiAgdGhlIHR5cGUgYW5kIHdpZHRoIG9mIGRpc3BsYXllZCBkYXRhLiAg
SWYgeW91IGNoYW5nZSB0aGVzZSwgeW91IG11c3QKICBwcmVzZXJ2ZSBhbGwgb2YgdGhlIGZv
cm1hdHRpbmcgY29kZXMsIGFuZCB0aGV5IG11c3QgYXBwZWFyIGluIHRoZSBvcmRlcgogIHVz
ZWQgYnkgdGhlIGRlZmF1bHQgbWVzc2FnZXMuCgpmdW5jdGlvbl9uYW1lcwogIEhlcmUsIHlv
dSB3aWxsIGZpbmQgYSBsaXN0IG9mIG5hbWVzIGZvciBTcGVha3VwIGZ1bmN0aW9ucy4gIFRo
ZXNlIGFyZSB1c2VkCiAgYnkgdGhlIGhlbHAgc3lzdGVtLiAgRm9yIGV4YW1wbGUsIHN1cHBv
c2UgdGhhdCB5b3UgaGF2ZSBhY3RpdmF0ZWQgaGVscCBtb2RlLAogIGFuZCB5b3UgcHJlc3Nl
ZCBrZXlwYWQgMy4gIFNwZWFrdXAgc2F5czoKICAia2V5cGFkIDMgaXMgY2hhcmFjdGVyLCBz
YXkgbmV4dC4iCiAgVGhlIG1lc3NhZ2UgImNoYXJhY3Rlciwgc2F5IG5leHQiIG5hbWVzIGEg
U3BlYWt1cCBmdW5jdGlvbiwgYW5kIGl0CiAgY29tZXMgZnJvbSB0aGlzIGZ1bmN0aW9uX25h
bWVzIGZpbGUuCgprZXlfbmFtZXMKICBBZ2Fpbiwga2V5X25hbWVzIGlzIHVzZWQgYnkgU3Bl
YWt1cCdzIGhlbHAgc3lzdGVtLiAgSW4gdGhlIHByZXZpb3VzCiAgZXhhbXBsZSwgU3BlYWt1
cCBzYWlkIHRoYXQgeW91IHByZXNzZWQgImtleXBhZCAzLiIKICBUaGlzIG5hbWUgY2FtZSBm
cm9tIHRoZSBrZXlfbmFtZXMgZmlsZS4KCnN0YXRlcwogIFRoaXMgZmlsZSBjb250YWlucyBu
YW1lcyBmb3Iga2V5IHN0YXRlcy4KICBBZ2FpbiwgdGhlc2UgYXJlIHBhcnQgb2YgdGhlIGhl
bHAgc3lzdGVtLiAgRm9yIGluc3RhbmNlLCBpZiB5b3UgaGFkIHByZXNzZWQKICBzcGVha3Vw
ICsga2V5cGFkIDMsIHlvdSB3b3VsZCBoZWFyOgogICJzcGVha3VwIGtleXBhZCAzIGlzIGdv
IHRvIGJvdHRvbSBlZGdlLiIKICBUaGUgc3BlYWt1cCBrZXkgaXMgZGVwcmVzc2VkLCBzbyB0
aGUgbmFtZSBvZiB0aGUga2V5IHN0YXRlIGlzIHNwZWFrdXAuCiAgVGhpcyBwYXJ0IG9mIHRo
ZSBtZXNzYWdlIGNvbWVzIGZyb20gdGhlIHN0YXRlcyBjb2xsZWN0aW9uLgoKMTQuMi4xLiAg
TG9hZGluZyBZb3VyIE93biBNZXNzYWdlcwp+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+CgpUaGUgZmlsZXMgdW5kZXIgdGhlIGkxOG4gc3ViZGlyZWN0b3J5IGFsbCBmb2xs
b3cgdGhlIHNhbWUgZm9ybWF0LgpUaGV5IGNvbnNpc3Qgb2YgbGluZXMsIHdpdGggb25lIG1l
c3NhZ2UgcGVyIGxpbmUuCkVhY2ggbWVzc2FnZSBpcyByZXByZXNlbnRlZCBieSBhIG51bWJl
ciwgZm9sbG93ZWQgYnkgdGhlIHRleHQgb2YgdGhlIG1lc3NhZ2UuClRoZSBudW1iZXIgaXMg
dGhlIHBvc2l0aW9uIG9mIHRoZSBtZXNzYWdlIGluIHRoZSBnaXZlbiBjb2xsZWN0aW9uLgpG
b3IgZXhhbXBsZSwgaWYgeW91IHZpZXcgdGhlIGZpbGUgYGAvc3BlYWt1cC9pMThuL2NvbG9y
c2BgLCB5b3Ugd2lsbCBzZWUgdGhlCmZvbGxvd2luZyBsaXN0OjoKCiAgMCAtIGJsYWNrCiAg
MSAtIGJsdWUKICAyIC0gZ3JlZW4KICAzIC0gY3lhbgogIDQgLSByZWQKICA1IC0gbWFnZW50
YQogIDYgLSB5ZWxsb3cKICA3IC0gd2hpdGUKICA4IC0gZ3JleQoKWW91IGNhbiBjaGFuZ2Ug
b25lIG1lc3NhZ2UsIG9yIHlvdSBjYW4gY2hhbmdlIGEgd2hvbGUgZ3JvdXAuClRvIGxvYWQg
YSB3aG9sZSBjb2xsZWN0aW9uIG9mIG1lc3NhZ2VzIGZyb20gYSBuZXcgc291cmNlLCBzaW1w
bHkgdXNlCnRoZSBjcCBjb21tYW5kOjoKCiAgY3Agfi9teV9jb2xvcnMgL3NwZWFrdXAvaTE4
bi9jb2xvcnMKCllvdSBjYW4gY2hhbmdlIGFuIGluZGl2aWR1YWwgbWVzc2FnZSB3aXRoIHRo
ZSBlY2hvIGNvbW1hbmQsCmFzIHNob3duIGluIHRoZSBmb2xsb3dpbmcgZXhhbXBsZS4KClRo
ZSBTcGFuaXNoIG5hbWUgZm9yIHRoZSBjb2xvciBibHVlIGlzIGF6dWwuCkxvb2tpbmcgYXQg
dGhlIGNvbG9ycyBmaWxlLCB3ZSBzZWUgdGhhdCB0aGUgbmFtZSAiYmx1ZSIgaXMgYXQgcG9z
aXRpb24gMQp3aXRoaW4gdGhlIGNvbG9ycyBncm91cC4gIExldCdzIGNoYW5nZSBibHVlIHRv
IGF6dWw6OgoKICBlY2hvICcxIGF6dWwnID4gL3NwZWFrdXAvaTE4bi9jb2xvcnMKClRoZSBu
ZXh0IHRpbWUgdGhhdCBTcGVha3VwIHNheXMgbWVzc2FnZSAxIGZyb20gdGhlIGNvbG9ycyBn
cm91cCwgaXQgd2lsbApzYXkgImF6dWwiLCByYXRoZXIgdGhhbiAiYmx1ZS4iCgoxNC4yLjIu
IENob29zZSBhIGxhbmd1YWdlCn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkluIHRoZSBm
dXR1cmUsIHRyYW5zbGF0aW9ucyBpbnRvIHZhcmlvdXMgbGFuZ3VhZ2VzIHdpbGwgYmUgbWFk
ZSBhdmFpbGFibGUsCmFuZCBtb3N0IHVzZXJzIHdpbGwganVzdCBsb2FkIHRoZSBmaWxlcyBu
ZWNlc3NhcnkgZm9yIHRoZWlyIGxhbmd1YWdlLiBTbyBmYXIsCm9ubHkgRnJlbmNoIGxhbmd1
YWdlIGlzIGF2YWlsYWJsZSBiZXlvbmQgbmF0aXZlIENhbmFkaWFuIEVuZ2xpc2ggbGFuZ3Vh
Z2UuCgpGcmVuY2ggaXMgb25seSBhdmFpbGFibGUgYWZ0ZXIgeW91IGFyZSBsb2dnZWQgaW4u
CgpDYW5hZGlhbiBFbmdsaXNoIGlzIHRoZSBkZWZhdWx0IGxhbmd1YWdlLiBUbyB0b2dnbGUg
YW5vdGhlciBsYW5ndWFnZSwKZG93bmxvYWQgdGhlIHNvdXJjZSBvZiBTcGVha3VwIGFuZCB1
bnRhciBpdCBpbiB5b3VyIGhvbWUgZGlyZWN0b3J5LiBUaGUKZm9sbG93aW5nIGNvbW1hbmQg
c2hvdWxkIGxldCB5b3UgZG8gdGhpczo6CgogIHRhciB4dmpmIHNwZWFrdXAtPHZlcnNpb24+
LnRhci5iejIKCndoZXJlIGBgPHZlcnNpb24+YGAgaXMgdGhlIHZlcnNpb24gbnVtYmVyIG9m
IHRoZSBhcHBsaWNhdGlvbi4KCk5leHQsIGNoYW5nZSB0byB0aGUgbmV3bHkgY3JlYXRlZCBk
aXJlY3RvcnksIHRoZW4gaW50byB0aGUgdG9vbHMvIGRpcmVjdG9yeSwgYW5kCnJ1biB0aGUg
c2NyaXB0IHNwZWFrdXBfc2V0bG9jYWxlLiBZb3UgYXJlIGFza2VkIHRoZSBsYW5ndWFnZSB0
aGF0IHlvdSB3YW50IHRvCnVzZS4gVHlwZSB0aGUgbnVtYmVyIGFzc29jaWF0ZWQgdG8geW91
ciBsYW5ndWFnZSAoZS5nLiBmciBmb3IgRnJlbmNoKSB0aGVuIHByZXNzCkVudGVyLiBOZWVk
ZWQgZmlsZXMgYXJlIGNvcGllZCBpbiB0aGUgaTE4biBkaXJlY3RvcnkuCgpOb3RlOiB0aGUg
c3BlYWt1cGNvbmYgbXVzdCBiZSBpbnN0YWxsZWQgb24geW91ciBzeXN0ZW0gc28gdGhhdCBz
ZXR0aW5ncyBhcmUgc2F2ZWQuCk90aGVyd2lzZSwgeW91IHdpbGwgaGF2ZSBhbiBlcnJvcjog
eW91ciBsYW5ndWFnZSB3aWxsIGJlIGxvYWRlZCBidXQgeW91IHdpbGwKaGF2ZSB0byBydW4g
dGhlIHNjcmlwdCBhZ2FpbiBldmVyeSB0aW1lIFNwZWFrdXAgcmVzdGFydHMuClNlZSBzZWN0
aW9uIDE2LjEuIGZvciBpbmZvcm1hdGlvbiBhYm91dCBzcGVha3VwY29uZi4KCllvdSB3aWxs
IGhhdmUgdG8gcmVwZWF0IHRoZXNlIHN0ZXBzIGZvciBhbnkgY2hhbmdlIG9mIGxvY2FsZSwg
aS5lLiBpZiB5b3Ugd2lzaApjaGFuZ2UgdGhlIHNwZWFrdXAncyBsYW5ndWFnZSBvciBjaGFy
c2V0IChpc28tODg1OS0xNSBvdSBVVEYtOCkuCgpJZiB5b3Ugd2lzaCBzdG9yZSB0aGUgc2V0
dGluZ3MsIG5vdGUgdGhhdCBhdCB5b3VyIG5leHQgbG9naW4sIHlvdSB3aWxsIG5lZWQgdG8K
ZG86OgoKICBzcGVha3VwIGxvYWQKCkFsdGVybmF0aXZlbHksIHlvdSBjYW4gYWRkIHRoZSBh
Ym92ZSBsaW5lIHRvIHlvdXIgZmlsZQpgYH4vLmJhc2hyY2BgIG9yIGBgfi8uYmFzaF9wcm9m
aWxlYGAuCgpJZiB5b3VyIHN5c3RlbSBhZG1pbmlzdHJhdG9yIHJhbiBoaW1zZWxmIHRoZSBz
Y3JpcHQsIGFsbCB0aGUgdXNlcnMgd2lsbCBiZSBhYmxlCnRvIGNoYW5nZSBmcm9tIEVuZ2xp
c2ggdG8gdGhlIGxhbmd1YWdlIGNob29zZWQgYnkgcm9vdCBhbmQgZG8gZGlyZWN0bHkKc3Bl
YWt1cGNvbmYgbG9hZCAob3IgYWRkIHRoaXMgdG8gdGhlIGBgfi8uYmFzaHJjYGAgb3IKYGB+
Ly5iYXNoX3Byb2ZpbGVgYCBmaWxlKS4gSWYgdGhlcmUgYXJlIHNldmVyYWwgbGFuZ3VhZ2Vz
IHRvIGhhbmRsZSwgdGhlCmFkbWluaXN0cmF0b3IgKG9yIGV2ZXJ5IHVzZXIpIHdpbGwgaGF2
ZSB0byBydW4gdGhlIGZpcnN0IHN0ZXBzIHVudGlsIHNwZWFrdXBjb25mCnNhdmUsIGNob29z
aW5nIHRoZSBhcHByb3ByaWF0ZSBsYW5ndWFnZSwgaW4gZXZlcnkgdXNlcidzIGhvbWUgZGly
ZWN0b3J5LiBFdmVyeQp1c2VyIHdpbGwgdGhlbiBiZSBhYmxlIHRvIGRvIHNwZWFrdXBjb25m
IGxvYWQsIFNwZWFrdXAgd2lsbCBsb2FkIGhpcyBvd24gc2V0dGluZ3MuCgoxNC4zLiAgTm8g
U3VwcG9ydCBmb3IgTm9uLVdlc3Rlcm4tRXVyb3BlYW4gTGFuZ3VhZ2VzCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkFzIG9mIHRoZSBj
dXJyZW50IHJlbGVhc2UsIFNwZWFrdXAgb25seSBzdXBwb3J0cyBXZXN0ZXJuIEV1cm9wZWFu
IGxhbmd1YWdlcy4KU3VwcG9ydCBmb3IgdGhlIGV4dGVuZGVkIGNoYXJhY3RlcnMgdXNlZCBi
eSBsYW5ndWFnZXMgb3V0c2lkZSBvZiB0aGUgV2VzdGVybgpFdXJvcGVhbiBmYW1pbHkgb2Yg
bGFuZ3VhZ2VzIGlzIGEgd29yayBpbiBwcm9ncmVzcy4KCgoxNS4gIFVzaW5nIFNwZWFrdXAn
cyBXaW5kb3dpbmcgQ2FwYWJpbGl0eQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQoKU3BlYWt1cCBoYXMgdGhlIGNhcGFiaWxpdHkgb2YgZGVmaW5pbmcgYW5k
IG1hbmlwdWxhdGluZyB3aW5kb3dzIG9uIHRoZQpzY3JlZW4uICBTcGVha3VwIHVzZXMgdGhl
IHRlcm0gIldpbmRvdyIsIHRvIG1lYW4gYSB1c2VyIGRlZmluZWQgYXJlYSBvZgp0aGUgc2Ny
ZWVuLiAgVGhlIGtleSBzdHJva2VzIGZvciBkZWZpbmluZyBhbmQgbWFuaXB1bGF0aW5nIFNw
ZWFrdXAKd2luZG93cyBhcmUgYXMgZm9sbG93czo6CgogIHNwZWFrdXAgKyBmMiAtLSBTZXQg
dGhlIGJvdW5kcyBvZiB0aGUgd2luZG93LgogIFNwZWFrdXAgKyBmMyAtLSBjbGVhciB0aGUg
Y3VycmVudCB3aW5kb3cgZGVmaW5pdGlvbi4KICBzcGVha3VwICsgZjQgLS0gVG9nZ2xlIHdp
bmRvdyBzaWxlbmNlIG9uIGFuZCBvZmYuCiAgc3BlYWt1cCArIGtleXBhZCBwbHVzIC0tIFNh
eSB0aGUgY3VycmVudGx5IGRlZmluZWQgd2luZG93LgoKVGhlc2UgY2FwYWJpbGl0aWVzIGFy
ZSB1c2VmdWwgZm9yIHRyYWNraW5nIGEgY2VydGFpbiBwYXJ0IG9mIHRoZSBzY3JlZW4Kd2l0
aG91dCByZXJlYWRpbmcgdGhlIHdob2xlIHNjcmVlbiwgb3IgZm9yIHNpbGVuY2luZyBhIHBh
cnQgb2YgdGhlCnNjcmVlbiB0aGF0IGlzIGNvbnN0YW50bHkgY2hhbmdpbmcsIHN1Y2ggYXMg
YSBjbG9jayBvciBzdGF0dXMgbGluZS4KClRoZXJlIGlzIG5vIHdheSB0byBzYXZlIHRoZXNl
IHdpbmRvdyBzZXR0aW5ncywgYW5kIHlvdSBjYW4gb25seSBoYXZlIG9uZQp3aW5kb3cgZGVm
aW5lZCBmb3IgZWFjaCB2aXJ0dWFsIGNvbnNvbGUuICBUaGVyZSBpcyBhbHNvIG5vIHdheSB0
byBoYXZlCndpbmRvd3MgYXV0b21hdGljYWxseSBkZWZpbmVkIGZvciBzcGVjaWZpYyBhcHBs
aWNhdGlvbnMuCgpJbiBvcmRlciB0byBkZWZpbmUgYSB3aW5kb3csIHVzZSB0aGUgcmV2aWV3
IGtleXMgdG8gbW92ZSB5b3VyIHJlYWRpbmcKY3Vyc29yIHRvIHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIGFyZWEgeW91IHdhbnQgdG8gZGVmaW5lLiAgVGhlbiBwcmVzcwpzcGVha3VwICsgYGYy
YC4gIFNwZWFrdXAgd2lsbCB0ZWxsIHlvdSB0aGF0IHRoZSB3aW5kb3cgc3RhcnRzIGF0IHRo
ZQppbmRpY2F0ZWQgcm93IGFuZCBjb2x1bW4gcG9zaXRpb24uICBUaGVuIG1vdmUgdGhlIHJl
YWRpbmcgY3Vyc29yIHRvIHRoZQplbmQgb2YgdGhlIGFyZWEgdG8gYmUgZGVmaW5lZCBhcyBh
IHdpbmRvdywgYW5kIHByZXNzIHNwZWFrdXAgKyBgZjJgIGFnYWluLgpJZiB0aGVyZSBpcyBt
b3JlIHRoYW4gb25lIGxpbmUgaW4gdGhlIHdpbmRvdywgU3BlYWt1cCB3aWxsIHRlbGwgeW91
CnRoYXQgdGhlIHdpbmRvdyBlbmRzIGF0IHRoZSBpbmRpY2F0ZWQgcm93IGFuZCBjb2x1bW4g
cG9zaXRpb24uICBJZiB0aGVyZQppcyBvbmx5IG9uZSBsaW5lIGluIHRoZSB3aW5kb3csIHRo
ZW4gU3BlYWt1cCB3aWxsIHRlbGwgeW91IHRoYXQgdGhlCndpbmRvdyBpcyB0aGUgc3BlY2lm
aWVkIGxpbmUgb24gdGhlIHNjcmVlbi4gIElmIHlvdSBhcmUgb25seSBkZWZpbmluZyBhCm9u
ZSBsaW5lIHdpbmRvdywgeW91IGNhbiBqdXN0IHByZXNzIHNwZWFrdXAgKyBgZjJgIHR3aWNl
IGFmdGVyIHBsYWNpbmcgdGhlCnJlYWRpbmcgY3Vyc29yIG9uIHRoZSBsaW5lIHlvdSB3YW50
IHRvIGRlZmluZSBhcyBhIHdpbmRvdy4gIEl0IGlzIG5vdApuZWNlc3NhcnkgdG8gcG9zaXRp
b24gdGhlIHJlYWRpbmcgY3Vyc29yIGF0IHRoZSBlbmQgb2YgdGhlIGxpbmUgaW4gb3JkZXIK
dG8gZGVmaW5lIHRoZSB3aG9sZSBsaW5lIGFzIGEgd2luZG93LgoKCjE2LiAgVG9vbHMgZm9y
IENvbnRyb2xsaW5nIFNwZWFrdXAKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQoKVGhlIHNwZWFrdXAgZGlzdHJpYnV0aW9uIGluY2x1ZGVzIGV4dHJhIHRvb2xzIChpbiB0
aGUgdG9vbHMgZGlyZWN0b3J5KQp3aGljaCB3ZXJlIHdyaXR0ZW4gdG8gbWFrZSBzcGVha3Vw
IGVhc2llciB0byB1c2UuICBUaGlzIHNlY3Rpb24gd2lsbApicmllZmx5IGRlc2NyaWJlIHRo
ZSB1c2Ugb2YgdGhlc2UgdG9vbHMuCgoxNi4xLiAgU3BlYWt1cGNvbmYKLS0tLS0tLS0tLS0t
LS0tLS0tCgpzcGVha3VwY29uZiBiZWdhbiBsaWZlIGFzIGEgY29udHJpYnV0aW9uIGZyb20g
U3RldmUgSG9sbWVzLCBhIG1lbWJlciBvZgp0aGUgc3BlYWt1cCBjb21tdW5pdHkuICBXZSB3
b3VsZCBsaWtlIHRvIHRoYW5rIGhpbSBmb3IgaGlzIHdvcmsgb24gdGhlCmVhcmx5IHZlcnNp
b25zIG9mIHRoaXMgcHJvamVjdC4KClRoaXMgc2NyaXB0IG1heSBiZSBpbnN0YWxsZWQgYXMg
cGFydCBvZiB5b3VyIGxpbnV4IGRpc3RyaWJ1dGlvbiwgYnV0IGlmCml0IGlzbid0LCB0aGUg
cmVjb21tZW5kZWQgcGxhY2VzIHRvIHB1dCBpdCBhcmUgYGAvdXNyL2xvY2FsL2JpbmBgIG9y
CmBgL3Vzci9iaW5gYC4gIFRoaXMgc2NyaXB0IGNhbiBiZSBydW4gYnkgYW55IHVzZXIsIHNv
IGl0IGRvZXMgbm90IHJlcXVpcmUKcm9vdCBwcml2aWxlZ2VzLgoKU3BlYWt1cGNvbmYgYWxs
b3dzIHlvdSB0byBzYXZlIGFuZCBsb2FkIHlvdXIgU3BlYWt1cCBzZXR0aW5ncy4gIEl0IHdv
cmtzCmJ5IHJlYWRpbmcgYW5kIHdyaXRpbmcgdGhlIGBgL3N5c2BgIGZpbGVzIGRlc2NyaWJl
ZCBhYm92ZS4KClRoZSBkaXJlY3RvcnkgdGhhdCBzcGVha3VwY29uZiB1c2VzIHRvIHN0b3Jl
IHlvdXIgc2V0dGluZ3MgZGVwZW5kcyBvbgp3aGV0aGVyIGl0IGlzIHJ1biBmcm9tIHRoZSBy
b290IGFjY291bnQuICBJZiB5b3UgZXhlY3V0ZSBzcGVha3VwY29uZiBhcwpyb290LCBpdCB1
c2VzIHRoZSBkaXJlY3RvcnkgYGAvZXRjL3NwZWFrdXBgYC4gIE90aGVyd2lzZSwgaXQgdXNl
cyB0aGUgZGlyZWN0b3J5CmBgfi8uc3BlYWt1cGBgLCB3aGVyZSBgYH5gYCBpcyB5b3VyIGhv
bWUgZGlyZWN0b3J5LgpBbnlvbmUgd2hvIG5lZWRzIHRvIHVzZSBTcGVha3VwIGZyb20geW91
ciBjb25zb2xlIGNhbiBsb2FkIGhpcyBvd24gY3VzdG9tCnNldHRpbmdzIHdpdGggdGhpcyBz
Y3JpcHQuCgpzcGVha3VwY29uZiB0YWtlcyBvbmUgcmVxdWlyZWQgYXJndW1lbnQ6IGxvYWQg
b3Igc2F2ZS4KVXNlIHRoZSBjb21tYW5kOjoKCiAgc3BlYWt1cGNvbmYgc2F2ZQoKdG8gc2F2
ZSB5b3VyIFNwZWFrdXAgc2V0dGluZ3MsIGFuZDo6CgogIHNwZWFrdXBjb25mIGxvYWQKCnRv
IGxvYWQgdGhlbSBpbnRvIFNwZWFrdXAuCgpBIHNlY29uZCBhcmd1bWVudCBtYXkgYmUgc3Bl
Y2lmaWVkIHRvIHVzZSBhbiBhbHRlcm5hdGUgZGlyZWN0b3J5IHRvCmxvYWQgb3Igc2F2ZSB0
aGUgc3BlYWt1cCBwYXJhbWV0ZXJzLgoKMTYuMi4gIFRhbGt3aXRoCi0tLS0tLS0tLS0tLS0t
LQoKQ2hhcmxlcyBIYWxsZW5iZWNrLCBhbm90aGVyIG1lbWJlciBvZiB0aGUgc3BlYWt1cCBj
b21tdW5pdHksIHdyb3RlIHRoZQppbml0aWFsIHZlcnNpb25zIG9mIHRoaXMgc2NyaXB0LCBh
bmQgd2Ugd291bGQgYWxzbyBsaWtlIHRvIHRoYW5rIGhpbSBmb3IKaGlzIHdvcmsgb24gaXQu
CgpUaGlzIHNjcmlwdCBuZWVkcyByb290IHByaXZpbGVnZXMgdG8gcnVuLCBzbyBpZiBpdCBp
cyBub3QgaW5zdGFsbGVkIGFzCnBhcnQgb2YgeW91ciBsaW51eCBkaXN0cmlidXRpb24sIHRo
ZSByZWNvbW1lbmRlZCBwbGFjZXMgdG8gaW5zdGFsbCBpdAphcmUgYGAvdXNyL2xvY2FsL3Ni
aW5gYCBvciBgYC91c3Ivc2JpbmBgLgoKVGFsa3dpdGggYWxsb3dzIHlvdSB0byBzd2l0Y2gg
c3ludGhlc2l6ZXJzIG9uIHRoZSBmbHkuICBJdCB0YWtlcyBhIHN5bnRoZXNpemVyCm5hbWUg
YXMgYW4gYXJndW1lbnQuICBGb3IgaW5zdGFuY2UsCnRhbGt3aXRoIGRlY3RsawpjYXVzZXMg
U3BlYWt1cCB0byB1c2UgdGhlIERlY1RhbGsgRXhwcmVzcy4gIElmIHlvdSB3aXNoIHRvIHN3
aXRjaCB0byBhCnNvZnR3YXJlIHN5bnRoZXNpemVyLCB5b3UgbXVzdCBhbHNvIGluZGljYXRl
IHdoaWNoIGRhZW1vbiB5b3Ugd2lzaCB0bwp1c2UuICBUaGVyZSBhcmUgdHdvIHBvc3NpYmxl
IGNob2ljZXM6CnNwZCBhbmQgZXNwZWFrdXAuICBzcGQgaXMgYW4gYWJicmV2aWF0aW9uIGZv
ciBzcGVlY2hkLXVwLgpJZiB5b3Ugd2lzaCB0byB1c2UgZXNwZWFrdXAgZm9yIHNvZnR3YXJl
IHN5bnRoZXNpcywgZ2l2ZSB0aGUgY29tbWFuZAp0YWxrd2l0aCBzb2Z0IGVzcGVha3VwClRv
IHVzZSBzcGVlY2hkLXVwLCB0eXBlOjoKCiAgdGFsa3dpdGggc29mdCBzcGQKCkFueSBhcmd1
bWVudHMgdGhhdCBmb2xsb3cgdGhlIG5hbWUgb2YgdGhlIGRhZW1vbiBhcmUgcGFzc2VkIHRv
IHRoZSBkYWVtb24Kd2hlbiBpdCBpcyBpbnZva2VkLiAgRm9yIGluc3RhbmNlOjoKCiAgdGFs
a3dpdGggZXNwZWFrdXAgLS1kZWZhdWx0LXZvaWNlPWZyCgpjYXVzZXMgZXNwZWFrdXAgdG8g
dXNlIHRoZSBGcmVuY2ggdm9pY2UuCgouLiBub3RlOjoKCiAgVGFsa3dpdGggbXVzdCBhbHdh
eXMgYmUgZXhlY3V0ZWQgd2l0aCByb290IHByaXZpbGVnZXMuCgpUYWxrd2l0aCBkb2VzIG5v
dCBhdHRlbXB0IHRvIGxvYWQgeW91ciBzZXR0aW5ncyBhZnRlciB0aGUgbmV3CnN5bnRoZXNp
emVyIGlzIGFjdGl2YXRlZC4gIFlvdSBjYW4gdXNlIHNwZWFrdXBjb25mIHRvIGxvYWQgeW91
ciBzZXR0aW5ncwppZiBkZXNpcmVkLgoKCgo=
--------------8F2755065F9007E1085D124E--
