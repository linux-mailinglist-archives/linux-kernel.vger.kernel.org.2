Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B507F358BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhDHR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDHR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:58:19 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA7CC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:58:06 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id h2-20020a4ad7420000b02901e5901169a5so480190oot.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjjtxfZDaRiLXHBjXX5lq0Oke8MJeuPXuGP2r18boHY=;
        b=cT3vv+ZiDCbDV/FET0fxhkXBCZwdGl378BVLqXWtyciSxd8qG9WbC0+lMNJqLouBPF
         U2zhvH2eGr9xr5Wys9tvjQJ2+6qD/7OhQUVtOb7juPLrhLMsfKZ4W6CMc8OFMH1SuJym
         ISZlXnl5KlkoIIJM4H65TfDi17FDCAOeYcnhJPSwefWcio9hQxCLjfXIETVwZrOxFtug
         jCYqSgVS6klH/hRpUKUMUoKHS+ASjEp5iY2n1eLLsoJSlI7NIu5atKcwyZ8RDEvoAcWT
         aMZzgIyOGnnK1aY9wh4P/aqYo7Fgw7xnTftGluo6ehffXb0DWRuM5i3M1Bkxn6YnrxRi
         o8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjjtxfZDaRiLXHBjXX5lq0Oke8MJeuPXuGP2r18boHY=;
        b=N8PRPxCNf0nVqsO7hUJHlvUUoE3I88zYMBQx5kE/cmjOHGO2d2h0yqfW1pm7cQrQLJ
         zJINqF7D/20zijRiTpXISJ6OQniC7zAACxGiJ3T70VcRS2UaSkntGUYaNtnbG5m0PsUk
         3E4BSOyQPIpbMgj/bhFMqlOZRaGImX+DnAl14uQbvnhAPNzNlXmkikIr6DFjZtNSl0GB
         jEF+Dkpkbe9xTszmtPYusok8X+o+/hxZl//vqQSfn/cmhRKcRYE3RCj+IsLOccsli0pP
         9s3TWjsSejN8nzztnqVxLjHBu+KrujwR/3j6lK1bVYBZbOyR1RDkX54JXfzWdTVObMoo
         fmbA==
X-Gm-Message-State: AOAM533ytFST+1udJl1MNAwd4ZZ7rzrKoycu8phCO33vbo95bTqNpo8e
        +Ss4LCYipiPxhXw/Fwm5snSfNan1XxYSMk9ho3emNw==
X-Google-Smtp-Source: ABdhPJxxMXmWAigVetBbknCH4DYF1uDfItCk4A0H0BbWtzHTerVhk9pCqqb2Pc+RcoMsAzg5s1ehu5zhwwNheHliE4U=
X-Received: by 2002:a4a:e6c2:: with SMTP id v2mr8545609oot.74.1617904685371;
 Thu, 08 Apr 2021 10:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
 <20210331215802.r4rp6wynjqutdoup@archlinux-ax161> <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
In-Reply-To: <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Thu, 8 Apr 2021 10:57:54 -0700
Message-ID: <CA+SOCLL67K=reMX=pBQzRV6dYbbS6EPVeOxZ8Xdw90P91Zb8Zw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this issue is blocking the LLVM upgrading on ChromeOS. Nathan, do
you mind sending out the smaller patch like Nick suggested just to see
what feedback we could get? I could send it for you if you are busy,
and please let me know what tags I should use in that case.

Thanks,
Jian

On Wed, Mar 31, 2021 at 3:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> > >
> > > I just realized you already proposed solutions for skipping the check
> > > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > > Do you have any plans to send them for review?
> >
> > I was hoping to gather some feedback on which option would be preferred
> > by Jens and the other ClangBuiltLinux folks before I sent them along. I
> > can send the first just to see what kind of feedback I can gather.
>
> Either approach is fine by me. The smaller might be easier to get
> accepted into stable. The larger approach will probably become more
> useful in the future (having the diag infra work properly with clang).
> I think the ball is kind of in Jens' court to decide.  Would doing
> both be appropriate, Jens? Have the smaller patch tagged for stable
> disabling it for the whole file, then another commit on top not tagged
> for stable that adds the diag infra, and a third on top replacing the
> file level warning disablement with local diags to isolate this down
> to one case?  It's a fair but small amount of churn IMO; but if Jens
> is not opposed it seems fine?
> --
> Thanks,
> ~Nick Desaulniers
