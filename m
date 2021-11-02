Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CE442F17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKBNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhKBNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635859820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7a9fwdqVobQq7YV4q5QN50HHW7MqP/6FfVQWJ5UuQoY=;
        b=fCRhbkVuNcLmm7etJwtECl5hZdtcbGgw+SbpSrurWh7+rH730Jptm0HeeJ8HqR/c4wknkS
        z9yoUQjEoa+Nz+j6AqU2MYPKUVLXzqxy9eaAxstvGkIYWyySQyT5ys6Q2yLpZ6clG0Zyr9
        hadPgqgmA9731J1T0VnzLReQjFa4Dhc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-mVP5lYPaORSHl8MtTXEiRg-1; Tue, 02 Nov 2021 09:30:19 -0400
X-MC-Unique: mVP5lYPaORSHl8MtTXEiRg-1
Received: by mail-ed1-f72.google.com with SMTP id w11-20020a05640234cb00b003e0cd525777so14125869edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7a9fwdqVobQq7YV4q5QN50HHW7MqP/6FfVQWJ5UuQoY=;
        b=S/hfY3Fa7900OiHXpeAoNUNnJZff3L2gI5HG6749cARXO3ebgmbHJa3y4MUNBWJHAJ
         YU4gxboM13pvPyeJxYreHRCv+UthzIGvh0VMzShZE5MMnrZN+qTjr8611A/lFTz41Q3R
         f1amA0WkkBxBoGoOOYbmJp3lvLN1cgAaFpqsUn/TLAX/VByOIE0Dc4mQSNUMhcwQ9f4E
         BG+L4OJFJAtlObNRM8X/IVAJNv6nWYtoQd5KfSePy/YvvnTOgNMQRJlydWOO9l1+Lv/+
         a8J2Oay+wfH4Pg/WsdC5SIr0x1yM+J3muoxW5IfLB1zQi0kmp57h6Z6N8ZxY0Mcu2iZh
         shug==
X-Gm-Message-State: AOAM532QndEoYyLqC8NUk8ODSk/qcGLJJg4s/au9B/PvFNNbf+nf6KHZ
        BDvHPbHWAZyYBLqARWsz25bYpPvKeyZqvV7wqhkgplFdYjrCPZb4h5lvCcdXCEYNbunutvINbSP
        wjaXgZ06HXZYwjkO9o4qFjCxD
X-Received: by 2002:a17:907:8a20:: with SMTP id sc32mr19224480ejc.65.1635859818367;
        Tue, 02 Nov 2021 06:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1KP4w7cRqQTgNk3Posz5punPXW0XvK5doe+IuPA7lypbSniV0SwOMyOUyhVgi2mIDO32HVw==
X-Received: by 2002:a17:907:8a20:: with SMTP id sc32mr19224458ejc.65.1635859818233;
        Tue, 02 Nov 2021 06:30:18 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id u16sm8178560ejy.16.2021.11.02.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:30:17 -0700 (PDT)
Date:   Tue, 2 Nov 2021 14:30:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keescook@chromium.org, kvalo@codeaurora.org,
        miriam.rachel.korenblit@intel.com
Subject: Re: [GIT PULL] Networking for 5.16
Message-ID: <YYE9Z3wUs9HqcqhV@krava>
References: <20211102054237.3307077-1-kuba@kernel.org>
 <CAHk-=wgdE6=ob5nF60GvRYAG24MKaJBGJf3jPufMe1k_UPBQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdE6=ob5nF60GvRYAG24MKaJBGJf3jPufMe1k_UPBQTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 06:20:35AM -0700, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 10:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-for-5.16
> 
> I get quite a lot of
> 
>     ./scripts/pahole-flags.sh: line 7: return: can only `return' from
> a function or sourced script
> 
> with this. Why didn't anybopdy else notice? It seems entirely bogus
> and presumably happens everywhere else too.
> 
> It's shell script. You don't "return" from it. You "exit" from it.
> 
> Grr.

ugh, sorry.. I'll send the fix shortly

jirka

> 
>                  Linus
> 

