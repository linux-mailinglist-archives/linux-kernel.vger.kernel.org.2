Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D992744EE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhKLV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhKLV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:27:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D350C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:24:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f4so42832245edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxOWnpmrxEJOcsIMF7YyE2H5OxmtpPoQ4AkQJgB5Uf4=;
        b=SWHLLWDuIHwPVxjXsEIyf4VxOwte8QOBFZZWGtQ1GC3WxldCHWHz2Mp0jGHYz7osk8
         QgaE+y93cbrjSCGTSilBj8ULM8IcoVBH6PAQO2rVDnzNfCTsct5NfFYG18gOsjbLWgSc
         Nr9IDBZBI4U6Hf2b5EEpUHjPW3SBEUXYF7eAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxOWnpmrxEJOcsIMF7YyE2H5OxmtpPoQ4AkQJgB5Uf4=;
        b=rJld6xA1A41LWnoh9zlKftSe9O5w8l/zcTA984iMwaSzr9PojSaQpAEWe3n+Q4uWOT
         +qcPI6UOHisEOcT1Kz4WvEfGeIsufPxH2U70dnRW0WtxnchLtEuCCtREH3L/DIxWipAc
         VfD/4loxEdwXFpRF6GFYsh164cfDQjDs2zAl86X/DDfSOVrFath87GSU1NzeekzuOMzE
         q6vovsLO4FPGjgNywLlLDM+3nQUpssm5uumhLZtMuCGLeh05yaFSQNK47lKIgpT1i6D+
         O23HrmOa/l7Q9JmnIwxMaE/eDdhNyqGARXJlg/7tzYwOiXgR6JgF5ylD+zUJOZHXNTBw
         Bs2g==
X-Gm-Message-State: AOAM5317lSH0eOZ/UAmkNgnfhGwlL3V3NPXIz810DjlGyZ6TqYtLsC/v
        5EzR+theKD+IV2nJpR3gnhSAMhsZyAZErbR++n0=
X-Google-Smtp-Source: ABdhPJx4x52cyLixJQFPX19t+iCsRCAKPxESGmiTLzWikX01VIbMeWLExTSJoN4OCZ41He46O8KBKw==
X-Received: by 2002:a17:906:6993:: with SMTP id i19mr23733468ejr.136.1636752295059;
        Fri, 12 Nov 2021 13:24:55 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id m25sm1661908edj.80.2021.11.12.13.24.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 13:24:53 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id d3so17780067wrh.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:24:53 -0800 (PST)
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr21948864wrd.105.1636752293250;
 Fri, 12 Nov 2021 13:24:53 -0800 (PST)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-9-ebiederm@xmission.com>
 <874k8htmb2.fsf@email.froward.int.ebiederm.org> <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
 <87ilwxrvu9.fsf@email.froward.int.ebiederm.org> <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
 <87ee7lqe6k.fsf@email.froward.int.ebiederm.org> <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
In-Reply-To: <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 13:24:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU1Nf+zzFgwE5bAGSq2W9DifmKDsAOFuZcaaHq3vEQ8w@mail.gmail.com>
Message-ID: <CAHk-=wjU1Nf+zzFgwE5bAGSq2W9DifmKDsAOFuZcaaHq3vEQ8w@mail.gmail.com>
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an
 actual BUG_ON
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 1:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I could see some quick test hack doing it - the IVT at boot is
> actually not at zero, but at fffxxxxx. 8086 is magic.

.. and it's been too long, and I'm too lazy to check - it may be that
vm86 mode doesn't even do that magic boot-time address thing.

It's not like we really care about vm86 mode any more, since pretty
much nobody users it.

                  Linus
