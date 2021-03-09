Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0607C33315E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhCIWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:07:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139EDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 14:07:56 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k12so22857604ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnLCWqIqy0lDlxCw6e8PHlWeH2Vh57fNhd7kauIIeiU=;
        b=TEkIAHDc6BIOqsFC86sOh2ibewl48ClOu8B8xM1GRaBXzj7QrGDGCUvLgNHqScWIJx
         Lm1dSgcQeC45BerB5txWSAheU+W88XHLrQB9Jk5zT05KHACvGEJ444EGBP9YtQ1XD+I8
         2AnZOsdrR2KmI/y7up2YjkyVgFIB47NPkJAAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnLCWqIqy0lDlxCw6e8PHlWeH2Vh57fNhd7kauIIeiU=;
        b=sbN4JQY9Hcja5n52boOBCbrmek0iAL7oHpaHK0FSjvKaIydkQJzaOuWelSi/yNG6Y9
         zpLNmRrPjfkXIzyrRPp6oj9ISquFQZWaClSkLyWOIyqQfMu0ZxMHRtNBsqz14K+Lf6Vm
         KsIv6TZl6BU3GDPJWG0QGBSt8W/zAtJD94CYT19Bt3JXSEHBvdgBjwHrx8qH2hOB4EVR
         x0X/mBLEj+abN0amUURU8yiNU40J95+Bvekr5WVuy9/VGq4Qq2BTAJiyplY+AjwTe7KE
         HXGM4iNdlWejUbfEG8wASTpyGzMwNDZSfq5oLQHVz4pgvpmYGsiPTGoVWQwqab5WfF2f
         bJpQ==
X-Gm-Message-State: AOAM533s2jWvawnLjpjwJXAOECrFw4IpaNd7+rO3Z0ebgN8za3vEwkId
        8jnLFT8Vd2n0Iutso/HHw7kG9bZhISjPzA==
X-Google-Smtp-Source: ABdhPJyFsWKvJJ5QhU1ydoEdO3A/IWoYblYDpgbnvKOjX8n8e4BDOk4OTpDpAiVgKc8l00p2EkvtrQ==
X-Received: by 2002:a2e:6a15:: with SMTP id f21mr18512551ljc.9.1615327674076;
        Tue, 09 Mar 2021 14:07:54 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d13sm1362918lfi.247.2021.03.09.14.07.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:07:52 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id t9so22857960ljt.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 14:07:52 -0800 (PST)
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr17672507ljo.411.1615327672300;
 Tue, 09 Mar 2021 14:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk> <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 14:07:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
Message-ID: <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> So add an initramfs_async= kernel parameter, allowing the main init
> process to proceed to handling device_initcall()s without waiting for
> populate_rootfs() to finish.

I like this smaller second version of the patch, but am wondering why
we even need the parameter.

It sounds mostly like a "maybe I didn't think of all cases" thing -
and one that will mean that this code will not see a lot of actual
test coverage..

And because of the lack of test coverage, I'd rather reverse the
meaning, and have the async case on by default (without even the
Kconfig option), and have the kernel command line purely as a "oops,
it's buggy, easy to ask people to test if this is what ails them".

What *can* happen early boot outside of firmware loading and usermodehelpers?

Hmm?

              Linus
