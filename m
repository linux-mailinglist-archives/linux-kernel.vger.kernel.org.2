Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C0358CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhDHSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:43:22 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B3C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:43:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m13so3176540oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz3WWuK9ivXqRhBUKbaDFsjSTwxUZn+PwdntH13EvCw=;
        b=DbBileZum6NPWyRUsnKHXhoKhh2fInnvgwtIvDU/8h7plDhuw9afWA8Z5GD/CQHEFK
         1ETTbXqNveHagQMeZ/gFmjL5PW+9qPqh1GWSPJ5X9AHDqN4xefCLYUqJ9sFp+XG21ixP
         VwCA8OBYbqgLhVJHTlyTDA488oquEbtHKdE/4wOUmtAt2/YDKYufenBjhbIcWAqDR1gW
         ALUomhvjTYTcQdtF5Hn1QBtRlQGimHsfhy4Am02P/bJrtVgnNUIiaP5T3swyOXWpNaRO
         1nDGNslFuwfXpR/k1P2Y1Af+4tVgYy9ek6zLLMb7BhFvtrqPeuv5Ub2K2JPyUrdw/mts
         7S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz3WWuK9ivXqRhBUKbaDFsjSTwxUZn+PwdntH13EvCw=;
        b=Srq6rQyHVGCUqQr0XFGVUa9/x6LSSvmgUXxH0nFl+Mh7s0XfZ2dUVwHEqg6pp3bxsX
         T/TwWxh9farKypLoww+FOD/76QZ9C29qFlYHUF+AM/uQ3n+/m7PAJqUTvQieTAXiSACc
         4GY0iFQrQN4SrpZw/JEiwQUJ3QXHYsITqmoDBDbxCwQCZoDodBNZmjDW+AQ0PoOFlrlN
         bMa+aFKMrnsOAkA1A8uh1nzTWq/YlbWN6DS0h5DO06zcBWVYdQ3zVRbc//sJhz1I0A4F
         6vEXxHYivIPoqUk+iihqnLtgT60gcaM4oq3kaT4ZGOJE0u/u8yhcaboKhcyUGIu1rlwZ
         IVJg==
X-Gm-Message-State: AOAM533q8mc/jtu9wze6x/TFdlbXCkRRqybuHuqBoFIhArqJACiXUhcx
        d1+IvkNa2FOjEvwVNPj8BAr1cXf4hoT74H750mUVAw==
X-Google-Smtp-Source: ABdhPJy9Ku3eTj9dWwFpWk3KqO98Kfjyb5zklca3BbhqxQRoWIUDqAOjDX5ELf/1GOFSJJBLXNtG3a0e18eWBL6X8rE=
X-Received: by 2002:aca:2b07:: with SMTP id i7mr7444647oik.66.1617907389872;
 Thu, 08 Apr 2021 11:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
 <20210331215802.r4rp6wynjqutdoup@archlinux-ax161> <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
 <CA+SOCLL67K=reMX=pBQzRV6dYbbS6EPVeOxZ8Xdw90P91Zb8Zw@mail.gmail.com> <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
In-Reply-To: <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
From:   Jian Cai <jiancai@google.com>
Date:   Thu, 8 Apr 2021 11:42:58 -0700
Message-ID: <CA+SOCLKC+7BS+-Cd+y9PQsfKADMQeYrzumRzb=oCuQmmxR6TPw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

Sounds good! Thanks for the help and the link.

On Thu, Apr 8, 2021 at 11:12 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Jian,
>
> On Thu, Apr 08, 2021 at 10:57:54AM -0700, Jian Cai wrote:
> > So this issue is blocking the LLVM upgrading on ChromeOS. Nathan, do
> > you mind sending out the smaller patch like Nick suggested just to see
> > what feedback we could get? I could send it for you if you are busy,
> > and please let me know what tags I should use in that case.
> >
> > Thanks,
> > Jian
>
> I will go ahead and send the smaller patch at some point today.
>
> For what it's worth, Nick brought up https://reviews.llvm.org/D100037,
> which may be relevant here.
>
> Cheers,
> Nathan
>
> > On Wed, Mar 31, 2021 at 3:06 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> > > > >
> > > > > I just realized you already proposed solutions for skipping the check
> > > > > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > > > > Do you have any plans to send them for review?
> > > >
> > > > I was hoping to gather some feedback on which option would be preferred
> > > > by Jens and the other ClangBuiltLinux folks before I sent them along. I
> > > > can send the first just to see what kind of feedback I can gather.
> > >
> > > Either approach is fine by me. The smaller might be easier to get
> > > accepted into stable. The larger approach will probably become more
> > > useful in the future (having the diag infra work properly with clang).
> > > I think the ball is kind of in Jens' court to decide.  Would doing
> > > both be appropriate, Jens? Have the smaller patch tagged for stable
> > > disabling it for the whole file, then another commit on top not tagged
> > > for stable that adds the diag infra, and a third on top replacing the
> > > file level warning disablement with local diags to isolate this down
> > > to one case?  It's a fair but small amount of churn IMO; but if Jens
> > > is not opposed it seems fine?
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
