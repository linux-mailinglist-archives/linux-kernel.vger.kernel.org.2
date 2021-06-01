Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5839762A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhFAPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhFAPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:13:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC052C061574;
        Tue,  1 Jun 2021 08:11:30 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z1so7356388qvo.4;
        Tue, 01 Jun 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y767OaMfFFbemWWFP3gHwczlHzwVeNK+OGy5uLWq4H0=;
        b=RNhiuP4RVLhB6AGDuB//l6b0ZpRPSulWzXZSeOim/YwePtFUqC+uYCRHYKDDnJwc28
         xKh9omh3k9Plu3mlNoBMDAXt0nbtP2bcoVeu5KVtBgqdqM0IuxsrhDve0A6oInz5+Be0
         1Fl9YN21raiSFYF5omR4MgMbWunFtuxD8U/LugSdlAx9rrn7YWPDJoIx3o3gZRx6MPpV
         24sizaFrSOQ3CeWoQbdcGvOWc8p2hm30R+boit+s1ZchDUDNE21JMk/by+kamCx0GKsf
         ZeMmCd2MFXiOAY/Zv2kQaMQmBjzgrHhGQ6lUbFYyz7rjqopq0AKfAKAF1u1YmteuU+g4
         XQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y767OaMfFFbemWWFP3gHwczlHzwVeNK+OGy5uLWq4H0=;
        b=WwIzkOsbkFX/SZE1KqU8hohTi4w3Ez0dbkM6SImLbKLOCTT/ZXoam0gEvjl5E2BwuP
         9t+9CWpv1xxfioFIUFsK4zmx7CCKU4gZN7AEGIIlGDoVWmyQYDbRytX5FHzRZ6WV76uK
         z4TlxWUUWvj+UGGDLqZ/fX9Ta49YNT3aRBdt6VWkL1rPNLum7pfphBhEbRV0aredm2ug
         V8dnAXjmaqr2fvg1V11F5g1gyw5iX/paCDFS56OqVvy7pphDfjQEitECqFlLvGKgT9Kt
         vBAG0z4wSnbZSNyENFKyGervNTlENnCo6eig1Od7ORqZpSXUrbMQZOEs8ndOyVLLI5Mw
         DiFg==
X-Gm-Message-State: AOAM530FD3m3X4gVkl8TW/AqgrIX9CgiFaKzIjWjyA3IUU+mLdA9lefU
        jEQO+ZF65L3q71kA4KM9I5sjk6VesWE=
X-Google-Smtp-Source: ABdhPJwqJjLVndEtvnkhXd41odpz78kjPPrnR2hDin9ds32pMgac87gvG1+TiHzknc/9/SKmvFNchg==
X-Received: by 2002:ad4:4a68:: with SMTP id cn8mr2933833qvb.38.1622560289627;
        Tue, 01 Jun 2021 08:11:29 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id c68sm10639823qkd.112.2021.06.01.08.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:11:29 -0700 (PDT)
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
To:     Jani Nikula <jani.nikula@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, samuel.thibault@ens-lyon.org,
        grandmaster@al2klimov.de, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <87r1hlrfhk.fsf@intel.com>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <1b1e0e07-d438-0902-a28a-e346cba53518@gmail.com>
Date:   Tue, 1 Jun 2021 12:11:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87r1hlrfhk.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani Nikula,

