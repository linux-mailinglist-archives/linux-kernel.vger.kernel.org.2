Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8A400818
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbhICXMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbhICXMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:12:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2CEC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 16:11:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so1305912lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VyHnrpdaAGfTsMG4jSt8uLXr2vuUSFvqiMs6Z7blZ8=;
        b=K8O0JbyTuDEIYjIpdBNAFYJ1TzrbIUD0u7HfVjPfyHcW3tbAELblkOb4WQmzk9pKrH
         GWUo2VkIdrw3RVMZXvKYNuZcY9T8R8L8n6KqwN8wQBGIiTFUtpZ0BsnsYybjJ1tpErHg
         VylHHfaIk4Q88U1RlysxjeBFWfgUHs3oHbCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VyHnrpdaAGfTsMG4jSt8uLXr2vuUSFvqiMs6Z7blZ8=;
        b=rJLA3zP5MDI3jXz3xPh8HXUoK0iLIdIbmyKkYuYVDlmRhM4PsEC3I8molhp5nJIDfD
         XsNnnz5JwUEuKmj0n1tMULJN+/QC8rF1EJQR6Jp5Ubvtj/7MWlTUQHb5lKZXoGK/NqoA
         ast+qqfkQh13ybnbf0dIT3ItnHE8RZf3Fp86JTYoZs5PX7IKcEwpxYplOM+cUbJt3E/D
         LumZjnv/8GlnscJCmi5u30hkhgmkEuZzQVeBgUxF16TwCGISP5dIH7N31y4gGM12+pZO
         9Z9SQ9Pw/bbKqdiB0h2tknzOG9xqnpRzt+roIj58ohivmDj9iycHoGS7ZM+SEJROvuAO
         1pLw==
X-Gm-Message-State: AOAM533kVmg6KR9Of9Wq+n07Qe/LLvb3MjbysvDLwNZU7/bVD7c4nJ9r
        cCRQeS+yHJkZXEK5tm3nixVlR3T/A2oisS2FYng=
X-Google-Smtp-Source: ABdhPJzzctAJwFJeqOUWnNchlt+yfkRDyrD85B439vFsLVQmWPM6RAwQCZH5XjAG9tvSMgNoDSKHMQ==
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr908769lfg.199.1630710695219;
        Fri, 03 Sep 2021 16:11:35 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 10sm74672lft.233.2021.09.03.16.11.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 16:11:34 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x27so1305822lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:11:34 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr919994lfv.655.1630710694461;
 Fri, 03 Sep 2021 16:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
 <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
 <CANn89iJ5Q-PeZ=+87DT-BY4EVhWZATtieid59W7Tq0bkCvRQbw@mail.gmail.com> <CAHk-=wiwydQEhbZCkUhwbDZp_CdMJrOtRwTThA5bT5C7b+grnA@mail.gmail.com>
In-Reply-To: <CAHk-=wiwydQEhbZCkUhwbDZp_CdMJrOtRwTThA5bT5C7b+grnA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 16:11:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjevysNdRU18Fs--ZciCd+DTDMFWptZcFBqbBa3Zco38w@mail.gmail.com>
Message-ID: <CAHk-=wjevysNdRU18Fs--ZciCd+DTDMFWptZcFBqbBa3Zco38w@mail.gmail.com>
Subject: Re: dozens of sysbot reports
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 4:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It had just added __GFP_NOWARN to hide the fact that it did crazy
> allocations and just wanted the craziest ones to fail silently.

.. and yes, we can make __GFP_NOWARN limit that WARN_ON_ONCE() too,
but the whole point of this really was to actually find people who
simply didn't check their arguments. So I'd rather add a few sanity
checks, than say "__GFP_NOWARN silences the sanity check too".

              Linus
