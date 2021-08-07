Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9823E3607
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhHGPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhHGPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:11:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E70C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:11:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so16585740ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9f7ghUXtHQ5rDYMyBLLCh4R9WR+dNTHwc7IlpM9D23o=;
        b=CTVyN5wLrHKEspU84x3YdGLOn+ke577EFIBOHWCXsSM55RpUL1vOVaXARFWvygapcF
         iQWHWrEqhA/UGjUZbxIQ+r88leyykBaN++pA1uhH+uaJXS8MnP8wLaKBYKheFHoNdaAS
         3oIx+CfoYgirxSnqwzjWxDV3yW/5b8fnqYhI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9f7ghUXtHQ5rDYMyBLLCh4R9WR+dNTHwc7IlpM9D23o=;
        b=X1iKlE5R5niDjBWxfrq+avSTkAc6vkol/6jtSrY0b6nuaoL49TDe7RnJvHmIba8rCi
         gLWbMTPzAEqI5qeXPeIcFz6Eo5ZHZ60DNKMZHMbH6GlQ3FxichaLQvB8A20Ck1MAGxyg
         4OMdWSA1ZOY+8vPuBaqYJJR8vPNcff+Eh7/OPSiIFYFaPRaB4R2NXO+vUBML7/XTRo69
         wd6YeucngnSx1NAy2fmcdiQVUFay79BlUH7XHjxS98Ft04zYQn0OLyKA55LDwH7buHz+
         wy0vRbMH5ArucN7B2sRpYhueUNqXPyjevftYxitW/9vUlS1mUoBWSfqfxznGyZuyUpNh
         PW5w==
X-Gm-Message-State: AOAM531MeKFCibULZmffl3odILBLKryxDMs6oYAx2JPAOFi9up0bg+oa
        XIFQQfKCbiA8lcdKye02mP4K5oVk/nqahTDr
X-Google-Smtp-Source: ABdhPJzQtmUVS52mEYepdAdPacXBOFX07PIBjDeYLlo6T34wcR51JIaI4H/mKnwk6/tXr18iAnN4+A==
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr6009924ljl.278.1628349070221;
        Sat, 07 Aug 2021 08:11:10 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t21sm737375lfg.74.2021.08.07.08.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 08:11:09 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g30so20073429lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 08:11:09 -0700 (PDT)
X-Received: by 2002:ac2:4885:: with SMTP id x5mr10932945lfc.487.1628349069409;
 Sat, 07 Aug 2021 08:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
 <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
 <20210807050314.1807-1-hdanton@sina.com> <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
 <20210807091128.1862-1-hdanton@sina.com>
In-Reply-To: <20210807091128.1862-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Aug 2021 08:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+z6ePDWhCX-EfypR-9VyHf8j_cQyOETOHtSzC6LPNAQ@mail.gmail.com>
Message-ID: <CAHk-=wh+z6ePDWhCX-EfypR-9VyHf8j_cQyOETOHtSzC6LPNAQ@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 2:11 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
>         CPU0                    CPU1    CPU2
>         ----                    ----    ----
>         given count == 2
>                                         put uc
>                                 put uc
>         get uc
>         UAF

No.

The thread on CPU0 must have had a reference to the ucount.

So if CPU1 and CPU2 are doing a put at the same time (and they held a
ref to it too), then the starting count must have been at least 3.

In other words, the above would be a bug - and not because of the UAF,
but because somebody had screwed up their reference counts.

You might as well had said "given count = 2, do 99x put_ucounts() ->
UAF". True, but immaterial from the standpoint of "put_ucounts()"
correctness.

Get it? You can't do a "get_ucounts()" on something that you don't
already have a reference to (and similarly, you obviously cannot do a
"put_ucounts()" on something you don't hold a reference to).

You *can* do a "find_ucount()" to find a ucount that you don't yet
have a reference to, but that's why you have to hold the lock (and why
anybody who does that has to increment the reference to it after
finding it before they drop the lock).

           Linus
