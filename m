Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC73BC622
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGFFld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhGFFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:41:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3108C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 22:38:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c17so32179552ejk.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNUQ7wh0N7HeTOa7d8zggaSVvZkN28GVoez9TkP5YDs=;
        b=euQAW3VhpMnydgkH9ltLRR/hYeN3dJX9pNpQPs4OTO8RqqDBZc4m8Oger6a7pSMlUT
         jA6a4lOTyf6dWiTNmGvhUsilVJa2hhjLPyGvQZ9lrSVRtM5SqHbVMKlDwEzr6qma3Jnb
         sBhEUQTOI8mSIPFXDJ/4tTMES2fBgSTX7r5O7zIeESXOmYX5ajYs/MUwvN4iIp/dc23G
         2B/rUSjjHpV0m5pQ2oMrPd8q9Bs44pVhzzLQfylFMot4Wx0hCUfCMkRWvmorHwNPm9zy
         fbUv9acVueF1goNKC99gi10jmoUDzobB4c6Kzw2Lv5M9b8QTbU/17ajxkXTvfOa3yxQk
         Jpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNUQ7wh0N7HeTOa7d8zggaSVvZkN28GVoez9TkP5YDs=;
        b=fNEayk+DuMRt+kMnlM7bREJQf9uB+IHrMxYMpZGlhV7jXga854cAATgCj4Bx6/Ggib
         uV+cRpZ8+bSKPm/km/TX26/3sIO+V1tvkaaVfvopiEwjd/Rlsw8mtioe21Acrt81GuGK
         V1cCu0vME6ZmX/cToj+ehMXfr6QXeUTkzZ2uebUyOalr7R+U+kq+roNSsw250WLmObCd
         dPXp5okW/VQNS9eEM0B9TEEDuFmgyv29rIJDzHtOX//XBhZIUw4i5A5JGjurHh+6W0yF
         FYfwCvIaVFHvvpBewXC8Nj0Ni4/jhe3meRfnLMPKbIufwKwK9O4Ft5zt8IQACtykFJ7H
         3fXA==
X-Gm-Message-State: AOAM530Qk86bwPVTQloEk6xCCmWatzDMev47mpDyKHWES7zlbZAYJkLc
        p3bGUHNgbnt1VjonrB5mIMBmN6PokZ4yTt2Dbi1SwfjrS6k=
X-Google-Smtp-Source: ABdhPJw1WABHs+UskfaqcLXkd8hVVYdfl/uL9BfUmpKjEZRqHHrAYqstNKAyynu2FWqTO98B8QI33CNawGRneVs6cC4=
X-Received: by 2002:a17:906:3407:: with SMTP id c7mr16619684ejb.212.1625549932521;
 Mon, 05 Jul 2021 22:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210706050833.9852-1-jinpu.wang@ionos.com> <YOPrRh/3gZ3JETlh@zn.tnic>
In-Reply-To: <YOPrRh/3gZ3JETlh@zn.tnic>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 6 Jul 2021 07:38:41 +0200
Message-ID: <CAMGffEm1ZX1bRJXTbMj=acV+URSMmKXM_Pohq2Cwi4p1osDdgQ@mail.gmail.com>
Subject: Re: [PATCH] EDAC/amd64: Do not load EDAC driver when running as a guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
        "Luck, Tony" <tony.luck@intel.com>, mchehab@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 7:34 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 06, 2021 at 07:08:33AM +0200, Jack Wang wrote:
> > Similar to commit f0a029fff4a5 ("EDAC/Intel: Do not load EDAC driver when running as a guest")
> >
> > There's little to no point in loading an EDAC driver running in a guest.
> >
> > Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
> > and simply return -ENODEV in the init routine.
>
> Did you even read this sentence before leaving it in the commit message
> or you simply copied the commit message of f0a029fff4a5 blindly?
sorry, I notice the patch for Intel, and feel we should do the same
for AMD, hence post the patch.
I forgot to adapt the content of the commit message. -.-
>
> Also:
>
> https://lore.kernel.org/linux-edac/20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com/
>
Great if it's already in the queue.
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
Thanks!
