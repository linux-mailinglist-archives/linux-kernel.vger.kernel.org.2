Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13D3AF16D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFURKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFURKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:10:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFAFC061224
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:07:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u20so6524188ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfyI+PE4yMFE2NiBIg4WN+XRsbmpmtuoazfEDa31UNE=;
        b=uviUHAF4Kl81bYxL74OOvKsVzg6wvX6YPg1izMWApQE0qUH3f+zE0RIhhlc/d4slv2
         DxlrglB/H/M5hMZYFbo/bRFqPRLjL2iZMtq4IX+PiZYlEfSWxM4rxU0daIJInis6+Nxp
         2/sE8bEjGI2fvfVwC18hPuvzFSzce6AWKyXxkJqLPOcLj3plzpF/oIS2v93XOGKNv+J8
         j/peMUTgudseO6Mm0n7nSi9ccMwuHo7vVtg1JS13M6/XUBS0zqeYygb5R01onXHwx708
         Df+jyaZcsyfvywoEE7kfhDyb6XMZVnKrW4KpQkfMyMfI7bvA01KRTrOHrOnyxZJ1UA39
         vcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfyI+PE4yMFE2NiBIg4WN+XRsbmpmtuoazfEDa31UNE=;
        b=D8udsnYSTvhQ3/tA0SjRtoDlYSTARSrI5oyE2BHfmwqK6sf2otyiQW4CSoR0k54hBG
         v1u6XKekzcIdAFzwGdtpFNA8EWxR13Dh1RSxSi48qB80B217RzHzinfevSBxs494FmnR
         IcrBCHAf51KtRPKODfdpX76OJs9NyFsVCyGJA6xKagHzccCVaLE58cd6pB/sMmsNH8LI
         aoRxTNy5QbE4etB5dUhzF38zsty3oIOPfP9w1WKvB6n3tje7HZehqOfTyFr2Am4d1DqM
         /ZAb7Pg6LIl5UHzhiEpckrit6dFIeH9ZQNfadtdWEPfNOYCB5SSQsR/FmMHJdtpDze/w
         5FLw==
X-Gm-Message-State: AOAM531n3yd5UpioPyVnvWiXDa/QO/vytyUSa9j9rElsNfj402pMctvP
        6XPsTaZeI9TS/WbEb7OZK3/Vzl1UHzuQXhZl1UMf4g==
X-Google-Smtp-Source: ABdhPJyEtNkIjBI5N44m4GQ843pXOdK+86sbhof7yjNOwXzFx3GIIYNndERBm4quNQ9brfXdSV8QEJeUVFqOAWVLg30=
X-Received: by 2002:a2e:b80f:: with SMTP id u15mr23152412ljo.284.1624295261005;
 Mon, 21 Jun 2021 10:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com> <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
 <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com>
 <20210621162243.GA29874@vingu-book> <CAFpoUr1hyAeFSCvyJU4SKjtEKn6Hq1RLuu1eZPhRt1SaAq7=TQ@mail.gmail.com>
In-Reply-To: <CAFpoUr1hyAeFSCvyJU4SKjtEKn6Hq1RLuu1eZPhRt1SaAq7=TQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 19:07:29 +0200
Message-ID: <CAKfTPtA21ZG3wwdFG-11Nq6NBFu_eOAdvYFMFJePoSMiS_+jcw@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Odin Ugedal <odin@uged.al>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 at 18:45, Odin Ugedal <odin@uged.al> wrote:
>
> man. 21. jun. 2021 kl. 18:22 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> > I would prefer that we use the reason of adding the cfs in the list instead.
> >
> > Something like the below should also fixed the problem. It is based on a
> > proposal I made to Rik sometimes ago when he tried to flatten the rq:
> > https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
> >
> > This will ensure that a cfs is added in the list whenever one of its  child
> > is still in the list.
>
> Oh, yeah, that is a much more elegant solution! It fixes the issue as well!
>
> Feel free to add this when/if you submit it as a patch:
> Acked-by: Odin Ugedal <odin@uged.al>

Thanks

>
> Odin
