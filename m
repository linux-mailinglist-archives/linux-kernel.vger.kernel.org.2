Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949B42CD42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhJMWHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhJMWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634162725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QpPT8JA8abmHcouNfWzYUUf2C/UgkKSHsziTQZmI0JY=;
        b=Ul5fTfHZE2HYtWIFOTu3/Kw9zp8r+H8ur9Jck8/7OACpMKNvaUYh1S9sjIOWVR80sYz/Xc
        lMF121TcfPQWv1MWcnO/dT8Hv1GznXkH/sinOsBB+Wa3EQYW7RS2RL6VcZ1hXOJi/mnQZx
        S+qVK4An14fJMkVBkSYEmIKYlvTE1RM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-OiG8PG_JM8--3p8ThRxG0A-1; Wed, 13 Oct 2021 18:05:24 -0400
X-MC-Unique: OiG8PG_JM8--3p8ThRxG0A-1
Received: by mail-qv1-f69.google.com with SMTP id gw8-20020a0562140f0800b0038366347de1so3862639qvb.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpPT8JA8abmHcouNfWzYUUf2C/UgkKSHsziTQZmI0JY=;
        b=jy4rFbNDnOkAjq5lZOrSqqicZ8Crp/ZvXXqoGHIelA1vwuWEZzFpZK1F7VzcE4KWHC
         l/4RzcOMx7tMXLiHSDtPpDvipCA5stlSJcRDB93jHBzxUSivruLCIqysTbEqfKR+yAuK
         ufwNnvRxlx6GIQpOTvjcl100OT6lUVJT7jjhAgHdjhlhkEhtjMCDb3jAiXbU6WFYKSZL
         NY25cnI1AZNc+f17RHVVJOVgXWNL8oMQIgMsmo+YlQz31UEO9mgZIZt4UCu0ldlrUBIJ
         Ny0WYOZu0MmiGwqMtLqd2lxXzUTdIb6zumHxZrxmzwQAvfQbr8GEqaiRYfEmWHZf24CL
         GtcQ==
X-Gm-Message-State: AOAM530bvr1/wuK1AeJ07UrAyVYP66Q5M0T+nYEJYXV2FC/pvCBKxXqI
        tRIepBUYL34aY1SpyA6AS+ndZkSQqMLLxRdZ11kncQ8Cb+hYAKncWXAd7jKCjR7Zcy+EtXVufmt
        UtLAE827TaTH/vghSM1bHkW0j
X-Received: by 2002:a05:620a:24ce:: with SMTP id m14mr908907qkn.212.1634162723599;
        Wed, 13 Oct 2021 15:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE7mbcXsZagTjJsOL1NtfkwWKPhD8LeM7ki4jrd5eHLQyr9YOyO1M9RGaQKOV2sq+8UKLdsw==
X-Received: by 2002:a05:620a:24ce:: with SMTP id m14mr908891qkn.212.1634162723394;
        Wed, 13 Oct 2021 15:05:23 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z5sm479353qkd.103.2021.10.13.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:05:23 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:05:20 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013220520.xzsp5q2amuwy6n6o@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013211118.apsj66c6b6abubeo@treble>
 <YWdTDz8Qqs3jjCf1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWdTDz8Qqs3jjCf1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:43:43PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 02:11:18PM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > +#ifdef CONFIG_X86_64
> > > +
> > > +/*
> > > + * CALL/JMP *%\reg
> > > + */
> > > +static int emit_indirect(int op, int reg, u8 *bytes)
> > 
> > X86_64 is already equivalent to STACK_VALIDATION these days, but might
> > as well clarify here where the retpoline_sites dependency comes from by
> > changing this to '#ifdef CONFIG_STACK_VALIDATION'.
> 
> Yeah, I was contemplating having x86_64 unconditionally select that.
> Maybe we should.

As far as I can tell, it already does that:

        select HAVE_STACK_VALIDATION            if X86_64
        select HAVE_STATIC_CALL_INLINE          if HAVE_STACK_VALIDATION
        select STACK_VALIDATION                 if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)

> Also, I think I've proposed it before, but what about:
> 
>  s/STACK_VALIDATION/OBJTOOL/
> 
> on all that?

How about keeping STACK_VALIDATION, but then having it depend on
OBJTOOL, in case anybody cares to extricate the two at some point.  Some
objtool features (like this one) don't rely on the full validation.

-- 
Josh

