Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412F3B4D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFZGn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 02:43:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC07C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:41:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i94so13203688wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dVgzgypy3I4vyZa0CC1LNit8ZRjGCA/6UvyisA1I/pA=;
        b=bWZ+08uRS0bqS9b2VzHhkNwZZC2wRFzwatNGEemyWd0YCXdj7bIA8VXm+0RecadiR5
         uOKI0/qEvKEAvdDgfRsFnY24d/kWrgW8u7gFD0IzBScuoFrP77uthKLaUHMzWF7SuMMf
         F0CoXy8X3TLbS57RQnSIqeNISejt88v+vNa+dLqLg1T5qGKCQ7hze25GQdAFm1KnaQ9x
         rpL46/N66bbL7pLwK0KZEED7149lun4ckAld22NvlIsTHmgngTxP9ng725L/sdSfwOzd
         iPsLtUTRlg9eov4XaamghjFIjX9EUqqSoXzTgwg8zJnufGnLKXdd7JP7G6rO3In8Tctw
         qCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dVgzgypy3I4vyZa0CC1LNit8ZRjGCA/6UvyisA1I/pA=;
        b=VOPzP542HqwLc9E3nd993egXGv+m+b5a8BMUlwXmC5/cXpxZB2ijsGP0UaVgTLAG3p
         w2p40CPlbLUJP5n4Yay/CshvHi02MNQ+jmRVGqhgmvWdBDq7/E7WH0lWUWy7WgzRC+FT
         3NqShlUYG4cGGXgdzBwkYvMbiV8eGDbXdvds5N+8CfJOIGAblw7r9Fe78NZmijbHIK6N
         oFqaU08/MA5pGjIMNOhDByVR/uf6dQJb4Y5jtND5guzP6aBOzxtS0ezFa/1420T0YiWl
         kbNW3oSdOFpOcOdEaJ+AbUNcp8ysPzJU7p9XxLzIpPbyN1r8l+CYkVu24KVMIm0ZVcQT
         vFHA==
X-Gm-Message-State: AOAM532YKf4ERbCelqUKCtw+YDKEzNBooKNuWiO1pW8/9rwgdddGI1GM
        SK5dTIryDiuMqHjnAhCRaA==
X-Google-Smtp-Source: ABdhPJxlwUTojDCVu47mmZ5677O02+ro0CJn2raWLIG82Xd2VgaqoRtU/dCxze6pXelV1AiIO3eIvw==
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr15518937wrs.45.1624689661925;
        Fri, 25 Jun 2021 23:41:01 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.84])
        by smtp.gmail.com with ESMTPSA id s1sm13350194wmj.8.2021.06.25.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:41:01 -0700 (PDT)
Date:   Sat, 26 Jun 2021 09:40:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
Message-ID: <YNbL+2dIVeZlNo6V@localhost.localdomain>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
 <YNZG6N0W/7gjG7Gm@localhost.localdomain>
 <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 04:30:40PM -0700, Andrew Morton wrote:
> On Sat, 26 Jun 2021 00:13:12 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Last write to the "error" variable in load_elf_binary() is dead write.
> > 
> > Add and use SUPPRESS_WARN_UNUSED_RESULT macro to express intent better.
> > 
> > Credit goes to Ed Catmur:
> > 
> > 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
> > 
> > Macro doesn't work for WUR functions returning structures and unions,
> > but it will work when gcc copies clang.
> > 
> > ...
> >

> >  #define __must_check                    __attribute__((__warn_unused_result__))
> > +/*
> > + * "(void)" is enough for clang but not for gcc.
> > + */
> > +#define SUPPRESS_WARN_UNUSED_RESULT	(void)!
> 
> That macro is rather ugly.  Hopefully we won't really need it - how
> many such sites are there in a full kernel build anyway?

I don't know really. And they're hard to find because "(void)" doesn't
work and not everything is marked as WUR.

copy_from_user/copy_to_user are WUR but get_user/put_user aren't.
Logically they should bed. And if put_user() is WUR then I know another
place inside fork:

	        if (clone_flags & CLONE_PARENT_SETTID)
	                put_user(nr, args->parent_tid);
