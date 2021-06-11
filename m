Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE43A4A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFKVLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 17:11:46 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:42880 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhFKVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:11:41 -0400
Received: by mail-ej1-f48.google.com with SMTP id k25so6437151eja.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5RYu1yzTcYpZQLW2ljBy/Ub8tYY/LNdm9AWdK10j7KU=;
        b=ULwcGngStr4q6USLFU8YONQ493SZ9NLerC01aVbVHlnMo+Z2J2VmXboyiUEIyy/fxF
         VIQkdBTLnUgIgIIMDoWdFi4u8ofA3Wes4kzCXdhhOm5an/M3aLQl+mu1BQcPZ4W2thxv
         guklyZ3W06qdre+yzJhTVje4Mmw63PRLmuCE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RYu1yzTcYpZQLW2ljBy/Ub8tYY/LNdm9AWdK10j7KU=;
        b=f1TR3ApRZ9OPth9L9Jxa1vlazgn1DAtrFKeMdqzAcgxtbS0pQZlTar9u0/AYuYPPEh
         CwwHrurT+Bm9G02l/tFu3PM8XkTVbLO1Nw2fwvHVt8ftZlTjjHU55fgwpCymMMmDI7hh
         mpOvZrAaQPYOTfIkTIIYLIqNY56lDm6D11Ufsz6AyJf3sbquXj2CKNrn5/DqliUYEWEu
         dcmnDZLl/8MV7Nvsq3ut5DhwRWv8OeQc/gPm+5KyWJ32P2Lx4FVn6tE0ySu9r+h/4ult
         6Yyh15OLO9/KIMQlPV8iZxBFtAu7vjCRvI6E+3DL+K+fsWADAhD0njcTtHisTgXxADTX
         HMjQ==
X-Gm-Message-State: AOAM530JhYyu5FrDerRNe3swlDC9MXX06X3guzQxhDRXQhlnEoVeUH7M
        vINuIgXfbS8/FfOyzUS41uKxxiU+mcpLQQ==
X-Google-Smtp-Source: ABdhPJwTXvU42F3CqX6v3WwMlP1dn3lIsTaubaDPy/s7bO19h1AmW5Wh1TRJeeZSIibI9PVzP8ohmQ==
X-Received: by 2002:a17:906:2bc6:: with SMTP id n6mr5359852ejg.256.1623445707377;
        Fri, 11 Jun 2021 14:08:27 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id d17sm2433652ejp.90.2021.06.11.14.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 14:08:26 -0700 (PDT)
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
 <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
 <20210611084817.GB26476@xsang-OptiPlex-9020>
 <db82c1c9-edfe-6ee2-c403-d6740e8c46c6@rasmusvillemoes.dk>
 <20210611152959.GA29971@xsang-OptiPlex-9020>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <729130e8-1e2e-ba79-5c4a-5156ac6d64be@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 23:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611152959.GA29971@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 17.29, Oliver Sang wrote:
> hi Rasmus,
> 
> On Fri, Jun 11, 2021 at 11:20:18AM +0200, Rasmus Villemoes wrote:
>> OK. It's really odd that providing the VM with _more_ memory makes it
>> fail (other then the obvious failure in the other direction when there's
>> simply not enough memory for the unpacked initramfs itself). But
>> unfortunately that also sounds like I won't be able to reproduce with
>> the HW I have.
>>
>>>> As an extra data point, what happens if you add initramfs_async=0 to the
>>>> command line?
>>>
>>> yes, we tested this before sending out the report. the issue gone
>>> if initramfs_async=0 is added.
>>
>> Hm. Sounds like some initcall after rootfs_initcall time must
>> allocate/hog a lot of memory, perhaps with some heuristic depending on
>> how much is available.
>>
>> Can you try with initcall_debug=1? I think that should produce a lot of
>> output, hopefully that would make it possible to see which initcalls
>> have been done just prior to (or while) the initramfs unpacking hits ENOMEM.
> 
> thanks a lot for guidance!
> 
> by several jobs with initcall_debug=1, the oom happens consistently after
> "calling  panel_init_module"
> 
> below is an example, and detail dmesg.xz attached:

Interesting. Well, I'm not sure panel_init_module has anything to do
with it; there is an almost five second gap until the OOM hits. So my
_guess_ is that we're just hitting

panel_init_module ->
parport_register_driver (macro wrapper for __parport_register_driver) ->
get_lowlevel_driver ->
request_module ->
...
wait_for_initramfs

which is why there's no more output from PID1. But just in case, can you
try disabling CONFIG_PARPORT_PANEL and see if you still hit the OOM?

It's not clear where all the memory goes. Is there any way to print some
memory statistics after each initcall?

You said that it was consistent, so perhaps something like this ugly
hack could be used to "bisect" to see which other initcall(s) we have a
bad interaction with:

diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..2386057f1faa 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -732,3 +732,19 @@ static int __init populate_rootfs(void)
        return 0;
 }
 rootfs_initcall(populate_rootfs);
+
+static unsigned count;
+static int __init hack_setup(char *str)
+{
+       count = simple_strtoul(str, NULL, 0);
+       return 1;
+}
+__setup("hack=", hack_setup);
+
+void hack(void)
+{
+       if (!initramfs_cookie || !count)
+               return;
+       if (!--count)
+               wait_for_initramfs();
+}
diff --git a/init/main.c b/init/main.c
index e9c42a183e33..a96367080011 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1236,6 +1236,7 @@ static inline void
do_trace_initcall_finish(initcall_t fn, int ret)
 }
 #endif /* !TRACEPOINTS_ENABLED */

+extern void hack(void);
 int __init_or_module do_one_initcall(initcall_t fn)
 {
        int count = preempt_count();
@@ -1248,6 +1249,7 @@ int __init_or_module do_one_initcall(initcall_t fn)
        do_trace_initcall_start(fn);
        ret = fn();
        do_trace_initcall_finish(fn, ret);
+       hack();

        msgbuf[0] = 0;

(compile-tested only). By my count, there are 322 initcalls from
populate_rootfs() to panel_init_module() inclusive. Booting with hack=1
should be equivalent to initramfs_async=0 and hence succeed, and
hack=322 should make you see the above behaviour.


Rasmus