On 6/1/21 8:28 AM, Jani Nikula wrote:
> On Mon, 31 May 2021, Igor Matheus Andrade Torrente <igormtorrente@gmail.com> wrote:
>> Modify some parts of the text and add the necessary formatting to leverage
>> the rst features. Including links, code-blocks, bullet lists, etc.
>>
>> Also, adds a table of contents at the beginning and a section to the
>> license.
>>
>> This change helps integrate this documentation to the rest of the rst
>> documentation.
>>
>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>> ---
>>
>> V2: Rebase the patch to cover the commit cae2181b498fe
>>
>> ---
>>   Documentation/admin-guide/index.rst           |    1 +
>>   .../{spkguide.txt => spkguide.rst}            | 1026 +++++++++--------
>>   2 files changed, 574 insertions(+), 453 deletions(-)
>>   rename Documentation/admin-guide/{spkguide.txt => spkguide.rst} (75%)
>>
>> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>> index 423116c4e787..c45121777ecf 100644
>> --- a/Documentation/admin-guide/index.rst
>> +++ b/Documentation/admin-guide/index.rst
>> @@ -112,6 +112,7 @@ configure specific aspects of kernel behavior to your liking.
>>      ras
>>      rtc
>>      serial-console
>> +   spkguide
>>      svga
>>      syscall-user-dispatch
>>      sysrq
>> diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.rst
>> similarity index 75%
>> rename from Documentation/admin-guide/spkguide.txt
>> rename to Documentation/admin-guide/spkguide.rst
>> index 977ab3f5a0a8..e254af41a8e9 100644
>> --- a/Documentation/admin-guide/spkguide.txt
>> +++ b/Documentation/admin-guide/spkguide.rst
>> @@ -1,14 +1,20 @@
>> -
>> +========================
>>   The Speakup User's Guide
>> -For Speakup 3.1.2 and Later
>> -By Gene Collins
>> -Updated by others
>> -Last modified on Mon Sep 27 14:26:31 2010
>> -Document version 1.3
>> +========================
>> +
>> +| For Speakup 3.1.2 and Later
>> +| By Gene Collins
>> +| Updated by others
>> +| Last modified on Mon Jan 21 17:08:21 2021
>> +| Document version 1.3
>> +
>>   
>> -Copyright (c) 2005  Gene Collins
>> -Copyright (c) 2008  Samuel Thibault
>> -Copyright (c) 2009, 2010  the Speakup Team
>> +Copyright and License
>> +=====================
>> +
>> +| Copyright (c) 2005  Gene Collins
>> +| Copyright (c) 2008  Samuel Thibault
>> +| Copyright (c) 2009, 2010  the Speakup Team
> 
> Use a field list?
> 
> https://docutils.sourceforge.io/docs/user/rst/quickref.html#field-lists

That what I was looking for when converting this text, thanks!

> 
>>   
>>   Permission is granted to copy, distribute and/or modify this document
>>   under the terms of the GNU Free Documentation License, Version 1.2 or
>> @@ -17,7 +23,40 @@ Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A
>>   copy of the license is included in the section entitled "GNU Free
>>   Documentation License".
>>   
>> +
>> +Contents
>> +========
>> +
>> +* `Preface`_.
>> +
>> +* `1.  Starting Speakup`_
>> +* `2.  Basic operation`_
>> +* `3.  Using the Speakup Help System`_
>> +* `4.  Keys and Their Assigned Commands`_
>> +* `5.  The Speakup Sys System`_
>> +* `6.  Changing Synthesizers`_
>> +* `7.  Loading modules`_
>> +* `8.  Using Software Synthesizers`_
>> +     - `8.1. Espeakup`_
>> +     - `8.2. Speech Dispatcher`_
>> +* `9.  Using The DecTalk PC Card`_
>> +* `10.  Using Cursor Tracking`_
>> +* `11.  Cut and Paste`_
>> +* `12.  Changing the Pronunciation of Characters`_
>> +* `13.  Mapping Keys`_
>> +* `14.  Internationalizing Speakup`_
>> +     - `14.1.  Files Under the i18n Subdirectory`_.
>> +     - `14.2.1.  Loading Your Own Messages`_.
>> +     - `14.2.2. Choose a language`_.
>> +     - `14.3.  No Support for Non-Western-European Languages`_.
>> +* `15.  Using Speakup's Windowing Capability`_
>> +* `16.  Tools for Controlling Speakup`_
>> +     - `16.1.  Speakupconf`_.
>> +     - `16.2.  Talkwith`_
> 
> There's a directive for this:
> 
> .. contents::
> 
> The document didn't use to have a manually updated contents, why add one
> now that you can have it automated?
> 
> https://docutils.sourceforge.io/docs/ref/rst/directives.html#table-of-contents

Thanks, I will change it!

> 
>> +
>> +
>>   Preface
>> +=======
>>   
>>   The purpose of this document is to familiarize users with the user
>>   interface to Speakup, a Linux Screen Reader.  If you need instructions
>> @@ -37,7 +76,9 @@ with speech access unaided by a sighted person.  Again, these details
>>   are beyond the scope of this manual, but the user should be aware of
>>   them.  See the web site mentioned above for further details.
>>   
>> +
> 
> Unnecessary extra blank line, but okay.

