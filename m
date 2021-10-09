Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90669427CD7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhJISx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJISxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:53:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFCFC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:51:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so40601269wrb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VCc9tVN0bimsXAN1i1G3f40eNdkJ2+q6unaQMhwPUIU=;
        b=W0oNPxVkpsrGSfx1h58uvX5vysNlUfVyA1vSY1KYKqY4Y8g1YQI6MfGSDCTTbyCL6+
         q0TgYAlnrlrl5tL12ZigqlFqsH+eSt0xD0nOyFPSnO/xIZB8N3RcWzHgwWwzxkl+gUmx
         rX76J61T38nsA8MmcuNI27LhU6l4dRBukABg4oI/RIckb+Rv/hZ9ZgweplpG4+OWSxpO
         4gS0POQ+rxUzyjFLTV/MmaOToXT7A099W1j3M6+fKKEDGiB/niur/sNjuTAniNflp+1O
         0Us/AhZ2nsxmEH1cFyPFqofN78BarimsXhSB/IVKLEkMntIcQ4NLp5/X0JXVi6QXj0dc
         XFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCc9tVN0bimsXAN1i1G3f40eNdkJ2+q6unaQMhwPUIU=;
        b=2dEzm3LapQpoeCZ0WMa382A8BsrqfrvAGzDO021DrMoOqHlkm7zyefRSVsptWKmlG5
         MrcOY1Ii1qV6m3qw8nCwWxatnuli4NN8WcUCZcTLEnSxdIVG5Sy0LYndx+IoRIyIp+tC
         qP27RjGCWJUfcCCRhHGAXdBAq4anR9hXRQ+Japo5jbWeueuiOu3BuUuEBbkGP6x2yojj
         HZBheXcBG1K7ea54x6X/PXP2usFBN4wuI9ZWVX7R40X/1Om19nr0pEfowxPHtmAOlFmi
         PzuecWX5Guoh2meNCIIHXuNJfCrH1n3/4dqvLN5LyBU2lCdqVrVybK6UY0RkjhiGn25u
         rZvg==
X-Gm-Message-State: AOAM531dubPknqlyklMzMAgwHvAd5GwHlm+tgpZfPzzbHXraxaco3dDK
        wkaIMdQWthJbpumiFKnYuzz6eaM3s78=
X-Google-Smtp-Source: ABdhPJy8xVz3AhQO3tiNYz07sIYHOQwgefy5H1VQ6PLDu4C9XkTFxyO3bA50h5uqXDh+WkkmAArWsQ==
X-Received: by 2002:adf:f386:: with SMTP id m6mr13169066wro.187.1633805486930;
        Sat, 09 Oct 2021 11:51:26 -0700 (PDT)
Received: from [10.8.0.10] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id r27sm2883052wrr.70.2021.10.09.11.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 11:51:26 -0700 (PDT)
Subject: Re: [Bug 214661] New: THREAD_SIZE on x86_64 is 4*PAGE_SIZE, not
 2*PAGE_SIZE
To:     bugzilla-daemon@bugzilla.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bug-214661-216477@https.bugzilla.kernel.org/>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <3078967c-cde6-198f-4c2d-66a635a622c1@gmail.com>
Date:   Sat, 9 Oct 2021 20:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bug-214661-216477@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC += LKML

Hello,

On 10/9/21 7:19 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214661
> 
>              Bug ID: 214661
>             Summary: THREAD_SIZE on x86_64 is 4*PAGE_SIZE, not 2*PAGE_SIZE
>             Product: Documentation
>             Version: unspecified
>            Hardware: All
>                  OS: Linux
>              Status: NEW
>            Severity: normal
>            Priority: P1
>           Component: man-pages

This is incorrect.

The internal kernel documentation is not part of the man-pages.
I checked to see if the manual pages need an update, but I couldn't find 
anything about THREAD_SIZE:

alx@sqli:~/src/linux/man-pages$ grep -rn THREAD_SIZE
alx@sqli:~/src/linux/man-pages$

I can't edit the component, so maybe you need to close the bug and open 
a new one in a different component.

Anyway, thanks for the report!

Alex


>            Assignee: documentation_man-pages@kernel-bugs.osdl.org
>            Reporter: me@ieevee.com
>          Regression: No
> 
> According to '/root/linux/arch/x86/include/asm/page_64_types.h', THREAD_SIZE on
> x86_64 now is 4*PAGE_SIZE:
> 
> #ifdef CONFIG_KASAN
> #define KASAN_STACK_ORDER 1
> #else
> #define KASAN_STACK_ORDER 0
> #endif
> 
> #define THREAD_SIZE_ORDER       (2 + KASAN_STACK_ORDER)
> #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
> 
> However, the Documentation/x86/kernel-stacks.rst shows that THREAD_SIZE on
> x86_64 is 2*PAGE_SIZE:
> 
> Like all other architectures, x86_64 has a kernel stack for every
> active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
> 
> I am not quite sure which is correct, Maybe the document needs an upgrade?
> Thanks a lot for any reply.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
