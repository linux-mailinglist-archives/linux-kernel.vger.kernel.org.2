Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9C36891F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 00:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbhDVWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDVWov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 18:44:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:44:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h36so20464961lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eVWWvugI8DB7tGc32EIZh1dbZnwGe5Bt+f006OvhJS0=;
        b=J+EDgb6lx4Ai3flNJZAUBsqJDvUXLA67oGcIqHVqt7rpFgBUDYNJsQZ4o3h5AaNI3U
         GBJgJVmfbnA5xfbL/uUHu/bVkU6Sj4caOjrq2RimVAS1IpWEHeNACHQ6BydOG9JyMNnn
         rEw+vXuijPm+PTk0G/Ng9czw8gxh5Tyj32N1PN4cZPV1UTvXaDAZCqY5QOba6u74G4Ue
         kEye3LPZtcdetcvoVY7Z07WlPTfZbdwmphfwX1vLe97GhJClaq9upYRf86HqJLT97uvh
         RwbYzzRqbTBsKr0m+Vf2+aiNwKCTDeKAJrOKYp1I+CAPPQ477hnmGf9mlfzm9JUHeXu2
         Tuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eVWWvugI8DB7tGc32EIZh1dbZnwGe5Bt+f006OvhJS0=;
        b=fLhM/XshoJost7d7Dp7dWqyU0bdnktPxxqMX6lHG1pxWYPsPxCkewSmZvtkxwwKpm8
         4OXpYYXKLUInWDAfiGAIcxNqZJaFzhRDM/lvXjySIt8RJzrR4BJwXO6pB4uFPvznePu1
         4oIEeajPrr00txCYUWv2RCSWeC7zjfmSa/F9GJf78912Ir6iUZushT5kmoluyWnyz2f/
         DwXFJ0ML2PpEIB5dMhhz/AirNXy8BqXUnqHE3PoEKYrldrb07B46pPp+Gr5VdjyapSCW
         0XD+S7kGaaumnFCvivdqjr3RFkZWNlfgicy1JvqepcG1LgyFeT4Q/quYi5KtVy+ttaMH
         q3Gw==
X-Gm-Message-State: AOAM5310WSUrSTrTC5dO+rxLXtcIpNTxWBXb3WBJEq5oFjbAH75T7gzI
        fi9aBazPbwaZDYu6Ix06dV9jDBKqSa73jNRx96omtg==
X-Google-Smtp-Source: ABdhPJwYSO43FuRfyDZjVX5z5UG55Qn0AtKaW1+5Fl21nVwrVVRCd3KaER5zMUSJFG13eTZoMQSkycXBXphkTb373o8=
X-Received: by 2002:a05:6512:159:: with SMTP id m25mr454486lfo.73.1619131454440;
 Thu, 22 Apr 2021 15:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-2-ndesaulniers@google.com> <87blio1ilu.fsf@mpe.ellerman.id.au>
 <CAKwvOd=ZeJU+vLUk2P7FpX35haj7AC50B9Yps4pyoGCpd7ueTw@mail.gmail.com> <3d837a36-a186-6789-7924-eaa97f056b68@csgroup.eu>
In-Reply-To: <3d837a36-a186-6789-7924-eaa97f056b68@csgroup.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Apr 2021 15:44:02 -0700
Message-ID: <CAKwvOd=KP5CZ5wOrczC6qPAzN7DdFCJ_XvU6e=zvB3XpQrp_-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 11:02 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 02/09/2020 =C3=A0 19:41, Nick Desaulniers a =C3=A9crit :
> > On Wed, Sep 2, 2020 at 5:14 AM Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
> >>
> >> Nick Desaulniers <ndesaulniers@google.com> writes:
> >>> Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for o=
rphan sections")
> >>
> >> I think I'll just revert that for v5.9 ?
> >
> > SGTM; you'll probably still want these changes with some modifications
> > at some point; vdso32 did have at least one orphaned section, and will
> > be important for hermetic builds.  Seeing crashes in supported
> > versions of the tools ties our hands at the moment.
> >
>
> Keeping the tool problem aside with binutils 2.26, do you have a way to
> really link an elf32ppc object when  building vdso32 for PPC64 ?

Sorry, I'm doing a bug scrub and found
https://github.com/ClangBuiltLinux/linux/issues/774 still open (and my
reply to this thread still in Drafts; never sent). With my patches
rebased:
$ file arch/powerpc/kernel/vdso32/vdso32.so
arch/powerpc/kernel/vdso32/vdso32.so: ELF 32-bit MSB shared object,
PowerPC or cisco 4500, version 1 (SYSV), dynamically linked, stripped

Are you still using 2.26?

I'm not able to repro Nathan's reported issue from
https://lore.kernel.org/lkml/20200902052123.GA2687902@ubuntu-n2-xlarge-x86/=
,
so I'm curious if I should resend the rebased patches as v2?

--
Thanks,
~Nick Desaulniers
