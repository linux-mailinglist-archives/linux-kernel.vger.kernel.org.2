Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03263AA4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhFPUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhFPUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:03:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0665FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:01:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l15so1263051lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0sGanNeM+6nVMH7hMipVVh7kfFvtaj9v71nplXpGOQ=;
        b=W2AITzayliTdBtw+P2eGCat6m1fvimytrfbjpYp3F+ZqA7U78mdL6p9s1QlqYnA0Cu
         HmuuCHptbwVi95FtTdSDCMlLPBnLl9I3IjPOnYExv6QFeCUpcrP5yEPGt2AUEAL6rQRa
         AVA3P5mSOxUsuokFD59yB5+vElkaqAzJ+n8vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0sGanNeM+6nVMH7hMipVVh7kfFvtaj9v71nplXpGOQ=;
        b=a1atSRuC0GxBz+tqtCX5jQqOASOizakYBJLPSQQDTzoDeITdSt1Vr2ndSeCisRj7nh
         OuFUo5N/Yf9LLhyeKiw48JFATN7xXV4mzRjBXtV55KS1gFBoO09tUkLKoqhvJoKC9uTe
         +kLTGYaY0+nyWj8TBgGacrplMSFK4yaE0tJfqnAvR+qyTdtSN77Qo0nZAAt2yGWdvkR+
         xITT7sHGGk+vxSrHQy4hCoKQ1IXxkaF4tNyygGFD0cnlBH9DNHYTEMgdcMQRM63QLXC/
         lprgS4TEwNsROLRP1IkhE6xuKxC9Wq4I86f4TP4BLWm+w5uxrTaKYgV61QZtPi8n+JIi
         rdmg==
X-Gm-Message-State: AOAM531ajQRi93e6aJVWUdoD4MtP+slBNf8p6eqT33Kg5qux2YnH86Wx
        G2grHXkAUm9mpN1KzqyVwk3alQC3S46hzkaQ7+w=
X-Google-Smtp-Source: ABdhPJwv63BO8jNlmcqtk7tVY5O80LkWh3HBX1FMP/x8kB9x1nv+cwT2y2FT5YrtRip4Qg+91LD8KA==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr1321739ljh.223.1623873671078;
        Wed, 16 Jun 2021 13:01:11 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z10sm344035lfj.221.2021.06.16.13.01.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 13:01:09 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r198so6224408lff.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:01:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr1037501lfv.41.1623873668703;
 Wed, 16 Jun 2021 13:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133> <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133> <87k0mtek4n.fsf_-_@disp2133>
In-Reply-To: <87k0mtek4n.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jun 2021 13:00:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
Message-ID: <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:32 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Prevent security holes by recording when all of the registers are
> available so generic code changes do not result in security holes
> on alpha.

Please no, not this way. ldl/stc is extremely expensive on some alpha cpus.

I really think thatTIF_ALLREGS_SAVED bit isn't worth it, except
perhaps for debugging.

And even for debugging, I think it would be both easier and cheaper to
just add a magic word to the entry stack instead.

              Linus
