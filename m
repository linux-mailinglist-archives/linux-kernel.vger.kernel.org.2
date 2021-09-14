Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86B40A305
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhINCFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhINCFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:05:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:03:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i4so8100732lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tobHcPJqhSNN4ZgtQaxMXpHgpTB6zZsMk6e9QdMIJao=;
        b=COw8J9SZUs4LkLiixQE+bnMy4NhxzCRXjrXYewVuOym1vN7v5KNNtqhQIlVcrbvboC
         UjjjEk1x1NdooPYMhBvKaSWvMvmm+9qbRiHG23qPOwLueInAFV1LTxwOeLxyCpMeQrus
         dKVrFrAyLVCKJ4IB9zqk3uoXaWuxBLuq4iGm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tobHcPJqhSNN4ZgtQaxMXpHgpTB6zZsMk6e9QdMIJao=;
        b=iwWVfmM5MOBYwXGGwtmW5vaqluxA3jRnEVxFSG7V5bomH4P8oo07gSyBBw2kE0/uua
         Nf96BZJ49o7foXBiP/MAZmTL+cR9/g7FAFVyApEZCA75TAsSbouND/a+XeApzxG276YO
         VFbXKTBAQ4DidAhqzkeO7RAMgRrrc/zHb2GI6IaF5/J9wNWomvHuZBSuUQEFSV+ZUYGY
         tVd/kLEUTqlqbaOzW3cv/QVsuYWiDzHxBnqqCs6N2OgckJltOKV33SucwlLjf8NDxz6v
         bR7f1b4pmJscb+wSWPvixQ8jdmqDL4UFLRnvId5uCENO3qRH8RCgn51Z0fUG+VCQaZcb
         3c7w==
X-Gm-Message-State: AOAM533W7R2sR6lyaFCV2ogAjl9J4ME2mfR1mOWSCa2hppW8sL7decD5
        LpNKy83P2/Vgl99Iq0ojf6mMF0NtSKLQ6urNjk4=
X-Google-Smtp-Source: ABdhPJwx0djGAH1hUiVz6m98K5fkkJNFFFguPT/BWjHMDJ7EhRWzHB/TLKyvd9fZBnfbxcoWcRM3Iw==
X-Received: by 2002:a05:6512:31cd:: with SMTP id j13mr11409935lfe.69.1631585028656;
        Mon, 13 Sep 2021 19:03:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a16sm1153011ljq.22.2021.09.13.19.03.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:03:47 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f2so20775037ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:03:47 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr13338597ljv.249.1631585027415;
 Mon, 13 Sep 2021 19:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au> <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
 <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
 <20210914105359.5c651d55@canb.auug.org.au> <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
 <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
In-Reply-To: <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 19:03:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6ADF7EkeZVT=R0=-hRxZeT0Ffcc5HSB0hSbK9AMX10w@mail.gmail.com>
Message-ID: <CAHk-=wg6ADF7EkeZVT=R0=-hRxZeT0Ffcc5HSB0hSbK9AMX10w@mail.gmail.com>
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

On Mon, Sep 13, 2021 at 6:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, that just makes me think that something like that patch in my
> previous email is the way to go, but I would like to stress (again)
> how little testing it had: exactly none.
>
> So please consider that nothing more than a hand-wavy "something like this".

The alternative would be to just add a

  #ifndef __ASSEMBLY__
  ...
  #endif

around the whole thing. I could do that without asking for help from
the powerpc people.

But it really does seem kind of wrong to include a "compiler
attributes" header file to compile a *.S file. It's not like any of
those attributes are valid in asm anyway.

I did just verify that the patch I sent out seems to cross-compile ok.
At least for the power64 defconfig.

So that's _some_ testing, and implies that the patch isn't complete garbage.

          Linus
