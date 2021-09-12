Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1823D407ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhILRHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILRHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 13:07:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:05:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b7so9025764iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLM/qMdzxceOUrX6oXopeVubbXjNKiq4kNF47n2hgmE=;
        b=FsZxfERYIM8U1yU21gKvztnQAGDhifbCdXvd/eWZvfA3yl3xfjfYdxns5LfOdPwKCV
         BBvODz7Ld2Jsy190Vg5t5plJCOqR12ZjW3lf+wfK3Pr8ftlU0bz5L3xLXkFYbl8It8In
         pfeIY4ojux8ipccpnMDAWxoHaJboDOowxQa5Q8TfjJtj7nWpeHI+ELOxEepPBIziOq6S
         6JrO6oMSKmhH7O3+k8OydPFcfTGLs6nyFnZSMtasNELvlgS8e7H1d+1vXxE3eM9EQD29
         N2Lpj2hVpzbZM1lIl21XByJhAkx/M39VBMmHeFTt3W97p1Q8/cMXIaCfC3Y4tbTWbiNF
         kZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLM/qMdzxceOUrX6oXopeVubbXjNKiq4kNF47n2hgmE=;
        b=tq/B/r8rBpPAD+iXzgWAa30a/zptduU3rR76r8rgMHXK69xTHAtY8Ta7DW0v2QxwUc
         Qt3n/maOYpoyzuVApzqaas5J9FD4VUF1G0vaqA7jYAFFqzkjxExfmDz/fpGWyckDdvMd
         xD/wvlZS+jV/2qNFV7isx71rg0wdXNgCPexDmOBDHbwCSpdWR3YdTv/4W+tu0d3NbtiT
         W65o0H6/Nblzbv6U9zobJRc3/WN4zIWsAMJcWZK6inkMYmO8ezEUGzSDmtAYPEX81oXF
         6ztQrTlnm65c3F76woJXK5q0yq8WnEiwHMsnk0ebvG57Otwq5ZjeBrnn9LcaikagS1j3
         gxJA==
X-Gm-Message-State: AOAM531WLFYGacThHLDXoep8Vy9KIm+vK18LNdT97l8uJVl3HSN34INJ
        DnEuRk2udEZ0Aos5w0anQP5E+G4Q0PEDcQ==
X-Google-Smtp-Source: ABdhPJw99yFVxvHeAk0qT0t0AfUdPQbQVfbyFGP62yJs1ajIgYc+mMBgsA7/honfxQY4Rk/VuYPn0A==
X-Received: by 2002:a02:aa17:: with SMTP id r23mr6241739jam.52.1631466356813;
        Sun, 12 Sep 2021 10:05:56 -0700 (PDT)
Received: from [192.168.10.11] ([172.58.141.119])
        by smtp.gmail.com with ESMTPSA id t14sm3142441ilu.67.2021.09.12.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 10:05:56 -0700 (PDT)
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, Daniel Palmer <daniel@0x0f.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
 <20210912015740.GJ13220@brightrain.aerifal.cx>
 <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <7a7d2e62-8a8a-0572-8f9f-beb95deeabc7@landley.net>
Date:   Sun, 12 Sep 2021 12:25:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/21 5:36 AM, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/12/21 03:57, Rich Felker wrote:
>> Hi. I see there's a situation that needs my attention here. I will
>> plan to review and merge anything important/blocking that doesn't have
>> problems this week.
> 
> I'm glad to here that you're still active. I will try to help assembling
> the list of patches. I won't be able to test them though as I'm not at
> home so I'm unable to reset the machine in case it crashes due to a bad
> kernel patch. So, basically, I just have one shot free.

I smoketest on qemu-system-sh4 first just because it's so convenient, then test
on my j-core (sh2+) turtle board because it's the next most convenient thing
(it's USB powered and one lives in my backpack).

>> At the same time, I am open to the possibility of a new maintainer or
>> co-maintainer if that ends up being what makes sense. Are there any
>> candidates?
> 
> I would generally be interested to help although I'm not as knowledgeable
> when it comes to low-level kernel development.

I'm in a similar position: I can put more cycles into this (and I've collected
patch stacks for Rich before), but I don't have the domain expertise to make
judgement calls about device tree representation, interrupt routing, nontrivial
lock ordering, knowing when you need a memory barrier and why...

(Also, I've been running up to 3 days behind on my email recently, and catching
up on weekends...)

Rob
