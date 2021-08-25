Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCA3F7CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhHYTox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:44:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD33C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:44:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q21so618173ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hionP+S3WQHCeRsfV2U1fbeKdh6BHUGkpwhUBr6Opo=;
        b=cSO5M3pXxwAmQTu4luHD6GnYnkqg92T0OMr1XA6ueriTiYW41YJ1a4sLbAmVHerBfw
         Twvwln+3PoG5r3psuTBFR3bMMBT21KQan37TbOfPSqxaWBJwUjIK7Z6Fb/ySGvljgGZ+
         /9XpvKthjhblWn4cPz+TQGVoKb2//adm+EAHu702s3rePIN1d1gJtOMnHQXVRmj/jzQG
         F4Tm4Jc5nKZp+chGDsdDfI5M3twgwM5WfuqdOAGx+jF1TXsZp93DfdgRlck4ywgtDCPo
         nUMs9u6uiZnEnhVVFlQqRNnkcq+Y+UwuKC5Dbp33Me8D35Xw5mlK9Jk9Q2qJjkBhS0db
         2NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hionP+S3WQHCeRsfV2U1fbeKdh6BHUGkpwhUBr6Opo=;
        b=rSeWvLvxP1fvgAVaeIfMrD88iKxZjdKi74bdTogCSm9ClUtqWKULVicqk8+doXpbNz
         n60NMJyRI2w//L6yhEF27/cJy6iZUI9hn1ubVw3XY6a6IUl6GsGZA6TDhAJSYPvKPYvC
         jtGKk/Q2/6qL+gLLyy6myTobVzU44dthymDl8iwizXdLadWUs3Av/qbj1S4iz5qqLI+5
         d4dvwaqxPsp8RUNW4z+JZg8948iQuvmr1gB7aqpFkeIk+VMc7vM/o9FA6qcWToXCV7Lv
         WIveovi6Oz0eO0zoEEfVkqDapYq+MPP9Fyu9VI3u+7PmUOk/wgVi/Mo8ykxEM9iUcYLj
         lOHg==
X-Gm-Message-State: AOAM533rzY6RCCTG4Xlv8klHBGVeNzwcF+wV3w6iGZu+hBuRncrUgRtz
        ge7023GLo/5Id0UMpNd2pRjHs/L7prsPu6I5unowZg==
X-Google-Smtp-Source: ABdhPJyZ7uDwfp8fuaRxMK0BR+wxPpEoAE9f9CfLQXt1nMlh04/ioOFiOdQlutGtK4GqkF0S0R4UriHTlLmeZsPRp1A=
X-Received: by 2002:a2e:a367:: with SMTP id i7mr268052ljn.244.1629920644666;
 Wed, 25 Aug 2021 12:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-14-keescook@chromium.org> <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
In-Reply-To: <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 12:43:53 -0700
Message-ID: <CAKwvOdnd_e7K9Ayn+4pMgWzbu7W8U5dWiSVa9AEKs99m+q7K+g@mail.gmail.com>
Subject: Re: [PATCH for-next 13/25] compiler_types.h: Remove __compiletime_object_size()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 11:43 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 22/08/2021 09.51, Kees Cook wrote:
>
> > -     int sz = __compiletime_object_size(addr);
> > +     int sz = __builtin_object_size(addr, 0);
>
> Not directly related to this patch, but seeing this I wonder if there
> would be some value in introducing names for those magic 0/1/2/3 that
> are used with __b_o_s. Every time I stumble on code using that I have to
> go to the gcc docs, and even then it takes me a while to grok what
>
>      TYPE is an integer constant from 0 to 3.  If the least significant
>      bit is clear, objects are whole variables, if it is set, a closest
>      surrounding subobject is considered the object a pointer points to.
>      The second bit determines if maximum or minimum of remaining bytes
>      is computed.
>
> means. The names don't need to be too verbose, just having a few
> #defines in-tree with the above quoted above them makes it a lot easier
> to figure out what they mean.

We share a similar experience.
-- 
Thanks,
~Nick Desaulniers
