Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F39344E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhCVSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:33:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:32:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 75so22811042lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eze6fo/qU2elQxuT7PNT60Pcmqt6hp4FChAafrK7TlY=;
        b=MxVOxL3Na62SXddwG0JngoJ0NSLgIP7LZhILCSHq0+vh3G87bf4ovXeVud9pSOr+gD
         mBBpRsaDF/G+IuEsR3hmtNXFYGch9vLD+iOXqyJfevKWC+m4Heg8NC353wM0YauFP1sc
         EwIEyfAPoYFmfum4Gdj/bVbPeK/XiG0jOnTLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eze6fo/qU2elQxuT7PNT60Pcmqt6hp4FChAafrK7TlY=;
        b=cWWpZfUMLYaP2dsRSnqUet8S94+RqzbHnyb0vwIX89ELvmX9ciA7UidpfGZrynUD0I
         DGLCouJH3l1GGVhyVhY4nzH7DEyFe6XonUkpOAzj2b4yzVTZIYt6d4Fmw6ejTssYwWRN
         QTRdu76o0YiqzAtP1Pa5LeKrq62b9yKAI9pNuQvlCBcKgdoaHQTD13UxpxJA9gfFn7UC
         Tcp4scEUVrR3jNUKx5VR8FqrfuZwYsAAnYjIWUHuvbxoRt0uYQcBd9WMzNS5GSjqzN/w
         sX3emGPIdZy98V+PFmnLaqEAfg7fTy73cqdCBA9WnwvwQsbJ2D2DqglIjKbJmHzF0+vX
         xRwg==
X-Gm-Message-State: AOAM532eAvbNXO9bkebfjAIk6Mak5GBBvKBDhTRlk5LjVwkBoqduFMAu
        F8fV11I4ntBD2RwYwvOPFoBj+qXSri+QOQ==
X-Google-Smtp-Source: ABdhPJywEaErUTglRVeBW22qLWoXrI6BcDHAGMFjDWem1RMAdoNs5wYxacVXuWPUvosNfkeMR9T+Fw==
X-Received: by 2002:ac2:5e8b:: with SMTP id b11mr353917lfq.99.1616437970655;
        Mon, 22 Mar 2021 11:32:50 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b25sm2023828ljo.80.2021.03.22.11.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 11:32:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f16so22387843ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:32:50 -0700 (PDT)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr530535ljj.48.1616437969891;
 Mon, 22 Mar 2021 11:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
In-Reply-To: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Mar 2021 11:32:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
Message-ID: <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 8:18 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
>     I even requested a
> "linux-regressions@vger.kernel.org" a while later, but didn't hear
> anything back; and, sadly, about the same time I started having trouble
> finding spare time for working on regression tracking. :-/

Honestly, I'd much prefer the name 'linux-regressions' as being much
more targeted than 'linux-issues'. Make it clear that the list is only
for regressions that people can describe some way, rather than some
general "I have issues with xyz".

The more clear-cut the list is, the better, I think.

            Linus