For me these blank lines makes the rst more readable in the text editor 
like vim.

> 
>>   1.  Starting Speakup
> 
> I'd drop the numbers and let Sphinx take care of this.
> 
>> +====================
>>   
>>   If your system administrator has installed Speakup to work with your
>>   specific synthesizer by default, then all you need to do to use Speakup
>> @@ -58,41 +99,43 @@ build and install your own kernel.
>>   If your kernel has been compiled with Speakup, and has no default
>>   synthesizer set, or you would like to use a different synthesizer than
>>   the default one, then you may issue the following command at the boot
>> -prompt of your boot loader.
>> +prompt of your boot loader.::
>>   
>> -linux speakup.synth=ltlk
>> +  linux speakup.synth=ltlk
>>   
>>   This command would tell Speakup to look for and use a LiteTalk or
>>   DoubleTalk LT at boot up.  You may replace the ltlk synthesizer keyword
>>   with the keyword for whatever synthesizer you wish to use.  The
>> -speakup.synth parameter will accept the following keywords, provided
>> +``speakup.synth`` parameter will accept the following keywords, provided
>>   that support for the related synthesizers has been built into the
>>   kernel.
>>   
>> -acntsa -- Accent SA
>> -acntpc -- Accent PC
>> -apollo -- Apollo
>> -audptr -- Audapter
>> -bns -- Braille 'n Speak
>> -dectlk -- DecTalk Express (old and new, db9 serial only)
>> -decext -- DecTalk (old) External
>> -dtlk -- DoubleTalk PC
>> -keypc -- Keynote Gold PC
>> -ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
>> -spkout -- Speak Out
>> -txprt -- Transport
>> -dummy -- Plain text terminal
>> -
>> -Note: Speakup does * NOT * support usb connections!  Speakup also does *
>> -NOT * support the internal Tripletalk!
>> +| acntsa -- Accent SA
>> +| acntpc -- Accent PC
>> +| apollo -- Apollo
>> +| audptr -- Audapter
>> +| bns -- Braille 'n Speak
>> +| dectlk -- DecTalk Express (old and new, db9 serial only)
>> +| decext -- DecTalk (old) External
>> +| dtlk -- DoubleTalk PC
>> +| keypc -- Keynote Gold PC
>> +| ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
>> +| spkout -- Speak Out
>> +| txprt -- Transport
>> +| dummy -- Plain text terminal
> 
> Looks like a definition list?
> 
> https://docutils.sourceforge.io/docs/user/rst/quickref.html#definition-lists

If the '|' is replaced by definition-list, I'll have to skip a line to 
each item so the sphinx doesn't concatenate them into a single line. 
Like this:

keywords
   acntsa -- Accent SA

   acntpc -- Accent PC

   apollo -- Apollo
   [...]


There's a way to do that without these blank lines?

For me, it doesn't look very good, but I think the tradeoff worth it 
improves readability to speakup users. If it is the case.

> 
>> +
>> +.. note::
>> +
>> +   | Speakup does **NOT** support usb connections!
>> +   | Speakup also does **NOT** support the internal Tripletalk!
> 
> Why the pipes "|"?

This is the way I found to separate these sentences into two different 
lines. I'm gladly accepting a better solution for this :)

