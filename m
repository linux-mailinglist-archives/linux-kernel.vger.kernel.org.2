Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C164329C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhJRWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:31:19 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B370C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:08 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f3so10955500uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMD63kGqlNMIm2FKXXcH/6opQFRwCGdWT3zmw0bkJrA=;
        b=aKYJXtCHjg2UnpSBovbegHvrjQiiX3aR+c/HFkMZBU2WdysI4FgFgIb+VhXYJYJ/Fk
         iK2oY2LGnIt902esFd+ID+e7zq5LkydVbKsiV4NsYawJaxuGHILadEQxbrVslmZAQjAK
         E2cMzdN7w4+72V9KvpnzfS4jOQdQZLDL/EtYaMUX94zllgePPaTFyNfUCcbFw82PS8tL
         OD/1GlZNj69MvquEwQKhJCmDayJDO0iAiNvrTUvFtdIP71EaESI0iqsw2SLpdb2UUqTW
         oeulcO37ldGjq5//rxfNwSv8k4TZV8QovvZM7JioV9JGWuk9f4unkLNtw/36UY/R3CQQ
         5cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMD63kGqlNMIm2FKXXcH/6opQFRwCGdWT3zmw0bkJrA=;
        b=srgrEASGb9w5guGUj4poTFXMlHMsSdCHQiLsJ25oZCwqvMhidU1ncRd3ccdrUY9Taq
         TB4DrinRlgNcueczAu/y1b1CwrT4gYB6yuNX2nF3Tngf52gQ71UwgpUfl51OpNpzRAYt
         qoLB/NdPQFngVBdi2wVrpxxHe8ZcBcSB4xASgrWqx4vW8mFfXCMvsp5Fx44QDTitmMRK
         8Gb75PuDuYlldo+G+wb+Dk6mHAVxvm97DdXnbHI71wZAGLF0oAfVXxXjhFGHs5yKR7Xl
         nSA70+BcQO2e1+0XuHY/W7/sgqbtp+IP7+RD1n6Vc4Ra0DB0bXWcodi1qs29PPvV1tHZ
         kOZA==
X-Gm-Message-State: AOAM530jSdHb08cPiuoydxY3Lef38aIRjo0yc4UMAyZSvvUMHf4yNcjf
        Njd9Y67QGWLDzGBiMP+7aUr63Mfq/EUlDaKX4vVb6A==
X-Google-Smtp-Source: ABdhPJzo0CfetTCPrXkMaZh15zQ32H+Uc/w23A3wWlFLZgyQ214JKsoGDlpvpzAuhdk/f2lsqyFwk935WRE9e4LzKoc=
X-Received: by 2002:a9f:23d0:: with SMTP id 74mr28388250uao.131.1634596147043;
 Mon, 18 Oct 2021 15:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133> <87fssytizw.fsf_-_@disp2133> <871r4itfjw.fsf_-_@disp2133>
In-Reply-To: <871r4itfjw.fsf_-_@disp2133>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 18 Oct 2021 16:28:56 -0600
Message-ID: <CAOUHufafm96SU8UCxFgU_1y9KrxMxCeX=OZAceeZ0gH7mMRdvQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ucounts: misc fixes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:21 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> While digging into the previous ucount kernel crashes I found some minor
> bugs in the ucount code.  When hit these bugs all result in a ucount
> either being counted in the wrong location or leak of a struct ucounts.
>
> Nothing particularly serious but certainly things that should be fixed.
>
> Eric W. Biederman (3):
>       ucounts: Pair inc_rlimit_ucounts with dec_rlimit_ucoutns in commit_creds
>       ucounts: Proper error handling in set_cred_ucounts
>       ucounts: Move get_ucounts from cred_alloc_blank to key_change_session_keyring
>
>  kernel/cred.c                | 9 ++++-----
>  security/keys/process_keys.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)

Thanks for the fixes. Tested the whole series on the latest 5.15-rc6.

Tested-by: Yu Zhao <yuzhao@google.com>
