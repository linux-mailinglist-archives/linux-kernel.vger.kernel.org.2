Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D71731DC37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhBQPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhBQP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:29:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:28:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r21so17786104wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4pcyLYffNfmU+u3Tjw4FhdV6ogQRH45aAGk6RIO5pI=;
        b=slA93Ow1GNgJE18cJVQ3EST12wmjCcw9wakQ5pxtzBj2bymDif+l5P17HZbxVyvj01
         vpTzdQJOxMCMosSV1zD39ehXGAKlAsJZPpT4yQc7CC/HGJb0dlMyTzfMBIDhGIZGVz9t
         L/TmV8uy5MpoydfOvtC/x7Kc3HMqmBJpbbTKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4pcyLYffNfmU+u3Tjw4FhdV6ogQRH45aAGk6RIO5pI=;
        b=LQEfzvEMusNY2XmDPwLyxwu1XPbLCZjy+APmwKJMu6AQ839r0m+H0VNxbLrnhJjlzl
         iXTacvLGv79UEKI74zqc56Xkg0b+qnzGGTNwqVkg6QpIxuT1WdcpkrehV/7CEuaReAWP
         KJx3MdmaeElJVnRjAncv6KCfZiLmqGBPBYddk9XwMkIrKjs5atzEC6t2bRXMsNFUHi3y
         EDWa9K/xf96zIR6oXOygKWJSycev9CbIQqMsCBh/uHwau7F/ai61O4IvkL1+LmT72VGt
         F1hZ2JNgZmgN1cOHsvotl7zisybBxCNgQvnXxrhrffwIn/tWeIo5nZ10Qh3lyP85rr+5
         HM9g==
X-Gm-Message-State: AOAM532YClRqwpcr4Vgyo5r/xCh+ZJvT9DyaEE2Q8SxA8/6FeIq/TFWa
        NsZH8xFwCbSp9dkJLadR/ZUKEw==
X-Google-Smtp-Source: ABdhPJzpaTJBRhShgDtTNIHpvGuipAtZwkumHE6YjI69eS1HJ9bXTibCCDilHs0nSF+EB48mDb3A7g==
X-Received: by 2002:adf:df81:: with SMTP id z1mr29083310wrl.259.1613575705258;
        Wed, 17 Feb 2021 07:28:25 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id l2sm4506798wrm.6.2021.02.17.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:28:24 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:28:24 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: output: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC02GBghuhmlvrXk@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvqdrBc3wLDClhv@alley>
 <YCv4V5EFeuEmyxSz@chrisdown.name>
 <YC0n3vRO788sXqud@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC0n3vRO788sXqud@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>I guess that you already use it internally and have its own tooling
>around it.

Hmm, we're actually not using it yet widely because I don't want to backport it 
to our prod kernel until we're reasonably agreed on the format :-)

My main concern is making sure that parsing is reliable, and there's as
little "well, there shouldn't ever be a <char> here" as possible. That's why I
preferred originally to use the already well established char array/printk
rules where possible, since they're mature and well tested.

I'm not against some other solution though, as long as it meets these
requirements. It looks like your proposed format with escaping prior to sending 
to userspace also meets that requirement.

>    $ cat pf.py
>    #!/usr/bin/env python
>    with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
>        raw_fmts = f.read().split("\x00")[:-1]
>        for raw_fmt in raw_fmts:
>            level, fmt = raw_fmt[1], raw_fmt[2:]
>            print(f"Level {level}: {fmt!r}")
>
>I wonder how it would look in another scripting languages, like
>bash or perl. Any non-printable character is tricky and would
>complicate it.

It's really not that complicated there, either. Since you bring up bash, it's
even less work than the Python solution:

     while IFS= read -r -d $'\0' fmt; do
         printf 'Level %s: %q\n' "${fmt:1:1}" "${fmt:2}"
     done < /sys/kernel/debug/printk/formats/vmlinux

The changelog describes the use case: automated detection of printk fmts
changing. For that reason, I don't understand why there's a desire to produce a
human readable format by default when the only known consumer of this is going
to be automation anyway.

If a use case for that comes up, we can always have a directory producing human 
readable versions. I personally don't see the need though.

As long as it's reliably parseable though, I won't die on this hill, I just 
don't understand the rationale :-)

>> Re: not being not safe for machine processing because it only works for a
>> single digit, I'm a little confused. KERN_* levels are, as far as I know,
>> only a single byte wide, and we rely on that already (eg. in
>> printk_skip_header()).
>
>It is great that you mentioned it. KERN_ levels are implementation
>detail.
>
>It used to be "<level>". The binary KERN_SOH has been introduced
>in v3.6-rc1 by the commit 04d2c8c83d0e3ac5f ("printk: convert
>the format for KERN_<LEVEL> to a 2 byte pattern").
>
>In v4.9-rc1, the commit 4bcc595ccd80decb4 ("printk: reinstate KERN_CONT
>for printing continuation lines") added the possibility to define
>both KERN_LEVEL + KERN_CONT at the same time. It is not handled
>by your python snippet above.

Thanks, this is a good callout. I will make sure v5 handles that.

In a hypothetical scenario where we do go towards something human-readable, how 
do you perceive that should look? Something like this?

     % less ...
     <c, 5> 'Some fmt with cont + level 5\n'
     <5> 'Some fmt with only level 5\n'
     <c> 'Some fmt with only LOG_CONT\n'

>> We also already have precedent for
>> null-separation/control characters in (for example) /proc/pid/cmdline.
>
>Yes, there is a precedent. But it does not mean that we should not
>try to do it better.

To be clear, I'm actually asserting that I believe the machine-readable version 
_is_ better, not that it's simply unnecessary to produce a human-readable 
version :-)

As mentioned earlier in this e-mail though, it's not a hill I want to die on.  
If you believe it should be human-readable, as long as its reliably parseable, 
I'm happy to do that.
