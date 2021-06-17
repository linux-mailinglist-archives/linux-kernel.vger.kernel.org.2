Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D13AB30D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhFQLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFQLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:53:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D489C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:51:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q20so10060482lfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAQVkmDM9ks63fpAXt6D/ILvK6PyLHBYSS0DZBxRCs0=;
        b=G1n2nMMgdFMZmLdYpzf8ADnIx5QYjQJK5kMpIwzOyf95zQbz0lsEdME2FrnRnzlrU7
         8ULRSEL/JSqomxeu3dJwFcjct8zaRnneogXxgiI7D+vSno8dxIvV3/6N00udo2IBz0j1
         WpXzzb6CH0AfEtK8kAA5rNVeYJI5FCJsQY2lAPuH4SBEKCFV2MvsQPiboITpD920IWXO
         NrRsV5cirP/a0BOsJ0vi8Yvw24BOhxL9lkssRH1d/Q5AeZKPvBfLjwGIr+QY/3cG1tTc
         0wEJZ5HXK+F9jerOqBc6+0bYL7o90olY4KWm8XQ+rnz+uCDu2NJbisnoYsBvNOXBu0bz
         VqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAQVkmDM9ks63fpAXt6D/ILvK6PyLHBYSS0DZBxRCs0=;
        b=Rjlecvx92T8SmInUKNVtamGcXwJwwPIpGxNtSE9GkDzzDOmFm/fG3TC1p+haHJRk2Y
         IAN+z3wPB99v64I/mOK08QlAuRpEQyLq9XFfE2dYc5wqAFmEj0SEHF9N8BL+BFCAhM3K
         NxNTNp9dwniC/raizsjOAmuTVYW2WWx3jmwgG3zvJ6HkIaRIoLf3fx743AwNifd+lHF7
         caqHeR8lV17LyAj6HkIRwOssUNxX7mz642aD15/OJA4h2byqqqpsFEKJsEzVoDcCJzxq
         i73ant8iSEug6JXqh5NSYI0UY9kLDcmQtrMUo3+shPoMpqg1hnlf8J2F2dtaUFDueiTK
         feeA==
X-Gm-Message-State: AOAM5339UPqDXwMoKLojPhxlNM6+10PJ75LbFxTk3nxze8NhgiclNlBg
        KsET9QiHFwN5g1hKFUovqu6o2zW+dBa6jr/iZcWqvQ==
X-Google-Smtp-Source: ABdhPJwRKYxuP38B7YEuESBN95sdva4iXFbQlSSOipdD/6xspoqdwOBv6yLo2BuRzpN3ts1CvK0/elWlh51QVNp3uC8=
X-Received: by 2002:ac2:5396:: with SMTP id g22mr3701413lfh.84.1623930683579;
 Thu, 17 Jun 2021 04:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210323065519.821062-1-sumit.garg@linaro.org> <20210617112527.nganuruifprwhv3h@maple.lan>
In-Reply-To: <20210617112527.nganuruifprwhv3h@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Jun 2021 17:21:12 +0530
Message-ID: <CAFA6WYMwRr5iO3uv_8sSocPYhBBaxEN-M+J3GCze5UvtkeUyzw@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 16:55, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Mar 23, 2021 at 12:25:19PM +0530, Sumit Garg wrote:
> > Currently the only user for debug heap is kdbnearsym() which can be
> > modified to rather use statically allocated buffer for symbol name as
> > per it's current usage. So do that and hence remove custom debug heap
> > allocator.
> >
> > Note that this change puts a restriction on kdbnearsym() callers to
> > carefully use shared namebuf such that a caller should consume the symbol
> > returned immediately prior to another call to fetch a different symbol.
> >
> > This change has been tested using kgdbtest on arm64 which doesn't show
> > any regressions.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I'm afraid the passage of time (mostly due to my dropping the ball)
> means this no longer applies cleanly to latest kernel and `git am
> -3way` tells me that "sha1 information is lacking or useless".
> Please can you rebase this on v5.13-rc4 and repost?
>

Sure.

> Also...
>
>
> > diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> > index b857a84de3b5..ec91d7e02334 100644
> > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > index b59aad1f0b55..e131d74abb8d 100644
> > --- a/kernel/debug/kdb/kdb_support.c
> > +++ b/kernel/debug/kdb/kdb_support.c
> > @@ -57,35 +57,26 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> >  }
> >  EXPORT_SYMBOL(kdbgetsymval);
> >
> > -static char *kdb_name_table[100];    /* arbitrary size */
> > -
> >  /*
> > - * kdbnearsym -      Return the name of the symbol with the nearest address
> > - *   less than 'addr'.
> > + * kdbnearsym() - Return the name of the symbol with the nearest address
> > + *                less than @addr.
> > + * @addr: Address to check for near symbol
> > + * @symtab: Structure to receive results
> >   *
> > - * Parameters:
> > - *   addr    Address to check for symbol near
> > - *   symtab  Structure to receive results
> > - * Returns:
> > - *   0       No sections contain this address, symtab zero filled
> > - *   1       Address mapped to module/symbol/section, data in symtab
> > - * Remarks:
> > - *   2.6 kallsyms has a "feature" where it unpacks the name into a
> > - *   string.  If that string is reused before the caller expects it
> > - *   then the caller sees its string change without warning.  To
> > - *   avoid cluttering up the main kdb code with lots of kdb_strdup,
> > - *   tests and kfree calls, kdbnearsym maintains an LRU list of the
> > - *   last few unique strings.  The list is sized large enough to
> > - *   hold active strings, no kdb caller of kdbnearsym makes more
> > - *   than ~20 later calls before using a saved value.
> > + * Note here that only single statically allocated namebuf is used for every
> > + * symbol, so the caller should consume it immediately prior to another call
> > + * to fetch a different symbol.
>
> This still looks like it will confused experienced kernel devs who
> aren't aware of kdb's calling context. Nor does it help future kdb
> developers understand some of the subtlty of interactions here.
>
> Can you enlarge this to the following (editing anything below that you
> don't want git to blame you for ;-) ):
>
> ~~~
> WARNING: This function may return a pointer to a single statically
> allocated buffer (namebuf). kdb's unusual calling context (single
> threaded, all other CPUs halted) provides us sufficient locking for
> this to be safe. The only constraint imposed by the static buffer is
> that the caller must consume any previous reply prior to another call
> to lookup a new symbol.
>
> Note that, strictly speaking, some architectures may re-enter the kdb
> trap if the system turns out to be very badly damaged and this breaks
> the single-threaded assumption above. In these circumstances successful
> continuation and exit from the inner trap is unlikely to work and any
> user attempting this receives a prominent warning before being allowed
> to progress. In these circumstances we remain memory safe because
> namebuf[KSYM_NAME_LEN-1] will never change from '\0' although we do
> tolerate the possibility of garbled symbol display from the outer kdb
> trap.
> ~~~
>

Okay I will use this comment instead.

-Sumit

> Thanks
>
>
> Daniel.
