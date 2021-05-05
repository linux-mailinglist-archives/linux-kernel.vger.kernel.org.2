Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240F3741D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhEEQl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235013AbhEEQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620232654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uv6HWPPhcIJ6ztPfM9ijF0feEKmq6v7oLGoMt+LIy08=;
        b=JOisa8vukfFzW9xY/I7uW7y6uSbcpnBJNPuCQbDc+L9YZd2TMjCgC+tM+c0VN9lrIVBBlL
        XgHZmuRvi9GUrFTeHWN4kqRSP0Q1ABbH4ZSr3bXi8CxCMqM5XWWBLmcwGcF4JyFjLf7JQP
        X0QUAZ6mxK5C6LvS4XaAZMro6jisi4I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-pKsv5c0EMzyLouCAqQQluA-1; Wed, 05 May 2021 12:37:33 -0400
X-MC-Unique: pKsv5c0EMzyLouCAqQQluA-1
Received: by mail-qk1-f198.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso1562195qkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uv6HWPPhcIJ6ztPfM9ijF0feEKmq6v7oLGoMt+LIy08=;
        b=EcyWbMI7fU6J03Koc795jHoCOfRDFQ2dzpiYw0QZL0XrjwysVlvSSZerZY7LIGUJQI
         YKNhGAxzm/1Jj14y1lTJCAHNbBSTm8xI0WwVKQEMMY2lorIp7e4lzAowOD9dLP8xOu+g
         BfaTgMM3+fxUYbNxEYW+qCihc6cNHeOHfC/LVf0QEOvf1Net2dysawt+ZHzDZ7okuNVu
         MXS4SPO5y1/zXNt//5ruWs+DolEqM/aVhxiIH4aDp8HYkEsXJa5qJXjUo1xiX941lroL
         gCypgyCfPlsIYsRRdSeCLRM/DvhLM2FkfPhsufx/pXQs0wShPBGCnC/ca4DbfTi31+fj
         v3jA==
X-Gm-Message-State: AOAM531Oyd7LBtoS8EHFsaTOpKBUd/J39aCABt3JM0NUVHVlyKwPQMP+
        wHott4vGek9fuDzaEqm81jeiayTIwsRXC0qJir9hWNkop0UjnCEYCopk/prmJo1MYGTezyoTYwb
        E00lO7xU9WQYxX8LQQ/bve9iF
X-Received: by 2002:ac8:7f41:: with SMTP id g1mr29255144qtk.72.1620232652608;
        Wed, 05 May 2021 09:37:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrcAGLv8WxV3azQAcAZsJeSvdYLnF1uJcmyEeAAjFNrI5+JPUv9Rt3mtONlR7nb+Vgneyr0w==
X-Received: by 2002:ac8:7f41:: with SMTP id g1mr29255128qtk.72.1620232652417;
        Wed, 05 May 2021 09:37:32 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v65sm14451566qkc.125.2021.05.05.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 09:37:32 -0700 (PDT)
Date:   Wed, 5 May 2021 11:37:28 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <20210505163728.oh7rqpdvxrdilmfk@halaneylaptop>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
 <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
 <YJKpv6vjCcCkbzNT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKpv6vjCcCkbzNT@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 04:20:47PM +0200, Borislav Petkov wrote:
> On Tue, May 04, 2021 at 10:26:14AM -0500, Andrew Halaney wrote:
> > Definitely a matter of opinion, but with the kernel having specific
> > ways to denote init destined parameters (anything after "--") I think
> > an unconditional message is acceptable.
> 
> Or - and I had alluded to that on IRC - you *actually* know which params
> are kernel params:
> 
> #define __setup_param(str, unique_id, fn, early)                        \
>         static const char __setup_str_##unique_id[] __initconst         \
>                 __aligned(1) = str;                                     \
>         static struct obs_kernel_param __setup_##unique_id              \
>                 __used __section(".init.setup")                         \
> 				^^^^^^^^^^^^^^^^^^
> 
>                 __aligned(__alignof__(struct obs_kernel_param))         \
>                 = { __setup_str_##unique_id, fn, early }
> 
> 
> all those guys in the above section.
I actually did use that recommendation essentially, the patch I've sent
is riding on the work done by unknown_bootoption() which is populated by
iterating over over the different sections parameters can live in - so
this is only printing out arguments that didn't match a known kernel
parameter. Sorry if I didn't make that clear earlier, definitely was
trying to listen to your advice.

> 
> So you'd have iterate over those and do some cheap version of those
> autocorrect algorithms which guess which words you meant. For example,
> if you have:
> 
> panik_on_oops instead of
> panic_on_oops
> 
> the difference is one letter so it is likely a mistyped param rather
> than something which goes to init or other random garbage and then you
> warn.
> 
> Something like that.
> 
> It would need a lot of experimentation first, though, to see whether
> this makes sense and it is workable at all.
I'll have to think about this some more (the "did you mean this
parameter" part).. that seems like it might be more trouble than it is
worth, but I admittedly haven't looked into those cheap algorithms you
mentioned yet. The reason I say it might be more trouble than it is
worth is because it is easy to say "why didn't my param work", then grep
for it in dmesg and find it in the "Unknown command line parameters"
list - that's sort of the workflow I imagined would happen when someone
mucks with their kernel cli and doesn't get the intended result.

Thanks,
Andrew

