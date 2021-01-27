Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE53062DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbhA0R7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbhA0R6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:58:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D817C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:58:08 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z22so2746086ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzaDeSiNyFATYWMonrT6PBY0MxStPQSahy/WY/iIwL8=;
        b=eUI8GsuZtZDcqVh/6RmV4P0MXv1Da3hyuYGsJStk4tZO/iWF9NNqWecNR216YbKsK2
         xUJLIVAFfV7B7gyrQqnqra7mI/4sl83xShGqqijcb8oEG8NzWs+RRvJU1NdE1yc9vgIs
         Fokh42k8E4lMwgEet5cTDv8vWKfgJq3YXyUgydx/nceJMbNrwgsfcx/s+65ASlHJ4Jo3
         oEnJwT4dKjvelj3BwbXiHOWLr2B90q/UYpIuCwvJaKgBcF+H1utWhft3yOclc26ny/nZ
         sh8lDVoe6NsWg+8TUr+CGYq6QMwh+OnkqSoXI0HqYQvV1xWsVpdg7noNLIGQl15JYyRm
         xQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzaDeSiNyFATYWMonrT6PBY0MxStPQSahy/WY/iIwL8=;
        b=SpZP0tsHPW9qx8bkhybtrp6F/xR11BgHQ5Hp2EC9RH1guPT/e9RB/1ffhmTt25m/dO
         /yz7vtWHq6sJIH4zpi+308V2ymGABk4yns+eRWpCteJtl6X3xjSHOuNczEM7+k5tebmT
         KJIUohe4C03AF/3Zgct89bhLL4DGzV4BsJUqyPZ5Xzr4hCWxty/MxIqbByXI8sV9TH4L
         sZjbo25jym6JJsmJkoXBC0XNEofRbKE5x7ohBR0CGWRxBwMB7QXVUVNDNLZgiHvr5wor
         QvU1c5OfgBQRQzKXiA2eYTRcZcVr3jjq8JtKFJ2UEc0/KqK0rLuHSvsA1U5mcaqG5HAt
         XaDg==
X-Gm-Message-State: AOAM533edtNlW55Pdk9FL1T0c8e/SN70oaQbSgmPKj7mliRZmu3wJoo2
        UoAvO/ZyHFvxGocISL+4QTM5uRyaGZ9WOBVGVJ4=
X-Google-Smtp-Source: ABdhPJzXVWUlCcIwN/6MIz+tU5w1WqfLFSBqWv024ijF6WLsDfvM4/a+ZscCIMQpKPjfdsSbmdf4v6GeZY5m24G0IO8=
X-Received: by 2002:a6b:3115:: with SMTP id j21mr8371438ioa.55.1611770287690;
 Wed, 27 Jan 2021 09:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-7-paul.gortmaker@windriver.com> <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
 <YBCMk8ip4fyORSs3@smile.fi.intel.com>
In-Reply-To: <YBCMk8ip4fyORSs3@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 27 Jan 2021 09:57:56 -0800
Message-ID: <CAAH8bW87PBxjoP0vsHi7JjC-VTML5yZX9+i8dGo3DiYQ4cw2=A@mail.gmail.com>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 1:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 26, 2021 at 11:37:30PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 26, 2021 at 12:11:39PM -0500, Paul Gortmaker wrote:
>
> ...
>
> > > +   if (str[0] == 'N') {
> > > +           *num = nbits - 1;
> > > +           return str + 1;
> > > +   }
> >
> > But locating it here makes possible to enter a priori invalid input, like N for
> > start of the region.
> >
> > I think this should be separate helper which is called in places where it makes
> > sense.
>
> Okay, N is 31 on 32 core system... It is a bit counter intuitive, because it's
> rather _L_ast than _N_umber of CPUs.
>
> Changing letter?

No objections.
