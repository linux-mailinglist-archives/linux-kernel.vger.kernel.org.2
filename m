Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0477A41365D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhIUPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhIUPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:43:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:41:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i25so83978976lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5ZjvlclnOLefKJUciH/41eaKTuf2oeVM14/tctcfHk=;
        b=WAtzyCe5WGtijPUGvRi94F/d74XLgpaTeM3I9SyJeVvDgv27xzam2rqeMHc3M/6F9o
         ObDpjtJQ7zMy9DmdvysMIbDE9KwSUMhZlGKlmzhuJBfyxSsgmt1NVpenIzlj/Xxyv4/I
         8p0CuY63IGjBJVi+pENOA39cL/acy1HeogBao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5ZjvlclnOLefKJUciH/41eaKTuf2oeVM14/tctcfHk=;
        b=EF/SaWjOTSeDtBj2VBl94EqavO8oqyjIqPuV7zJa6IN18QKLWWlfMwp7/+wuuS8PCX
         N3nVN8gbvLyupdQgPUmyfwW/ZShXkP1mpuqJQQpr86/Qn1PLw58lJ2Udx5AcS6c4Rcgf
         pI8cS8azrwboQHNBzE12xsA4NP4LmqNRFlBq5U49+nbyaSkgEf8/Dyadxtxb83QbRfsM
         puC34WsF8D5I5r9ZwHLpeUJNlf3lnPD0NYvI74VvJnFEtLbzruvPkAiOcfhiGAVff06x
         /I06wPxQWQJ3z46EEsQ5+2KxfgP+rtiKmQBb4B6uiUvyzQEgZhW13smyK0Vr1iBd/ZcI
         B7uw==
X-Gm-Message-State: AOAM532nwl5d7fo9Ls1+sHH02lodW3TUp3tFcvmp23S7tP5lwKzF4kCt
        gxe30uq6PouujP2m+JLxnfbMDGx1XHpc8+OOaQ0=
X-Google-Smtp-Source: ABdhPJyCixQuQTRHj7fKdB2/893l4UbfxRNXQeopXCF2Fd139w5DCftL/oGSKiYnQzPXAgl8+S3gEw==
X-Received: by 2002:a05:6512:c20:: with SMTP id z32mr13500939lfu.590.1632238869500;
        Tue, 21 Sep 2021 08:41:09 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w3sm1546366lfu.147.2021.09.21.08.41.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:41:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i4so83684796lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:41:09 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr9831360ljh.68.1632238839995;
 Tue, 21 Sep 2021 08:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121208.54732-1-arnd@kernel.org> <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
 <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com> <2955101.xlVK0Xs8nM@alarsen.net>
In-Reply-To: <2955101.xlVK0Xs8nM@alarsen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Sep 2021 08:40:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaaUgz58Avt_W=7mAsp1DSoLh79mkcGASa-OUbPmjvVQ@mail.gmail.com>
Message-ID: <CAHk-=wgaaUgz58Avt_W=7mAsp1DSoLh79mkcGASa-OUbPmjvVQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
To:     Anders Larsen <al@alarsen.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 8:15 AM Anders Larsen <al@alarsen.net> wrote:
>
> they are available at the same offsets in struct qnx4_link_info as well, so
> wouldn't it be even simpler to just always use the fields of the latter
> structure?

I'd rather use that third "clearly neither" structure member, just to
clarify what is going on.

Yes, we could just always use the bigger structure, but then we'd
actually access a "link entry" even when it really isn't a link entry.

Now we can have that bogus entry and the big comment that says exactly
why we use the bogus entry, and it's clear that the "name" we use is
not necessarily a link entry or an inode entry, it's that special
union with a big comment about a gcc bug above it..

Anyway, I committed my patch that Arnd had tested, with a slightly
expanded comment. I'm sure yours would have compiled cleanly too.

           Linus
