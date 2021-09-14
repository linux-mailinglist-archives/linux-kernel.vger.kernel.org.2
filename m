Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FF40B840
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhINTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhINTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:39:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52DC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:38:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h16so725572lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSeP+SZFtkEJy4ZaKy/cigl2Oc8Bbz9AhqLyEsdn6ls=;
        b=ZKg5V6al9TUVnuClTBJc+c6AZow3uufBTv1h/0WiWYy24OFTEkjr1EP8aogrcyDBm+
         8g0J3o5Lml2fPzZNj3xLe+red1+Q3skWtCy2ht7pffCiyfF7PJ2JDk+DlnwMW2+jFx5F
         kkl268btaSsMQHet+Up8JA0um/uIUglJ5+ncs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSeP+SZFtkEJy4ZaKy/cigl2Oc8Bbz9AhqLyEsdn6ls=;
        b=z4zm4kn5zjWYfTJWE1a46mfDBIjZau4dcItGlV2Z0MUBEZjdrGGT14ETt1ph46JxBN
         eTaBEwbgO5u4eyOmFXxG6iJl8H6AgO+9795IvEnGzXg/Whq4hvV5CULJ5+we/yOAXWDP
         tLY37CUJ457TgLf1T7E89K4CRT75YyU9dTGUfu7V1LdSnkhqzysbUhOqt6ZsW4dDJlWL
         f8HUtn10uYVCn3mG1OUBDFKn9wXllvJ8qBBYqZHXjrKL2Br3AC2i6aLDZXPC9LIsy7hO
         5oFE9lK9pJgjBPhD+cbmzsVr8GAkNCs0ULhLoyuCWWcOZAppNhnVgds8U0oJa8ZC1g1C
         0c9A==
X-Gm-Message-State: AOAM531MlEt8aqsRQlnG9V/M03owryQ48rjWBREKENsYI/Bk7544fcQW
        J/xe+ADj8kcETQ5nlU1HyxObg4/YV1DgKRcVKN0=
X-Google-Smtp-Source: ABdhPJxbsq27jvoNKBCv7SUntORFqHKuZnQxEVDRgYAw3MgXFI6cLuMrrz2yrk1DxrtRVMrwofUdkw==
X-Received: by 2002:a05:6512:1510:: with SMTP id bq16mr14979252lfb.571.1631648303333;
        Tue, 14 Sep 2021 12:38:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v23sm133488lfp.236.2021.09.14.12.38.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 12:38:22 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i4so798598lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:38:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr14634897lfv.655.1631648302398;
 Tue, 14 Sep 2021 12:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home> <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home> <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
 <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 12:38:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
Message-ID: <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, never mind. I'll just do the automated replacement, it will
> fix that NULL pointer thing too.

Sadly, the automated replacement isn't quite as simple as the
sed-script I planned on using.

Because this:

  sed -i \
    's:memblock_free(__pa(\([^)]*\)),:memblock_free_sane(\1,:' \
    $(git grep -wl memblock_free)

does actually mostly work, but because "__pa()" takes either a pointer
or a integer value, the end result is that sometimes we call
memblock_free_sane() with things that aren't pointers.

Very annoying. That "__pa()" macro has the two underscores for a
reason. It shouldn't be "use this thing willy nilly".

So I'll do a minimal conversion that adds "memblock_free_ptr()" and
hope that people start using that. And then we can later try to move
"memblock_free()" to a name that isn't so misleading.

                  Linus
