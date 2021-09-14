Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB240A2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhINBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbhINBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:39:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5DFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:37:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r3so20693293ljc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaxVMoYr01ooBsRLl+9NrQ8wh4tzlePArs6uZi+Ocvk=;
        b=LWKknnDlMezAs3gUXR3kh/QfVsbTeK+nWV3l/0fmyZ2xNtUAX8M6drYh43BUMBEtMD
         GDa6WkmcV7mH8tsO4kjdyzm6FXGRqNGpF5OqxXxX39QZusB8c+baEHhdSa1tzasPozfR
         H0g67r5PAKacEgCwf/LDT7505JFTZAmmkEQjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaxVMoYr01ooBsRLl+9NrQ8wh4tzlePArs6uZi+Ocvk=;
        b=rEgBTOqn0JQZYuyNPBsd0fQzzR4slCA0fXWZEYt+kMUhW11Q391hMcT6wIpoUEWSDI
         hCYFkr6pZas4xsaPA3fB4+RgpuFLC/uFWG7F4rV2HEgPxaApoa+Pu/xMg6CNfrDRanAF
         s9Xh8m1eUcrrQZEzuVN4Onr11EzwQ60Gy8lFdD8V3Xeosw/8gMY7iU9p+lQOWQE6Haxj
         UXg6U3uDAZbn1ONOldpsNVvtYS2/DQXQPpvC1EcN0Nu0A06N6j8jcmT+mA0MjOXbFFn+
         0bUEZIjr2UFMxr4iXD/UriC7H9vpxq+zapi/HBNMIxjjouNYOpjp/nZRvyvmbsfNm/b5
         wSqw==
X-Gm-Message-State: AOAM531GH/Imn6zLMj6meQVxAlp5hhgF80HTwzwP9spUJoduGbBFYjYX
        XRce+4bmR3q41SBop+Pt5y/Qu0dPW/oA8sBn4U8=
X-Google-Smtp-Source: ABdhPJyW/96eXtp1YLa1Oiq+23p2wiifU8RPE4blHIse0deS/yeklyDJw+xGPWEDplBut9E1KbbIKQ==
X-Received: by 2002:a2e:b5ce:: with SMTP id g14mr12634331ljn.93.1631583476541;
        Mon, 13 Sep 2021 18:37:56 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v22sm983310lfd.79.2021.09.13.18.37.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id y28so871012lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr11493578lfg.150.1631583475033;
 Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au> <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
 <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
 <20210914105359.5c651d55@canb.auug.org.au> <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
In-Reply-To: <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 18:37:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
Message-ID: <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 6:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, do I know *why* that ppc Makefile it does that? No.

Well, that is simple enough to find out..

        git show 77433830ed164

just tells us.

Of course, that also points to scripts/Makefile.lib, which doesn't
have this problem, because it keeps c_flags and a_flags nicely
separated.

Anyway, that just makes me think that something like that patch in my
previous email is the way to go, but I would like to stress (again)
how little testing it had: exactly none.

So please consider that nothing more than a hand-wavy "something like this".

              Linus
