Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A7350717
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhCaTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhCaTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:02:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C216DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:02:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so30566952lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+VaQoy9nNIAoWhp78xbuEiZirssLKL+15uXIJ5gRdQ=;
        b=S1BJ+dNRSdNsgQfwQbuOfmegd+KLeQT7nl+NUCAQ5roNM82bxXDXm77u1F2uUEoSY+
         uX32LEzVrX6MSWvaY5vNz+6rQJfyyWVg0KME7LUMsK3JYVoJD4IaMo2pOTQabda1zIiM
         DWwAk2DLJKH2SwckLZF0e/h3M1p6a3H7e59E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+VaQoy9nNIAoWhp78xbuEiZirssLKL+15uXIJ5gRdQ=;
        b=hH6qzRh82KET83CNaVjNWyEBvDoDU5t559rEQ7HS8qCeFYDDxzn/t//avomIXQ9m8q
         FM2wdtK98HweaxX5wnbwvfOPtZJYnnlfo+uzYN512n3BPkndLo6EexZVESTsEudGldEb
         UJ5BeiGTj7UEfH/hAyMFoSRgSW1/M3mHgBEsF7qTVMW2sck4K+xb7A+jvxN3VUyNcNq2
         KDhPKqfTZfeOJNa8OBDG3ao+BkJi6uCAZ8BCNSWBnr4njIIGl2Wp7Gfx/ydP65sg36kN
         f3O+4J3mqm1F4mE/QbwQM/9CbI2XDuY4qp7QXyu9HjorgPZhY1T4b85hI9JUbEbhVAVc
         KD7g==
X-Gm-Message-State: AOAM5303hqPboHl2fQeWswbyl+h4rPYAlpRoIo4uRumZHW4GB2/29HJy
        8V6ixy+nRLDjCeCXcfcSSki7qEwSEoNooA==
X-Google-Smtp-Source: ABdhPJy6ZY0+2ePqLe1xQliQ012yc1tJTr1Ak9dyl3wbEgHBDln9p4XVax13IC8NpaamlNy+OIpjiQ==
X-Received: by 2002:a05:6512:ba0:: with SMTP id b32mr3084243lfv.127.1617217329994;
        Wed, 31 Mar 2021 12:02:09 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o24sm308096lfg.64.2021.03.31.12.02.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 12:02:09 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id o126so30713211lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:02:08 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr2948842lfv.421.1617217328537;
 Wed, 31 Mar 2021 12:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210331092711.2b23fcff@gandalf.local.home> <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
 <20210331145145.0e3579fa@gandalf.local.home>
In-Reply-To: <20210331145145.0e3579fa@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Mar 2021 12:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWB+VQJACE6nKLdEbwrart1WvcuzQkmBncsp0kmUT2EQ@mail.gmail.com>
Message-ID: <CAHk-=wgWB+VQJACE6nKLdEbwrart1WvcuzQkmBncsp0kmUT2EQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling free_pages()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:51 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Your fls() trick might work too (have to gawk at it more). And I should fix
> the comments. But any work on that would be for the next merge window, and
> doesn't affect that this patch fixes a possible issue.

See my second email. It doesn't even fix the actual issues.

           Linus
