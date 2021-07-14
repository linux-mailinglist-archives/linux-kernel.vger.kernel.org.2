Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9E3C93F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhGNWn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhGNWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:43:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:40:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q4so5716536ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF9g4Kiw/Fnjhra0A3NHssg/L+MsgY/bbhNOhs2yWkg=;
        b=XwnAiopxVuee/+xvAawo1KbGDlP9AIOqV52u6nh+zQy7X8YyvYLVsIWrsG5z4hsAZo
         Us04RZB8+P1gHRtT9c5f7srdMs0z/wnINhl02yV17re/Cvj3nskjZ10AhDcDnZq6QQVD
         AjLwXMP+HKQ5AC55ituGLykCuW4g6U7vxsBmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF9g4Kiw/Fnjhra0A3NHssg/L+MsgY/bbhNOhs2yWkg=;
        b=iaBjsUUynBqXqBQP8D1SQ4LvIHChWfOqwkauPDMRxO+Tt0jM14SNFNZSNg+gcB6Apt
         wxfp4CBmvlVxCh86K558dCplUptpg4kImaRVtEK1F/M8tuAbg/hwKf+qPAkBqbJXt6+p
         0D0HkI8WwUN/jhOFpI3S6WtcY5PptA4BEPiwFG7lMWSD027GtWnjmlLHcdjI/OYYSro7
         ebj2rsyYvxiSUasDex14SVKxgffs2bpLraQLFh3AHv14VEJU9VntFzPYS6Xke+G4mJ0m
         kZ6PeG/Zt72XhHMWLiZIiQpENJVepVGTNQbtJhBp6XL+oGT40yLWY38bvQax6fo1Wuno
         kNcA==
X-Gm-Message-State: AOAM530SeeL+j3NgnxQQzeGDetgwNER57XVJwPflsLeCFiRF16t/c7UA
        2LE8V86Ghj4jQ12KicBPUADSTLMw7nHptjaV
X-Google-Smtp-Source: ABdhPJwoquSnfJd9ci1ooc32bf1Z92VDpxolIXpDbLc5TEEZcCXjK5puL3v8zIimKlrzDrj7jA8/PQ==
X-Received: by 2002:a2e:a22c:: with SMTP id i12mr141472ljm.267.1626302428870;
        Wed, 14 Jul 2021 15:40:28 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h10sm251611lfp.151.2021.07.14.15.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 15:40:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a12so6334108lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:40:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr265721lfa.421.1626302428152;
 Wed, 14 Jul 2021 15:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210704202756.29107-1-ojeda@kernel.org> <20210704202756.29107-3-ojeda@kernel.org>
 <CAKwvOdmhRuF5eTZ2ztZBrL6BvDkA57B7OfVuvCaEMfV8nkLXCQ@mail.gmail.com>
 <CAHk-=whzXv=Fu7dQshSTyd9H1-JS5=gyKwW-GMNGccAKs4Mwpg@mail.gmail.com>
 <87mtqo1wv6.fsf@disp2133> <CAHk-=whdi_biEOrzrYn7OC+wq+ckoaa5dFAATdM=n9P7Dp0YOA@mail.gmail.com>
 <87a6mo1v0q.fsf@disp2133>
In-Reply-To: <87a6mo1v0q.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 15:40:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWiu5uak824BeWu5J+9n1NhQ9UKDGgcUfrumra6r+Z0A@mail.gmail.com>
Message-ID: <CAHk-=wjWiu5uak824BeWu5J+9n1NhQ9UKDGgcUfrumra6r+Z0A@mail.gmail.com>
Subject: Re: [PATCH 02/17] kallsyms: increase maximum kernel symbol length to 512
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Sorry I was meaning to ask should the C symbols that get hashed
> include their types in the hash as well?  Because if everything
> is going to be hashed we need to clear definition of what we do
> with good old C symbols as well.

Oh, I guess if we wanted to be fancy, we could make the modversion
information be part of the hash.

Because we already have that, and that's kind of what it is. But I
wasn't actually thinking that fancy - I'd leave the C hash as just the
name hash with no type info.

Unless somebody really wants to do that modversions thing. It *would*
be a very natural thing to do in that "link using hashes" world view..

                Linus
