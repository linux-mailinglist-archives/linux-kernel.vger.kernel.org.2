Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17730B1F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhBAVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhBAVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:17:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:16:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so12492007pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPbcRaX1SgEZLu4YCv7l4zPyyMW8dttxgAN/QGCyppw=;
        b=iHWQb81/ia8DQq3d2ds1zRxrP+jhpqwVi5k5vWZw1g59/lyadKYb1YUzaaxSsDPXEK
         04eZQ7xLhCIp8ehR+UurOS8YJ+g02SYl0PUJBfSKBRXL4hzxhtw43xqxR7YIjfbOptxC
         kS8draunkHMry4+vR1OxwbkqsZ1EV1Tdn8yH6XUha6PV3J5X4fP67ANYAKld4hNwSX5z
         gXMjUCd3XTF2y+GS16jHO/meJWahBHbqXHM4ApYjMln3b5aXUn6FoiswtunMAHU7KZmT
         J/XhQAxDahP71tMYE6YiJkUbtRe4d70GHKqNlJqT3+7T2y4tL6taaXE30zlBiG7/UdrH
         vFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPbcRaX1SgEZLu4YCv7l4zPyyMW8dttxgAN/QGCyppw=;
        b=XCSaYoAye0oIaBwN/nRxlbCdTDYOE1ziS+jrvx6g+54Z/msc/ceJdKbGSZ5Ogg3TYX
         np0Xk9NPT+EXO2bo9txtTC25J3fNJNYxy/qahlpyaHTqrRpj/l7OewuuJAxUyQiMN36U
         iG21Ics3MssjBDm54mR7WT1G4cdvVtjWtcTr1qn2fo/jkZdMBup/A3TNkj9Gbg//iUY6
         fckLGCDXPrZRtEU8JXRhJm8v/enIfmRElZ06/E8QYNb6duCXqHa/TtSTcBgFi3nLkVUW
         md7CMi3eUnz04tctvtCi/Zqmxj9z7O5OrWaW3rHN1TUAcD6Fgq7x/VS9WDrk23HvF249
         /CFw==
X-Gm-Message-State: AOAM530e8Ow5X6Dgr2wGhLySnFNjJR4m5LPusEF9QG6rLj10NW3f90Eo
        dWFdPNnvRLFirhqCe/gFKj9AWmOdrA+Ysc7vW4Wdig==
X-Google-Smtp-Source: ABdhPJx8iYzAdimcqwPEaBhxqxj8JDqf8XEN6LS6P4YdyPCo7YTyNl84jtQ18EM6tRCGWp4QTm/i5l7txXsk4Qii9DM=
X-Received: by 2002:a62:7896:0:b029:1b6:7319:52a7 with SMTP id
 t144-20020a6278960000b02901b6731952a7mr18577965pfc.30.1612214190673; Mon, 01
 Feb 2021 13:16:30 -0800 (PST)
MIME-Version: 1.0
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com> <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu> <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu>
In-Reply-To: <YBhuHJgZ3QPqHheV@mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Feb 2021 13:16:19 -0800
Message-ID: <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:09 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 01, 2021 at 03:41:50PM -0300, Vinicius Tinti wrote:
> >
> > My goal is to avoid having a dead code. Three options come to mind.
> >
> > The first would be to add another #ifdef SOMETHING (suggest a name).
> > But this doesn't remove the code and someone could enable it by accident.
>
> I *really* don't see the point of having the compiler whine about
> "dead code", so I'm not terribly fond of
> -Wunreachable-code-aggressive.

I agree; Vinicius, my recommendation for -Wunreachable-* with Clang
was to see whether dead code identified by this more aggressive
diagnostic (than -Wunused-function) was to ask maintainers whether
code identified by it was intentionally dead and if they would
consider removing it.  If they say "no," that's fine, and doesn't need
to be pushed.  It's not clear to maintainers that:
1. this warning is not on by default
2. we're not looking to pursue turning this on by default

If maintainers want to keep the dead code, that's fine, let them and
move on to the next instance to see if that's interesting (or not).
-- 
Thanks,
~Nick Desaulniers
