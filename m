Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E993B3C8B65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhGNTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhGNTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:07:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:04:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so5434126lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qboNP9wECqxtAQPwi4Gka7E9oHhS1YQMu+Q8JxA7ak=;
        b=glh504o9Z7GfM84TfN6a9e1MVve+NDS52G62Hq+T8wU2hET7iB2/LaVZ85dbskzDgh
         yAhIlfeW60S6JOo6yc3CQ/IrfJT+6DnE98rLe7dMWar89uMeZPDVQtzoII2b3yZofc4W
         nDIrMzgD5EdLgxaeyj2u+vGDFkWBSBw0uXR4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qboNP9wECqxtAQPwi4Gka7E9oHhS1YQMu+Q8JxA7ak=;
        b=cm6ULPZAnRk9GLCPuo1APSPNmm8kENnB4ThynQjIfJvrByhzdcB4DswMkUu4rNaXnu
         rQND5ZwcH5yL6gZy7jSbL4kOnT4/g1/rkGiaRu6CEHHvwD2FvIXrnAHeptvqUb+3p1xo
         Wiawu6O9dwzXZm3O5JF3jMUqsYJSE2eWCMfLhdDUwqt+LWsBybQuyKVzeDEYM8JM38VG
         /KusneGDQVPcyb6Brsb/u0AeXdA2h7TURuZ2e+NiBT3ij1HHbE6zJQBRtiOKe+jSKSEN
         eyV/nB1z77cDsQIarszMRmIWebtwIRbyjkwYifq7/+Om0wPlqSYtFdYoU+K86zidE6af
         kM1g==
X-Gm-Message-State: AOAM533DCXeAUINdYOlIjasV99gVL0etV/og+AefxUnhGjRu0neTafgX
        FEhIpJwlrIqLa7tMgGoWRKT5oSyZrk8yQ5wY
X-Google-Smtp-Source: ABdhPJwWyub98svHmZPEKy0Rre8zQ0rFQOpkbFZtXEMh6WH3p+S1qE6wXPtTxvmR5Xl75OK9SjCHAg==
X-Received: by 2002:ac2:4d12:: with SMTP id r18mr8280634lfi.51.1626289465779;
        Wed, 14 Jul 2021 12:04:25 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t24sm328317ljj.97.2021.07.14.12.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 12:04:24 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h9so4990275ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:04:24 -0700 (PDT)
X-Received: by 2002:a05:651c:1798:: with SMTP id bn24mr10307687ljb.335.1626289464172;
 Wed, 14 Jul 2021 12:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210704202756.29107-1-ojeda@kernel.org> <20210704202756.29107-3-ojeda@kernel.org>
 <CAKwvOdmhRuF5eTZ2ztZBrL6BvDkA57B7OfVuvCaEMfV8nkLXCQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmhRuF5eTZ2ztZBrL6BvDkA57B7OfVuvCaEMfV8nkLXCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 12:04:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzXv=Fu7dQshSTyd9H1-JS5=gyKwW-GMNGccAKs4Mwpg@mail.gmail.com>
Message-ID: <CAHk-=whzXv=Fu7dQshSTyd9H1-JS5=gyKwW-GMNGccAKs4Mwpg@mail.gmail.com>
Subject: Re: [PATCH 02/17] kallsyms: increase maximum kernel symbol length to 512
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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

On Wed, Jul 14, 2021 at 11:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Do we demangle rust symbols when printing a trace from a warn/panic?
> That would be nice.

I think it would be pretty much required. Otherwise stack traces are
going to be very very painful.

In fact, I'm starting to think that Willy is right: we should use
hashes for the "real" symbol name, and have demangled names for
printing, and at no point would the kernel actually want or need to
have the nasty mangled names.

(This wouldn't be rust-specific - using hashes for module linking
sounds like a good diea for C code as well, even if the de-mangled
names for printing are then the regular ones)

Anybody interested in looking into that? It would make this "big
kernel symbols" patch immaterial.

             Linus
