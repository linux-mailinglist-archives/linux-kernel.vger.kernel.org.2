Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDDE352FE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDBToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:44:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281FC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 12:44:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so8729657ejv.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiERDmIswX/YbKPoqhHgYspY/vKtrQPWIrw0P2V6W+s=;
        b=Hmgox/vUxNLjiNg4Lyt+zxYanpHpfJvwky9P2pm7/9dQi9UttYnr28Di80kM77uS/B
         qpxopO5Di7QIXj6m7SpUJ6siSKibKkoPOViA7IMybAFZSRqFsa8X2dLOtGnCtKp3+cx1
         PkDVvH/kbmQ+edxq4CIbMzuBGbA9bApQvfDUNCA+7cGvdNtNIaq3yMqZy4b4KtLnQVda
         P5fD7zUYvV1+yki97JGDuKU4kVQvyDDGoNlqCvZ2BQ0Qu3ltbCFFBKsRXhUg3VGGmdvG
         7DaYffCCQCIqxONPMFbqD2TTG+AWUna5CAyNQ3xUM2Y4oSGzfJwIZ6fYt9VihG4ap9vR
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiERDmIswX/YbKPoqhHgYspY/vKtrQPWIrw0P2V6W+s=;
        b=a7XUD+l//CIG+pMA4MXsWzrb6g/5Roocn0tRCAlxsbZpA/D5t9mbSEHbQLFyGHlM42
         Ov+Nr3x/dgDcuuka27U9oJVIqwssGH5nnBiWW4wPtKdT0WDdtpbzlJXbqpZcb28l8YyC
         Mu0VPPhPbcerzGR+gAk2JvtpxW9TgvhtPLq9b8hsZhpzbVWZn/cGUyugRKgTZEpT4+pF
         7gMl4L8qEI+6+q6pGmK1ZwrVUC307diHyRAaCWchFnYJdCYlwoY1pS8LN51A4U6XvHIl
         WHxhtLHQqizH/xSpsRRaDY9ryXOPwz6Kxuxc3n/BOJLcLcop6LreARkclY6f2N+T2mre
         QDPw==
X-Gm-Message-State: AOAM531Gx4KpWfQ26SZL/DZqZdJtIoKhI1/0xp17jGzABnCsmBXhTIsA
        o8kZ02v7+1aa1UN6DPi1CiyJ3y/oh5tH2mieKSPFXQ==
X-Google-Smtp-Source: ABdhPJyjmy5gewZQqdxToBwHVY1mC0M0nHR8ON01DDONzarxzy6EbuSlksy+QYvCbloFyRWmcAYtKGFO33xKlzQipWI=
X-Received: by 2002:a17:907:10c1:: with SMTP id rv1mr15707542ejb.5.1617392647440;
 Fri, 02 Apr 2021 12:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210402094042.9218-1-gi-oh.kim@ionos.com> <CAKwvOdkFJ_WFpt2+rnNR3tbrdFky2NnEOWSG7MhgLrBHJAOEVw@mail.gmail.com>
 <202104021122.7896C66@keescook>
In-Reply-To: <202104021122.7896C66@keescook>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Fri, 2 Apr 2021 21:43:31 +0200
Message-ID: <CAJX1YtZTr246sG5zs15apHw_EdfQeOWCFPG=z_ePoQ3BXDQY2g@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 8:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Apr 02, 2021 at 11:17:13AM -0700, Nick Desaulniers wrote:
> > Thanks for the patch!
> >
> > + akpm (please remember to run ./scripts/get_maintainer.pl on your patch files)
> >
> > On Fri, Apr 2, 2021 at 2:41 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> > >
> > > As the name shows, it checks if strings are equal in case insensitive
> > > manner. I found some cases using strncasecmp to check the entire
> > > strings and they would not work as intended.
> > >
> > > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > > strncasecmp to check that the input via sysfs is "mi". But it would
> > > work even-if the input is "min-wrongcommand".
> > > And also drivers/pnp/interface.c checks "disable" command with
> > > strncasecmp but it would also work if the command is "disable-wrong".
> >
> > Perhaps those callers should be using strcasecmp then, rather than strncasecmp?
> >
> > Also, if they're being liberal in accepting either case, I don't see
> > why the sysfs nodes should be strict in rejecting trailing input at
> > that point.
>
> I think this shouldn't be prefixed "sysfs_" -- name it for what it does,
> not where it gets used, if it's a general utility function.
>

I think sysfs_streqcase is another version of sysfs_streq.
That is why I use "sysfs_" prefix.
