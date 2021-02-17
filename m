Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6031E14F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhBQVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhBQVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:24:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:23:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a207so5270614wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t38IBDiln8jFDPKpINqSVjOUz/xfYh58FCdxyOqAKEc=;
        b=BCltraG2s2ema6giKHCDQko+FfZRmoVHUbGvqbG+JZXC9sM1J71Qz/xhJOm81KHt8F
         Itr1Tpk/9ZOUzPOUpMLPYL8OQwtPSbpPuaZsA7UOnkw75yD9qqsjtGq4eFahRSso146A
         +VE7h+wAtksBGgoSo9DXtsV/nZYreL52v+dsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t38IBDiln8jFDPKpINqSVjOUz/xfYh58FCdxyOqAKEc=;
        b=nyCQllVyiGnP83gPGPU3a8vw43Amtqymt3k/ni3I66OshmvC/2Pl3z6o5N+RBXpFZx
         sw73MqFc7+O29WWKsJUe40BcyXNuBsaICgV6Ysk9QBczafXKJhaXHNAl1zTY9cqJyuy0
         NjhAQ5pEEK2eYvXqhttPfMgCO7oWP2INkSYWgoN+OW4lhgz7cLfyEkucWpdEGsmtuFLr
         mab2u0l75oUJOBXKvYRG1A55JQeUoGFCqxEs4KJduAFYG/4wHT3BaKym/k4otG6QjrzU
         ipescELcZ6ZIEx5u4xN707lMTGZ/BN+xNoXS7xsuT6couQVVfvRHf/WlbG4+5zlmjSpZ
         MxjQ==
X-Gm-Message-State: AOAM531/FDqzHjQYjPgLQh9C/GztrY+aGWgvXU6UpjoPuG6G2ek9R+AW
        SvA60D4/xqn/Sf3IPm+35UgaJQ==
X-Google-Smtp-Source: ABdhPJyDHtG+qY2qJkjZDzMhXM5NYtB/BM1HaG+mbM/XjjhPuxQP/5SWsVF5/hvqtHVD/7X9AlJhkA==
X-Received: by 2002:a05:600c:2184:: with SMTP id e4mr643618wme.107.1613597036649;
        Wed, 17 Feb 2021 13:23:56 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f7e9])
        by smtp.gmail.com with ESMTPSA id f20sm5496817wrd.96.2021.02.17.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:23:56 -0800 (PST)
Date:   Wed, 17 Feb 2021 21:23:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: output: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC2Ja3DjKd/PFYKg@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvqdrBc3wLDClhv@alley>
 <YCv4V5EFeuEmyxSz@chrisdown.name>
 <YC0n3vRO788sXqud@alley>
 <YC02GBghuhmlvrXk@chrisdown.name>
 <20210217141717.52089bbc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210217141717.52089bbc@gandalf.local.home>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:
>OK, now do the same in C. "%q" "and I guess that "f" in the print statement
>in python (but I don't know for sure) does some magic with converting the
>"\n" and such.
>
>I agree with Petr on this. Print the format itself, and not what is
>converted. It's much easier to convert "\t" and such to what they mean,
>than to go the other way around.

To be clear, you're advocating for escaping tabs/newlines/etc on the kernel 
side, right?

That seems to be implied by your first paragraph, but "print the format itself 
and not what is converted" sounds like the opposite of that to me. I assume 
your meaning is "escape the format, don't print it raw", which is what Petr was 
also advocating for? :-)