> 
>>   
>>   Speakup does support two other synthesizers, but because they work in
>>   conjunction with other software, they must be loaded as modules after
>>   their related software is loaded, and so are not available at boot up.
>>   These are as follows:
>>   
>> -decpc -- DecTalk PC (not available at boot up)
>> -soft -- One of several software synthesizers (not available at boot up)
>> +| decpc -- DecTalk PC (not available at boot up)
>> +| soft -- One of several software synthesizers (not available at boot up)
>>   
>>   See the sections on loading modules and software synthesizers later in
>>   this manual for further details.  It should be noted here that the
>> @@ -102,7 +145,9 @@ the boot process, such action must be configured by your system
>>   administrator.  This will mean that you will hear some, but not all,  of
>>   the bootup messages.
>>   
>> +
>>   2.  Basic operation
>> +===================
>>   
>>   Once you have booted the system, and if necessary, have supplied the
>>   proper bootup parameter for your synthesizer, Speakup will begin
>> @@ -115,10 +160,12 @@ screen using the kernel, and must get their keyboard input through the
>>   kernel, they are automatically handled properly by Speakup.  There are a
>>   few exceptions, but we'll come to those later.
>>   
>> -Note:  In this guide I will refer to the numeric keypad as the keypad.
>> -This is done because the speakupmap.map file referred to later in this
>> -manual uses the term keypad instead of numeric keypad.  Also I'm lazy
>> -and would rather only type one word.  So keypad it is.  Got it?  Good.
>> +.. note::
>> +
>> +  In this guide I will refer to the numeric keypad as the keypad.
>> +  This is done because the speakupmap.map file referred to later in this
>> +  manual uses the term keypad instead of numeric keypad.  Also I'm lazy
>> +  and would rather only type one word.  So keypad it is.  Got it?  Good.
>>   
>>   Most of the Speakup review keys are located on the keypad at the far
>>   right of the keyboard.  The numlock key should be off, in order for these
>> @@ -131,9 +178,9 @@ You probably won't want to listen to all the bootup messages every time
>>   you start your system, though it's a good idea to listen to them at
>>   least once, just so you'll know what kind of information is available to
>>   you during the boot process.  You can always review these messages after
>> -bootup with the command:
>> +bootup with the command::
>>   
>> -dmesg | more
>> +  dmesg | more
>>   
>>   In order to speed the boot process, and to silence the speaking of the
>>   bootup messages, just press the keypad enter key.  This key is located
>> @@ -164,19 +211,19 @@ the speech with keypad enter, or use any of the Speakup review keys.
>>   Here are some basic Speakup review keys, and a short description of what
>>   they do.
>>   
>> -keypad 1 -- read previous character
>> -keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
>> -	the current character phonetically)
>> -keypad 3 -- read next character
>> -keypad 4 -- read previous word
>> -keypad 5 -- read current word (press twice rapidly to spell the current word)
>> -keypad 6 -- read next word
>> -keypad 7 -- read previous line
>> -keypad 8 -- read current line (press twice rapidly to hear how much the
>> -	text on the current line is indented)
>> -keypad 9 -- read next line
>> -keypad period -- speak current cursor position and announce current
>> -	virtual console
>> +| keypad 1 -- read previous character
>> +| keypad 2 -- read current character (pressing keypad 2 twice rapidly will speak
>> +	      the current character phonetically)
>> +| keypad 3 -- read next character
>> +| keypad 4 -- read previous word
>> +| keypad 5 -- read current word (press twice rapidly to spell the current word)
>> +| keypad 6 -- read next word
>> +| keypad 7 -- read previous line
>> +| keypad 8 -- read current line (press twice rapidly to hear how much the
>> +	      text on the current line is indented)
>> +| keypad 9 -- read next line
>> +| keypad period -- speak current cursor position and announce current
>> +		   virtual console
> 
> Definition list?
> 
> Ditto for all the similar cases.
> 
>>   
>>   It's also worth noting that the insert key on the keypad is mapped
>>   as the speakup key.  Instead of pressing and releasing this key, as you
>> @@ -190,16 +237,18 @@ Speakup will say, "You turned me off.", or "Hey, that's better."  When
>>   Speakup is turned off, no new text on the screen will be spoken.  You
>>   can still use the reading controls to review the screen however.
>>   
> 
> [snip]
> 
>> +
>> +Document License
>> +================
>> +
> 
> Using SPDX might be nice.

I was just trying to respect the original text as much as possible, but 
I don't mind change it if everybody agrees with it.

> 
>>                   GNU Free Documentation License
>>                     Version 1.2, November 2002
>>   
>>   
>> - Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
>> - Everyone is permitted to copy and distribute verbatim copies
>> - of this license document, but changing it is not allowed.
>> +Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
>> +Everyone is permitted to copy and distribute verbatim copies
>> +of this license document, but changing it is not allowed.
>>   
>>   
>>   0. PREAMBLE
> 
