Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACF371F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhECS2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:28:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:27:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d15so7956732ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUJJM5d1RF9GGuiubhFMHdLaxkaUCrVU7Ef1itvGUYw=;
        b=Iz1Jj88OWNjnZbyzHKPAERMOG0k13rFHVpLrBt2xfZaieVMH7nw+sNWGiRUiduGceu
         Q/A99uUt/MemkwMysX38asDsD2yAdm1hM/Dnd1GK0ZrXXrdQGK3aL4QH99V77Y32/7dq
         WwIp/LoQg2gfPkO2yaHCFrqLkGm5+TFR/oqec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUJJM5d1RF9GGuiubhFMHdLaxkaUCrVU7Ef1itvGUYw=;
        b=XqnfNFqcKWxm01UYYOxsv9qLHvWp1tQ06iTX0g5NP5YlPGSidHwQUXe9IfOb52gUZk
         gnY4Rjiz9a0fD1YcSYjD2gCy1G2gifGcg6r/cID0SCcv690GxF2jcVkjoT1eTdkFJk5i
         kReosWo4/g3yz3hTufcvG/y3Y7tOOhk+OK9DggE7pDYxvGxXc9NCnsezIiRIJG2cUZ66
         sK9pZhaotKqkOV3ygMIxc3hJvDrbfXcqdrKAkmDjCnrwQhfniH2pDUQFnSM8CcbVUNMt
         w8oDlFEsRGpjQCS16sfGun24/ZMfUFmeIys8h9ggIZq0tAgyjUWvKQLIhS45xml4xnv6
         YXXA==
X-Gm-Message-State: AOAM530FVk7eQYuuB/FBJrN17rP4qmSkxYsk2Gb9314i/4AqpcmoY54r
        4xT4OiwkFZTghD3oW3ba8dgrJA9Y2tsLzFyWHPg=
X-Google-Smtp-Source: ABdhPJzvOemTGp/pJjG8ryqXmExYjmee2SFz3vuS2JCcxLaHFJr1jVrYMaAIhSgioq+B2X5VrbTV0Q==
X-Received: by 2002:a2e:8559:: with SMTP id u25mr14542477ljj.460.1620066440299;
        Mon, 03 May 2021 11:27:20 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b10sm34983lfb.183.2021.05.03.11.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 11:27:19 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 124so9498919lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:27:18 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr13574252lfe.41.1620066438744;
 Mon, 03 May 2021 11:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210503091713.1aa7a7b7@gandalf.local.home>
In-Reply-To: <20210503091713.1aa7a7b7@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 11:27:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgo40oeh3huHvb64KfeNEYXw_hQXLXqujbhYz18TMZ6ZA@mail.gmail.com>
Message-ID: <CAHk-=wgo40oeh3huHvb64KfeNEYXw_hQXLXqujbhYz18TMZ6ZA@mail.gmail.com>
Subject: Re: [ GIT PULL] tracing: Updates for 5.13
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Cao jin <jojing64@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 6:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Colin Ian King (1):
>       ftrace: Fix spelling mistake "disabed" -> "disabled"

Well, that spelling fix didn't fix the other misspelled word right next to it.

> This is the first time I'm sending a pull request with a merge
> in it. I'm hoping my scripts did everything correctly. Might want
> to check it a bit more than usual.

The merge looks fine. It causes the diffstat to show incorrectly,
which is normal (and generally avoided by you doing a test merge so
that you get the diffstat from the merged state - but don't send the
merge itself to me, just use it to (a) look at what conflicts there
will be and (b) get that correct diffstat for the end result).

That said, if the only reason for the merge was one single trivial
commit, you could just have cherry-picked it instead, avoiding the
things like "oh, now it has two merge bases so 'diff' no longer has an
unambiguous result" etc.

But this is fine. If you start doing a lot of merges, I may really ask
you to then also do that test-merge for the pull request, but if it's
one of these "once in a blue moon" things then don't worry about it.

              Linus
