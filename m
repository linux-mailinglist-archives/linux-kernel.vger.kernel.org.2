Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07C428A37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhJKJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhJKJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:55:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863AC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:53:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d9so41604437edh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJnQ1oTbprGYdIkFA4ySIUQFtDTFkncKqirdWOx0uac=;
        b=kRBvoqhKzNcoEEhEkPE6VTinGN5nfG0M2/tZNXFf7S+CG04r3Kz2wsO2CbwToW1+qb
         L7/S8W9iZZB/cTigI89EJwsdPG8PdrAo5xhrDl7636XCAAvXQm4CnFkIWeKIpcjMTL51
         35NUt88qI1kTElspZnE1tmqNfzW/2ZPoKjwGfAiiz6vd4xyN/i/JSl4wXqKu+JDA6hX8
         cUHLRbJVz9CVAc3KKIJ7coi6odbhRYt7gMGDVgNMn3B/uf6AHHRtrALuUillPxxEfIFn
         lH43TFd2U7HM9m+JA/PgVzQbMdaA1yNqV2y5Rf5T7IgViUKZhNrzmzirGVhPZmys9CL3
         085Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJnQ1oTbprGYdIkFA4ySIUQFtDTFkncKqirdWOx0uac=;
        b=vrDf56yhU1KDeMEN2kud0DakDVsZZSpk3cfVXlskRZnW7ESoqDET8I7JpAeQk3Tskr
         58wnsX+U78n5dqXsQbWsPLsCuLk25IX6kenxqYfSOYF5B+Ssq+YqWRARpQ/TexLd3SmP
         MIVZ3f8Z140LNIaG1fdk/TH86fJf/n2BBrS0V7QLwxwscoRxK3h+HEUyr2WzCUNOVcVb
         uOs19xH5odwQdNnuLqiFe74QwLI4Er8pWrwpbIlwm1a+cilymXHTh3Ndf0+3zh7Q/2R7
         64vHArVYdCiENfsalWvemwr3+dgQLt3KIk1erYULI1XXCnm2xZ9QKKJjNHLlnXBbi8RL
         EnRw==
X-Gm-Message-State: AOAM5334x5Pey5zR8HaVZw4VOfsvKLyiqUbYC6E7kfYD+BSmXgSD9Tgf
        nYBBpOgamR7ZrKBrw6qOrs1g/d5DJK0=
X-Google-Smtp-Source: ABdhPJwFKNBO/z+f5x/qmFDF3FynFeR0KZ2BJRvFUxzICuqd3Qeg4CND1yB+Bf+9aJnT8HqVKc1Yqw==
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr24613535ejb.280.1633946022806;
        Mon, 11 Oct 2021 02:53:42 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-109-12.retail.telecomitalia.it. [79.43.109.12])
        by smtp.gmail.com with ESMTPSA id e13sm3226167eje.95.2021.10.11.02.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:53:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Date:   Mon, 11 Oct 2021 11:53:40 +0200
Message-ID: <3132934.4g9fEnOrTt@localhost.localdomain>
In-Reply-To: <20211011082134.GM2083@kadam>
References: <20210826130342.9552-1-fmdefrancesco@gmail.com> <2664974.42EkL7omyK@localhost.localdomain> <20211011082134.GM2083@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 11, 2021 10:21:34 AM CEST Dan Carpenter wrote:
> On Sun, Oct 10, 2021 at 11:21:49AM +0200, Fabio M. De Francesco wrote:
> > On Saturday, October 9, 2021 6:31:12 PM CEST Fabio M. De Francesco wrote:
> > > On Thursday, August 26, 2021 3:54:13 PM CEST Dan Carpenter wrote:
> > > > Another thing to fix are some of the sleeping in atomic bugs.
> > > > 
> > > > drivers/staging/r8188eu/core/rtw_ap.c:139 update_BCNTIM() warn: 
sleeping
> > > > in atomic context
> > > > drivers/staging/r8188eu/core/rtw_ap.c:1296 update_bcn_wps_ie() warn: 
> > > > sleeping in atomic context
> > > >
> > > > [...]
> > > >
> > > Hello Dan,
> > > 
> > > I'd like to address these kind of bugs, but I have a couple of 
questions 
> > > about them.
> > > 
> > > 1) You've listed what looks like the output of a compiler or static
> > > analyzer. 
> > > How did you get the warnings you copy-pasted above?
> > > 
> > > 2) I know that both the execution of interrupt handlers (ISRs) as well 
as
> > > any 
> > > code blocks that are executed holding spinlocks are "atomic contexts". 
In 
> > > these cases, "sleeping" is not allowed (for obvious reasons). Besides 
the
> > > two 
> > > mentioned above, are there any further cases of "atomic contexts" in 
the 
> > > kernel?
> > 
> > After some research, I've found that Softirqs and Tasklets are also 
executed 
> > in "atomic context", as hardware interrupt service routines are.
> > 
> > Furthermore, I've also found a .config option named DEBUG_ATOMIC_SLEEP
> > that should warn if some code is sleeping in "atomic context". However, 
the 
> > documentation of that option does not explain where the output of these 
> > checks can be read.
> > 
> > I would appreciate any help on this matter.
> 
> These are a new Smatch warning.
> 
> https://lkml.org/lkml/2021/9/1/950
> 
> You would need to rebuild the Smatch database probably around five times
> to see the warnings.  It takes a long time to build...  It's probably
> not that hard to figure out just from looking at the code without the
> generating the warning.

I must confess that, since I started to submit patches to the Kernel this 
year in April and until now, I have not ever used Smatch. I thought that 
building with GCC and setting C=2 and W=1 were enough. Sometimes I've 
also used Coccinelle. That's all.

Now I admit that I was plainly wrong. My _big_ fault, sorry :(

This morning I have taken a quick look at your code at https://github.com/
error27/smatch. Obviously, what I could see is only the overall design and it 
looks quite impressive. I'll start using Smatch soon.

> So spin locks can't sleep.  Mutexes can.  There are read/write locks,
> built on both mutexes and spin locks.  Rcu_read/write cannot sleep.

Oh, right. RCU were missing from my lists.

Thanks very much for Smatch and for your kind replies.

Regards,

Fabio M. De Francesco

P.S.: Yesterday I read the first one third of a paper co-authored by Julia 
Lawall (Effective Detection of Sleep-in-atomic-context Bugs
in the Linux Kernel - https://doi.org/10.1145/3381990). 

It talks about a practical static approach named DSAC. It looks really 
interesting, but it seems that their tool is not yet available to the public. 

Do you know something about it? I've found an old message by Greg K-H that 
asked for where to find that tool but, as far as I know, he have not yet had 
that information. With this message I've Cc'd Julia in case she has time to 
reply.

> regards,
> dan carpenter
> 
> 




