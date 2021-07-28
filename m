Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD73D8D04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhG1LtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhG1LtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:49:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D56C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 04:49:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h2so3391852lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d2D+hJNQBzPVKTTQsdeFot1jQaXIpG7C6Y4YayV23PE=;
        b=FvPY9YoCBpLyEXj1Kgv+5iXiIKiLQxwT+PFAcZZw9yBJVBquxy7J8psvyK8e234aTQ
         4HRlT4FqwSBg/FFC/CXzhesufW/cJakbRR4TQ13Wvjyw4s22EGmvHp9G73bt85zRRHXf
         nBC8FiF9MEyAPdqhG7ps0NHsW16Ex5bzcsrz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2D+hJNQBzPVKTTQsdeFot1jQaXIpG7C6Y4YayV23PE=;
        b=ULZyZD8MK1IC3jZ1Jn5BwnumqECzLHBMTs/ls0Jk4NiWEJKQIj9S78JIQgYImHR4c6
         W24IWH28WmW9G2dNopKHe56OUUhSurPIPCiLPgy5s0aW9RKRTRjTJpgnvOGXR8c1WCR/
         hTzpPuxjkaDTFlouO4WQxN8BljR0wmBeJvQmkXxGOG2EA/RW5ZxGEPUWtaK1qgxEmKju
         WfNFq7JqcfrZqyiiqb1niMTczJIBwaOExjOfz2SXAAwKqCcTqR7H219G5U4QefkjqDu2
         K/FrM/aX5HXBv/uh3XBErAqy46FQKZmxoocOHuuvbNOuL/t4QJS2CfbtOKHCjK0+AAsF
         WXwg==
X-Gm-Message-State: AOAM533SY8Iu1Cp75witm1eVGcQkt1jpildzgLWKkdPbHZv/z6u8qNgd
        KAsqVXMfsl8GQ+C3ORABN4mYNQ==
X-Google-Smtp-Source: ABdhPJxbIkLWStTvQEowM17wmHvy/ETRZtCvZOjeiki9c+cou8rsj4se0fz5Rcro3kpEGXzzLJA3ew==
X-Received: by 2002:a05:6512:3f99:: with SMTP id x25mr19693185lfa.225.1627472957705;
        Wed, 28 Jul 2021 04:49:17 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m9sm492531ljo.85.2021.07.28.04.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 04:49:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <87sfzyg1x9.fsf@oc8242746057.ibm.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6a9819fe-b1cc-63fe-6ab3-32a4fbe7f16f@rasmusvillemoes.dk>
Date:   Wed, 28 Jul 2021 13:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87sfzyg1x9.fsf@oc8242746057.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 12.36, Alexander Egorenkov wrote:
> Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:
> 
>> On 24/07/2021 09.46, Alexander Egorenkov wrote:
>>> Hello,
>>>
>>> since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
>>> started seeing the following problem on s390 arch regularly:
>>>
>>> [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>>
>> While that message was added as part of the same patch, it's a red
>> herring: It merely means that something ends up calling usermodehelper
>> (perhaps a request_module) before the init sequence has come around to
>> rootfs_initcalls. At that point, the rootfs is (with or without my async
>> patch) entirely empty, so those usermodehelper calls have always failed
>> with -ENOENT.
>>
>> If you have CONFIG_UEVENT_HELPER=y and CONFIG_UEVENT_HELPER_PATH set to
>> a non-empty string, you can try setting the latter to the empty string.
>> But the message won't go away if it's really a request_module() and not
>> a uevent notification.
>>
> 
> Thanks for the helpful explanation. I disabled UEVENT on my test machine and
> as you said, the message is being triggered by request_module() now.

Yes. But as I've said, the "called before rootfs_initcalls" message is
entirely harmless and not in any way related to whatever problems is
later encountered when the initramfs is actually being decompressed and
extracted.

I have this so far untested patch that I plan on sending, which should
remove that message

diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..51a686a8c929 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -727,6 +727,7 @@ static int __init populate_rootfs(void)
 {
        initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
                                                 &initramfs_domain);
+       usermodehelper_enable();
        if (!initramfs_async)
                wait_for_initramfs();
        return 0;
diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..d5c5542fe142 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1387,7 +1387,6 @@ static void __init do_basic_setup(void)
        driver_init();
        init_irq_proc();
        do_ctors();
-       usermodehelper_enable();
        do_initcalls();
 }

diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 3d62b07f3bb9..f1d9e5495cc1 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -18,6 +18,7 @@ static int __init default_rootfs(void)
 {
        int err;

+       usermodehelper_enable();
        err = init_mkdir("/dev", 0755);
        if (err < 0)
                goto out;

because any call of a usermodehelper (be it a uevent hotplug
notification or a request_module) would just return -EBUSY during all
pure_, core_, postcore_, arch_, subsys_ and fs_ initcalls. (It is really
beyond me why rootfs_ initcalls are hidden between fs_ and device_
initcalls).

Currently (with or without my async patch) umh calls from those
initcalls probably return -ENOENT or whatever kernel_execve() returns
when there's no such binary. So if something actually looks at the
return value, the change from -ENOENT to -EBUSY might cause a
regression. But I doubt it.

Rasmus
