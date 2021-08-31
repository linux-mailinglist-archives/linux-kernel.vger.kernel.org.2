Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC13FCB97
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhHaQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhHaQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:40:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:40:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g14so4791803ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlDvXWCwq9oQrcS+ObUACbXbifYYVn7FARrjhr/5Hw8=;
        b=LaDPyL+bvAPyD4iPhWTnGEliAF5N5bk9qNdn6gNkd/k4E9TXbp/ff4JtgKOD8IS41y
         9mfNzGlYM+qCWBkM3Xu6bQ0IZ4fcrj9gBV7prm6Ry88aItm9Up1BB36d6W2KxRIOCtWI
         LxLJxns5SrPZu9HOj88MgI//jXoAE0XHqJ6BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlDvXWCwq9oQrcS+ObUACbXbifYYVn7FARrjhr/5Hw8=;
        b=Gbvjnc3u5yrCvn1fWvf7HaCQDfydHmoaNrr6kW+0iPFZTQtGDxURTo0KQDQ29gmSH5
         I4JqaD9GTnYqiHvKnyh7I75R6udcEUD0Sj/CtPnNq4oLpKsVSUqdj/6IyCdtJglzQnK6
         Xfa5Gr77blyltXLkvj6v+65+lnLrvqR8HgwXqZyBpJB3iw4Leh3C0lFLhqM51botOiUR
         AqmrR/W8/eUNnlMetBSPCswnBbJwpvP5ufu2SQNvCV0s0z9ZmZGMSQTnpEyS+y0lF7gn
         vOUfh7ZQPtb8Vtcda7HOjdsckc6ZOfftbDDw1mKYKErV2szr7sjTco1DCeMgZHU20Erx
         YftA==
X-Gm-Message-State: AOAM533KqkmrC4x2hoRgC0zARcm4SVl5avpZISUm9oYBNZQSCwYLYEkl
        kcbr8Sw5YAeBq0r2efJR62x5dpFjyhYuFqbqTqU=
X-Google-Smtp-Source: ABdhPJwQ3+3By1ZHMSP9Np6h56zE0SM+JpCiLRA76bYE9UlvYByuej4grJ09kbW4pT2R2qxkAalxkQ==
X-Received: by 2002:a2e:a28d:: with SMTP id k13mr24398607lja.446.1630428000748;
        Tue, 31 Aug 2021 09:40:00 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j1sm1455553lja.108.2021.08.31.09.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 09:39:59 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id x27so62805lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:39:59 -0700 (PDT)
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr9701063lfb.201.1630427999490;
 Tue, 31 Aug 2021 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
In-Reply-To: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Aug 2021 09:39:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNvB_j3VZYJ1yZqq+9JjgWCO1MUmRsjTKBwQ+x=kB5tg@mail.gmail.com>
Message-ID: <CAHk-=wiNvB_j3VZYJ1yZqq+9JjgWCO1MUmRsjTKBwQ+x=kB5tg@mail.gmail.com>
Subject: Re: [GIT PULL] cifs/smb3 client fixes
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 10:48 PM Steve French <smfrench@gmail.com> wrote:
>
> - mostly restructuring to allow disabling less secure algorithms (this
> will allow eventual removing rc4 and md4 from general use in the
> kernel)

Well, you should probably have mentioned that you already started on
this by removing LANMAN support.

I'm sincerely hoping nobody used or depended on that old garbage in
this day and age any more.

Anyway, entirely unrelated question: you pretty much interchangeably
use "cifs" or "smb3" for the filesystem, as shown once more by the
commit messages here (but also the subject line).

The filesystem directory is called "cifs", and I've taken to use that
in my "Pull cifs updates" thing from you to just avoiding the
confusion.

And now we have ksmbd (yup, I just merged that pull request too), so
we have a "cifs client" and a "smb server". Aaarrgh.

I understand that some people may care about the name, may care about
"smb2 vs smb3", or whatever. But I have to admit finding it a bit
annoying how the code and the directory layout uses these different
terms pretty much randomly with no real apparent logic.

Somehow the NFS people had no problem completely changing everything
about their protocols and then still calling the end result "nfs
client" vs "nfs server".

Oh well. I'm assuming it's not going to change, and it's not really a
problem, I just wanted to mention my frustration about how clear as
mud the naming is.

             Linus
