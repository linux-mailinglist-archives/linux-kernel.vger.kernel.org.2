Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971E8431EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhJROFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233689AbhJROA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YS5xsAw9pqAnEXGHaWIRjYnoXsCfpfjBOib6An1+74c=;
        b=IUHwMWNs7e0Ojhti8gFYC1CQWvIBXZ4vzkxA9txGp0/F99VYh4hbwBv1eVW1akWGdU9iVo
        uuw+KwgHZGzl+I1a+wyRcRQiI9lQeTJ9aRcRxdd+ODJ39U0YdtWpsQosu4RIY8fSevRXBt
        QR43+Ui+y/NC6zrF5x28nVutYKQ1Rh0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-CNbpaJdrPkeF1p2Sn42jMw-1; Mon, 18 Oct 2021 09:58:42 -0400
X-MC-Unique: CNbpaJdrPkeF1p2Sn42jMw-1
Received: by mail-io1-f72.google.com with SMTP id d7-20020a056602228700b005ddba37de42so10676794iod.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 06:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YS5xsAw9pqAnEXGHaWIRjYnoXsCfpfjBOib6An1+74c=;
        b=RPyvbiYamGBxWBbk4kq3F4nJzSvd3N140pfdqt/udFEaJe/xUApheD2bRaw5KZcqbk
         GXwsmsw2n+nfk5o0Qc/YCi/X2RgZCXABUW3dvc/YxqP4LUPMMAvzwbQDkRtUu9OG3plH
         plQLB6KnCpB9+xkaMRwcLVDQLWR3hlULd8g7CkDcc15osYMT2YO24H9/l8AbtoIdwYWY
         pfiGRLhEYQWBqiwKJo5myC4bJfg6jl9B7qsR7WFxD4jr6pTDfCjon3IfOsAmM758/7i7
         /ujgFPStfoCHYBqoLb0nWvfTfoLmOmDQFXT0uL8GtMTJW0AW7/27VdkQS8qcpV6B93kZ
         jaHA==
X-Gm-Message-State: AOAM531y43ZDK5K/DwImkp5K/UHaFaO3IaHnCC6DVUS51KJSZKItM+kR
        xbexphqY6pyOFaLhxXkTCgXO81cCH6nwy1KOFByDn+zTNxZEPrgCd88g0LY7NnQjJn+hRA1GstZ
        Cv0Ms1z4CZieia3pCg1voE41b
X-Received: by 2002:a05:6638:15a:: with SMTP id y26mr18295363jao.84.1634565521907;
        Mon, 18 Oct 2021 06:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF+1no62r1IsLwCiZRtNJJKC5Mu8PP9xkALffJ6FBRLOuLoh3WVzk9gDBualyojlvF4A0ZCw==
X-Received: by 2002:a05:6638:15a:: with SMTP id y26mr18295341jao.84.1634565521544;
        Mon, 18 Oct 2021 06:58:41 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id r17sm7052380ile.40.2021.10.18.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 06:58:41 -0700 (PDT)
Date:   Mon, 18 Oct 2021 08:58:38 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c: silence some -Wunused-parameter warnings
Message-ID: <20211018135838.tdrjqsllozazqa7q@halaneylaptop>
References: <20210519162341.1275452-1-ahalaney@redhat.com>
 <20210519213731.fd8699098bf79bfd23c73090@linux-foundation.org>
 <20210520130330.hqejx2xw6kbdibil@halaneylaptop>
 <f06b8308-645b-031b-f9c6-b92400a269aa@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06b8308-645b-031b-f9c6-b92400a269aa@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:34:45AM +0200, Rasmus Villemoes wrote:
> On 20/05/2021 15.03, Andrew Halaney wrote:
> > On Wed, May 19, 2021 at 09:37:31PM -0700, Andrew Morton wrote:
> >> On Wed, 19 May 2021 11:23:41 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:
> >>
> 
> > If we decide we don't care about such warnings then feel free to ignore
> > this patch, but since I was playing around here anyways I thought I'd
> > clean it up a little. My preference would be to care, but the output is
> > so loud it is easy to make the argument that it is too late to start
> > caring.
> 
> Those always-unused annotations are quite verbose. Could we instead
> allow both int (*)(char *) and int (*)(void) functions via some macro
> magic, say extending __setup_param to something like (entirely untested)
> 
> #define __setup_param(str, unique_id, fn, early)                    \
>         static const char __setup_str_##unique_id[] __initconst     \
>                 __aligned(1) = str;                                 \
> +       static_assert(same_type(&fn, int (*)(char *)) || same_type(&fn,
> int (*)(void)));
>         static struct obs_kernel_param __setup_##unique_id          \
>                 __used __section(".init.setup")                     \
>                 __aligned(__alignof__(struct obs_kernel_param))     \
> -                = { __setup_str_##unique_id, fn, early }
> +                = { __setup_str_##unique_id, (int (*)(char *)fn, early }
> 
> That would still require modifying each callback, but then it would be
> to the more plain-C
> 
> int foo(void) // yeah, this doesn't use any parameters
> 
> I checked, the transparent_union trick doesn't work for static
> initialization.
> 
> But really, the compiler should have some heuristic that said "hm, ok,
> the address of this function was taken so it probably has that prototype
> because it has to be that way". I bet that would remove 90% of the
> Wunused-parameter noise.
> 
> Rasmus
> 

Sorry for the way late reply Rasmus, my spam filter has been flagging a
few things incorrectly and this was one.

I'll be completely honest, both the macro magic and teaching the
compiler are things I'm not familiar with. If I get some free
time I'll look more into the macro magic approach to see if anything is
possible, but I wouldn't hold your breath for a speedy update :P

Thanks,
Andrew

