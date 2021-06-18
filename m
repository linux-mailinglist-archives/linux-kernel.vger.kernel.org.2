Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA843AC0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhFRBxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFRBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:53:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A12C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 18:51:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r5so13728544lfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UaP7fpSAvejmoUQnJtHQRdOKJTRjKU7XpX0CXF1/h8=;
        b=edaHJ5LXCr2dEOcnGwz175/5dMvBRbZeYTk7Btle7vMoxvOA8UWlcaKY7kOy8tkXNR
         /zwq7afT0j7dXRPh168IaKKkrcv5jYKaGMrwXSQ0+6/pG6y4a1IhuDv+lN+jC/QMG3P9
         1QpodkbjXuyW1Jy/J7pMImeNlxNRbmKrafXooJ37pk5JwOJxI1/FzQHAF5ydk1q30+Ll
         RnLikL8YlQ/wXbl0lhb9TlsDPOvrJq/1EHM8CXXw8nc5KtC1hwRssllzgFUeE3uz/j1N
         kluM+L4OxGwPD+aBJBYQPolElag09NMz1bamZIckBwZ0brZ6+11yyrn2HtzGEWhcjAaJ
         zGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UaP7fpSAvejmoUQnJtHQRdOKJTRjKU7XpX0CXF1/h8=;
        b=sobvzfgS452fvonnm1YYWHRLR8yRO6khvu9kXN+CntOMSQXw+WNP1QA57veBWowY7e
         Tdu8lSVaZOJZ1rzLK4LxveRgFZTsbyCoCSkWcuUg/5DHLYoC/Yf9mEnsxK/yKi82Xveg
         se+UGIJOyn7S7ig9SLrZYZcHxls0vcb/6xqgxu5y4vb6yNFL20ghMZyGddSopWWA76QU
         W4tTxXBTrOCv3FQMksHkwNy2wkKtoiaiM7eOzIqOcdgEslrmKLLhmA3IGNdxIKoOo+8x
         pHWmnn+ZKgtz8sAOsFCGD9ZzCvNNm1LNcKzeKhzdHamOzNJjb0wDqr+q87MoWXJg7rjp
         jwfA==
X-Gm-Message-State: AOAM530rA2+31fS69TLCvw1iDccM2qOHMqipYDFyg3YPnsd36t8rcBXT
        omISc88gT+/CPn4yOAKoCzaJf66uWpfrDWTUyag=
X-Google-Smtp-Source: ABdhPJzREjRgfpawE8ZNxK2H9QBJxDW6oik6mzXZs3wq408HrkEWn1kF8TfkQavbT/U4pb+wwCzywPkvy5qRE9d6FYE=
X-Received: by 2002:a05:6512:1683:: with SMTP id bu3mr1087899lfb.520.1623981070056;
 Thu, 17 Jun 2021 18:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210617150523.454965-1-sxwjean@me.com> <YMtnf4lOEiF++32w@boqun-archlinux>
In-Reply-To: <YMtnf4lOEiF++32w@boqun-archlinux>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 18 Jun 2021 09:50:43 +0800
Message-ID: <CAEVVKH9RQmh7oh-bE4t5AaVYD_Suu+sHAr=WUEHupV1pP7-1GQ@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: correct the description error for check_redundant()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Thu, Jun 17, 2021 at 11:05:23PM +0800, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > If there is no matched result, check_redundant() will return BFS_RNOMATCH.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
>
> Good catch!
>
> Nit: you may want to capitalize the first letter after subsystem tag in
> the patch title, like:
>
>         "locking/lockdep: Correct ..."

Ok. Will update the patch.

>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thank you.

Regards,
Xiongwei
>
> Regards,
> Boqun
>
> > ---
> >  kernel/locking/lockdep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index cfe0f4374594..1f126ca7fbd7 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -2726,7 +2726,7 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
> >   * <target> or not. If it can, <src> -> <target> dependency is already
> >   * in the graph.
> >   *
> > - * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
> > + * Return BFS_RMATCH if it does, or BFS_RNOMATCH if it does not, return BFS_E* if
> >   * any error appears in the bfs search.
> >   */
> >  static noinline enum bfs_result
> > --
> > 2.30.2
> >
