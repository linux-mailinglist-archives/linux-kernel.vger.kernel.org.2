Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560963D58BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhGZLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhGZLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:05:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA64C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:46:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id jg2so11082400ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qzMdoe+UOOrlvP6HpgpsES23IJcRirjppJvTAQGKbDw=;
        b=fiBX20Elneyu49tg9KgXvoP1053uCdeaGnE0zyMEl3eoNOm4OpWZPWhyQ3xb7HTE6S
         mYCnqvBaWCBQBiMjfLH9DRTk63FDrDPMmT4H94c2nyghDVos6Ws/tNKsu4qvnkMU1vUi
         +nh/N0dx+1t7/K6EL5/EvjtOYh6CmdwgF2Qg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qzMdoe+UOOrlvP6HpgpsES23IJcRirjppJvTAQGKbDw=;
        b=I4HOD8w2vvnWwy6Og8spHk/wBB0CpjK88Irv7G89LOTvTAj7w3RQYysyhfYe8nwaAQ
         GGOoUU9TsvM1QLWDG1As1FRncbuZ2joVR4mZ5HKLnyU//08H3YxJElvvTURuuKvgiQIZ
         Qxo+Y3CRBFnGXwczs+8NAQKdYCawZht+jW12gfD3fBPgoHErgBgElGQFoHo4NsmnlVgL
         kXlTPk2wERxRpp700tYFGVf+lUnbQ60QaFC4bC6nY/WU8zLYFOEPdwKDlgGw0NBdhv1N
         IbhSXO1HVR2SsBYbh8Ku3XcNRTepKt9NSdl8dTVTUns7AOERK11vdtMZdyIZsDWN9M4F
         ZKHA==
X-Gm-Message-State: AOAM533xE1sprjttTSBiNIlMm53VunpZt3MeW+8gGrIDgAlLezb+sWRW
        R6a3eAAes2URXkeVz0R+pdhvSA==
X-Google-Smtp-Source: ABdhPJx78dMgTWDfKtK7ZvPasV1H9N8LEZufvQIC6xdPsvWfEJro2lu6lE7rJ0TAqLgNeIIZQTZeNQ==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr9621180ejb.219.1627299964909;
        Mon, 26 Jul 2021 04:46:04 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.69.72])
        by smtp.gmail.com with ESMTPSA id ec38sm19031505edb.15.2021.07.26.04.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 04:46:04 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        linux@rasmusvillemoes.dk
Cc:     akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <87sg04p315.fsf@oc8242746057.ibm.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
Date:   Mon, 26 Jul 2021 13:46:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87sg04p315.fsf@oc8242746057.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2021 09.46, Alexander Egorenkov wrote:
> Hello,
> 
> since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> started seeing the following problem on s390 arch regularly:
> 
> [    5.039734] wait_for_initramfs() called before rootfs_initcalls

While that message was added as part of the same patch, it's a red
herring: It merely means that something ends up calling usermodehelper
(perhaps a request_module) before the init sequence has come around to
rootfs_initcalls. At that point, the rootfs is (with or without my async
patch) entirely empty, so those usermodehelper calls have always failed
with -ENOENT.

If you have CONFIG_UEVENT_HELPER=y and CONFIG_UEVENT_HELPER_PATH set to
a non-empty string, you can try setting the latter to the empty string.
But the message won't go away if it's really a request_module() and not
a uevent notification.

> [    6.599433] rootfs image is not initramfs (broken padding); looks like an initrd
> [    6.669373] Freeing initrd memory: 24828K
> 
> It is very hard to reproduce, i haven't managed to do it yet and working
> on it, but it occurs regularly, nearly every day once but only on a particular
> test machine with our nightly s390 CI test runs.

So this looks somewhat similar to a ppc64 report

https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u

that ended up not being caused by e7cb072eb988, since it could also be
reproduced with that patch reverted. I don't know if Bruno found the
root cause, adding him to cc. Also cc += Dave Young who had some input
in that thread.

> Although the initramfs corruption is hard to reproduce,
> the message 'wait_for_initramfs() called before rootfs_initcalls'
> appears regularly on each boot at least since 2021-06-24 which we just
> noticed a couple of days ago.
> 
> Appending 'initramfs_async=0' to the kernel command-line doesn't seem to
> help with the 'wait_for_initramfs' message and i can still see it.

Yes, that's expected. I should probably send a patch to move
usermodehelper_enable() from do_basic_setup() to populate_rootfs(), as
it really doesn't make sense to have usermodehelper enabled before
there's any content in the file system. But as I said, the warning is
harmless and merely indicates there's a bunch of futile work being done
to call a (at that point in time) non-existing usermode program.

> [    0.890962] wait_for_initramfs() called before rootfs_initcalls
...
> [    1.636419] Trying to unpack rootfs image as initramfs...
> [    1.676907] Freeing initrd memory: 26056K

It would be interesting if you could boot with initramfs_async=0 enough
times to see if you can reproduce the problem; and/or do the same with
e7cb072eb988 reverted.

Thanks,
Rasmus
