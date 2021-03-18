Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2033FF87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCRG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCRG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:26:34 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F88C06174A;
        Wed, 17 Mar 2021 23:26:33 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h82so1367507ybc.13;
        Wed, 17 Mar 2021 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4jcVy0dq4D6dkbuTYCxEhsvgRcoFBgu9ucC7LjDGtY=;
        b=anfgqyjmTFQehzgUa8eJsjaCE3q5mOrfE4piuRxkviFKdxQpUYasboBZZSiiCnqE1U
         qPj3m/2/W3krZElD36V6c8MPA8N68yUEhn/fbYgrVRjqM/6NGa/r8HcryVKnX+29K3dX
         VM4rah52VPyj2QpfDvSI8Q3YORCi3siDnyrEkphPKXM47DA85aBkm6uZlkJQCJZNy/JG
         g+5QZDQct9Mv9hligBYeVct2roPpGDKDavw/oeuMr8k2B8Vk+r4rZgW1lT2ljH6BN/lf
         0QmXbiLa/46Enprh3PJBHFecNxLQtBjDwCK5MbkeDLh/N57Ry78RWMunFZKksAHRwAaf
         ffsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4jcVy0dq4D6dkbuTYCxEhsvgRcoFBgu9ucC7LjDGtY=;
        b=asaXcTytY/yUO/J8LGZ1qSz34uc+c+ead+brimBIbbSkHVtdu4wU/gIdGdQ57HKo35
         kevTcBOVAMRP46yoEygMwLkGabn8NqyP5JOUx/R96L+Q12oVyBBmCqVwchp9v3DWd0UY
         UxDr0iYN+zX+L4VGuYezsU9Wzf6jYMMiy9MYMIDYAP1xlykwszF2C1u2Qp177RMNvEk0
         yl2pZvOF9P+JLdDfe4efr0pbKaYxYbKiAbYbxy1WnAwdMZX3NQ/dzlm+m1lc6LLPzdIn
         wwjVfsys0TFHmqBUAbwzgPTlDfUuGDQaLpzkIAaVNQCRiAu45Tt0egLRcE13+vLG1s7k
         cuOQ==
X-Gm-Message-State: AOAM531DVWg1Ay6QOjutcKYFA1p74QWZrrSviJrsBqos7X885j9uHR+H
        IugbHTVkuM0NNQY/E1e2RNzMHz0EK1HlQhj+IKOaSxRx+H4S8Q==
X-Google-Smtp-Source: ABdhPJw2UgQtZm/ksPlg9wSMLE9HrhTK2V0Gci5LHv9rMUYVF8eW3LpHhOL+zKV4V1RqPB6cCwLEhRSfbaBfmH+ktac=
X-Received: by 2002:a25:844a:: with SMTP id r10mr3632810ybm.26.1616048793316;
 Wed, 17 Mar 2021 23:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook> <282490.1616047333@turing-police>
In-Reply-To: <282490.1616047333@turing-police>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 18 Mar 2021 07:26:22 +0100
Message-ID: <CANiq72nyNSgrM6bhmM7ymdtYYKoDLfUXfwgTwLOmhLFc=c0U-w@mail.gmail.com>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 7:03 AM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> Or declare that gcc6 is the minimum for building the kernel.

Cc'ing some interested people in raising GCC's version for one reason
or another, so that we put this as another one in the pile of reasons
:-)

https://lore.kernel.org/lkml/CAHk-=3Dwjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lc=
prj7bEg@mail.gmail.com/

Cheers,
Miguel
