Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74E344E82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCVSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhCVSZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 323A061992
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616437508;
        bh=btqPrkynhxzXV4lNizFKA3/kG4DsBvvwKnGEdTnojHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJXdo49ICbPSsITEAeQ6RstshMpvA4bQOA5aXO2KyXuXW+ie1kMYpA1Y6j6//8BAz
         OaMv3m/Zk64SfVvoYvo7S9hKBN43at0Bqh5yDM0HCxQ0IHTjymLcE3A7wDzgQbAdFP
         bi/q50XgQGAdQjx4bSWlorzGltEccgyBXJXRErEX1F1oejbxYqdOy9WXG4ZcWqH+6I
         XSTqGG/m5zocu1YP9SrpFf/zB9cVVjTs2HG99c7HQ20X+pqjdYCq//ORfwPS46gwnU
         ZhgKIqK4Dg4AnsyuQuwBXHvjoCJNt4PaTjvWPHre4LPCW7SVn3vXGFO/V/dBmepbZi
         W4n0i9aWyzrnw==
Received: by mail-oi1-f171.google.com with SMTP id k25so14047387oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:25:08 -0700 (PDT)
X-Gm-Message-State: AOAM530kb4WRIDXYg+znGXh249y5psVNNcmRtzHIsmvrST25Q7Erv8Um
        JdcA+PasajxVm+5ZC6zpj4maxW0/k92rTzcdHrA=
X-Google-Smtp-Source: ABdhPJyekS5YJDAfepWLsBuiiaxcMeuFVDatMCafGcgToZ6ttTRUBZX8hAJKr/yCFFz00JEPy9gmaBi6jO0HgJyNUl4=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr322031oie.4.1616437507486;
 Mon, 22 Mar 2021 11:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114536.3517661-1-arnd@kernel.org> <20210322143344.GN3141668@madcap2.tricolour.ca>
 <CAK8P3a2NkB7COUetdq65cSNjVe7-96c44=4JE5BXkBwXG-5nyQ@mail.gmail.com> <20210322175821.GO3141668@madcap2.tricolour.ca>
In-Reply-To: <20210322175821.GO3141668@madcap2.tricolour.ca>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 19:24:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3hQKASNVp0VsFYteGh6Mav3=iNZT5n2eWzFieH0hpXjQ@mail.gmail.com>
Message-ID: <CAK8P3a3hQKASNVp0VsFYteGh6Mav3=iNZT5n2eWzFieH0hpXjQ@mail.gmail.com>
Subject: Re: [PATCH] audit: avoid -Wempty-body warning
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 6:58 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2021-03-22 17:28, Arnd Bergmann wrote:
> > On Mon, Mar 22, 2021 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Change the macros to use the usual "do { } while (0)" instead, and change a
> > > > few more that were (void)0, for consistency.
> > >
> > > So what about audit_put_watch() and audit_get_watch() which are set to
> > > {}?   (And all of include/linux/audit.h that uses the latter...)  Does
> > > this only matter if they are the only action called in an if or loop?
> >
> > I missed those, thanks for pointing it out. I sent a v2 patch now.
>
> Ok, cool, that looks more consistent.  Can you answer my question about
> include/linux/audit.h and exactly what conditions require
> "do { } while (0)" over "{ }"?

This is the usual way of constructing a C expression that can be used
e.g. in

   if (x)
          foo();
   else
          bar();

If foo() is defined as '{}', this causes a syntax error.

         Arnd
