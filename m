Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B903FF6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347913AbhIBV46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbhIBV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:56:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8024BC0612A5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:55:39 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l18so6234949lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OGY0A1bmZf1fxvWkbRm6Nt7GcmJzJ4PCA9tMxUQzJU=;
        b=L34pszxLvaK1/ThKDYqV097bwVi8n2QR0jDIHeafcSSoPQ9z8W+i4niPigybjSIJqH
         dFiDtYwNyV56xL39aIJBQy+mTx3awcN1DVNd15K9XDNl52+jJzM/lNcR26w39F121YK1
         e7Vu0mceRcUbTfqKirHJsqCLxbSujeusdES90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OGY0A1bmZf1fxvWkbRm6Nt7GcmJzJ4PCA9tMxUQzJU=;
        b=VRF9Lr8zDij+P+2n9y1epMN35NFkVuGmxR0hc2lBFYAgpxHBHqCJ2fmenqRSmCYLYw
         nRQRy/Pts4K8R9hjsyPzjJBweQwYtVNZV+0wzAmMcw40MoAr9GEvenTsrLfteU2Ljtd9
         BqSbgmMqiAJekTv2LK1Qqt0H2kV0SuVd7y0pwmZtBjFkYgTfDP7aoW6GzzuaYlXDf1Sw
         N5H/vFGBpBvdoM7K/vLYXd11vH/8Xn/9wNsrjMEv8fBws+iF2hU0cTWSQqIzzY298hTI
         uEIEbcY2tyjA/D2aHGHX+HU2wuE3OjBOedb5C2Vx2e7sJFAXjKAsJl2l9wyDGRz9a9m2
         mrLQ==
X-Gm-Message-State: AOAM530KOpJlFCdvXkahMU6JpWa7p5cf8MdGLZwC03/iD/gtwFyJJD0A
        FwCMMazhtBNtfR4SsvDkIE1Z7TPf09p9MID1NhQ=
X-Google-Smtp-Source: ABdhPJyqtT4p8sEm07vIxTBEzPeAlBuSiQW0KM8pjqzI9688Cr9eEO+3rjnMmLXKqxIeOb00hVormg==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr347472ljj.384.1630619737097;
        Thu, 02 Sep 2021 14:55:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d8sm308620lfm.67.2021.09.02.14.55.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k13so7486863lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr229751lfs.40.1630619736152;
 Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com> <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 14:55:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7GMGD1YNM7WgPAU3nwHhMAvQ8yvdwvJtuwe9J1pBgvg@mail.gmail.com>
Message-ID: <CAHk-=wg7GMGD1YNM7WgPAU3nwHhMAvQ8yvdwvJtuwe9J1pBgvg@mail.gmail.com>
Subject: Re: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, I won't pull until the next merge window opens anyway (about a
> month away). But it would be good to have your tree in linux-next for
> at least a couple of weeks before that happens.
>
> Added Stephen to the participants list as a heads-up for him - letting
> him know where to fetch the git tree from will allow that to happen if
> you haven't done so already.

Ok, so I've merged the biggest pieces of this merge window, and I
haven't actually seen a NTFSv3 pull request yet.

I wonder if you expected that being in linux-next just "automatically"
causes the pull to happen, because that's not the case. We often have
things "brewing" in linux-next for a while, and it's there for testing
but not necessarily ready for prime time.

So linux-next is a preparatory thing, not a "this will get merged"

So to actually merge things, I will expect to get an explicit pull
request with the usual diffstat and shortlog, to show that yes, you
really think it's all good, and it's ready to merge.

Don't worry about - and don't try to fix - merge conflicts with
possible other work that has been going on. Stephen fixes it for
linux-next and makes people aware of it, and I want to _know_ about
them, but I will then handle and re-do the merge conflicts myself
based on what I have actually merged up to that point.

And of course, the other side of that is that if linux-next uncovered
other issues, or if there are things holding things up, please _don't_
feel obligated to send me a pull request. There is always the next
merge window.

            Linus
