Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D39E922
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 23:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFGVeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 17:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGVeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:34:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E35C061574;
        Mon,  7 Jun 2021 14:32:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m18so19217987wrv.2;
        Mon, 07 Jun 2021 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDwdlII4xvRHYMeALYz88M86eElsCZPiDN/teNVAvlY=;
        b=ZzBwJJEjMdi8Sj9uSmMTvUY5dvdi5DswCqZiL46IbaiX8kEjLOrRPjYPF+3Rcekmps
         aOIGJODSP/4/+nH3Un8UUD2v0IS45VIiGO1KcDuSppLJDSKoJPJWyExX7BpbpvVpXaF9
         EVMPlS7Fz2tIqrsR1XdxG/FkgaOOr23I0BL4hzrs14GfglItwnX5JnU4JFMVMAJzbsRq
         DuIT+dFzHf+pZ9UjE4qpbcvaxUdnl9cZU43S1TxWKisrhkm5l9xdqxETJWc1JPkStlDO
         XY2uu1cjx72Hx1PUAtIf3hIHe02pQDkfb+mRjAYY4Rs1Vwr04NkkJhX2PNISN96HIkQs
         ORoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDwdlII4xvRHYMeALYz88M86eElsCZPiDN/teNVAvlY=;
        b=ueVa2LODphOnORo5Hj+4kRP+cthKbs1t/PwqnHup9MbukE+fw1OplxyooKLMOAS1rW
         23RfOFCvjCFJ8QhUvzkQidSpLOZkRtQPXpZ8uidpZI48wOZH9IqYBfOcuLYhxXZ8ZJn5
         ocA5mBZP7q/3aowAY9Z9V5IibsnxPZjuHCDIGBedBoUTIyb1VQQlqW3TT7Zc+BxL8iHl
         EJ4mkI8/tgATucGFDZ68rMHBVqW87JdPyVXvWcplZE+Av5+vRsEd2m39HxpKxuCbU1NN
         3FDZh8+jBXjusow9zv0MkZ6cq2yKy97YD+3XYQeVkm4B3dfqbeyO8keLcU9bRIJtCzo5
         mmCg==
X-Gm-Message-State: AOAM531CmWX1JNO3nNdqFA+g8AxT4zeeiRUfoa8kho36mVdIx4YjfXhG
        3A9eMtEO3JsIZa8aIskZwRN2RhqZP3fT+To4Wcs=
X-Google-Smtp-Source: ABdhPJzvPtqdfmAIJbFBnlWMRVMPMd5FM5ysUui85hJNne03xVPiNOTQjx1I3fifRbtK8dmOYH5eqfpqH5pSqkOYKxQ=
X-Received: by 2002:adf:e507:: with SMTP id j7mr18490221wrm.178.1623101548421;
 Mon, 07 Jun 2021 14:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210605070502.22288-1-dwaipayanray1@gmail.com>
 <CAKXUXMydnnun3iu3B2_acQLd6EgDHOGUhKvbuUCh6WaS-ohiDw@mail.gmail.com> <CABJPP5CfoPrybLgmZ2AP15x_esCPC6J780QYzEahMB9qzkRD=Q@mail.gmail.com>
In-Reply-To: <CABJPP5CfoPrybLgmZ2AP15x_esCPC6J780QYzEahMB9qzkRD=Q@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 8 Jun 2021 03:02:16 +0530
Message-ID: <CABJPP5BufzwYjHd=U0Xhz+3+miMOv-DP5DZiUo+jvNFraw2X_A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: checkpatch: Document and segregate more
 checkpatch message types
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 7:17 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> > > +  **CONSTANT_CONVERSION**
> > > +    Use of __constant_<foo> form is discouraged for the following functions::
> > > +
> > > +      __constant_cpu_to_be[x]
> > > +      __constant_cpu_to_le[x]
> > > +      __constant_be[x]_to_cpu
> > > +      __constant_le[x]_to_cpu
> > > +      __constant_htons
> > > +      __constant_ntohs
> > > +
> > > +    Using any of these outside of include/uapi/ isn't preferred as using the
> >
> > write out: s/isn't/is not/
> >
> > ...or even stylistically much better is to just write the
> > recommendation positively and clear:
> >
> > Use the corresponding function without __constant_ prefix, e.g., htons
> > instead of __constant_htons, for any use in files, except
> > include/uapi/.
> >
> > Are there other __constant_ functions in the code base beyond all the
> > ones you listed? Then, we should explain why only those above and why
> > not the others. Otherwise, we can keep the list above quite brief, and
> > just say all __constant_ functions can be replaced by their
> > counterparts without __constant_ prefix.
> >

So, as Lukas said, I came up with this updated explanation for
constant conversion:

  **CONSTANT_CONVERSION**
    Use of __constant_<foo> form is discouraged for the following functions::

      __constant_cpu_to_be[x]
      __constant_cpu_to_le[x]
      __constant_be[x]_to_cpu
      __constant_le[x]_to_cpu
      __constant_htons
      __constant_ntohs

    Using any of these outside of include/uapi/ is not preferred as using the
    function without __constant_ is identical when the argument is a
    constant.

    In big endian systems, the macros like __constant_cpu_to_be32(x) and
    cpu_to_be32(x) expand to the same expression::

      #define __constant_cpu_to_be32(x) ((__force __be32)(__u32)(x))
      #define __cpu_to_be32(x)          ((__force __be32)(__u32)(x))

    In little endian systems, the macros __constant_cpu_to_be32(x) and
    cpu_to_be32(x) expand to __constant_swab32 and __swab32.  __swab32
    has a __builtin_constant_p check::

      #define __swab32(x) \
        (__builtin_constant_p((__u32)(x)) ? \
        ___constant_swab32(x) : \
        __fswab32(x))

    So ultimately they have a special case for constants.
    Similar is the case with all of the macros in the list.  Thus
    using the __constant_... forms are unnecessarily verbose and
    not preferred outside of include/uapi.

    See: https://lore.kernel.org/lkml/1400106425.12666.6.camel@joe-AO725/

Can Lukas or Joe confirm this or have any comments on it. I can send
an updated patch then.

Thanks,
Dwaipayan.
