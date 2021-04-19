Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9C363968
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhDSCdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhDSCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:33:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1FC06174A;
        Sun, 18 Apr 2021 19:33:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f17so46515597lfu.7;
        Sun, 18 Apr 2021 19:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QEpzdjP4dphABYnhH7gyCbErJK9GWvUa5xb2cIfPbw=;
        b=fQbvjGw8VFQ8QHd4ioKUeh1wiw0z+lal35xuB8hLmq6pbO1S5cGM0jYicoDaKDTw0E
         iG+hbr+tk4Vg57Yu2Q7I1uHnVkgyaF6r3m1uHljTWfRah0xnVQpiXgKVKHeTwt4j0+3v
         EyqRGi8eJVbyAeP9dU+RSIQM8nTjctiyXghWaKZOMUmC+a8BkRN+enHz7eqa8L947Ne3
         qraOchfqEoJgUcBWFu++3OqQzabl8dH8khxQqcD7jVv30Hzx5ELXp7mtNfHOZSWMZtzG
         Hb2zoXuvTYGAJeemt0F6ASNXtaleYxyppdAndjmt1wAHBisH6hA1fGLkrrtzLvql2PqX
         BABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QEpzdjP4dphABYnhH7gyCbErJK9GWvUa5xb2cIfPbw=;
        b=VmXutwHGl33QHMHvAR3HBDXN9a/9F+WdoZQa3V6Xz/7MlkmKOQh9grxJFRB7TTPGl8
         Xh7KgFy8gx21I5UzZ5ekm2XHvMYFc01qbbHZs23//xc/9z0ay/kRgoOPtW2NVOGH9t/l
         NrNjZDaf6SEildNUwy9gsE6ENRUFB+twE3iGJ8anAgxjmJMUeNjtHZj4VR58Gfwsw5lW
         taNXDnDkavTofv8Kkkm2WxehrLpQNIEfiU9Mckcue0uj9Sfm2B/q0szLh1xNRo4MG8xl
         OQMu2Iy9zrZGWCG8G6zMvc+D9LnYWh+8Pr0y/YISiR1iaJjTsMJ3l4FQUANaMvMam28d
         fdWg==
X-Gm-Message-State: AOAM533qpbawc27uxe5aZDPqXtbjaNP+pPqkpazQzJQG8QYxaBve34mF
        zVgCe/g/qRbw6CZFzzoCeAN4Yplh9gLcF0MyMjRPckkVD0/RLw==
X-Google-Smtp-Source: ABdhPJyS8sHvEvUtqYrKCrrKl7/7zFP4Js/oTDdprUXoYh2KnPWDm0KitzHk/S+q9BhiKXRy5RZpuysN7DDMEI4hwQw=
X-Received: by 2002:a19:818d:: with SMTP id c135mr10430713lfd.349.1618799591584;
 Sun, 18 Apr 2021 19:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210316054727.25655-1-foxhlchen@gmail.com> <20210316054727.25655-2-foxhlchen@gmail.com>
 <20210419021730.GV2531743@casper.infradead.org>
In-Reply-To: <20210419021730.GV2531743@casper.infradead.org>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 10:33:00 +0800
Message-ID: <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Neil Brown <neilb@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 16, 2021 at 01:47:16PM +0800, Fox Chen wrote:
> > -In the absence of symbolic links, ``walk_component()`` creates a new
> > +As the last step of ``walk_component()``, ``step_into()`` will be called either
>
> You can drop ``..`` from around function named which are followed with
> ().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> marks them up automatically.
>

Got it, thanks for letting me know. But I will still use them in this
patch series to keep consistency with the remaining parts of the
document.


thanks,
fox
