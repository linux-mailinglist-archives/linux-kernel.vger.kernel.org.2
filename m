Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1640B26E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhINPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhINPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:03:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B77C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:02:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a66so15148976qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikRfZznVPSXgOHZwn7JV71/YZkay7rEY3B5GGPhJJ+U=;
        b=biWj6oOhhZxdxpaxbui8CnDRKvz3RAAV0JLgdSoWpp1s6sxukGfPhlHQql85u5sKC+
         eWAsEdfVzc4X63GeAFgSUC37oIZ9Qk7Z0iQ9/YARn8S7JZ9e0PyrsEDNqE9JMHEzHl14
         ZrSwlOi5vSL1nO4tt2CSeAWhK2qu2G34II0M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikRfZznVPSXgOHZwn7JV71/YZkay7rEY3B5GGPhJJ+U=;
        b=ChnM2+c4fLLywFmCK64rlHhHeZe6COQYDQYtZ+DzLS61hAmHmFRCZNvuOFxPNBqNCj
         iMT/13yOZN34CadrQrmqePdgwzqD7QQVYXCkGyxgQNJbSqEk/KjYhrBeGh5UZeiPV29F
         LwfgrxJj1d3IBnlMA4ZvmUdaZcyaryN9pb09CgUGCaK7+bVuCK0MRqP8DFPMzdA8KFJj
         hta+9spL8oVzgu0nk9DsSMnFNRsjORqR6ey11iVW5Gt2E5Gu/4IkwCMj+1kGV+DsJQMj
         dcVeEendAbm4c4HNnM/ZJ6tOfKZgvnGFVMZeWUF8LuXdzcBVw+q/0Ng8n0xvR1ksk0iN
         1pLQ==
X-Gm-Message-State: AOAM530nPpG5En+t7hoUBopSzD9VnJOaXJo5WWNUW1uK9jyFRLjj0rG8
        +rtHQn96OOpbfoR4elQmG6nuuqCHdE/9CG4aayihPg==
X-Google-Smtp-Source: ABdhPJy5FtjBECS7D5pqnI7V2Px/Rkc9Hc6UzmLi6RECLOhHNEvqX50enNMA3OI7/seaVcoHAcaFc+Ldf77gvG30rUs=
X-Received: by 2002:a37:a905:: with SMTP id s5mr5380057qke.63.1631631745930;
 Tue, 14 Sep 2021 08:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com>
 <20210910190322.27058-5-romain.perier@gmail.com> <CAFr9PXnLZC1zfs4e1GqZU4UU3knU-BwREe0-abrWNq7akrTntw@mail.gmail.com>
 <CAK8P3a24NTmkyh01OEzDQ8=oTWpUnDtwWQgUUxUbW2wxsgAFeA@mail.gmail.com>
In-Reply-To: <CAK8P3a24NTmkyh01OEzDQ8=oTWpUnDtwWQgUUxUbW2wxsgAFeA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Sep 2021 00:04:44 +0900
Message-ID: <CAFr9PXkipBnVDBOpdYhUD4bYNaL8qybPhGJi7YwSHaCNrPz6rw@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, 14 Sept 2021 at 22:54, Arnd Bergmann <arnd@arndb.de> wrote:
> Sounds good to me.
>
> One process issue though: These emails were sent 'cc:soc@kernel.org', so
> they end up in patchwork, but I'm guessing they were not actually meant
> for us to apply from there. I'm happy to take merge these patches (or
> a future version of the series) directly from patchwork if that's what you
> both had in mind, but for clarity please either
>
> a) drop soc@kernel.org from Cc for patches that are meant for review
> and will be part of a pull request.
>
> or
>
> b) put soc@kernel.org in the 'to:' field after they have been reviewed
> and you want them to get merged.

Noted for the future. Until now we haven't done pull requests so
having the patches go into the soc patchwork made sense but from now
on we'll send pull requests when needed to you and Olof for the ARM
specific bits. Which I don't think there will be much aside from dts
stuff.

> Or even better, add an explicit sentence below the '---' line asking
> for the patches to be merged directly into the soc tree when this
> is what you want.

Noted.

> FWIW, I'd suggest merging the MAINTAINERS file change as a
> bugfix for 5.15, it's generally better to do these as early as possible
> to make sure any patches reach all the right people.

That makes sense.
Would it be possible for you to merge that single commit for me?
Seems like that would be easier than me creating a fixes branch for a
single commit, sending you a PR, finding out I still don't actually
know how to do PR properly.. :)
If it's a hassle I'll do the PR though.

Cheers,

Daniel
