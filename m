Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE003A2C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFJNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:05:32 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:33290 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFJNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:05:32 -0400
Received: by mail-ej1-f45.google.com with SMTP id g20so44094052ejt.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPHYvldXG36Q5hmLWy7mjXbIeQh84dwNnvC0v95QQto=;
        b=MExxyjTKjAoJPOl7e1Myfso7OXcONgfuCORM2hcMWu2qGKDB+4m1Dvm/HYHlro+LtZ
         T+V8UtWHec2GeIfcw0cW6hvspKjfI4k949lWYxZEj+SnPbo+d4If2i3uymFg+qQ2EwMT
         WE6dYG/RYd22P/KLzPYd5jvfggDdzsoppB0so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPHYvldXG36Q5hmLWy7mjXbIeQh84dwNnvC0v95QQto=;
        b=XijVkmX6lUHq9Sdtm90q9271bCQGJb2jWVlIgWvgRtpGByuURufvWhu4/ZMweoKJ4v
         KUxwwR+nSZWPGhMiMB8GPb17bVyGg2dZE0iunuI3DgjjjOdKdOFYeaeLoPJdTkXbOp8N
         v0LRmPytKKyfONdLlXxsOu1BInegC49WY4JW5qQuRJX92oGZn6AIdwvyPY0oWHoJwBtr
         E3YRIlG1+P4vggjzllgSrR5NxDqhYlEOk+s05iv+W6DsL08pZXuPHTOxt/OVuSuDUpd0
         io8FUlOTs92bZPqPKgiNJyvTeEf98jSEy4ZY+w9suVfMzZccJCTT+NMdZyVgjLNWCs7R
         KM4Q==
X-Gm-Message-State: AOAM530PtJKGemsM+srAxbV+trsslmeDLqwMKxE2JoyK6pPPc1GkYOWX
        cKP4/5UPerFfhE4loTHrt7rdaw==
X-Google-Smtp-Source: ABdhPJwyeUlHkQLfUvBsm+FtHgwXnv/mkoNFhffFzy6wwPlDenyeB8KbKE5eNDs51wIYqFOH/jy9Tw==
X-Received: by 2002:a17:906:1912:: with SMTP id a18mr4408704eje.117.1623330144006;
        Thu, 10 Jun 2021 06:02:24 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id f7sm1343080edd.5.2021.06.10.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 06:02:23 -0700 (PDT)
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Bruno Goncalves <bgoncalv@redhat.com>, linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
Date:   Thu, 10 Jun 2021 15:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 13.47, Bruno Goncalves wrote:
> Hello,
> 
> We've observed in some cases kernel panic when trying to boot on
> ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
> could be related to patch
> https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
> 

Thanks for the report. It's possible, but I'll need some help from you
to get more info.

First, can you send me the .config?

> 
> [    1.516075] wait_for_initramfs() called before rootfs_initcalls

This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
non-empty path (/sbin/hotplug perhaps). This did get reported once before:

https://lore.kernel.org/lkml/45556f52-cd2f-5512-ba65-81e4acee21ff@rasmusvillemoes.dk/

I think I should go and prepare a patch that moves the
usermodehelper_enable() call to after initramfs unpacking has been
initiated.

But until then, can you check if you do have UEVENT_HELPER_PATH set, and
if so, does changing it to the empty string make a change wrt this crash?


> [    1.559757] PCI: CLS 128 bytes, default 128
> [    1.560150] Trying to unpack rootfs image as initramfs...

OK, so now we got to populate_rootfs() and have kicked off a worker to
do the unpacking. Meanwhile, PID1 goes on to do other initcalls.

...

> [    1.764430] Initramfs unpacking failed: no cpio magic

Whoa, that's not good. Did something scramble over the initramfs memory
while it was being unpacked? It's been .2 seconds since the start of the
unpacking, so it's unlikely the very beginning of the initramfs is corrupt.

Can you try booting with initramfs_async=0 on the command line and see
if the kernel still crashes?

> [    1.766204] Freeing initrd memory: 18176K
...


> [    1.787649] Run /init as init process
> [    1.787793] Failed to execute /init (error -2)
> [    1.787801] Run /sbin/init as init process
> [    1.787842] Run /etc/init as init process
> [    1.787880] Run /bin/init as init process
> [    1.787921] Run /bin/sh as init process
> [    1.787978] Kernel panic - not syncing: No working init found.  Try

Yeah, well, this is expected when unpacking the initramfs failed.

So I think the problem is the "no cpio magic", i.e. the initramfs got
corrupted somehow. But I don't have any idea why that would happen -
freeing the initramfs memory only happens after unpacking is done
(naturally...).

Rasmus
