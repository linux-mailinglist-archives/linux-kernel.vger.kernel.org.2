Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AF43A433
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhJYURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbhJYURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:17:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C6C08B9CA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:44:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j10so10977684ilu.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCAeU37V8sZNMhZf3pMD7qGLVGlKLtfdANheEgNS+FQ=;
        b=cYlyaKkKqtZBV1QEEhyHGLNaTplJZOWNgTRS3ZdrP7OvyMeje5W9+T5CNjpKZUvbDB
         b2ZuiDeDI541JWCw1YswV1r+FU/qPn7SYfX6xqA/7CPmgdOnVXvk1jPIaTjQgu6sFkz6
         ZIwva4SuI7l3yrWS2NWfR/b/7/cxpmWnz7iW10hBvo0KU+VowzCofa9QaHzyiD8yHoM+
         Lq2r0ogLg5+XXmHrAOgHty5LXr7zibvCTZpmgspFVMN+uTMtw9oB6XmMRAUXgIb/z/bL
         awVSr4q/eWo0us4hNILif5tQFGSis5AoBHGzk6MMG+NX9GKUxrrIDAZEnKGTXCUPplqL
         CbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCAeU37V8sZNMhZf3pMD7qGLVGlKLtfdANheEgNS+FQ=;
        b=X336trTfwLpeOkxIKj22vGmRSYvZQxHPEjXhjUHLzvsKTf9xOOtjFneXqsNjMjmLhO
         bMoBW/R8xKNJEVonh+M8DQf5XOSfDYMra3VF1WMgGjAaxO5UiNfNgUdiTQ4TJOQihzcc
         X2/L3owQJltnPVm4eQPvrb4V7SgSEkhZWUK5riSacfHOM5pqLnCSZGR9HUtzerTrP+im
         Ubzf1v/wWWgg8zK5ZbifOAYGbNc+Yx1F4ejcTny+z6L3FpXe73nNp0NkRazV29209Dmy
         BibMZ8dZevmCS+H8p94r5hKIxumqDA5WzTVXJ8uLG8s199a/1RX4QD8meAW86GEy9oHq
         9DfQ==
X-Gm-Message-State: AOAM5301FWJOyyoKe/vnW/XSlJkomP5sUqJHaDagLPh4OHp9YPpWmPh4
        QQ6NPcTxPcorK4OiJYTo8XQ0NGIo3JXgkNLRAgOovg==
X-Google-Smtp-Source: ABdhPJx/B916AQ5/1Bt/Nyn+iweGR2lx3TjApu0DHNo8e0zpn2WZcChFxTv/2VCDQOW3YeIHUk6skYfeNTNTDZv+S8w=
X-Received: by 2002:a92:b00c:: with SMTP id x12mr10577902ilh.37.1635191054847;
 Mon, 25 Oct 2021 12:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhMmr7bWv_UgdkFZz89O4=WRfUFhXHH5hHEOBBfBaAR8f4Ygw@mail.gmail.com>
 <CA+h21hqrX32qBmmdcNiNkp6_QvzsX61msyJ5_g+-FFJazxLgDw@mail.gmail.com>
 <YXY15jCBCAgB88uT@d3> <CA+pv=HPyCEXvLbqpAgWutmxTmZ8TzHyxf3U3UK_KQ=ePXSigBQ@mail.gmail.com>
 <61f29617-1334-ea71-bc35-0541b0104607@pensando.io>
In-Reply-To: <61f29617-1334-ea71-bc35-0541b0104607@pensando.io>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Mon, 25 Oct 2021 15:44:03 -0400
Message-ID: <CA+pv=HOTQUzd0EYCuunC9AUPOVLEu6htyhNwiUB1fTjhUHsN5Q@mail.gmail.com>
Subject: Re: Unsubscription Incident
To:     Shannon Nelson <snelson@pensando.io>
Cc:     Benjamin Poirier <benjamin.poirier@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Lijun Pan <lijunp213@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 2:34 PM Shannon Nelson <snelson@pensando.io> wrote:
>
> On 10/25/21 10:04 AM, Slade Watkins wrote:
> > On Mon, Oct 25, 2021 at 12:43 AM Benjamin Poirier
> > <benjamin.poirier@gmail.com> wrote:
> >> On 2021-10-22 18:54 +0300, Vladimir Oltean wrote:
> >>> On Fri, 22 Oct 2021 at 18:53, Lijun Pan <lijunp213@gmail.com> wrote:
> >>>> Hi,
> >>>>
> >>>>  From Oct 11, I did not receive any emails from both linux-kernel and
> >>>> netdev mailing list. Did anyone encounter the same issue? I subscribed
> >>>> again and I can receive incoming emails now. However, I figured out
> >>>> that anyone can unsubscribe your email without authentication. Maybe
> >>>> it is just a one-time issue that someone accidentally unsubscribed my
> >>>> email. But I would recommend that our admin can add one more
> >>>> authentication step before unsubscription to make the process more
> >>>> secure.
> >>>>
> >>>> Thanks,
> >>>> Lijun
> >>> Yes, the exact same thing happened to me. I got unsubscribed from all
> >>> vger mailing lists.
> >> It happened to a bunch of people on gmail:
> >> https://lore.kernel.org/netdev/1fd8d0ac-ba8a-4836-59ab-0ed3b0321775@mojatatu.com/t/#u
> > I can at least confirm that this didn't happen to me on my hosted
> > Gmail through Google Workspace. Could be wrong, but it seems isolated
> > to normal @gmail.com accounts.
> >
> > Best,
> >               -slade
>
> Alternatively, I can confirm that my pensando.io address through gmail
> was affected until I re-subscribed.

Hm. Must be a hit or miss thing, then.

> sln
>
>
>

             -slade
