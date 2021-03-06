Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605432F8A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCFGZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:25:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A65C06175F;
        Fri,  5 Mar 2021 22:25:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u8so4363168ior.13;
        Fri, 05 Mar 2021 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdO1rf7D9EsXwVNciVZC9BRLn0JylmSd2lI++KNulbQ=;
        b=GaG/tbR38USl4WlqilVcCQVEmq0VZF26liI+vquXhzo/Bw30snBaYBdpqe6V0LYoO/
         b36VvrgbYtu8mrhEYqtKiSTAPyl/HrnyK0x/ISUQHuAE8tYCpKz7T1YbeZuRKpMUHZgt
         DHuufiyvtDKUohdVMA/Z/QNlhiIG7FuJZGp6a5R8QU9hxkAoewj+Rxq1JSgsqMkhTXKF
         kCczUhf+s9Wi8P77ZO0vIGW2ZTsRl4LRQt01y75rl1KB3l2Hmfdo3JYLvB0nq9YRouDL
         DK6viUNjy6zeuab+a7SUQ577iBQbO/HpC6F8sW7leaadWH1PsJofMIWzebMLFY/KpNxf
         hOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdO1rf7D9EsXwVNciVZC9BRLn0JylmSd2lI++KNulbQ=;
        b=cmh0cEsHisO/+3T12UqEcT2hcE8hpxFnpQaYF7xjB6Lee41gwvcBcqREghi2YgicQ7
         hdhU9agr9yFRVM7YnKmwzt8Nwp/JedkN+t0Nu7+BLVov4uBiE2mAKWAnn80pyz6mIYYE
         THcwd8MFisCCZ7qggEplQ4bSh0rGy+k7UkIorBY30dHbbmfsc2wYnCAe3MfwcReNDZZT
         M9OQPf47Wxoq1KK4YvGORFN6hey7SZFiWACwO0EAhLJnLzcUTMZxd0QkNZpLwWfGGVvS
         QpuyYWkJPQx/z5iX7V2fbeYS2ATdMZs9Ecgwm1GbqMjupS/hnouA706lnZxN85ryZCa/
         C/UA==
X-Gm-Message-State: AOAM531lB5lNmP6Efz/kSs4vnPu75vRozAdM+fJw2iWDud7oOgl5br/Q
        9aRcp/4a3nn/O5t231Z24FxT5BuCQHzLOjdbz9ma3UCW+Cc=
X-Google-Smtp-Source: ABdhPJySV6iVcfmYrhCE3WKy3pV/m8SSKIZfQh7oC8hC2RiqNpAIeJ1i5Q9UPudju7pmM9R2mzcWMLCvvmuXy3m5GL4=
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr10716369iok.183.1615011936034;
 Fri, 05 Mar 2021 22:25:36 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
 <20210225145033.11431-1-yashsri421@gmail.com> <20210306043548.GO2723601@casper.infradead.org>
In-Reply-To: <20210306043548.GO2723601@casper.infradead.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 6 Mar 2021 07:25:25 +0100
Message-ID: <CAKXUXMwD_ZZA7EJaxZBRfMDEvwd4Ghsj2vy9KCfj0R-yx2_K0Q@mail.gmail.com>
Subject: Re: [RFC v3] scripts: kernel-doc: fix typedef support for
 struct/union parsing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 5:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 25, 2021 at 08:20:33PM +0530, Aditya Srivastava wrote:
> > +++ b/scripts/kernel-doc
> > @@ -1201,12 +1201,23 @@ sub dump_union($$) {
> >  sub dump_struct($$) {
> >      my $x = shift;
> >      my $file = shift;
> > +    my $decl_type;
> > +    my $members;
> > +    my $type = qr{struct|union};
> > +    # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
> > +    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
> > -    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
> > -     my $decl_type = $1;
> > +    if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
> > +     $decl_type = $1;
> >       $declaration_name = $2;
> > -     my $members = $3;
> > +     $members = $3;
> > +    } elsif ($x =~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/) {
> > +     $decl_type = $1;
> > +     $declaration_name = $3;
> > +     $members = $2;
> > +    }
>
> In the same spirit as dump_function, would something like this work?
>

I agree. That might be a suitable clean-up to keep the code for
functions and struct/union parsing similar in style/spirit.

Aditya, would you like to create a patch for that?

Lukas
