Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723FA36A868
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhDYQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:38:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB15C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:37:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 4so24782424lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAvPlNogEVXWDSOoGh+iiQN8Cag/kg0giuiiQpODl9U=;
        b=aD+B0qtsE7lpdWo3g6USTTDUtMKhtSnKUaKuXTxExwR9hV+yKPhqs/IUmTKfcDePGV
         UGy22jBtKXtlFcuY0WHOzpy9ZW2hMSCdS3MpbxCZiyXu4twj/09dDIvpkfTX9fxZCacO
         pXurjncRSgSlmvYf6yu1P8i7NU625W+kLm6nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAvPlNogEVXWDSOoGh+iiQN8Cag/kg0giuiiQpODl9U=;
        b=FbnP8ArrygXwPD9o6xddi2IWjc6wBjK5r6syI1GJDq5wjfPE57Ivoa6hp618pT+4ux
         qwWtpN78OuC/k6zxADXrBaDlAzEQZadpGcHFqO++0N3NqQZ3LCFBvwUYp3umEmTwNaiB
         BSJeu62XjMQK7aN9tVo5sPtHejcJuWzgi+GuYuGxBNobo2gkH5K7JQcJpJZUyCoJGg3h
         KmoakemVCe+80e9Ikzf7KvPfzhVdrhnSqdjfrlJxZZiNS0JiulgwSePM7HM//EcOMMJO
         BKKg6rKZL7a6X2r7CMpidt7A7eNbR7xiOYmUXEakErgKJLn7M1Yz9xrSFPuyp5U7HimR
         vOXQ==
X-Gm-Message-State: AOAM5329duFThtegYfgvKFwe7KYNUvm1HW8saQ0Z1H1XXnH+bNgRi978
        gWSP2zR5GIZXF7XDT5RR45wUZ/6XR8qIAkes
X-Google-Smtp-Source: ABdhPJzHoxjOJQbOgxyyVlAwC4izzv9SCrCFf5RgIWx5nRSt/niAik/NlwGvxyabMOfXnSk9JVHrag==
X-Received: by 2002:ac2:559c:: with SMTP id v28mr10220008lfg.290.1619368657026;
        Sun, 25 Apr 2021 09:37:37 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e8sm1146192lfc.192.2021.04.25.09.37.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 09:37:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a13so7414404ljp.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:37:36 -0700 (PDT)
X-Received: by 2002:a2e:330f:: with SMTP id d15mr9825041ljc.251.1619368656485;
 Sun, 25 Apr 2021 09:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <YIU4005K55S20FU1@zn.tnic>
In-Reply-To: <YIU4005K55S20FU1@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Apr 2021 09:37:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
Message-ID: <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
Subject: Re: [GIT PULL] locking/urgent for v5.12
To:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ali Saidi <alisaidi@amazon.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Side note: this is cc'd to x86-ml, even though x86 is the _one_
architecture that was guaranteed to be not at all affected by the
actual locking bug, since a locked op is always ordered on x86. ]

On Sun, Apr 25, 2021 at 2:39 AM Borislav Petkov <bp@suse.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12
>
> - Fix ordering in the queued writer lock's slowpath.

So I'm looking at that change, because the code is confusing.

Why did it add that "cnts" variable? We know it must have the value
_QW_WAITING, since that's what the atomic_cond_read_relaxed() waits
for.

I'm assuming it's because of the switch to try_cmpxchg by PeterZ?

HOWEVER.

That actually just makes the code even MORE unreadable.

That code was odd and hard to read even before, but now it's
positively confusing.

New confusion:
 - Why is the truly non-critical cmpxchg using "try_cmpxhg()", when
the _first_ cmpxchg - above the loop - is not?

Pre-existing confusion:
 - Why is the code using "atomic_add()" to set a bit?

Yeah, yeah, neither of these are *bugs*, but Christ is that code hard
to read. The "use add to set a bit" is valid because of the spinlock
serialization (ie only one add can ever happen), and the
cmpxchg-vs-try_cmpxchg confusion isn't buggy, it's just really really
confusing that that same function is using two different - but
equivalent - cmpxchg things on the same variable literally a couple of
lines apart.

I've pulled this, but can we please

 - make *both* of the cmpxchg's use "try_cmpxchg()" (and thus that
"cnts" variable)?

 - add a comment about _why_ it's doing "atomic_add()" instead of the
much more logical "atomic_or()", and about how the spinlock serializes
it

I'm assuming the "atomic_add()" is simply because many more
architectures have that as an actual intrinsic atomic. I understand.
But it's really really not obvious from the code.

                Linus
