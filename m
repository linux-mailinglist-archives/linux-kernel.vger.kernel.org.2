Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304C325DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:57:51 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:57:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m22so12372310lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTghAYC+gRhrAARfUZ1trTPRu51XeejlsuQaOFCWN7A=;
        b=susevJATkTe7C57QpZVMpR//EDKwOOqnHDssM2XTs8U8PRxcs6OK8NSe3zdGl9+mHE
         xvfWZQfYXJR2SlV8oPP2jIufFa6C9paGbp4q1LTcF+ily8Cu0eMDapLU7xn8+gxRzyam
         /2qCvHmLtq46Vv1Ncj6xZ2QTmb5QbtdBzlYaQGtk4sdK/lnPk/4ObcjCYQiW+yJ4vcnJ
         SSzmeAvQ7Pm/WGKP0BgA9mfopaQapYA2eP9rpWHK/osOvGuK+ONiRM3zBmbqqon64Bon
         TqahnkV3PnLb0TeF+ZHtc0waxmx1zcyUmBj4ruENZq0jdgoUz7vrSSeW4TsBlaY/FK0u
         s8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTghAYC+gRhrAARfUZ1trTPRu51XeejlsuQaOFCWN7A=;
        b=ZwaqtixoLcrLciE9bH1EelYVUDcfH2V+1Rx6Ks6+UKYN6xJgZi2/BH+butYgZPVf9z
         qaYdgtFmlZcB0+mYT+IbzK3BDx49csoinPg+BrqhoYOe2S8QSnfuT60zC5M2oTE4uc92
         AERcwxuIYJjq7EdRCkFKx5G5tOG+/LIa0/14J5pJ3/Erh8pzSuvzd2UNLItD/diwHAOl
         bFvWuTjUUzcPWr+a/rFq9AOadJYEheMMLINDjoGPg4bmD1Ru+D3BZFL/bKWfOOjHcixH
         AXvd6e7F4TptksK95xM161Wk+h36RXJdEzUo8xt8VdQlOgq/jTsoEROte50qXA8dUrVu
         820g==
X-Gm-Message-State: AOAM533iiFi6DW431t+PR3qjaOBiRbPUiOAIvJAMY24YUImefsp40OFZ
        VieuoZ3ZYE91h06OPka+P3UYd1jLF6Fo84fh5dQfWg==
X-Google-Smtp-Source: ABdhPJwf/fs8KdhYyBibGWfVILQtI0qi3lSGoT+v/KGNx294ah6iU6SvE/8TrjPwmnrmOf7hHXXyIaccIncYV+Orh+M=
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr960635lfd.84.1614322629317;
 Thu, 25 Feb 2021 22:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20210224081652.587785-1-sumit.garg@linaro.org>
 <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com> <20210224102052.009aaa27dd5b530d7e7ef599@linux-foundation.org>
In-Reply-To: <20210224102052.009aaa27dd5b530d7e7ef599@linux-foundation.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Feb 2021 12:26:58 +0530
Message-ID: <CAFA6WYN===hi_6w=zhXKT=iCAyMkXvi0OwvZb3bbsZpUeeFg-A@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 at 23:50, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 24 Feb 2021 10:09:25 -0800 Doug Anderson <dianders@chromium.org> wrote:
>
> > On Wed, Feb 24, 2021 at 12:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Currently breakpoints in kernel .init.text section are not handled
> > > correctly while allowing to remove them even after corresponding pages
> > > have been freed.
> > >
> > > Fix it via killing .init.text section breakpoints just prior to initmem
> > > pages being freed.
> >
> > It might be worth it to mention that HW breakpoints aren't handled by
> > this patch but it's probably not such a big deal.
>
> I added that to the changelog, thanks.
>

Thanks Andrew for picking this up.

-Sumit

> I'll take your response to be the coveted acked-by :)
