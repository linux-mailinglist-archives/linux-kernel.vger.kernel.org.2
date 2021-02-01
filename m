Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92930AD46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhBAQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhBAQ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:59:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35F5C64EC0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612198722;
        bh=mwlzY4YmzjklRz2/xfModrOKlPhbTJUiNVyzf9f0nK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KBGdGR+K+fpQecTd6AxdzmAuvUKuEwcaR5X7SY8mBWPJqHWGPjhmKKMD8b2ULxiDw
         rkod9P3UrKte1jp6xkSsElRwCeQjCIP86G99SDFP16Elo/KqRT8Y+rLkZp+yvnWiGo
         BIS4a/OgRIEVwdTmnNM59J/+JZKIG13JockqUek/apDgsndfvjpKUpwX1shjpMxQZR
         pAwRSwQ3L5kyd+5SRqQz/BUkFMpY1GR0E4FgDyp4wRoSZJbBr9FM68hm1u+i0PdSnE
         nv4ijv9Txw7uxO4mOQFRtUOzfn455D6ATGmLNM1aFbyIyI3R2eGfDK/Q/gXDTkdtjK
         dYcoIOdevIRAw==
Received: by mail-ed1-f47.google.com with SMTP id s5so6805669edw.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:58:42 -0800 (PST)
X-Gm-Message-State: AOAM5327RKfyQtnanl+9fZyFEr/sqp2FJT47SjTiUSxoJ2EU8+nnpvNU
        0h2tFMO2ODcI0IbJxZmP/CmJGNZgO6lnvS9memOL2A==
X-Google-Smtp-Source: ABdhPJzWiavi4aB2MQ9WAMQG5XeDZ7L3UUhx01HM5KiOsDwtUPUmzieJTwcTy8UjPBv6co+DxMN6nExVf2muSFo4jgU=
X-Received: by 2002:a05:6402:b30:: with SMTP id bo16mr20278246edb.84.1612198720520;
 Mon, 01 Feb 2021 08:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
In-Reply-To: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 08:58:27 -0800
X-Gmail-Original-Message-ID: <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
Message-ID: <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        naoya.horiguchi@nec.com, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, YANGFENG1@kingsoft.com,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:17 AM Aili Yao <yaoaili@kingsoft.com> wrote:
>
> When one page is already hwpoisoned by AO action, process may not be
> killed, the process mapping this page may make a syscall include this
> page and result to trigger a VM_FAULT_HWPOISON fault, if it's in kernel
> mode it may be fixed by fixup_exception. Current code will just return
> error code to user process.
>
> This is not sufficient, we should send a SIGBUS to the process and log
> the info to console, as we can't trust the process will handle the error
> correctly.

Does this happen when one process gets SIGBUSed due to memory failure
and another process independently hits the poisoned memory?  I'm not
entirely convinced that this is a problem.

In any case, this patch needs rebasing on top of my big fault series
-- as it stands, it's way too difficult to keep track of which paths
even call your new code..  And the various signal paths need to be
consolidated -- we already have three of them, and the last thing we
need is a fourth.
