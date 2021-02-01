Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A605F30B29B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhBAWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBAWKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:10:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D15D64ED5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612217396;
        bh=F3ILgxSnxoQwmzY/e5titQNYP/LJL5qbaStk24eScGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FTavinDOrtTLd2T2FAjBUDF0PyUmCqc8SNI42zu4P58CiiBXCRXZHbli+T0i5UDoh
         3+lCCCQ6GTLKujkqNOPGmP2XvViELfxBRGj14TI+QHXGhz/KHzvcOjTp+JL8E/NEir
         A8A7kejwkd5oDB1+ozQvTn3JZqNowQ2WC5Dfy7gKeEbozPOUbHuuxmy++j2YVmyrSD
         QPjlh2PRxY/GYcoho1Gq2m6MN1XZkxhopa7ENAQms13JK7cKff5mx6NIJSoJuVoUJD
         bFyyfnwz5J6JA2qNLV93nsmjtX7jgxgtpm82D3rWmOrTLty7pqd0+IRmM7yTAuj65h
         AyRYbDk1bElyw==
Received: by mail-ej1-f44.google.com with SMTP id l9so26836636ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:09:56 -0800 (PST)
X-Gm-Message-State: AOAM5327uQGINVqTU8He/oo+G55srkRN/dGaJ/h3SVnmn0JeYHnVCV5r
        wvtZqmQRm6DR8lf88Ie/ncyqykm3yd2k/h99nwC4Fw==
X-Google-Smtp-Source: ABdhPJxonS6inAy3MtpJuPQVR7WX4ZKuGEHMihl3ndH4s17Qh/A3AcWxEvoLKLzjfUKOpRULLLldM2TXawfTk91S5l4=
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr20049751ejy.199.1612217395055;
 Mon, 01 Feb 2021 14:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com> <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
 <2908aa061ff1494387a53128c6eadb61@intel.com>
In-Reply-To: <2908aa061ff1494387a53128c6eadb61@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 14:09:43 -0800
X-Gmail-Original-Message-ID: <CALCETrXdn8Oqk9yQUcr7cg5Oknzd+3sZxgm2CXvzGMb9uETJOg@mail.gmail.com>
Message-ID: <CALCETrXdn8Oqk9yQUcr7cg5Oknzd+3sZxgm2CXvzGMb9uETJOg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Aili Yao <yaoaili@kingsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:10 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > In any case, this patch needs rebasing on top of my big fault series
>
> Is that series in some GIT tree? Or can you give a lore.kernel.org link?

https://lore.kernel.org/lkml/cover.1612113550.git.luto@kernel.org/T/#t

>
> Thanks
>
> -Tony
