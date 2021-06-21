Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684D3AF23C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFURqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhFURqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:46:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A36C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:44:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k8so26233643lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aj/0Z18KSrpkQcWAKnHj05+GfR0DaIVfgC0ovqanE2c=;
        b=hTKeytdGalobGnv1mLXz9178COoRqwCgEE/ubFc97TESs4l1ETbGTi/LXWwSHW8ii7
         cU1NcxgBwnSNSSWUGI+0LSLO/eA4skHJOAyy2fZxvgaDUE2kKpXUeFq7V5b34HYKHOnI
         TsfOqqXpxOjB45tPERHc8HZ9x/0x2urKpZmdDFjmOHnTIzDvOBwe/rgvABgjv5qaLR/O
         ByzDEPcf5lYiYqzPcNPzyCnIwtBSE6IaFn0tItgAEDTNFbtKqHPSF2zRWCYSRAJfI1ut
         6seNasjRSFy7UCNfh8Ov01ynyt41Sclnq4cMIJyoVCx9rvyy9NrYgMxQtwhLOKhMEat+
         cJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj/0Z18KSrpkQcWAKnHj05+GfR0DaIVfgC0ovqanE2c=;
        b=LuCPmIKwPeB0GMuZssE+GvwuPTemCs4i4GUMPNi94YADw3oq5YdOIGPJ/a5DcyfFgW
         j/AukxhpcvbUwHHhufqQG69YruvQmZJz8+pephnxfiXLdMeoaKAcly7WpnVpwbRQsgwI
         WGKtNyeqJWCC63owZ58cOVWzwYzsPRdj7CJOojkEFbjIuCuqjCaSZQhi6Ufoh/RaYTVK
         O4eWuKif/bSuij/ThBsV5MWpoLGN1XoWzWhDYW5KsDJwYqamaTqs6vBzHr8hlorUA/yt
         E70V+WDN+DuX4yZibN1GkCyTV7lbsYvNPveFsM7ES3JfGU2thMn+rTQCLxjhsENd1IhO
         ahFg==
X-Gm-Message-State: AOAM5303y2GgsAqAYjqbQPf7OllZcbOMidJUIC81J2aGJq8MGOxfznZQ
        9BCjznp+nPzVi6ve5x7TBEcOCRfNe//XzeciYEuuxQ==
X-Google-Smtp-Source: ABdhPJwdQKs2XYfO12j9GxWLhfQ9o6XvL9JaTlE9K2yEhyTXPKP7lTIi01KFE2ZPpN2bcp+AVRGr823u8lFAqVeQG58=
X-Received: by 2002:a2e:858a:: with SMTP id b10mr22329066lji.445.1624297464450;
 Mon, 21 Jun 2021 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com> <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
 <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com>
 <20210621162243.GA29874@vingu-book> <CAKfTPtACzzoGhDFW0bTGgZRPB=3LR6kSwuUOrcKDFTAJ7BhTFQ@mail.gmail.com>
 <14EEE4A4-B2B1-4D0C-B2F6-BDB7C11B05DE@linux.vnet.ibm.com>
In-Reply-To: <14EEE4A4-B2B1-4D0C-B2F6-BDB7C11B05DE@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 19:44:13 +0200
Message-ID: <CAKfTPtCwqpHUxFdk0Q4dwL19Zn0_EhX7gQ8dwf=rsWHyxZVAVw@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Odin Ugedal <odin@uged.al>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 at 19:32, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
> >>> Any thoughts Vincent?
> >>
> >>
> >> I would prefer that we use the reason of adding the cfs in the list instead.
> >>
> >> Something like the below should also fixed the problem. It is based on a
> >> proposal I made to Rik sometimes ago when he tried to flatten the rq:
> >> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
> >>
> >> This will ensure that a cfs is added in the list whenever one of its  child
> >> is still in the list.
> >
> > Could you confirm that this patch fixes the problem for you too ?
> >
> Thanks for the fix.
>
> The patch fixes the reported problem. The test ran to completion without
> any failure.
>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks

>
> -Sachin
>
