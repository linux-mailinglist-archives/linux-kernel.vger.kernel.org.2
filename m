Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB3386CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbhEQWdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbhEQWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:33:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:31:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so11069360lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGw1wUzHGygdPQiaQ+eAoRqhEvUaiTqtJWO/+qT7Sec=;
        b=BsKOnZSskjk3+kihrvXS6DVXY5L/+N52zGT9+xiTUxQxTkAIKdsxQLyk1O7ORMVhUR
         mXoxSePwmtbrgsbhAU0zLqL45GrRsCHLjjZQ7tGsvZ2BaFd72dIQ1Hw5p73GwX8gGtur
         1ZD92hodIXcVN7RvDQo4Glh8y2YWuP2LU2fNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGw1wUzHGygdPQiaQ+eAoRqhEvUaiTqtJWO/+qT7Sec=;
        b=BrcLABmW4RYFWS8e2mV2baAbzb84dRD9u082SnaVbVAcewIf/Nl+kSNVsNQDSuKgU0
         V5g5ecQUTaT5wsAOadS1nJ4aAWBcLYeYpCy3v2ZxyqyOIuAIQUMZY/+/56rEicUsC8Xl
         Z/GujZ/goyayb/YF3SDYKcKqRQaAUSXRHYTN4wLiHhZq+cU7PkpZwcoOfRRNqdvi1nIg
         aMobeOhNMZ1pij/9nBkIUHEW7pYih4b2UT6kIxF9QR/+OPp2qNSrWMSL5mIovXUs85lv
         l+FwPLTUXUs+0OoNVsKshwNso9SP9Lb4kFtsW3NEy5qf6d/AHkPwQuFOlPqSFt6KiDjo
         ghUA==
X-Gm-Message-State: AOAM530u0gxUBmUm5biKhA+9PnsThrvov0c3eSVc3F3c05C7lEDf1PXZ
        GI0+QJDKpEH7f6xJ0IIv+9h9qBRp/NNumobR
X-Google-Smtp-Source: ABdhPJwPbOfBVK6qGrwI2C59SWxGZf3IPuKKZyUHdgOqdchEQVJb9FU8myory6qIQzYUGrzvdBCw5Q==
X-Received: by 2002:ac2:4186:: with SMTP id z6mr1463549lfh.16.1621290708275;
        Mon, 17 May 2021 15:31:48 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w27sm1684235lfl.195.2021.05.17.15.31.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:31:47 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m11so11105703lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:31:47 -0700 (PDT)
X-Received: by 2002:a19:ca15:: with SMTP id a21mr1421228lfg.487.1621290707592;
 Mon, 17 May 2021 15:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
 <20210517135653.GA2116459@roeck-us.net>
In-Reply-To: <20210517135653.GA2116459@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 15:31:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUsAw7g6x4ianP1VxsADr1b+fitmQ2qecrq70d9r3ZJQ@mail.gmail.com>
Message-ID: <CAHk-=whUsAw7g6x4ianP1VxsADr1b+fitmQ2qecrq70d9r3ZJQ@mail.gmail.com>
Subject: Re: Linux 5.13-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 6:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> I have seen a pull request that fixes the raspi2 problem. Hopefully that
> fix should be in -rc3.

Hmm. That commit actually made it into rc2. We're talking about that
commit bb4031b8af80 ("clk: Skip clk provider registration when np is
NULL"), aren't we?

That's the patch that you reported fixed it for you.

And it got merged by me (commit 28183dbf54ed: "Merge tag
'driver-core-5.13-rc2' .."), and is part of rc2.

So if rc2 still has some raspi2 failures, there's something else going on..

Strange. Mind double-checking?

                Linus
