Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAC3E5382
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhHJG14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhHJG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:27:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1221C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:27:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h9so12596615ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Hwnsr93Hzf8aAn89w3QAR5Rj6HoDPYCgjQEsVOi/00=;
        b=XYk25ezJ0kVIePMD73YyZroWy7jsB4Ysplb+Q0kl5Kbc8svFvAaIH//aFXpGEgMtjm
         HcrYVeESv0cUZyBRTyLM897TiPB8K9LAD8BmhwkNGI63QQP4iagdpv8E7xouJoIsHXrO
         APOvdJS0ZQ/pJiy/KPztSdrDxoQnEeqx4VRqrjf2Ad+568JROa34xgjv3o1a8TkOR2Gc
         csE2R5vhmLz+Ms+FVOrItPPRfz6+/luqfHw/zQrWfYJaIDSFT24Uwhn3uelgfERk4yck
         93vIi5Mcqwu6v5SeY3WRV6tJyxXBORb+lF7xC3e8CPEbDnQY8aaZok0hNncRjujcLC8z
         oK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Hwnsr93Hzf8aAn89w3QAR5Rj6HoDPYCgjQEsVOi/00=;
        b=Th+9DJggxyuJZyOdTeqAFJVH2YviSctjaSrWGZFa3mb7C9/fKh+LKAHLqHJL6ZIiCL
         4ae6jGB0TRSGOUSQdYvnze2dyy++oM2vXRb3s1A0yUz7Zi+OPx7ekf/rT5AqOVw2DhLB
         hN1AbpG2ASk+iRdbI+mKXlkxBJRcM2Jv9S5PxUcxbiRZQODrR/yOQpX4jR0j8FrbuHwO
         fx+o4yx0NCP5jh3RKcrK373Vnc9N1XYPYkUg8QribjWEbFB1hVQNwXFStjCZg13RqELm
         vTIVGppmx3Uo3f0C0EaM3o7zpQbNrZ9A0ifX3gt3FxQMW9TvnLtMK6nZe4rxpDsZUXWK
         Z2/w==
X-Gm-Message-State: AOAM531KTo6UdFp6ehya/OESLFEW97H4Agcn+SMS59XUKW4eMuQ2jtWo
        E4/97m1G6fIUHe8LGb1pR/8wftqtgMMPf5quo5A=
X-Google-Smtp-Source: ABdhPJwOOHN526CNxCm04yzFJWqeR3lM90mFUgXud6C4oGdkm8SXfbo2flYd0ZJRgj/ey1QrqEM0lTWD4NNUsssYYts=
X-Received: by 2002:a17:906:8493:: with SMTP id m19mr11451997ejx.103.1628576852552;
 Mon, 09 Aug 2021 23:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <YRFKlOvXKKQX9vr6@kroah.com> <CAD-N9QXFWr2APy294T6v+16d8SXtUuLEoPvZTw1ZDwfQ+D4kFg@mail.gmail.com>
 <CAD-N9QVgnbwNScKD6anFLUELbJ5tAZ1hWbKhOStwZ+kPwgvVLw@mail.gmail.com> <YRIYsNCMmKrPfRlF@kroah.com>
In-Reply-To: <YRIYsNCMmKrPfRlF@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 14:27:06 +0800
Message-ID: <CAD-N9QWoW1i=WsL7jgq3RM6tspyeKr_iuLYePt8JyQy6drao7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ipack: tpci200: fix many double free issues in tpci200_pci_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 2:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 10, 2021 at 07:41:55AM +0800, Dongliang Mu wrote:
> > On Tue, Aug 10, 2021 at 7:08 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > >
> > > On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 09, 2021 at 10:30:26PM +0800, Dongliang Mu wrote:
> > > > > The function tpci200_register called by tpci200_install and
> > > > > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > > > > tpci200_unregister has some cleanup operations not in the
> > > > > tpci200_register. So the error handling code of tpci200_pci_probe has
> > > > > many different double free issues.
> > > > >
> > > > > Fix this problem by moving those cleanup operations out of
> > > > > tpci200_unregister, into tpci200_pci_remove and reverting
> > > > > the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> > > > > Fix a double free in tpci200_pci_probe").
> > > > >
> > > > > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > > ---
> > > > > v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
> > > > > location change of tpci_unregister into one separate patch;
> > > >
> > > > Also needs to go to the stable trees, right?
> > >
> > > Yes, this needs to go to the stable trees.
> >
> > Hi gregkh,
> >
> > Let me clarify more. In my series, PATCH 3/4 4/4 depends on PATCH 1/4
> > and PATCH 2/4. And also PATCH 2/4 depends on PATCH 1/4 as they are
> > closely related.
> >
> > But from your reply, the last 2 patches should not depend on the first
> > 2 patches. I don't quite understand as I don't send some patch series
> > before. For a patch series, the latter ones should depend on the
> > former ones, right? If I have any misunderstanding, please let me
> > know.
>
> Yes, they can depend on previous patches, but if some patches are to be
> merged today for 5.14-final, and others later for 5.15-rc1, then ideally
> they will be separate series of changes as those go to two different
> branches in my tree at the moment.
>
> > BTW, PATCH 3/4 has some compilation issues. I will fix it in the next version.
>
> As you haven't even tested these, I'm really hesitant to take them at
> all.
>
> Please just send the first two patches, fixed up, as a series after you
> have tested them, and then after they are merged into Linus's tree, you
> can send the cleanup patches, as they are just "nice" to have.
>

That's good. I will send the first two patches. After they are merged,
then I will send the rest patches.

> thanks,
>
> greg k-h
