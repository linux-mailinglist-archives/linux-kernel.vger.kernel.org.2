Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB363B0CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhFVSbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhFVSbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:31:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC4C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:28:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j2so37523567lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZpVUR22GV2FhIPfitStL6sJNaCS4zKOgFuhT+Jblpo=;
        b=Z693fDgItvtwcb4kTOVryT20g278Zz6hUQqITd0+HePvWOEJ/q4X2/GBHNiKYE5aNZ
         xF4pSUq8WFx8OrMLW1r42O24+mcof+0hdJXuwaV68w1SsOSyBEhfQWKBUBZM0GfgOc5N
         g49GS2nhPH9aIUXjg2ss34vZ75Z/DfiJKbz0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZpVUR22GV2FhIPfitStL6sJNaCS4zKOgFuhT+Jblpo=;
        b=DDDC07ofnV1zYCPLw4IvwY+kyT1/2uZkSHCNFBwn1dDBkSjmjihjXpxgDrWQzxApG3
         FwawwnmdHTT3f7KIWeyYcAcKjN0ycgpsU70fXdWIioLGAPt47DPSZ13kqyGEefiBV5tQ
         QHcy0tJoYtZPAadHZ5BVLq6OT0XZMarx+t4FmO2d//0YZ+Jg4eTBvfq+YH9GSl6K1Ze4
         zfA/lr3EH+yG1gl9sTuNYTsyjvrwqEOGk3a76yE3huOpZdnJgRomgISfgIimXh+tbJmk
         N/E3XjNzMvmfCIjrmRo/hwGADMHIkfUi49/pgnMZa1wQw8yhItXpIoh2F1//yQqqNABo
         Bd7g==
X-Gm-Message-State: AOAM532kRmnBgzNxyhrN6Y7ePIAHxwb9H0Jk8v82NJ8dMPyZcOYrfilP
        kN1gYKE8flKeLdC7u0jihJ2MKGy6B2XZWiB7Oew=
X-Google-Smtp-Source: ABdhPJx9seR7rmowpqgIs3jjkFaM/+x2uH06LH8u3+AlfC/5NhZ3+EnYMRQMuPKB06oeiSZciTyEOg==
X-Received: by 2002:a05:6512:22c5:: with SMTP id g5mr3798977lfu.476.1624386527904;
        Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k15sm547775lfu.72.2021.06.22.11.28.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a16so9953871ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr4383026ljn.48.1624386526776;
 Tue, 22 Jun 2021 11:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <YNIqjhsvEms6+vk9@casper.infradead.org>
In-Reply-To: <YNIqjhsvEms6+vk9@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:28:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
Message-ID: <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> It wouldn't be _that_ bad necessarily.  filemap_fault:

It's not actually the mm code that is the biggest problem. We
obviously already have readahead support.

It's the *fault* side.

In particular, since the fault would return without actually filling
in the page table entry (because the page isn't ready yet, and you
cannot expose it to other threads!), you also have to jump over the
instruction that caused this all.

Doable? Oh, absolutely. But you basically need a new inline asm thing
for each architecture, so that the architecture knows how to skip the
instruction that caused the page fault, and the new exception table
entry type to say 'this is that magic VM prefetch instruction".

So filemap_fault() is the least of the problems.

Honestly, it doesn't look _complicated_, but it does look like a fair
number of small details..

               Linus
