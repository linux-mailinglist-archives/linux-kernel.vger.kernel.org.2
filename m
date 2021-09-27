Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2703041A182
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhI0Vub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhI0Vu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:50:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E852C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:48:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so84090414lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQziuvBfMARHu13Vd8UtdQcVHSAZAA1BW8ACAK1SnhE=;
        b=NGpFDJkITm1KfPEm3AGsnSRalQF0DwNDYxx0+9BDd5ChQE9kL6NB5KDsHAmMwVhIgP
         ACUY3BOQZVr6hHMpD6sr5qPQZLozbKu6ibg2WhIpWCB9r4XzmqAuaSYsBT/322WUD+gn
         t8lLVz5wiX7/CJTHCNVlutwPKAddZlDG1Dejg+c5P/TrWhUHDXuBN5q1PWTmbTI4VIto
         qsCm/jmnE30fATndaSCtSCkRj9+cQGETpJAdy091YpXA87AUrsFUrbi6wMN7NyuZvYGj
         UIOw6K7hzQFtdWHvMK2T8QFeL10xFIzxJr0+5y1YxIEK0t4MMs8X26ytL8QTcYvhguRp
         qt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQziuvBfMARHu13Vd8UtdQcVHSAZAA1BW8ACAK1SnhE=;
        b=c7zmsORRse75AZq0N4W0CnubM7noVrm6NH2jxe57sOqENpI3ytxbxql/gmvRU7+sd+
         5rSnhoMarTswgyEN6bMN7oltff1IF3Wh5hHP9NWc5rm7nxyFtZYScBtLDzq/lHmQABtf
         mSPZszSBd09EZ9s1ZVfmsVl8h566UqXodJNA19BAKCzMCwWdvty9vncttazA4ixBV58+
         GtCED+NKgdWNenk2ISxGcf9WfevZpnMG/+1McgwkcRuowgKfnuBuY3ZNXIvCNiO8s3NO
         MWS0/704rm4hWbm7tUwJHNYvJ/+1NauD2jS+ZD291KeHqPTudsODUbMtgV4Wg7S2JbjN
         PptA==
X-Gm-Message-State: AOAM533XQfMdcR0dsIcatl0mbBjbWvaTE2ATHuU4CbjCgCGKzdEXVY8b
        +rrCkdQKzw27xaYvXPUSbJXADGOlDw9DVs8ZfG4F6w==
X-Google-Smtp-Source: ABdhPJxP+ChpDdQIABcI5f3CK9us5oK3lnIFxWcqw0cBy+9IUsI6SeIO9UhwDiMik2DcBMb6VXtvjgnuaa+Js+P7ih0=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr2204795ljd.128.1632779325708;
 Mon, 27 Sep 2021 14:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
 <20210927214715.GE964074@nvidia.com>
In-Reply-To: <20210927214715.GE964074@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 27 Sep 2021 14:48:33 -0700
Message-ID: <CAKwvOdnmbLO3+8jwwyoS3Cw_wSfr18Zqf3QyHpEJN5Dok46CQg@mail.gmail.com>
Subject: Re: Linux 5.15-rc3
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 2:47 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Sep 27, 2021 at 10:48:42PM +0200, Sedat Dilek wrote:
> > [ Please CC me I am not subscribed to LKML and linux-rdma ]
> >
> > Hi,
> >
> > with CONFIG_INFINIBAND_QIB=m I observe a build-error since Linux
> > v5.13-rc1 release.
> > This is with LLVM/Clang >= v13.0.0-rc3 on my Debian/unstable AMD64 system.
> >
> > For details see ClangBuiltLinux issue #1452 (see [1]).
> >
> > The fix is pending in rdma.git#for-rc (see [2]):
> >
> > commit  3110b942d36b961858664486d72f815d78c956c3
> > "IB/qib: Fix clang confusion of NULL pointer comparison"
> >
> > Dunno if there was a pull-request from linux-rdma folks.
> > Cannot say if it is worth taking this directly...?
>
> It should come as a PR this week, I don't think we need to do anything
> special urgent here, do we?

I think that should be fine. Thanks Jason for doing so, and Sedat for
help testing/reporting.
-- 
Thanks,
~Nick Desaulniers
