Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDFE402204
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhIGBNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 21:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhIGBNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 21:13:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03798C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 18:12:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j12so13830399ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buovdfuVwAYJ1wdL40xpZvGrNDWI2KNqFgBPmPDh630=;
        b=fuQfTafv4uneL2AzwltGo4ZWCS3xmlXhvTfaWdXPcpqErjQyMz3g6ew9quCkVeUZdR
         X0gHcxtFLBJg+SYSmchrwATm1Xb1uxbZjxVz/87MUSvQntnDeHgJkbIMmJCgDwCX/vPJ
         0YlupHDDkh2Qz5u75srCW2zHTRG5msU6vsIYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buovdfuVwAYJ1wdL40xpZvGrNDWI2KNqFgBPmPDh630=;
        b=ec9+lVBRY3Yxpv7Tfmd0VKFovS81m9J0cKEwDyzjLmxGIX0p8bRNi4JtFecxDthVZG
         NR4W2LHdWsVqeOPe2nYvnucbL09m3dPgUsVwNSIad5mXgFqLKtXU6C3pdXD2J25teOTI
         iCehynJHJFA7szCeq6D8cmjzKWQe2sm0hxFUzGoL7R2mlhl6HriibzGwoINHGSLeBHmr
         FXitWYx+MjonaFeLUW3ePiD4tKUalC76Gag4aGoHu8JAbxH7rT9SiUOiYGHF75DG63pO
         t+hXRfOpvuGNEaPkCKiO/p3ZApTQNGpTAOhUWrJOe6wG8nd0M64617CWDasz4IEQU5cD
         rlGA==
X-Gm-Message-State: AOAM5314CU/AUjZiPeqHQ84GAITcMI8ngJdULL7ns7CdfZs+/yFXEbU/
        Q5RElhyp4RPrnRZ9I5zpecaZ0I/aIWZHrbpM
X-Google-Smtp-Source: ABdhPJyRGjOwIiNIHMDFIeRXF58jbO/Fmx3NO5EeMxDmC1PitYkm21K9wRNLQNdTQex9Rw7towthfw==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr12878748ljn.267.1630977143467;
        Mon, 06 Sep 2021 18:12:23 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l22sm858278lfc.218.2021.09.06.18.12.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 18:12:23 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id p15so13897482ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 18:12:22 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr12459242ljn.56.1630977142525;
 Mon, 06 Sep 2021 18:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
In-Reply-To: <20210906234921.GA1394069@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 18:12:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
Message-ID: <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > but I'm not seeing why that one happens on sparc64, but not on arm64
> > or x86-64. There doesn't seem to be anything architecture-specific
> > anywhere in that area.
> >
> > Funky.
>
> Not really. That is because de->di_fname is always 16 bytes but size
> can be 48 if the node is really a link. The use of de is overloaded
> in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
> but the actual data is struct qnx4_link_info where the name is 48 bytes
> long. A possible fix (compile tested only) is below.
>
> I think the warning/error is only reported with gcc 11.x. Do you possibly
> use an older compiler for x86/arm64 ?

No. Literally the same exact version. All of them are

    gcc version 11.2.1 20210728

from F34.

I suspect it's something about the config - a sparc64 allmodconfig
presumably doesn't end up having some of the things x86-64 has enabled
(because of different core config parameters), and then optimizes
differently as a result and shows the issue that way.

Or something. <wild handwaving>

                Linus
