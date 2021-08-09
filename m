Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB483E5012
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhHIXmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhHIXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:42:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46939C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:42:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id yk17so31929635ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 16:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JC+TZFqQ27/4coXQmSt8pQVtEupvajbKIf+kglQsXqM=;
        b=m44FSmUa+bL+jkDcHxpARHXlYT9Y/v2PG2SGZmggMEkSQttHflNZLexukzee8uNUG4
         LK3leKqZDOR3xmXgYfV3Q7yyVdsHl5WXGnqMbHYeyerFvHp9gAe2kLDyB3Ul6MHD8W7Y
         z238WHMm2r7TIJsGvNKhobYbpRW8SvoHFLA9mt7ffYJL1LHenceCHf8M770cwz4aW96V
         7HlA9mzbkPKmk4MK5RJTFOMpuQJi631r7YG08bBBamCr4UiqU3TmD6qd0IVmyWhh80Q/
         WCxTgzbuGUCE8LTQS8z94FjRs+sRvTU+tzmTF6q7MN80QM6zrKLRtOgTHP/gGOdhxZeS
         GjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JC+TZFqQ27/4coXQmSt8pQVtEupvajbKIf+kglQsXqM=;
        b=ZX9UuwemBK58pafDLJ6b1qYWx417nT0b8aEORLbDBxVZZdLG1gEu3mZmLYl/XlRLSp
         qvgBhEs7NDqvxrvoH01P1H2tonZ55QXW0PYVUxgvr/ttkkBcSugGlrY4HBQTloCIiQsb
         OUIRMRIbEzw7ligzUohH3m/gMoUtoxop8lqiOLWpqXEjni4LwtceFs/5yhy9Mnvzsx51
         hCQvOegxJm9ulQ1skm0TOvcSlyehTBpOyfkzmcbf9dYmReDkyYQyJrAlkAMQCWS+/5Et
         o4re7mQmS07ajolfIgRPElRtaYApGcI90Ig313gXcCejS0FQlytb2ssOEYdBYRD1soMo
         CAFw==
X-Gm-Message-State: AOAM533Rn733aHxrtKWk9pZ7d3QjynPx64i9VLSKU+F3OQW+cTzok93z
        Fgdb0zBu0PWDpwq8z2EAUUgbXpGMZbjU4KvzNSA=
X-Google-Smtp-Source: ABdhPJzRow989v6YwuZGVFZjjqlQUCTOVGRcXox1Q3nePwmh0Vu0+WzuH0Z7tKWCbkFGGIv3sHnKR2jYNbKqil15FwA=
X-Received: by 2002:a17:906:a3c3:: with SMTP id ca3mr24755070ejb.337.1628552541899;
 Mon, 09 Aug 2021 16:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <YRFKlOvXKKQX9vr6@kroah.com> <CAD-N9QXFWr2APy294T6v+16d8SXtUuLEoPvZTw1ZDwfQ+D4kFg@mail.gmail.com>
In-Reply-To: <CAD-N9QXFWr2APy294T6v+16d8SXtUuLEoPvZTw1ZDwfQ+D4kFg@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 07:41:55 +0800
Message-ID: <CAD-N9QVgnbwNScKD6anFLUELbJ5tAZ1hWbKhOStwZ+kPwgvVLw@mail.gmail.com>
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

On Tue, Aug 10, 2021 at 7:08 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 09, 2021 at 10:30:26PM +0800, Dongliang Mu wrote:
> > > The function tpci200_register called by tpci200_install and
> > > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > > tpci200_unregister has some cleanup operations not in the
> > > tpci200_register. So the error handling code of tpci200_pci_probe has
> > > many different double free issues.
> > >
> > > Fix this problem by moving those cleanup operations out of
> > > tpci200_unregister, into tpci200_pci_remove and reverting
> > > the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> > > Fix a double free in tpci200_pci_probe").
> > >
> > > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > > v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
> > > location change of tpci_unregister into one separate patch;
> >
> > Also needs to go to the stable trees, right?
>
> Yes, this needs to go to the stable trees.

Hi gregkh,

Let me clarify more. In my series, PATCH 3/4 4/4 depends on PATCH 1/4
and PATCH 2/4. And also PATCH 2/4 depends on PATCH 1/4 as they are
closely related.

But from your reply, the last 2 patches should not depend on the first
2 patches. I don't quite understand as I don't send some patch series
before. For a patch series, the latter ones should depend on the
former ones, right? If I have any misunderstanding, please let me
know.

BTW, PATCH 3/4 has some compilation issues. I will fix it in the next version.


>
> >
