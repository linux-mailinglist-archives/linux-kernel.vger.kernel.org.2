Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5052139D113
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFFTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:41:41 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41515 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFTlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:41:40 -0400
Received: by mail-lf1-f44.google.com with SMTP id v8so22440738lft.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7An2hiLHGrbouqS/7tRGUe6/Rk56Kt/+cv6MVnKXHw=;
        b=X8PSQcCXi9TFSGp9uWLEWYLwqtECkft4cK25eAUrYbl7/k0fofUzW1c21vgoGXqIYU
         dQ4Hem4Zryf7koLchCfD4ceiGeDTdMHvqYMp7G+rStj8EzD6cbYYICA6UCD7/lAvpKR5
         BqGJs7qDa9ChMulRvIlfwScs6RUibNr5ta6ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7An2hiLHGrbouqS/7tRGUe6/Rk56Kt/+cv6MVnKXHw=;
        b=It5U2LuHGhZU4PIyAa/BUiXWgCAsJ/cefNvIvTPCDxT1YiwMtTxyb2qMoufpFPHHDz
         SuY+3oNdfbJq33vYVLILl14z9QkaedSh3pMx8aQYq2NyP6vBdBVaWb+XyX7dSqaQC0GN
         cIGxprVTYoiBu5ZcvyV/OWegZ+XYnGtCENElBiLaia7YgNnBn03w3SXXggEuLFNAXEw+
         OSE8CFGh5hECX70SgtIyKKk4BZqj7b/iu0k6gZz8HZdcBKqKzX9LrUyMu15nVvhZT5fg
         iEUyeb7TXa73tqwDBZmwOjL2yDOCnAsRVHPXqYhxUOewhIA4grU+gRBRLSE8dRk7j6pi
         7sow==
X-Gm-Message-State: AOAM531cqqBmioTNZ8qnAdxg6Woa7vFX//OGiraenC43q9lvPe0abqvN
        PIjnd0qYf0z6FM/nYda9r/M3eo/q/D4AlLp0iH4=
X-Google-Smtp-Source: ABdhPJwaI6TqdZVZm1ndd6thxcsbLTeZ5d/WjPtEsx3+LjmglOkgeOjVLKsoDeCkugrxVXUla+jP0Q==
X-Received: by 2002:ac2:5d69:: with SMTP id h9mr9137998lft.603.1623008329159;
        Sun, 06 Jun 2021 12:38:49 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q126sm1563705ljq.111.2021.06.06.12.38.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 12:38:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a4so19043024ljd.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:38:48 -0700 (PDT)
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr11975196ljl.465.1623008328440;
 Sun, 06 Jun 2021 12:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <YLx/iA8xeRzwhXJn@zn.tnic>
In-Reply-To: <YLx/iA8xeRzwhXJn@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 12:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
Message-ID: <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
To:     Borislav Petkov <bp@suse.de>, Mike Rapoport <rppt@linux.ibm.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 12:55 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Do away with all the wankery of reserving X amount of memory in
> the first megabyte to prevent BIOS corrupting it and simply and
> unconditionally reserve the whole first megabyte.

This seems a bit draconic.

How does this work at all under Windows? There must be some windows
knowledge about what the BIOS updates that we're not aware of.

I've pulled it, but it does seem like something odd is going on.

And that

    Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")

makes me go "Umm.." too. What did a799c2bd29d1 actually break? It
looks like it was meant to be a no-op consolidation - if somebody
bisected to it, I think that is a sign that there's something odd
there.

           Linus
