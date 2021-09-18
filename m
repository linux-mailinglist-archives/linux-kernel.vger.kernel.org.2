Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBF41079D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhIRQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhIRQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:37:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD47C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 09:35:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e15so8263384lfr.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZcGOii1pU+hj/Up4OBQax4sO+IjcSpEw4Fkvr3/kLE=;
        b=JTZm2jo+OQTRExJj4lUJ4+2wlgp+CShZkSqHeLHZDnUCHdtjvicfbXtsV99l0pApDJ
         bmwIq9pAiTcI8shMynSmQ7OtrizRQW/TGDZn5oP3ktBENs7JiHoUJGxF/hQpdnsLMoyO
         n4atMZbKzGyBB4s74RDarADOfvPPjIrcpxBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZcGOii1pU+hj/Up4OBQax4sO+IjcSpEw4Fkvr3/kLE=;
        b=1QDURuF4Pe1tit7UQTB1ppP0DJKMHcy1lTl7Ok4GIsRb4x6GyYlcmfgJfxCPZig9nr
         T6rgbBNhfKOPk+DZfZL7l8KlXKWgGYCt/by5eQlgtKu4xJhn1GNnzwbxaZt/wYSQVqUI
         t3deHr2WOxiBHcfe+F/RgzA3jJMspyeWm5Chnw4i4G0svGhcfgPDZF33b1XhedV3AKag
         aii/gkR86nqsD5DJQZdkFmxXBFK54ot3weTuSo29powrNFYBCJB7NmSiL2C0Blpqqsya
         HkfQcU2ECRfDrK2o4ZOYEBp27XD8L+GC2RZ6TrNvvRWL4+T820fp34P+6B+7w4oM0MfB
         +Bgw==
X-Gm-Message-State: AOAM53130qha1W+euy6WbV0ix5vdJ6O/JiviGZuTvW0saNTJCgsXBs/+
        O42z1adfNlWvKM8kwHIs82pZwhLhaAIDynn4/Mc=
X-Google-Smtp-Source: ABdhPJyBlUfJhQbpHLhPSVzxrvpeOBL4Et/6PcV52RH+W499+ex+CLfEN99wIZPdw261X+xIejYBzQ==
X-Received: by 2002:a2e:7605:: with SMTP id r5mr3372132ljc.107.1631982943696;
        Sat, 18 Sep 2021 09:35:43 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z6sm808327lfh.25.2021.09.18.09.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 09:35:43 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id p29so45797909lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 09:35:43 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr12275435lft.173.1631982942882;
 Sat, 18 Sep 2021 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <202109151423.43604.linux@zary.sk> <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net> <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net> <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
 <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
 <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net> <20210918090641.GD5106@worktop.programming.kicks-ass.net>
In-Reply-To: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 09:35:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD60LDMeTw1VbEW4=ij5XcNN16cPzONZ7s-KgU-39GYg@mail.gmail.com>
Message-ID: <CAHk-=wgD60LDMeTw1VbEW4=ij5XcNN16cPzONZ7s-KgU-39GYg@mail.gmail.com>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ondrej Zary <linux@zary.sk>, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 2:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> How's this then?

Looks good to me. Thanks,

          Linus
