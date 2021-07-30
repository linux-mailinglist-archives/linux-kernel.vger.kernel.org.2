Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160433DBEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhG3TY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhG3TYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:24:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC0C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:24:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so5032232lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlZRTu+F0o6A8qh5wibGN8Kxtu6GVrlOQ+jra2A0ypw=;
        b=VphtNkf0G/ZxdbSdJpJzgxkywMFcq1UHxJnjZdCDE57WkxcLiIrN61VNPYQac5bOpk
         hzseshWLh8ffqXoaL+BdguaYgNlzWPDe5sacat3uwFxH2Xb3YxRGk8hwNauNLDtrOr1p
         KCX50L4qjXUnogsRN6IM9EICxclKNh4O3UxrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlZRTu+F0o6A8qh5wibGN8Kxtu6GVrlOQ+jra2A0ypw=;
        b=bNbEJEQ4or1YYibQ93gdrcuIzlM+WkvP3rEpo6ZzJGc3UO7LRRyFVpOaATd0E7VsqZ
         bos/SeY805Mm0BAryMlSser2LF8Lns6Mj0A+ttU5RUwdL1aVFdEHjcehHvv/mLFUeHAY
         y5JL50kNQSVrkHXXTHQUHFNUkgpjHk0yT5nvUqH8sekL+iVbZxU7rjDv8siyU85eRvqH
         WVllbxzExJDbDcSdVL3bCS7fzUpHxHNUlaVzb4H2zoZC/+bqSvY6MRi3VfPMKtoFGCFX
         MVU46l62aZXJ7m+cI6sP4EOoh0cRLI8KdHX25O6yHlEVWexnmN/Pjq4X6nZhcDZnBO5s
         GrIg==
X-Gm-Message-State: AOAM531vCHR4CzPqObyiS0NILt2/OICRbmoOUY1ConEsv18WgixnRMhf
        w/7jT/BgdANux9RM+7IlEX0vI7OWH6GKPMkO
X-Google-Smtp-Source: ABdhPJxmfBzX5LkcHP/Jcvuh/krqVC/splBcITtO2lVVwJ98X57LG7kNEeoeH4gAvdtVVPjcCIINoA==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr3004031lfp.393.1627673057268;
        Fri, 30 Jul 2021 12:24:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t30sm218119lfg.289.2021.07.30.12.24.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 12:24:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id r26so20003067lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:24:15 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr2853330lfv.201.1627673054956;
 Fri, 30 Jul 2021 12:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210729222635.2937453-1-sspatil@android.com> <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com> <cee514d6-8551-8838-6d61-098d04e226ca@android.com>
In-Reply-To: <cee514d6-8551-8838-6d61-098d04e226ca@android.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jul 2021 12:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
Message-ID: <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Sandeep Patil <sspatil@android.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:11 PM Sandeep Patil <sspatil@android.com> wrote:
>
> Yes, your patch fixes all apps on Android I can test that include this
> library.

Ok, thanks for checking.

> fwiw, the library seems to have been fixed. However, I am not sure
> how long it will be for all apps to take that update :(.

I wonder if I could make the wakeup logic do this only for the epollet case.

I'll have to think about it, but maybe I'll just apply that simple
patch. I dislike the pointless wakeups, and as long as the only case I
knew of was only a test of broken behavior, it was fine. But now that
you've reported actual application breakage, this is in the "real
regression" category, and so I'll fix it one way or the other.

And on the other hand I also have a slight preference towards your
patch simply because you did the work of finding this out, so you
should get the credit.

I'll mull it over a bit more, but whatever I'll do I'll do before rc4
and mark it for stable.

Thanks for testing,

                 Linus
