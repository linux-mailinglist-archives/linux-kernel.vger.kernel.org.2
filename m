Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9B33C8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhCOWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhCOV7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:59:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4152C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:59:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so68829793ejy.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGASx9m/DjoWGLK/gBk7YWodmyiJN6OqoYf2dnqX1Z4=;
        b=bO3agdBd9e48EifUMo/g7nwum9w1UyCtqIutWEbPQ7O6UGH2CdXKvWcE+R2AJk32ba
         UAYziKq+qZveMT2FpolenYkOIZEf/IuxDUlsW/tNdRKZeteaEMYh2rYQmk4rbqDE7SnI
         J7E2qCDyzp/Z5i/YeWk20NTe3n8gCfesgTo6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGASx9m/DjoWGLK/gBk7YWodmyiJN6OqoYf2dnqX1Z4=;
        b=uZ4EbEKX/6HCTRo8UpL2xXGDp043hm9YNavdXT+cRiJd8n4Sz8KyNT4RZwGqPclfT+
         5VhuRhetJDxRaTnH9m1k0/IFBFS05mGoXDr0xjAjqTk50UJD19UmO4IHKp0SFx7n/RRc
         1U30DIHIMk81WZBhG8XNMupTetcHAcO9yEwgDwTaT9WiIndUaobSPsX6rsxOwGGoiyGz
         Yb/5iVOCXwuo3xebX/c8nY2WoIX2CA7RD+RcMV5UvnRqScxltd/tY3uAdyPE+pMxo3vH
         6ASiqyMzFC9keAEszOGmD4QKXSUuAPfM9z6rXjBL7q7DvqYkP1DS9yopuh6JSScRH2uL
         moKw==
X-Gm-Message-State: AOAM533/uPlUlqNgxGKKHfYl3BFsb0yCa+ddRVofjpcAzZ4Nrr0bX5gN
        7b0aKjWja3qmo8V0DnK+n2RhoA==
X-Google-Smtp-Source: ABdhPJx0peqQ7fM8yZQJfHIX+329n8WiXeT9y1Rvd8Ovg+JUJnKFdAh7NnRt4tzsBDStBdQiVTKtTw==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr26329986ejf.25.1615845593530;
        Mon, 15 Mar 2021 14:59:53 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id w18sm8218137ejn.23.2021.03.15.14.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 14:59:53 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
 <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
 <20210315143356.ce87a0be2b4b2a273d6c49b9@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5ae69ecb-7f1a-c10b-5f5f-db3ee47dc059@rasmusvillemoes.dk>
Date:   Mon, 15 Mar 2021 22:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315143356.ce87a0be2b4b2a273d6c49b9@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2021 22.33, Andrew Morton wrote:
> On Sat, 13 Mar 2021 22:25:27 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> Most of the boot process doesn't actually need anything from the
>> initramfs, until of course PID1 is to be executed. So instead of doing
>> the decompressing and populating of the initramfs synchronously in
>> populate_rootfs() itself, push that off to a worker thread.
[...]
> 
> This seems sensible.  And nice.

Thanks.

> Are you sure that you've found all the code paths that require that
> initramfs be ready?  You have one in init/main, one in the bowels of
> the firmware loader and one in UML.  How do we know that there are no
> other such places?

No, I don't _know_ that I've found all such places, but nobody, Linus
included, have been able to come up with any that I've missed. At this
point, the only way to figure it out is to get the code into linux-next
(and the more time it gets before the merge window, the better). Since
it's default-on, it should get quite a bit of testing that way.

> Also, all this doesn't buy anything for uniprocessor machines.  Is
> there a simple way of making it all go away if !CONFIG_SMP?

It absolutely does buy something for UP, at least for some special case:
The ppc machine I'm talking about is UP, and without getting the
initramfs unpacking pushed to the background, the machine doesn't get to
pet the external hardware watchdog soon enough. So this is really the
difference between booting successfully or being a power-consuming paper
weight. Also, lots of device initialization actually makes the CPU
twiddle its thumbs now and then, so having something other than the idle
thread to schedule makes better use of the single CPU.

Rasmus
